import 'package:appinventario/navbarscreens/codescanner.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'manualform.dart';
import 'codescanner.dart';

// Clase para crear y mantener en la interfaz la barra de navegación
void main() => runApp(MaterialApp(home: BottomNavBar()));

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

// Clase principal
class _BottomNavBarState extends State<BottomNavBar> {
  int pageIndex = 1;
  GlobalKey _bottomNavigationKey = GlobalKey();

  // Creacion de paginas
  final MyScanner _codigos = MyScanner();
  final DBTestPage _tablas = DBTestPage();

  Widget _menuprincipal = new MyScanner();

// Switch para al momento de cambiar hacia otro numero del contador, este cambia a otra pagina.
  Widget _selector(int page) {
    switch (page) {
      case 0:
        return _codigos;
        break;
      case 1:
        return _tablas;
        break;
      default:
        return _codigos;
    }
  }

// Override con el estilo de la barra de navegación
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: pageIndex,
          // Tamaño de la barra de navegación
          height: 50.0,
          // Opciones en la barra de navegación
          items: <Widget>[
            Icon(Icons.camera, size: 30, color: Colors.white),
            Icon(Icons.file_copy, size: 30, color: Colors.white),
          ],
          // Color para la barra de navegación
          color: Colors.indigo,
          // Color de fondo para cada botón
          buttonBackgroundColor: Colors.indigo,
          // Color de fondo
          backgroundColor: Colors.transparent,
          // Animación de movimiento
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          // Accion para cuando se pulse el boton principal.
          onTap: (int tappedIndex) {
            setState(() {
              _menuprincipal = _selector(tappedIndex);
            });
          },
        ),
        body: Container(
          color: Colors.transparent,
          child: Center(
            child: _menuprincipal,
          ),
        ));
  }
}
