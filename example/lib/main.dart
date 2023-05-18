import 'package:dio/src/adapter.dart';
import 'package:dio/src/dio_error.dart';
import 'package:dio/src/dio_mixin.dart';
import 'package:dio/src/options.dart';
import 'package:dio/src/response.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:dio_builder/dio_builder.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: const Center(
          child: Text('Running on: '),
        ),
      ),
    );
  }
}

/// you have to extend the class here
class DioHelper extends DioBuilder{
  /// you have to make this class as singleton
  /// use this way
  static final DioHelper _instance = DioHelper.internal();
  /// call the build function to set up dio here
  /// you can set default dio by calling build function
  /// you must pre-define base url here
  /// you have 3 type of base url
  /// live, test, stage
  /// here I am using live url cause i have only one
  DioHelper.internal(){
    setBaseLiveUrls("https://dart.dev");
    setIsLive(true);
    build();
  }

  factory DioHelper() {
    return _instance;
  }


  @override
  handleOnError(DioError e, ErrorInterceptorHandler handler) {
    /// this intercept wrapper onError callback
  }

  @override
  handleOnRequest(RequestOptions options, RequestInterceptorHandler handler) {
    /// this intercept wrapper onRequest callback
  }

  @override
  handleOnResponse(Response<dynamic> e, ResponseInterceptorHandler handler) {
    /// this intercept wrapper onResponse callback
  }

}
