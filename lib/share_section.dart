import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ShareSection extends StatelessWidget {
  const ShareSection({
    super.key,
    required this.correctAnswersCount,
    required this.answersCount,
  });

  final int correctAnswersCount;
  final int answersCount;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text('Comparteix els resultats:',
          style: Theme.of(context).textTheme.headlineMedium),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
            onPressed: () {
              Share.share(
                "Avui n'he encertat $correctAnswersCount de $answersCount. I tu? Baixa't l'aplicatiu i prova-ho a {{URL_PLAY_STORE}}",
                subject: "L'aplicatiu pels VTVs",
              );
            },
            style: ButtonStyle(
              elevation: MaterialStateProperty.all(8.0),
              shape: MaterialStateProperty.all(
                const CircleBorder(),
              ),
              padding: MaterialStateProperty.all<EdgeInsets>(
                const EdgeInsets.all(16.0),
              ),
              backgroundColor: MaterialStateProperty.all(
                const Color.fromARGB(255, 255, 255, 255),
              ),
              side: MaterialStateProperty.all(const BorderSide(width: 2.0)),
            ),
            child: const Icon(
              Icons.share,
              size: 32.0,
              color: Color.fromARGB(255, 0, 0, 0),
            )),
      ),
    ]);
  }
}
