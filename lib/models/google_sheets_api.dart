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


}