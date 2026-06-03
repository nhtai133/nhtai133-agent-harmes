//+------------------------------------------------------------------+
//| TNPA Telegram Alert EA                                           |
//| Alert-only MT5 Expert Advisor for EMA 34/89 crossover alerts.    |
//|                                                                  |
//| Safety boundary: this EA does not place, modify, or close trades. |
//+------------------------------------------------------------------+
#property strict
#property version   "1.02"
#property description "TNPA alert-only EA. Sends Telegram and/or popup alerts on EMA 34/89 closed-candle crossovers."

input string          Symbols             = "XAUUSD,EURUSD,BTCUSD";
input ENUM_TIMEFRAMES SignalTimeframe     = PERIOD_H1;
input int             FastEMA             = 34;
input int             SlowEMA             = 89;
input string          TelegramBotToken    = "";
input string          TelegramChatID      = "";
input bool            EnableTelegramAlert = true;
input bool            EnablePopupAlert    = true;
input bool            EnablePrintLog      = true;
input bool            SendStartupTestMessage = true;

const int TIMER_SECONDS = 30;
const int TELEGRAM_TIMEOUT_MS = 5000;
const string EA_NAME = "TNPA Telegram Alert EA";
const string EA_VERSION = "v0.2";

struct PendingAlert
{
   bool     active;
   bool     retried;
   datetime barTime;
   string   direction;
   string   message;
};

struct SymbolState
{
   string       symbol;
   bool         valid;
   int          fastHandle;
   int          slowHandle;
   datetime     initializedBarTime;
   datetime     lastEvaluatedBarTime;
   datetime     lastSuccessfulAlertBarTime;
   PendingAlert pending;
};

SymbolState g_states[];

//+------------------------------------------------------------------+
//| Logging helper.                                                   |
//+------------------------------------------------------------------+
void LogMessage(const string message)
{
   if(EnablePrintLog)
      Print(EA_NAME + ": " + message);
}

//+------------------------------------------------------------------+
//| Forced warning for unsafe or silent configurations.               |
//+------------------------------------------------------------------+
void WarnMessage(const string message)
{
   Print(EA_NAME + ": " + message);
}

//+------------------------------------------------------------------+
//| At least one output must be enabled before delivery is successful.|
//+------------------------------------------------------------------+
bool HasAnyAlertChannelEnabled()
{
   return EnableTelegramAlert || EnablePopupAlert || EnablePrintLog;
}

//+------------------------------------------------------------------+
//| Basic whitespace trimming for parsed symbol names.                |
//+------------------------------------------------------------------+
string TrimText(string value)
{
   int start = 0;
   int end = StringLen(value) - 1;

   while(start <= end)
   {
      ushort ch = StringGetCharacter(value, start);
      if(ch != ' ' && ch != '\t' && ch != '\r' && ch != '\n')
         break;
      start++;
   }

   while(end >= start)
   {
      ushort ch = StringGetCharacter(value, end);
      if(ch != ' ' && ch != '\t' && ch != '\r' && ch != '\n')
         break;
      end--;
   }

   if(end < start)
      return "";

   return StringSubstr(value, start, end - start + 1);
}

//+------------------------------------------------------------------+
//| Timeframe label for alert text.                                   |
//+------------------------------------------------------------------+
string TimeframeToText(const ENUM_TIMEFRAMES timeframe)
{
   switch(timeframe)
   {
      case PERIOD_M1:  return "M1";
      case PERIOD_M5:  return "M5";
      case PERIOD_M15: return "M15";
      case PERIOD_M30: return "M30";
      case PERIOD_H1:  return "H1";
      case PERIOD_H4:  return "H4";
      case PERIOD_D1:  return "D1";
      case PERIOD_W1:  return "W1";
      case PERIOD_MN1: return "MN1";
      default:         return EnumToString(timeframe);
   }
}

//+------------------------------------------------------------------+
//| Human-readable account mode for startup connection test.          |
//+------------------------------------------------------------------+
string AccountModeToText()
{
   long mode = AccountInfoInteger(ACCOUNT_TRADE_MODE);

   if(mode == ACCOUNT_TRADE_MODE_DEMO)
      return "Demo";
   if(mode == ACCOUNT_TRADE_MODE_REAL)
      return "Live";
   if(mode == ACCOUNT_TRADE_MODE_CONTEST)
      return "Contest";

   return "Unknown";
}

