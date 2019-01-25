import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_bloc/models/User.dart';

class UserRepository {
  static UserRepository _userRepository;
  static Database _database;

  String userTable = "user";
  String colId = "id";
  String colUserId = "userId";
  String colMobileNumber = "mobileNumber";
  String colUserName = "name";
  String databaseName = "dice.db";

  UserRepository._createInstance();

  factory UserRepository() {
    if (_userRepository == null) {
      _userRepository = UserRepository._createInstance();
    }
    return _userRepository;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + databaseName;

    var userDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return userDatabase;
  }

  void _createDb(Database db, int newversion) async {
    await db.execute(
        "CREATE TABLE $userTable($colId INTEGER PRIMARY KEY AUTOINCREMENT,$colUserId INTEGER,$colUserName TEXT ,$colMobileNumber INTEGER)");
  }

  Future<List<Map<String, dynamic>>> getUserMapList() async {
    Database db = await this.database;
    return await db.query(userTable);
  }

  Future<int> insertUser(User user) async {
    Database db = await this.database;
    return await db.insert(userTable, user.toMap());
  }

  Future<int> updateUser(User user) async {
    var db = await this.database;
    return await db.update(userTable, user.toMap(),
        where: "$colId = ?", whereArgs: [user.id]);
  }


  Future<List<User>> getUserList() async {
    var userMapList = await getUserMapList();

    List<User> userList = List<User>();

    for (int i = 0; i < userMapList.length; i++) {
      userList.add(User.fromMapObject(userMapList[i]));
    }
    return userList;
  }

  Future<int> deleteAllUsers() async {
    var db = await this.database;
    return await db.delete(userTable);
  }

  Future<int> deleteParticularUser(User user) async {
    var db = await this.database;
    return await db
        .delete(userTable, where: "$colId = ?", whereArgs: [user.id]);
  }
}

var userRepository = UserRepository();
