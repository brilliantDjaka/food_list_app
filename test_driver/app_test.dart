// Imports the Flutter Driver API
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('FoodList Test', () {
    group('instrumen test', () {
      final title = find.byValueKey('title');
      FlutterDriver driver;

      // Connect to the Flutter driver before running any tests
      setUpAll(() async {
        driver = await FlutterDriver.connect();
      });
      test('check app tab', () async {
        await driver.waitFor(find.text('Dessert'));
        await driver.waitFor(find.text('Seafood'));
        await driver.waitFor(find.text('Favorite'));
        await driver.tap(find.text('Favorite'));
        await driver.waitFor(find.text('No Data'));
      });
      test('check app favorite', () async {
        await driver.tap(find.text('Favorite'));
        await driver.waitFor(find.text('No Data'));
      });
      test('add favorite test', () async {
        await driver.tap(find.text('Dessert'));
        await driver.waitFor(find.byValueKey('foodCard0'));
        await driver.tap(find.byValueKey('foodCard0'));
        await driver.waitFor(find.byType('ListView'));
        await driver.scrollUntilVisible(
            find.byType('ListView'), find.text('Add To Favorite'),
            dyScroll: -10);
        await driver.tap(find.text('Add To Favorite'));
      });
      test('delete favorite test', () async {
        await driver.tap(find.text('Favorite'));
        await driver.waitFor(find.byValueKey('foodCard0'));
        await driver.tap(find.byValueKey('foodCard0'));
        await driver.waitFor(find.byType('ListView'));
        await driver.scrollUntilVisible(
            find.byType('ListView'), find.text('Delete from Favorite'),
            dyScroll: -10);
      });
      // Close the connection to the driver after the tests have completed
      tearDownAll(() async {
        if (driver != null) {
          driver.close();
        }
      });
    });
  });
//  group('Counter App', () {
//    // First, define the Finders. We can use these to locate Widgets from the
//    // test suite. Note: the Strings provided to the `byValueKey` method must
//    // be the same as the Strings we used for the Keys in step 1.
//    final counterTextFinder = find.byValueKey('counter');
//    final buttonFinder = find.byValueKey('increment');
//
//    FlutterDriver driver;
//
//    // Connect to the Flutter driver before running any tests
//    setUpAll(() async {
//      driver = await FlutterDriver.connect();
//    });
//
//    // Close the connection to the driver after the tests have completed
//    tearDownAll(() async {
//      if (driver != null) {
//        driver.close();
//      }
//    });
//
//    test('starts at 0', () async {
//      // Use the `driver.getText` method to verify the counter starts at 0.
//      expect(await driver.getText(counterTextFinder), "0");
//    });
//
//    test('increments the counter', () async {
//      // First, tap on the button
//      await driver.tap(buttonFinder);
//
//      // Then, verify the counter text has been incremented by 1
//      expect(await driver.getText(counterTextFinder), "1");
//    });
//  });
}
