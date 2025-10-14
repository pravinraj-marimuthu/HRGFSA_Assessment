# ---------- Build ----------

FROM python:3.11-alpine AS builder

WORKDIR /app

COPY app/requirements.txt ./

RUN pip install --no-cache-dir -r requirements.txt

# ---------- Runtime ----------

FROM python:3.11-alpine

WORKDIR /app

COPY --from=builder /usr/local/lib/python3.11/site-packages /usr/local/lib/python3.11/site-packages

COPY app/ ./

EXPOSE 3000

CMD ["python", "app.py"]