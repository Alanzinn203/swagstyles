class Sneaker {
  final String id;
  final String name;
  final String description;
  final String detailedDescription;
  final double price;
  final String imagePath;
  final String category; 
  final List<String> colors; 
  final List<String> sizes;

  Sneaker({
    required this.id,
    required this.name,
    required this.description,
    required this.detailedDescription,
    required this.price,
    required this.imagePath,
    required this.category,
    required this.colors,
    required this.sizes,
  });
}