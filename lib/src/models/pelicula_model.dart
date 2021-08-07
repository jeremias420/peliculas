class Peliculas{

  // List<Pelicula> listaPelicula = new List();
   List<Pelicula> listaPeliculas = <Pelicula>[];

  Peliculas();

  Peliculas.fromJsonList(List<dynamic> flista){

    if(flista == null){
      return;
    }

    for(var item in flista){
      final pelicula = new Pelicula.fromJsonMap(item);
      listaPeliculas.add(pelicula);
    
    }

  }

}

class Pelicula {
  String uniqueId;

  bool adult;
  String backdropPath;
  List<int> genreIds;
  int id;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  String releaseDate;
  String title;
  bool video;
  double voteAverage;
  int voteCount;

  Pelicula({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  Pelicula.fromJsonMap(Map<String, dynamic> fjsonMap){
    adult             = fjsonMap['adult'];
    backdropPath      = fjsonMap['backdrop_path'];
    genreIds          = fjsonMap['genre_ids'].cast<int>();
    id                = fjsonMap['id'];
    originalLanguage  = fjsonMap['original_language'];
    originalTitle     = fjsonMap['original_title'];
    overview          = fjsonMap['overview'];
    popularity        = fjsonMap['popularity'] / 1;
    posterPath        = fjsonMap['poster_path'];
    releaseDate       = fjsonMap['release_date'];
    title             = fjsonMap['title'];
    video             = fjsonMap['video'];
    voteAverage       = fjsonMap['vote_average'] / 1;
    voteCount         = fjsonMap['vote_count'];
  }

   getPosterImg(){
    if (posterPath == null){
      return 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/495px-No-Image-Placeholder.svg.png';
    }else {
      return 'https://image.tmdb.org/t/p/w500/$posterPath';
    }
  }

  getBackgroundImg(){
    if (posterPath == null){
      return 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/495px-No-Image-Placeholder.svg.png';
    }else {
      return 'https://image.tmdb.org/t/p/w500/$backdropPath';
    }
  }
}


