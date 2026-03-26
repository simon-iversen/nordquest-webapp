import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nordquest_webapp/src/app/app.dart';

void main() {
  runApp(const ProviderScope(child: NordQuestApp()));
}
