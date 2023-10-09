part of dio_handler;


class DioHandler {
  final Dio dio;
  final String baseUrl;
  final Map<String, dynamic>? defaultHeaders;

  DioHandler({
    required this.baseUrl,
    this.defaultHeaders,
  }) : dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: const Duration(milliseconds: 30000),
    receiveTimeout: const Duration(milliseconds: 30000),
  )) {
    if (defaultHeaders != null) {
      dio.options.headers.addAll(defaultHeaders!);
    }
  }

  Future<Response> get<T>(
      String path, {
        Map<String, dynamic>? params,
        Map<String, dynamic>? headers,
      }) async {
    if (!await isInternetAvailable()) {
      throw DioError(
        error: "No internet connection",
      );
    }

    try {
      final response = await dio.get(
        path,
        queryParameters: params,
        options: Options(headers: headers),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        throw DioError(
          response: response,
          error: "HTTP Error ${response.statusCode}",
        );
      }
    } catch (e) {
      throw DioError(
        error: "Network Error: ${e.toString()}",
      );
    }
  }

  Future<Response> post<T>(
      String path, {
        Map<String, dynamic>? params,
        Map<String, dynamic>? headers,
        dynamic data,
      }) async {
    if (!await isInternetAvailable()) {
      throw DioError(
        error: "No internet connection",
      );
    }

    try {
      final response = await dio.post(
        path,
        queryParameters: params,
        options: Options(headers: headers),
        data: data,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        throw DioError(
          response: response,
          error: "HTTP Error ${response.statusCode}",
        );
      }
    } catch (e) {
      throw DioError(
        error: "Network Error: ${e.toString()}",
      );
    }
  }

  Future<Response> put<T>(
      String path, {
        Map<String, dynamic>? params,
        Map<String, dynamic>? headers,
        dynamic data,
      }) async {
    if (!await isInternetAvailable()) {
      throw DioError(
        error: "No internet connection",
      );
    }

    try {
      final response = await dio.put(
        path,
        queryParameters: params,
        options: Options(headers: headers),
        data: data,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        throw DioError(
          response: response,
          error: "HTTP Error ${response.statusCode}",
        );
      }
    } catch (e) {
      throw DioError(
        error: "Network Error: ${e.toString()}",
      );
    }
  }

  Future<Response> delete<T>(
      String path, {
        Map<String, dynamic>? params,
        Map<String, dynamic>? headers,
        dynamic data,
      }) async {
    if (!await isInternetAvailable()) {
      throw DioError(
        error: "No internet connection",
      );
    }

    try {
      final response = await dio.delete(
        path,
        queryParameters: params,
        options: Options(headers: headers),
        data: data,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        throw DioError(
          response: response,
          error: "HTTP Error ${response.statusCode}",
        );
      }
    } catch (e) {
      throw DioError(
        error: "Network Error: ${e.toString()}",
      );
    }
  }

  Future<Response<T>> postFormData<T>(
      String path, {
        Map<String, dynamic>? params,
        Map<String, dynamic>? headers,
        FormData? formData,
      }) async {
    if (!await isInternetAvailable()) {
      throw DioError(
        error: "No internet connection",
      );
    }

    try {
      final response = await dio.post(
        path,
        queryParameters: params,
        options: Options(headers: headers),
        data: formData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        throw DioError(
          response: response,
          error: "HTTP Error ${response.statusCode}",
        );
      }
    } catch (e) {
      throw DioError(
        error: "Network Error: ${e.toString()}",
      );
    }
  }

  Future<Response<T>> putFormData<T>(
      String path, {
        Map<String, dynamic>? params,
        Map<String, dynamic>? headers,
        FormData? formData,
      }) async {
    if (!await isInternetAvailable()) {
      throw DioError(
        error: "No internet connection",
      );
    }

    try {
      final response = await dio.put(
        path,
        queryParameters: params,
        options: Options(headers: headers),
        data: formData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        throw DioError(
          response: response,
          error: "HTTP Error ${response.statusCode}",
        );
      }
    } catch (e) {
      throw DioError(
        error: "Network Error: ${e.toString()}",
      );
    }
  }

  // Additional customizations:
  void addDefaultHeader(String key, dynamic value) {
    dio.options.headers[key] = value;
  }

  void setConnectTimeout(Duration duration) {
    dio.options.connectTimeout = duration;
  }

  void setReceiveTimeout(Duration duration) {
    dio.options.receiveTimeout = duration;
  }
}
