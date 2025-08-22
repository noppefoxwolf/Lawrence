# Railway用のDockerfile - Swift実行環境を含む
FROM swift:5.9-jammy AS build

WORKDIR /app
COPY Package.swift ./
RUN swift package resolve

COPY Sources ./Sources
RUN swift build -c release

# Swiftランタイムを含むイメージを使用
FROM swift:5.9-jammy-slim
RUN apt-get update && apt-get install -y ca-certificates && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY --from=build /app/.build/release/Lawrence ./

EXPOSE 8080
CMD ["./Lawrence"]