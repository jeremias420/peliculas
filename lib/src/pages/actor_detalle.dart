import 'package:flutter/material.dart';
import 'package:peliculas/src/models/actor_model.dart';
import 'package:peliculas/src/models/persona_model.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';

class ActorDetalle extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final peliculaProvider = new PeliculasProvider();

    final Actor fActor = ModalRoute.of(context).settings.arguments;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(fActor.name),
      ),
      body: ListView(
        children:[ 
          FutureBuilder(
            future: peliculaProvider.getPersonaActor(fActor.id.toString()),
            
            builder: (BuildContext context, AsyncSnapshot<Persona> snapshot) {
              if (snapshot.hasData){
                return _crearDetalle(context,snapshot.data);
              }else{
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ]
      ),
      
    );
    
  }

  Widget _crearDetalle(BuildContext context,Persona fPersona) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal:10, vertical:20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Hero(
                tag:fPersona.id,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image(
                    image: NetworkImage(fPersona.getPersonaImg()),
                    height: 180,
                  ),
                ),
              ),
              SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(fPersona.name, style: Theme.of(context).textTheme.headline6, overflow: TextOverflow.ellipsis,),
                  Text('Nacimiento:'+ fPersona.birthday, style: Theme.of(context).textTheme.subtitle1, overflow: TextOverflow.ellipsis,),
                ],
              )
              
            ],
          ),
          SizedBox(height: 10),
          Text('Bibliografia', style:Theme.of(context).textTheme.subtitle2),          
          Text(fPersona.biography, style:Theme.of(context).textTheme.bodyText2,textAlign: TextAlign.justify,),
        ] 
      )
    );

  }
}