enum AgeCohort { gentJove, gentGran }

class Age {
  final AgeCohort ageCohort;

  Age(this.ageCohort);

  String getAgeLabel() {
    switch (ageCohort) {
      case AgeCohort.gentJove:
        return 'jove';
      case AgeCohort.gentGran:
        return 'gran';
      default:
        throw Error;
    }
  }
}

class Question {
  late int id;
  late String pregunta;
  late List<String> respostes;
  late int indexCorrecte;

  Question(this.id, this.pregunta, this.respostes, this.indexCorrecte);

  Question.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int;
    pregunta = json['pregunta'] as String;
    respostes = json['respostes'] as List<String>;
    indexCorrecte = json['indexCorrecte'] as int;
  }
}
