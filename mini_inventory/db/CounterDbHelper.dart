import 'dart:io';

import 'package:mini_inventory/mini_inventory/model/CounterCatModel.dart';
import 'package:mini_inventory/mini_inventory/model/CounterChangeLog.dart';
import 'package:mini_inventory/mini_inventory/model/CounterModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:synchronized/synchronized.dart';

class CounterDbHelper {

  static final _databaseName = "AppCounterDB.db";
  static final _databaseVersion = 1;

  //
  static final Table_CounterCat = 'CounterCatModel';
  static final Column_counterCatId = 'counterCatId';
  static final Column_counterCatTitle = 'counterCatTitle';
  static final Column_counterCatIsActive = 'counterCatIsActive';

  //
  static final Table_CounterModel = 'CounterModel';
  static final Column_counterId = 'counterId';
  static final Column_counterTitle = 'counterTitle';
  static final Column_counterValue = 'counterValue';
  static final Column_counterIsActive = 'counterIsActive';

  static final Column_createDate = 'createDate';
  static final Column_updateDate = 'updateDate';

  //
  static final Table_CounterChangeLog = 'CounterChangeLog';

  static final Column_counterChangeLogId = 'counterChangeLogId';
  static final Column_counterChangeType = 'counterChangeType';
  static final Column_counterDelta = 'counterDelta';

  //
  CounterDbHelper._privateConstructor();
  static final CounterDbHelper instance = CounterDbHelper._privateConstructor();



