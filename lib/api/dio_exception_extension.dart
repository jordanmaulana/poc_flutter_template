import 'package:dio/dio.dart';
import 'package:flutter_usecase_template/api/base_response_model/error_response_model.dart';
import 'package:get/get.dart';

/// This is the error parser. It is used as standard to parse error from API responses.
extension ResponseExtension on DioException {
  ErrorResponse get errorResponse {
    Map<String, dynamic>? res = response?.data as Map<String, dynamic>;
    ErrorResponse result = ErrorResponse.fromJson(res);
    return result;
  }

  String get errorMessage {
    if (response != null) {
      String? error;
      try {
        Map<String, dynamic>? res = response?.data as Map<String, dynamic>;
        ErrorResponse result = ErrorResponse.fromJson(res);
        error = '';
        result.messages?.forEach(
          (key, value) {
            for (var element in value) {
              error = '$error $element\n';
            }
          },
        );
      } catch (e) {
        Get.log('Error $e');
      }

      switch (response!.statusCode) {
        case 400:
          return error ?? 'Masukan tidak valid';
        case 403:
          return error ?? 'Akses tidak tersedia';
        case 404:
          return error ?? 'Layanan tidak lagi tersedia';
        case 500:
          return error ?? 'Layanan sedang diperbaiki';
        default:
          return error ?? 'Terjadi kesalahan';
      }
    } else {
      /// Something happened in setting up or sending the request that triggered an Error
      return 'ERROR\n${requestOptions.uri.path.toString()}\n${toString()}';
    }
  }
}
