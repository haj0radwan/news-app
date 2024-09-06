import 'package:news_app/features/news/data/models/articldto.dart';
import 'package:news_app/features/news/data/models/source.dart';
import 'package:news_app/features/news/domain/entities/newsentity.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'news_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
        '''CREATE TABLE sources(idd INTEGER PRIMARY KEY AUTOINCREMENT ,id TEXT,name TEXT)''');
    await db.execute('''
      CREATE TABLE news(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        author TEXT,
        title TEXT,
        description TEXT,
        url TEXT,
        urlToImage TEXT,
        publishedAt TEXT,
        content TEXT,
        sourceId INTEGER,
        FOREIGN KEY (sourceId) REFERENCES sources (idd)
      )
    ''');
  }

  Future<int> insertSource(Source source) async {
    final db = await database;
    final counter = await db.rawQuery('SELECT COUNT(*) FROM sources');
    // final count = counter.first["COUNT(*)"];
    int count = Sqflite.firstIntValue(counter) ?? 0;
    // print(" the count is $count");
    if (count == 0) {
      await db.execute('DELETE FROM sqlite_sequence WHERE name = "sources"');
    }
    int x = await db.insert(
      'sources',
      source.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return x;
  }

  Future<void> insertSourceAndNews(Article art) async {
    int sourceId = await insertSource(art.source);

    final newArt = ArticleDto(
      author: art.author,
      title: art.title,
      desc: art.desc,
      url: art.url,
      urlToimg: art.urlToimg,
      publishedAt: art.publishedAt,
      content: art.content,
      sourceId: sourceId,
      source: art.source,
    );

    await insertArticle(newArt);
  }

  Future<void> insertArticle(ArticleDto news) async {
    await _database!.insert(
      'news',
      news.toJsonWithoutSource(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getTableContent(String tableName) async {
    final db = await database;

    return await db.query(tableName);
  }

  Future<void> deleteAllArticles() async {
    final db = await database;
    final int i = await db.delete('news');
    final int s = await db.delete('sources');
    // await db.execute('VACUUM');
    print("from news there is $i  row deleted");
    print("from sources there is $s  row deleted");
  }

  Future<List<ArticleDto>> getArticlesWithSources() async {
    final db = await database;

    final List<Map<String, dynamic>> result = await db.rawQuery('''
    SELECT 
        news.id AS id,
        news.author AS author,
        news.title AS title ,
        news.description AS desc,
        news.url AS url ,
        news.urlToImage AS urlToimg ,
        news.publishedAt AS publishedAt,
        news.content AS content,
        sources.id  AS sourceid ,
        sources.name AS sourceName,
        sources.idd AS sourceId
    FROM 
        news
    INNER JOIN 
        sources ON news.sourceId = sources.idd;
  ''');
    List<ArticleDto> list = [];

    for (var a in result) {
      list.add(ArticleDto.fromMap(a));
    }
    return list;
  }

  Future<void> deleteArticle(int sourceid) async {
    final db = await database;
    int i = await db.database
        .delete("news", where: 'sourceId =? ', whereArgs: [sourceid]);

    int j = await db.database
        .delete("sources", where: 'idd =? ', whereArgs: [sourceid]);

    print("row $i deleted from news");
    print("row $j deleted from sources");
  }
}
