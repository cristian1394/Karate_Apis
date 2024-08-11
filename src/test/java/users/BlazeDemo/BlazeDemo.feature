
Feature: Prueba_Karate

  # Background:

    @Microservicios

  Scenario:  Nuevo Usuario

    Given url 'https://api.demoblaze.com/signup'
    * header Accept = '*/*'
    * header Accept-Encoding = 'gzip, deflate, br, zstd'
    * header Accept-Language: = 'es-419,es;q=0.9'
    * header Access-Control-Request-Headers: = 'content-type'
    * def variableRandom = 'Usuario_' + java.lang.System.currentTimeMillis()
    When request { "username": #(variableRandom), "password": "password123" }
    And method POST
    Then status 200
    * print response


  Scenario:  Usuario Existente

    Given url 'https://api.demoblaze.com/signup'
    * header Accept = '*/*'
    * header Accept-Encoding = 'gzip, deflate, br, zstd'
    * header Accept-Language: = 'es-419,es;q=0.9'
    * header Access-Control-Request-Headers: = 'content-type'
    When request { "username": "Prueba", "password": "PruebaQa" }
    And method POST
    Then status 200
    And match response == {  "errorMessage": "This user already exist."}



  Scenario:  Password incorrecto

    Given url 'https://api.demoblaze.com/login'
    * header Accept = '*/*'
    * header Accept-Encoding = 'gzip, deflate, br, zstd'
    * header Accept-Language: = 'es-419,es;q=0.9'
    * header Access-Control-Request-Headers: = 'content-type'
    When request { "username": "Prueba", "password": #(variableRandom) }
    And method POST
    Then status 200
    And match response == {  "errorMessage": "Wrong password."}


  Scenario: Login correcto

    Given url 'https://api.demoblaze.com/login'
    * header Accept = '*/*'
    * header Accept-Encoding = 'gzip, deflate, br, zstd'
    * header Accept-Language = 'es-419,es;q=0.9'
    * header Access-Control-Request-Headers = 'content-type'
    When request { "username": "pruebasQA", "password": "cHJ1ZWJhMTIz" }
    And method POST
    Then status 200
    * print response
    And match response contains "Auth_token: "