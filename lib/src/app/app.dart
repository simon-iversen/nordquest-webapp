import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nordquest_webapp/src/routing/app_router.dart';

class NordQuestApp extends ConsumerWidget {
  const NordQuestApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'NordQuest',
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF2D6A4F),
        useMaterial3: true,
      ),
    );
  }
}
