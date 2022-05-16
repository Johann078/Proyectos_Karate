function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    apiUrl: 'https://api.realworld.io/api/'
  }
  if (env == 'dev') {
    config.userEmail ='testjohan@test.com',
    config.userPassword = 'karate123'
  } else if (env == 'qa') {
    // customize
  }
  return config;
}