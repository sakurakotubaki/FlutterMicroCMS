import 'package:dio/dio.dart';
import 'package:microcms_api/core/logger.dart';
import 'package:microcms_api/model/blog_state.dart';
import 'package:microcms_api/repository/api_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'microcms_api.g.dart';

@Riverpod(keepAlive: true)
MicroCmsApi microCmsApi(MicroCmsApiRef ref) => MicroCmsApi();

class MicroCmsApi with ApiService {
  Future<List<ResponseModel>> getCategories() async {
    try {
      final response = await dio.get('blogs');
      final data = response.data as Map<String, dynamic>; // ListからMapに戻す
      if (data.containsKey('contents') && data['contents'] is List) {
        // 'contents'フィールドを再度チェック
        final contents = data['contents'] as List;
        final contentsList = contents.map((content) {
          logger.d('リポジトリのコード🦁: $content'); // content mapをログに出力
          return ResponseModel.fromJson(content);
        }).toList();
        return contentsList;
      } else {
        logger.d('Error: contents field is missing or null in data');
        throw Exception('contents field is missing or null in data');
      }
    } on DioException catch (e) {
      logger.d('Dioのエラー: $e');
      throw Exception(e.message);
    } catch (e) {
      logger.d('すべてのエラー: $e');
      throw Exception(e);
    }
  }
}
