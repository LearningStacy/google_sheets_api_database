import 'package:gsheets/gsheets.dart';

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


}