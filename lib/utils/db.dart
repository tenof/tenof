// 简单的 json 操作
import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';

class DB {
  String name;

  String? filename;

  DB(
    this.name, {
    this.filename,
  });

  // 默认申明创建的 file 位置
  // final File file = File(Directory.systemTemp.path + filename);
  File file() {
    final file = '${Directory.systemTemp.path}/db_$name.json';
    if (filename != null) {
      return File(filename!);
    }
    return File(file);
  }

  void test() {
    var map = {
      "name": 1,
      "value": 2,
    };
    print(map);
  }

  Future<T> data<T extends Map<String, dynamic>>() async {
    try {
      if (await file().exists()) {
        print('获取位置:$file');
        // [{name, value}]
        /*
          name 表名
          value 表内容
        */
        final contents = await file().readAsString().then((data) => data);
        T jsonData =
            jsonDecode(contents).where((vals) => vals.name == name).toList();
        return jsonData;
      } else {
        throw '未获取到JSON文件';
      }
    } catch (err) {
      throw '获取JSON数据';
    }
  }

  Future get(String key, String value) async {
    final jsonData = await data();
    final searchData = jsonData["value"].where((vals) {
      return vals[key] == value;
    }).toList();

    return searchData ?? [];
  }

  Future<File> set(contents) async {
    print('添加位置:${file()}');
    final List? jsonData = await data();
    if (jsonData != null) {
      jsonData = {
        [name]: [...jsonData, contents],
      };
    }
    return await file()
        .writeAsString(jsonEncode({
      [name]: contents,
    }))
        .then((_) {
      return _;
    });
  }

  void setList(contents) async {
    // 查看 目录所有的值
    final List? data = await get('list');
    set({
      "list": [...?data, contents]
    });
  }

  Future del(String name, vals) async {
    try {
      final List? data = await getList();
      // data.where((element) => false)
      if (data != null) {}
    } catch (err) {
      print(err);
      // if (err) {
      //   rethrow;
      // }
    }
  }
}
