FROM maven:3.6.0-jdk-11 as builder

WORKDIR /app

# Get dependencies
COPY pom.xml .
RUN mvn dependency:resolve dependency:resolve-plugins

# Compile
COPY src src
RUN mvn compile dependency:copy-dependencies

# Run
FROM adoptopenjdk/openjdk11
ENTRYPOINT ["java"]
CMD ["-cp", "/app/classes/:/app/dependency/*", "hello.Application"]
COPY --from=builder /app/target /app