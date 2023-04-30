import 'package:flutter/material.dart';
import 'package:vtv_app/datamanager.dart';
import 'package:vtv_app/datamodel.dart';

class AppState extends ChangeNotifier {
  List preguntes = [];
  int indexPregunta = 0;

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
    return preguntes[indexPregunta];
  }

  void getNextPregunta() {
    indexPregunta += 1;
    notifyListeners();
  }

  void getPreviousPregunta() {
    indexPregunta -= 1;
    notifyListeners();
  }

  bool isLastPregunta() {
    return indexPregunta == preguntes.length - 1;
  }

  bool isFirstPregunta() {
    return indexPregunta == 0;
  }
}
