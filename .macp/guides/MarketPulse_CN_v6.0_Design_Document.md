# MarketPulse CN v6.0 - Design Document

## 1. Project Goal

To adapt the existing **MarketPulse v6.0 (US)** workflow to the Chinese market, providing a comprehensive daily digest of key Chinese economic and market indicators. This version will serve as the foundation for future iterations, including a potential v7.0 (CN) with value investor metrics.

## 2. Core Architecture

The architecture will be a direct adaptation of the MarketPulse US v6.0 workflow, leveraging the same n8n HTTP Request node structure. The key change is the replacement of US-specific symbols and API endpoints with their validated Chinese equivalents.

**Key Finding:** The core discovery from the research phase is that **Yahoo Finance provides robust, free, and direct access to all necessary China market data**, including major indices and individual stocks. This dramatically simplifies the architecture, as we do not need to introduce new libraries like AKShare or Tushare for this foundational version.

## 3. Data Source Mapping: US vs. CN

The following table outlines the direct mapping of data sources from the US version to the new China-focused version.

| Category | MarketPulse US v6.0 | MarketPulse CN v6.0 | Data Source | API/Symbol |
| :--- | :--- | :--- | :--- | :--- |
| **Primary Index** | S&P 500 | **CSI 300** | Yahoo Finance | `000300.SS` |
| **Secondary Index** | Dow Jones | **SSE Composite** | Yahoo Finance | `000001.SS` |
| **Volatility** | VIX | **China VIX (iVX)** | AKShare (Future) | *Scrape/TBD* |
| **Sentiment** | Fear & Greed Index | **MacroMicro CN F&G** | Web Scrape | *URL* |
| **Commodity** | Gold (WTI) | **Gold (WTI)** | Yahoo Finance | `GC=F` |
| **Forex** | USD/EUR | **USD/CNY** | Yahoo Finance | `CNY=X` |
| **Govt. Bond** | US 10-Year | **CN 10-Year** | AKShare (Future) | *TBD* |
| **Economic Data** | FRED (US) | **World Bank (CN)** | World Bank API | `CN` country code |
| **News Feed** | MarketWatch RSS | **Sina Finance RSS** | RSS Feed URL | *URL* |
| **Stock Watchlist** | US Stocks (GOOGL) | **CN/HK Stocks** | Yahoo Finance | `.SS`, `.SZ`, `.HK` |

**Note on Volatility/Sentiment:** For v6.0, we will initially omit the direct sentiment/volatility indicators (MacroMicro F&G, China VIX) as they require web scraping or the AKShare library. The goal for v6.0 is to build a robust foundation using only the reliable Yahoo Finance and World Bank APIs. These will be added in v7.0 (CN).

## 4. n8n Workflow Structure

The workflow will mirror the v6.0 US version precisely:

1.  **Trigger:** Daily schedule (e.g., 8:00 AM Beijing Time).
2.  **Fetch All Market Data (Code Node):** A single, sequential JavaScript-powered node.
    *   Fetches all data points using `fetch()` within the node.
    *   Uses `dns.setDefaultResultOrder('ipv4first')` for IPv4 stability.
    *   Implements retry logic and rate limiting.
3.  **AI Analysis (Gemini):**
    *   The consolidated data is passed to the Gemini 2.5 Flash model.
    *   The prompt will be updated to reflect a focus on the Chinese market.
4.  **Compose Telegram Message (Code Node):**
    *   Formats the final message with Markdown and emoji indicators.
5.  **Send to Telegram:**
    *   Sends the formatted message to the designated channel.

## 5. Watchlist Configuration

The initial watchlist will include a mix of prominent Shanghai, Shenzhen, and Hong Kong-listed companies to demonstrate the system's capability.

*   **Kweichow Moutai (SH):** `600519.SS`
*   **CATL (SZ):** `300750.SZ`
*   **BYD (SZ):** `002594.SZ`
*   **Alibaba (HK):** `9988.HK`
*   **Tencent (HK):** `0700.HK`

## 6. VerifiMind-PEAS Validation Plan

This project will be validated using the VerifiMind-PEAS framework.

*   **Performance:** The workflow must execute reliably on a daily schedule, fetching all data points without error.
*   **Environment:** The n8n cloud infrastructure must support the required `fetch` calls and code execution.
*   **Agent:** The AI agent (Gemini) must provide relevant and coherent analysis based on the Chinese market data.
*   **Security:** All API keys and sensitive information will be stored securely in n8n credentials.

## 7. Roadmap to v7.0 (CN)

Once the v6.0 foundation is stable, the following features will be added for the v7.0 (CN) iteration:

*   **Value Investor Dashboard:** Buffett Indicator (China), Shiller PE, Yield Curve.
*   **Advanced Sentiment:** Integration of MacroMicro Fear & Greed and China VIX (iVX).
*   **Deeper Economic Data:** Integration with AKShare for more granular PBOC and NBS data.
