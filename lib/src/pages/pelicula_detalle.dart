import 'package:flutter/material.dart';
import 'package:peliculas/src/models/actor_model.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';

class PeliculaDetalle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final Pelicula fPelicula = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _crearAppbar(fPelicula),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: 10,),
                _posterTituloPelicula(context,fPelicula),
                _descripcionPelicula(context,fPelicula),
                _pageViewActores(fPelicula)
              ]
            )
          )
        ],
      )
    );
  }

  Widget _crearAppbar(Pelicula fPelicula) {
    return SliverAppBar(

      elevation: 2,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          fPelicula.title,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        background: FadeInImage(
          image: NetworkImage(fPelicula.getBackgroundImg()),
          placeholder: AssetImage('assets/img/loading.gif'),
          fadeInDuration: Duration(milliseconds: 150),
          fit: BoxFit.cover,
        )
        
      ),

    );
  }

  Widget _posterTituloPelicula(BuildContext context,Pelicula fPelicula) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          
          Hero(
            tag: fPelicula.uniqueId,
            child: ClipRRect( //sirve para dar bordes redondeados
              borderRadius: BorderRadius.circular(20),
              child : Image(
                image: NetworkImage(fPelicula.getPosterImg()),
                height: 150,
              ),
            ),
          ),
          SizedBox(width: 10,),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(fPelicula.title, style: Theme.of(context).textTheme.headline6, overflow: TextOverflow.ellipsis,),
                Text(fPelicula.originalTitle, style: Theme.of(context).textTheme.subtitle1, overflow: TextOverflow.ellipsis),
                Row(
                  children: [
                    Icon(Icons.star_border),
                    Text(fPelicula.voteAverage.toString(), style: Theme.of(context).textTheme.subtitle1),
                  ],
                )
              ],
            ),
          
          )
        ],
      ),
    );
  }

  Widget _descripcionPelicula(BuildContext context,Pelicula fPelicula) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal:10, vertical:20),
      child: Text(fPelicula.overview, style:Theme.of(context).textTheme.bodyText2,textAlign: TextAlign.justify,),
    );
  }

  Widget _pageViewActores(Pelicula fPelicula) {
    final peliculaProvider = new PeliculasProvider();

    

    return FutureBuilder(
      future: peliculaProvider.getCast(fPelicula.id.toString()),
      
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData){
          return _crearPageViewActores(snapshot.data);
        }else{
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearPageViewActores(List<Actor> fListaActores) {

    return SizedBox(
      height: 200,
      child: PageView.builder(
        pageSnapping: false,
        controller: PageController(
          viewportFraction: 0.3,
          initialPage: 1
        ),
        itemCount: fListaActores.length,
        itemBuilder: (context,i){
          return _actorTarjeta(context,fListaActores[i]);
        }
      ,),
    );
  }


  Widget _actorTarjeta(BuildContext context,Actor fActor){
    final tarjeta =  Container(
      child: Column(
        children: [
          Hero(
            tag:fActor.id,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                image: NetworkImage(fActor.getActorImg()),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                height: 150,
                fit:BoxFit.cover,
              ),
            ),
          ),
          Text(
            fActor.name,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
    return GestureDetector(
      child: tarjeta,
      onTap: (){
        Navigator.pushNamed(context, 'actorDetalle',arguments: fActor);
      },
    );
  }
}