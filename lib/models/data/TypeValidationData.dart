class TypeValidationData {
  static final String typeValidationTable = "Type_Validation";

  static final String colonnePkId = "nom";
  static final String colonneDescription = "description";

  static final String createTableScript = '''
    CREATE TABLE $typeValidationTable(
        $colonnePkId              Varchar(50)  PRIMARY KEY NOT NULL,
        $colonneDescription       Text
  );''';

}
