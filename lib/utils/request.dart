import 'package:dio/dio.dart';
import 'dart:convert';
import 'dart:async';

Future request(String url, {data, Options? options, bool json = true}) async {
  try {
    Response response;
    Dio dio = Dio();
    if (!json) {
      dio.options.contentType = Headers.formUrlEncodedContentType;
    }
    response = await dio.request(url, data: data, options: options);
    return response;
  } catch (err) {
    throw "tenof: ${err.toString()}";
  }
}
