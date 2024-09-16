import 'package:covid19/components/Lists/countriesLists.dart';
import 'package:covid19/components/services/model.dart';
import 'package:covid19/components/services/statesServices.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WorldState extends StatefulWidget {
  const WorldState({super.key});

  @override
  State<WorldState> createState() => _WorldStateState();
}

class _WorldStateState extends State<WorldState> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  )..repeat();

  @override
  final colorList = <Color>[
    const Color.fromARGB(240, 26, 108, 239),
    const Color(0xdd1aa260),
    const Color(0xffde5246),
  ];
  @override
  Widget build(BuildContext context) {
    Statesservices statesservices = Statesservices();
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Corona Cases',
            style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Column(children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          FutureBuilder(
              future: statesservices.fetchWorldStateRecords(),
              builder: (context, AsyncSnapshot<Models> snapshot) {
                if (!snapshot.hasData) {
                  return Expanded(
                      child: SpinKitFadingCircle(
                    color: Colors.red,
                    size: 55.0,
                    controller: _controller,
                  ));
                } else {
                  return Column(
                    children: [
                      PieChart(
                        dataMap: {
                          // "total": 15,
                          // "Recovered": 10,
                          // "Death": 5,
                          "Total":
                              double.parse(snapshot.data!.cases!.toString()),
                          "Recovered": double.parse(
                              snapshot.data!.recovered!.toString()),
                          "Deaths":
                              double.parse(snapshot.data!.deaths!.toString()),
                        },
                        chartRadius: 150,
                        legendOptions: const LegendOptions(
                            legendPosition: LegendPosition.left),
                        animationDuration: const Duration(milliseconds: 1000),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      ReusableRow(
                          title: 'Total',
                          value: snapshot.data!.cases!.toString()),
                      ReusableRow(
                          title: 'Recovered',
                          value: snapshot.data!.recovered!.toString()),
                      ReusableRow(
                          title: 'Deaths',
                          value: snapshot.data!.deaths!.toString()),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CountriesList())),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.blue[500],
                            ),
                            width: double.infinity,
                            child: const Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Choose Countries',
                                  style: TextStyle(fontSize: 20.0),
                                )),
                          ),
                        ),
                      )
                    ],
                  );
                }
              }),
        ]));
  }
}

class ReusableRow extends StatelessWidget {
  String title, value;
  ReusableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 20.0),
              ),
              Text(value, style: const TextStyle(fontSize: 20.0))
            ],
          )
        ],
      ),
    );
  }
}
