import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vtv_app/datamanager.dart';
import 'package:vtv_app/datamodel.dart';

class AppState extends ChangeNotifier {
  int maxNumberOfQuestions = 5;
  List<Question> questionsList = [];
  int indexCurrentQuestion = 0;
  int? currentQuestionSelectedResponseIndex;
  List<Score> answerTrackingList = [];

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

    bool hasPreviouslyAnsweredQuestion =
        answerTrackingList.any((answer) => answer.preguntaId == preguntaId);
    Question preguntaActual =
        questionsList.firstWhere((pregunta) => pregunta.id == preguntaId);
    bool isValidAnswer = preguntaActual.indexCorrecte == indexSelectedResposta;

    if (hasPreviouslyAnsweredQuestion) {
      int indexInRespostes = answerTrackingList
          .indexWhere((resposta) => resposta.preguntaId == preguntaId);

      answerTrackingList[indexInRespostes] =
          Score(preguntaId, indexSelectedResposta, isValidAnswer);

      return;
    }

    answerTrackingList
        .add(Score(preguntaId, indexSelectedResposta, isValidAnswer));

    return;
  }

  void resetState() {
    indexCurrentQuestion = 0;
    currentQuestionSelectedResponseIndex = null;
    answerTrackingList = [];
    questionsList = [];
  }

  List<Score> getScoreTracking() {
    return answerTrackingList;
  }
}
