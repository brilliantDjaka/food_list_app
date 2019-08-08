class FoodModel {
  String title;
  String href;
  String ingredients;
  String thumbnail;
  FoodModel({Map foodMap}){
    this.title = foodMap['title'];
    this.href = foodMap['href'];
    this.ingredients = foodMap['ingredients'];
    this.thumbnail = foodMap['thumbnail'];
  }
}