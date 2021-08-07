import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';

class peliculaSearch extends SearchDelegate{

  String seleccion = '';
  final peliculasProvider = new PeliculasProvider();

  @override

  List<Widget> buildActions(BuildContext context) {
    // son las acciones de nuestro appbar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: (){
          query = '';
        }
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // icono a la izquierda del appbar
    return IconButton(
      icon: AnimatedIcon(
        progress: transitionAnimation,
        icon: AnimatedIcons.menu_arrow
      ),
      onPressed: (){
        close(context, null);
      }
    
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    //crea los resultados de la busqueda que se van a mostrar
    return Center(
      child: Container(
        height: 100,
        width: 100,
        color:Colors.blueAccent,
        child: Text(seleccion),
      ),
    );
  }
  @override
  Widget buildSuggestions(BuildContext context) {
    // son las sugerencias que aparecen mientras el usuario escribe
    if (query.isEmpty){
      return Container();
    }

    return FutureBuilder(
      future: peliculasProvider.buscarPelicula(query),
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
        if (snapshot.hasData){

          final peliculas =snapshot.data;

          return ListView(
            children: peliculas.map((p){
              return ListTile(
                leading: FadeInImage(
                  image:NetworkImage(p.getPosterImg()),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  width: 50,
                  fit:BoxFit.contain
                ),
                title: Text(p.title),
                subtitle: Text(p.originalTitle),
                onTap: (){
                  close(context, null);
                  p.uniqueId= '';
                  Navigator.pushNamed(context, 'peliculaDetalle',arguments: p);
                },
              );
            }).toList()
          );

        }else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        
      },
    );


  }




  // @override
  // Widget buildSuggestions(BuildContext context) {
    //son las sugerencias que aparecen mientras el usuario escribe

  //   final listaSugerida = (query.isEmpty) ? peliculasRecientes : pelicuas.where((p)=>p.toLowerCase().starsWith(query.toLowerCase())).toList();

  //   return ListView.builder(
  //     itemCount: listaSugerida.length,
  //     itemBuilder: (contex,i){
  //       return ListTile(
  //         leading: Icon(Icons.movie),
  //         title: Text(listaSugerida[i]),
  //         onTap: (){ 
  //           seleccion = listaSugerida[i];
  //           showResults(context);
  //         },
  //       );

  //     }
  //   );
  // }

  

}