import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:microcms_api/usecase/microcms_notifier.dart';

class BlogPage extends ConsumerWidget {
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final microCmsViewModel = ref.watch(microCmsNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('ブログ'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(microCmsNotifierProvider.notifier).getCategories();
        },
        child: const Icon(Icons.refresh),
      ),
      body: microCmsViewModel.when(
        data: (data) {
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final title = data[index].title;
              print('インデックス: $index, データ: ${data[index]}'); // ログ出力
              return ListTile(
                // 画像を表示
                leading: data[index].eyecatch != null
                    ? Padding(
                        padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                        child: SizedBox(
                            width: 100,
                            height: 100,
                            child: Image.network(data[index].eyecatch!.url)),
                      )
                    : null,
                title: Text(title!),
              );
            },
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stackTrace) => Center(
          child: Text(error.toString()),
        ),
      ),
    );
  }
}
