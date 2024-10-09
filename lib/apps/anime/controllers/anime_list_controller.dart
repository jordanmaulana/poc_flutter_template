import 'package:flutter_usecase_template/apps/anime/models/anime.dart';
import 'package:flutter_usecase_template/apps/anime/repo/anime_repo.dart';
import 'package:flutter_usecase_template/base/base_controller.dart';
import 'package:get/get.dart';

class AnimeListController extends BaseListController {
  final AnimeRepo _animeRepo = Get.find();
  List<Anime> data = [];

  @override
  void getData() async {
    setLoading(true);
    final result = await _animeRepo.getAnimes(page: page);
    result.when(
      onSuccess: (data) {
        if (page == 1) this.data = [];
        this.data.addAll(data.data);
        hasNext = data.pagination.hasNextPage;
        update();
      },
      onFailure: (error) {
        this.error = error;
        update();
      },
    );
    setLoading(false);
  }

  @override
  void onInit() {
    getData();
    super.onInit();
  }
}
