import 'package:flutter/material.dart';

import '../models/category.dart';

class CategoryTile extends StatelessWidget {
  const CategoryTile({super.key, required this.category});

  final Category category;

  @override
  Widget build(BuildContext context) {
    return ListTile(title: Text(category.categoryName));
  }
}
