//+------------------------------------------------------------------+
//| TNPA Telegram Alert EA                                           |
//| Alert-only MT5 Expert Advisor for TNPA Signal Engine v0.4.       |
//|                                                                  |
//| Safety boundary: this EA does not place, modify, or close trades. |
//+------------------------------------------------------------------+
#property strict
#property version   "1.04"
#property description "TNPA alert-only radar scanner. Sends Telegram and/or popup alerts for TNPA v0.4 closed-candle signals."

input string          Symbols             = "XAUUSD,EURUSD,BTCUSD";
input string          TelegramBotToken    = "";
input string          TelegramChatID      = "";
input bool            EnableTelegramAlert = true;
input bool            EnablePopupAlert    = true;
input bool            EnablePrintLog      = true;
input bool            SendStartupTestMessage = true;

input bool            Enable_M15          = true;
input bool            Enable_M30          = true;
input bool            Enable_H1           = true;
input bool            Enable_H4           = true;
input bool            Enable_D1           = true;
input bool            Enable_W1           = true;

input int             EMA_Fast            = 21;
input int             EMA_Mid1            = 34;
input int             EMA_Mid2            = 89;
input int             EMA_Long            = 200;

input int             RSI_Period          = 14;
input int             RSI_SMA_Period      = 50;

input int             KC_Period           = 21;
input int             KC_ATR_Period       = 21;
input double          KC_Multiplier       = 1.5;

input int             DC_Fast_Period      = 20;
input int             DC_Slow_Period      = 55;
input bool            EnableDCLevels      = true;
input double          DC_Near_Percent     = 0.15;

input bool            EnableSignal_TrendAlignment = true;
input bool            EnableSignal_WeeklyFilter   = true;
input bool            EnableSignal_KC21Momentum   = true;
input bool            EnableSignal_EMA21Pullback  = true;
input bool            EnableSignal_TDPlaceholder  = false;

const int TIMER_SECONDS = 30;
const int TELEGRAM_TIMEOUT_MS = 5000;
const string EA_NAME = "TNPA Telegram Alert EA";
const string EA_VERSION = "v0.4";
const int SIGNAL_COUNT = 5;

enum SignalDirection
{
   DIR_NEUTRAL = 0,
   DIR_BUY = 1,
   DIR_SELL = -1
};

enum SignalId
{
   SIGNAL_TREND_ALIGNMENT = 0,
   SIGNAL_WEEKLY_FILTER = 1,
   SIGNAL_KC21_MOMENTUM = 2,
   SIGNAL_EMA21_PULLBACK = 3,
   SIGNAL_TD_PLACEHOLDER = 4
};

struct PendingAlert
{
   bool     active;
   bool     retried;
   datetime barTime;
   string   signalType;
   string   direction;
   string   message;
};

struct SignalRuntime
{
   int      lastDirection;
   datetime lastSuccessfulAlertBarTime;
   PendingAlert pending;
};

struct ScanState
{
   string          symbol;
   ENUM_TIMEFRAMES timeframe;
   bool            valid;
   int             emaFastHandle;
   int             emaMid1Handle;
   int             emaMid2Handle;
   int             emaLongHandle;
   int             rsiHandle;
   int             atrHandle;
   datetime        initializedBarTime;
   datetime        lastEvaluatedBarTime;
   SignalRuntime   runtime[5];
};

struct MarketSnapshot
{
   datetime barTime;
   double close;
   double high;
   double low;
   double emaFast;
   double emaMid1;
   double emaMid2;
   double emaLong;
   double rsi;
   double rsiSma;
   double atr;
   double kcMid;
   double kcUpper;
   double kcLower;
   double dc20Upper;
   double dc20Lower;
   double dc55Upper;
   double dc55Lower;
   string dcContext;
};

ScanState g_states[];

//+------------------------------------------------------------------+
//| Logging helper.                                                   |
//+------------------------------------------------------------------+
void LogMessage(const string message)
{
   if(EnablePrintLog)
      Print(EA_NAME + ": " + message);
}

//+------------------------------------------------------------------+
//| Forced warning for unsafe or delivery-failure states.             |
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
      case PERIOD_M15: return "M15";
      case PERIOD_M30: return "M30";
      case PERIOD_H1:  return "H1";
      case PERIOD_H4:  return "H4";
      case PERIOD_D1:  return "D1";
      case PERIOD_W1:  return "W1";
      default:         return EnumToString(timeframe);
   }
}

