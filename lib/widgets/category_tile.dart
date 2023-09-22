import 'package:flutter/material.dart';

import '../models/stream_category.dart';

class CategoryTile extends StatelessWidget {
  const CategoryTile({super.key, required this.category});

  final StreamCategory category;

  @override
  Widget build(BuildContext context) {
    return ListTile(title: Text(category.categoryName));
  }
}
