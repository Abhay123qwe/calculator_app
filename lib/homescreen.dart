import 'package:calculator_app/color.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //Variables
  var input = "";
  var output = "";
  var operation = "";
  var hideinput = false;
  var outputSize = 34.0;

  //putting conditions onButtonClick
  onButtonClick(value) {
    if (value == "AC") {
      input = "";
      output = "";
    } else if (value == "<") {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    } else if (value == "=") {
      if (input.isNotEmpty) {
        var userInput = input;
        //here replacing text with operators
        userInput = input.replaceAll("x", "*");
        userInput = input.replaceAll("÷", "/");
        Parser p = Parser();
        Expression expression = p.parse(userInput);
        ContextModel cm = ContextModel();
        var finalvalue = expression.evaluate(EvaluationType.REAL, cm);
        output = finalvalue.toString();
        if (output.endsWith(".0")) {
          output = output.substring(0, output.length - 2);
        }
        input = output;
        hideinput = true;
        outputSize = 55;
      }
    } else {
      input = input + value;
      hideinput = false;
      outputSize = 34;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cblack,
      body: Column(
        children: [
          //input output area
          Container(
            width: MediaQuery.of(context).size.width,
            height: 320,
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  hideinput ? '' : input,
                  style: const TextStyle(fontSize: 50, color: cwhite),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  output,
                  style: TextStyle(fontSize: outputSize, color: Colors.white70),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),

          //button area
          Row(
            children: [
              button(
                  text: "AC",
                  buttonBgColor: operatorColor,
                  tColor: orangeColor),
              button(
                  text: "D", buttonBgColor: operatorColor, tColor: orangeColor),
              button(text: "00", buttonBgColor: operatorColor),
              button(
                  text: "÷", buttonBgColor: operatorColor, tColor: orangeColor)
            ],
          ),
          Row(
            children: [
              button(text: "7"),
              button(text: "8"),
              button(text: "9"),
              button(
                  text: "x", buttonBgColor: operatorColor, tColor: orangeColor)
            ],
          ),
          Row(
            children: [
              button(text: "4"),
              button(text: "5"),
              button(text: "6"),
              button(
                  text: "-", buttonBgColor: operatorColor, tColor: orangeColor)
            ],
          ),
          Row(
            children: [
              button(text: "1"),
              button(text: "2"),
              button(
                text: "3",
              ),
              button(
                  text: "+", buttonBgColor: operatorColor, tColor: orangeColor)
            ],
          ),
          Row(
            children: [
              button(
                  text: "%", buttonBgColor: operatorColor, tColor: orangeColor),
              button(text: "0"),
              button(
                text: ".",
              ),
              button(text: "=", buttonBgColor: orangeColor)
            ],
          ),
        ],
      ),
    );
  }

  Widget button({text, tColor = cwhite, buttonBgColor = buttonColor}) {
    return Expanded(
        child: Container(
            margin: const EdgeInsets.all(8),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.all(22),
                  backgroundColor: buttonBgColor,
                ),
                onPressed: () => onButtonClick(text),
                child: Text(
                  text,
                  style: TextStyle(
                      fontSize: 18, color: tColor, fontWeight: FontWeight.bold),
                ))));
  }
}
