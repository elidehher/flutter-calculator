import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';
import 'package:calculator/styled_button.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  CalculatorState createState() => CalculatorState();
}

class CalculatorState extends State<Calculator> {
  // State variables
  String _display = '';
  String _accumulator = '';

  // Method to handle button presses
  void _onButtonPressed(String value) {
    setState(() {
      if (value == 'C') {
        _display = '';
        _accumulator = '';
      } else if (value == '=') {
        try {
          final expression = Expression.parse(_display);
          const evaluator = ExpressionEvaluator();
          var result = evaluator.eval(expression, {});
          _accumulator = '$_display = $result';
          _display = result.toString();
        } catch (e) {
          _accumulator = 'Error';
        }
      } else {
        _display += value;
      }
    });
  }

  // The build method that returns the widget tree
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          alignment: Alignment.centerRight,
          child: Text(
            _accumulator,
            style: const TextStyle(fontSize: 24, color: Colors.black54),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          alignment: Alignment.centerRight,
          child: Text(
            _display,
            style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
          ),
        ),
        const Divider(),
        _buildButtonRow(['7', '8', '9', '/']),
        _buildButtonRow(['4', '5', '6', '*']),
        _buildButtonRow(['1', '2', '3', '-']),
        _buildButtonRow(['C', '0', '=', '+']),
      ],
    );
  }

  // Helper method to build a row of buttons
  Widget _buildButtonRow(List<String> buttons) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: buttons
          .map((button) => StyledButton(
                onPressed: () => _onButtonPressed(button),
                child: Text(button, style: const TextStyle(fontSize: 24)),
              ))
          .toList(),
    );
  }
}

