package utils;

import io.restassured.RestAssured;
import io.restassured.http.ContentType;
import io.restassured.response.Response;
import net.serenitybdd.rest.SerenityRest;


public class APIOperations {
    public static Response post(String endpoint, String body) {
        return SerenityRest.given()
                .header("Content-Type", ContentType.JSON)
                .body(body)
                .post(endpoint);
    }
}
