package helpers;

import com.github.javafaker.Faker;

import net.minidev.json.JSONObject;

public class DataGenerate{

public static JSONObject getRandomArticleValues(){

Faker faker = new Faker();
String title = faker.gameOfThrones().character();
String description = faker.gameOfThrones().city();
String body = faker.gameOfThrones().quote();
JSONObject json = new JSONObject();
json.put("title",title);
json.put("description",description);
json.put("body",body);
return json;

}

}