import 'package:server_slide/server_slide.dart';
import 'package:aqueduct_test/aqueduct_test.dart';

export 'package:server_slide/server_slide.dart';
export 'package:aqueduct_test/aqueduct_test.dart';
export 'package:test/test.dart';
export 'package:aqueduct/aqueduct.dart';

/// A testing harness for server_slide.
///
/// A harness for testing an aqueduct application. Example test file:
///
///         void main() {
///           Harness harness = Harness()..install();
///
///           test("GET /path returns 200", () async {
///             final response = await harness.agent.get("/path");
///             expectResponse(response, 200);
///           });
///         }
///
class Harness extends TestHarness<ServerSlideChannel> with TestHarnessORMMixin{
  @override
  Future onSetUp() async {
    await resetData();

  }

  @override
  Future onTearDown() async {

  }

  @override
  // TODO: implement context
  ManagedContext get context => channel.context;
}