//+------------------------------------------------------------------+
//| Enabled timeframe list for startup message.                       |
//+------------------------------------------------------------------+
string EnabledTimeframesText()
{
   string value = "";
   if(Enable_M15) value += "M15,";
   if(Enable_M30) value += "M30,";
   if(Enable_H1)  value += "H1,";
   if(Enable_H4)  value += "H4,";
   if(Enable_D1)  value += "D1,";
   if(Enable_W1)  value += "W1,";

   if(value == "")
      return "None";

   return StringSubstr(value, 0, StringLen(value) - 1);
}

//+------------------------------------------------------------------+
//| Human-readable account mode for startup and alerts.               |
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
//| Signal labels.                                                    |
//+------------------------------------------------------------------+
string SignalTypeText(const int signalId)
{
   switch(signalId)
   {
      case SIGNAL_TREND_ALIGNMENT: return "TNPA TREND ALIGNMENT";
      case SIGNAL_WEEKLY_FILTER:   return "TNPA WEEKLY FILTER";
      case SIGNAL_KC21_MOMENTUM:   return "TNPA KC21 MOMENTUM";
      case SIGNAL_EMA21_PULLBACK:  return "TNPA EMA21 PULLBACK";
      case SIGNAL_TD_PLACEHOLDER:  return "TNPA TD PLACEHOLDER";
      default:                     return "TNPA UNKNOWN SIGNAL";
   }
}

//+------------------------------------------------------------------+
//| Direction label.                                                  |
//+------------------------------------------------------------------+
string DirectionText(const int direction)
{
   if(direction == DIR_BUY)
      return "BUY";
   if(direction == DIR_SELL)
      return "SELL";
   return "NEUTRAL";
}

//+------------------------------------------------------------------+
//| Trading style label by timeframe.                                 |
//+------------------------------------------------------------------+
string TradingStyleText(const ENUM_TIMEFRAMES timeframe)
{
   if(timeframe == PERIOD_M15 || timeframe == PERIOD_M30)
      return "Scalping / Intraday";
   if(timeframe == PERIOD_H1 || timeframe == PERIOD_H4)
      return "Intraday / Swing";
   if(timeframe == PERIOD_D1 || timeframe == PERIOD_W1)
      return "Swing / Position";
   return "Unclassified";
}

//+------------------------------------------------------------------+
//| Signal toggle lookup.                                             |
//+------------------------------------------------------------------+
bool IsSignalEnabled(const int signalId)
{
   switch(signalId)
   {
      case SIGNAL_TREND_ALIGNMENT: return EnableSignal_TrendAlignment;
      case SIGNAL_WEEKLY_FILTER:   return EnableSignal_WeeklyFilter;
      case SIGNAL_KC21_MOMENTUM:   return EnableSignal_KC21Momentum;
      case SIGNAL_EMA21_PULLBACK:  return EnableSignal_EMA21Pullback;
      case SIGNAL_TD_PLACEHOLDER:  return EnableSignal_TDPlaceholder;
      default:                     return false;
   }
}

//+------------------------------------------------------------------+
//| Validate enough closed candle history for v0.4 indicators.        |
//+------------------------------------------------------------------+
bool HasEnoughHistory(const string symbol, const ENUM_TIMEFRAMES timeframe)
{
   int requiredBars = MathMax(EMA_Long, MathMax(RSI_Period + RSI_SMA_Period, MathMax(KC_ATR_Period, DC_Slow_Period))) + 5;
   int bars = Bars(symbol, timeframe);

   if(bars < requiredBars)
   {
      LogMessage(StringFormat("%s %s skipped: insufficient history. Bars=%d Required=%d",
                              symbol,
                              TimeframeToText(timeframe),
                              bars,
                              requiredBars));
      return false;
   }

   return true;
}

//+------------------------------------------------------------------+
//| Initialize one runtime slot.                                      |
//+------------------------------------------------------------------+
void ResetRuntime(SignalRuntime &runtime)
{
   runtime.lastDirection = DIR_NEUTRAL;
   runtime.lastSuccessfulAlertBarTime = 0;
   runtime.pending.active = false;
   runtime.pending.retried = false;
   runtime.pending.barTime = 0;
   runtime.pending.signalType = "";
   runtime.pending.direction = "";
   runtime.pending.message = "";
}

