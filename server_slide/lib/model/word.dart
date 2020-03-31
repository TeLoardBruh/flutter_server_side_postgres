import 'package:server_slide/server_slide.dart';


class Word extends ManagedObject<_Word> implements _Word{

}
class _Word{
  @primaryKey
  int id;

  @Column(unique: true, indexed: true)
  String word;

  Document content;
}