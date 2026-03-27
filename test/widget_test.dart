import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nordquest_webapp/src/app/app.dart';

void main() {
  test('NordQuestApp can be instantiated', () {
    const app = NordQuestApp();

    expect(app, isA<Widget>());
    expect(app.key, isNull);
  });
}
