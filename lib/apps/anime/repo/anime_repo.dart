import 'package:flutter_usecase_template/api/pagination_response_model.dart';
import 'package:flutter_usecase_template/apps/anime/models/anime.dart';
import 'package:flutter_usecase_template/base/resource.dart';

import '../../../api/dio_client.dart';

class AnimeRepo {
  final DioClient _dioClient;
  AnimeRepo(this._dioClient);

  Future<Resource<PaginatedResponse<Anime>, String>> getAnimes({
    int page = 1,
    int? limit = 20,
  }) async {
    try {
      final response = await _dioClient.get(
        '/anime',
        queryParameters: {
          "page": page,
          "limit": limit,
        },
      );
      PaginatedResponse<Anime> apiResponse = PaginatedResponse.fromJson(
          response.data, (item) => Anime.fromJson(item));
      return apiResponse.toResourceSuccess();
    } on DioException catch (e) {
      return e.errorMessage.toResourceFailure();
    }
  }
}
