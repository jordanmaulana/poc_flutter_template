import 'package:flutter_usecase_template/apps/anime/controllers/anime_list_controller.dart';
import 'package:flutter_usecase_template/apps/anime/models/anime.dart';
import 'package:flutter_usecase_template/base/export_view.dart';
import 'package:flutter_usecase_template/components/lists.dart';

class AnimeListView extends StatelessWidget {
  const AnimeListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: VText("Anime List"),
      ),
      body: GetBuilder(
        builder: (AnimeListController controller) {
          return VPaginatedList(
            loading: controller.loading,
            page: controller.page,
            length: controller.data.length,
            onNext: controller.nextPage,
            onRefresh: controller.resetPage,
            errorMsg: controller.error,
            itemBuilder: (c, i) {
              Anime data = controller.data[i];
              return ListTile(
                title: VText(data.title),
                subtitle: VText(data.status),
              );
            },
          );
        },
      ),
    );
  }
}
