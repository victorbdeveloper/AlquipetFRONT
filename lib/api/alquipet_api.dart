import "package:alquipet_front/services/local_storage.dart";
import "package:dio/dio.dart";

class AlquipetApi {
  static final Dio _dio = Dio();

  static void configureDio() {
    //TODO: CAMBIAR AL DESPLEGAR A PRODUCCIÓN
    /// BASE URL
    /// desarrollo - local
    // _dio.options.baseUrl = "http://localhost:8081/api";

    /// desarrollo - heroku
    // _dio.options.baseUrl = "https://alquipet.herokuapp.com/api";

    /// producción - heroku + google domains
    _dio.options.baseUrl = "https://alquipet.com/api";

    /// HEADERS
    _dio.options.headers = {
      /// establecer JWT
      "Authorization": "Bearer: ${LocalStorage.prefs.getString("token") ?? ""}"
    };
  }

  static Future dioGet(String path, {Map<String, dynamic>? queryParams}) async {
    try {
      final resp = await _dio.get(path, queryParameters: queryParams);

      return resp.data;
    } on DioError catch (e) {
      print(e.response);
      throw ("Error en el GET");
    }
  }

  static Future dioPost(String path,
      {Map<String, dynamic>? queryParams, Map<String, dynamic>? body}) async {
    FormData formData = FormData();

    ///COMPROBAR BODY
    if (body != null) {
      formData = FormData.fromMap(body);
    }

    ///REALIZAR PETICIÓN
    try {
      final resp = await _dio.post(
        path,
        queryParameters: queryParams,
        data: formData,
      );

      return resp.data;
    } on DioError catch (e) {
      print("ERROR DIO POST: $e");
      throw ("Error en el POST");
    }
  }

  static Future dioPut(String path,
      {Map<String, dynamic>? queryParams, Map<String, dynamic>? body}) async {
    FormData formData = FormData();

    ///COMPROBAR BODY
    if (body != null) {
      formData = FormData.fromMap(body);
    }

    ///REALIZAR PETICIÓN
    try {
      final resp = await _dio.put(path, data: formData);
      return resp.data;
    } on DioError catch (e) {
      print(e);
      throw ("Error en el PUT $e");
    }
  }

  static Future dioDelete(String path,
      {Map<String, dynamic>? queryParams, Map<String, dynamic>? body}) async {
    FormData formData = FormData();

    ///COMPROBAR BODY
    if (body != null) {
      formData = FormData.fromMap(body);
    }

    ///REALIZAR PETICIÓN
    try {
      final resp = await _dio.delete(path, data: formData);
      return resp.data;
    } on DioError catch (e) {
      print(e);
      throw ("Error en el delete");
    }
  }
}
