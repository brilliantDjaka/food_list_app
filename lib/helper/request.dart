import 'dart:convert';
import 'package:http/http.dart';
import '../ui/food_model.dart';
import '../config.dart';

class RequestHelper {
  Future<Map> getFood(id, Client http) async {
    Response data = await http
        .get('https://www.themealdb.com/api/json/v1/1/lookup.php?i=$id');
    Map result = json.decode(data.body);
    result = result['meals'][0];
    return result;
  }

  Future<List> getFoodData({String category, Client http}) async {
    var response = await http.get(
      'https://www.themealdb.com/api/json/v1/1/filter.php?c=$category',
    );
    Map tempData = await json.decode(response.body);
    if (response.statusCode != 200) {
      return [];
    }
    List result = tempData['meals'].map((e) => FoodModel(foodMap: e)).toList();
    return result;
  }

  Future searchFood({String searchString, Client http}) async {
    if (Config.isDebug) print('a');
    var response = await http.get(
      'https://www.themealdb.com/api/json/v1/1/search.php?s=$searchString',
    );
    if (response.statusCode != 200) {
      return Future.error('');
    }
    Map tempData = await json.decode(response.body);
    if (tempData['meals'] == null) return Future.error('');
    if (Config.isDebug) print(tempData);
    List result = tempData['meals'].map((e) => FoodModel(foodMap: e)).toList();
    if (Config.isDebug) print(result);
    return result;
  }

}


