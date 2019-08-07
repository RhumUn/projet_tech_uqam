class DifficulteData {
  static final String difficulteTable = "Difficulte";

  static final String colonnePkId = "nom";

  static final String createTableScript = '''
    CREATE TABLE $difficulteTable(
        $colonnePkId              Varchar(50)  PRIMARY KEY NOT NULL
  );''';
}
