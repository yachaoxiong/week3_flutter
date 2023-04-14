import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Simple Calculator'),
        ),
        body: Calculator(),
      ),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _expression = '';

  void _evaluate() {
    try {
      Parser p = Parser();
      Expression exp = p.parse(_expression);
      ContextModel cm = ContextModel();
      double result = exp.evaluate(EvaluationType.REAL, cm);
      setState(() {
        _expression = result.toString();
      });
    } catch (e) {
      setState(() {
        _expression = 'Error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter an expression',
            ),
            onChanged: (value) {
              setState(() {
                _expression = value;
              });
            },
          ),
        ),
        SizedBox(height: 16.0),
        ElevatedButton(
          onPressed: _evaluate,
          child: Text('Calculate'),
        ),
        SizedBox(height: 16.0),
        Text(
          'Result: $_expression',
          style: TextStyle(fontSize: 24.0),
        ),
      ],
    );
  }
}
