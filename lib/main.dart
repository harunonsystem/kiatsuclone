import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kiatsuclone/model/weather_model.dart';
import 'package:kiatsuclone/process/api_getter.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ApiGetter getData = ApiGetter();
  String testData = "testData";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Status(),
    );
  }
}

class Status extends StatelessWidget {
  final ApiGetter getData = ApiGetter();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('kiatsu'),
        centerTitle: true,
      ),
      body: FutureBuilder<WeatherClass>(
          future: getData.getWeather(),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? Container(
                    child: ListView(
                      children: <Widget>[
                        Center(
                          child: Container(
                            padding: EdgeInsets.all(10.0),
                            margin: EdgeInsets.all(10.0),
                            child: Text('pressure'),
                          ),
                        ),
                        SizedBox(
                          height: 24.0,
                        ),
                        Center(
                          child: Text(
                              snapshot.data.main.pressure.toString() + 'hPa'),
                        )
                      ],
                    ),
                  )
                : Center(child: CircularProgressIndicator());
          }),
    );
  }
}
