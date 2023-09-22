import 'package:calculator_application/constants.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  var textInput = '';
  var resault = '';
  void _pressButton(String value) {
    setState(() {
      textInput = textInput + value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: backgroundGreyDark,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  color: backgroundGreyDark,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 7, vertical: 7),
                        child: Text(
                          textInput,
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: textGreen,
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 7, vertical: 21),
                        child: Text(
                          resault,
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 49,
                            fontWeight: FontWeight.bold,
                            color: textPhosphor,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 7,
                child: Container(
                  color: backgroundGrey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _getRow('AC', 'CE', '%', '/'),
                      _getRow('7', '8', '9', '*'),
                      _getRow('4', '5', '6', '-'),
                      _getRow('1', '2', '3', '+'),
                      _getRow('00', '0', '.', '='),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _getRow(String text1, text2, text3, text4) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
          onPressed: () {
            if (text1 == 'AC') {
              setState(() {
                textInput = '';
                resault = '';
              });
            } else {
              _pressButton(text1);
            }
          },
          style: TextButton.styleFrom(
            minimumSize: Size(90, 90),
            shape: CircleBorder(
                side: BorderSide(width: 0, color: Colors.transparent)),
            backgroundColor: _getButtonColor(text1),
          ),
          child: Text(
            text1,
            style: TextStyle(fontSize: 28, color: _getButtonTextColor(text1)),
          ),
        ),
        TextButton(
          onPressed: () {
            if (text2 == 'CE') {
              setState(() {
                if (textInput.isNotEmpty) {
                  textInput = textInput.substring(0, textInput.length - 1);
                }
              });
            } else {
              _pressButton(text2);
            }
          },
          style: TextButton.styleFrom(
            minimumSize: Size(90, 90),
            shape: CircleBorder(
                side: BorderSide(width: 0, color: Colors.transparent)),
            backgroundColor: _getButtonColor(text2),
          ),
          child: Text(
            text2,
            style: TextStyle(fontSize: 28, color: _getButtonTextColor(text2)),
          ),
        ),
        TextButton(
          onPressed: () {
            _pressButton(text3);
          },
          style: TextButton.styleFrom(
            minimumSize: Size(90, 90),
            shape: CircleBorder(
                side: BorderSide(width: 0, color: Colors.transparent)),
            backgroundColor: _getButtonColor(text3),
          ),
          child: Text(
            text3,
            style: TextStyle(fontSize: 28, color: _getButtonTextColor(text3)),
          ),
        ),
        TextButton(
          onPressed: () {
            if (text4 == '=') {
              Parser parser = Parser();
              Expression expression = parser.parse(textInput);
              ContextModel contextModel = ContextModel();
              double eval =
                  expression.evaluate(EvaluationType.REAL, contextModel);
              setState(() {
                resault = eval.toStringAsFixed(0);
              });
            } else {
              _pressButton(text4);
            }
          },
          style: TextButton.styleFrom(
            minimumSize: Size(90, 90),
            shape: CircleBorder(
                side: BorderSide(width: 0, color: Colors.transparent)),
            backgroundColor: _getButtonColor(text4),
          ),
          child: Text(
            text4,
            style: TextStyle(fontSize: 35, color: _getButtonTextColor(text4)),
          ),
        ),
      ],
    );
  }

  bool _isOprator(String text) {
    var list = ['AC', 'CE', '%', '/', '*', '-', '+', '='];
    for (var item in list) {
      if (text == item) {
        return true;
      }
    }
    return false;
  }

  Color _getButtonColor(String text) {
    if (_isOprator(text)) {
      return backgroundGreyDark;
    }
    return backgroundGrey;
  }

  Color _getButtonTextColor(String text) {
    if (_isOprator(text)) {
      return textGreen;
    }
    return textGrey;
  }
}
