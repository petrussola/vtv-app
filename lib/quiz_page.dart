import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vtv_app/app_state.dart';
import 'package:vtv_app/datamodel.dart';
import 'package:vtv_app/question_wrapper.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();

    Future<List<Question>> quizFuture = appState.loadPreguntes();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('El quiz dels VTVs'),
        ),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: FutureBuilder(
            future: quizFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return QuestionWrapper(
                  questions: snapshot.data!,
                );
              }

              if (snapshot.hasError) {
                // TODO: per fer
                return const Text('Tens un error :(');
              }

              // TODO: per fer
              return const Text('Encenent la traca...');
            },
          ),
        ),
      ),
    );
  }
}
