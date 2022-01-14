// 简单的 json 操作
import 'dart:io';
import 'dart:convert';

class DB {
  // 申明创建的 file 位置
  final file = File(Directory.systemTemp.path + '/db_list.json');

  Future get(String name) async {
    if (await file.exists()) {
      print('获取位置:$file');
      final contents = await file.readAsString().then((data) => data);
      Map jsonData = jsonDecode(contents);
      return jsonData[name];
    }
  }

  Future getList(String key, value) async {
    // 目录信息保存
    final jsonData = await get('list');
    if (jsonData != null) {
      final data = jsonData.where((vals) {
        return vals[key] == value;
      }).toList();

      return data;
    }

    return [];
  }

  Future<File> set(contents) async {
    print('添加位置:$file');
    return await file.writeAsString(jsonEncode(contents)).then((_) {
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
}
