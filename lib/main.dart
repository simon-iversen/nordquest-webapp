import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:nordquest_webapp/src/app/app.dart';

const _supabaseUrl = String.fromEnvironment(
  'SUPABASE_URL',
  defaultValue: 'https://blfjftbjxtzbtdygpcjl.supabase.co',
);

const _supabaseAnonKey = String.fromEnvironment(
  'SUPABASE_ANON_KEY',
  defaultValue:
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJsZmpmdGJqeHR6YnRkeWdwY2psIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjY0MzAwMjcsImV4cCI6MjA4MjAwNjAyN30.rFUtSEND3VLulupRRMEkvCycHJ7oNxcQYh-kp9o1HwU',
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(url: _supabaseUrl, anonKey: _supabaseAnonKey);
  runApp(const ProviderScope(child: NordQuestApp()));
}
