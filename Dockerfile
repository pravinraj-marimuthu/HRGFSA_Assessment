# ---------- Build ----------

FROM python:3.11-alpine AS builder

WORKDIR /app

COPY app/requirements.txt ./

RUN pip install --no-cache-dir -r requirements.txt --target /app/deps

# ---------- Runtime ----------

FROM python:3.11-alpine

WORKDIR /app

COPY --from=builder /app/deps /usr/lib/python3.11/site-packages

COPY app/ ./

EXPOSE 3000

CMD ["python", "app.py"]