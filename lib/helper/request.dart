import 'dart:convert';
import 'package:http/http.dart' as http;
import '../ui/food_model.dart';

Future<Map> getFood(id) async {
  http.Response data = await http
      .get('https://www.themealdb.com/api/json/v1/1/lookup.php?i=$id');
  Map result = json.decode(data.body);
  result = result['meals'][0];
  return result;
}

Future<List> getFoodData({String category}) async {
  var response = await http.get(
      'https://www.themealdb.com/api/json/v1/1/filter.php?c=$category',
      headers: {
        'X-RapidAPI-Host': 'recipe-puppy.p.rapidapi.com',
        'X-RapidAPI-Key': '1e564e6c10msh7e12cb56442b016p1e7006jsna9fcf54df7ef'
      });
  Map tempData = await json.decode(response.body);
  if (response.statusCode != 200) {
    return [];
  }
  List result = tempData['meals'].map((e) => FoodModel(foodMap: e)).toList();
  return result;
}

Future<List<FoodModel>> getFoodByIdToFoodModel(List<Map> id) async {
  print('List Of ID : ' + id.toString());
  List finalList;
  for (var count = 0; count < id.length; count++) {
    print('item = ' + id[count].toString());
    http.Response data = await http.get(
        'https://www.themealdb.com/api/json/v1/1/lookup.php?i=${id[count]['id']}');
    Map result = json.decode(data.body);
    print('data');
    print(FoodModel(foodMap: result['meals'][0]).getData());
    finalList.add((FoodModel(foodMap: result['meals'][0])));
  }
  print('final');
  print(finalList);
  return finalList;
}
