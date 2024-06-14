import 'package:flutter/material.dart';
import 'recipe.dart';

class RecipeDetailScreen extends StatelessWidget {
  final Recipe recipe;

  RecipeDetailScreen({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Recipe Title: ${recipe.title}',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Text(
              'Recipe ID: ${recipe.id}',
              style: TextStyle(fontSize: 20),
            ),
            // Add more details as needed
          ],
        ),
      ),
    );
  }
}
