import 'dart:ffi';

import 'package:app_delivery_flutter/src/models/medida.dart';
import 'package:app_delivery_flutter/src/models/response_api.dart';
import 'package:app_delivery_flutter/src/models/user.dart';
import 'package:app_delivery_flutter/src/provider/users_provider.dart';
import 'package:app_delivery_flutter/src/utils/utils_snackbar.dart';
import 'package:flutter/material.dart';

class RegisterController{
  //se agrega un ? indicando que puede ser nula la variable
  BuildContext context;
  TextEditingController emailCtrller = new TextEditingController();
  TextEditingController nameCtrller = new TextEditingController();
  TextEditingController lastnameCtrller = new TextEditingController();
  TextEditingController phoneCtrller = new TextEditingController();
  TextEditingController pwCtrller = new TextEditingController();
  TextEditingController confirmpwCtrller = new TextEditingController();
  //Controladores para detectar el texto escrito
  TextEditingController hCtrller = new TextEditingController();
  TextEditingController wCtrller = new TextEditingController();
  String idIMC = "";
  String imc_value = "";

  UsersProvider usersProvider = new UsersProvider();

  Future init(BuildContext context){
    this.context = context;
    usersProvider.init(context);
  }

  void register() async{
    String email = emailCtrller.text.trim();
    String name = nameCtrller.text;
    String lastname = lastnameCtrller.text;
    String phone = phoneCtrller.text.trim();
    String pw = pwCtrller.text.trim();
    String cpw = confirmpwCtrller.text.trim();
    String h = hCtrller.text.trim();
    String w = wCtrller.text.trim();


    //validar que no haya ningún campo vacío
    if(email.isEmpty || name.isEmpty || lastname.isEmpty || phone.isEmpty || pw.isEmpty || cpw.isEmpty || h.isEmpty || w.isEmpty){
      UtilsSnackbar.show(context, 'Debes ingresar todos los campos.');
      //se cancela ejecución
      return;
    }
    //validar contraseña
    if(pw != cpw){
      UtilsSnackbar.show(context, 'La contraseña y confirmación deben ser iguales.');
      //se cancela ejecución
      return;
    }


    //validar longitud de contraseña
    if(pw.length < 6){
      UtilsSnackbar.show(context, 'La contraseña debe tener al menos 6 caracteres.');
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

        if(18.5 <= imc_valor && imc_valor <=24.9) int_imc = 2;
        else if(25 <= imc_valor && imc_valor <= 29.9) int_imc = 3;
        else if(30 <= imc_valor) int_imc = 4;


        idIMC = int_imc.toString();
        imc_value = imc_valor.toStringAsFixed(2);



    }catch(e){
      UtilsSnackbar.show(context, 'Poner peso y/o altura válida.');
      return;
    }

    User user = new User(
      email: email,
      name: name,
      lastname: lastname,
      phone: phone,
      image: 'https://bit.ly/3sJZ3jI',
      password: pw,
    );

    //esperar respuesta del servidor al mandar la petición de crear un usuario
    ResponseApi responseApi = await usersProvider.create(user);

    if(responseApi == null){
      UtilsSnackbar.show(context, "Error al crear el usuario\nSi el problema persiste, contacte a servicio.");
    }
    else{

      //Si la respuesta es correcta, se agrega una función future para redirigir al login.
      //LA función tiene un delay de 2s
      if(responseApi.success){

        Medida med = new Medida(
          id_user: int.parse(responseApi?.data),
          id_imc: int.parse(idIMC),
          name: '',
          route: '',
          imc_value: imc_value,
        );

        ResponseApi responseApi2 = await usersProvider.addIMC(med);
        if(responseApi2 == null){
          UtilsSnackbar.show(context, "Error al registrar el IMC\nSi el problema persiste, contacte a servicio.");
        }
        else {
          if (responseApi2.success) {
            Future.delayed(Duration(seconds: 2), () {
              Navigator.pushReplacementNamed(context, 'login');
            });
          }
        }
      }

      print('RESPUESTA ${responseApi?.data}');
      UtilsSnackbar.show(context, responseApi.message);
    }

  }

  void back(){
    //recibe un contexto, para regresar a la pantalla anterior
    Navigator.pop(context);
  }

}