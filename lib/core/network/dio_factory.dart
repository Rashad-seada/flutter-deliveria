
import 'package:delveria/core/helper/constants.dart';
import 'package:delveria/core/helper/shared_pref_helper.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioFactory {
  /// private constructor as I don't want to allow creating an instance of this class
  DioFactory._();

  static Dio? dio;

  static Dio getDio() {
    Duration timeOut = const Duration(minutes: 1);

    if (dio == null) {
      dio = Dio();
      dio!
        ..options.connectTimeout = timeOut
        ..options.receiveTimeout = timeOut
        ..options.headers = {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        };

      addDioInterceptor();
      return dio!;
    } else {
      return dio!;
    }
  }

  static void addDioInterceptor() {
    dio?.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await SharedPrefHelper.getSecuredString(SharedPrefKeys.userToken);
          final isGuest = await SharedPrefHelper.getBool(SharedPrefKeys.isGuest);
          
          print("🔑 Token: ${token.isEmpty ? 'EMPTY' : 'FOUND'}, Guest: $isGuest");
          
          // Don't attach our app token to external API calls (e.g. Paymob)
          final isExternalApi = options.uri.host.contains('paymob.com');
          
          if (token.isNotEmpty && !isGuest && !isExternalApi) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
      ),
    );

    dio?.interceptors.add(
      PrettyDioLogger(
        responseBody: true,
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
      ),
    );
  }
}
