import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vtv_app/app_state.dart';
import 'package:vtv_app/datamodel.dart';
import 'package:vtv_app/pregunta.dart';

class PreguntaPage extends StatelessWidget {
  const PreguntaPage({super.key, required this.age});

  final Age age;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();

    String ageLabel = age.getAgeLabel();
    Future<List<Question>> preguntes =
        appState.getPreguntes(age.getAgeCohort());

    return Scaffold(
        appBar: AppBar(
          title: Text('Modalitat $ageLabel'),
        ),
        body: FutureBuilder(
          future: preguntes,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const Pregunta();
            }

            if (snapshot.hasError) {
              return const Text('buu');
            }

            return const Text('Encenent la traca...');
          },
        ));
  }
}
