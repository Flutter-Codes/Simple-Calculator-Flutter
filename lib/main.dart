import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Simple Calculator',
        home: Scaffold(
          appBar: AppBar(
            title: Center(
                child: Text(
              "Simple Calculator",
              style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold),
            )),
          ),
          body: Calculator(),
        ));
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String equation = "0";
  String result = "0";
  String expression = "0";
  double equationFontSize = 28.0;
  double resultFontSize = 38.0;
// finalresult()
// double n1 = 2.123;
//           var value = n1.truncate();
//           print("The truncated value of 2.123 = $value");
  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        equationFontSize = 28.0;
        resultFontSize = 38.0;
        equation = "0";
        result = "0";
      } else if (buttonText == "Del") {
        equationFontSize = 38.0;
        resultFontSize = 28.0;
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (buttonText == "=") {
        equationFontSize = 28.0;
        resultFontSize = 38.0;
        expression = equation;
        expression = expression.replaceAll('x', '*');
        expression = expression.replaceAll('÷', '/');
        try {
          double n1 = 2.123;
          var value = n1.truncate();
          print("The truncated value of 2.123 = $value");
          Parser p = new Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();

          // if (result == result.round()) {}
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Error";
        }
      } else {
        equationFontSize = 38.0;
        resultFontSize = 28.0;
        if (equation == "0") {
          equation = buttonText;
        } else
          equation = equation + buttonText;
      }
    });
  }

  Widget buildButton(
      String buttenText, double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.width * 0.2 * buttonHeight,
      color: buttonColor,
      child: MaterialButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
            side: BorderSide(
                color: Colors.white, width: 1, style: BorderStyle.solid)),
        padding: EdgeInsets.all(16.0),
        onPressed: () => buttonPressed(buttenText),
        child: Text(
          buttenText,
          style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.normal,
              color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(children: [
        Expanded(
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  alignment: Alignment.bottomRight,
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                  child: AutoSizeText(
                    equation,
                    overflow: TextOverflow.clip,
                    maxLines: 4,
                    style: TextStyle(
                      fontSize: equationFontSize,
                    ),
                  ),
                ),
              ),
              Divider(
                color: Colors.greenAccent,
                height: 1.0,
              ),
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.bottomRight,
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                  child: AutoSizeText(
                    "= $result",
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: resultFontSize,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildButton("C", 1, Colors.red[900]),
                      buildButton("Del", 1, Colors.red[400]),
                      buildButton("÷", 1, Colors.blue[800]),
                    ]),
                    TableRow(children: [
                      buildButton("7", 1, Colors.black87),
                      buildButton("8", 1, Colors.black87),
                      buildButton("9", 1, Colors.black87),
                    ]),
                    TableRow(children: [
                      buildButton("4", 1, Colors.black87),
                      buildButton("5", 1, Colors.black87),
                      buildButton("6", 1, Colors.black87),
                    ]),
                    TableRow(children: [
                      buildButton("1", 1, Colors.black87),
                      buildButton("2", 1, Colors.black87),
                      buildButton("3", 1, Colors.black87),
                    ]),
                    TableRow(children: [
                      buildButton(".", 1, Colors.black87),
                      buildButton("0", 1, Colors.black87),
                      buildButton("00", 1, Colors.black87),
                    ])
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * .25,
                child: Table(children: [
                  TableRow(children: [
                    buildButton("x", 1, Colors.blue[800]),
                  ]),
                  TableRow(children: [
                    buildButton("-", 1, Colors.blue[800]),
                  ]),
                  TableRow(children: [
                    buildButton("+", 1, Colors.blue[800]),
                  ]),
                  TableRow(children: [
                    buildButton("=", 2, Colors.yellow[600]),
                  ]),
                ]),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
