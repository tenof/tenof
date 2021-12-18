import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:bot_toast/bot_toast.dart';
import 'dart:async';
// intl
import 'generated/l10n.dart';

import 'utils/toast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate, // 指定本地化的字符串和一些其他的值
          GlobalCupertinoLocalizations.delegate, // 对应的Cupertino风格
          GlobalWidgetsLocalizations.delegate // 指定默认的文本排列方向, 由左到右或由右到左
        ],
        supportedLocales: S.delegate.supportedLocales,
        title: 'Tenof',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
        builder: BotToastInit(),
        navigatorObservers: [BotToastNavigatorObserver()]);
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("Tenof"),
      ),
      body: Column(
        children: [
          Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: TextButton(
                child: Text(S.of(context).helloWorld),
                onPressed: () {
                  // notification.warning(title: const Text('测试提示信息问题')),
                  Toast.loading();

                  const timeout = Duration(seconds: 5);
                  Timer.periodic(timeout, (timer) {
                    //callback function
                    //1s 回调一次
                    print('afterTimer=' + DateTime.now().toString());
                    Toast.hide();

                    timer.cancel(); // 取消定时器
                  });
                }),
          ),
          Center(
            child: TextButton(
              child: const Text("取消loading"),
              onPressed: () => Toast.hide(),
            ),
          )
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
