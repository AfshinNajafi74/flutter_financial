// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $TransactionModelDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $TransactionModelDatabaseBuilderContract addMigrations(
      List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $TransactionModelDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<TransactionModelDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorTransactionModelDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $TransactionModelDatabaseBuilderContract databaseBuilder(
          String name) =>
      _$TransactionModelDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $TransactionModelDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$TransactionModelDatabaseBuilder(null);
}

class _$TransactionModelDatabaseBuilder
    implements $TransactionModelDatabaseBuilderContract {
  _$TransactionModelDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $TransactionModelDatabaseBuilderContract addMigrations(
      List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $TransactionModelDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<TransactionModelDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$TransactionModelDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$TransactionModelDatabase extends TransactionModelDatabase {
  _$TransactionModelDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  TransactionModelDao? _transactionModelDaoInstance;

  CategoryModelDao? _categoryModelDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `TransactionModel` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `dateTime` INTEGER NOT NULL, `name` TEXT NOT NULL, `amount` TEXT NOT NULL, `description` TEXT, `typeCategory` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `CategoryModel` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `typeCategory` INTEGER NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  TransactionModelDao get transactionModelDao {
    return _transactionModelDaoInstance ??=
        _$TransactionModelDao(database, changeListener);
  }

  @override
  CategoryModelDao get categoryModelDao {
    return _categoryModelDaoInstance ??=
        _$CategoryModelDao(database, changeListener);
  }
}

class _$TransactionModelDao extends TransactionModelDao {
  _$TransactionModelDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _transactionModelInsertionAdapter = InsertionAdapter(
            database,
            'TransactionModel',
            (TransactionModel item) => <String, Object?>{
                  'id': item.id,
                  'dateTime': item.dateTime,
                  'name': item.name,
                  'amount': item.amount,
                  'description': item.description,
                  'typeCategory': item.typeCategory.index
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<TransactionModel> _transactionModelInsertionAdapter;

  @override
  Future<List<TransactionModel>> getAllTransactionModel() async {
    return _queryAdapter.queryList('SELECT * FROM TransactionModel',
        mapper: (Map<String, Object?> row) => TransactionModel(
            id: row['id'] as int?,
            dateTime: row['dateTime'] as int,
            name: row['name'] as String,
            amount: row['amount'] as String,
            typeCategory: TypeCategory.values[row['typeCategory'] as int],
            description: row['description'] as String?));
  }

  @override
  Future<TransactionModel?> findTransactionModelByName(
      String transaction) async {
    return _queryAdapter.query(
        'SELECT * FROM TransactionModel WHERE transaction = ?1',
        mapper: (Map<String, Object?> row) => TransactionModel(
            id: row['id'] as int?,
            dateTime: row['dateTime'] as int,
            name: row['name'] as String,
            amount: row['amount'] as String,
            typeCategory: TypeCategory.values[row['typeCategory'] as int],
            description: row['description'] as String?),
        arguments: [transaction]);
  }

  @override
  Future<void> deleteTransactionModelByName(int id) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM TransactionModel WHERE id = ?1',
        arguments: [id]);
  }

  @override
  Future<void> insertTransactionModel(TransactionModel transactionModel) async {
    await _transactionModelInsertionAdapter.insert(
        transactionModel, OnConflictStrategy.abort);
  }
}

class _$CategoryModelDao extends CategoryModelDao {
  _$CategoryModelDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _categoryModelInsertionAdapter = InsertionAdapter(
            database,
            'CategoryModel',
            (CategoryModel item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'typeCategory': item.typeCategory.index
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<CategoryModel> _categoryModelInsertionAdapter;

  @override
  Future<List<CategoryModel>> getAllCategoryModel() async {
    return _queryAdapter.queryList('SELECT * FROM CategoryModel',
        mapper: (Map<String, Object?> row) => CategoryModel(
            id: row['id'] as int?,
            name: row['name'] as String,
            typeCategory: TypeCategory.values[row['typeCategory'] as int]));
  }

  @override
  Future<void> deleteCategoryModelByName(int id) async {
    await _queryAdapter.queryNoReturn('DELETE FROM CategoryModel WHERE id = ?1',
        arguments: [id]);
  }

  @override
  Future<void> insertCategoryModel(CategoryModel categoryModel) async {
    await _categoryModelInsertionAdapter.insert(
        categoryModel, OnConflictStrategy.abort);
  }
}
