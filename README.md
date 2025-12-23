# VerifiMind MCP Server

**Multi-Model AI Validation with RefleXion Trinity (X-Z-CS Agents)**

[![Smithery](https://smithery.ai/badge/verifimind-mcp-server)](https://smithery.ai/server/creator35lwb-web/verifimind-mcp-server)
[![Version](https://img.shields.io/badge/version-0.2.3-blue.svg)](https://github.com/creator35lwb-web/verifimind-mcp-server)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)

## Overview

VerifiMind PEAS MCP Server provides AI-powered validation for your ideas and concepts using the RefleXion Trinity methodology:

- **X Agent** - Innovation & Strategy Analysis
- **Z Agent** - Ethics & Safety Review (has VETO power)
- **CS Agent** - Security & Feasibility Validation

## Quick Start

### Via Smithery (Recommended)

Install from Smithery registry:

```bash
npx @smithery/cli install verifimind-mcp-server
```

Or connect directly:

```bash
npx @smithery/cli connect verifimind-mcp-server
```

### Via Claude Desktop

Add to your Claude Desktop config (`~/Library/Application Support/Claude/claude_desktop_config.json`):

```json
{
  "mcpServers": {
    "verifimind-genesis": {
      "url": "https://verifimind.ysenseai.org/mcp/",
      "transport": "streamable-http",
      "headers": {
        "Accept": "application/json, text/event-stream",
        "Content-Type": "application/json"
      }
    }
  }
}
```

### Via Direct HTTP

```bash
# Health check
curl https://verifimind.ysenseai.org/health

# MCP Initialize
curl -X POST https://verifimind.ysenseai.org/mcp/ \
  -H "Content-Type: application/json" \
  -H "Accept: application/json, text/event-stream" \
  -d '{"jsonrpc": "2.0", "method": "initialize", "params": {"protocolVersion": "2024-11-05", "capabilities": {}, "clientInfo": {"name": "test", "version": "1.0"}}, "id": 1}'
```

## BYOK (Bring Your Own Key)

By default, the server uses a **mock provider** for testing. To use real AI models, configure your API keys:

| Provider | Description | Cost |
|----------|-------------|------|
| `mock` | Mock responses for testing | FREE |
| `gemini` | Google Gemini 2.0 Flash | FREE tier available |
| `anthropic` | Anthropic Claude | Paid |
| `openai` | OpenAI GPT-4 | Paid |

### Smithery Configuration

When installing via Smithery, you'll be prompted to configure:

- `llm_provider`: Choose your provider (default: `mock`)
- `gemini_api_key`: Your Gemini API key (get free at https://aistudio.google.com)
- `anthropic_api_key`: Your Anthropic API key
- `openai_api_key`: Your OpenAI API key

## Available Tools

| Tool | Description |
|------|-------------|
| `consult_agent_x` | Innovation & Strategy analysis |
| `consult_agent_z` | Ethics & Safety review (has VETO power) |
| `consult_agent_cs` | Security & Feasibility validation |
| `run_full_trinity` | Complete X → Z → CS validation pipeline |

### Example: Full Trinity Validation

```
Use the run_full_trinity tool to validate:
- Name: "AI-Powered Customer Support"
- Description: "An AI chatbot that handles customer inquiries 24/7"
```

Returns comprehensive analysis from all three agents with synthesis and recommendation.

## Available Resources

| Resource | URI | Description |
|----------|-----|-------------|
| Genesis Master Prompt | `genesis://config/master_prompt` | Agent role definitions |
| Latest Validation | `genesis://history/latest` | Most recent validation result |
| Validation History | `genesis://history/all` | Complete validation history |
| Project Info | `genesis://state/project_info` | Project metadata |

## Technical Details

| Property | Value |
|----------|-------|
| **Transport** | streamable-http |
| **Protocol Version** | 2024-11-05 |
| **MCP Endpoint** | `/mcp/` (trailing slash required) |
| **Accept Header** | `application/json, text/event-stream` |

## Links

- **Landing Page**: https://verifimind.manus.space
- **Production Server**: https://verifimind.ysenseai.org
- **Main Repository**: https://github.com/creator35lwb-web/VerifiMind-PEAS
- **White Paper**: https://doi.org/10.5281/zenodo.17645665
- **Smithery**: https://smithery.ai/server/creator35lwb-web/verifimind-mcp-server

## License

MIT License - See main repository for details.

---

Part of the [YSenseAI](https://ysenseai.org) ecosystem.
