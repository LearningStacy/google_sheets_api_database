import 'package:gsheets/gsheets.dart';
import 'package:search_database_sheets_api/models/LetterFields.dart';

class GoogleSheetsAPI {
  static const _credentials = r'''
  
  ''';

  static final _spreadsheetID="";

  static final _gsheets=GSheets(_credentials);
  static Worksheet? _alphabetSheet;

  static Future init() async{
    final spreadsheet = await _gsheets.spreadsheet(_spreadsheetID);
    _alphabetSheet = spreadsheet.worksheetByTitle('Alphabet Table');
  }

  static Future<LetterChar?> getById(int id) async{
    if (_alphabetSheet == null) return null;

    final json = await _alphabetSheet!.values.map.rowByKey(id, fromColumn: 1);
    return json ==null ? null:LetterChar.fromJson(json);
  }

  static Future<int> getRowCount() async{
    if(_alphabetSheet == null) return 0;

    final lastRow = await _alphabetSheet!.values.lastRow();

    return lastRow == null ? 0: int.tryParse(lastRow.first) ?? 0;
  }

  static Future<List<LetterChar>> getAllPokemon() async{
    if(_alphabetSheet == null) return <LetterChar>[];

    final allLetters = await _alphabetSheet!.values.map.allRows();
    return allLetters == null ? <LetterChar>[] : allLetters.map(LetterChar.fromJson).toList();
  }
}