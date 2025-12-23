# VerifiMind MCP Server

**Multi-Model AI Validation with RefleXion Trinity (X-Z-CS Agents)**

[![Smithery](https://smithery.ai/badge/verifimind-mcp-server)](https://smithery.ai/server/creator35lwb-web/verifimind-mcp-server)

## Overview

VerifiMind PEAS MCP Server provides AI-powered validation for your ideas and concepts using the RefleXion Trinity methodology:

- **X Agent** (Gemini) - Innovation & Strategy Analysis
- **Z Agent** (Claude) - Ethics & Safety Review  
- **CS Agent** (Claude) - Security & Feasibility Validation

## Quick Start

### Via Smithery (Recommended)

```bash
npx @anthropic/mcp-client connect smithery://verifimind-mcp-server
```

### Via Direct Connection

```json
{
  "mcpServers": {
    "verifimind": {
      "url": "https://verifimind.ysenseai.org/mcp"
    }
  }
}
```

## Available Tools

| Tool | Description |
|------|-------------|
| `consult_agent_x` | Innovation & Strategy analysis |
| `consult_agent_z` | Ethics & Safety review |
| `consult_agent_cs` | Security & Feasibility validation |
| `run_full_trinity` | Complete X → Z → CS validation |

## Resources

| Resource | URI |
|----------|-----|
| Genesis Master Prompt | `genesis://config/master_prompt` |
| Latest Validation | `genesis://history/latest` |
| Validation History | `genesis://history/all` |
| Project Info | `genesis://state/project_info` |

## Links

- **Landing Page**: https://verifimind.manus.space
- **Production Server**: https://verifimind.ysenseai.org
- **Main Repository**: https://github.com/creator35lwb-web/VerifiMind-PEAS
- **White Paper**: https://doi.org/10.5281/zenodo.17645665

## License

MIT License - See main repository for details.

---

Part of the [YSenseAI](https://ysenseai.org) ecosystem.
