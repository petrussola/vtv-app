enum AgeCohort { gentJove, gentGran }

class Age {
  final AgeCohort ageCohort;

  Age(this.ageCohort);

  AgeCohort getAgeCohort() {
    return ageCohort;
  }

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

class Quiz {
  
}

class Question {
  Question(this.id, this.pregunta, this.respostes, this.indexCorrecte);

  late int id;
  late String pregunta;
  late List respostes;
  late int indexCorrecte;

  Question.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int;
    pregunta = json['pregunta'] as String;
    respostes = json['respostes'] as List;
    indexCorrecte = json['indexCorrecte'] as int;
  }
}

class Score {
  Score(this.preguntaId, this.indexSelectedAnswer, this.isValidAnswer);

  late int preguntaId;
  late int indexSelectedAnswer;
  late bool isValidAnswer;
}
