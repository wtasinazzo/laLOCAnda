import 'package:la_locanda/database/database.dart';
import 'package:la_locanda/database/entities/entities.dart';
import 'package:flutter/material.dart';

class DatabaseRepository extends ChangeNotifier {
  //The state of the database is just the AppDatabase
  final AppDatabase database;

  //Default constructor
  DatabaseRepository({required this.database});

  //This method wraps the findAllCoupons() method of the DAO
  Future<void> insertCliente(Clienti cliente) async {
    await database.clientiDao.insertCliente(cliente);
    notifyListeners();
  } //findAllCoupons

  //This method wraps the insertCoupons() method of the DAO.
  //Then, it notifies the listeners that something changed.
  Future<void> updateCliente(Clienti cliente) async {
    await database.clientiDao.updateCliente(cliente);
    notifyListeners();
  } //insertCoupons

  //This method wraps the deleteCoupon() method of the DAO.
  //Then, it notifies the listeners that something changed.
  Future<Clienti?> findClienteByContatto(int numero) async {
    final result = await database.clientiDao.findClienteByContatto(numero);
    return result;
  } //deleteCoupons

  //This method wraps the findAllTrainings() method of the DAO
  Future<List<Prenotazioni?>> findPrenotazioniByData(DateTime data) async {
    final results = await database.prenotazioniDao.findPrenotazioniByData(data);
    return results;
  } //findAllTrainings

  Future<List<Prenotazioni?>> findPrenotazioniByContatto(int numero) async {
    final results = await database.prenotazioniDao.findPrenotazioniByContatto(numero);
    return results;
  }

  Future<Prenotazioni?> findPrenotazione(int numero, DateTime data) async{
    final result = await database.prenotazioniDao.findPrenotazione(numero,data);
    return result;
  }

  Future<void> insertPrenotazione(Prenotazioni prenotazione) async {
    await database.prenotazioniDao.insertPrenotazione(prenotazione);
    notifyListeners();
  }

  Future<void> deletePrenotazione(Prenotazioni prenotazione) async {
    await database.prenotazioniDao.deletePrenotazione(prenotazione);
    notifyListeners();
  }

  Future<void> updatePrenotazione(Prenotazioni prenotazione) async {
    await database.prenotazioniDao.updatePrenotazione(prenotazione);
    notifyListeners();
  }
} //DatabaseRepository
