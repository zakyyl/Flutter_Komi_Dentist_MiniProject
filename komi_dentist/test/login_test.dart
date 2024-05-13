import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:komi_dentist/screens/login_screen.dart';
import 'package:komi_dentist/screens/home_screen.dart'; 

void main() {
  testWidgets('Login screen UI test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: LoginScreen()));
    expect(find.byType(Image), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
    
    await tester.enterText(find.byType(TextFormField).at(0), 'test@example.com');
    await tester.enterText(find.byType(TextFormField).at(1), 'password');
    
    await tester.tap(find.text('L O G I N'));
    await tester.pump();
    
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    
    await tester.pump(Duration(seconds: 1));
    
    expect(find.byType(CircularProgressIndicator), findsNothing);
    
    expect(find.byType(HomeScreen), findsOneWidget);
  });
}
