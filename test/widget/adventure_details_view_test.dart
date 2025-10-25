import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:adven_hive/UI/views/adventure_details_view.dart';
import 'package:adven_hive/core/adventure_repo_implmnt.dart';
import '../helpers/mock_repository.dart';
import '../helpers/test_helpers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AdventureDetailsView Widget Tests', () {
    late MockAdventureRepository mockRepo;

    setUp(() {
      setupGetX();
      mockRepo = MockAdventureRepository();
      Get.put<AdventureRepository>(mockRepo);
      Get.put(AdventureDetailsController());
    });

    tearDown(() {
      cleanupGetX();
    });

    // Test: Initial UI Rendering
    testWidgets('should render main components', (tester) async {
      await tester.pumpWidget(
        wrapWithGetMaterialApp(const AdventureDetailsView()),
      );

      expect(find.text('Plan Your\nAdventure'), findsOneWidget);
      expect(find.text('What type of adventure?'), findsOneWidget);
      expect(find.text('Next →'), findsOneWidget);
    });

    // Test: Adventure Type Selection
    testWidgets('should select and deselect adventure type', (tester) async {
      await tester.pumpWidget(
        wrapWithGetMaterialApp(const AdventureDetailsView()),
      );

      final controller = Get.find<AdventureDetailsController>();

      // Select Hiking
      await tester.tap(find.text('Hiking'));
      await tester.pump();
      expect(controller.adventureType.value, 'Hiking');

      // Deselect Hiking
      await tester.tap(find.text('Hiking'));
      await tester.pump();
      expect(controller.adventureType.value, '');
    });

    // Test: Form Input
    testWidgets('should enter text in members field', (tester) async {
      await tester.pumpWidget(
        wrapWithGetMaterialApp(const AdventureDetailsView()),
      );

      final controller = Get.find<AdventureDetailsController>();
      final membersField = find.widgetWithText(
        TextFormField,
        'Enter number of members',
      );

      await tester.enterText(membersField, '5');
      await tester.pump();

      expect(controller.members.value, '5');
    });

    // Test: Pagination Navigation
    testWidgets('should navigate to second page on Next tap', (tester) async {
      await tester.pumpWidget(
        wrapWithGetMaterialApp(const AdventureDetailsView()),
      );

      // Tap Next button
      await tester.tap(find.text('Next →'));
      await tester.pumpAndSettle();

      // Should show second page content
      expect(
        find.text('How far are you planning to\ntravel/walk?'),
        findsOneWidget,
      );
      expect(find.text('Start generating ⚡'), findsOneWidget);
    });

    // Test: Weather Selection on Second Page
    testWidgets('should select weather condition on page 2', (tester) async {
      await tester.pumpWidget(
        wrapWithGetMaterialApp(const AdventureDetailsView()),
      );

      final controller = Get.find<AdventureDetailsController>();

      // Navigate to second page
      await tester.tap(find.text('Next →'));
      await tester.pumpAndSettle();

      // Select Sunny weather
      await tester.tap(find.text('Sunny'));
      await tester.pump();

      expect(controller.weather.value, 'Sunny');
    });

    // Test: Complete Form Submission Flow
    testWidgets('should complete full form and validate', (tester) async {
      await tester.pumpWidget(
        wrapWithGetMaterialApp(const AdventureDetailsView()),
      );

      final controller = Get.find<AdventureDetailsController>();

      // Fill first page
      await tester.tap(find.text('Camping'));
      await tester.pump();

      await tester.enterText(
        find.widgetWithText(TextFormField, 'Enter number of members'),
        '3',
      );
      await tester.pump();

      // Select difficulty
      await tester.tap(find.byType(DropdownButtonFormField<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Easy').last);
      await tester.pumpAndSettle();

      // Navigate to second page
      await tester.tap(find.text('Next →'));
      await tester.pumpAndSettle();

      // Fill second page
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Distance With Km'),
        '5',
      );
      await tester.pump();

      await tester.enterText(
        find.widgetWithText(TextFormField, 'Describe challenges'),
        'Basic camping',
      );
      await tester.pump();

      await tester.tap(find.text('Sunny'));
      await tester.pump();

      // Verify form is complete
      expect(controller.isFormValid, true);
      expect(controller.adventureType.value, 'Camping');
      expect(controller.members.value, '3');
      expect(controller.difficulty.value, 'Easy');
      expect(controller.weather.value, 'Sunny');
    });
  });
}
