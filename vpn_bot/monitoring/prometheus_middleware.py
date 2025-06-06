"""Prometheus exporter middleware."""
from prometheus_client import Counter, generate_latest
from starlette.middleware.base import BaseHTTPMiddleware
from starlette.responses import Response

REQUEST_COUNT = Counter('requests_total', 'Total HTTP requests', ['path'])

class PrometheusMiddleware(BaseHTTPMiddleware):
    async def dispatch(self, request, call_next):
        REQUEST_COUNT.labels(path=request.url.path).inc()
        return await call_next(request)

async def metrics_endpoint(request):
    return Response(generate_latest(), media_type='text/plain')
