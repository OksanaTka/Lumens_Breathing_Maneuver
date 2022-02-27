import 'dart:async';

class NumbersBloc {
  int _numberInt = 0;

  // The subscription on events from  breathStream()
  late StreamSubscription _sub;

  // The controller to stream the final output to the required StreamBuilder
  final _stateStreamController = StreamController<int>();

  StreamSink<int> get numbersSink => _stateStreamController.sink;

  Stream<int> get numbersStream => _stateStreamController.stream;

  Future<void> closeStream() => _stateStreamController.close();

  NumbersBloc() {
    generate();
  }

  Stream<int> breathStream() {
    final flow = [
      1,
      10,
      15,
      20,
      22,
      28,
      40,
      43,
      45,
      57,
      60,
      63,
      69,
      82,
      88,
      90,
      92,
      95,
      100
    ];
    return Stream.periodic(const Duration(milliseconds: 400), (i) => flow[i])
        .take(flow.length);
  }

  void generate() {
    //receive flow numbers
    _sub = breathStream().listen((number) {
      _numberInt = number;
      //check if stream is closed
      if (!_stateStreamController.isClosed) {
        numbersSink.add(_numberInt);
      } else {
        dispose();
      }
    });
  }

  //close streams
  void dispose() {
    _stateStreamController.close();
    _sub.cancel();
  }
}
