import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseServices {
	final String name;
	String gameID;
	DataBaseServices({required this.name, required this.gameID});

	final CollectionReference games = Firestore.instance.collection("games");



	Future<bool> checkGameExistence() async {
		bool exist;
		QuerySnapshot qs;
			qs = await games.where("name", isEqualTo: name).getDocuments();

		if(qs.documents.length >= 1) {
			exist = true;
		} else {
			exist = false;
		}
		return exist;
	}

	Future<String> insertGame() async {
		final ref = await games.add({
			"name": name,
			"current_move": null,
			"last_move": null,
			"player1": null,
			"player2": null,
			"player3": null,
			"player4": null,
			"player5": null,
			"player6": null,
			"player7": null,
			"player8": null,
			"round_number": 0,
			"score1": 0,
			"score2": 0,
			"cnt_players": 0,
		});
	  gameID = ref.documentID;
    return gameID;
  }

	Future<bool> checkAvailability() async {
	 QuerySnapshot qs;

			qs = await games.where("name", isEqualTo: name).getDocuments();

		if( qs.documents.length == 0) {
			return false;
		}
		return (qs.documents[0].data["cnt_players"] < 4);
	}

	Future<String> getGameID() async {
		QuerySnapshot qs;

			qs = await games.where("name", isEqualTo: name).getDocuments();

		gameID = qs.documents[0].documentID;
		return gameID;
	}

	Future updatePlayers() async {
		QuerySnapshot qs;

			qs = await games.where("name", isEqualTo: name).getDocuments();

		int currentCount = qs.documents[0].data["cnt_players"];
		int newCount = currentCount + 1;
		await games.document(qs.documents[0].documentID).updateData({
			"cnt_players": newCount,
		});
	}
}