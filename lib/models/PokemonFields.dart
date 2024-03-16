import 'dart:convert';

class PokemonFields{
  static final String id='ID';
  static final String name = 'Name of Pokemon';
  static final String elementType = 'Element Type';
  static final String generation = 'Generation';


}

class Pokemon{
  final int? id;
  final String name;
  final String elementType;
  final String generation;

  const Pokemon({
    this.id, required this.name, required this.elementType, required this.generation
  });

  Pokemon copy({
  int? id,
    String? name,
    String? elementType,
    String? generation
}) => Pokemon(id: id??this.id,name: name??this.name, elementType: elementType??this.elementType, generation: generation??this.generation);
  
  static Pokemon fromJson(Map<String, dynamic> json) => Pokemon(
      id: jsonDecode(json[PokemonFields.id]),
      name: json[PokemonFields.name],
      elementType: json[PokemonFields.elementType],
      generation: json[PokemonFields.generation]
  );

  Map<String, dynamic> toJson() => {
    PokemonFields.id: id,
    PokemonFields.name:name,
    PokemonFields.elementType: elementType,
    PokemonFields.generation: generation
  };
}