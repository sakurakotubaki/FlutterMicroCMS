import 'package:dio/dio.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

mixin ApiService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://xityyp5xvg.microcms.io/api/v1/',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
      headers: {
        // APIキーを.envから取得
        'X-MICROCMS-API-KEY': dotenv.env['MICROCMS_API_KEY'],
      },
    ),
  );
}
