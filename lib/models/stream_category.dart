class StreamCategory {
  final String categoryId;
  final String categoryName;
  final int parentId;

  StreamCategory({
    required this.categoryId,
    required this.categoryName,
    required this.parentId,
  });

  factory StreamCategory.fromJson(Map<String, dynamic> json) => StreamCategory(
        categoryId: json["category_id"],
        categoryName: json["category_name"],
        parentId: json["parent_id"],
      );

  Map<String, dynamic> toJson() => {
        "category_id": categoryId,
        "category_name": categoryName,
        "parent_id": parentId,
      };
}
