# Use uma imagem Maven como base para compilar o projeto
FROM maven:3.8.4-openjdk-17 AS build

# Configurar o diretório de trabalho
WORKDIR /app

# Copiar o código-fonte do projeto para o contêiner
COPY ./todolist /app

# Compilar o projeto
RUN mvn clean install

# Use a imagem OpenJDK para executar o aplicativo
FROM openjdk:17-jdk-slim

# Configurar o diretório de trabalho
WORKDIR /app

# Copiar o arquivo JAR gerado a partir do estágio de compilação
COPY --from=build /app/target/todolist-1.0.0.jar app.jar

# Expor a porta 8080
EXPOSE 8080

# Comando de entrada para iniciar o aplicativo
ENTRYPOINT [ "java", "-jar", "app.jar" ]
