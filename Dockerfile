# VerifiMind MCP Server - Smithery Deployment
FROM ghcr.io/astral-sh/uv:python3.12-bookworm-slim

WORKDIR /app

RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

COPY . .

RUN uv pip install --system --no-cache .

ENV PYTHONUNBUFFERED=1
ENV PORT=8080

EXPOSE 8080

# Increased start-period to 60s for model/prompt loading on Smithery
HEALTHCHECK --interval=10s --timeout=5s --start-period=60s --retries=5 \
  CMD curl -f http://localhost:${PORT:-8080}/health || exit 1

# Flexible PORT handling - use $PORT if set by Smithery, otherwise 8080
CMD ["sh", "-c", "uvicorn http_server:app --host 0.0.0.0 --port ${PORT:-8080}"]
