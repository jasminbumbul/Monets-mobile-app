# Monets mobile app

Monets is a restaurant where the employees are using the desktop app for user overview, food and menu creation and ect., while the mobile app is used by the restaurants clients and  they can create reservations, add foods to reservations, pay thorugh the app, choose a table and time and similar.

## Link to desktop app and web api
```
https://github.com/jasminbumbul/Monets-RS2_Seminarski
```
## FLUTTER APP LAUNCHING

App is configured to be run over an emulator.
To run the app on a real device, change root url in Constants.dart file to your IP address.

## FLUTTER APP LAUNCHING

Withing the folder where the project is located, enter the following commands on the CMD:<br/>
-flutter pub get


-flutter run


Note: Make sure you have an emulator running

## API LAUNCHING

1. Clone repository<br/>

2. Install docker<br/>

3. Within the folder where the project is located, enter the following commands on the CMD:<br/>

- docker-compose build

- docker-compose up

 4. After docker is complete, open in browser: http://localhost:5010/swagger

To use the payment service inside the app, you can use these test parameters:
email: sb-whhsh14275735@personal.example.com
password: j3?67+E+

## Login credentials:
**Desktop**<br/>
```
Username: desktop
Password: test
```

**Mobile**<br/>
```
Username: mobile
Password: test
```
----------------------------------------------------------------------------------------------------------------------
*All credentials*<br/><br/>
**Desktop**<br/>
```
Username: uposlenik1, uposlenik2, uposlenik3, uposlenik4
Password: test
```

**Mobile**<br/>
```
Username: klijent1, klijent2, klijent3, klijent4, klijent5
Password: test
```


The whole project consists of three parts:
  *Web API - backend created using ASP.Net
  *Desktop app - created using Windows Forms
  *Mobile app - created using Flutter



