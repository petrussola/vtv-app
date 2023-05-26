import 'package:flutter/services.dart' show rootBundle;
import 'package:vtv_app/app_state.dart';
import 'dart:convert';
import 'package:vtv_app/datamodel.dart';

class DataManager {
  static Future<List<Question>> loadQuiz() async {
    String serializedQuiz =
        await rootBundle.loadString('assets/test_data.json');

    List mapDataQuiz = jsonDecode(serializedQuiz);

    List<Question> quiz =
        mapDataQuiz.map((question) => Question.fromJson(question)).toList();

    List<Question> filteredQuiz =
        quiz.where((question) => question.day == day).toList();

    return filteredQuiz;
  }
}
