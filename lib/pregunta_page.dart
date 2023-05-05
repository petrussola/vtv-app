import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vtv_app/app_state.dart';
import 'package:vtv_app/datamodel.dart';
import 'package:vtv_app/pregunta_wrapper.dart';

class PreguntaPage extends StatelessWidget {
  const PreguntaPage({super.key, required this.age});

  final Age age;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();

    String ageLabel = age.getAgeLabel();
    Future<List<Question>> preguntesFuture =
        appState.loadPreguntes(age.getAgeCohort());

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Modalitat $ageLabel'),
        ),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: FutureBuilder(
            future: preguntesFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return PreguntaWrapper(
                  preguntes: snapshot.data!,
                );
              }

              if (snapshot.hasError) {
                // TODO: per fer
                return const Text('buu');
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
