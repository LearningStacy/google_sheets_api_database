import 'dart:convert';

class LetterCharFields{
  static final String id='ID';
  static final String letterChar = 'Letter';
}

class LetterChar{
  final int? id;
  final String letterChar;

  const LetterChar({
    this.id, required this.letterChar
  });

  LetterChar copy({
    int? id,
    String? letterChar
  }) => LetterChar(id: id??this.id,letterChar: letterChar??this.letterChar);

  static LetterChar fromJson(Map<String, dynamic> json) => LetterChar(
      id: jsonDecode(json[LetterCharFields.id]),
      letterChar: json[LetterCharFields.letterChar],
  );

  Map<String, dynamic> toJson() => {
    LetterCharFields.id: id,
    LetterCharFields.letterChar:letterChar,

  };
}