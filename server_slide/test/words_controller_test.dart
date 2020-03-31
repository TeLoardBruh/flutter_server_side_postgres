import 'harness/app.dart';

Future main() async {
  final harness = Harness()..install();

  test("GET /words return 200 ok",() async{
    final response = await harness.agent.get('/words');
    expect(response.statusCode, 200);
  });

  test("Post /words return 200 ok",() async{
    await harness.agent.post('/words',body:{
      'word': 'test',
      'content' : {'description' : 'testing working'}
    });
    final response = await harness.agent.get('/words');
    expect(response.statusCode, 200);
  });
  
}
