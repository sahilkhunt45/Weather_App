import 'package:flutter/material.dart';
import 'package:singletonclass/modals/weather.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_icons/weather_icons.dart';
import '../helpers/weather_api_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController searchController = TextEditingController();
  late Future<Weather?> getWeatherData;
  String Clouds = "https://assets1.lottiefiles.com/packages/lf20_wfx6naii.json";
  String Mist = "https://assets2.lottiefiles.com/temp/lf20_kOfPKE.json";
  String Haze = "https://assets7.lottiefiles.com/packages/lf20_mwnl7iyc.json";
  String Rain = "https://assets2.lottiefiles.com/packages/lf20_GOiHQYLXTH.json";
  String Snow = "https://assets2.lottiefiles.com/packages/lf20_rsZzNSltJ9.json";
  String Sunny = "https://assets6.lottiefiles.com/temp/lf20_Stdaec.json";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWeatherData = WeatherAPIHelper.apiHelper.fechWeatherData(city: 'Surat');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xff3e68b4),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xff3e68b4),
        automaticallyImplyLeading: true,
        leading: BoxedIcon(WeatherIcons.day_sunny),
        title: const Text("Indian Wheather"),
        actions: [
          BoxedIcon(
            TimeIcon.fromDate(
              DateTime.now(),
            ),
            size: 40,
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT9fk6J_sp__CdgcvBMf5KHl_sQ0A-kzwea4w&usqp=CAU"),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: [
            FutureBuilder(
              future: getWeatherData,
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text("Error : ${snapshot.error}"),
                  );
                } else if (snapshot.hasData) {
                  Weather? data = snapshot.data;
                  int cal = data!.temp.toInt();
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          enabled: true,
                          controller: searchController,
                          decoration: InputDecoration(
                            hintText: "Search your place",
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            enabled: true,
                            focusColor: Colors.grey,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                String searchedCity = searchController.text;

                                setState(() {
                                  getWeatherData = WeatherAPIHelper.apiHelper
                                      .fechWeatherData(city: searchedCity);
                                });
                              },
                              icon: Icon(Icons.arrow_forward),
                            ),
                            prefixIcon: Icon(Icons.search),
                          ),
                        ),
                      ),
                      SizedBox(height: 50),
                      Container(
                        margin: EdgeInsets.only(right: 10, left: 10),
                        padding: EdgeInsets.only(right: 10, left: 10),
                        height: MediaQuery.of(context).size.height / 2.1,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "${cal - 273}°C",
                                  style: TextStyle(
                                    fontSize: 50,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Lottie.network(
                                  (data.name == "Clouds")
                                      ? Clouds
                                      : (data.name == "Rain")
                                          ? Rain
                                          : (data.name == "Snow")
                                              ? Snow
                                              : (data.name == "Mist")
                                                  ? Mist
                                                  : (data.name == "Smoke")
                                                      ? Mist
                                                      : (data.name == "Haze")
                                                          ? Haze
                                                          : (data.name ==
                                                                  "Sunny")
                                                              ? Sunny
                                                              : Clouds,
                                  height: 110,
                                  fit: BoxFit.fill,
                                  width: 140,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "${data.name}",
                                  style: TextStyle(
                                    fontSize: 50,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "${Global.city}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                Icon(Icons.location_on),
                              ],
                            ),
                            SizedBox(height: 10),
                            Divider(
                              thickness: 2,
                              color: Colors.black,
                              indent: 20,
                              endIndent: 20,
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      "Humidity",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "${data.humidity}",
                                      style: TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Lottie.network(
                                      "https://assets3.lottiefiles.com/packages/lf20_nfxa6agk.json",
                                      height: 100,
                                      width: 100,
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "Wind Speed",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "${data.speed}",
                                      style: TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Lottie.network(
                                      "https://assets6.lottiefiles.com/packages/lf20_vcg89p.json",
                                      height: 100,
                                      width: 100,
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "Wind Degree",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "${data.degree}",
                                      style: TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Lottie.network(
                                      "https://assets4.lottiefiles.com/packages/lf20_khrclx93.json",
                                      height: 100,
                                      width: 100,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  );
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Lottie.network(
                        "https://assets6.lottiefiles.com/packages/lf20_gbfwtkzw.json",
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
