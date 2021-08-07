import 'dart:async';
import 'dart:convert';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/models/actor_model.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/src/models/persona_model.dart';

class PeliculasProvider{
  String _apiKey = '15db81cc185e0a851eaed0b78a584902';
  String _url = 'api.themoviedb.org';
  String _languaje = 'es-ES';

  int _popularesPage = 0;
  bool _cargando = false;

  List<Pelicula> _populares = <Pelicula>[];

  final _popularesStreamController = StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get popularesSink => _popularesStreamController.sink.add;

  Stream<List<Pelicula>> get popularesStream =>_popularesStreamController.stream;


  void disposeStreams(){
    _popularesStreamController?.close();
  }

  Future<List<Pelicula>>_procesarRespuestaHttp(Uri furl) async{
    final respuestaHttp = await http.get(furl);
    final decodedRespuestaHttp = json.decode(respuestaHttp.body);
    final peliculas = new Peliculas.fromJsonList(decodedRespuestaHttp['results']);
    return peliculas.listaPeliculas;
  }


  Future<List<Pelicula>>getEnCines() async{
    final url = Uri.https(_url, '3/movie/now_playing',{
      'api_key':_apiKey,
      'language':_languaje
    });
    return await _procesarRespuestaHttp(url);
  }


  Future<List<Pelicula>>getPopulares() async{
    if (_cargando) {return [];} 
    else {_cargando = true;}
    
    _popularesPage++;

    final url = Uri.https(_url, '3/movie/popular',{
      'api_key':_apiKey,
      'language':_languaje,
      'page':_popularesPage.toString()
    });

    final respuestaHttp = await _procesarRespuestaHttp(url);

    _populares.addAll(respuestaHttp);
    popularesSink(_populares);

    _cargando = false;
    return respuestaHttp;
  }

  Future<List<Actor>> getCast(String fPeliculaID) async{

    //genero la url con la clase Uri para enviar los parametros 
    final url = Uri.http(_url, '3/movie/$fPeliculaID/credits',{
      'api_key':_apiKey,
      'language':_languaje,
    });

    //hago un get url (http get)
    final respuestaHttp = await http.get(url);

    //transformo el la respuesta aun json
    final respuestaJson = json.decode(respuestaHttp.body);

    //llamo al constructor de actores con la respuesta para que genere la lista
    final actores = Actores.fromJsonList(respuestaJson['cast']);

    //retorno la lista de actores
    return actores.listaActores;

  }

  
  Future<List<Pelicula>>buscarPelicula(String query) async{
    final url = Uri.https(_url, '3/search/movie',{
      'api_key':_apiKey,
      'language':_languaje,
      'query':query
    });
    return await _procesarRespuestaHttp(url);
  }

    
  Future<Persona>getPersonaActor(String fActorId) async{
    
    //genero la url con la clase Uri para enviar los parametros 
    final url = Uri.http(_url, '3/person/$fActorId',{
      'api_key':_apiKey,
      'language':_languaje,
    });

    //hago un get url (http get)
    final aRespuestaHttp = await http.get(url);

    //transformo el la respuesta aun json
    final aRespuestaJson = json.decode(aRespuestaHttp.body);

    //llamo al constructor de actores con la respuesta para que genere el objeto
    final aPersona = Persona.fromJsonMap(aRespuestaJson);

    //retorno el objeto persona
    return aPersona;

  }

}//final