import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:quill_delta/quill_delta.dart';
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
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _loadDocument().then((document) {
      setState(() {
        _controller = ZefyrController(document);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final body = (_controller == null)
        ? const Center(child: CircularProgressIndicator())
        : ZefyrField(
            padding: const EdgeInsets.all(16),
            controller: _controller,
            focusNode: _focusNode,
          );

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
      body: body,
    );
  }

  /// Loads the document to be edited in Zefyr.
  Future<NotusDocument> _loadDocument() async {
    final file = File(Directory.systemTemp.path + '/quick_start.json');
    if (await file.exists()) {
      final contents = await file.readAsString().then(
          (data) => Future.delayed(const Duration(seconds: 1), () => data));
      return NotusDocument.fromJson(jsonDecode(contents));
    }
    final delta = Delta()..insert('Zefyr Quick Start\n');
    return NotusDocument()..compose(delta, ChangeSource.local);
  }

  void _saveDocument(BuildContext context) {
    // Notus documents can be easily serialized to JSON by passing to
    // `jsonEncode` directly:
    final contents = jsonEncode(_controller.document);
    // For this example we save our document to a temporary file.
    final file = File(Directory.systemTemp.path + '/quick_start.json');
    // And show a snack bar on success.
    file.writeAsString(contents).then((_) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Saved.')));
    });
  }
}
