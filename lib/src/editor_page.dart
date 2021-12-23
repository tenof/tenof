import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:tenof/utils/toast.dart';
import 'package:zefyr/zefyr.dart';
import '../generated/l10n.dart';
// 组件
import '../components/drawer_widget.dart';

class EditorPage extends StatefulWidget {
  const EditorPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => EditorPageState();
}

class EditorPageState extends State<EditorPage> {
  /// Allows to control the editor and the document.
  late ZefyrController _controller;

  /// Zefyr editor like any other input field requires a focus node.
  late final FocusNode _focusNode = FocusNode();

  // void _handleSettingsLoaded(Settings value) {
  //   setState(() {
  //     _settings = value;
  //     _loadFromAssets();
  //   });
  // }

  @override
  void initState() {
    super.initState();

    final document = _loadDocument();
    _controller = ZefyrController(document);
    // _loadDocument().then((document) {
    //   setState(() {
    //     _controller = ZefyrController(document);
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    // 自定义 toolbar
    final toolbar = ZefyrToolbar(children: [
      ToggleStyleButton(
        attribute: NotusAttribute.bold,
        icon: Icons.format_bold,
        controller: _controller,
      ),
      const SizedBox(width: 1),
      ToggleStyleButton(
        attribute: NotusAttribute.italic,
        icon: Icons.format_italic,
        controller: _controller,
      ),
      VerticalDivider(indent: 16, endIndent: 16, color: Colors.grey.shade400),
      SelectHeadingStyleButton(controller: _controller),
      VerticalDivider(indent: 16, endIndent: 16, color: Colors.grey.shade400),
      ToggleStyleButton(
        attribute: NotusAttribute.block.numberList,
        controller: _controller,
        icon: Icons.format_list_numbered,
      ),
      ToggleStyleButton(
        attribute: NotusAttribute.block.bulletList,
        controller: _controller,
        icon: Icons.format_list_bulleted,
      ),
      VerticalDivider(indent: 16, endIndent: 16, color: Colors.grey.shade400),
      ToggleStyleButton(
        attribute: NotusAttribute.block.quote,
        controller: _controller,
        icon: Icons.format_quote,
      ),
    ]);

    return Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).title),
          leading: Builder(
              builder: (BuildContext context) => IconButton(
                    icon: const Icon(Icons.menu),
                    tooltip: "Navigration",
                    onPressed: () => Scaffold.of(context).openDrawer(),
                  )),
          actions: <Widget>[
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.save),
                onPressed: () => _saveDocument(context),
              ),
            )
          ],
        ),
        drawer: const DrawerWidget(),
        body: Column(
          children: [
            Expanded(
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(16.0),
                child: ZefyrEditor(
                  controller: _controller,
                  focusNode: _focusNode,
                  autofocus: true,
                ),
              ),
            ),
            Divider(height: 1, thickness: 1, color: Colors.grey.shade200),
            ZefyrToolbar.basic(
              controller: _controller,
            ),
          ],
        ));
  }

  /// Loads the document to be edited in Zefyr.
  NotusDocument _loadDocument() {
    // final file = File(Directory.systemTemp.path + '/quick_start.json');
    // if (await file.exists()) {
    //   final contents = await file.readAsString().then(
    //       (data) => Future.delayed(const Duration(seconds: 1), () => data));
    //   return NotusDocument.fromJson(jsonDecode(contents));
    // }
    // final delta = Delta()..insert('Zefyr Quick Start\n');
    // return NotusDocument()..compose(delta, ChangeSource.local);
    final Delta delta = Delta()..insert("Zefyr Quick Start\n");
    return NotusDocument.fromDelta(delta);
  }

  void _saveDocument(BuildContext context) {
    // Notus documents can be easily serialized to JSON by passing to
    // `jsonEncode` directly:
    final contents = jsonEncode([
      {"name": 12121}
    ]);
    print(contents is List);
    // For this example we save our document to a temporary file.
    final file = File(Directory.systemTemp.path + '/quick_start.json');
    print(file);
    // And show a snack bar on success.
    file.writeAsString(contents).then((_) {
      notification.success(title: const Text('保存成功'));
    });
  }
}
