import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:vtv_app/datamodel.dart';

class DataManager {
  static Future<List<Question>> loadQuestionnaireJove() async {
    String serializedJoveQuestionnaire =
        await rootBundle.loadString('assets/gent_jove.json');

    List mapDataJove = jsonDecode(serializedJoveQuestionnaire);

    List<Question> gentJoveQuestionnaire =
        mapDataJove.map((question) => Question.fromJson(question)).toList();

    return gentJoveQuestionnaire;
  }

  static Future<List<Question>> loadQuestionnaireGran() async {
    String serializedGranQuestionnaire =
        await rootBundle.loadString('assets/gent_gran.json');

    List mapDataGran = jsonDecode(serializedGranQuestionnaire);

    List<Question> gentGranQuestionnaire =
        mapDataGran.map((question) => Question.fromJson(question)).toList();

    return gentGranQuestionnaire;
  }
}
