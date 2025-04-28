import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:turso_example/views/memo_new_screen.dart';
import 'package:turso_example/views/memos_screen.dart';

final goRouter = GoRouter(
  initialLocation: MemosScreen.screenPath,

  routes: [
    GoRoute(
      path: MemosScreen.screenPath,
      pageBuilder:
          (context, state) =>
              MaterialPage<void>(key: state.pageKey, child: MemosScreen()),
      routes: [
        GoRoute(
          path: MemoNewScreen.screenPath,
          pageBuilder:
              (context, state) => MaterialPage<void>(
                key: state.pageKey,
                child: MemoNewScreen(),
              ),
        ),
      ],
    ),
  ],
);
