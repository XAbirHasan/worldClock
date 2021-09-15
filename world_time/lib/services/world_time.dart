import 'dart:convert';
import 'package:http/http.dart';
import 'package:intl/intl.dart';


class WorldTime{
  String location; // location name
  String time; // location time
  String flag; // flag path;
  String url;
  String time_period = "";

  WorldTime(this.location, this.time, this.flag, this.url); // the url;

  Future<void> get_time() async{
    try {
      // Response all_location = await get(Uri.parse('http://worldtimeapi.org/api/timezone'));
      // print(all_location.body);

      //make request and get time data
      Response response = await get(
          Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body) as Map;

      // get date and time
      String date_time = data['datetime'].toString();
      String offset_hours = data['utc_offset'].substring(1, 3).toString();
      String offset_minutes = data['utc_offset'].substring(4,).toString();

      // make a datetime object
      // print(date_time);
      DateTime now = DateTime.parse(date_time);
      now = now.add(Duration(
          minutes: int.parse(offset_minutes), hours: int.parse(offset_hours)));
      // print(offset_hours);
      // print(offset_minutes);

      // print(now.hour);

      if (now.hour >=5 && now.hour<12){
        time_period = 'morning';
      }
      else if (now.hour >=12 && now.hour<18) {
        time_period = 'afternoon';
      }
      else{
        time_period = 'night';
      }
      time = now.toString();
    }
    catch (e)
    {

    }

  }

}