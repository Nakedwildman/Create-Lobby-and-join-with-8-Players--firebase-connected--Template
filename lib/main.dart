import 'screens/select_game.dart';
import 'screens/game.dart';
import 'screens/select_player.dart';
import 'package:flutter/material.dart';
import 'dart:async';


Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Montserrat'
    ),
    initialRoute: '/',    //HomeRoute
    routes: {
      '/': (context) => SelectGame(),
      '/select': (context) => SelectPlayer(),
      '/game': (context) => Game(),
      '/divide':(context) => SelectGame()
    },
  )
  );

}

