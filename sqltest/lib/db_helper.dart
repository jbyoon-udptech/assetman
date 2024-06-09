import 'dart:async';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:sqltest/student_model.dart';
import 'package:sqltest/asset_model.dart';
//import 'dart:io' as io;
//import 'package:path_provider/path_provider.dart';

class DBHelper {
  late Database _db;
  initDatabase() async {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    WidgetsFlutterBinding.ensureInitialized();

    String path = join(await getDatabasesPath(), 'student.db');
    _db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return _db;
  }

  _onCreate(Database db, int version) async {
    await db
        .execute('CREATE TABLE student (id INTEGER PRIMARY KEY, name TEXT)');
    await db
        .execute('CREATE TABLE asset (name TEXT, at DATE, value FLOAT, PRIMARY KEY(name, at))');
  }

  Future<Student> add(Student student) async {
    var dbClient = _db; // await db;
    student.id = await dbClient.insert('student', student.toMap());
    return student;
  }

  Future<List<Student>> getStudents() async {
    var dbClient = _db; // await db;
    List<Map<String,Object?>> maps = await dbClient.query('student', columns: ['id', 'name']);
    List<Student> students = [];
    if (maps.isNotEmpty) {
      for (int i = 0; i < maps.length; i++) {
        students.add(Student.fromMap(maps[i]));
      }
    }
    return students;
  }

  Future<int> delete(int id) async {
    var dbClient = _db; // await db;
    return await dbClient.delete(
      'student',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> update(Student student) async {
    var dbClient = _db; // await db;
    return await dbClient.update(
      'student',
      student.toMap(),
      where: 'id = ?',
      whereArgs: [student.id],
    );
  }

  Future close() async {
    var dbClient = _db; // await db;
    dbClient.close();
  }
}

class AssetDB {
  late Database _db;
  initDatabase() async {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    WidgetsFlutterBinding.ensureInitialized();

    String path = join(await getDatabasesPath(), 'asset.db');
    _db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return _db;
  }

  _onCreate(Database db, int version) async {
    await db
        .execute('CREATE TABLE asset (name TEXT, at CHAR(10), value FLOAT, PRIMARY KEY(name, at))');
  }

  Future<Asset> add(Asset d) async {
    await _db.insert('asset', d.toMap());
    return d;
  }

  Future<Asset?> getLastofAt(String name, String at) async {
    List<Map<String,Object?>> maps = await _db.query('asset',
      columns: ['name', 'at', 'value'],
      where: 'name = ? AND at <= ?',
      whereArgs: [name, at],
      orderBy: 'at DESC',
      limit: 1
      );
    if (maps.isNotEmpty) {
      return Asset.fromMap(maps[0]);
    }
    return null;
  }

  Future<List<Asset>> getAll() async {
    List<Map<String,Object?>> maps = await _db.query('asset', columns: ['name', 'at', 'value']);
    List<Asset> data = [];
    if (maps.isNotEmpty) {
      for (int i = 0; i < maps.length; i++) {
        data.add(Asset.fromMap(maps[i]));
      }
    }
    return data;
  }

  Future<int> delete(String name, String at) async {
    return await _db.delete(
      'asset',
      where: 'name = ? AND at = ?',
      whereArgs: [name, at],
    );
  }

  Future<int> update(Asset d) async {
    var dbClient = _db; // await db;
    return await dbClient.update(
      'asset',
      d.toMap(),
      where: 'name = ? AND at = ?',
      whereArgs: [d.name, d.at],
    );
  }

  Future close() async {
    _db.close();
  }
}
