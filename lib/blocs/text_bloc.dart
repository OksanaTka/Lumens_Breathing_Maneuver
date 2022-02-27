import 'dart:async';

import 'package:breathing_maneuver/events/text_event.dart';


class TextBlock {
  String _message = "";

  // The subscription on events from eventStream
  late StreamSubscription _sub;

  final _stateStreamController = StreamController<String>();

  //input
  StreamSink<String> get messageSink => _stateStreamController.sink;

  //output
  Stream<String> get messageStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<TextEvent>();

  //inputs events
  StreamSink<TextEvent> get eventSink => _eventStreamController.sink;

  //outputs events
  Stream<TextEvent> get eventStream => _eventStreamController.stream;

  Future<void> closeStream() => _stateStreamController.close();

  TextBlock() {
    generate();
  }

  void generate() {
    //receive events
    _sub = eventStream.listen(_mapEventToState);
  }

  //handle events
  void _mapEventToState(TextEvent event) {
    if (event is StartInhalingEvent) {
      _message = 'Start Inhaling';
    } else if (event is KeepGoingEvent) {
      _message = 'Keep going!!!';
    } else if (event is WellDoneEvent) {
      _message = 'Well Done!';
    }
    //check if stream is closed
    if (!_stateStreamController.isClosed) {
      messageSink.add(_message);
    } else {
      dispose();
    }
  }

  //close stream
  void dispose() {
    _stateStreamController.close();
    _eventStreamController.close();
    _sub.cancel();
  }
}
