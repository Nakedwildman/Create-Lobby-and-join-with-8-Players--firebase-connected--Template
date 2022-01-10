import 'dart:math';
import 'package:flutter/material.dart';
import 'card.dart';

class CardsDraw {
  CardsDraw(this.cardCount);
  final int cardCount;

  List<int> draw(int cardsToDraw, {int? seed}) {
    if (cardsToDraw > this.cardCount) {
      throw Exception("Cannot draw more than the number of cards");
    }

    var cards = List<int>.generate(cardCount, (int index) => index);

    var random = Random();
    random = Random(seed);

    cards.shuffle(random);

    return cards.sublist(0, cardsToDraw);
  }
}

class CardSpread extends StatefulWidget {
  CardSpread({Key? key, required this.spread, this.reveal = false}) : super(key: key);
  final int spread;
  final bool reveal;

  @override
  _CardSpreadState createState() => _CardSpreadState();
}

class _CardSpreadState extends State<CardSpread> {
  late List<CardSide> _cardsSide;

  @override
  void initState() {
    _cardsSide = List<CardSide>.filled(widget.spread, CardSide.BackSide);
    super.initState();
  }

  @override
  void didUpdateWidget(CardSpread oldWidget) {
    if (widget.reveal) {
      _cardsSide = List<CardSide>.filled(widget.spread, CardSide.FrontSide);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    var draw = CardsDraw(55);
    var cards = draw.draw(widget.spread, seed: widget.key.hashCode);
    final Key cardKey = new Key('__key__');

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: List<Widget>.generate(
        widget.spread,
            (i) => FlipCard(frontImage: Image.asset("images/card-" + (1+cards[i]).toString() + ".png"), backImage: Image.asset("images/back.png"),side : _cardsSide[i], onTap: (side) {
          if (side == CardSide.BackSide) {
            setState(() {
              _cardsSide[i] = CardSide.FrontSide;
            });
          }
        }, key: cardKey,),
      ),
    );
  }
}
