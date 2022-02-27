import 'package:flutter/material.dart';
import 'package:breathing_maneuver/blocs/numbers_bloc.dart';
import 'package:breathing_maneuver/blocs/text_bloc.dart';
import 'package:breathing_maneuver/events/text_event.dart';
import 'package:breathing_maneuver/views/circles_view.dart';
import 'package:breathing_maneuver/views/ring_animation.dart';
import 'package:breathing_maneuver/views/text_view.dart';
import 'main_route.dart';

class BreathRoute extends StatefulWidget {
  const BreathRoute({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<BreathRoute> {
  final _numbersBloc = NumbersBloc();
  final _textBloc = TextBlock();
  final List<Widget> circlesList = [];

  final int _perimeterCirclesNumber = 6;
  final int _streamMaxPercent = 100;

  // display bigger circles on the view
  final int _circleSizeEnlargement = 50;

  // fit the ring animation enlargement to the perimeter circles
  late int _ratioRingAndCircles;

  @override
  void initState() {
    super.initState();
    _ratioRingAndCircles =
        (_streamMaxPercent / _perimeterCirclesNumber).floor();
  }

  void _closeStream() {
    _numbersBloc.closeStream();
    _textBloc.closeStream();
  }

  void _navigateBack() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => const MainRoute(),
      ),
      (route) => false,
    );
  }

  // manage text events
  void manageEvents(int num) {
    if (0 <= num && num <= 9) {
      _textBloc.eventSink.add(StartInhalingEvent());
    } else if (10 <= num && num <= 89) {
      _textBloc.eventSink.add(KeepGoingEvent());
    } else if (90 <= num && num <= 100) {
      _textBloc.eventSink.add(WellDoneEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          leading: BackButton(
              onPressed: () {
                _navigateBack();
              },
              color: Colors.black),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.all(20.0),
              child: StreamBuilder(
                stream: _textBloc.messageStream,
                initialData: "",
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  return TextView(snapshot.data!);
                },
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 100.0),
              child: StreamBuilder(
                stream: _numbersBloc.numbersStream,
                initialData: 0,
                builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                  manageEvents(snapshot.data!);
                  return Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      CirclesView(
                          circlesList: circlesList,
                          circleSizeEnlargement: _circleSizeEnlargement),
                      RingAnimation(
                          dataNumber: snapshot.data!,
                          ratioRingAndCircles: _ratioRingAndCircles,
                          circleSizeEnlargement: _circleSizeEnlargement),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    //close stream and blocks
    _closeStream();
    _numbersBloc.dispose();
    _textBloc.dispose();
    super.dispose();
  }
}
