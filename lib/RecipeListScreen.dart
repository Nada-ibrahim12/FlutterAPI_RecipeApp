import 'package:flutter/material.dart';
import 'RecipeService.dart';
import 'recipe.dart';
import 'RecipeDetailsScreen.dart';  // Import the new screen

class RecipeListScreen extends StatefulWidget {
  const RecipeListScreen({super.key});

  @override
  _RecipeListScreenState createState() => _RecipeListScreenState();
}

class _RecipeListScreenState extends State<RecipeListScreen> {
  late Future<List<Recipe>> futureRecipes;

  @override
  void initState() {
    super.initState();
    // Wrap in try-catch to handle any exceptions during initialization
    try {
      futureRecipes = RecipeService().fetchRecipes();
    } catch (e) {
      print('Error initializing recipes: $e');
      futureRecipes = Future.error(e); // Propagate the error to FutureBuilder
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipes'),
        backgroundColor: Colors.green,
      ),
      body: FutureBuilder<List<Recipe>>(
        future: futureRecipes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No recipes found'));
          } else {
            final recipes = snapshot.data!;
            return ListView.builder(
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                final recipe = recipes[index];
                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    title: Text(
                      recipe.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        recipe.imageUrl,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    onTap: () async {
                      try {
                        final detailedRecipe = await RecipeService().fetchRecipeDetails(recipe.id);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RecipeDetailScreen(recipe: detailedRecipe),
                          ),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Failed to load recipe details: $e'),
                          ),
                        );
                      }
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
