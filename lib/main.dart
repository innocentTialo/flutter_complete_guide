import 'package:flutter/material.dart';

import 'package:flutter_complete_guide/quiz.dart';
import 'package:flutter_complete_guide/result.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final _questions = const [
    {
      'questionText': "What is your favorite color?",
      'answers': ['Black', 'Green', 'Blue', 'Yellow'],
    },
    {
      'questionText': "What is your favorite animals?",
      'answers': ['Cat', 'Dog', 'Lion', 'Tigger'],
    },
    {
      'questionText': "Who is your favorite instructor?",
      'answers': ['Max', 'Mateo', 'Tchoupe', 'Tadmon'],
    },
  ];
  Map<String, String> _results = Map();
  var _questionIndex = 0;
  void _answerQuestion(String answer) {
    setState(() {
      _results[_questions[_questionIndex]['questionText']] = answer;
      _questionIndex = (_questionIndex + 1);
    });
  }

  void _restartQuiz() {
    setState(() {
      print(_results);
      _questionIndex = 0;
      _results = Map();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('My First App'),
        ),
        body: _questionIndex < _questions.length
            ? Quiz(
                questions: _questions,
                answerQuestion: _answerQuestion,
                questionIndex: _questionIndex)
            : Result(_restartQuiz, _results),
      ),
    );
  }
}
