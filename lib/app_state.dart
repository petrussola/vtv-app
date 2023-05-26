import 'package:flutter/material.dart';
import 'package:vtv_app/datamanager.dart';
import 'package:vtv_app/datamodel.dart';

const maxNumberOfQuestions = 5;
const day = "tomorrow";

class AppState extends ChangeNotifier {
  List<Question> questionsList = [];
  int indexCurrentQuestion = 0;
  int? currentQuestionSelectedResponseIndex;
  List<Score> answerTrackingList = List<Score>.filled(
    maxNumberOfQuestions,
    Score(null, null, null),
    growable: false,
  );

  Future<List<Question>> loadPreguntes() {
    return DataManager.loadQuiz();
  }

  List<Question> getCurrentListPreguntes() {
    return questionsList;
  }

  void setListQuestions(List<Question> data) {
    questionsList = data;
  }

  Question getPreguntaActual() {
    return questionsList[indexCurrentQuestion];
  }

  int getPreguntaActualId() {
    return questionsList[indexCurrentQuestion].id;
  }

  void getPreviousPregunta() {
    indexCurrentQuestion -= 1;
    resetCurrentPreguntaSelectedRespotaIndex();
    notifyListeners();
  }

  void getNextPregunta() {
    indexCurrentQuestion += 1;
    resetCurrentPreguntaSelectedRespotaIndex();
    notifyListeners();
  }

  bool isLastPregunta() {
    return indexCurrentQuestion == maxNumberOfQuestions - 1;
  }

  bool isFirstPregunta() {
    return indexCurrentQuestion == 0;
  }

  void setCurrentPreguntaSelectedRespostaIndex(indexAnswer) {
    currentQuestionSelectedResponseIndex = indexAnswer;
    notifyListeners();
  }

  void resetCurrentPreguntaSelectedRespotaIndex() {
    if (answerTrackingList.length == indexCurrentQuestion) {
      currentQuestionSelectedResponseIndex = null;
    } else {
      currentQuestionSelectedResponseIndex =
          answerTrackingList[indexCurrentQuestion].indexSelectedAnswer;
    }
  }

  int? getCurrentPreguntaSelectedRespostaIndex() {
    return currentQuestionSelectedResponseIndex;
  }

  void storeRespostaSelection(preguntaId, indexSelectedResposta) {
    setCurrentPreguntaSelectedRespostaIndex(indexSelectedResposta);

    final preguntaActual =
        questionsList.firstWhere((pregunta) => pregunta.id == preguntaId);
    final isValidAnswer = preguntaActual.indexCorrecte == indexSelectedResposta;

    answerTrackingList[indexCurrentQuestion] = Score(
      preguntaId,
      indexSelectedResposta,
      isValidAnswer,
    );
  }

  void resetState() {
    indexCurrentQuestion = 0;
    currentQuestionSelectedResponseIndex = null;
    answerTrackingList = List<Score>.filled(
      maxNumberOfQuestions,
      Score(null, null, null),
      growable: false,
    );
    questionsList = [];
  }

  List<Score> getAnswerTrackingList() {
    return answerTrackingList;
  }
}