//+------------------------------------------------------------------+
//| Release indicator handles for one state.                          |
//+------------------------------------------------------------------+
void ReleaseStateHandles(ScanState &state)
{
   if(state.emaFastHandle != INVALID_HANDLE)
      IndicatorRelease(state.emaFastHandle);
   if(state.emaMid1Handle != INVALID_HANDLE)
      IndicatorRelease(state.emaMid1Handle);
   if(state.emaMid2Handle != INVALID_HANDLE)
      IndicatorRelease(state.emaMid2Handle);
   if(state.emaLongHandle != INVALID_HANDLE)
      IndicatorRelease(state.emaLongHandle);
   if(state.rsiHandle != INVALID_HANDLE)
      IndicatorRelease(state.rsiHandle);
   if(state.atrHandle != INVALID_HANDLE)
      IndicatorRelease(state.atrHandle);

   state.emaFastHandle = INVALID_HANDLE;
   state.emaMid1Handle = INVALID_HANDLE;
   state.emaMid2Handle = INVALID_HANDLE;
   state.emaLongHandle = INVALID_HANDLE;
   state.rsiHandle = INVALID_HANDLE;
   state.atrHandle = INVALID_HANDLE;
}

//+------------------------------------------------------------------+
//| Copy one indicator value from the latest closed candle.           |
//+------------------------------------------------------------------+
bool CopyOneValue(const int handle, const string label, const ScanState &state, double &value)
{
   double buffer[];
   ArraySetAsSeries(buffer, true);

   ResetLastError();
   int copied = CopyBuffer(handle, 0, 1, 1, buffer);
   int error = GetLastError();

   if(copied != 1)
   {
      LogMessage(StringFormat("%s %s CopyBuffer failed for %s. Copied=%d Error=%d",
                              state.symbol,
                              TimeframeToText(state.timeframe),
                              label,
                              copied,
                              error));
      return false;
   }

   value = buffer[0];
   return true;
}

//+------------------------------------------------------------------+
//| Copy latest RSI and SMA of prior RSI values on closed candles.    |
//+------------------------------------------------------------------+
bool CopyRsiValues(const ScanState &state, double &rsi, double &rsiSma)
{
   double buffer[];
   ArraySetAsSeries(buffer, true);

   ResetLastError();
   int copied = CopyBuffer(state.rsiHandle, 0, 1, RSI_SMA_Period, buffer);
   int error = GetLastError();

   if(copied != RSI_SMA_Period)
   {
      LogMessage(StringFormat("%s %s CopyBuffer failed for RSI SMA. Copied=%d Error=%d Required=%d",
                              state.symbol,
                              TimeframeToText(state.timeframe),
                              copied,
                              error,
                              RSI_SMA_Period));
      return false;
   }

   rsi = buffer[0];
   double total = 0.0;
   for(int i = 0; i < RSI_SMA_Period; i++)
      total += buffer[i];

   rsiSma = total / RSI_SMA_Period;
   return true;
}

//+------------------------------------------------------------------+
//| Calculate Donchian context from closed candles only.              |
//+------------------------------------------------------------------+
bool CalculateDonchian(const ScanState &state,
                       const double close,
                       double &dc20Upper,
                       double &dc20Lower,
                       double &dc55Upper,
                       double &dc55Lower,
                       string &context)
{
   dc20Upper = 0.0;
   dc20Lower = 0.0;
   dc55Upper = 0.0;
   dc55Lower = 0.0;
   context = "None";

   if(!EnableDCLevels)
      return true;

   double highs20[];
   double lows20[];
   double highs55[];
   double lows55[];
   ArraySetAsSeries(highs20, true);
   ArraySetAsSeries(lows20, true);
   ArraySetAsSeries(highs55, true);
   ArraySetAsSeries(lows55, true);

   ResetLastError();
   int high20Copied = CopyHigh(state.symbol, state.timeframe, 1, DC_Fast_Period, highs20);
   int high20Error = GetLastError();

   ResetLastError();
   int low20Copied = CopyLow(state.symbol, state.timeframe, 1, DC_Fast_Period, lows20);
   int low20Error = GetLastError();

   ResetLastError();
   int high55Copied = CopyHigh(state.symbol, state.timeframe, 1, DC_Slow_Period, highs55);
   int high55Error = GetLastError();

   ResetLastError();
   int low55Copied = CopyLow(state.symbol, state.timeframe, 1, DC_Slow_Period, lows55);
   int low55Error = GetLastError();

   if(high20Copied != DC_Fast_Period || low20Copied != DC_Fast_Period ||
      high55Copied != DC_Slow_Period || low55Copied != DC_Slow_Period)
   {
      LogMessage(StringFormat("%s %s Donchian copy failed. H20=%d/E%d L20=%d/E%d H55=%d/E%d L55=%d/E%d",
                              state.symbol,
                              TimeframeToText(state.timeframe),
                              high20Copied,
                              high20Error,
                              low20Copied,
                              low20Error,
                              high55Copied,
                              high55Error,
                              low55Copied,
                              low55Error));
      return false;
   }

   dc20Upper = highs20[0];
   dc20Lower = lows20[0];
   for(int i = 1; i < DC_Fast_Period; i++)
   {
      if(highs20[i] > dc20Upper)
         dc20Upper = highs20[i];
      if(lows20[i] < dc20Lower)
         dc20Lower = lows20[i];
   }

   dc55Upper = highs55[0];
   dc55Lower = lows55[0];
   for(int i = 1; i < DC_Slow_Period; i++)
   {
      if(highs55[i] > dc55Upper)
         dc55Upper = highs55[i];
      if(lows55[i] < dc55Lower)
         dc55Lower = lows55[i];
   }

   string labels = "";
   double near20 = MathAbs(dc20Upper - dc20Lower) * DC_Near_Percent;
   double near55 = MathAbs(dc55Upper - dc55Lower) * DC_Near_Percent;

   if(near20 > 0.0)
   {
      if(MathAbs(close - dc20Upper) <= near20)
         labels += "Near DC20 Swing High; ";
      if(MathAbs(close - dc20Lower) <= near20)
         labels += "Near DC20 Swing Low; ";
   }

   if(near55 > 0.0)
   {
      if(MathAbs(close - dc55Upper) <= near55)
         labels += "Near DC55 Major Swing High; ";
      if(MathAbs(close - dc55Lower) <= near55)
         labels += "Near DC55 Major Swing Low; ";
   }

   if(labels != "")
      context = StringSubstr(labels, 0, StringLen(labels) - 2);

   return true;
}

