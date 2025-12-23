# VerifiMind MCP Server - Smithery Deployment
FROM ghcr.io/astral-sh/uv:python3.12-bookworm-slim

WORKDIR /app

RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

COPY . .

RUN uv pip install --system --no-cache .

ENV PYTHONUNBUFFERED=1
ENV PORT=8080

EXPOSE 8080

# Increased start-period to 30s for model/prompt loading
HEALTHCHECK --interval=5s --timeout=3s --start-period=30s --retries=3 \
  CMD curl -f http://localhost:${PORT}/health || exit 1

CMD ["sh", "-c", "uvicorn http_server:app --host 0.0.0.0 --port ${PORT}"]
