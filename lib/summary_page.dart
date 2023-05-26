import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vtv_app/app_state.dart';
import 'package:vtv_app/datamodel.dart';

class SummaryPage extends StatelessWidget {
  const SummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
    List<Question> preguntes = appState.getCurrentListPreguntes();
    List<Score> scoreTracking = appState.getAnswerTrackingList();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Sumari de les preguntes'),
        ),
        body: ListView(
          children: [...generateResults(preguntes, scoreTracking)],
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
    final answer = answerTracking[index];
    final pregunta =
        preguntes.firstWhere((pregunta) => pregunta.id == answer.preguntaId);
    final String selectedAnswer =
        pregunta.respostes[answer.indexSelectedAnswer!];
    index += 1;
    final String correctAnswer = pregunta.respostes[pregunta.indexCorrecte];

    return Resultat(
        pregunta: pregunta.pregunta,
        isValidAnswer:
            answer.isValidAnswer != null && answer.isValidAnswer == true,
        selectedAnswer: selectedAnswer,
        correctAnswer: correctAnswer);
  }).toList();
}

class Resultat extends StatelessWidget {
  const Resultat({
    super.key,
    required this.pregunta,
    required this.isValidAnswer,
    required this.selectedAnswer,
    required this.correctAnswer,
  });

  final String pregunta;
  final bool isValidAnswer;
  final String selectedAnswer;
  final String correctAnswer;

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
                  WithTopPadding(
                    child: Text(
                      'Has seleccionat: $selectedAnswer',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  if (!isValidAnswer)
                    WithTopPadding(
                      child: Text(
                        'Resposta correcta: $correctAnswer',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
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

class WithTopPadding extends StatelessWidget {
  const WithTopPadding({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: child,
    );
  }
}
