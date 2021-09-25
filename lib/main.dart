import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'widgets/main_widget.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

Future<WeatherInfo> fetchWeather() async {
  final apiKey = '698adc15638429b71131978c9b20a089';
  final cityName = 'Lagos';
  // Temperature in Kelvin is used by default in the API,
  // For temperature in Celsius use units=metric
  final requestUrl =
      'https://api.openweathermap.org/data/2.5/weather?q=$cityName&units=metric&appid=$apiKey';

  final response = await http.get(Uri.parse(requestUrl));

  if (response.statusCode == 200) {
    return WeatherInfo.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('The URL returned an invalid response');
  }
}

class WeatherInfo {
  final name;
  final tempMin;
  final feelsLike;
  final humidity;
  final windSpeed;

  WeatherInfo(
      {required this.name,
      required this.tempMin,
      required this.feelsLike,
      required this.humidity,
      required this.windSpeed});

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    return WeatherInfo(
      name: json['name'],
      tempMin: json['main']['temp_min'],
      feelsLike: json['main']['feels_like'],
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'],
    );
  }
}

void main() {
  // Use Code below to disable orientation in your app
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(
    MaterialApp(
      title: 'Weather Forecasts',
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<WeatherInfo> futureWeather;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureWeather = fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/ikeja_image.jpeg'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
              Colors.purple.withOpacity(0.6), BlendMode.darken),
        ),
      ),
      child: Scaffold(
        backgroundColor: Color(0xff5834EF).withOpacity(0.3),
        body: FutureBuilder<WeatherInfo>(
          future: futureWeather,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return MainWidget(
                name: snapshot.data!.name,
                tempMin: snapshot.data!.tempMin,
                feelsLike: snapshot.data!.feelsLike,
                humidity: snapshot.data!.humidity,
                windSpeed: snapshot.data!.windSpeed,
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('${snapshot.error}'),
              );
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
