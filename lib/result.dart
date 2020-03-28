import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final Function restartQuizHandler;
  final Map<String, String> results;

  const Result(this.restartQuizHandler, this.results);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ...results.entries.map((entry) {
            return Column(children: [
              Text(
                entry.key,
                style: TextStyle(fontSize: 25),
              ),
              Text(
                entry.value,
                style: TextStyle(fontSize: 16),
              )
            ]);
          }).toList(),
          FlatButton(
              textColor: Colors.blue,
              child: Text("Restart Quiz!"),
              onPressed: restartQuizHandler),
        ],
      ),
    );
  }
}
