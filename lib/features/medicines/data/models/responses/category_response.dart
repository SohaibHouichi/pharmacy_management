class CategoryResponse {
  final int id;
  final String name;
  final String nameAr;

  const CategoryResponse({
    required this.id,
    required this.name,
    required this.nameAr,
  });

  factory CategoryResponse.fromJson(Map<String, dynamic> json) {
    return CategoryResponse(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
      nameAr: json['name_ar'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'name_ar': nameAr,
      };
}