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
    config.userEmail ='jarv078@gmail.com',
    config.userPassword = '123qwe'
    // customize
    // e.g. config.foo = 'bar';
  } else if (env == 'prod') {
    
    // customize
  }
  return config;
}