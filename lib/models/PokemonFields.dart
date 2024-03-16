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

  Map<String, dynamic> toJson() => {
    PokemonFields.id: id,
    PokemonFields.name:name,
    PokemonFields.elementType: elementType,
    PokemonFields.generation: generation
  };
}