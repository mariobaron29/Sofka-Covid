import 'package:sofkacovid/models/country.dart';
import 'package:sofkacovid/ui/widgets/data_item.dart';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';

class CountryDetail extends StatefulWidget {
  final Country country;

  const CountryDetail({Key key, this.country}) : super(key: key);

  @override
  _CountryDetailState createState() => _CountryDetailState();
}

class _CountryDetailState extends State<CountryDetail> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange[800],
          title: Text(widget.country.country),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
                left: 8.0,
              ),
              child: Text(
                'Covid-19 en ${widget.country.country}',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: CircleAvatar(
                radius: 50.0,
                child: ClipOval(
                  child: Flags.getFlag(
                      country: widget.country.countryCode,
                      height: 100,
                      width: 100,
                      fit: BoxFit.fill),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: DataItem(
                          title: 'Confirmados totales',
                          number: widget.country.totalConfirmed.toString(),
                          colorNumber: Colors.red,
                        ),
                      ),
                      Expanded(
                        child: DataItem(
                          title: 'Bajas totales',
                          number: widget.country.totalDeaths.toString(),
                        ),
                      ),
                      Expanded(
                        child: DataItem(
                          title: 'Recuperados totales',
                          number: widget.country.totalRecovered.toString(),
                          colorNumber: Colors.green,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 14.0),
                    child: Text('Actualizado el: ${widget.country.date}'),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
