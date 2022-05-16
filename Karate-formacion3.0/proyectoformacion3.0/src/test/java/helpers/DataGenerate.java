package helpers;

import com.github.javafaker.Faker;
import com.ibm.icu.text.CaseMap.Title;

import net.minidev.json.JSONObject;

public class DataGenerate {

    public static String getRamdonEmail(){
        Faker faker = new Faker();
        String email = faker.name().firstName().toLowerCase() + faker.random().nextInt(0,100) +"@test.com";
        return email;
    }
    public static String getRamdonUsername(){
        Faker faker = new Faker();
        String Username = faker.name().username();
        return Username;
    }

    public static JSONObject getRandomArticleValues(){

        Faker faker = new Faker();
        String title = faker.superhero().name();
        String description = faker.gameOfThrones().city();
        String body = faker.gameOfThrones().quote();
        JSONObject json = new JSONObject();

        json.put("title",title);
        json.put("description",description);
        json.put("body",body);
        return json;
    }
    
}
