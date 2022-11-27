import 'dart:ui';

class CategoryFood {
  const CategoryFood({
    required this.id,
    required this.title,
    required this.places,
    required this.logoPath,
    required this.color,
  });

  final int id;
  final String title;
  final int places;
  final String logoPath;
  final Color color;
}
