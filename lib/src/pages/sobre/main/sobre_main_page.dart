import 'package:app_delivery_flutter/src/pages/sobre/main/sobre_main_controller.dart';
import 'package:app_delivery_flutter/src/utils/utils_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lottie/lottie.dart';

class SobreMainPage extends StatefulWidget {
  const SobreMainPage({Key key}) : super(key: key);

  @override
  _SobreMainPageState createState() => _SobreMainPageState();
}

class _SobreMainPageState extends State<SobreMainPage> {

  SobreMainController _con = new SobreMainController();

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
      key: _con.key,
      appBar: AppBar(
        //title: _showDrawer(),
        //leading para mostrar el nuestro y no el por defecto
        leading: _showDrawer(),
      ),
      drawer: _drawer(),
      body: Center(

        child:
        Stack(
          children: [

            SingleChildScrollView(
              child: Column(
                children: [
                  _LottieAnimLogin(),
                  ElevatedButton(
                    onPressed: _con.goToCalculatePage,
                    child: Text('Calcular nuevo IMC'),
                  ),
                ],
              ),
            ),
            Positioned(
              child: _txtBajoPeso(),
              top: 0,
              left: 50,
            ),
          ],
        ),

      ),
    );
  }


  Widget _txtBajoPeso(){
    return Text(
      'IMC. Sobrepeso',
      //agregar estilos al texto
      style: TextStyle(
          color: UtilsColors.primaryColorDark,
          fontWeight: FontWeight.bold,
          fontSize: 22,
          fontFamily: 'NimbusSans'
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
          'assets/json/2.json',
          width: 250,
          height: 200,
          fit: BoxFit.fill
      ),
    );
  }

  Widget _showDrawer(){
    return GestureDetector(
      onTap: _con.openDrawer,
      child: Container(
        margin: EdgeInsets.only(left: 20),
        alignment: Alignment.centerLeft,
        child:
        Image.asset('assets/img/menu.png', width: 20, height: 20,),
      ),
    );
  }

  Widget _drawer(){
    return Drawer(
      //Es una columna pero permite scroll
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            //agregar estilos
              decoration: BoxDecoration(
                color: UtilsColors.primaryColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${_con.user?.name ?? ''} ${_con.user?.lastname ?? ''}',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),
                    //No puede abarcar más de una línea
                    maxLines: 1,
                  ),
                  Text('${_con.user?.email ?? ''} ',
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[100],
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic
                    ),
                    //No puede abarcar más de una línea
                    maxLines: 1,
                  ),
                  Text('${_con.user?.phone ?? ''} ',
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[100],
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic
                    ),
                    //No puede abarcar más de una línea
                    maxLines: 1,
                  ),
                  Container(
                    height: 60,
                    margin: EdgeInsets.only(top: 10),
                    child: FadeInImage(
                      image: _con.user.image != null ? NetworkImage(_con.user?.image)
                          : AssetImage('assets/img/no-image.png'),
                      fit: BoxFit.contain,
                      fadeInDuration: Duration(milliseconds: 50),
                      placeholder: AssetImage('assets/img/no-image.png'),
                    ),
                  )
                ],
              )
          ),
          ListTile(
            onTap: _con.logout,
            title: Text('Cerrar sesión'),
            trailing: Icon(Icons.power_settings_new),
          )
        ],
      ),
    );
  }


  void refresh(){
    setState(() {

    });
  }
}