//+------------------------------------------------------------------+
//| Build latest closed candle market snapshot.                       |
//+------------------------------------------------------------------+
bool BuildSnapshot(const ScanState &state, MarketSnapshot &snapshot)
{
   if(!HasEnoughHistory(state.symbol, state.timeframe))
      return false;

   snapshot.barTime = iTime(state.symbol, state.timeframe, 1);
   if(snapshot.barTime <= 0)
   {
      LogMessage(state.symbol + " " + TimeframeToText(state.timeframe) + " skipped: closed candle time unavailable.");
      return false;
   }

   snapshot.close = iClose(state.symbol, state.timeframe, 1);
   snapshot.high = iHigh(state.symbol, state.timeframe, 1);
   snapshot.low = iLow(state.symbol, state.timeframe, 1);

   if(snapshot.close == 0.0 || snapshot.high == 0.0 || snapshot.low == 0.0)
   {
      LogMessage(state.symbol + " " + TimeframeToText(state.timeframe) + " skipped: closed candle price data unavailable.");
      return false;
   }

   if(!CopyOneValue(state.emaFastHandle, "EMA_Fast", state, snapshot.emaFast))
      return false;
   if(!CopyOneValue(state.emaMid1Handle, "EMA_Mid1", state, snapshot.emaMid1))
      return false;
   if(!CopyOneValue(state.emaMid2Handle, "EMA_Mid2", state, snapshot.emaMid2))
      return false;
   if(!CopyOneValue(state.emaLongHandle, "EMA_Long", state, snapshot.emaLong))
      return false;
   if(!CopyRsiValues(state, snapshot.rsi, snapshot.rsiSma))
      return false;
   if(!CopyOneValue(state.atrHandle, "ATR", state, snapshot.atr))
      return false;

   snapshot.kcMid = snapshot.emaFast;
   snapshot.kcUpper = snapshot.kcMid + snapshot.atr * KC_Multiplier;
   snapshot.kcLower = snapshot.kcMid - snapshot.atr * KC_Multiplier;

   if(!CalculateDonchian(state,
                         snapshot.close,
                         snapshot.dc20Upper,
                         snapshot.dc20Lower,
                         snapshot.dc55Upper,
                         snapshot.dc55Lower,
                         snapshot.dcContext))
      return false;

   return true;
}