  //
  static Database _database = null;
  Future<Database> get database async {

    if (_database != null) return _database;

    //_database = await lock.synchronized (() async {

      print("get database async...0...:: _database == ${_database}");

    await Future.delayed(const Duration(seconds: 2), () async{

      if (_database == null) {
        // lazily instantiate the db the first time it is accessed
        print("get database async...1...:: need init db...");
        _database = await _initDatabase();
      }
      else {
        print("get database async...2...:: NO need init db...");
      }

    });



      print("get database async...10...:: _database == ${_database}");

      return _database;

    //});

    print("get database async...20...:: _database == ${_database}");

    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  Future<Database> _initDatabase() async {

    print("_initDatabase...0...");

    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    print("_initDatabase...10...${documentsDirectory}...");
    String path = join(documentsDirectory.path, _databaseName);
    print("_initDatabase...20...${path}");
    //Sqflite.setDebugModeOn(true);
    print("_initDatabase...30...");
    Database db = await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
    print("_initDatabase...40...");
    print("_initDatabase...50...:: db == ${db}");
    print("_initDatabase...60...");
    return db;
  }

  //
  Future _onCreate(Database db, int version) async {

    print("_onCreate...0...");

    await db.execute('''
          CREATE TABLE $Table_CounterCat (
            $Column_counterCatId INTEGER PRIMARY KEY AUTOINCREMENT,
            $Column_counterCatTitle TEXT NOT NULL,
            $Column_counterCatIsActive INTEGER NOT NULL
          )
          ''');

    print("_onCreate...10...");

    await db.execute('''
          CREATE TABLE $Table_CounterModel (
            
            $Column_counterId INTEGER PRIMARY KEY AUTOINCREMENT,
            $Column_counterCatId INTEGER NOT NULL,
            $Column_counterTitle TEXT NOT NULL,
            $Column_counterValue INTEGER  NOT NULL,
            $Column_counterIsActive INTEGER NOT NULL,
            $Column_createDate REAL NOT NULL,
            $Column_updateDate REAL NOT NULL
          )
          ''');

    print("_onCreate...20...");

    await db.execute('''
          CREATE TABLE $Table_CounterChangeLog (
            $Column_counterChangeLogId INTEGER PRIMARY KEY AUTOINCREMENT,
            $Column_counterId INTEGER NOT NULL,
            $Column_counterChangeType TEXT NOT NULL,
            $Column_counterDelta INTEGER NOT NULL,
            $Column_counterValue INTEGER  NOT NULL,
            $Column_updateDate REAL NOT NULL
          )
          ''');

    print("_onCreate...30...");
    await insertSomeSampleRowsIfNeeded();
    print("_onCreate...40...");

  }



  Future<void> insertSomeSampleRowsIfNeeded() async {

    //await resetDb(); return;

    Database db;
    try {
      db = await instance.database;
      bool is_db_empty = await isDbEmpty(db);
      if (is_db_empty) {
        await insertSomeSampleRows(db);
      }
      else {
        print('dd NOT empty, no need insert sample rows...');
      }
    }
    catch(err) {
      print(err);
    }
    finally {
      try {
        // await db.close();
      }
      catch(_) {  }
    }




  }

  Future<bool> isDbEmpty(Database db) async {

    int cnt_counter_cat = await CounterCat_queryRowCount(db);
    int cnt_counter = await Counter_queryRowCount(db);
    int cnt_counter_changelog = await CounterChangeLog_queryRowCount(db);

    return (cnt_counter_cat == 0 && cnt_counter == 0 && cnt_counter_changelog ==0);
  }

  Future<void> insertSomeSampleRows(Database db) async {

    return await db.transaction((txn) async {

      CounterCatModel counterCat = CounterCatModel(
        counterCatTitle: '衣物',
        counterCatIsActive: true,
      );

      int cat_id = await txn.insert(Table_CounterCat, counterCat.toMap());
      counterCat = counterCat.copyWith(counterCatId: cat_id);

      print('txn insert :: cat_id == ${cat_id}');

      CounterModel counterWhiteShirt = CounterModel(
          counterCatId: counterCat.counterCatId,
          counterTitle: '內衣 (白色)',
          counterIsActive: true,
          createDate: DateTime.now(),
          updateDate: DateTime.now(),
      );

      CounterModel counterGreyShirt = CounterModel(
          counterCatId: counterCat.counterCatId,
          counterTitle: '內衣 (灰色)',
          counterIsActive: true,
          createDate: DateTime.now(),
          updateDate: DateTime.now(),
      );

      CounterModel counterWhiteTrouser = CounterModel(
          counterCatId: counterCat.counterCatId,
          counterTitle: '內裤 (白色)',
          counterIsActive: true,
          createDate: DateTime.now(),
          updateDate: DateTime.now(),
      );

      CounterModel counterGreyTrouser = CounterModel(
          counterCatId: counterCat.counterCatId,
          counterTitle: '內裤 (灰色)',
          counterIsActive: true,
          createDate: DateTime.now(),
          updateDate: DateTime.now(),
      );

      int WhiteShirt_id = await txn.insert(Table_CounterModel, counterWhiteShirt.toMap());
      counterWhiteShirt = counterWhiteShirt.copyWith(counterId: WhiteShirt_id);

      int GreyShirt_id = await txn.insert(Table_CounterModel, counterGreyShirt.toMap());
      counterGreyShirt = counterGreyShirt.copyWith(counterId: GreyShirt_id);

      int WhiteTrouser_id = await txn.insert(Table_CounterModel, counterWhiteTrouser.toMap());
      counterWhiteTrouser = counterWhiteTrouser.copyWith(counterId: WhiteTrouser_id);

      int GreyTrouser_id = await txn.insert(Table_CounterModel, counterGreyTrouser.toMap());
      counterGreyTrouser = counterGreyTrouser.copyWith(counterId: GreyTrouser_id);


      //
      CounterChangeLog changeLogWhiteShirt = new CounterChangeLog(
          counterId: counterWhiteShirt.counterId,
          counterChangeType: CounterChangeLog.TYPE_initialValue,
          counterDelta: counterWhiteShirt.counterValue,
          counterValue: counterWhiteShirt.counterValue,
          updateDate: DateTime.now()
      );

      CounterChangeLog_insert(txn, changeLogWhiteShirt.toMap());

      //
      CounterChangeLog changeLogGreyShirt = new CounterChangeLog(
          counterId: counterGreyShirt.counterId,
          counterChangeType: CounterChangeLog.TYPE_initialValue,
          counterDelta: counterGreyShirt.counterValue,
          counterValue: counterGreyShirt.counterValue,
          updateDate: DateTime.now()
      );

      CounterChangeLog_insert(txn, changeLogGreyShirt.toMap());

      //
      CounterChangeLog changeLogWhiteTrouser = new CounterChangeLog(
          counterId: counterWhiteTrouser.counterId,
          counterChangeType: CounterChangeLog.TYPE_initialValue,
          counterDelta: counterWhiteTrouser.counterValue,
          counterValue: counterWhiteTrouser.counterValue,
          updateDate: DateTime.now()
      );

      CounterChangeLog_insert(txn, changeLogWhiteTrouser.toMap());

      //
      CounterChangeLog changeLogGreyTrouser = new CounterChangeLog(
          counterId: counterGreyTrouser.counterId,
          counterChangeType: CounterChangeLog.TYPE_initialValue,
          counterDelta: counterGreyTrouser.counterValue,
          counterValue: counterGreyTrouser.counterValue,
          updateDate: DateTime.now()
      );

      CounterChangeLog_insert(txn, changeLogGreyTrouser.toMap());

    });

  }


  ////////////////////////////////////////////////////////////

  Future<int> CounterCat_insert(Map<String, dynamic> row) async {

    Database db;
    try {
      db = await instance.database;
      return await db.insert(Table_CounterCat, row);
    }
    finally {
      try {
        // await db.close();
      }
      catch(_) {  }
    }

  }

  Future<int> CounterCat_queryRowCount(Database db) async {

    Database db;
    try {
      db = await instance.database;

      return (await db.rawQuery('''
        select count(*) as cnt from $Table_CounterCat
        ''')).toList().first['cnt'];
    }
    finally {
      try {
        // await db.close();
      }
      catch(_) {  }
    }


  }

  Future<List<Map<String, dynamic>>> CounterCat_queryRowById(int counterCatId) async {

    Database db;
    try {
      db = await instance.database;
      return await db.rawQuery('''
        select * from $Table_CounterCat
        where $Column_counterCatId = $counterCatId
        ''');
    }
    finally {
      try {
        // await db.close();
      }
      catch(_) {  }
    }
  }

  Future<List<Map<String, dynamic>>> CounterCat_queryRows({bool inclOnlyActive}) async {

    print("CounterCat_queryRows...0...");
    try {
      Database db = await instance.database;

      print("CounterCat_queryRows...10...${db}...");

      var results = await db.rawQuery('''
        select * from $Table_CounterCat
        where 1 = 1
        ${ (inclOnlyActive = false) ? '' : ' and $Column_counterCatIsActive = 1 ' }
        order by ${Column_counterCatTitle}
        ''');

      print("CounterCat_queryRows...20...results == ${results}...");

      return results;
    }
    finally {
      try {
        // await db.close();
      }
      catch(_) {  }
    }

  }

  Future<int> CounterCat_update(Map<String, dynamic> row) async {

    print('CounterCat_update...0...');

    Database db;
    try {
      db = await instance.database;
      int id = row[Column_counterCatId];
      print('CounterCat_update...10...');
      var results = await db.update(Table_CounterCat, row, where: '$Column_counterCatId = ?', whereArgs: [id]);
      print('CounterCat_update...20...results==${results}');

      return results;
    }
    finally {
      try {
        // await db.close();
      }
      catch(_) {  }
    }

  }


  ////////////////////////////////////////////////////////////

  Future<int> Counter_queryRowCount(Database db) async {

    return (await db.rawQuery('''
        select count(*) as cnt from $Table_CounterModel
        ''')).toList().first['cnt'];

  }

  Future<List<Map<String, dynamic>>> Counter_queryRowById(int counterId) async {

    Database db;
    try {
      db = await instance.database;
      return await db.rawQuery('''
        select * from $Table_CounterModel
        where $Column_counterId = $counterId
        ''');
    }
    finally {
      try {
        // await db.close();
      }
      catch(_) {  }
    }

  }


  Future<int> Counter_insert(Map<String, dynamic> row) async {

    Database db;
    try {
      db = await instance.database;

      return await db.transaction((txn) async {

        int id = await txn.insert(Table_CounterModel, row);

        //
        CounterModel counterModel = CounterModel.fromMap(row);
        counterModel = counterModel.copyWith(counterId: id);

        CounterChangeLog counterChangeLog = new CounterChangeLog(
            counterId: counterModel.counterId,
            counterChangeType: CounterChangeLog.TYPE_initialValue,
            counterDelta: counterModel.counterValue,
            counterValue: counterModel.counterValue,
            updateDate: DateTime.now()
        );

        CounterChangeLog_insert(txn, counterChangeLog.toMap());

        return id;
      });

    }
    finally {
      try {
        // await db.close();
      }
      catch(_) {  }
    }

  }

  Future<List<Map<String, dynamic>>> Counter_queryRows(
      {int counterCatId = -1, bool inclOnlyActive}) async {


    try {
      Database db = await instance.database;

      print("Counter_queryRows...db == ${db}...counterCatId==${counterCatId}");

      String query = ''' 
        select COUNTER.* from $Table_CounterModel COUNTER, $Table_CounterCat CAT
        where COUNTER.$Column_counterCatId = CAT.$Column_counterCatId
        ${  (counterCatId <= 0) ? '' : ' and CAT.$Column_counterCatId = $counterCatId '  }
        ${  (inclOnlyActive = false) ? '' : ' and CAT.$Column_counterCatIsActive = 1  and COUNTER.$Column_counterIsActive = 1  '  } 
        order by CAT.${Column_counterCatTitle} ,  COUNTER.${Column_counterTitle}  
        ''';

      print("Counter_queryRows sql: ${counterCatId}...${query}");

      var resultSet = await db.rawQuery( query );

      print("Counter_queryRows resultSet == ${resultSet}");

      return resultSet;
    }
    finally {
      try {
        // await db.close();
      }
      catch(_) {  }
    }
  }

  Future<int> Counter_update(Map<String, dynamic> row) async {

    Database db;
    try {
      db = await instance.database;
      int id = row[Column_counterId];
      return await db.update(Table_CounterModel, row,
          where: '$Column_counterId = ?', whereArgs: [id]);

    }
    finally {
      try {
        // await db.close();
      }
      catch(_) {  }
    }
  }

  Future<void> onUpdateCounterValue(Map<String, dynamic> counter_row,
      Map<String, dynamic> counter_change_log_row,) async {

      Database db;
      try {
        db = await CounterDbHelper.instance.database;

        return await db.transaction((txn) async {
          int id = counter_row[Column_counterId];

          txn.update(CounterDbHelper.Table_CounterModel,
              counter_row, where: '$Column_counterId = ?', whereArgs: [id]);

          CounterChangeLog_insert(txn, counter_change_log_row);

        });
      }
      finally {
        try {
          // await db.close();
        }
        catch(_) {  }
      }

  }




  ///////////////////////////////////////////////////////////

  Future<int> CounterChangeLog_queryRowCount(Database db) async {

    return (await db.rawQuery('''
        select count(*) as cnt from $Table_CounterChangeLog
        ''')).toList().first['cnt'];

  }


  Future<int> CounterChangeLog_insert(Transaction tx, Map<String, dynamic> row) async {
    return await tx.insert(Table_CounterChangeLog, row);

  }


  Future<List<Map<String, dynamic>>> CounterChangeLog_queryAllRows(int counterId) async {

    Database db;
    try {
      db = await instance.database;
      return await db.query(Table_CounterChangeLog, where: '$Column_counterId = ?', whereArgs: [counterId] );

    }
    finally {
      try {
        // await db.close();
      }
      catch(_) {  }
    }
  }


}
