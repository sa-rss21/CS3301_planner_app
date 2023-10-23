import 'package:flutter/material.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String _output = "0";
  String _currentNumber = "";
  double num1 = 0.0;
  double num2 = 0.0;
  String operand = "";

  void buttonPressed(String buttonText) {
    if (buttonText == "C") {
      _output = "0";
      _currentNumber = ""; // Reset the current number as well
      num1 = 0.0;
      num2 = 0.0;
      operand = "";
    } else if (buttonText == "+" ||
        buttonText == "-" ||
        buttonText == "×" ||
        buttonText == "÷") {

      if (_currentNumber != "") {
        num2 = double.parse(_currentNumber);
        if (operand != "") {
          if (operand == "+") num1 += num2;
          if (operand == "-") num1 -= num2;
          if (operand == "×") num1 *= num2;
          if (operand == "÷") num1 /= num2;
          _output = num1.toString();
          _currentNumber = "";
        } else {
          num1 = double.parse(_output);
          _currentNumber = "";
        }
      }
      operand = buttonText;

    } else if (buttonText == ".") {
      if (_currentNumber.contains(".")) {
        return;
      }
      _currentNumber = _currentNumber + buttonText;
    } else if (buttonText == "=") {
      if (_currentNumber != "") {
        num2 = double.parse(_currentNumber);
        if (operand == "+") _output = (num1 + num2).toString();
        if (operand == "-") _output = (num1 - num2).toString();
        if (operand == "×") _output = (num1 * num2).toString();
        if (operand == "÷") _output = (num1 / num2).toString();
        num1 = double.parse(_output);
        _currentNumber = "";
      }
      operand = "";

    } else {
      _currentNumber = _currentNumber + buttonText;
      _output = _currentNumber;
    }

    setState(() {
      _output = _output;
    });
  }


  Widget buildButton(String buttonText) {
    Color buttonColor;
    if (buttonText == "=") {
      buttonColor = Colors.red;
    } else if (buttonText == "+" ||
        buttonText == "-" ||
        buttonText == "×" ||
        buttonText == "÷" ||
        buttonText == "C") {
      buttonColor = Colors.grey;
    } else {
      buttonColor = Colors.amber;
    }

    return Expanded(
      child: Container(
        height: 66.0,
        margin: EdgeInsets.all(2.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: buttonColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.0)
              )
          ),
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(
                vertical: 24.0,
                horizontal: 12.0,
              ),
              child: Text(
                _output,
                style: TextStyle(
                  fontSize: 48.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Divider(),
            ),
            Column(
              children: [
                Row(children: [
                  buildButton("7"),
                  buildButton("8"),
                  buildButton("9"),
                  buildButton("÷"),
                ]),
                SizedBox(height: 5.0),
                Row(children: [
                  buildButton("4"),
                  buildButton("5"),
                  buildButton("6"),
                  buildButton("×"),
                ]),
                SizedBox(height: 5.0),
                Row(children: [
                  buildButton("1"),
                  buildButton("2"),
                  buildButton("3"),
                  buildButton("-"),
                ]),
                SizedBox(height: 5.0),
                Row(children: [
                  buildButton("."),
                  buildButton("0"),
                  buildButton("="),
                  buildButton("+"),
                ]),
                SizedBox(height: 5.0),
                Row(children: [
                  buildButton("C"),
                ]),
              ],
            )
          ],
        ),
      ),
    );
  }
}

