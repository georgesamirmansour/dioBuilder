import 'dart:async';

import 'package:dio_builder/dio_builder.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// Example usage of the DioModule class
void exampleUsage() async {
  final dioModule = DioModule();
  dioModule.setBaseLiveUrl("https://api.example.com");
  dioModule.addLogger();
  dioModule.allowRetryInFailed();
  dioModule.setDefaultTimeOut(10);

  final responseData = await dioModule.getData('/users');
  print(responseData);

  final postData = {
    'name': 'John Doe',
    'email': 'john@example.com',
  };
  final response = await dioModule.postData('/users', postData);
  print(response);
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

class DioModule extends DioBuilder {
  // Custom methods or properties specific to your Dio module can be added here

  /// Performs a GET request to retrieve data from the specified [endpoint].
  /// Returns the response data as a dynamic object.
  Future<dynamic> getData(String endpoint) async {
    try {
      final response = await build().get(endpoint);
      return response.data;
    } catch (e) {
      // Handle the error
      rethrow;
    }
  }

  /// Performs a POST request to send data to the specified [endpoint].
  /// The [data] parameter represents the payload to be sent.
  /// Returns the response data as a dynamic object.
  Future<dynamic> postData(String endpoint, dynamic data) async {
    try {
      final response = await build().post(endpoint, data: data);
      return response.data;
    } catch (e) {
      // Handle the error
      rethrow;
    }
  }

  @override
  void handleOnError(
      DioException dioException, ErrorInterceptorHandler handler) {
    // TODO: implement handleOnError
  }

  @override
  void handleOnRequest(
      RequestOptions options, RequestInterceptorHandler handler) {
    // TODO: implement handleOnRequest
  }

  @override
  void handleOnResponse(
      Response<dynamic> response, ResponseInterceptorHandler handler) {
    // TODO: implement handleOnResponse
  }

  // Add more methods for different HTTP request types and functionalities as needed
}
