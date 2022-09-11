import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'one_key.dart';

// en este widget mostramos el keypad y los valores de las monedas
class KeyPad extends StatefulWidget {
  const KeyPad(
      {Key? key,
      required this.textCurrency1,
      required this.textCurrency2,
      required this.rate})
      : super(key: key);

  // estos tres valores son recibidos de converter_page
  final String textCurrency1;
  final String textCurrency2;
  final double rate;

  @override
  State<KeyPad> createState() => _KeyPadState();
}

class _KeyPadState extends State<KeyPad> {
  // valor de la moneda convertida
  double _currency2 = 0;
  // el valor de la moneda que es introducida en el keypad
  int _currency1 = 0;
  // cadena que representa el número ingresado
  String strCurrency = '';

  // función que cambia el estado del widget (_currency1, _currency2)
  void _onPressed(int k) {
    setState(() {
      if (k == 10) {
        // Significa que se presionó reset button
        _currency1 = 0;
        _currency2 = 0;
        strCurrency = '';
      } else {
        // _currency1 debe cambiar con el keypad
        // _currency2 debe cambiar de acuerdo con _currency1 y la tasa de cambio
        strCurrency += k.toString();
        _currency1 = int.parse(strCurrency);
        _currency2 = _currency1 * widget.rate;
      }
    });
  }

  // Método que da formato a los números
  String formatCurrency(double num) {
    final formatter = NumberFormat('###,###,###,###.##', 'es_CO');
    return formatter.format(num);
  }

  @override
  void didUpdateWidget(covariant oldWidget) {
    super.didUpdateWidget(oldWidget);
    // aquí garantizamos que cuando el widget refresca el estado va a cero
    _currency1 = 0;
    _currency2 = 0;
    strCurrency = '';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.textCurrency1,
                style:
                    const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Container(),
            ),
            Container(
                padding: const EdgeInsets.all(8.0),
                alignment: Alignment.centerRight,
                child: Text(
                  formatCurrency(double.parse(_currency1.toString())),
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green[800],
                      fontSize: 35),
                )),
          ],
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.textCurrency2,
                style:
                    const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Container(),
            ),
            Container(
                padding: const EdgeInsets.all(8.0),
                alignment: Alignment.centerRight,
                child: Text(
                  formatCurrency(double.parse(_currency2.toString())),
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green[800],
                      fontSize: 35),
                ))
          ],
        ),

        // Fila de números
        Expanded(
          flex: 1,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                // en cada OneKey se manda el número y _onPressed para callback
                OneKey(number: 7, callback: _onPressed),
                OneKey(number: 8, callback: _onPressed),
                OneKey(number: 9, callback: _onPressed),
              ]),
        ),
        Expanded(
          flex: 1,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                // en cada OneKey se manda el número y _onPressed para callback
                OneKey(number: 4, callback: _onPressed),
                OneKey(number: 5, callback: _onPressed),
                OneKey(number: 6, callback: _onPressed),
              ]),
        ),
        Expanded(
          flex: 1,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                // en cada OneKey se manda el número y _onPressed para callback
                OneKey(number: 1, callback: _onPressed),
                OneKey(number: 2, callback: _onPressed),
                OneKey(number: 3, callback: _onPressed),
              ]),
        ),
        Expanded(
          flex: 1,
          child: Row(children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(11, 8, 11, 8),
                child: MaterialButton(
                  key: const Key("reset"),
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  color: Colors.red,
                  onPressed: () {
                    _onPressed(10);
                  },
                  child: const Text(
                    "Reset",
                    style: TextStyle(
                        fontSize: 28.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            // en cada OneKey se manda el número y _onPressed para callback
            OneKey(number: 0, callback: _onPressed),
          ]),
        )
      ],
    );
  }
}
