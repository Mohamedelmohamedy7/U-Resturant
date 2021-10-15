class Meal {
  String? title;
  String? calories;
  String? ingredients;
  String? steps;
  String? serving;
  String? imageUrl;
  String? minites;

  Meal({
    this.title,
    this.calories,
    this.ingredients,
    this.steps,
    this.serving,
    this.imageUrl,
    this.minites,
   });

  Meal.fromjson(Map<String, dynamic> map) {
    if (map == null) {
     print("===>null");
    }
    title = map["title"];
    calories = map["caliores"];
    ingredients = map["ingrediants"];
    steps = map["steps"];
    serving = map["servising"];
    imageUrl = map["imageUrl"];
    minites = map["minites"];
  }

  toJson() {
    return {
      calories: "calories",
      ingredients: "ingredients",
      steps: "steps",
      serving: "serving",
      imageUrl: "imageUrl",
       title: "title",
      minites: "minites",
    };
  }
}
