// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_list_by_brian/helper/request.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  RequestHelper requestHelper = RequestHelper();

  group('request fuct test', () {
    test('getFood', () async {
      final client = MockClient();
      when(client.get(
          'https://www.themealdb.com/api/json/v1/1/lookup.php?i=52959'))
          .thenAnswer((_) async =>
          http.Response(
              '{"meals" : '
                  '['
                  '{'
                  ' "idMeal": "52959"'
                  '}'
                  ']'
                  '}',
              200));
      expect(await requestHelper.getFood('52959', client), {'idMeal': '52959'});
    });
    test('getFoodData', () async {
      final client = MockClient();
      when(client.get(
          'https://www.themealdb.com/api/json/v1/1/filter.php?c=dessert'))
          .thenAnswer((_) async =>
          http.Response(
              '{"meals" : '
                  '['
                  '{'
                  ' "idMeal": "52959",'
                  '"strMeal": "Baked salmon with fennel & tomatoes",'
                  '"strInstructions": "Heat oven to 180C/fan 160C/gas 4. Trim the fronds from the fennel and set aside. Cut the fennel bulbs in half, then cut each half into 3 wedges. Cook in boiling salted water for 10 mins, then drain well. Chop the fennel fronds roughly, then mix with the parsley and lemon zest.Spread the drained fennel over a shallow ovenproof dish, then add the tomatoes. Drizzle with olive oil, then bake for 10 mins. Nestle the salmon among the veg, sprinkle with lemon juice, then bake 15 mins more until the fish is just cooked. Scatter over the parsley and serve.",'
                  '"strMealThumb": "https://www.themealdb.com/images/media/meals/1548772327.jpg"'
                  '}'
                  ']'
                  '}',
              200));
      expect(await requestHelper.getFoodData(category: 'dessert', http: client),
          isInstanceOf<List>());
    });
    test('search', () async {
      final client = MockClient();
      when(client.get(
          'https://www.themealdb.com/api/json/v1/1/search.php?s=dessert'))
          .thenAnswer((_) async =>
          http.Response(
              '{"meals" : '
                  '['
                  '{'
                  ' "idMeal": "52959",'
                  '"strMeal": "Baked salmon with fennel & tomatoes",'
                  '"strInstructions": "Heat oven to 180C/fan 160C/gas 4. Trim the fronds from the fennel and set aside. Cut the fennel bulbs in half, then cut each half into 3 wedges. Cook in boiling salted water for 10 mins, then drain well. Chop the fennel fronds roughly, then mix with the parsley and lemon zest.Spread the drained fennel over a shallow ovenproof dish, then add the tomatoes. Drizzle with olive oil, then bake for 10 mins. Nestle the salmon among the veg, sprinkle with lemon juice, then bake 15 mins more until the fish is just cooked. Scatter over the parsley and serve.",'
                  '"strMealThumb": "https://www.themealdb.com/images/media/meals/1548772327.jpg"'
                  '}'
                  ']'
                  '}',
              200));
      expect(
          await requestHelper.searchFood(searchString: 'dessert', http: client),
          isInstanceOf<List>());
    });
  });
}
