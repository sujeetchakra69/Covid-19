import 'package:covid19/components/World_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DetailedView extends StatefulWidget {
  String name, images;
  int totalcases, totaldeaths, totalrecovered, totalpopulation;

  DetailedView({
    super.key,
    required this.images,
    required this.name,
    required this.totalcases,
    required this.totaldeaths,
    required this.totalrecovered,
    required this.totalpopulation,
  });

  @override
  State<DetailedView> createState() => _DetailedViewState();
}

class _DetailedViewState extends State<DetailedView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[200],
          title: Text(
            widget.name,
            style: TextStyle(fontSize: 20.0, color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: Stack(children: [
          Card(
            color: Colors.grey[300],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                    widget.images,
                    fit: BoxFit.cover,
                    height: 150,
                  
                   
                  ),
                ReusableRow(
                    title: 'Cases', value: widget.totalcases.toString()),
                ReusableRow(
                    title: 'Deaths', value: widget.totaldeaths.toString()),
                ReusableRow(
                    title: 'Recovered',
                    value: widget.totalrecovered.toString()),
                ReusableRow(
                    title: 'Population',
                    value: widget.totalpopulation.toString()),
              ],
            ),
          ),
        ]));
  }
}
