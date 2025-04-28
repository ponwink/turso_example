import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:turso_example/models/memo.dart';
import 'package:turso_example/repository/memo_repository.dart';

part 'memos_notifier.g.dart';

@riverpod
class MemosNotifier extends _$MemosNotifier {
  @override
  Future<List<Memo>> build() async {
    final memoRepository = MemoRepository();
    return await memoRepository.getAll();
  }

  // 再読み込み
  Future<void> reload() async {
    final memoRepository = MemoRepository();
    state = AsyncValue.data(await memoRepository.getAll());
  }
}
