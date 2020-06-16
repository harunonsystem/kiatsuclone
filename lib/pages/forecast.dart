import 'package:flutter/material.dart';
import 'package:weather/weather_library.dart';

enum AppState { NOT_DOWNLOADED, DOWNLOADING, FINISHED_DOWNLOADING }

class Forecast extends StatefulWidget {
  @override
  _ForecastState createState() => _ForecastState();
}

class _ForecastState extends State<Forecast> {
  String key = '856822fd8e22db5e1ba48c0e7d69844a';
  WeatherStation ws;
  List<Weather> _data = [];
  AppState _state = AppState.NOT_DOWNLOADED;
  double lat, lon;

  @override
  void initState() {
    super.initState();
    ws = new WeatherStation(key);
  }

  void queryForecast() async {
    /// Removes keyboard
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {
      _state = AppState.DOWNLOADING;
    });

    List<Weather> forecasts = await ws.fiveDayForecast(lat, lon);
    setState(() {
      _data = forecasts;
      _state = AppState.FINISHED_DOWNLOADING;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('forecast'),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: queryForecast,
        ),
        body: ListView.separated(
          itemCount: _data.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(_data[index].pressure.toString()),
            );
          },
          separatorBuilder: (context, index) {
            return Divider();
          },
        ));
    /*
        body: FutureBuilder(
          future: Future(queryfocast),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError && snapshot != null) {
              return Center(
                child: Text(snapshot.error),
              );
            } else if (snapshot.hasData) {
              return Center(
                child: Text(snapshot.data.main.pressure.toString()),
              );
            } else {
              return Center(
                  child: CircularProgressIndicator(
                backgroundColor: Colors.pink,
              ));
            }
          },
        ));

         */
  }
}
