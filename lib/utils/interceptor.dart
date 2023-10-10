import 'package:dio/dio.dart';

class AuthorizationInterceptor extends Interceptor {
  final String authToken;

  AuthorizationInterceptor(this.authToken);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Add the authorization header with the token to the request
    options.headers['Authorization'] = 'Bearer $authToken';
    super.onRequest(options, handler);
  }
}

