import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class CardSwiper extends StatelessWidget {
  
  final List<Pelicula> listaPeliculas;

  CardSwiper({@required this.listaPeliculas});
  
  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;



    return Container(
      padding: EdgeInsets.only(top:10),     
      child: Swiper(        
        itemCount: listaPeliculas.length,
        // pagination: new SwiperPagination(),
        // control: new SwiperControl(),
        itemWidth: _screenSize.width * 0.7, //70% de la pantalla
        itemHeight: _screenSize.height * 0.55,//50% de la pantalla
        layout: SwiperLayout.STACK,//esto va por que lo necesita el swiper      

        //este builder hace un bucle dependiendo de la cantidad de items de itemCount.
        itemBuilder: (BuildContext context,int index){

          listaPeliculas[index].uniqueId = '${listaPeliculas[index].id}-tarjeta';

          return Hero(
            tag: listaPeliculas[index].uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: GestureDetector(
                onTap: ()=>Navigator.pushNamed(context, 'peliculaDetalle', arguments: listaPeliculas[index]),
                child: FadeInImage(
                  placeholder: AssetImage('assets/img/no-image.jpg'), 
                  image: NetworkImage(listaPeliculas[index].getPosterImg()),
                  fit: BoxFit.cover,//redondea mejor los bordes de las imagenes
                ),
              )
            ),
          );
        },        
        
      ),
    );
  }
}