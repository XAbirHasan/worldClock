import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

Color bg_color = Colors.amber;
Color statusbar = Colors.grey[600]!;
Color textColor = Colors.black;
Color buttonColor = Colors.purple[500]!;
Map data = {};
String time_period = "";
Widget screen_bg = BackGround_custom();
DateTime the_time = DateTime.now();
String time = "";

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty? data : ModalRoute.of(context)!.settings.arguments as Map;
    time_period = data['time_period'].toString();

    the_time = DateTime.parse(data['time'].toString());
    time = DateFormat.jm().format(the_time);
    void _update() {
      setState(() {
        the_time = DateTime.parse(data['time'].toString());
        time = DateFormat.jm().format(the_time);
      });
    }
    // print(time_period);

    if(time_period == 'morning'){
      buttonColor = Colors.purple[500]!;
      String hexString = "fff2d7";
      textColor = Colors.black;
      bg_color = Color(int.parse("0xff${hexString}"));
      screen_bg = const BackGround_custom();
    }
    else if(time_period == 'afternoon'){
      buttonColor = Colors.purple[500]!;
      String hexString = "fff2d7";
      textColor = Colors.black;
      bg_color = Color(int.parse("0xff${hexString}"));
      screen_bg = const BackGround_noon();
    }
    else{
      bg_color = Colors.grey[900]!;
      statusbar = Colors.grey[800]!;
      screen_bg =  BG_dark();
      textColor = Colors.white;
      buttonColor = Colors.amber;
    }
    return Scaffold(
      //change status bar colors
      // backgroundColor: Colors.amber,
      body: Container(
        color: bg_color,
        child: Body(update: _update,),
      ),
    );
  }
}


class Body extends StatefulWidget {
  var update;
  Body({required this.update});
  @override
  _BodyState createState() => _BodyState(update: update);
}

class _BodyState extends State<Body> {
  var update;
  _BodyState({this.update});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
            statusBarColor: statusbar,
            statusBarIconBrightness: Brightness.light
        )
    );
    return Stack(
      children: [
        screen_bg,
        Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
          child: Column(
            children: [
              const SizedBox(height: 80,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton.icon(
                    style: TextButton.styleFrom(
                      primary: buttonColor,
                    ),
                    onPressed: () async {
                      dynamic result = await Navigator.pushNamed(context, '/location');
                      String location = result['location'].toString();
                      location = (location.contains('/')) ? location.substring(location.indexOf('/')+1) : location;
                      location = (location.contains('/')) ? location.substring(location.indexOf('/')+1) : location;
                      setState(() {
                        data = {
                          'location': location,
                          'time': result['time'],
                          'flag': result['flag'],
                          'time_period':result['time_period'],
                        };
                        update();
                      });
                    },
                    icon: const Icon(Icons.edit_location_rounded),
                    label: const Text("Edit Location")
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(data['location'].toString(),
                    style: TextStyle(
                      fontSize: 28,
                      color: textColor,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              TimeUpdate(),
            ],
          ),
        ),
      ),
      ]
    );
  }
}

class BackGround_custom extends StatefulWidget {
  const BackGround_custom({Key? key}) : super(key: key);

  @override
  _BackGround_customState createState() => _BackGround_customState();
}

class _BackGround_customState extends State<BackGround_custom> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Container(child: Lottie.asset('assets/anim/sunrise.json')),
         Container(
          alignment: Alignment.bottomCenter,
          child: Lottie.asset('assets/anim/sunrise.json')),
      ]
    );
  }
}

class BG_dark extends StatefulWidget {
  const BG_dark({Key? key}) : super(key: key);

  @override
  _BG_darkState createState() => _BG_darkState();
}

class _BG_darkState extends State<BG_dark> {
  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          // Container(child: Lottie.asset('assets/anim/sunrise.json')),
          Container(
              alignment: Alignment.bottomCenter,
              child: Lottie.asset('assets/anim/light.json')),
        ]
    );
  }
}

class BackGround_noon extends StatefulWidget {
  const BackGround_noon({Key? key}) : super(key: key);

  @override
  _BackGround_noonState createState() => _BackGround_noonState();
}

class _BackGround_noonState extends State<BackGround_noon> {
  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          // Container(child: Lottie.asset('assets/anim/sunrise.json')),
          Container(
              alignment: Alignment.bottomCenter,
              child: Lottie.asset('assets/anim/moving_terbine_morning.json')),
        ]
    );
  }
}

class TimeUpdate extends StatefulWidget {
  @override
  _TimeUpdateState createState() => _TimeUpdateState();
}

class _TimeUpdateState extends State<TimeUpdate> {
  @override
  void initState() {
    the_time = DateTime.parse(data['time'].toString());
    time = DateFormat.jm().format(the_time);
    Timer.periodic(Duration(seconds: 1), (timer) {
      var preTime = DateTime.now().add(Duration(seconds: -1)).minute;
      var curTime = DateTime.now().minute;
      if (preTime!=curTime){
        setState(() {
          the_time = the_time.add(Duration(minutes: 1));
          time = DateFormat.jm().format(the_time);
        });
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Text(time,
      style: TextStyle(
          fontSize: 66,
          color: textColor,
          letterSpacing: 0
      ),
    );
  }
}

class hi extends StatefulWidget {
  const hi({Key? key}) : super(key: key);

  @override
  _hiState createState() => _hiState();
}

class _hiState extends State<hi> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: a,
    );
  }
}





