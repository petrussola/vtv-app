import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vtv_app/app_state.dart';
import 'package:vtv_app/datamodel.dart';
import 'package:vtv_app/resultats_page.dart';

class PreguntaWrapper extends StatelessWidget {
  const PreguntaWrapper({super.key, required this.preguntes});

  final List<Question> preguntes;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
    appState.setListPreguntes(preguntes);

    Question preguntaActual = appState.getPreguntaActual();
    int preguntaId = appState.getPreguntaActualId();

    return Pregunta(
      pregunta: preguntaActual,
      preguntaId: preguntaId,
    );
  }
}

class Pregunta extends StatelessWidget {
  const Pregunta({super.key, required this.pregunta, required this.preguntaId});

  final Question pregunta;
  final int preguntaId;

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
          ...generateRespostes(
            pregunta.respostes,
            pregunta.indexCorrecte,
            preguntaId,
          ),
          const Spacer(),
          const RowActions()
        ],
      ),
    );
  }
}

List generateRespostes(respostes, indexRespostaCorrecte, indexPregunta) {
  int index = 0;

  return respostes.map((resposta) {
    bool isRespostaCorrecta = index == indexRespostaCorrecte;
    int indexResposta = index;
    index += 1;

    return Resposta(
        resposta: resposta,
        isRespostaCorrecta: isRespostaCorrecta,
        indexResposta: indexResposta,
        preguntaId: indexPregunta);
  }).toList();
}

class Resposta extends StatelessWidget {
  const Resposta({
    super.key,
    required this.resposta,
    required this.isRespostaCorrecta,
    required this.indexResposta,
    required this.preguntaId,
  });

  final String resposta;
  final bool isRespostaCorrecta;
  final int indexResposta;
  final int preguntaId;

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
          onPressed: () {
            appState.storeRespostaSelection(preguntaId, indexResposta);
          },
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            backgroundColor: const Color.fromARGB(255, 241, 233, 233),
            side: selectedRespostaIndex == indexResposta
                ? const BorderSide(width: 3.0)
                : null,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              resposta,
              style: const TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 38.0,
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
  const RowActions({super.key});

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
        if (!appState.isFirstPregunta())
          IconButton(
            icon: const Icon(
              Icons.arrow_back,
              size: 40.0,
            ),
            onPressed: () => appState.getPreviousPregunta(),
          ),
        if (!appState.isLastPregunta())
          IconButton(
            icon: const Icon(
              Icons.arrow_forward,
              size: 40.0,
            ),
            onPressed: hasSelectedAnswer ? () => onClickNext() : null,
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
