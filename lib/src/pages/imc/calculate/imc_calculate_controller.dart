import 'package:app_delivery_flutter/src/models/medida.dart';
import 'package:app_delivery_flutter/src/models/response_api.dart';
import 'package:app_delivery_flutter/src/models/user.dart';
import 'package:app_delivery_flutter/src/provider/users_provider.dart';
import 'package:app_delivery_flutter/src/utils/utils_sharedpref.dart';
import 'package:app_delivery_flutter/src/utils/utils_snackbar.dart';
import 'package:flutter/material.dart';

class ImcCalculateController{
  BuildContext context;
  UtilsSharedpref _sharedPref = new UtilsSharedpref();
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  //Controladores para detectar el texto escrito
  TextEditingController hCtrller = new TextEditingController();
  TextEditingController wCtrller = new TextEditingController();
  Function refresh;
  User user;

  UtilsSharedpref _sharedpref = new UtilsSharedpref();
  String idIMC = "";
  String imc_value = "";
  String route = "bajo/main";

  UsersProvider usersProvider = new UsersProvider();

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

  void calculateIMC() async{

    String h = hCtrller.text.trim();
    String w = wCtrller.text.trim();


    //validar que no haya ningún campo vacío
    if(h.isEmpty || w.isEmpty){
      UtilsSnackbar.show(context, 'Debes ingresar todos los campos.');
      //se cancela ejecución
      return;
    }

    try{
      double peso = double.parse(w);
      double altura = double.parse(h);

      peso = peso/1000;
      altura = altura/100;

      double imc_valor = (peso / (altura*altura));

      int int_imc=1;

      if(18.5 <= imc_valor && imc_valor <=24.9)
        {
          int_imc = 2;
          route = "normal/main";
        }
      else if(25 <= imc_valor && imc_valor <= 29.9){
        int_imc = 3;
        route = "sobre/main";
      }
      else if(30 <= imc_valor){
        int_imc = 4;
        route = "obesidad/main";
      }

      idIMC = int_imc.toString();
      imc_value = imc_valor.toStringAsFixed(2);



    }catch(e){
      UtilsSnackbar.show(context, 'Poner peso y/o altura válida.');
      return;
    }

    //esperar respuesta del servidor al mandar la petición de crear un usuario
    Medida med = new Medida(
      //para tests dejamos el 1
      id_user: int.parse(user.id),
      id_imc: int.parse(idIMC),
      name: '',
      route: '',
      imc_value: imc_value,
    );

    ResponseApi responseApi = await usersProvider.addIMC(med);
    if(responseApi == null){
      UtilsSnackbar.show(context, "Error al registrar el IMC\nSi el problema persiste, contacte a servicio.");
      Future.delayed(Duration(seconds: 2), () {
        Navigator.pushReplacementNamed(context, route);
      });
    }
    else {
      if (responseApi.success) {
        Future.delayed(Duration(seconds: 2), () {
          UtilsSnackbar.show(context, "IMC guardado");
          Navigator.pushReplacementNamed(context, route);
        });
      }
    }
  }
}