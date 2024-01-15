import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location;
  String time = '';
  String flag;
  String url;
  bool isDaytime = true;

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    try {
      Response response =
          await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);

      // get properties from data
      String datetime = data["datetime"];
      String offset = data["utc_offset"].substring(1, 3);
      String symbol = data["utc_offset"].substring(0, 1);

      // create DateTime object
      DateTime now = DateTime.parse(datetime);
      if (symbol == '+') {
        now = now.add(Duration(hours: int.parse(offset)));
      } else if (symbol == '-') {
        now = now.subtract(Duration(hours: int.parse(offset)));
      }
      // set the time property
      isDaytime = now.hour >= 6 && now.hour <= 18 ? true : false;
      time = DateFormat.jm().format(now);
    } catch (err) {
      print('caught error: $err');
      time = 'could not get time data';
    }
  }
}
