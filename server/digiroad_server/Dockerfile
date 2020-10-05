FROM python:3.8-alpine
ADD REQUIREMENTS.txt .
RUN pip install -r REQUIREMENTS.txt
WORKDIR /api
COPY ./ /api
CMD ["python", "app.py"]