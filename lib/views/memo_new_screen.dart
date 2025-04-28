import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:turso_example/notifiers/memos_notifier.dart';
import 'package:turso_example/repository/memo_repository.dart';

/// メモ入力画面
class MemoNewScreen extends ConsumerWidget {
  final TextEditingController _memoController = TextEditingController();

  MemoNewScreen({super.key});

  static const String screenPath = '/memo_new';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text('メモを入力')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _memoController,
              maxLines: null, // 複数行入力可能にする
              decoration: InputDecoration(
                labelText: 'メモを入力してください',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {
                final memoRepository = MemoRepository();
                await memoRepository.insert(_memoController.text);
                ref.read(memosNotifierProvider.notifier).reload();
                if (context.mounted) context.pop();
              },
              child: Text('登録'),
            ),
          ],
        ),
      ),
    );
  }
}
