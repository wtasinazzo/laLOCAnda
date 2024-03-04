import 'package:la_locanda/database/entities/entities.dart';
import 'package:floor/floor.dart';

//Here, we are saying that the following class defines a dao.

@dao
abstract class ClientiDao{

  //Query #1: INSERT -> this allows to add a Coupons in the table
  @insert
  Future<void> insertCliente(Clienti cliente);

  //Query #2: UPDATE -> this allows to add a Coupons from the table
  @update
  Future<void> updateCliente(Clienti cliente);

  @Query('SELECT * FROM clienti WHERE contatto = :numero')
  Future<Clienti?> findClienteByContatto(int numero);
} //CouponsDao

@dao
abstract class PrenotazioniDao {
  //Query #1: SELECT 
  @Query('SELECT * FROM prenotazioni WHERE data = :data')
  Future<List<Prenotazioni?>> findPrenotazioniByData(DateTime data);

  @Query('SELECT * FROM prenotazioni WHERE telefono = :numero')
  Future<List<Prenotazioni?>> findPrenotazioniByContatto(int numero);

  @Query('SELECT * FROM prenotazioni WHERE telefono = :numero AND data = :data')
  Future<Prenotazioni?> findPrenotazione(int numero, DateTime data);

  //Query #2: INSERT -> this allows to add a Training in the table
  @insert
  Future<void> insertPrenotazione(Prenotazioni prenotazione);

  //Query #3: DELETE -> this allows to delete a Training from the table
  @delete
  Future<void> deletePrenotazione(Prenotazioni prenotazione);

  @update
  Future<void> updatePrenotazione(Prenotazioni prenotazione);


}

