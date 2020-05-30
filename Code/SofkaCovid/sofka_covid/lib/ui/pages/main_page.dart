import 'dart:convert';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sofkacovid/models/country.dart';
import 'package:sofkacovid/models/summary_response.dart';
import 'package:sofkacovid/ui/widgets/data_item.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Future<SummaryResponse> summaryFuture;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    summaryFuture = getSummaryData();
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: SmartRefresher(
        controller: _refreshController,
        onRefresh: _onRefresh,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  top: 12.0,
                  left: 8.0,
                  right: 8.0,
                ),
                child: Card(
                  elevation: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 8.0,
                          left: 8.0,
                          right: 8.0,
                        ),
                        child: Image.asset(
                          'assets/images/logo_sofka.png',
                          fit: BoxFit.fill,
                          width: double.infinity,
                          height: 100,
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: '#',
                          style: TextStyle(
                            color: Color(0xFFe06a1b),
                            fontSize: 40.0,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'MeQuedoEnCasa',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 30.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 8.0,
                  left: 8.0,
                  right: 8.0,
                ),
                child: Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 8.0,
                          left: 8.0,
                        ),
                        child: Text(
                          'Covid-19 en Colombia',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: CircleAvatar(
                          radius: 50.0,
                          child: ClipOval(
                            child: Flags.getFlag(
                                country: 'CO',
                                height: 100,
                                width: 100,
                                fit: BoxFit.fill),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 16.0),
                        child: FutureBuilder<SummaryResponse>(
                          future: summaryFuture,
                          initialData: SummaryResponse(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Expanded(
                                        child: DataItem(
                                          title: 'Confirmados totales',
                                          number:
                                              getColombiaData(snapshot?.data)
                                                      ?.totalConfirmed
                                                      ?.toString() ??
                                                  '',
                                          colorNumber: Colors.red,
                                        ),
                                      ),
                                      Expanded(
                                        child: DataItem(
                                          title: 'Bajas totales',
                                          number:
                                              getColombiaData(snapshot?.data)
                                                      ?.totalDeaths
                                                      ?.toString() ??
                                                  '',
                                        ),
                                      ),
                                      Expanded(
                                        child: DataItem(
                                          title: 'Recuperados totales',
                                          number:
                                              getColombiaData(snapshot?.data)
                                                      ?.totalRecovered
                                                      ?.toString() ??
                                                  '',
                                          colorNumber: Colors.green,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 14.0),
                                    child: Text(
                                        'Actualizado el: ${getColombiaData(snapshot.data)?.date ?? ''}'),
                                  )
                                ],
                              );
                            } else if (snapshot.hasError) {
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    summaryFuture = getSummaryData();
                                  });
                                },
                                child: Column(
                                  children: <Widget>[
                                    Icon(Icons.refresh),
                                    Text('Reintentar')
                                  ],
                                ),
                              );
                            }
                            return CircularProgressIndicator();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 8.0,
                  left: 8.0,
                  right: 8.0,
                ),
                child: Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 8.0,
                          left: 8.0,
                          right: 8.0,
                        ),
                        child: Text(
                          '¿Qué es el Covid-19?',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8.0),
                              child: Text(
                                'Los coronavirus (CoV) son virus que surgen periódicamente en diferentes áreas del mundo y que causan Infección Respiratoria Aguda (IRA), es decir gripa, que pueden llegar a ser leve, moderada o grave.',
                                style: TextStyle(fontSize: 14.0),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Image.asset(
                                'assets/images/virus.png',
                                width: 100.0,
                                height: 100.0,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: OutlineButton(
                          shape: StadiumBorder(),
                          borderSide: BorderSide(
                            color: Colors.orange[800],
                          ),
                          textColor: Colors.orange[800],
                          onPressed: () {
                            _launchWebSite(
                                'https://coronaviruscolombia.gov.co/Covid19/index.html');
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text('Más informacion'),
                              Icon(Icons.open_in_new),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 8.0,
                  left: 8.0,
                  right: 8.0,
                ),
                child: Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 8.0,
                          left: 8.0,
                          right: 8.0,
                        ),
                        child: Text(
                          'Síntomas',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Container(
                          height: 200.0,
                          child: ListView(
                            // This next line does the trick.
                            scrollDirection: Axis.horizontal,
                            children: <Widget>[
                              _SymptomsItem(
                                image: 'assets/images/cough.png',
                                symptom: 'Tos seca',
                              ),
                              _SymptomsItem(
                                image: 'assets/images/nose.png',
                                symptom: 'Secreción nasal',
                              ),
                              _SymptomsItem(
                                image: 'assets/images/sore_throat.png',
                                symptom: 'Dolor de garganta',
                              ),
                              _SymptomsItem(
                                image: 'assets/images/temperature.png',
                                symptom: 'Fiebre',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _launchWebSite(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _onRefresh() async {
    summaryFuture = getSummaryData();
    await summaryFuture.then((value) => _refreshController.refreshCompleted());
  }

  Future<SummaryResponse> getSummaryData() async {
    final response = await http.get('https://api.covid19api.com/summary');
    if (response.statusCode == 200) {
      return SummaryResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }

  Country getColombiaData(SummaryResponse summary) {
    return summary?.countries
            ?.firstWhere((country) => country.slug == 'colombia') ??
        Country();
  }
}

class _SymptomsItem extends StatelessWidget {
  final String symptom;
  final String image;

  _SymptomsItem({
    this.symptom,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 8.0,
      ),
      child: Card(
        elevation: 2.0,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Image.asset(
                  image,
                  width: 100.0,
                  height: 100.0,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                symptom,
                maxLines: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
