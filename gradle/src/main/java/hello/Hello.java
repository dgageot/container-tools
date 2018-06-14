package hello;

import io.vertx.core.Vertx;

public class Hello {
    public static void main(String[] args) {
        Vertx.vertx()
            .createHttpServer()
            .requestHandler(routingContext -> {
                routingContext
                    .response()
                    .putHeader("content-type", "text/plain")
                    .end("Hello, World!");
            }).listen(8080);
    }
}
