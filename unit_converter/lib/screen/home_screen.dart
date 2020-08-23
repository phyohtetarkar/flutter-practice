import 'package:flutter/material.dart';
import 'package:unit_converter/screen/converter_screen.dart';

enum Conversion { VOLUME, LENGTH, WEIGHT, DISTANCE }

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text(
        "Unit Converter",
        style: TextStyle(
          color: Colors.white.withOpacity(0.9),
          fontSize: 24,
        ),
      ),
    );

    return Scaffold(
      appBar: appBar,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AspectRatio(
          aspectRatio: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: Row(
                  children: <Widget>[
                    _MenuButton(
                      icon: Icons.widgets,
                      color: Colors.amber,
                      text: "Volume",
                      conversion: Conversion.VOLUME,
                    ),
                    SizedBox(width: 8),
                    _MenuButton(
                      icon: Icons.straighten,
                      color: Colors.green,
                      text: "Length",
                      conversion: Conversion.LENGTH,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Expanded(
                child: Row(
                  children: <Widget>[
                    _MenuButton(
                      icon: Icons.fitness_center,
                      color: Colors.red,
                      text: "Weight",
                      conversion: Conversion.WEIGHT,
                    ),
                    SizedBox(width: 8),
                    _MenuButton(
                      icon: Icons.directions_walk,
                      color: Colors.blue,
                      text: "Distance",
                      conversion: Conversion.DISTANCE,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuButton extends StatelessWidget {
  final IconData icon;
  final MaterialColor color;
  final String text;
  final Conversion conversion;

  const _MenuButton({
    Key key,
    this.icon,
    this.color,
    this.text,
    this.conversion,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FlatButton(
        color: color.shade100,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        onPressed: () {
          var route = MaterialPageRoute(
            builder: (context) {
              return ConverterScreen(
                title: text,
                conversion: conversion,
              );
            });

          Navigator.push(context, route);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              color: color,
              size: 64,
            ),
            SizedBox(height: 8),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                color: color.shade900.withOpacity(0.75),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
