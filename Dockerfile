# 1) Збирання проєкту
FROM instrumentisto/flutter:latest AS builder
WORKDIR /app

# Копіюємо код проєкту
COPY . .

ARG BASE_URL
ARG GOOGLE_MAP_API

ENV GOOGLE_MAP_API=$GOOGLE_MAP_API
ENV BASE_URL=$BASE_URL

# Збираємо web
RUN flutter pub get
RUN flutter build web --release \
    --dart-define=BASE_URL=$BASE_URL \
    --dart-define=GOOGLE_MAP_API=$GOOGLE_MAP_API

# Дебагінг: виводимо вміст index.html перед заміною
RUN echo "=== DEBUG: index.html before sed ===" && \
    cat build/web/index.html && \
    echo "=== DEBUG END ==="

# Замінюємо плейсхолдер у index.html
RUN sed -i "s/{{GOOGLE_MAP_API}}/$GOOGLE_MAP_API/g" build/web/index.html

# Дебагінг: виводимо вміст index.html після заміни
RUN echo "=== DEBUG: index.html after sed ===" && \
    cat build/web/index.html && \
    echo "=== DEBUG END ==="

# 2) Nginx для сервірування
FROM nginx:alpine
# Копіюємо зібраний web
COPY --from=builder /app/build/web /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]