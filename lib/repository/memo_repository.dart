import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:libsql_dart/libsql_dart.dart';
import 'package:turso_example/models/memo.dart';

class MemoRepository {
  MemoRepository() {
    client = LibsqlClient(dotenv.env['TURSO_URL'] ?? '')
      ..authToken = dotenv.env['TURSO_AUTH_TOKEN'];
  }

  late final LibsqlClient client;

  // 全てのメモを取得
  Future<List<Memo>> getAll() async {
    await client.connect();

    final memoMaps = await client.query("SELECT * FROM memos");

    await client.dispose();

    return memoMaps.map((map) {
      return Memo(
        id: map['id'] as int,
        memo: map['memo'] as String,
        created: map['created'] as String,
      );
    }).toList();
  }

  // メモを登録
  Future<void> insert(String memoText) async {
    try {
      await client.connect();
      final statement = await client.prepare(
        'INSERT INTO memos (memo, created) VALUES (?, ?)',
      );
      statement.query(positional: [memoText, DateTime.now().toIso8601String()]);
    } catch (e) {
      print('メモの登録に失敗しました: $e');
    } finally {
      await client.dispose();
    }
  }

  // メモを削除
  Future<void> delete(int id) async {
    try {
      await client.connect();
      final statement = await client.prepare('DELETE FROM memos WHERE id = ?');
      statement.query(positional: [id]);
    } catch (e) {
      print('メモの削除に失敗しました: $e');
    } finally {
      await client.dispose();
    }
  }
}
