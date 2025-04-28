import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:turso_example/repository/memo_repository.dart';
import 'package:turso_example/views/memo_new_screen.dart';
import 'package:turso_example/notifiers/memos_notifier.dart';

/// メモ一覧画面
class MemosScreen extends ConsumerWidget {
  const MemosScreen({super.key});

  static const String screenPath = '/';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue memosAsyncValue = ref.watch(memosNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('メモ一覧'),
        actions: [
          // 再読み込みボタン
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'refresh',
            onPressed: () {
              ref.read(memosNotifierProvider.notifier).reload();
            },
          ),
        ],
      ),
      body: memosAsyncValue.when(
        data:
            (memos) => ListView.builder(
              itemCount: memos.length,
              itemBuilder: (context, index) {
                final memo = memos[index];
                return ListTile(
                  title: Text(memo.memo),
                  subtitle: Text(memo.created),
                  leading: Icon(Icons.description),
                  trailing: IconButton(
                    onPressed: () async {
                      final memoRepository = MemoRepository();
                      await memoRepository.delete(memo.id);
                      ref.read(memosNotifierProvider.notifier).reload();
                    },
                    icon: Icon(Icons.close),
                  ),
                );
              },
            ),
        error: (error, stackTrace) => Center(child: Text('エラーが発生しました: $error')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go(MemoNewScreen.screenPath);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
