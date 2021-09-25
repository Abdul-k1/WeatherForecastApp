import 'package:flutter/material.dart';
import 'weather_cards.dart';
import 'package:intl/intl.dart';

//making use of the intl package to get the current date

final DateTime now = DateTime.now();
final DateFormat formatter = DateFormat.yMMMEd();
final String formatted = formatter.format(now);

class MainWidget extends StatelessWidget {
  final name;
  final tempMin;
  final feelsLike;
  final humidity;
  final windSpeed;

  MainWidget(
      {required this.name,
      required this.tempMin,
      required this.feelsLike,
      required this.humidity,
      required this.windSpeed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 1.5,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Ikeja,${name.toString()}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 130.0),
                child: Text(
                  formatted,
                  style: TextStyle(fontSize: 25.0, color: Colors.white70),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  right: 150.0,
                  bottom: 10.0,
                ),
                child: Icon(
                  Icons.wb_sunny,
                  color: Color(0xffE0912C),
                  size: 150.0,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  right: 120.0,
                ),
                child: Text(
                  '${tempMin.toInt().toString()}°',
                  style: TextStyle(fontSize: 60.0, color: Color(0xffF0E4E4)),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xff302089),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(100.0),
                topLeft: Radius.circular(100.0),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  WeatherCards(
                    apiData: '${feelsLike.toInt().toString()}°',
                    icon: Icons.thermostat_outlined,
                    title: 'Temp',
                  ),
                  WeatherCards(
                    apiData: '${humidity.toString()}%',
                    icon: Icons.wb_cloudy_outlined,
                    title: 'Humid',
                  ),
                  WeatherCards(
                    apiData: '${windSpeed.toInt().toString()}mph',
                    icon: Icons.waves_outlined,
                    title: 'Wind',
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
