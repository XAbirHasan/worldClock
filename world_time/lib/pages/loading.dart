import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:world_time/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';



class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  String time = "00:00";

  void setupTime() async {
    final WorldTime worldTime = WorldTime("Dhaka", "2021-08-16T10:54:49.329769+06:00", 'dhaka.png', 'Asia/Dhaka');
    await worldTime.get_time();

    Future.delayed(Duration(milliseconds: 2500),(){
      Navigator.pushReplacementNamed(
          context,
          '/home',
          arguments: {
            'location': worldTime.location,
            'time': worldTime.time,
            'flag': worldTime.flag,
            'time_period':worldTime.time_period,
          }
      );
    });

  }
  @override
  void initState() {
    super.initState();
    setupTime();
  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        )
    );
    return const Scaffold(
      backgroundColor: Colors.amber,
      body: Body(),
    );
  }
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: const SpinKitPouringHourglass(
              color: Colors.white,
              size: 50.0,
            ),
          ),
          SizedBox(height: 20,),
          Text("@abirHassan",
            style: TextStyle(
              color: Colors.black,
              fontSize: 10,
              letterSpacing: 2
            ),
          ),
        ],
      );
  }
}

