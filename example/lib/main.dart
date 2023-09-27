import 'dart:async';

import 'package:dio_builder/dio_builder.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// Example usage of the DioModule class
void exampleUsage() async {
  final dioClient = DioClient();


  final responseData = await dioClient.getData('/users');
  print(responseData);

  final postData = {
    'name': 'John Doe',
    'email': 'john@example.com',
  };
  final response = await dioClient.postData('/users', postData);
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

class DioClient extends DioBuilder {
  // Custom methods or properties specific to your Dio module can be added here

  DioClient(){
    baseUrl = 'https://api.example.com';
    addLogger();
    allowRetryInFailed();
    setDefaultTimeOut(10);
  }

  /// Performs a GET request to retrieve data from the specified [endpoint].
  /// Returns the response data as a dynamic object.
  Future<dynamic> getData(String endpoint) async {
    try {
      final response = await get(endPoint: endpoint);
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
      final response = await post(endPoint: endpoint, data: data);
      return response.data;
    } catch (e) {
      // Handle the error
      rethrow;
    }
  }

  @override
  void handleOnResponse(
      Response<dynamic> response, ResponseInterceptorHandler handler) {
  }

  @override
  void handleOnRequest(
      RequestOptions options, RequestInterceptorHandler handler) {

  }

  @override
  void handleOnError(
      DioException dioException, ErrorInterceptorHandler handler) {
  }

// Add more methods for different HTTP request types and functionalities as needed
}