//+------------------------------------------------------------------+
//| URL-encode text for Telegram GET requests.                        |
//+------------------------------------------------------------------+
string UrlEncode(const string text)
{
   string encoded = "";
   uchar bytes[];
   int count = StringToCharArray(text, bytes, 0, WHOLE_ARRAY, CP_UTF8);

   for(int i = 0; i < count - 1; i++)
   {
      uchar c = bytes[i];

      if((c >= 'A' && c <= 'Z') ||
         (c >= 'a' && c <= 'z') ||
         (c >= '0' && c <= '9') ||
         c == '-' || c == '_' || c == '.' || c == '~')
      {
         encoded += CharToString(c);
      }
      else if(c == ' ')
      {
         encoded += "%20";
      }
      else
      {
         encoded += StringFormat("%%%02X", c);
      }
   }

   return encoded;
}

//+------------------------------------------------------------------+
//| Check that a symbol has enough history for EMA crossover logic.   |
//+------------------------------------------------------------------+
bool HasEnoughHistory(const string symbol)
{
   int requiredBars = MathMax(FastEMA, SlowEMA) + 3;
   int bars = Bars(symbol, SignalTimeframe);

   if(bars < requiredBars)
   {
      LogMessage(StringFormat("%s skipped: insufficient history. Bars=%d Required=%d", symbol, bars, requiredBars));
      return false;
   }

   return true;
}

//+------------------------------------------------------------------+
//| Initialize one symbol state.                                      |
//+------------------------------------------------------------------+
bool InitializeSymbolState(SymbolState &state, const string symbol)
{
   state.symbol = symbol;
   state.valid = false;
   state.fastHandle = INVALID_HANDLE;
   state.slowHandle = INVALID_HANDLE;
   state.initializedBarTime = 0;
   state.lastEvaluatedBarTime = 0;
   state.lastSuccessfulAlertBarTime = 0;
   state.pending.active = false;
   state.pending.retried = false;
   state.pending.barTime = 0;
   state.pending.direction = "";
   state.pending.message = "";

   if(symbol == "")
      return false;

   if(!SymbolSelect(symbol, true))
   {
      LogMessage(symbol + " skipped: symbol is unavailable or could not be selected.");
      return false;
   }

   if(!HasEnoughHistory(symbol))
      return false;

   state.fastHandle = iMA(symbol, SignalTimeframe, FastEMA, 0, MODE_EMA, PRICE_CLOSE);
   if(state.fastHandle == INVALID_HANDLE)
   {
      LogMessage(symbol + " skipped: invalid FastEMA indicator handle.");
      return false;
   }

   state.slowHandle = iMA(symbol, SignalTimeframe, SlowEMA, 0, MODE_EMA, PRICE_CLOSE);
   if(state.slowHandle == INVALID_HANDLE)
   {
      LogMessage(symbol + " skipped: invalid SlowEMA indicator handle.");
      IndicatorRelease(state.fastHandle);
      state.fastHandle = INVALID_HANDLE;
      return false;
   }

   datetime latestClosedBarTime = iTime(symbol, SignalTimeframe, 1);
   if(latestClosedBarTime <= 0)
   {
      LogMessage(symbol + " skipped: latest closed candle time is unavailable.");
      IndicatorRelease(state.fastHandle);
      IndicatorRelease(state.slowHandle);
      state.fastHandle = INVALID_HANDLE;
      state.slowHandle = INVALID_HANDLE;
      return false;
   }

   // Startup safety: do not backfill historical alerts. Monitoring starts
   // from the next newly closed candle after initialization.
   state.initializedBarTime = latestClosedBarTime;
   state.lastEvaluatedBarTime = latestClosedBarTime;
   state.valid = true;

   LogMessage(StringFormat("%s initialized on %s. Historical alerts suppressed through %s.",
                           symbol,
                           TimeframeToText(SignalTimeframe),
                           TimeToString(latestClosedBarTime, TIME_DATE | TIME_MINUTES)));
   return true;
}

