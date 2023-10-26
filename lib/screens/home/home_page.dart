// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_application_1/models/item.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String apiUrl = 'https://cpsu-test-api.herokuapp.com/api/1_2566/weather/current?city=bangkok';
  WeatherData? weatherData;

  // Function เพื่อดึงข้อมูลจาก API โดยใช้ Dio
  Future<void> fetchWeatherData() async {
    try {
      final dio = Dio();
      final response = await dio.get(apiUrl);

      if (response.statusCode == 200) {
        final data = response.data;
        setState(() {
          weatherData = WeatherData.fromJson(data);
        });
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 202, 200, 200),
      body: Column(
        children: [
          Container(
            height: 60, // ความสูงของแถบบนสุด
            color: Colors.grey, // สีพื้นหลังของแถบบนสุด
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 100,
                  alignment: Alignment.center,
                  child: Text('Bangkok', style: TextStyle(color: Colors.black)),
                ),
                VerticalDivider(
                  color: Colors.black, // สีของเส้นขีด
                ),
                Container(
                  width: 150,
                  alignment: Alignment.center,
                  child: Text('Nakorn Pathom', style: TextStyle(color: Colors.black)),
                ),
                VerticalDivider(
                  color: Colors.black, // สีของเส้นขีด
                ),
                Container(
                  width: 100,
                  alignment: Alignment.center,
                  child: Text('Paris', style: TextStyle(color: Colors.black)),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Text(weatherData!.city, style: TextStyle(fontSize: 50)),
          SizedBox(height: 20),
          Text(weatherData!.country, style: TextStyle(fontSize: 20)),
          SizedBox(height: 20),
          Text(weatherData!.lastUpdated, style: TextStyle(fontSize: 15)),
          Image.network(
            'https://cdn.weatherapi.com/weather/128x128/day/116.png', // แทนที่ URL ด้วย URL รูปภาพที่คุณต้องการแสดง
            width: 200, // กำหนดความกว้างของรูปภาพ
            height: 200, // กำหนดความสูงของรูปภาพ
          ),
          
          Text(weatherData!.condition.text, style: TextStyle(fontSize: 15)),
          SizedBox(height: 20),
          Text(weatherData!.tempC.toString(), style: TextStyle(fontSize: 80)),
          Text('Feels like' + ' '+weatherData!.feelsLikeC.toString(), style: TextStyle(fontSize: 20)),
          SizedBox(height: 10),
          Text('°C | °F ' , style: TextStyle(fontSize: 35)),
          SizedBox(height: 100),
          Row(
            children: [
              SizedBox(width: 70), 
              Container(child: Icon(Icons.water_drop, size: 20)),
               SizedBox(width: 150), 
              Container(child: Icon(Icons.wind_power, size: 20)),
              SizedBox(width: 150), 
              Container(child: Icon(Icons.sunny, size: 20)),
            ],
            
          ),
          Row(
            children: [
              SizedBox(width: 40), 
              Container(child: Text('HUMIDITY', style: TextStyle(fontSize: 15)),),
               SizedBox(width: 120), 
              Container(child: Text('WIND', style: TextStyle(fontSize: 15)),),
              SizedBox(width: 140), 
              Container(child: Text('UV', style: TextStyle(fontSize: 15)),),
            ],
            
          ),
          Row(
            children: [
              SizedBox(width: 70), 
              Container(child: Text(weatherData!.humidity.toString()+'%', style: TextStyle(fontSize: 15)),),
               SizedBox(width: 130), 
              Container(child: Text(weatherData!.windKph.toString()+' km/h', style: TextStyle(fontSize: 15)),),
              SizedBox(width: 140), 
              Container(child: Text(weatherData!.uv.toString(), style: TextStyle(fontSize: 15)),),
            ],
            
          ),
          
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}
