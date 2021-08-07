import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class MovieHorizontal extends StatelessWidget {

  final List<Pelicula> peliculas;
  final Function siguientePagina;

  MovieHorizontal({@required this.peliculas, @required this.siguientePagina});

  final _pageController = new PageController(
    initialPage: 1,
    viewportFraction: 0.3
  );

  @override
  Widget build(BuildContext context) {

    final _screnSize = MediaQuery.of(context).size ; //obtener el tamaño de la pantalla

    _pageController.addListener(() {
      
      if(_pageController.position.pixels >= _pageController.position.maxScrollExtent - 200){
        //cargar siguiente pagina de peliculas
        siguientePagina();
        // print('cargar peliculas');
      }

    });

    return Container(
      height: _screnSize.height * 0.2,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        // children: _tarjetas(context),
        itemCount: peliculas.length,
        itemBuilder: (context,i) => _tarjeta(context,peliculas[i])
      )
    );
  }

  Widget _tarjeta(BuildContext context, Pelicula fPelicula){
    
    fPelicula.uniqueId = '${fPelicula.id}-poster';

    final fTarjeta =  Container(
      margin: EdgeInsets.only(right: 15),
      child: Column(
        children: [
          Hero(
            tag: fPelicula.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: AssetImage('assets/img/no-image.jpg'), 
                image: NetworkImage(fPelicula.getPosterImg()),
                fit: BoxFit.cover,
                height: 120,
              ),
            ),
          ),
          SizedBox(height: 5,),
          Text(
            fPelicula.title, 
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          )
        ],
      ),
    );

    return GestureDetector(
      child: fTarjeta,
      onTap: (){
        Navigator.pushNamed(context, 'peliculaDetalle',arguments: fPelicula);
      },

    );
  }

  // List<Widget> _tarjetas(BuildContext context) {

  //   return peliculas.map((fPelicula) {

  //       return Container(
  //         margin: EdgeInsets.only(right: 15),
  //         child: Column(
  //           children: [
  //             ClipRRect(
  //               borderRadius: BorderRadius.circular(20),
  //               child: FadeInImage(
  //                 placeholder: AssetImage('assets/img/no-image.jpg'), 
  //                 image: NetworkImage(fPelicula.getPosterImg()),
  //                 fit: BoxFit.cover,
  //                 height: 120,
  //               ),
  //             ),
  //             SizedBox(height: 5,),
  //             Text(
  //               fPelicula.title, 
  //               overflow: TextOverflow.ellipsis,
  //               style: Theme.of(context).textTheme.caption,
  //             )
  //           ],
  //         ),
  //       );
  //   }).toList();

  // }
}