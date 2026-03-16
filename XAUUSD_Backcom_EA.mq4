// XAUUSD_Backcom_EA.mq4
// Expert Advisor for Backcom Rebates on XAUUSD

// Define input parameters for the EA
input double LotSize = 0.1; // Lot size for trades
input double TakeProfit = 10; // Take profit in pips
input double StopLoss = 5; // Stop loss in pips
input int Slippage = 3; // Maximum slippage

// Initialize variables
double Volume;
double LastTradeTime;

// Function to calculate volume based on account equity and risk
void CalculateVolume() {
    double AccountEquity = AccountBalance() * 10; // 1000 cent (10 USD) capital
    Volume = LotSize * AccountEquity / 1000; // Calculate volume
}

// Function to open a trade
void OpenTrade() {
    CalculateVolume();
    double price = Ask;
    int ticket = OrderSend(Symbol(), OP_BUY, Volume, price, Slippage, price - StopLoss * Point, price + TakeProfit * Point, "XAUUSD_Backcom_EA", 0, 0, clrGreen);
    if (ticket < 0) {
        Print("Error opening trade: ", GetLastError());
    }
}

// Main trading function
void OnTick() {
    if (TimeCurrent() - LastTradeTime > 60) { // Check for last trade
        OpenTrade();
        LastTradeTime = TimeCurrent();
    }
}