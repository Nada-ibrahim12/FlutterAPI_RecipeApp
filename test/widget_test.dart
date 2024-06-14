import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_app/main.dart';  // Ensure this path is correct

void main() {
  testWidgets('RecipeListScreen test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Add your widget tests here.
    expect(find.text('Recipes'), findsOneWidget);
  });
}
