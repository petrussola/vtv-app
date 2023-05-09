import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vtv_app/app_state.dart';
import 'package:vtv_app/datamodel.dart';
import 'package:vtv_app/pregunta_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppState(),
      child: MaterialApp(
        title: 'Vilafranquins de tota la vida - the app',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'VTV - Vilafranquins de Tota la Vida'),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 32.0, bottom: 64.0),
              child: Text(
                'Ets un VTV?',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: Text(
                'Tria la teva modalitat:',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            StartQuestionnaireButton(selectedAge: Age(AgeCohort.gentJove)),
            StartQuestionnaireButton(selectedAge: Age(AgeCohort.gentGran)),
          ],
        ),
      ),
    );
  }
}

class StartQuestionnaireButton extends StatelessWidget {
  const StartQuestionnaireButton({super.key, required this.selectedAge});

  final Age selectedAge;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();

    String ageLabel = selectedAge.getAgeLabel();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.75,
        child: ElevatedButton(
          style: ButtonStyle(
              elevation: MaterialStateProperty.all(8.0),
              shape: MaterialStateProperty.all(const StadiumBorder())),
          onPressed: () {
            appState.resetState();

            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PreguntaPage(age: selectedAge)),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Gent $ageLabel',
              style: const TextStyle(fontSize: 32.0),
            ),
          ),
        ),
      ),
    );
  }
}
