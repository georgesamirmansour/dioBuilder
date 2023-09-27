```markdown
# DioBuilder

DioBuilder is a Dart library that provides a builder pattern for configuring and creating instances of the Dio HTTP client. It abstracts common configurations and interceptors for making HTTP requests, making it easier to set up and use Dio for your network requests.

## Installation

Add `dio_builder` to your `pubspec.yaml` file:

```yaml
dependencies:
  dio_builder: ^3.0.0 # Replace with the latest version
```

Then, run `flutter pub get` to install the dependency.

## Usage

1. Import the necessary libraries:

```dart
import 'package:dio_builder/dio_builder.dart';
import 'package:dio/dio.dart';
```

2. Initialize the DioBuilder:

```dart
final dioBuilder = DioBuilder();
dioBuilder.initialize();
```

3. Configure and build your Dio instance:

```dart
final dio = dioBuilder
    .setBaseUrl('https://api.example.com')
    .setContentType('application/json')
    .setHeaders({'Authorization': 'Bearer YOUR_ACCESS_TOKEN'})
    .build();
```

4. Use the Dio instance to make HTTP requests:

```dart
try {
  final response = await dio.get('/some-endpoint');
  // Handle the response
} catch (e) {
  // Handle errors
}
```

## Configuration

DioBuilder provides various methods to configure your Dio instance:

- `setBaseUrl`: Set the base URL for your API.
- `setContentType`: Set the content type for requests.
- `setHeaders`: Set custom headers for requests.
- `setFollowRedirects`: Enable or disable following redirects.
- `setExtras`: Set extra options for requests.
- `setQueryParameters`: Set query parameters for requests.
- `setListFormat`: Set the list format for serialization.
- `setMethod`: Set the HTTP method for requests.
- `setDefaultTimeOut`: Set the default timeout for network requests.
- `setResponseType`: Set the response type for requests.
- `setPersistentConnection`: Enable or disable persistent connections.
- `setMaxRedirects`: Set the maximum number of redirects to follow.
- `setReceiveDataWhenStatusError`: Set whether to receive data when the status is an error.

You can chain these methods together to configure DioBuilder according to your requirements.

## Interceptors

DioBuilder includes some common interceptors by default:

- Logger Interceptor: Logs HTTP requests and responses.
- Retry Interceptor: Automatically retries failed requests.

You can add or remove interceptors using the `addLogger` and `allowRetryInFailed` methods.

## Examples

Here are some examples of making different types of requests using DioBuilder:

### GET Request

```dart
final response = await dioBuilder.get(
  endPoint: '/get-endpoint',
  data: {'param1': 'value1'},
);
```

### POST Request

```dart
final response = await dioBuilder.post(
  endPoint: '/post-endpoint',
  data: {'param1': 'value1'},
);
```

### PUT Request

```dart
final response = await dioBuilder.put(
  endPoint: '/put-endpoint',
  data: {'param1': 'value1'},
);
```

### DELETE Request

```dart
final response = await dioBuilder.delete(
  endPoint: '/delete-endpoint',
  data: {'param1': 'value1'},
);
```

### Handling Responses

You can access the response data using `response.data`. For example:

```dart
final responseData = response.data;
```

### Handling Errors

If an error occurs during the request, it will be caught in the `catch` block. For example:

```dart
try {
  final response = await dioBuilder.get(
    endPoint: '/non-existent-endpoint',
    data: {'param1': 'value1'},
  );
} catch (e) {
  // Handle the error
}
```

## Contributing

Contributions to DioBuilder are welcome! If you encounter any bugs or have suggestions for improvements, please create a new issue on the [GitHub repository](https://github.com/georgesamirmansour/dioBuilder).

If you would like to contribute code to DioBuilder, please follow the [contribution guidelines](https://github.com/georgesamirmansour/dioBuilder/blob/master/CONTRIBUTING.md).

## License

DioBuilder is released under the [MIT License](https://opensource.org/licenses/MIT). See the [LICENSE](https://github.com/georgesamirmansour/dioBuilder/blob/master/LICENSE) file for more details.
```