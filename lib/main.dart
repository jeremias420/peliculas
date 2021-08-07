import 'package:flutter/material.dart';
import 'package:peliculas/src/pages/actor_detalle.dart';
import 'package:peliculas/src/pages/home_page.dart';
import 'package:peliculas/src/pages/pelicula_detalle.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Peliculas',
      initialRoute: '/',
      routes: {
          '/':(BuildContext context) => HomePage(),
          'peliculaDetalle':(BuildContext context) => PeliculaDetalle(),
          'actorDetalle':(BuildContext context) => ActorDetalle(),
      },      
    );
  }
}