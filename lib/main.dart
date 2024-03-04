import 'package:flutter/material.dart';
import 'package:la_locanda/pages/splash.dart';
import 'package:la_locanda/repository/databaseRepository.dart';
import 'database/database.dart';
import 'package:provider/provider.dart';

Future<void> main() async {

WidgetsFlutterBinding.ensureInitialized();

final AppDatabase database =
  await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  
final databaseRepository = DatabaseRepository(database: database);

runApp(ChangeNotifierProvider<DatabaseRepository>(
    create: (context) => databaseRepository,
    child: MyApp(),
  ));
}//main

class MyApp extends StatelessWidget {
const MyApp({Key? key}) : super(key: key);
@override
Widget build(BuildContext context) {
return MaterialApp(
title: 'Prenotazioni',
theme: ThemeData(
  primaryColor: Colors.redAccent.shade700,
  primaryColorLight: Colors.redAccent.shade700,
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch:  Colors.red , // Imposta il colore principale per tutti i widget
    backgroundColor: const Color.fromARGB(255, 237, 233, 211), // Imposta il colore di sfondo per tutti i widget
    
  ),
),
home: const Splash(),
);
}//build
}//MyApp