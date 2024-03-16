import 'package:gsheets/gsheets.dart';
import 'package:search_database_sheets_api/models/PokemonFields.dart';

class GoogleSheetsAPI {
  static const _credentials = r'''
  
  ''';

  static final _spreadsheetID="";

  static final _gsheets=GSheets(_credentials);
  static Worksheet? _pokemonSheet;

  static Future init() async{
    final spreadsheet = await _gsheets.spreadsheet(_spreadsheetID);
    _pokemonSheet = spreadsheet.worksheetByTitle('Pokemon Table');
  }

  static Future<Pokemon?> getById(int id) async{
    if (_pokemonSheet == null) return null;

    final json = await _pokemonSheet!.values.map.rowByKey(id, fromColumn: 1);
      return json ==null ? null:Pokemon.fromJson(json);
  }

  static Future<int> getRowCount() async{
    if(_pokemonSheet == null) return 0;

    final lastRow = await _pokemonSheet!.values.lastRow();

    return lastRow == null ? 0: int.tryParse(lastRow.first) ?? 0;
  }

  static Future<List<Pokemon>> getAllPokemon() async{
    if(_pokemonSheet == null) return <Pokemon>[];

    final allPokemon = await _pokemonSheet!.values.map.allRows();
    return allPokemon == null ? <Pokemon>[] : allPokemon.map(Pokemon.fromJson).toList();
  }


}