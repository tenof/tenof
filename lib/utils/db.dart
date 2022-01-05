// 简单的 json 操作
import 'dart:io';
import 'dart:convert';

class DB {
  // 申明创建的 file 位置
  final file = File(Directory.systemTemp.path + '/db_list.json');

  void get() async {
    if (await file.exists()) {
      print('获取位置:$file');
      final contents = await file.readAsString().then((data) => data);
      List jsonData = jsonDecode(contents);
      // for (var i = 0; i < jsonData.length; i++) {
      //   print(jsonData[i]);
      // }

      jsonData.map((e) {
        print(e);
        return e;
      }).toList();
    }
  }

  void set(String contents) {
    print('添加位置:$file');
    file.writeAsString(contents).then((_) {
      print(_);
    });
  }
}
