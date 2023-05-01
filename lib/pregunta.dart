import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vtv_app/app_state.dart';
import 'package:vtv_app/datamodel.dart';

class PreguntaWrapper extends StatelessWidget {
  const PreguntaWrapper({super.key, required this.preguntes});

  final List<Question> preguntes;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
    appState.setListPreguntes(preguntes);

    Question preguntaActual = appState.getPreguntaActual();

    return Pregunta(
      pregunta: preguntaActual,
    );
  }
}

class Pregunta extends StatelessWidget {
  const Pregunta({super.key, required this.pregunta});

  final Question pregunta;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Text(
              pregunta.pregunta,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          ...generateRespostes(pregunta.respostes, pregunta.indexCorrecte),
          const Spacer(),
          const RowActions()
        ],
      ),
    );
  }
}

List generateRespostes(respostes, indexCorrecte) {
  int index = 0;

  return respostes.map((resposta) {
    bool isRespostaCorrecta = index == indexCorrecte;
    index += 1;

    return Resposta(
      resposta: resposta,
      isRespostaCorrecta: isRespostaCorrecta,
    );
  }).toList();
}

class Resposta extends StatelessWidget {
  const Resposta(
      {super.key, required this.resposta, required this.isRespostaCorrecta});

  final String resposta;
  final bool isRespostaCorrecta;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
    bool isRespostaVisible = appState.getVisibilitySolution();

    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: Border.all(width: 1.0),
          borderRadius: const BorderRadius.all(
            Radius.circular(200.0),
          ),
          color: getBackgroundColor(isRespostaVisible, isRespostaCorrecta),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            resposta,
            style: TextStyle(
              color: getTextColor(isRespostaVisible),
              fontSize: 38.0,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class RowActions extends StatelessWidget {
  const RowActions({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
    bool isSolutionVisible = appState.getVisibilitySolution();

    void onClickNext() {
      appState.getNextPregunta();
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        if (!appState.isFirstPregunta())
          IconButton(
            icon: const Icon(
              Icons.arrow_back,
              size: 40.0,
            ),
            onPressed: () => appState.getPreviousPregunta(),
          ),
        IconButton(
          icon: Icon(
            isSolutionVisible ? Icons.visibility : Icons.visibility_off,
            size: 40.0,
          ),
          onPressed: () => appState.toggleSolution(),
        ),
        if (!appState.isLastPregunta())
          IconButton(
            icon: const Icon(
              Icons.arrow_forward,
              size: 40.0,
            ),
            onPressed: () => onClickNext(),
          )
      ],
    );
  }
}

Color getBackgroundColor(isSolutionVisible, isCorrectAnswer) {
  if (isSolutionVisible && isCorrectAnswer) {
    return const Color.fromARGB(255, 0, 110, 6);
  }

  if (isSolutionVisible && !isCorrectAnswer) {
    return const Color.fromARGB(255, 255, 0, 0);
  }

  return const Color.fromARGB(255, 241, 233, 233);
}

Color getTextColor(isSolutionVisible) {
  if (isSolutionVisible) {
    return const Color.fromARGB(255, 255, 255, 255);
  }

  return const Color.fromARGB(255, 0, 0, 0);
}
