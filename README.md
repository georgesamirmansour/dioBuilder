# DioBuilder

DioBuilder is a Dart library that provides a builder pattern for configuring and creating instances of the Dio HTTP client. It abstracts common configurations and interceptors for making HTTP requests.

## Features

- Builder pattern for configuring and creating Dio instances.
- Configuration options for setting base URLs, response types, content types, timeouts, headers, and more.
- Interceptors for logging HTTP requests and responses.
- Interceptor for automatically retrying failed requests.
- Support for handling bad SSL certificates or invalid HTTPS connections (optional).
- Environment-specific base URLs for live, test, and staging environments.

## Installation

To use DioBuilder in your Dart project, follow these steps:

1. Add the `dio_builder` package to your `pubspec.yaml` file:

```yaml
dependencies:
  dio_builder: ^2.0.0
```

2. Run `dart pub get` to fetch the package dependencies.

## Usage

1. Import the package in your Dart file:

```dart
import 'package:dio_builder/dio_builder.dart';
```

2. Configure the Dio client using the builder pattern:

```dart
void configureDio() {
  final dioBuilder = DioBuilder();

  // Set the base URL for the live environment
  dioBuilder.setBaseLiveUrl('https://api.example.com/live');

  // Set the base URL for the test environment
  dioBuilder.setBaseTestUrl('https://api.example.com/test');

  // Enable the logger for HTTP requests and responses
  dioBuilder.addLogger();

  // Enable retrying failed requests
  dioBuilder.allowRetryInFailed();

  // Set the default timeout for network requests
  dioBuilder.setDefaultTimeOut(10);

  // Set custom headers
  dioBuilder.setHeaders({'Authorization': 'Bearer TOKEN'});

  // Build the Dio client
  final dio = dioBuilder.build();

  // Use the Dio client to make HTTP requests
  dio.get('/users').then((response) {
    print(response.data);
  }).catchError((error) {
    print(error);
  });
}
```

3. Handling Bad SSL Certificates or Invalid HTTPS Connections (Optional)

To handle bad SSL certificates or invalid HTTPS connections, you can enable the `allowBadRequest` option:

```dart
dioBuilder.allowBadRequest(true);
```

**Note:** This should only be used for testing or development purposes and should be used with caution.

## Methods

### addLogger

```dart
DioBuilder addLogger({bool allowChucker = true, bool printLog = true})
```

Adds a logger interceptor to the Dio client for logging HTTP requests and responses. The logger can be printed to the console or integrated with the Chucker library for more detailed logs.

- `allowChucker` (optional): Enables or disables Chucker integration (default is `true`).
- `printLog` (optional): Enables or disables printing logs to the console (default is `true`).

Returns the `DioBuilder` instance.

### allowRetryInFailed

```dart
DioBuilder allowRetryInFailed({int retryCount = 3})
```

Adds a retry interceptor to the Dio client for automatically retrying failed requests. The number of retries can be specified with the `retryCount` parameter (default is 3).

- `retryCount` (optional): The number of retries to attempt (default is 3).

Returns the `DioBuilder` instance.

### setBaseLiveUrl

```dart
void setBaseLiveUrl(String baseUrl)
```

Sets the base URL for the live environment. This URL is used when the application is in production and deployed to app stores.

- `baseUrl`: The base URL for the live environment.

### setBaseTestUrl

```dart
DioBuilder setBaseTestUrl(String baseUrl)
```

Sets the base URL for the testing or development environment.

- `baseUrl`: The base URL for the testing or development environment.

Returns the `DioBuilder` instance.

### setBaseStageUrl

```dart
DioBuilder setBaseStageUrl(String baseUrl)
```

Sets the base URL for the staging environment.

- `baseUrl`: The base URL for the staging environment.

Returns the `DioBuilder` instance.

### allowBadRequest

```dart
DioBuilder allowBadRequest(bool value)
```

Enables or disables the ability to handle bad SSL certificates or invalid HTTPS connections. This can be useful for testing or development purposes but should be used with caution.

- `value`: `true` to allow bad SSL certificates or invalid HTTPS connections, `false` to disallow.

Returns the `DioBuilder` instance.

### setIsLive

```dart
DioBuilder setIsLive(bool value)
```

