import 'package:flutter/material.dart';
import 'package:vtv_app/datamodel.dart';

class QuestionnairePage extends StatelessWidget {
  const QuestionnairePage({super.key, required this.age});

  final Age age;

  @override
  Widget build(BuildContext context) {
    String ageLabel = age.getAgeLabel();

    return Scaffold(
      appBar: AppBar(
        title: Text('Modalitat $ageLabel'),
      ),
      body: Text(ageLabel),
    );
  }
}