//+------------------------------------------------------------------+
//| Current direction for one signal type.                            |
//+------------------------------------------------------------------+
int EvaluateSignalDirection(const int signalId, const ScanState &state, const MarketSnapshot &snapshot, string &strength)
{
   strength = "Normal";

   if(signalId == SIGNAL_TREND_ALIGNMENT)
   {
      bool buy = snapshot.emaFast > snapshot.emaMid1 &&
                 snapshot.emaMid1 > snapshot.emaMid2 &&
                 snapshot.emaMid2 > snapshot.emaLong &&
                 snapshot.rsi > snapshot.rsiSma;

      bool sell = snapshot.emaFast < snapshot.emaMid1 &&
                  snapshot.emaMid1 < snapshot.emaMid2 &&
                  snapshot.emaMid2 < snapshot.emaLong &&
                  snapshot.rsi < snapshot.rsiSma;

      if(buy) return DIR_BUY;
      if(sell) return DIR_SELL;
      return DIR_NEUTRAL;
   }

   if(signalId == SIGNAL_WEEKLY_FILTER)
   {
      if(state.timeframe != PERIOD_W1)
         return DIR_NEUTRAL;

      if(snapshot.rsi > 50.0 && snapshot.close > snapshot.emaFast)
         return DIR_BUY;
      if(snapshot.rsi < 50.0 && snapshot.close < snapshot.emaFast)
         return DIR_SELL;
      return DIR_NEUTRAL;
   }

   if(signalId == SIGNAL_KC21_MOMENTUM)
   {
      if(snapshot.close > snapshot.kcUpper && snapshot.rsi > 50.0)
      {
         strength = "Strong";
         return DIR_BUY;
      }
      if(snapshot.close > snapshot.kcMid && snapshot.rsi > 50.0)
         return DIR_BUY;
      if(snapshot.close < snapshot.kcLower && snapshot.rsi < 50.0)
      {
         strength = "Strong";
         return DIR_SELL;
      }
      if(snapshot.close < snapshot.kcMid && snapshot.rsi < 50.0)
         return DIR_SELL;
      return DIR_NEUTRAL;
   }

   if(signalId == SIGNAL_EMA21_PULLBACK)
   {
      string ignoredStrength = "Normal";
      int trendDirection = EvaluateSignalDirection(SIGNAL_TREND_ALIGNMENT, state, snapshot, ignoredStrength);

      if(trendDirection == DIR_BUY &&
         snapshot.low <= snapshot.emaFast &&
         snapshot.close > snapshot.emaFast &&
         snapshot.rsi > 50.0)
      {
         return DIR_BUY;
      }

      if(trendDirection == DIR_SELL &&
         snapshot.high >= snapshot.emaFast &&
         snapshot.close < snapshot.emaFast &&
         snapshot.rsi < 50.0)
      {
         return DIR_SELL;
      }

      return DIR_NEUTRAL;
   }

   if(signalId == SIGNAL_TD_PLACEHOLDER)
   {
      LogMessage("TD Sequential signal is not implemented in v0.4");
      return DIR_NEUTRAL;
   }

   return DIR_NEUTRAL;
}

//+------------------------------------------------------------------+
//| Build Telegram and popup message text.                            |
//+------------------------------------------------------------------+
string BuildAlertMessage(const ScanState &state,
                         const MarketSnapshot &snapshot,
                         const int signalId,
                         const int direction,
                         const string strength)
{
   return StringFormat("TNPA SIGNAL\n\nType: %s\n\nStrength:\n%s\n\nDirection:\n%s\n\nSymbol: %s\n\nSignal Timeframe: %s\n\nTrading Style: %s\n\nPrice: %.5f\n\nEMA%d: %.5f\n\nEMA%d: %.5f\n\nEMA%d: %.5f\n\nEMA%d: %.5f\n\nRSI%d: %.2f\n\nRSI_SMA%d: %.2f\n\nKC%d Mid: %.5f\n\nKC%d Upper: %.5f\n\nKC%d Lower: %.5f\n\nDC%d Upper: %.5f\n\nDC%d Lower: %.5f\n\nDC%d Upper: %.5f\n\nDC%d Lower: %.5f\n\nDC Context: %s\n\nBroker: %s\n\nAccount: %I64d\n\nMode:\n%s",
                       SignalTypeText(signalId),
                       strength,
                       DirectionText(direction),
                       state.symbol,
                       TimeframeToText(state.timeframe),
                       TradingStyleText(state.timeframe),
                       snapshot.close,
                       EMA_Fast,
                       snapshot.emaFast,
                       EMA_Mid1,
                       snapshot.emaMid1,
                       EMA_Mid2,
                       snapshot.emaMid2,
                       EMA_Long,
                       snapshot.emaLong,
                       RSI_Period,
                       snapshot.rsi,
                       RSI_SMA_Period,
                       snapshot.rsiSma,
                       KC_Period,
                       snapshot.kcMid,
                       KC_Period,
                       snapshot.kcUpper,
                       KC_Period,
                       snapshot.kcLower,
                       DC_Fast_Period,
                       snapshot.dc20Upper,
                       DC_Fast_Period,
                       snapshot.dc20Lower,
                       DC_Slow_Period,
                       snapshot.dc55Upper,
                       DC_Slow_Period,
                       snapshot.dc55Lower,
                       snapshot.dcContext,
                       AccountInfoString(ACCOUNT_COMPANY),
                       AccountInfoInteger(ACCOUNT_LOGIN),
                       AccountModeToText());
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
                       EnabledTimeframesText());
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
void SetPendingFailedAlert(ScanState &state,
                           const int signalId,
                           const datetime barTime,
                           const string direction,
                           const string message)
{
   state.runtime[signalId].pending.active = true;
   state.runtime[signalId].pending.retried = false;
   state.runtime[signalId].pending.barTime = barTime;
   state.runtime[signalId].pending.signalType = SignalTypeText(signalId);
   state.runtime[signalId].pending.direction = direction;
   state.runtime[signalId].pending.message = message;
}

