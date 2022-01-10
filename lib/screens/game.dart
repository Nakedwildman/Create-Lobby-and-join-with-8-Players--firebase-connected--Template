import 'package:flutter/material.dart';
import 'dart:math';
import 'cardspread.dart';

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Card Game',
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.amber,
      ),

    );

  }
}

class CardSpreadPage extends StatefulWidget {
  CardSpreadPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _CardSpreadPageState createState() => _CardSpreadPageState();
}

class _CardSpreadPageState extends State<CardSpreadPage> {
  var randomEngine = Random.secure();
  bool _reveal = false;
  int _cardsSeed = 0;
  int _cardsCount = 9;

  @override
  void initState() {
    super.initState();
  }

  void dealNewCards() {
    setState(() {
      _generateNewSeed();
    });
  }

  void setSpread(int spread) {
    setState(() {
      _cardsCount = spread;
      _generateNewSeed();
    });
  }

  reveal() {
    setState(() {
      _reveal = true;
    });
  }

  _generateNewSeed() {
    _cardsSeed = randomEngine.nextInt(1000000000);
    _reveal = false;
  }

  Widget buildCardsRow() {
    return CardSpread(
        key: ValueKey(_cardsSeed), spread: _cardsCount, reveal: _reveal);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildCardsRow(),
              SizedBox(height: 20),
              _reveal == true
                  ? RaisedButton(
                  onPressed: () {
                    dealNewCards();
                  },
                  color: Theme.of(context).accentColor,
                  child: Text("Draw new cards",
                      style: Theme.of(context).textTheme.headline6))
                  : RaisedButton(
                  onPressed: () {
                    reveal();
                  },
                  color: Theme.of(context).accentColor,
                  child: Text("Reveal",
                      style: Theme.of(context).textTheme.headline6)),
            ]),
      ),
    );
  }
}
Map<String, double> dataMap = {
  "Flutter": 5,
  "React": 3,
  "Xamarin": 2,
  "Ionic": 2,
};