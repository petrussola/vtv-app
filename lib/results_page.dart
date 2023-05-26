import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vtv_app/app_state.dart';
import 'package:vtv_app/datamodel.dart';
import 'package:vtv_app/question_wrapper.dart';
import 'package:vtv_app/share_section.dart';
import 'package:vtv_app/summary_page.dart';

class ResultatsPage extends StatelessWidget {
  const ResultatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
    List<Score> scoreTracking = appState.getAnswerTrackingList();
    Iterable<Score> correctAnswers = scoreTracking.where((answer) =>
        answer.isValidAnswer != null && answer.isValidAnswer == true);

    Map<String, String> resultMessage =
        getResultAssessment(correctAnswers.length, scoreTracking.length);

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
                children: [
                  Text(
                    'Resultat: ${correctAnswers.length}/${scoreTracking.length} ${resultMessage['emoji']}',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text(
                      '${resultMessage['assessment']}',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  const CustomDivider(),
                  Text(
                    'Respostes:',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const ScoreTracking(),
                  const CustomDivider(),
                  ShareSection(
                    correctAnswersCount: correctAnswers.length,
                    answersCount: scoreTracking.length,
                  ),
                  const CustomDivider(),
                  const Spacer(),
                  ElevatedButton(
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all(8.0),
                        fixedSize: MaterialStateProperty.all(
                          Size(MediaQuery.of(context).size.width, 100.0),
                        ),
                        side: MaterialStateProperty.all(
                            const BorderSide(width: 2.0)),
                        padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(vertical: 16.0),
                        ),
                        backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 255, 255, 255),
                        ),
                        shape: MaterialStateProperty.all(
                          const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                        )),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SummaryPage(),
                        ),
                      );
                    },
                    child: Text(
                      'Veure els resultats',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Divider(
        thickness: 1.0,
      ),
    );
  }
}

Map<String, String> getResultAssessment(
    correctAnswersLenght, scoreTrackingLength) {
  double percentValid = correctAnswersLenght / scoreTrackingLength;

  if (percentValid == 1) {
    return {
      "emoji": '🙌',
      "assessment":
          'Enhorabona! Ets un/a VTV de soca-arrel. Aviat seràs Administrador/a.',
    };
  }

  if (percentValid >= 0.75) {
    return {
      "emoji": '👍',
      "assessment":
          "Tens potencial, pero encara no estàs llest. Segueix estudiant l'article de Wikipedia sobre Vilafranca.",
    };
  }

  if (percentValid >= 0.5) {
    return {
      "emoji": '😐',
      "assessment":
          "Encara hi ha feina per fer. Et recomanem llegir senceres les pàgines web de l'Ajuntament de Vilafranca i l'article de Wikipedia. 5 vegades.",
    };
  }

  return {
    "emoji": '😝',
    "assessment":
        "Fatal. Demana una subscripció del 3 de 8 als Reis i memoritza la secció local, cada setmana.",
  };
}
