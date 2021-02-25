import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: new Home(),
    theme: ThemeData (
      cursorColor: Colors.green
    ),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = 'Informe seus dados';
  final isSelected = <bool>[true, false];

  void _resetFields() {
    weightController.text = '';
    heightController.text = '';
    setState(() {
      _infoText = 'Informe seus dados';
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);

      if (isSelected[0] == true) {
        if (imc < 20.7) _infoText = 'Abaixo do Peso (${imc.toStringAsPrecision(3)})';
        else if (imc >= 20.7 && imc <= 26.4) _infoText = 'Peso ideal (${imc.toStringAsPrecision(3)})';
        else if (imc >= 26.5 && imc <= 27.8) _infoText = 'Pouco acima do peso (${imc.toStringAsPrecision(3)})';
        else if (imc >= 27.9 && imc <= 31.1) _infoText = 'Acima do peso (${imc.toStringAsPrecision(3)})';
        else if (imc >= 31.2) _infoText = 'Obesidade (${imc.toStringAsPrecision(3)})';
      } else {
        if (imc < 19.1) _infoText = 'Abaixo do Peso (${imc.toStringAsPrecision(3)})';
        else if (imc >= 19.1 && imc <= 25.8) _infoText = 'Peso ideal (${imc.toStringAsPrecision(3)})';
        else if (imc >= 25.9 && imc <= 27.3) _infoText = 'Pouco acima do peso (${imc.toStringAsPrecision(3)})';
        else if (imc >= 27.4 && imc <= 32.3) _infoText = 'Acima do peso (${imc.toStringAsPrecision(3)})';
        else if (imc >= 32.4) _infoText = 'Obesidade (${imc.toStringAsPrecision(3)})';
      }

      if (imc < 18.6) {
        _infoText = 'Abaixo do Peso (${imc.toStringAsPrecision(3)})';
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de IMC'),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh), onPressed: _resetFields)
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.person_outline, size: 120.0, color: Colors.green),
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Insira seu Peso!';
                  } 
                },
                controller: weightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Peso (kg)',
                  labelStyle: TextStyle(color: Colors.green)
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
              ),
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Insira sua Altura!';
                  } 
                },
                controller: heightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Altura (cm)',
                  labelStyle: TextStyle(color: Colors.green),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green, width: 2.0),
                  ),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: ToggleButtons(
                      fillColor: Colors.green.shade400,
                      selectedColor: Colors.white,
                      selectedBorderColor: Colors.green,
                      borderRadius: BorderRadius.circular(4.0),
                      constraints: BoxConstraints(minHeight: 50.0, minWidth: 100.0),
                      onPressed: (index) {
                      // Respond to button selection
                        setState(() {
                          isSelected[index] = !isSelected[index]; 
                          if (index == 0) {
                            if (isSelected[0] == false) {
                              isSelected[1] = true;
                            } else if (isSelected[1] == true) {
                              isSelected[1] = false;
                              isSelected[0] = true;
                            }
                          } else {
                            if (isSelected[1] == false) {
                              isSelected[0] = true;
                            } else if (isSelected[0] == true) {
                              isSelected[1] = true;
                              isSelected[0] = false;
                            }
                          }
                        });
                      },
                      children: [
                        Text('Masculino'),
                        Text('Feminino')
                      ],
                      isSelected: isSelected,
                    ),
                  )
                ]
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Container(
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _calculate(); 
                      }
                    },
                    child: Text('Calcular', style: TextStyle(color: Colors.white, fontSize: 25.0),),
                    color: Colors.green,
                  ),
                ),
              ),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
              )
            ],
          ),
        )
      )
    );
  }
}