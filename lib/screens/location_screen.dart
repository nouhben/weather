import 'package:flutter/material.dart';
import 'package:weather/screens/city_screen.dart';
import 'package:weather/services/weather.dart';
import 'package:weather/utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  final locationWeather;
  LocationScreen({this.locationWeather});
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  var _temperature; //could be a double or int
  String _weatherIcon;
  String _weatherMessage;
  String _cityName;
  WeatherModel _weather = WeatherModel();
  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        this._temperature = 0;
        this._cityName = '';
        this._weatherMessage = 'Please ennable internet and location';
        this._weatherIcon = 'ERROR';
        return;
      }
      print(weatherData);
      this._temperature = weatherData['main']['temp'];
      this._cityName = weatherData['name'];
      var condition = weatherData['weather'][0]['id'];
      this._weatherIcon = _weather.getWeatherIcon(condition);
      this._weatherMessage = _weather.getMessage(this._temperature.toInt());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      var weatherData = await _weather.getLocationWeather();
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var typedName = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CityScreen();
                          },
                        ),
                      );
                      //after it is popped out the we can get the data form the other widget
                      if (typedName != null || typedName.toString() == '') {
                        var weatherData = await _weather.getCityWeather(typedName);
                        updateUI(weatherData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 32.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      this._temperature.toString() ?? '' + 'º',
                      style: kTempTextStyle,
                    ),
                    Text(
                      this._weatherIcon ?? '',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 32.0),
                child: Text(
                  '${this._weatherMessage} in ${this._cityName}' ?? '',
                  textAlign: TextAlign.left,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
