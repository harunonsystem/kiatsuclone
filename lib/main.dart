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
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {},
          )
        ],
      ),
      body: StreamBuilder(
        stream: getData.getWeather().asStream(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
            return Center(
              child: const Text('no data.'),
            );
          }
          return Container(
            //color: Colors.purple,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(30.0, 0, 10, 0),
                  //color: Colors.lightBlue,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 24.0,
                      ),
                      const Text(
                        'pressure',
                        style:
                            TextStyle(color: Colors.lightBlue, fontSize: 24.0),
                      ),
                      SizedBox(height: 10.0),
                      new Text(
                        snapshot.data.main.pressure.toString() + ' hPa',
                        style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Container(
                  //color: Colors.amber,
                  //margin: EdgeInsets.all(10.0),
                  //padding: EdgeInsets.all(10.0),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 24.0,
                        ),
                        new Text(
                          snapshot.data.name.toString() +
                              ' / ' +
                              snapshot.data.sys.country.toString(),
                          style: TextStyle(
                              fontSize: 24.0, color: Colors.lightBlue),
                        ),
                        RaisedButton.icon(
                          label: const Text(
                            'Share',
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.lightGreen,
                          elevation: 10.0,
                          icon: Icon(
                            Icons.share,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Share.share(snapshot.data.main.pressure.toString() +
                                ' hPa #kiatsu');
                          },
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
