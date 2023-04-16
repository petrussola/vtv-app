import 'package:flutter/material.dart';
import 'package:vtv_app/datamodel.dart';

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
      home: const MyHomePage(title: 'bla bla'),
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
            const AgeButton(buttonText: Age.gentJove),
            const AgeButton(buttonText: Age.gentGran),
          ],
        ),
      ),
    );
  }
}

class AgeButton extends StatelessWidget {
  const AgeButton({super.key, required this.buttonText});

  final Age buttonText;

  String getAgeLabel() {
    switch (buttonText) {
      case Age.gentJove:
        return 'Gent jove';
      case Age.gentGran:
        return 'Gent gran';
      default:
        throw Error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.75,
        child: ElevatedButton(
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(8.0),
          ),
          onPressed: () {},
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              getAgeLabel(),
              style: const TextStyle(fontSize: 32.0),
            ),
          ),
        ),
      ),
    );
  }
}
