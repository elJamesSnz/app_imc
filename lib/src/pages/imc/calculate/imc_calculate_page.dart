import 'package:app_delivery_flutter/src/pages/imc/calculate/imc_calculate_controller.dart';
import 'package:app_delivery_flutter/src/utils/utils_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lottie/lottie.dart';

class ImcCalculatePage extends StatefulWidget {
  const ImcCalculatePage({Key key}) : super(key: key);

  @override
  _ImcCalculatePageState createState() => _ImcCalculatePageState();
}

class _ImcCalculatePageState extends State<ImcCalculatePage> {

  ImcCalculateController _con = new ImcCalculateController();

  //se sobreescribe el método init
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //se inicializa el controlador de cliet list products
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(

        child:
        Stack(
          children: [

            SingleChildScrollView(
              child: Column(
                children: [
                  _LottieAnimLogin(),
                  _txtAltura(),
                  _txtpeso(),
                  ElevatedButton(
                    onPressed: _con.calculateIMC,
                    child: Text('Calcular nuevo IMC'),
                  ),
                  ElevatedButton(
                    onPressed: _con.logout,
                    child: Text('Cerrar sesión'),
                  ),
                ],
              ),
            ),
            Positioned(
              child: _txtCalculaPeso(),
              top: 0,
              left: 130,
            ),
          ],
        ),

      ),
    );
  }

  //widget campo altura
  Widget _txtAltura(){
    return Container(
      //márgenes a los espacios horizontales
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      //agregar decoraciones al container como color, forma, etc

      decoration: BoxDecoration(
        //color del box
        color: UtilsColors.primaryOpacityColor,
        //radio del box
        borderRadius: BorderRadius.circular(30),


      ),
      child: TextField(
        //Controlador de height
        controller: _con.hCtrller,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
            hintText: 'Altura en cms',
            //quitamos línea inferior
            border: InputBorder.none,
            //agregamos espacio para que no esté pegado al borde
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(
                color: UtilsColors.primaryColorDark
            ),
            prefixIcon: Icon(
              Icons.height,
              color: UtilsColors.primaryColor,
            )
        ),
      ),
    );
  }

//widget campo peso
  Widget _txtpeso(){
    return Container(
      //márgenes a los espacios horizontales
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      //agregar decoraciones al container como color, forma, etc
      decoration: BoxDecoration(
        //color del box
        color: UtilsColors.primaryOpacityColor,
        //radio del box
        borderRadius: BorderRadius.circular(30),


      ),
      child: TextField(
        //Controlador de weight
        controller: _con.wCtrller,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
            hintText: 'Peso en gr',
            //quitamos línea inferior
            border: InputBorder.none,
            //agregamos espacio para que no esté pegado al borde
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(
                color: UtilsColors.primaryColorDark
            ),
            prefixIcon: Icon(
              Icons.line_weight,
              color: UtilsColors.primaryColor,
            )
        ),
      ),
    );
  }

  //widget animación
  Widget _LottieAnimLogin(){
    return Container(
      //agregar margen
      margin: EdgeInsets.only(
          top: 20,
          bottom: MediaQuery.of(context).size.height * .05
      ),
      //se recupera asset
      child: Lottie.asset(
          'assets/json/calc.json',
          width: 250,
          height: 200,
          fit: BoxFit.fill
      ),
    );
  }

  Widget _txtCalculaPeso(){
    return Text(
      'Calcular IMC',
      //agregar estilos al texto
      style: TextStyle(
          color: UtilsColors.primaryColorDark,
          fontWeight: FontWeight.bold,
          fontSize: 22,
          fontFamily: 'NimbusSans'
      ),
    );
  }

  void refresh(){
    setState(() {

    });
  }

}



/*

class _CalculatePageState extends State<CalculatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("IMC calcualte Page"),
      ),
    );
  }







}
*/