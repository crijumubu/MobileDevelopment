import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      title: 'Calculator',
      theme: ThemeData(

        primarySwatch: Colors.grey,
        fontFamily: 'SegueUI',
        appBarTheme: const AppBarTheme(

          iconTheme: IconThemeData(color: Colors.white),
          foregroundColor: Colors.white,
          titleTextStyle: TextStyle(fontSize: 22.5, fontWeight: FontWeight.bold)
        ),
      ),
      home: const MyHomePage(title: 'Calculator'),
      debugShowCheckedModeBanner: false,
    );
  }
}

// Logica de la calculadora

final TextEditingController _buttonController = TextEditingController();

void _updateValue(String newValue){
  _buttonController.value = _buttonController.value.copyWith(
      text: newValue,
      selection: TextSelection.collapsed(offset: newValue.length)
  );
}

void buttonPress(int value){

  String updatedText;

  if (operationDone){
    updatedText = value.toString();
    operationDone = false;
  }else{
    updatedText = _buttonController.text + value.toString();
  }

  _updateValue(updatedText);
}

bool operationDone = false;
void operations(String character){

  if (_buttonController.text.isNotEmpty){

    final actualText = _buttonController.text;

    switch(character){
      case '%':
        _updateValue(actualText + character);
        break;
      case '÷':
        _updateValue(actualText + character);
        break;
      case '×':
        _updateValue(actualText + character);
        break;
      case '-':
        _updateValue(actualText + character);
        break;
      case '+':
        _updateValue(actualText + character);
        break;
      case '=':

        String operation = _buttonController.text;
        operation = operation.replaceAll('×', '*');

        String answer;

        try{
          Parser p = Parser();
          Expression expression = p.parse(operation);
          ContextModel contextModel = ContextModel();
          double evaluation = expression.evaluate(EvaluationType.REAL, contextModel);
          answer = evaluation.toString();
        } catch(e){
          answer = 'ERROR';
        }

        _updateValue(answer);
        operationDone = true;

        break;
      case '.':
        _updateValue(actualText + character);
        break;
    }
  }
}

void allClear(){
  const updatedText = '';
  _updateValue(updatedText);
}

void clearEntry(){
  final actualText = _buttonController.text;
  if (actualText.isNotEmpty){
    String updatedText = actualText.substring(0, actualText.length - 1);
    _updateValue(updatedText);
  }
}

class MyHomePage extends StatefulWidget {

  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Padding(

              padding: const EdgeInsets.only(top: 0, right: 50, bottom: 50, left: 50),

              child: TextFormField(
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                    border: UnderlineInputBorder()
                ),
                keyboardType: TextInputType.number,
                controller: _buttonController,
                  style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 20.0),
              ),
            ),

            Row(

              mainAxisAlignment: MainAxisAlignment.center,

              children: [

                Container(
                  margin: const EdgeInsets.all(8),
                  child: ElevatedButton(
                      style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.orange)),
                      onPressed: () {
                    allClear();
                  }, child: const Text('AC', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white))),
                ),

                Container(
                  margin: const EdgeInsets.all(8),
                  child: ElevatedButton(
                      style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.orange)),
                      onPressed: () {
                    clearEntry();
                  }, child: const Text('CE', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white))),
                ),

                Container(
                  margin: const EdgeInsets.all(8),
                  child: ElevatedButton(onPressed: () {
                    operations('%');
                  }, child: const Text('%', style: TextStyle(color: Colors.white))),
                ),

                Container(
                  margin: const EdgeInsets.all(8),
                  child: ElevatedButton(onPressed: () {
                    operations('÷');
                  }, child: const Text('÷', style: TextStyle(color: Colors.white))),
                ),
              ],
            ),

            Row(

              mainAxisAlignment: MainAxisAlignment.center,

              children: [

                Container(
                  margin: const EdgeInsets.all(8),
                  child: ElevatedButton(onPressed: () {
                    buttonPress(7);
                  }, child: const Text('7', style: TextStyle(color: Colors.white))),
                ),

                Container(
                  margin: const EdgeInsets.all(8),
                  child: ElevatedButton(onPressed: () {
                    buttonPress(8);
                  }, child: const Text('8', style: TextStyle(color: Colors.white))),
                ),

                Container(
                  margin: const EdgeInsets.all(8),
                  child: ElevatedButton(onPressed: () {
                    buttonPress(9);
                  }, child: const Text('9', style: TextStyle(color: Colors.white))),
                ),

                Container(
                  margin: const EdgeInsets.all(8),
                  child: ElevatedButton(onPressed: () {
                    operations('×');
                  }, child: const Text('×', style: TextStyle(color: Colors.white))),
                ),
              ],
            ),

            Row(

                mainAxisAlignment: MainAxisAlignment.center,

                children: [

                  Container(
                    margin: const EdgeInsets.all(8),
                    child: ElevatedButton(onPressed: () {
                      buttonPress(4);
                    }, child: const Text('4', style: TextStyle(color: Colors.white))),
                  ),

                  Container(
                    margin: const EdgeInsets.all(8),
                    child: ElevatedButton(onPressed: () {
                      buttonPress(5);
                    }, child: const Text('5', style: TextStyle(color: Colors.white))),
                  ),

                  Container(
                    margin: const EdgeInsets.all(8),
                    child: ElevatedButton(onPressed: () {
                      buttonPress(6);
                    }, child: const Text('6', style: TextStyle(color: Colors.white))),
                  ),

                  Container(
                    margin: const EdgeInsets.all(8),
                    child: ElevatedButton(onPressed: () {
                      operations('-');
                    }, child: const Text('-', style: TextStyle(color: Colors.white))),
                  ),
                ]
            ),

            Row(

              mainAxisAlignment: MainAxisAlignment.center,

              children: [

                Column(

                  children: [

                    Row(

                        children: [

                          Container(
                            margin: const EdgeInsets.all(8),
                            child: ElevatedButton(onPressed: () {
                              buttonPress(1);
                            }, child: const Text('1', style: TextStyle(color: Colors.white))),
                          ),

                          Container(
                            margin: const EdgeInsets.all(8),
                            child: ElevatedButton(onPressed: () {
                              buttonPress(2);
                            }, child: const Text('2', style: TextStyle(color: Colors.white))),
                          ),

                          Container(
                            margin: const EdgeInsets.all(8),
                            child: ElevatedButton(onPressed: () {
                              buttonPress(3);
                            }, child: const Text('3', style: TextStyle(color: Colors.white))),
                          ),
                        ]
                    ),

                    Row(

                      children: [

                        Container(
                          margin: const EdgeInsets.all(8),
                          child: ElevatedButton(onPressed: () {
                            buttonPress(0);
                          }, child: const Text('0', style: TextStyle(color: Colors.white))),
                        ),

                        Container(
                          margin: const EdgeInsets.all(8),
                          child: ElevatedButton(onPressed: () {
                            operations('.');
                          }, child: const Text('.', style: TextStyle(color: Colors.white))),
                        ),

                        Container(
                          margin: const EdgeInsets.all(8),
                          child: ElevatedButton(onPressed: () {
                            operations('=');
                          }, child: const Text('=', style: TextStyle(color: Colors.white))),
                        ),
                      ],
                    ),
                  ],
                ),

                Column(

                  children: [

                    Container(

                      margin: const EdgeInsets.all(8),
                      child: SizedBox(
                        width: 65,
                        height: 100,
                        child: ElevatedButton(onPressed: () {
                          operations('+');
                        }, child: const Text('+', style: TextStyle(color: Colors.white))),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}