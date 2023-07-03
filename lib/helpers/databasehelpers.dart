import 'dart:async';
import 'package:chatapp/model/callhistory.dart';
import 'package:chatapp/model/combined.dart';
import 'package:chatapp/model/message.dart';
import 'package:chatapp/model/user.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

/// Database Helper Class
class DatabaseHelper {
  ///object of private constructor
  static final DatabaseHelper _instance = DatabaseHelper.internal();

  ///factory constructor returned
  factory DatabaseHelper() => _instance;

  Database? _database;

  ///private Constructor
  DatabaseHelper.internal();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  ///initializing Database
  Future<Database> _initDatabase() async {
    var downloadsDirectory = await getExternalStorageDirectory();
    String customDatabasePath = '${downloadsDirectory!.path}/my_database.db';

    /// to send database to android data folders

    /*String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'my_database.db');*/

    return await openDatabase(customDatabasePath,
        version: 1, onCreate: _createTables);
  }

  Future<void> _createTables(Database db, int version) async {
    await db.execute('''
      CREATE TABLE message(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        senderid INTEGER,
        recieverid INTEGER,
        message TEXT, 
        updatedat TEXT,
        img TEXT,
        reaction TEXT
      )
      ''');

    await db.execute('''
      CREATE TABLE user(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT,
        phoneno VARCHAR,
        password TEXT,
        name TEXT,
        imageurl TEXT
      )
      ''');

    await db.execute('''
      CREATE TABLE callhistory(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        receiverno VARCHAR,
        callerno VARCHAR,
        calledat TEXT
        
      )
      ''');
  }

  ///Insert Message
  Future<int> insertMessage(Message message) async {
    final Database db = await database;

    return await db.insert('message', message.toMap());
  }

  ///create user
  Future<int> insertUser(User user) async {
    final Database db = await database;

    return await db.insert('user', user.toMap());
  }

  ///get login
  Future<List<User>> isUserExist(String email, String password) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.rawQuery(
        '''SELECT * FROM user WHERE email='$email'  AND  password= '$password'  ''');

    //int iid = id[0] as int;
    return List.generate(maps.length, (i) {
      if (kDebugMode) {
        print(maps[i]);
      }
      return User.fromMap(maps[i]);
    });
  }

  ///Fetch all Users
  Future<List<User>> getAllUsers(int id) async {
    Database db = await database;
    final List<Map<String, dynamic>> maps =
        await db.rawQuery(''' SELECT * FROM user WHERE id <> $id''');

    return List.generate(maps.length, (index) {
      return User.fromMap(maps[index]);
    });
  }

  ///Fetch User with given Id
  Future<User?> getUserById(int id) async {
    Database db = await database;

    final List<Map<String, dynamic>> maps = await db.query(
      'user',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }

    return null;
  }

  ///to get users phone number
  Future<String?> getUserNumer(int id) async {
    Database db = await database;

    final List<Map<String, dynamic>> maps = await db.query(
      'user',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (maps.isNotEmpty) {
      return User.fromMap(maps.first).phoneno;
    }

    return null;
  }

  ///Fetch username ,image url, message ,updatedat to message tab in Home page
  Future<List<Combined>> fetchMessagesSortedByDate(int userId) async {
    Database db = await database;

    final List<Map<String, dynamic>> result = await db.rawQuery('''
 SELECT u.name, u.imageurl, m.message, m.updatedat, m.recieverid, m.senderid
FROM user AS u
INNER JOIN (
    SELECT senderid, recieverid, message, updatedat
    FROM message
    WHERE senderid = $userId
    GROUP BY senderid, recieverid
    ORDER BY updatedat DESC
) AS m ON u.id = m.recieverid;

  ''');

    return List.generate(result.length, (i) {
      return Combined.fromMap(result[i]);
    });
  }

  ///Fetch Message conversation between sender and receiver and display in chat page
  Future<List<Combined>> fetchConversation(int senderId, int recieverid) async {
    Database db = await database;

    final List<Map<String, dynamic>> result = await db.rawQuery('''
    SELECT user.name, user.imageurl,user.phoneno,message.id,message.reaction, message.message, message.updatedat,message.recieverid,message.senderid,message.img
    FROM user
    INNER JOIN message ON user.id = message.senderid
    WHERE (message.senderid = $senderId AND message.recieverid=$recieverid) OR (message.senderid=$recieverid AND message.recieverid=$senderId) 
    ORDER BY message.updatedat DESC
  ''');

    return List.generate(result.length, (i) {
      return Combined.fromMap(result[i]);
    });
  }

  /// #Call History
  /// create CAll History
  Future<int> createCallHistory(CallHistory callHistory) async {
    final Database db = await database;

    return await db.insert('callhistory', callHistory.toMap());
  }

  ///Get Call History
  Future<List<CallHistory>> getCallHistory(String callerno) async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.rawQuery(
        ''' SELECT * FROM callhistory where callerno=$callerno ORDER BY calledat DESC''');

    return List.generate(maps.length, (index) {
      return CallHistory.fromMap(maps[index]);
    });
  }
}