//+------------------------------------------------------------------+
//| Parse and initialize all configured symbols.                      |
//+------------------------------------------------------------------+
void InitializeSymbols()
{
   string parsed[];
   int total = StringSplit(Symbols, ',', parsed);
   ArrayResize(g_states, 0);

   for(int i = 0; i < total; i++)
   {
      string symbol = TrimText(parsed[i]);
      if(symbol == "")
         continue;

      int next = ArraySize(g_states);
      ArrayResize(g_states, next + 1);

      if(!InitializeSymbolState(g_states[next], symbol))
      {
         // Keep invalid states out of the active scan list.
         ArrayResize(g_states, next);
      }
   }

   if(ArraySize(g_states) == 0)
      LogMessage("No valid symbols initialized. EA will remain safe and idle.");
}

//+------------------------------------------------------------------+
//| Build Telegram and popup message text.                            |
//+------------------------------------------------------------------+
string BuildAlertMessage(const string symbol,
                         const string direction,
                         const datetime barTime,
                         const double fastValue,
                         const double slowValue)
{
   return StringFormat("%s\nSymbol: %s\nTimeframe: %s\nSignal: %s\nBasis: EMA %d/%d closed-candle crossover\nEMA%d: %.5f\nEMA%d: %.5f\nClosed candle time: %s\nMode: Alert only, no trade execution",
                       EA_NAME,
                       symbol,
                       TimeframeToText(SignalTimeframe),
                       direction,
                       FastEMA,
                       SlowEMA,
                       FastEMA,
                       fastValue,
                       SlowEMA,
                       slowValue,
                       TimeToString(barTime, TIME_DATE | TIME_MINUTES));
}

//+------------------------------------------------------------------+
//| Build startup Telegram connection-test message.                   |
//+------------------------------------------------------------------+
string BuildStartupTestMessage()
{
   return StringFormat("%s Connected\n\nVersion: %s\nBroker: %s\nAccount: %I64d\nMode: %s\nSymbols: %s\nTimeframe: %s\n\nConnection Test: SUCCESS",
                       EA_NAME,
                       EA_VERSION,
                       AccountInfoString(ACCOUNT_COMPANY),
                       AccountInfoInteger(ACCOUNT_LOGIN),
                       AccountModeToText(),
                       Symbols,
                       TimeframeToText(SignalTimeframe));
}

//+------------------------------------------------------------------+
//| Send Telegram message. Success requires HTTP 200 and ok:true.     |
//+------------------------------------------------------------------+
bool SendTelegramMessage(const string message)
{
   if(!EnableTelegramAlert)
      return true;

   if(TelegramBotToken == "" || TelegramChatID == "")
   {
      WarnMessage("Telegram send failed: TelegramBotToken or TelegramChatID is empty.");
      return false;
   }

   string url = "https://api.telegram.org/bot" + TelegramBotToken +
                "/sendMessage?chat_id=" + UrlEncode(TelegramChatID) +
                "&text=" + UrlEncode(message);

   char data[];
   char result[];
   string resultHeaders = "";
   ArrayResize(data, 0);

   ResetLastError();
   int status = WebRequest("GET", url, "", TELEGRAM_TIMEOUT_MS, data, result, resultHeaders);
   int error = GetLastError();

   if(status == -1)
   {
      WarnMessage(StringFormat("Telegram send failed: WebRequest error %d. Confirm Telegram URL is allowed in MT5 options.", error));
      return false;
   }

   string response = CharArrayToString(result, 0, -1, CP_UTF8);
   if(status == 200 && StringFind(response, "\"ok\":true") >= 0)
      return true;

   WarnMessage(StringFormat("Telegram send failed: HTTP %d Response: %s", status, response));
   return false;
}

//+------------------------------------------------------------------+
//| Send one startup Telegram connection test on successful init.     |
//+------------------------------------------------------------------+
void SendStartupConnectionTest()
{
   if(!SendStartupTestMessage)
   {
      LogMessage("Startup Telegram connection test skipped: SendStartupTestMessage is disabled.");
      return;
   }

   if(!EnableTelegramAlert)
   {
      LogMessage("Startup Telegram connection test skipped: Telegram alerts are disabled.");
      return;
   }

   if(TelegramBotToken == "")
   {
      LogMessage("Startup Telegram connection test skipped: TelegramBotToken is empty.");
      return;
   }

   if(TelegramChatID == "")
   {
      LogMessage("Startup Telegram connection test skipped: TelegramChatID is empty.");
      return;
   }

   string message = BuildStartupTestMessage();
   if(SendTelegramMessage(message))
      LogMessage("Startup Telegram connection test sent successfully.");
   else
      WarnMessage("Startup Telegram connection test failed. See preceding Telegram failure log for exact reason.");
}

