import 'package:app_delivery_flutter/src/models/user.dart';
import 'package:app_delivery_flutter/src/utils/utils_sharedpref.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SobreMainController{
  BuildContext context;
  UtilsSharedpref _sharedPref = new UtilsSharedpref();
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  Function refresh;

  User user;



  //se hace un buildconetxt y le pasamos el contexto de la aplicación
  Future init(BuildContext context, Function refresh) async{
    this.context = context;
    this.refresh = refresh;
    user = User.fromJson(await _sharedPref.read('user'));
    refresh();
  }

  void logout(){
    //se envía la petición de logput con el contexto de la app
    _sharedPref.logout(context);
  }

  //método para hacer cambio de page a través de un controlador
  void goToCalculatePage(){
    Navigator.pushNamed(context, 'calculate');
  }

  void openDrawer(){
    key.currentState.openDrawer();
  }
}