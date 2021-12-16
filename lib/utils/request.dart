import 'dart:convert';
import 'package:dio/dio.dart';
import 'dart:async';

Future request(url, {data}) async {
  try {
    Response response;
    Dio dio = Dio()
    response = await dio.request(url, data: data);
  } catch (err) {
    print('错误信息');
  } finally {}
}