//+------------------------------------------------------------------+
//| Deliver alert through enabled channels.                           |
//+------------------------------------------------------------------+
bool DeliverAlert(const string message)
{
   if(!HasAnyAlertChannelEnabled())
   {
      WarnMessage("Alert delivery blocked: all alert channels are disabled. Enable Telegram, popup, or print logging.");
      return false;
   }

   bool telegramSuccess = SendTelegramMessage(message);
   if(!telegramSuccess)
      return false;

   if(EnablePopupAlert)
      Alert(message);

   if(EnablePrintLog)
      Print(message);

   return true;
}

//+------------------------------------------------------------------+
//| Create pending failed alert without repeated retry spam.          |
//+------------------------------------------------------------------+
void SetPendingFailedAlert(SymbolState &state,
                           const datetime barTime,
                           const string direction,
                           const string message)
{
   state.pending.active = true;
   state.pending.retried = false;
   state.pending.barTime = barTime;
   state.pending.direction = direction;
   state.pending.message = message;
}

//+------------------------------------------------------------------+
//| Retry a failed alert once on the next timer cycle only.           |
//+------------------------------------------------------------------+
void ProcessPendingAlert(SymbolState &state, const datetime latestClosedBarTime)
{
   if(!state.pending.active)
      return;

   if(state.pending.barTime != latestClosedBarTime)
   {
      LogMessage(StringFormat("%s pending alert expired because a newer candle is now active.", state.symbol));
      state.pending.active = false;
      return;
   }

   if(state.pending.retried)
   {
      state.pending.active = false;
      return;
   }

   state.pending.retried = true;
   LogMessage(StringFormat("%s retrying pending %s alert for %s.",
                           state.symbol,
                           state.pending.direction,
                           TimeToString(state.pending.barTime, TIME_DATE | TIME_MINUTES)));

   if(DeliverAlert(state.pending.message))
   {
      state.lastSuccessfulAlertBarTime = state.pending.barTime;
      state.pending.active = false;
      LogMessage(StringFormat("%s pending alert delivered successfully.", state.symbol));
   }
   else
   {
      LogMessage(StringFormat("%s pending alert retry failed and will not repeat.", state.symbol));
      state.pending.active = false;
   }
}

//+------------------------------------------------------------------+
//| Copy EMA buffers for latest and prior closed candles.             |
//+------------------------------------------------------------------+
bool GetEmaValues(const SymbolState &state,
                  double &fastCurrent,
                  double &fastPrevious,
                  double &slowCurrent,
                  double &slowPrevious)
{
   double fastBuffer[];
   double slowBuffer[];
   ArraySetAsSeries(fastBuffer, true);
   ArraySetAsSeries(slowBuffer, true);

   ResetLastError();
   int fastCopied = CopyBuffer(state.fastHandle, 0, 1, 2, fastBuffer);
   int fastError = GetLastError();

   ResetLastError();
   int slowCopied = CopyBuffer(state.slowHandle, 0, 1, 2, slowBuffer);
   int slowError = GetLastError();

   if(fastCopied != 2 || slowCopied != 2)
   {
      LogMessage(StringFormat("%s CopyBuffer failed. FastCopied=%d FastError=%d SlowCopied=%d SlowError=%d",
                              state.symbol,
                              fastCopied,
                              fastError,
                              slowCopied,
                              slowError));
      return false;
   }

   fastCurrent = fastBuffer[0];
   fastPrevious = fastBuffer[1];
   slowCurrent = slowBuffer[0];
   slowPrevious = slowBuffer[1];
   return true;
}

