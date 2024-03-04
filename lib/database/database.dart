//Imports that are necessary to the code generator of floor
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

//Here, we are importing the entities and the daos of the database
import 'daos/daos.dart';
import 'entities/entities.dart';
import 'typeConverters/dateTimeConverter.dart';

//The generated code will be in database.g.dart
part 'database.g.dart';

//Here we are saying that this is the first version of the Database 
@TypeConverters([DateTimeConverter])
@Database(version: 1, entities: [Clienti, Prenotazioni])
abstract class AppDatabase extends FloorDatabase {
  //Add all the daos as getters here
  ClientiDao get clientiDao;
  PrenotazioniDao get prenotazioniDao;
}//AppDatabase

