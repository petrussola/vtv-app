import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vtv_app/app_state.dart';
import 'package:vtv_app/datamodel.dart';

class ResultatsPage extends StatelessWidget {
  const ResultatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
    List<Question> preguntes = appState.getCurrentListPreguntes();
    List<Score> scoreTracking = appState.getScoreTracking();
    Iterable<Score> correctAnswers =
        scoreTracking.where((answer) => answer.isValidAnswer);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Resultats'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Resultat: ${correctAnswers.length}/${scoreTracking.length}',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  ...generateResults(preguntes, scoreTracking),
                ],
              )),
        ),
      ),
    );
  }
}

List generateResults(
  List<Question> preguntes,
  List<Score> answerTracking,
) {
  int index = 0;

  return answerTracking.map((answer) {
    Score answer = answerTracking[index];
    Question pregunta =
        preguntes.firstWhere((pregunta) => pregunta.id == answer.preguntaId);
    String selectedAnswer = pregunta.respostes[answer.indexSelectedAnswer];
    index += 1;

    return Resultat(
        pregunta: pregunta.pregunta,
        isValidAnswer: answer.isValidAnswer,
        selectedAnswer: selectedAnswer);
  }).toList();
}

class Resultat extends StatelessWidget {
  const Resultat({
    super.key,
    required this.pregunta,
    required this.isValidAnswer,
    required this.selectedAnswer,
  });

  final String pregunta;
  final bool isValidAnswer;
  final String selectedAnswer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Row(
        children: [
          if (isValidAnswer)
            const Icon(
              Icons.check_circle,
              color: Colors.green,
            ),
          if (!isValidAnswer) const Icon(Icons.cancel, color: Colors.red),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pregunta,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Text(
                    'Has seleccionat: $selectedAnswer',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