//+------------------------------------------------------------------+
//| Evaluate one symbol for a new closed-candle crossover.            |
//+------------------------------------------------------------------+
void EvaluateSymbol(SymbolState &state)
{
   if(!state.valid)
      return;

   if(!HasEnoughHistory(state.symbol))
      return;

   datetime latestClosedBarTime = iTime(state.symbol, SignalTimeframe, 1);
   if(latestClosedBarTime <= 0)
   {
      LogMessage(state.symbol + " skipped: latest closed candle time unavailable during evaluation.");
      return;
   }

   ProcessPendingAlert(state, latestClosedBarTime);

   // Only evaluate each newly closed candle once. Pending failed alerts are
   // retried separately above according to the one-retry rule.
   if(latestClosedBarTime <= state.lastEvaluatedBarTime)
      return;

   state.lastEvaluatedBarTime = latestClosedBarTime;

   double fastCurrent = 0.0;
   double fastPrevious = 0.0;
   double slowCurrent = 0.0;
   double slowPrevious = 0.0;

   if(!GetEmaValues(state, fastCurrent, fastPrevious, slowCurrent, slowPrevious))
      return;

   string direction = "";
   if(fastPrevious <= slowPrevious && fastCurrent > slowCurrent)
      direction = "BULLISH_TREND";
   else if(fastPrevious >= slowPrevious && fastCurrent < slowCurrent)
      direction = "BEARISH_TREND";
   else
      return;

   if(state.lastSuccessfulAlertBarTime == latestClosedBarTime)
      return;

   string message = BuildAlertMessage(state.symbol,
                                      direction,
                                      latestClosedBarTime,
                                      fastCurrent,
                                      slowCurrent);

   if(DeliverAlert(message))
   {
      state.lastSuccessfulAlertBarTime = latestClosedBarTime;
      state.pending.active = false;
      LogMessage(StringFormat("%s %s alert delivered for %s.",
                              state.symbol,
                              direction,
                              TimeToString(latestClosedBarTime, TIME_DATE | TIME_MINUTES)));
   }
   else
   {
      LogMessage(StringFormat("%s %s alert delivery failed for %s. One retry is pending for the next timer cycle.",
                              state.symbol,
                              direction,
                              TimeToString(latestClosedBarTime, TIME_DATE | TIME_MINUTES)));
      SetPendingFailedAlert(state, latestClosedBarTime, direction, message);
   }
}

//+------------------------------------------------------------------+
//| Expert initialization.                                            |
//+------------------------------------------------------------------+
int OnInit()
{
   if(FastEMA <= 0 || SlowEMA <= 0 || FastEMA >= SlowEMA)
   {
      LogMessage("Invalid EMA inputs. Require FastEMA > 0, SlowEMA > 0, and FastEMA < SlowEMA.");
      return INIT_PARAMETERS_INCORRECT;
   }

   if(EnableTelegramAlert && (TelegramBotToken == "" || TelegramChatID == ""))
      LogMessage("Telegram alerts are enabled, but TelegramBotToken or TelegramChatID is empty.");

   if(EnableTelegramAlert)
      LogMessage("Telegram requires https://api.telegram.org to be enabled in MT5 WebRequest settings.");

   if(!HasAnyAlertChannelEnabled())
      WarnMessage("All alert channels are disabled. Signals will not be marked as delivered until at least one channel is enabled.");

   InitializeSymbols();
   EventSetTimer(TIMER_SECONDS);
   SendStartupConnectionTest();

   return INIT_SUCCEEDED;
}

//+------------------------------------------------------------------+
//| Expert deinitialization.                                          |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
   EventKillTimer();

   for(int i = 0; i < ArraySize(g_states); i++)
   {
      if(g_states[i].fastHandle != INVALID_HANDLE)
         IndicatorRelease(g_states[i].fastHandle);
      if(g_states[i].slowHandle != INVALID_HANDLE)
         IndicatorRelease(g_states[i].slowHandle);
   }
}

//+------------------------------------------------------------------+
//| Timer-driven monitoring and retry cycle.                          |
//+------------------------------------------------------------------+
void OnTimer()
{
   for(int i = 0; i < ArraySize(g_states); i++)
      EvaluateSymbol(g_states[i]);
}

//+------------------------------------------------------------------+
//| Tick handler intentionally does not evaluate signals.             |
//| Timer evaluation prevents retry spam and keeps behavior stable.   |
//+------------------------------------------------------------------+
void OnTick()
{
}
