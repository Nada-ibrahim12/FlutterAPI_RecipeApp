class Recipe {
  final int id;
  final String title;
  final String imageUrl;
  final String instructions;
  final List<String> ingredients;

  Recipe({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.instructions,
    required this.ingredients,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      imageUrl: json['image'] ?? '',
      instructions: json['instructions'] ?? 'No instructions available',
      ingredients: (json['extendedIngredients'] as List<dynamic>?)
          ?.map((ingredient) => ingredient['originalString'] as String)
          .toList() ?? [],
    );
  }
}
