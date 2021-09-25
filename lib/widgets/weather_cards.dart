import 'package:flutter/material.dart';

class WeatherCards extends StatelessWidget {
  final String apiData;
  final IconData icon;
  final String title;

  WeatherCards(
      {required this.apiData, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            apiData,
            style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
          SizedBox(
            height: 10.0,
          ),
          Icon(
            icon,
            color: Colors.blue,
            size: 70.0,
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            title,
            style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          )
        ],
      ),
    );
  }
}
