import 'dart:async';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:sqltest/asset_model.dart';
//import 'dart:io' as io;
//import 'package:path_provider/path_provider.dart';

class AssetDB {
  late Database _db;
  final String dbname;

  AssetDB(this.dbname);
  initDatabase() async {
    databaseFactoryOrNull = null;
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    WidgetsFlutterBinding.ensureInitialized();

    String path = join(await getDatabasesPath(), '$dbname.db');
    _db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return _db;
  }

  _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE asset (name TEXT, at CHAR(10), value FLOAT, PRIMARY KEY(name, at))');
  }

  Future<Asset> insert(Asset d) async {
    await _db.insert('asset', d.toMap());
    return d;
  }

  Future<Asset?> getLastofAt(String name, String at) async {
    List<Map<String, Object?>> maps = await _db.query('asset',
        columns: ['name', 'at', 'value'],
        where: 'name = ? AND at <= ?',
        whereArgs: [name, at],
        orderBy: 'at DESC',
        limit: 1);
    if (maps.isNotEmpty) {
      return Asset.fromMap(maps[0]);
    }
    return null;
  }

  Future<List<Asset>> getAll() async {
    List<Map<String, Object?>> maps = await _db.query('asset', columns: ['name', 'at', 'value']);
    List<Asset> data = [];
    if (maps.isNotEmpty) {
      for (int i = 0; i < maps.length; i++) {
        data.add(Asset.fromMap(maps[i]));
      }
    }
    return data;
  }

  Future<int> deleteAll() async {
    return await _db.rawDelete('DELETE FROM asset');
  }

  Future<int> delete(String name, String at) async {
    return await _db.delete(
      'asset',
      where: 'name = ? AND at = ?',
      whereArgs: [name, at],
    );
  }

  Future<int> update(Asset d) async {
    return await _db.update(
      'asset',
      d.toMap(),
      where: 'name = ? AND at = ?',
      whereArgs: [d.name, d.at],
    );
  }

  Future<Asset> upsert(Asset d) async {
    try {
      await insert(d);
    } catch (e) {
      await update(d);
    }
    print('update ${d.name} ${d.at} ${d.value}');
    return d;
  }

  Future close() async {
    _db.close();
  }
}
