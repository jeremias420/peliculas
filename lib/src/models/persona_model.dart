class Persona {
  bool adult;
  List<dynamic> alsoKnownAs;
  String biography;
  String birthday;
  dynamic deathday;
  int gender;
  dynamic homepage;
  int id;
  String imdbId;
  String knownForDepartment;
  String name;
  String placeOfBirth;
  double popularity;
  String profilePath;

  Persona({
    this.adult,
    this.alsoKnownAs,
    this.biography,
    this.birthday,
    this.deathday,
    this.gender,
    this.homepage,
    this.id,
    this.imdbId,
    this.knownForDepartment,
    this.name,
    this.placeOfBirth,
    this.popularity,
    this.profilePath,
  });

  
  Persona.fromJsonMap(Map<String,dynamic>fJsonMap){

    adult              = fJsonMap['adult'];
    alsoKnownAs        = fJsonMap['also_known_as'];
    biography          = fJsonMap['biography'];
    birthday           = fJsonMap['birthday'];
    deathday           = fJsonMap['deathday'];
    gender             = fJsonMap['gender'];
    homepage           = fJsonMap['homepage'];
    id                 = fJsonMap['id'];
    imdbId             = fJsonMap['imdb_id'];
    knownForDepartment = fJsonMap['known_for_Department'];
    name               = fJsonMap['name'];
    placeOfBirth       = fJsonMap['place_of_birth'];
    popularity         = fJsonMap['popularity'];
    profilePath        = fJsonMap['profile_path'];

  }

  
  getPersonaImg(){
    if (profilePath == null){
      return 'https://st3.depositphotos.com/4111759/13425/v/600/depositphotos_134255710-stock-illustration-avatar-vector-male-profile-gray.jpg';
    }else {
      return 'https://image.tmdb.org/t/p/w500/$profilePath';
    }
  }
}
