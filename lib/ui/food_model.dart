class FoodModel {
  String id;
  String title;
  String thumbnail;
  FoodModel({Map foodMap}){
    this.id = foodMap['idMeal'];
    this.title = foodMap['strMeal'];
    this.thumbnail = foodMap['strMealThumb'];
  }

  FoodModel.fromFoodModelMap(Map foodModel){
    this.id = foodModel['id'];
    this.title = foodModel['title'];
    this.thumbnail = foodModel['thumbnail'];
  }
  String getData(){
    return'$title\n'
        '$thumbnail\n'
        '$id';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'thumbnail': thumbnail
    };
  }
}