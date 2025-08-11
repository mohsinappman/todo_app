class CategoryModel {
  String? id;
  String? name;
  String? imageUrl;
  String? colorHex;
  DateTime? createdAt;

  CategoryModel({
    this.id,
    this.name,
    this.colorHex,
    this.createdAt,
    this.imageUrl,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      imageUrl: json['image_url'] as String?,
      colorHex: json['color_hex']
          ?.toString(), // handles both hex and Color obj as string
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'image_url': imageUrl, 'color_hex': colorHex};
  }
}
