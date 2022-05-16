package helpers;

import com.github.javafaker.Faker;
import net.minidev.json.JSONObject;

public class DataGenerate {
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
     public static String getRandomEmail(){
        Faker faker = new Faker();
        String email = faker.name().firstName().toLowerCase() + faker.random().nextInt(0,100)+"@test.com"; 
        return email;
     }
     public static String getRandomUsername(){
        Faker faker = new Faker();
        String username = faker.name().username(); 
        return username;
     }
     public static JSONObject randomComment(){
      Faker faker = new Faker();
      JSONObject data = new JSONObject();
      String comment = faker.hobbit().quote();
      data.put("body", comment);
      return data;
  }
}
