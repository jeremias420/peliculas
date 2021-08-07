import 'package:flutter/material.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';
import 'package:peliculas/src/search/search_delegate.dart';
import 'package:peliculas/src/widgets/card_swiper_widget.dart';
import 'package:peliculas/src/widgets/movie_horizontal_widget.dart';


class HomePage extends StatelessWidget {
  // const name({Key? key}) : super(key: key);

  final peliculasProvider =new PeliculasProvider();

  @override
  Widget build(BuildContext context) {
    peliculasProvider.getPopulares();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Peliculas en cines'),
          backgroundColor: Colors.indigoAccent,
          actions: [
            IconButton(
              icon: Icon(Icons.search), 
              onPressed: (){
                showSearch(
                  context: context, 
                  delegate: peliculaSearch(),
                  // query:'hola'
                );
              }
            ),
          ],
        ),
        body:Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _swiperTarjetas(),
              _footer(context)
            ],
          ),
        )

      ),
    );
  }

  Widget _swiperTarjetas() {

    return FutureBuilder(
      future: peliculasProvider.getEnCines(),
      // initialData: InitialData,
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
         
        if(snapshot.hasData){
          return CardSwiper(listaPeliculas: snapshot.data);
        }else{
            return Container(
              height: 400,
              child: Center(
                child:CircularProgressIndicator()
              )
            );
        }
      },
    );
  }
  
  
  Widget _footer(BuildContext context){
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 20),
            child: Text('Populares', style: Theme.of(context).textTheme.subtitle1)
          ),
          SizedBox(height: 5),
          StreamBuilder(
            stream: peliculasProvider.popularesStream,
            
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if(snapshot.hasData){
                return MovieHorizontal(
                  peliculas: snapshot.data,
                  siguientePagina: peliculasProvider.getPopulares,
                );
              }else{
                return Center(child: CircularProgressIndicator());
              }
            },
          ),

        ],
      ),
    );
  }
}