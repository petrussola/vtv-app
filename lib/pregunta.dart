import 'package:flutter/material.dart';
import 'package:vtv_app/datamodel.dart';

class Pregunta extends StatelessWidget {
  const Pregunta({super.key, required this.pregunta});

  final Question pregunta;

  @override
  Widget build(BuildContext context) {
    return Column(
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
        ...createRespostes(pregunta.respostes),
      ],
    );
  }
}

List createRespostes(respostes) {
  return respostes
      .map((resposta) => Respota(
            resposta: resposta,
          ))
      .toList();
}

class Respota extends StatelessWidget {
  const Respota({super.key, required this.resposta});

  final String resposta;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.75,
        decoration: BoxDecoration(
          border: Border.all(width: 1.0),
          borderRadius: const BorderRadius.all(
            Radius.circular(200.0),
          ),
          color: const Color.fromARGB(255, 255, 0, 0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            resposta,
            style: const TextStyle(
              color: Color.fromRGBO(255, 255, 255, 1),
              fontSize: 38.0,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