//+------------------------------------------------------------------+
//| Retry failed alerts once on the next timer cycle only.            |
//+------------------------------------------------------------------+
void ProcessPendingAlerts(ScanState &state, const datetime latestClosedBarTime)
{
   for(int signalId = 0; signalId < SIGNAL_COUNT; signalId++)
   {
      PendingAlert pending = state.runtime[signalId].pending;
      if(!pending.active)
         continue;

      if(pending.barTime != latestClosedBarTime)
      {
         LogMessage(StringFormat("%s %s pending %s expired because a newer candle is now active.",
                                 state.symbol,
                                 TimeframeToText(state.timeframe),
                                 pending.signalType));
         state.runtime[signalId].pending.active = false;
         continue;
      }

      if(pending.retried)
      {
         state.runtime[signalId].pending.active = false;
         continue;
      }

      state.runtime[signalId].pending.retried = true;
      LogMessage(StringFormat("%s %s retrying pending %s %s alert for %s.",
                              state.symbol,
                              TimeframeToText(state.timeframe),
                              pending.signalType,
                              pending.direction,
                              TimeToString(pending.barTime, TIME_DATE | TIME_MINUTES)));

      if(DeliverAlert(pending.message))
      {
         state.runtime[signalId].lastSuccessfulAlertBarTime = pending.barTime;
         state.runtime[signalId].pending.active = false;
         LogMessage(StringFormat("%s %s pending %s delivered successfully.",
                                 state.symbol,
                                 TimeframeToText(state.timeframe),
                                 pending.signalType));
      }
      else
      {
         LogMessage(StringFormat("%s %s pending %s retry failed and will not repeat.",
                                 state.symbol,
                                 TimeframeToText(state.timeframe),
                                 pending.signalType));
         state.runtime[signalId].pending.active = false;
      }
   }
}

//+------------------------------------------------------------------+
//| Initialize one symbol/timeframe scanner state.                    |
//+------------------------------------------------------------------+
bool InitializeScanState(ScanState &state, const string symbol, const ENUM_TIMEFRAMES timeframe)
{
   state.symbol = symbol;
   state.timeframe = timeframe;
   state.valid = false;
   state.emaFastHandle = INVALID_HANDLE;
   state.emaMid1Handle = INVALID_HANDLE;
   state.emaMid2Handle = INVALID_HANDLE;
   state.emaLongHandle = INVALID_HANDLE;
   state.rsiHandle = INVALID_HANDLE;
   state.atrHandle = INVALID_HANDLE;
   state.initializedBarTime = 0;
   state.lastEvaluatedBarTime = 0;

   for(int signalId = 0; signalId < SIGNAL_COUNT; signalId++)
      ResetRuntime(state.runtime[signalId]);

   if(symbol == "")
      return false;

   if(!SymbolSelect(symbol, true))
   {
      LogMessage(symbol + " skipped: symbol is unavailable or could not be selected.");
      return false;
   }

   if(!HasEnoughHistory(symbol, timeframe))
      return false;

   state.emaFastHandle = iMA(symbol, timeframe, EMA_Fast, 0, MODE_EMA, PRICE_CLOSE);
   state.emaMid1Handle = iMA(symbol, timeframe, EMA_Mid1, 0, MODE_EMA, PRICE_CLOSE);
   state.emaMid2Handle = iMA(symbol, timeframe, EMA_Mid2, 0, MODE_EMA, PRICE_CLOSE);
   state.emaLongHandle = iMA(symbol, timeframe, EMA_Long, 0, MODE_EMA, PRICE_CLOSE);
   state.rsiHandle = iRSI(symbol, timeframe, RSI_Period, PRICE_CLOSE);
   state.atrHandle = iATR(symbol, timeframe, KC_ATR_Period);

   if(state.emaFastHandle == INVALID_HANDLE ||
      state.emaMid1Handle == INVALID_HANDLE ||
      state.emaMid2Handle == INVALID_HANDLE ||
      state.emaLongHandle == INVALID_HANDLE ||
      state.rsiHandle == INVALID_HANDLE ||
      state.atrHandle == INVALID_HANDLE)
   {
      LogMessage(StringFormat("%s %s skipped: one or more indicator handles are invalid.",
                              symbol,
                              TimeframeToText(timeframe)));
      ReleaseStateHandles(state);
      return false;
   }

   MarketSnapshot snapshot;
   if(!BuildSnapshot(state, snapshot))
   {
      ReleaseStateHandles(state);
      return false;
   }

   // Startup safety: seed signal memory from the latest closed candle so
   // existing historical states are not alerted after initialization.
   state.initializedBarTime = snapshot.barTime;
   state.lastEvaluatedBarTime = snapshot.barTime;
   for(int signalId = 0; signalId < SIGNAL_COUNT; signalId++)
   {
      if(!IsSignalEnabled(signalId))
         continue;

      string strength = "Normal";
      state.runtime[signalId].lastDirection = EvaluateSignalDirection(signalId, state, snapshot, strength);
   }

   state.valid = true;

   LogMessage(StringFormat("%s %s initialized. Historical alerts suppressed through %s.",
                           symbol,
                           TimeframeToText(timeframe),
                           TimeToString(snapshot.barTime, TIME_DATE | TIME_MINUTES)));
   return true;
}

