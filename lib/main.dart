import 'package:calculator/colors.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:auto_size_text/auto_size_text.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: CalculatorApp(),
  ));
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({Key? key}) : super(key: key);

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  var input = '';
  var output = '';
  var inputSize = 48;
  var outputSize = 24;

  onClick(value) {
    if (value == 'C') {
      input = '';
      output = '';
    } else if (value == 'Del') {
      if(output.isNotEmpty){
        output = output.substring(0,output.length-1);
        if(output.isEmpty){
          inputSize = 48;
        }
      }
      else if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    } else if (value == '=') {
      if (input.isNotEmpty) {
        var userInput = input;
        Parser p = Parser();
        Expression exp = p.parse(userInput);
        ContextModel cm = ContextModel();
        var finalOutput = exp.evaluate(EvaluationType.REAL, cm);
        output = finalOutput.toString();
        if(output.endsWith('.0')){
          output = output.substring(0,output.length-2);
        }
        inputSize = 24;
        outputSize = 48;
      }
    } else {
      input = input + value;
      outputSize = 24;
      inputSize = 48;
    }
    setState(() {});
  }

  onLongClick(value) {
    if(value== 'Del') {
      input = '';
      output= '';
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: operatorColor,
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Calculator',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Expanded(
              child: Container(
            //calculation area
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                AutoSizeText(
                  input,
                  style: TextStyle(
                      fontSize: inputSize.toDouble(),
                      color: Colors.black,
                      fontWeight: FontWeight.w400),
                  maxLines: 2,
                ),
                const SizedBox(
                  height: 20,
                ),
                AutoSizeText(
                  output,
                  style: TextStyle(
                      fontSize: outputSize.toDouble(),
                      color: Colors.black.withOpacity(0.7),
                      fontWeight: FontWeight.w400),
                  maxLines: 1,
                )
              ],
            ),
          )),
          Expanded(
              child: Container(
            color: operatorColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    button(text: 'C', tColor: orangeColor),
                    button(text: '(', tColor: orangeColor),
                    button(text: ')', tColor: orangeColor),
                    button(text: 'Del', tColor: orangeColor),
                    button(text: '/', tColor: orangeColor),
                  ],
                )),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    button(text: '7'),
                    button(text: '8'),
                    button(text: '9'),
                    button(text: '*', tColor: orangeColor),
                  ],
                )),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    button(text: '4'),
                    button(text: '5'),
                    button(text: '6'),
                    button(text: '-', tColor: orangeColor),
                  ],
                )),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    button(text: '1'),
                    button(text: '2'),
                    button(text: '3'),
                    button(text: '+', tColor: orangeColor),
                  ],
                )),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    button(text: '00'),
                    button(text: '0'),
                    button(text: '.'),
                    button(text: '=', buttonBgColor: orangeColor),
                  ],
                ))
              ],
            ),
          ))
        ],
      ),
    );
  }

  Widget button({
    text,
    tColor = Colors.white,
    buttonBgColor = buttonColor,
  }) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: buttonBgColor,
                padding:
                    const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                )),
            onPressed: () => onClick(text),
            onLongPress: () => onLongClick(text),
            child: FittedBox(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 24,
                  color: tColor,
                ),
              ),
            )),
      ),
    );
  }
}
