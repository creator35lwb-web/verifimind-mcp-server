# Mr.Market US - Architecture & Monetization Design

## 1. Project Vision: The Intelligent Value Investing Co-Pilot

**Mr.Market US** is envisioned as an intelligent, conversational AI agent built upon the robust data foundation of MarketPulse. It will serve as an interactive co-pilot for value investors, providing on-demand analysis, answering specific market questions, and offering insights based on the principles of Warren Buffett. This project transforms the one-way data broadcast of MarketPulse into a two-way, interactive analytical experience.

## 2. Phased Architecture: From Data to Dialogue

The project will be developed in three distinct, layered phases, ensuring a stable and scalable evolution from the existing foundation.

### Phase 1: The Foundation (MarketPulse v7.0)
*   **Core Function:** Continues to run as the daily data engine, collecting, processing, and analyzing market data.
*   **Key Change:** All collected data (indicators, watchlist, news, AI analysis) will be saved to a persistent data store (e.g., n8n's built-in data store, a dedicated database like Postgres, or even a structured JSON file) with each daily run. This creates a historical context buffer for the chatbot.

### Phase 2: The Interactive Chatbot (The Core Product)
*   **Technology:** A new, separate n8n workflow triggered by a Telegram webhook.
*   **User Interaction:** Users in a private, paid-subscriber Telegram channel can ask Mr.Market questions.
*   **Workflow Logic:**
    1.  **Telegram Trigger:** A `Telegram Trigger` node listens for incoming messages.
    2.  **User Authentication:** An `IF` node checks the user's Telegram ID against a list of paid subscribers.
    3.  **Context Loading:** A `Code` node loads the latest daily data from the persistent store created by the MarketPulse foundation.
    4.  **AI Agent:** The core of the chatbot. An `AI Agent` node (using Gemini 2.5/3.0) is initialized with:
        *   **System Prompt:** A detailed persona of "Mr.Market," a seasoned value investor who thinks like Warren Buffett.
        *   **Data Context:** The loaded market data from the foundation.
        *   **Conversation History:** A `Memory (Window Buffer)` node to remember the last few turns of the conversation.
        *   **Tools:** The AI Agent will be given tools to perform actions, such as a `HTTP Request` node to look up a specific stock's real-time price if asked.
    5.  **Response Generation:** The AI Agent processes the user's question within this rich context and generates a response.
    6.  **Send Response:** A `Telegram` node sends the formatted answer back to the user.

### Phase 3: Monetization & Subscription Management
*   **Payment Gateway:** We will use **InviteMember** as the primary subscription management tool. It provides a seamless user experience, handles payments via Stripe/PayPal, and automatically manages access to the private Telegram channel.
*   **Pricing Model:** Based on your formula: `Operating Cost x 1.20`.
    *   **Initial Estimate (Self-Hosted n8n):** A reliable VPS from Hostinger or ScalaHosting costs ~$10-30/month. With low initial LLM costs, the total operating cost could be ~$40/month.
    *   **Pricing Tiers:**
        *   **Tier 1 (10 Users):** $40 / 10 = $4/user/mo. Price: **$4.80/user/mo**.
        *   **Tier 2 (50 Users):** $40 / 50 = $0.80/user/mo. Price: **$0.96/user/mo**.
    *   This model allows for affordable scaling. We will start with a simple monthly subscription.

## 3. VerifiMind-PEAS Validation Plan

| PEAS Component | Validation Strategy & Success Criteria |
| :--- | :--- |
| **Performance** | **Criteria:** The chatbot must respond to 95% of queries within 15 seconds. The system must maintain 99.9% uptime. **Validation:** Implement logging to track response times and workflow success/failure rates over a 30-day test period. |
| **Environment** | **Criteria:** The chosen infrastructure (self-hosted n8n on a VPS) must handle at least 10 concurrent users without performance degradation. **Validation:** Conduct load testing by simulating 10 simultaneous user queries and measuring response latency. |
| **Agent** | **Criteria:** The AI Agent's responses must be accurate, relevant to the provided market context, and consistent with the value investor persona. **Validation:** Create a test suite of 50 questions. Evaluate responses for factual accuracy, contextual relevance, and persona adherence. The agent must score >90% on this test. |
| **Security** | **Criteria:** User data and payment information must be handled securely. API keys must not be exposed. **Validation:** Use a secure payment gateway (Stripe via InviteMember). Store all API keys and tokens in n8n's encrypted credential manager. Conduct a code review to ensure no sensitive data is logged or exposed. |

## 4. Development Roadmap

1.  **Sprint 1 (Foundation):** Modify MarketPulse v7.0 to save its daily output to a persistent JSON file.
2.  **Sprint 2 (Chatbot MVP):** Build the core chatbot workflow in n8n, including the Telegram trigger, AI Agent, and response nodes. Test with a single user.
3.  **Sprint 3 (Subscription):** Integrate InviteMember for subscription management and create the private Telegram channel.
4.  **Sprint 4 (Beta Launch):** Onboard a small group of beta testers to validate the full user journey and gather feedback.
5.  **Sprint 5 (Public Launch):** Announce and launch Mr.Market US to the public.
