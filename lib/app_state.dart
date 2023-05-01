import 'package:flutter/material.dart';
import 'package:vtv_app/datamanager.dart';
import 'package:vtv_app/datamodel.dart';

class AppState extends ChangeNotifier {
  List<Question> preguntes = [];
  int indexCurrentPregunta = 0;
  int? currentPreguntaSelectedRespostaIndex;
  List<Score> cumulatedRespostes = [];

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
    return indexCurrentPregunta == preguntes.length - 1;
  }

  bool isFirstPregunta() {
    return indexCurrentPregunta == 0;
  }

  void setCurrentPreguntaSelectedRespostaIndex(indexAnswer) {
    currentPreguntaSelectedRespostaIndex = indexAnswer;
    notifyListeners();
  }

  void resetCurrentPreguntaSelectedRespotaIndex() {
    if (cumulatedRespostes.length == indexCurrentPregunta) {
      currentPreguntaSelectedRespostaIndex = null;
    } else {
      currentPreguntaSelectedRespostaIndex =
          cumulatedRespostes[indexCurrentPregunta].indexSelectedAnswer;
    }
  }

  int? getCurrentPreguntaSelectedRespostaIndex() {
    return currentPreguntaSelectedRespostaIndex;
  }

  void storeRespostaSelection(preguntaId, indexSelectedResposta) {
    setCurrentPreguntaSelectedRespostaIndex(indexSelectedResposta);

    bool hasAnsweredQuestion =
        cumulatedRespostes.any((resposta) => resposta.preguntaId == preguntaId);
    Question resposta =
        preguntes.firstWhere((pregunta) => pregunta.id == preguntaId);
    bool isValidAnswer = resposta.indexCorrecte == indexSelectedResposta;

    if (hasAnsweredQuestion) {
      int indexInRespostes = cumulatedRespostes
          .indexWhere((resposta) => resposta.preguntaId == preguntaId);

      cumulatedRespostes[indexInRespostes] =
          Score(preguntaId, indexSelectedResposta, isValidAnswer);

      return;
    }

    cumulatedRespostes
        .add(Score(preguntaId, indexSelectedResposta, isValidAnswer));

    return;
  }
}
