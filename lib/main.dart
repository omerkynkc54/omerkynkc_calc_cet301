import 'package:flutter/material.dart';

void main() => runApp(CalculatorApp());

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Calculator',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String output = "0";

  String _output = "0";
  double num1 = 0.0;
  double num2 = 0.0;
  String operand = "";

  buttonPressed(String buttonText) {
    if (buttonText == "AC") {
      _output = "0";
      num1 = 0.0;
      num2 = 0.0;
      operand = "";
    } else if (buttonText == "+" ||
        buttonText == "-" ||
        buttonText == "÷" ||
        buttonText == "×") {
      num1 = double.parse(output);
      operand = buttonText;
      _output = "0";
    } else if (buttonText == ".") {
      if (_output.contains(".")) {
        print("Already contains a decimal");
        return;
      } else {
        _output = _output + buttonText;
      }
    } else if (buttonText == "=") {
      num2 = double.parse(output);

      if (operand == "+") {
        _output = (num1 + num2).toString();
      }
      if (operand == "-") {
        _output = (num1 - num2).toString();
      }
      if (operand == "×") {
        _output = (num1 * num2).toString();
      }
      if (operand == "÷") {
        _output = (num1 / num2).toString();
      }

      num1 = 0.0;
      num2 = 0.0;
      operand = "";
    } else {
      _output = _output + buttonText;
    }

    setState(() {
      output = _output;
    });
  }

  String formatOutput(String output) {
    double doubleValue = double.tryParse(output) ?? 0;
    if (doubleValue % 1 == 0) {
      return doubleValue.toInt().toString();
    } else {
      return doubleValue.toString();
    }
  }

  Widget buildButton(
      String buttonText, Color backgroundColor, Color textColor) {
    return Expanded(
      child: TextButton(
        style: TextButton.styleFrom(
          shape: CircleBorder(),
          primary: textColor, // Text Color
          backgroundColor: backgroundColor,
          minimumSize: Size(88, 88), // Button Size
        ),
        onPressed: () => buttonPressed(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 36.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          // Display
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            alignment: Alignment.bottomRight,
            child: Text(
              formatOutput(output),
              style: TextStyle(
                fontSize: 72,
                fontWeight: FontWeight.w200,
                color: Colors.white,
              ),
              maxLines: 1,
              textAlign: TextAlign.right,
            ),
          ),
          SizedBox(height: 24), // For spacing
          // Button rows
          ...[
            ['AC', '+/-', '%', '÷'],
            ['7', '8', '9', '×'],
            ['4', '5', '6', '-'],
            ['1', '2', '3', '+'],
            ['0', '.', '=']
          ].map((List<String> row) {
            return Row(
              children: row.map((String buttonText) {
                Color backgroundColor = buttonText == '0'
                    ? Colors.grey.shade800
                    : row.last == buttonText
                        ? Colors.orange
                        : Colors.grey;
                Color textColor =
                    row.last == buttonText ? Colors.white : Colors.white;
                return buildButton(buttonText, backgroundColor, textColor);
              }).toList(),
            );
          }),
        ],
      ),
    );
  }
}