Sets the environment to live mode.

- `value`: `true` to set the environment to live mode, `false` to unset.

Returns the `DioBuilder` instance.

### setIsTest

```dart
DioBuilder setIsTest(bool value)
```

Sets the environment to test mode.

- `value`: `true` to set the environment to test mode, `false` to unset.

Returns the `DioBuilder` instance.

### setIsStage

```dart
DioBuilder setIsStage(bool value)
```

Sets the environment to stage mode.

- `value`: `true` to set the environment to stage mode, `false` to unset.

Returns the `DioBuilder` instance.

### setDefaultTimeOut

```dart
DioBuilder setDefaultTimeOut(int value)
```

Sets the default timeout for network requests, in seconds.

- `value`: The default timeout value in seconds.

Returns the `DioBuilder` instance.

### setResponseType

```dart
DioBuilder setResponseType(ResponseType value)
```

Sets the response type for the HTTP requests.

- `value`: The response type.

Returns the `DioBuilder` instance.

### setContentType

```dart
DioBuilder setContentType(String value)
```

Sets the content type for the HTTP requests.

- `value`: The content type.

Returns the `DioBuilder` instance.

### setPersistentConnection

```dart
DioBuilder setPersistentConnection(bool value)
```

Sets whether the connection should be persistent or not.

- `value`: `true` to enable persistent connection, `false` to disable.

Returns the `DioBuilder` instance.

### setFollowRedirects

```dart
DioBuilder setFollowRedirects(bool value)
```

Sets whether the client should follow redirects or not.

- `value`: `true` to enable follow redirects, `false` to disable.

Returns the `DioBuilder` instance.

### setMaxRedirects

```dart
DioBuilder setMaxRedirects(int value)
```

Sets the maximum number of redirects to follow.

- `value`: The maximum number of redirects.

Returns the `DioBuilder` instance.

### setExtras

```dart
DioBuilder setExtras(Map<String, dynamic> value)
```

Sets extra options to be included in the requests.

- `value`: A map of extra options.

Returns the `DioBuilder` instance.

### setHeaders

```dart
DioBuilder setHeaders(Map<String, dynamic> value)
```

Sets the headers to be included in the requests.

- `value`: A map of headers.

Returns the `DioBuilder` instance.

### queryParameters

```dart
DioBuilder queryParameters(Map<String, dynamic> value)
```

Sets the query parameters to be

included in the requests.

- `value`: A map of query parameters.

Returns the `DioBuilder` instance.

### setListFormat

```dart
DioBuilder setListFormat(ListFormat value)
```

Sets the format for lists serialization in the requests.

- `value`: The list format.

Returns the `DioBuilder` instance.

### setMethod

```dart
DioBuilder setMethod(String value)
```

Sets the HTTP method for the requests.

- `value`: The HTTP method.

Returns the `DioBuilder` instance.

### setReceiveDataWhenStatusError

```dart
void setReceiveDataWhenStatusError(bool value)
```

Sets whether to receive the response data when the status is an error or not.

- `value`: `true` to receive data when the status is an error, `false` to discard data.

### checkInternetConnection

```dart
Future<bool> checkInternetConnection()
```

Checks if there is an internet connection between the client and server. Returns `true` if there is a connection, otherwise `false`.

Returns a `Future` that resolves to a boolean indicating the internet connection status.

### build

```dart
Dio build()
```

Builds the Dio client with the configured options and interceptors.

Returns the built Dio client.

## Contributing

Contributions to DioBuilder are welcome! If you encounter any bugs or have suggestions for improvements, please create a new issue on the [GitHub repository](https://github.com/your-username/your-repo).

If you would like to contribute code to DioBuilder, please follow the [contribution guidelines](https://github.com/your-username/your-repo/blob/main/CONTRIBUTING.md).

## License

DioBuilder is released under the [MIT License](https://opensource.org/licenses/MIT). See the [LICENSE](https://github.com/georgesamirmansour/dioBuilder/blob/master/LICENSE) file for more details.
```

Make sure to replace `your-username` and `your-repo` with your actual GitHub username and repository name.

Feel free to customize the README file according to your project's specific details and requirements.

I hope this README provides a comprehensive overview of the code and its methods. Let me know if you have any further questions or need any additional assistance!