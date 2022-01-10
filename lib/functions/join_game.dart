import 'package:flutter_card_game_updated/classes/authentication.dart';
import 'package:flutter_card_game_updated/classes/database.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String> joinGame(String name) async {

  DataBaseServices db = new DataBaseServices(name: name, gameID: '');

  bool alreadyExist = await db.checkGameExistence();
	if(alreadyExist == false) {
		return "Game does not exist";
	}

  bool spotAvailable = await db.checkAvailability();
  if(spotAvailable == false) {
    return "Game full";
  }

  String gameID = await db.getGameID();

  db.updatePlayers();

  final Authentication _auth = Authentication(gameID: gameID);
  dynamic res = await _auth.signIn();
  if(res == null) {
    return "Sign-in failed, create with new game name";
  }

  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("gameID", gameID);
  prefs.setString("uid", res.uid);

  return "No errors";

}