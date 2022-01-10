import 'package:flutter/material.dart';
import 'package:flutter_card_game_updated/classes/input_box.dart';
import 'package:flutter_card_game_updated/classes/pop_up.dart';
import 'package:flutter_card_game_updated/functions/create_game.dart';
import 'package:flutter_card_game_updated/functions/join_game.dart';

class SelectGame extends StatefulWidget {
  @override
  _SelectGameState createState() => _SelectGameState();
}

class _SelectGameState extends State<SelectGame> {

  final _formKeyCreate = GlobalKey<FormState>();
  final _formKeyJoin = GlobalKey<FormState>();

  late String _createName;
  late String _joinName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Game"),
        backgroundColor: Colors.grey[800],
      ),
      backgroundColor: Colors.white10,
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
          children: <Widget>[
            Form(
              key: _formKeyCreate,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    validator: (val){
                      if (val != null ) {
                        return val.isEmpty ? "Enter name" : null;
                      }

                    },
                    onChanged: (val) {
                      setState(() {
                        _createName = val;
                      });
                    },
                    decoration: inputBox("Enter name"),
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 20.0,),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    color: Colors.grey[500],
                    child: Text("Create new game"),
                    onPressed: () async {
                      if(_formKeyCreate.currentState?.validate() ?? false) {
                        String res = await createGame(_createName);
                        if(res != "No errors") {
                          popUp(context, res);
                        }
                        else {
                          Navigator.popAndPushNamed(context, "/select");
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0,),
            Form(
              key: _formKeyJoin,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    validator: (val){
                      return val!.isEmpty ? "Enter name" : null;
                    },
                    onChanged: (val) {
                      setState(() {
                        _joinName = val;
                      });
                    },
                    decoration: inputBox("Enter name"),
                    style: TextStyle(color: Colors.white, backgroundColor: Colors.transparent),
                  ),
                  SizedBox(height: 20.0,),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    color: Colors.grey[500],
                    child: Text("Join game"),
                    onPressed: () async {
                      if(_formKeyJoin.currentState!.validate()) {
                        String res = await joinGame(_joinName);
                        if(res != "No errors") {
                          popUp(context, res);
                        }
                        else {
                          Navigator.of(context).popAndPushNamed("/select");
                        }
                      }
                    },
                  ),
                ],
              )
            )
          ],
          ),
      ),
    );
  }
}