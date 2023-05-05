import 'package:flutter/material.dart';
import 'package:vtv_app/datamanager.dart';
import 'package:vtv_app/datamodel.dart';

class AppState extends ChangeNotifier {
  int maxNumberOfQuestions = 4;
  Age? selectedAge;
  List<Question> preguntes = [];
  int indexCurrentPregunta = 0;
  int? currentPreguntaSelectedRespostaIndex;
  List<Score> answerTracking = [];

  Future<List<Question>> getPreguntes(ageCohort) {
    switch (ageCohort) {
      case AgeCohort.gentJove:
        return DataManager.loadQuestionnaireJove();

      case AgeCohort.gentGran:
        return DataManager.loadQuestionnaireGran();

      default:
        throw Error();
    }
  }

  void setListPreguntes(data) {
    preguntes = data;
  }

  Question getPreguntaActual() {
    return preguntes[indexCurrentPregunta];
  }

  int getPreguntaActualId() {
    return preguntes[indexCurrentPregunta].id;
  }

  void getPreviousPregunta() {
    indexCurrentPregunta -= 1;
    resetCurrentPreguntaSelectedRespotaIndex();
    notifyListeners();
  }

  void getNextPregunta() {
    indexCurrentPregunta += 1;
    resetCurrentPreguntaSelectedRespotaIndex();
    notifyListeners();
  }

  bool isLastPregunta() {
    return indexCurrentPregunta == maxNumberOfQuestions - 1;
  }

  bool isFirstPregunta() {
    return indexCurrentPregunta == 0;
  }

  void setCurrentPreguntaSelectedRespostaIndex(indexAnswer) {
    currentPreguntaSelectedRespostaIndex = indexAnswer;
    notifyListeners();
  }

  void resetCurrentPreguntaSelectedRespotaIndex() {
    if (answerTracking.length == indexCurrentPregunta) {
      currentPreguntaSelectedRespostaIndex = null;
    } else {
      currentPreguntaSelectedRespostaIndex =
          answerTracking[indexCurrentPregunta].indexSelectedAnswer;
    }
  }

  int? getCurrentPreguntaSelectedRespostaIndex() {
    return currentPreguntaSelectedRespostaIndex;
  }

  void storeRespostaSelection(preguntaId, indexSelectedResposta) {
    setCurrentPreguntaSelectedRespostaIndex(indexSelectedResposta);

    bool hasPreviouslyAnsweredQuestion =
        answerTracking.any((answer) => answer.preguntaId == preguntaId);
    Question preguntaActual =
        preguntes.firstWhere((pregunta) => pregunta.id == preguntaId);
    bool isValidAnswer = preguntaActual.indexCorrecte == indexSelectedResposta;

    if (hasPreviouslyAnsweredQuestion) {
      int indexInRespostes = answerTracking
          .indexWhere((resposta) => resposta.preguntaId == preguntaId);

      answerTracking[indexInRespostes] =
          Score(preguntaId, indexSelectedResposta, isValidAnswer);

      return;
    }

    answerTracking.add(Score(preguntaId, indexSelectedResposta, isValidAnswer));

    return;
  }

  void resetState(newAge) {
    if (selectedAge != null && newAge != selectedAge) {
      indexCurrentPregunta = 0;
      currentPreguntaSelectedRespostaIndex = null;
      answerTracking = [];
    }

    selectedAge = newAge;
  }
}
