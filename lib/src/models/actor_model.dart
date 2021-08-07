class Actores{
  List<Actor>listaActores = <Actor>[];

  //creo el constructor de la clase vacio nomas
  Actores();

  //creo un constructor que sirva para cargar la lista de actores
  Actores.fromJsonList(List<dynamic> fListaJson){
    if(fListaJson == null) return;

    //recorro la lista y carto los actores en mi lista de actores
    for (var item in fListaJson) {
      final fActor = new Actor.fromJsonMap(item);
      listaActores.add(fActor);     
    }      
  }
}

class Actor {
  bool adult;
  int gender;
  int id;
  String knownForDepartment;
  String name;
  String originalName;
  double popularity;
  String profilePath;
  int castId;
  String character;
  String creditId;
  int order;
  String department;
  String job;

  Actor({
    this.adult,
    this.gender,
    this.id,
    this.knownForDepartment,
    this.name,
    this.originalName,
    this.popularity,
    this.profilePath,
    this.castId,
    this.character,
    this.creditId,
    this.order,
    this.department,
    this.job,
  });

  Actor.fromJsonMap(Map<String,dynamic>fJsonMap){

    adult               = fJsonMap['adult'];
    gender              = fJsonMap['gender'];
    id                  = fJsonMap['id'];
    knownForDepartment  = fJsonMap['known_for_department'];
    name                = fJsonMap['name'];
    originalName        = fJsonMap['original_name'];
    popularity          = fJsonMap['popularity'];
    profilePath         = fJsonMap['profile_path'];
    castId              = fJsonMap['cast_id'];
    character           = fJsonMap['character'];
    creditId            = fJsonMap['credit_id'];
    order               = fJsonMap['order'];
    department          = fJsonMap['department'];
    job                 = fJsonMap['job'];

  }

  getActorImg(){
    if (profilePath == null){
      return 'https://st3.depositphotos.com/4111759/13425/v/600/depositphotos_134255710-stock-illustration-avatar-vector-male-profile-gray.jpg';
    }else {
      return 'https://image.tmdb.org/t/p/w500/$profilePath';
    }
  }
}
