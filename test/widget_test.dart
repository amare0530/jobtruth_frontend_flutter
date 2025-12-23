import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jobtruth_frontend_flutter/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const JobTruthApp());

    // 檢查是否成功渲染 MaterialApp
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}