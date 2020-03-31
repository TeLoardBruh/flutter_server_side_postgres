import 'package:server_slide/server_slide.dart';
import '../model/word.dart';

class WordsController extends ResourceController {
  WordsController(this.context);

  ManagedContext context;

  // final _words=[
  //   {'word':'horse_1'},
  //   {'word':'horse_2'},
  //   {'word':'horse_3'},
  //   {'word':'horse_4'},
  //   {'word':'horse_5'},
  // ];

  @Operation.get()
  Future<Response> getAllWords({@Bind.query('q') String prefix}) async {
    final query = Query<Word>(context);

    if (prefix != null) {
      query.where((w) => w.word).beginsWith(prefix, caseSensitive: false);
    }

    // sorting and limiting the number of return word
    query
      ..sortBy((w) => w.word, QuerySortOrder.ascending)
      ..fetchLimit = 10;
    final wordList = await query.fetch();
    return Response.ok(wordList);
  }

  @Operation.get('id')
  Future<Response> getWordById(@Bind.path('id') int id) async {
    // int id = int.parse(request.path.variables['id']);
    final query = Query<Word>(context)..where((w) => w.id).equalTo(id);
    final word = await query.fetchOne();

    if(word==null){
      return Response.notFound();
    }
    return Response.ok(word);
  }

  @Operation.post()
  Future<Response> addWord(@Bind.body(ignore: ['id']) Word newWord) async {
    final query = Query<Word>(context)..values = newWord;
    final insertWord = await query.insert();

    return Response.ok(insertWord);
  }

  @Operation.put('id')
  Future<Response> updateWord(@Bind.path('id') int id,
      @Bind.body(ignore: ['id']) Word userUpdate) async {
    final query = Query<Word>(context)
      ..values = userUpdate
      ..where((w) => w.id).equalTo(id);
    final updateWord = await query.updateOne();
    return Response.ok(updateWord);
  }

  @Operation.delete('id')
  Future<Response> deleteWord(@Bind.path('id') int id) async {

    final query = Query<Word>(context)
      ..where((w) => w.id).equalTo(id);

    final deleteWord = await query.delete();

    final messageToUser = {'message': 'Deleted $deleteWord word(s)'};
    return Response.ok(messageToUser);
  }
}
