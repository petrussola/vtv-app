import 'package:flutter/material.dart';
import 'package:vtv_app/datamodel.dart';
import 'package:vtv_app/questionnaire_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vilafranquins de tota la vida - the app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'VTV - Vilafranquins de Tota la Vida'),
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
                'Benvinguts a la app Vilafranquins de Tota la Vida.',
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
            AgeButton(selectedAge: Age(AgeCohort.gentJove)),
            AgeButton(selectedAge: Age(AgeCohort.gentGran)),
          ],
        ),
      ),
    );
  }
}

class AgeButton extends StatelessWidget {
  const AgeButton({super.key, required this.selectedAge});

  final Age selectedAge;

  @override
  Widget build(BuildContext context) {
    String ageLabel = selectedAge.getAgeLabel();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.75,
        child: ElevatedButton(
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(8.0),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => QuestionnairePage(age: selectedAge)),
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
