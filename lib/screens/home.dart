import 'package:flutter/material.dart';
import '../const.dart';
import 'login.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class MyHomePage extends StatefulWidget {

  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // DadosLogin _dados = DadosLogin();


    // if (_dados.userLogin=="") {
    //   Navigator.pushNamed(
    //     context,
    //     '/login',
    //   );
    // }

    return Scaffold(
      appBar: AppBar(
        // leading: Image.asset(
        //   'images/logo.png',
        //   height: 30,
        // ),
        title: Text(Const.titleApp),
        actions: <Widget>[
          // IconButton(
          //   icon: Icon(Icons.add_circle_outline),
          //   tooltip: 'Trocar',
          //   onPressed: () {
          //     _incrementCounter();
          //     // handle the press
          //   },
          // ),
          // IconButton(
          //   icon: Icon(Icons.search),
          //   tooltip: 'Localizar Escambo',
          //   onPressed: () {
          //     _incrementCounter();
          //     // handle the press
          //   },
          // ),
          IconButton(
            icon: Icon(Icons.logout),
            tooltip: AppLocalizations.of(context).logoffButton,
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ),
              );
            }
          ),
        ],
      ),
      body:
            GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              crossAxisCount: 1,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                            '$_counter',
                            style: Theme.of(context).textTheme.headline4,
                          ),
                  color: Colors.green[100],
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
