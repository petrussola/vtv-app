import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:vtv_app/datamodel.dart';

class DataManager {
  Future<Map<List<Question>, List<Question>>> loadQuestionnaire() async {
    String serializedJoveQuestionnaire =
        await rootBundle.loadString('assets/gent_jove.json');
    String serializedGranQuestionnaire =
        await rootBundle.loadString('assets/gent_gran.json');

    List mapDataJove = jsonDecode(serializedJoveQuestionnaire);
    List mapDataGran = jsonDecode(serializedGranQuestionnaire);

    List<Question> gentJoveQuestionnaire =
        mapDataJove.map((question) => Question.fromJson(question)).toList();
    List<Question> gentGranQuestionnaire =
        mapDataGran.map((question) => Question.fromJson(question)).toList();

    return {
      gentJoveQuestionnaire: gentJoveQuestionnaire,
      gentGranQuestionnaire: gentGranQuestionnaire
    };
  }
}
