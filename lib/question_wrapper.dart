import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vtv_app/app_state.dart';
import 'package:vtv_app/datamodel.dart';
import 'package:vtv_app/results_page.dart';

class QuestionWrapper extends StatelessWidget {
  const QuestionWrapper({super.key, required this.questions});

  final List<Question> questions;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
    appState.setListQuestions(questions);

    Question preguntaActual = appState.getPreguntaActual();
    int preguntaId = appState.getPreguntaActualId();

    return Pregunta(
      question: preguntaActual,
      preguntaId: preguntaId,
    );
  }
}

class Pregunta extends StatefulWidget {
  const Pregunta({super.key, required this.question, required this.preguntaId});

  final Question question;
  final int preguntaId;

  @override
  State<Pregunta> createState() => _PreguntaState();
}

class _PreguntaState extends State<Pregunta> {
  bool isPreguntaLocked = false;

  void toggleLockPregunta(bool state) {
    setState(() {
      isPreguntaLocked = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Text(
              widget.question.pregunta,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          ...generateAnswers(
            widget.question.respostes,
            widget.question.indexCorrecte,
            widget.preguntaId,
            isPreguntaLocked,
            toggleLockPregunta,
          ),
          const Spacer(),
          RowActions(
            toggleLockPregunta: toggleLockPregunta,
          ),
        ],
      ),
    );
  }
}

List generateAnswers(answers, indexCorrectAnswer, indexQuestion,
    isPreguntaLocked, toggleLockPregunta) {
  int index = 0;

  return answers.map((resposta) {
    bool isRespostaCorrecta = index == indexCorrectAnswer;
    int indexResposta = index;
    index += 1;

    return Answer(
      resposta: resposta,
      isRespostaCorrecta: isRespostaCorrecta,
      indexResposta: indexResposta,
      preguntaId: indexQuestion,
      isPreguntaLocked: isPreguntaLocked,
      toggleLockPregunta: toggleLockPregunta,
    );
  }).toList();
}

class Answer extends StatelessWidget {
  const Answer({
    super.key,
    required this.resposta,
    required this.isRespostaCorrecta,
    required this.indexResposta,
    required this.preguntaId,
    required this.isPreguntaLocked,
    required this.toggleLockPregunta,
  });

  final String resposta;
  final bool isRespostaCorrecta;
  final int indexResposta;
  final int preguntaId;
  final bool isPreguntaLocked;
  final Function(bool) toggleLockPregunta;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();

    int? selectedRespostaIndex =
        appState.getCurrentPreguntaSelectedRespostaIndex();

    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
          onPressed: isPreguntaLocked
              ? null
              : () => {
                    appState.storeRespostaSelection(preguntaId, indexResposta),
                    toggleLockPregunta(true),
                  },
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            backgroundColor: const Color.fromARGB(255, 241, 233, 233),
            disabledBackgroundColor: getDisabledBackgroundColor(
                isPreguntaLocked,
                isRespostaCorrecta,
                indexResposta,
                selectedRespostaIndex),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              resposta,
              style: TextStyle(
                color: getDisabledTextColor(isPreguntaLocked,
                    isRespostaCorrecta, indexResposta, selectedRespostaIndex),
                fontSize: resposta.length > 20 ? 25.0 : 38.0,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

class RowActions extends StatelessWidget {
  const RowActions({super.key, required this.toggleLockPregunta});

  final Function(bool) toggleLockPregunta;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();

    bool hasSelectedAnswer =
        appState.getCurrentPreguntaSelectedRespostaIndex() != null;

    void onClickNext() {
      appState.getNextPregunta();
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        if (hasSelectedAnswer)
          ElevatedButton(
            style: ButtonStyle(
              elevation: MaterialStateProperty.all(8.0),
              shape: MaterialStateProperty.all(
                const StadiumBorder(),
              ),
            ),
            onPressed: () {},
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Explicació',
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
            ),
          ),
        if (!appState.isLastPregunta())
          IconButton(
            icon: const Icon(
              Icons.arrow_forward,
              size: 40.0,
            ),
            onPressed: hasSelectedAnswer
                ? () => {
                      onClickNext(),
                      toggleLockPregunta(false),
                    }
                : null,
          ),
        if (appState.isLastPregunta())
          IconButton(
            icon: const Icon(
              Icons.checklist,
              size: 40.0,
            ),
            onPressed: hasSelectedAnswer
                ? () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ResultatsPage(),
                    ))
                : null,
          )
      ],
    );
  }
}

Color getDisabledBackgroundColor(isPreguntaLocked, isRespostaCorrecta,
    indexResposta, selectedRespostaIndex) {
  if (!isPreguntaLocked) {
    return const Color.fromARGB(255, 241, 233, 233);
  }

  if (isRespostaCorrecta) {
    return const Color.fromARGB(255, 3, 116, 18);
  }

  if (selectedRespostaIndex == indexResposta && !isRespostaCorrecta) {
    return const Color.fromARGB(255, 255, 0, 0);
  }

  return const Color.fromARGB(255, 241, 233, 233);
}

Color getDisabledTextColor(isPreguntaLocked, isRespostaCorrecta, indexResposta,
    selectedRespostaIndex) {
  if (isPreguntaLocked) {
    if (isRespostaCorrecta || indexResposta == selectedRespostaIndex) {
      return const Color.fromARGB(255, 255, 255, 255);
    }
  }

  return const Color.fromARGB(255, 0, 0, 0);
}
