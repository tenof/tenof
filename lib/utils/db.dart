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

  Future getList() async {
    // 目录信息保存
    final jsonData = await get('list');
    if (jsonData != null) {
      for (var i = 0; i < jsonData.length; i++) {
        // jsonData[i].title
        // TODO: title 标题  time 时间 child 下级
        print(jsonData[i]);
      }
    }
  }

  Future<File> set(contents) async {
    print('添加位置:$file');
    return await file.writeAsString(contents).then((_) {
      return _;
    });
  }

  void setList(contents) {
    final data = jsonEncode({"list": contents});
    set(data);
  }
}
