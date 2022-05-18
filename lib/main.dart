import 'package:app_delivery_flutter/src/pages/bajo/main/bajo_main_page.dart';
import 'package:app_delivery_flutter/src/pages/imc/calculate/imc_calculate_page.dart';
import 'package:app_delivery_flutter/src/pages/login/login_page.dart';
import 'package:app_delivery_flutter/src/pages/normal/main/normal_main_page.dart';
import 'package:app_delivery_flutter/src/pages/obesidad/main/obesidad_main_page.dart';
import 'package:app_delivery_flutter/src/pages/register/register_page.dart';
import 'package:app_delivery_flutter/src/pages/sobre/main/sobre_main_page.dart';
import 'package:app_delivery_flutter/src/utils/utils_colors.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IMC Calc App',
      //ocultar bandera de debug
      debugShowCheckedModeBanner: false,
      //ruta  inicial, puede ser home o login, etc.
      initialRoute: 'login',
      //routes para mapear dónde están las pages
      routes: {
        //page de login
        'login': (BuildContext context) => LoginPage(),
        //page de registro
        'register': (BuildContext context) => RegisterPage(),
        //ruta de roles
        'calculate': (BuildContext context) => ImcCalculatePage(),
        'bajo/main': (BuildContext context) => UserBajoMainPage(),
        'normal/main': (BuildContext context) => NormalMainPage(),
        'sobre/main': (BuildContext context) => SobreMainPage(),
        'obesidad/main': (BuildContext context) => ObesidadMainPage(),
      },
      theme: ThemeData(
        colorScheme: ColorScheme.light(primary: UtilsColors.primaryColor),
        //fontFamily: 'NimbusSans'
      ),
    );
  }
}
