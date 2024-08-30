FROM python:3

WORKDIR /usr/src/app

RUN apt update
RUN apt install redis-server -y
RUN apt install -y libgl1-mesa-glx libglib2.0-0
RUN mkdir -p /var/log/myapp

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt
RUN playwright install
RUN apt install -y libnss3 libnspr4 libdbus-1-3 libatk1.0-0 libatk-bridge2.0-0 libcups2 libatspi2.0-0 libxcomposite1 libxdamage1 libxrandr2 libgbm1 libxkbcommon0 libasound2

COPY . .

EXPOSE 5000

CMD [ "python", "app.py" ]
