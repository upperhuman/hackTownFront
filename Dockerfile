# 1) Збирання
FROM instrumentisto/flutter:latest AS builder
WORKDIR /app

# Копіюємо код + .env
COPY . .

ARG BASE_URL
ARG GOOGLE_MAP_API
# Збираємо web
RUN flutter pub get
RUN flutter build web --release \
    --dart-define=BASE_URL=$BASE_URL \
    --dart-define=GOOGLE_MAP_API=$GOOGLE_MAP_API

# Запускаємо we

# 2) Ніжний nginx
FROM nginx:alpine
# Копіюємо лише зібраний web
COPY --from=builder /app/build/web /usr/share/nginx/html
# Видаляємо дефолтний конфіг, якщо хочете свій
#COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]