//+------------------------------------------------------------------+
//| Add one active scanner state.                                     |
//+------------------------------------------------------------------+
void AddScanState(const string symbol, const ENUM_TIMEFRAMES timeframe)
{
   int next = ArraySize(g_states);
   ArrayResize(g_states, next + 1);

   if(!InitializeScanState(g_states[next], symbol, timeframe))
      ArrayResize(g_states, next);
}

//+------------------------------------------------------------------+
//| Initialize all configured symbols and enabled timeframes.         |
//+------------------------------------------------------------------+
void InitializeScanner()
{
   string parsed[];
   int total = StringSplit(Symbols, ',', parsed);
   ArrayResize(g_states, 0);

   for(int i = 0; i < total; i++)
   {
      string symbol = TrimText(parsed[i]);
      if(symbol == "")
         continue;

      if(Enable_M15) AddScanState(symbol, PERIOD_M15);
      if(Enable_M30) AddScanState(symbol, PERIOD_M30);
      if(Enable_H1)  AddScanState(symbol, PERIOD_H1);
      if(Enable_H4)  AddScanState(symbol, PERIOD_H4);
      if(Enable_D1)  AddScanState(symbol, PERIOD_D1);
      if(Enable_W1)  AddScanState(symbol, PERIOD_W1);
   }

   if(ArraySize(g_states) == 0)
      LogMessage("No valid symbol/timeframe scanner states initialized. EA will remain safe and idle.");
}

//+------------------------------------------------------------------+
//| Evaluate one signal and deliver on direction changes only.        |
//+------------------------------------------------------------------+
void EvaluateSignal(ScanState &state, const MarketSnapshot &snapshot, const int signalId)
{
   if(!IsSignalEnabled(signalId))
      return;

   string strength = "Normal";
   int currentDirection = EvaluateSignalDirection(signalId, state, snapshot, strength);
   int previousDirection = state.runtime[signalId].lastDirection;

   state.runtime[signalId].lastDirection = currentDirection;

   if(currentDirection == DIR_NEUTRAL)
      return;

   if(previousDirection == currentDirection)
      return;

   if(state.runtime[signalId].lastSuccessfulAlertBarTime == snapshot.barTime)
      return;

   string message = BuildAlertMessage(state, snapshot, signalId, currentDirection, strength);
   string direction = DirectionText(currentDirection);

   if(DeliverAlert(message))
   {
      state.runtime[signalId].lastSuccessfulAlertBarTime = snapshot.barTime;
      state.runtime[signalId].pending.active = false;
      LogMessage(StringFormat("%s %s %s %s alert delivered for %s.",
                              state.symbol,
                              TimeframeToText(state.timeframe),
                              SignalTypeText(signalId),
                              direction,
                              TimeToString(snapshot.barTime, TIME_DATE | TIME_MINUTES)));
   }
   else
   {
      LogMessage(StringFormat("%s %s %s %s alert delivery failed for %s. One retry is pending for the next timer cycle.",
                              state.symbol,
                              TimeframeToText(state.timeframe),
                              SignalTypeText(signalId),
                              direction,
                              TimeToString(snapshot.barTime, TIME_DATE | TIME_MINUTES)));
      SetPendingFailedAlert(state, signalId, snapshot.barTime, direction, message);
   }
}

