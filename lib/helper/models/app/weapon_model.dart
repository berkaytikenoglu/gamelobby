enum WeaponType {
  sidearms, // Beylik silahı
  smgs, // Hafif makineli
  rifles, // Tüfek
  sniperRifles, // Keskin nişancı tüfeği
}

class WeaponModel {
  final int id;
  final String name;
  final int damage;
  final double weight;
  final WeaponType type;
  final String imageUrl;

  WeaponModel({
    required this.id,
    required this.name,
    required this.damage,
    required this.weight,
    required this.type,
    required this.imageUrl,
  });

  factory WeaponModel.fromJson(Map<String, dynamic> json) {
    return WeaponModel(
      id: json['id'] as int,
      name: json['name'] as String,
      damage: json['damage'] as int,
      weight: (json['weight'] as num).toDouble(),
      type: WeaponType.values.firstWhere(
        (e) => e.toString().split('.').last == json['type'],
        orElse: () => WeaponType.sidearms,
      ),
      imageUrl: json['imageUrl'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'damage': damage,
      'weight': weight,
      'type': type.toString().split('.').last,
      'imageUrl': imageUrl,
    };
  }
}
