// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ClientiDao? _clientiDaoInstance;

  PrenotazioniDao? _prenotazioniDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Clienti` (`contatto` INTEGER NOT NULL, `name` TEXT NOT NULL, `nPrenotazioni` INTEGER NOT NULL, PRIMARY KEY (`contatto`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `prenotazioni` (`telefono` INTEGER NOT NULL, `data` INTEGER NOT NULL, `nPersone` INTEGER NOT NULL, FOREIGN KEY (`telefono`) REFERENCES `Clienti` (`contatto`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`telefono`, `data`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ClientiDao get clientiDao {
    return _clientiDaoInstance ??= _$ClientiDao(database, changeListener);
  }

  @override
  PrenotazioniDao get prenotazioniDao {
    return _prenotazioniDaoInstance ??=
        _$PrenotazioniDao(database, changeListener);
  }
}

class _$ClientiDao extends ClientiDao {
  _$ClientiDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _clientiInsertionAdapter = InsertionAdapter(
            database,
            'Clienti',
            (Clienti item) => <String, Object?>{
                  'contatto': item.contatto,
                  'name': item.name,
                  'nPrenotazioni': item.nPrenotazioni
                }),
        _clientiUpdateAdapter = UpdateAdapter(
            database,
            'Clienti',
            ['contatto'],
            (Clienti item) => <String, Object?>{
                  'contatto': item.contatto,
                  'name': item.name,
                  'nPrenotazioni': item.nPrenotazioni
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Clienti> _clientiInsertionAdapter;

  final UpdateAdapter<Clienti> _clientiUpdateAdapter;

  @override
  Future<Clienti?> findClienteByContatto(int numero) async {
    return _queryAdapter.query('SELECT * FROM clienti WHERE contatto = ?1',
        mapper: (Map<String, Object?> row) => Clienti(row['contatto'] as int,
            row['name'] as String, row['nPrenotazioni'] as int),
        arguments: [numero]);
  }

  @override
  Future<void> insertCliente(Clienti cliente) async {
    await _clientiInsertionAdapter.insert(cliente, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateCliente(Clienti cliente) async {
    await _clientiUpdateAdapter.update(cliente, OnConflictStrategy.abort);
  }
}

class _$PrenotazioniDao extends PrenotazioniDao {
  _$PrenotazioniDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _prenotazioniInsertionAdapter = InsertionAdapter(
            database,
            'prenotazioni',
            (Prenotazioni item) => <String, Object?>{
                  'telefono': item.telefono,
                  'data': _dateTimeConverter.encode(item.data),
                  'nPersone': item.nPersone
                }),
        _prenotazioniUpdateAdapter = UpdateAdapter(
            database,
            'prenotazioni',
            ['telefono', 'data'],
            (Prenotazioni item) => <String, Object?>{
                  'telefono': item.telefono,
                  'data': _dateTimeConverter.encode(item.data),
                  'nPersone': item.nPersone
                }),
        _prenotazioniDeletionAdapter = DeletionAdapter(
            database,
            'prenotazioni',
            ['telefono', 'data'],
            (Prenotazioni item) => <String, Object?>{
                  'telefono': item.telefono,
                  'data': _dateTimeConverter.encode(item.data),
                  'nPersone': item.nPersone
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Prenotazioni> _prenotazioniInsertionAdapter;

  final UpdateAdapter<Prenotazioni> _prenotazioniUpdateAdapter;

  final DeletionAdapter<Prenotazioni> _prenotazioniDeletionAdapter;

  @override
  Future<List<Prenotazioni?>> findPrenotazioniByData(DateTime data) async {
    return _queryAdapter.queryList('SELECT * FROM prenotazioni WHERE data = ?1',
        mapper: (Map<String, Object?> row) => Prenotazioni(
            row['telefono'] as int,
            _dateTimeConverter.decode(row['data'] as int),
            row['nPersone'] as int),
        arguments: [_dateTimeConverter.encode(data)]);
  }

  @override
  Future<List<Prenotazioni?>> findPrenotazioniByContatto(int numero) async {
    return _queryAdapter.queryList(
        'SELECT * FROM prenotazioni WHERE telefono = ?1',
        mapper: (Map<String, Object?> row) => Prenotazioni(
            row['telefono'] as int,
            _dateTimeConverter.decode(row['data'] as int),
            row['nPersone'] as int),
        arguments: [numero]);
  }

  @override
  Future<Prenotazioni?> findPrenotazione(
    int numero,
    DateTime data,
  ) async {
    return _queryAdapter.query(
        'SELECT * FROM prenotazioni WHERE telefono = ?1 AND data = ?2',
        mapper: (Map<String, Object?> row) => Prenotazioni(
            row['telefono'] as int,
            _dateTimeConverter.decode(row['data'] as int),
            row['nPersone'] as int),
        arguments: [numero, _dateTimeConverter.encode(data)]);
  }

  @override
  Future<void> insertPrenotazione(Prenotazioni prenotazione) async {
    await _prenotazioniInsertionAdapter.insert(
        prenotazione, OnConflictStrategy.abort);
  }

  @override
  Future<void> updatePrenotazione(Prenotazioni prenotazione) async {
    await _prenotazioniUpdateAdapter.update(
        prenotazione, OnConflictStrategy.abort);
  }

  @override
  Future<void> deletePrenotazione(Prenotazioni prenotazione) async {
    await _prenotazioniDeletionAdapter.delete(prenotazione);
  }
}

// ignore_for_file: unused_element
final _dateTimeConverter = DateTimeConverter();
