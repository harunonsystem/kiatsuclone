import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kiatsuclone/model/weather_model.dart';
import 'package:kiatsuclone/process/api_getter.dart';
import 'package:share/share.dart';

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
      home: Stream(),
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

class Stream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ApiGetter getData = ApiGetter();
    return Scaffold(
      appBar: AppBar(
        title: Text('kiatsu'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              Share.share('hPa #kiatsu');
            },
          )
        ],
      ),
      body: StreamBuilder(
        stream: getData.getWeather().asStream(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
          }
          return Center(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 24.0,
                ),
                const Text('pressure'),
                new Text(
                  snapshot.data.main.pressure.toString() + ' hPa',
                  style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple),
                ),
                new Text(
                  snapshot.data.name.toString(),
                  style: TextStyle(fontSize: 24.0, color: Colors.lightBlue),
                ),
                IconButton(
                  color: Colors.blue,
                  icon: Icon(Icons.share),
                  onPressed: () {
                    Share.share(snapshot.data.main.pressure.toString() +
                        ' hPa #kiatsu🥺');
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
