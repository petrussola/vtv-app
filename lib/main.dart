import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vtv_app/app_state.dart';
import 'package:vtv_app/quiz_page.dart';

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
        home: const MyHomePage(title: 'El quiz dels VTVs'),
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
              padding: const EdgeInsets.only(top: 32.0, bottom: 32.0),
              child: Text(
                'VTV, estas a punt per jugar?',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            const StartQuestionnaireButton(),
            const Spacer(),
            Container(
              height: 300.0,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/geganta.png'),
                  fit: BoxFit.contain,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class StartQuestionnaireButton extends StatelessWidget {
  const StartQuestionnaireButton({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();

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
                builder: (context) => const QuizPage(),
              ),
            );
          },
          child: const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Jugar',
              style: TextStyle(fontSize: 32.0),
            ),
          ),
        ),
      ),
    );
  }
}
