class FoodModel {
  String id;
  String title;
  String thumbnail;
  FoodModel({Map foodMap}){
    this.id = foodMap['idMeal'];
    this.title = foodMap['strMeal'];
    this.thumbnail = foodMap['strMealThumb'];
  }
  String getData(){
    return'$title\n'
        '$thumbnail\n'
        '$id';
  }
}