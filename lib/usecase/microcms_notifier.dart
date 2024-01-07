import 'package:microcms_api/core/logger.dart';
import 'package:microcms_api/model/blog_state.dart';
import 'package:microcms_api/repository/microcms_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'microcms_notifier.g.dart';

// ViewとModelの橋渡しをするViewModel
@riverpod
class MicroCmsNotifier extends _$MicroCmsNotifier {
  @override
  FutureOr<List<ResponseModel>> build() {
    return getCategories();
  }

  Future<List<ResponseModel>> getCategories() async {
    try {
      logger.d('AsyncNotifierを実行👻');
      return ref.read(microCmsApiProvider).getCategories();
    } catch (e) {
      logger.d('すべてのエラー: $e');
      throw Exception(e);
    }
  }
}
