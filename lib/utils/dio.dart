import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

class DioClient {
  final Dio _dio = Dio();
  final box = GetStorage();

  DioClient() {
    _dio.options.baseUrl =
        'https://strategic-adina-nurman-629004a9.koyeb.app/api';
    _dio.options.connectTimeout = const Duration(milliseconds: 5000);
    _dio.options.receiveTimeout = const Duration(milliseconds: 3000);

    _dio.options.validateStatus = (status) {
      return status! < 500;
    };
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        options.headers['Authorization'] =
            'Bearer opiuiunouOIUOIBUIQUIQUI909898127iuyi78998anuikiuitu665qq545q61vguyiuyqt6quyigs';
        var jwt = box.read('jwt');
        if (jwt != null) {
          options.headers['Cookie'] = 'jwt=$jwt';
        }
        return handler.next(options);
      },
    ));
  }

  Dio get dio => _dio;
}
