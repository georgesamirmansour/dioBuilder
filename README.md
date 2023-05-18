# dio_builder

Dio builder is support plugin for dio. It's  build using abstract class.

## Getting Started

# example

```groovy
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
```

# function inside

```groovy
  /// allow to log the http request and response in terminal with single line
  /// in case of using chunker please review library
  /// curl logs appears in terminal you can copy and past it to use it in post man
  void addLogger({bool allowChucker = true, bool allowCurlLog = true}) {
    if (allowChucker) {
      _dio.interceptors.add(ChuckerDioInterceptor());
    }
    if (allowCurlLog) {
      _dio.interceptors
          .add(DioInterceptToCurl(convertFormData: true, printOnSuccess: true));
    } else {
      _dio.interceptors.add(PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 90));
    }

  }

void allowedSHAFingerprints(List<String> allowedSHAFingerprints) {
    _dio.interceptors.add(CertificatePinningInterceptor(
            allowedSHAFingerprints: allowedSHAFingerprints));

}

/// allow retry of connection in case of internet failed or error from api
/// default retry as default 3
void allowRetryInFailed({int retryCount = 3}) {
    _dio.interceptors.add(RetryInterceptor(
            dio: _dio,
            retries: retryCount,
            retryDelays: List.generate(
                    retryCount, (index) => Duration(seconds: retryCount + index))));

}

/// this is the production url
/// it only for production on app store on apple store when app live
void setBaseLiveUrls(String baseUrl) {
    _liveUrl = baseUrl;

}

/// this is testing or development url
void setTestUrls(String baseUrl) {
    _testUrl = baseUrl;

}

/// in case you have a mirror of your production url but is only
/// work in testing
void setBaseStageUrls(String baseUrl) {
    _stageUrl = baseUrl;

}

void setIsLive(bool value) {
    _isLive = value;

}

void setIsTest(bool value) {
    _isTest = value;

}

void setIsStage(bool value) {
    _isStage = value;

}

void setDefaultTimeOut(int value) {
    _defaultTimeOut = value;

}

void setResponseType(ResponseType value) {
    _responseType = value;

}

void setContentType(String value) {
    _contentType = value;

}

void setPersistentConnection(bool value) {
    _persistentConnection = value;

}

void setFollowRedirects(bool value) {
    _followRedirects = value;

}

void setMaxRedirects(int value) {
    _maxRedirects = value;

}

void setExtras(Map<String, dynamic> value) {
    _extra = value;

}

void setHeaders(Map<String, dynamic> value) {
    _headers = value;

}

void queryParameters(Map<String, dynamic> value) {
    _queryParameters = value;

}

void setListFormat(ListFormat value) {
    _listFormat = value;

}

void setMethod(String value) {
    _method = value;

}

void setReceiveDataWhenStatusError(bool value) {
    _receiveDataWhenStatusError = value;
}
/// check if their is connection between server and client
/// also detect if their is ping
Future<bool> checkInternetConnection() async {
    try {
        final result = await InternetAddress.lookup(_baseUrl());
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
            return Future.value(true);
        }
    } on SocketException {
        return Future.value(false);
    }
    return Future.value(false);
}

/// use this method for build with builder pattern
/// it build with default config first time
Dio build() {
    addLogger();
    allowRetryInFailed();
    _dio.options = _buildBaseOption();
    _dio.interceptors.add(_interceptorsWrapper);
    return _dio;
}
```

License
--------
MIT License

Copyright (c) 2023 George Samir

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NON INFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
