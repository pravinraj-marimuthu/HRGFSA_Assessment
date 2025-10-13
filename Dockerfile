FROM python:3.11-alpine

WORKDIR /app

COPY app/requirements.txt ./

RUN pip install -r requirements.txt

# Copy app
COPY app/ ./

EXPOSE 3000

CMD ["python", "app.py"]