//+------------------------------------------------------------------+
//| Evaluate one scanner state on a newly closed candle.              |
//+------------------------------------------------------------------+
void EvaluateState(ScanState &state)
{
   if(!state.valid)
      return;

   datetime latestClosedBarTime = iTime(state.symbol, state.timeframe, 1);
   if(latestClosedBarTime <= 0)
   {
      LogMessage(state.symbol + " " + TimeframeToText(state.timeframe) + " skipped: latest closed candle time unavailable during evaluation.");
      return;
   }

   ProcessPendingAlerts(state, latestClosedBarTime);

   if(latestClosedBarTime <= state.lastEvaluatedBarTime)
      return;

   state.lastEvaluatedBarTime = latestClosedBarTime;

   MarketSnapshot snapshot;
   if(!BuildSnapshot(state, snapshot))
      return;

   EvaluateSignal(state, snapshot, SIGNAL_TREND_ALIGNMENT);
   EvaluateSignal(state, snapshot, SIGNAL_WEEKLY_FILTER);
   EvaluateSignal(state, snapshot, SIGNAL_KC21_MOMENTUM);
   EvaluateSignal(state, snapshot, SIGNAL_EMA21_PULLBACK);
   EvaluateSignal(state, snapshot, SIGNAL_TD_PLACEHOLDER);
}

//+------------------------------------------------------------------+
//| Validate user inputs.                                             |
//+------------------------------------------------------------------+
bool ValidateInputs()
{
   if(EMA_Fast <= 0 || EMA_Mid1 <= 0 || EMA_Mid2 <= 0 || EMA_Long <= 0 ||
      !(EMA_Fast < EMA_Mid1 && EMA_Mid1 < EMA_Mid2 && EMA_Mid2 < EMA_Long))
   {
      WarnMessage("Invalid EMA inputs. Require 0 < EMA_Fast < EMA_Mid1 < EMA_Mid2 < EMA_Long.");
      return false;
   }

   if(RSI_Period <= 0 || RSI_SMA_Period <= 0)
   {
      WarnMessage("Invalid RSI inputs. Require RSI_Period > 0 and RSI_SMA_Period > 0.");
      return false;
   }

   if(KC_Period <= 0 || KC_ATR_Period <= 0 || KC_Multiplier <= 0.0)
   {
      WarnMessage("Invalid Keltner inputs. Require KC_Period > 0, KC_ATR_Period > 0, and KC_Multiplier > 0.");
      return false;
   }

   if(EMA_Fast != KC_Period)
      LogMessage("KC Mid uses EMA_Fast as EMA21. Keep EMA_Fast and KC_Period aligned for standard TNPA KC21 behavior.");

   if(DC_Fast_Period <= 0 || DC_Slow_Period <= 0 || DC_Fast_Period >= DC_Slow_Period || DC_Near_Percent < 0.0)
   {
      WarnMessage("Invalid Donchian inputs. Require 0 < DC_Fast_Period < DC_Slow_Period and DC_Near_Percent >= 0.");
      return false;
   }

   if(!Enable_M15 && !Enable_M30 && !Enable_H1 && !Enable_H4 && !Enable_D1 && !Enable_W1)
   {
      WarnMessage("All timeframes are disabled. Enable at least one timeframe.");
      return false;
   }

   return true;
}

//+------------------------------------------------------------------+
//| Expert initialization.                                            |
//+------------------------------------------------------------------+
int OnInit()
{
   if(!ValidateInputs())
      return INIT_PARAMETERS_INCORRECT;

   if(EnableTelegramAlert && (TelegramBotToken == "" || TelegramChatID == ""))
      LogMessage("Telegram alerts are enabled, but TelegramBotToken or TelegramChatID is empty.");

   if(EnableTelegramAlert)
      LogMessage("Telegram requires https://api.telegram.org to be enabled in MT5 WebRequest settings.");

   if(!HasAnyAlertChannelEnabled())
      WarnMessage("All alert channels are disabled. Signals will not be marked as delivered until at least one channel is enabled.");

   InitializeScanner();
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
      ReleaseStateHandles(g_states[i]);
}

//+------------------------------------------------------------------+
//| Timer-driven monitoring and retry cycle.                          |
//+------------------------------------------------------------------+
void OnTimer()
{
   for(int i = 0; i < ArraySize(g_states); i++)
      EvaluateState(g_states[i]);
}

//+------------------------------------------------------------------+
//| Tick handler intentionally does not evaluate signals.             |
//| Timer evaluation prevents retry spam and keeps behavior stable.   |
//+------------------------------------------------------------------+
void OnTick()
{
}
