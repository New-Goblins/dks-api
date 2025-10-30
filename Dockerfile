FROM eclipse-temurin:17.0.16_8-jre@sha256:3579917f5d48055c2d88b302b59dc809c28dcab8ba9bd8805446b5b46c0d9e49

WORKDIR /app

ENV JAVA_ENABLE_DEBUG=${JAVA_ENABLE_DEBUG}
ENV JAR=devops-knowledge-share-api.jar

COPY entrypoint.sh .
COPY ./build/libs/${JAR} .

RUN groupadd --system appuser -g 1001 && \
    useradd --system -g appuser -u 1001 appuser && \
    mkdir -p /app/data && \
    chown -R appuser:appuser /app && \
    chown appuser:appuser ${JAR} && \
    chmod 500 ${JAR}

EXPOSE 8080
USER 1001

CMD ["./entrypoint.sh"]
