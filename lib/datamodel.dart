class Question {
  Question(
      this.id, this.pregunta, this.respostes, this.indexCorrecte, this.day);

  late int id;
  late String pregunta;
  late List respostes;
  late int indexCorrecte;
  late String day;

  Question.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int;
    pregunta = json['pregunta'] as String;
    respostes = json['respostes'] as List;
    indexCorrecte = json['indexCorrecte'] as int;
    day = json['day'] as String;
  }
}

class Score {
  Score(this.preguntaId, this.indexSelectedAnswer, this.isValidAnswer);

  late int? preguntaId;
  late int? indexSelectedAnswer;
  late bool? isValidAnswer;
}
