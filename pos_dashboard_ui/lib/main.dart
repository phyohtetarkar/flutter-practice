import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: DashboardPage(),
    );
  }
}

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      centerTitle: true,
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      title: Text(
        "Dashboard",
        style: TextStyle(
          color: Colors.grey.shade800,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: appBar,
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _TotalSaleWidget(),
            SizedBox(height: 8),
            _QuickActionBar(),
            _GroupHeaderBar(
              header: "Categories",
              action: "Add New",
            ),
            SizedBox(
              height: 105,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _CategoryWidget(
                    color: Colors.blue,
                    name: "Food",
                  ),
                  SizedBox(width: 8),
                  _CategoryWidget(
                    color: Colors.orange,
                    name: "Drink",
                  ),
                  SizedBox(width: 8),
                  _CategoryWidget(
                    color: Colors.green,
                    name: "Stationary",
                  ),
                  SizedBox(width: 8),
                  _CategoryWidget(
                    color: Colors.pink,
                    name: "Cosmetic",
                  ),
                ],
              ),
            ),
            _GroupHeaderBar(
              header: "Sales",
              action: "View All",
            ),
            Expanded(
              child: ListView(
                children: [
                  _SaleItem(
                    color: Colors.red,
                    title: "#10001",
                    time: "Aug 19, 2020 10:30 AM",
                    price: "3000 Ks",
                  ),
                  _SaleItem(
                    color: Colors.green,
                    title: "#10002",
                    time: "Aug 19, 2020 10:30 AM",
                    price: "3000 Ks",
                  ),
                  _SaleItem(
                    color: Colors.blue,
                    title: "#10003",
                    time: "Aug 19, 2020 10:30 AM",
                    price: "3000 Ks",
                  ),
                  _SaleItem(
                    color: Colors.cyan,
                    title: "#10004",
                    time: "Aug 19, 2020 10:30 AM",
                    price: "3000 Ks",
                  ),
                  _SaleItem(
                    color: Colors.purple,
                    title: "#10005",
                    time: "Aug 19, 2020 10:30 AM",
                    price: "3000 Ks",
                  ),
                  _SaleItem(
                    color: Colors.grey,
                    title: "#10006",
                    time: "Aug 19, 2020 10:30 AM",
                    price: "3000 Ks",
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _TotalSaleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "Total Sale",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Text(
            "1500000 Ks",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: Colors.green,
            ),
          )
        ],
      ),
    );
  }
}

class _QuickActionBar extends StatelessWidget {
  Widget _createMenu(IconData icon, String label) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            Icon(
              icon,
              size: 24,
            ),
            SizedBox(height: 8),
            Text(label),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          _createMenu(Icons.laptop_mac, "POS"),
          _createMenu(Icons.widgets, "Products"),
          _createMenu(Icons.pie_chart, "Report"),
        ],
      ),
    );
  }
}

class _GroupHeaderBar extends StatelessWidget {
  final String header;
  final String action;

  const _GroupHeaderBar({
    Key key,
    this.header,
    this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              header,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          FlatButton(
            onPressed: () {},
            padding: EdgeInsets.symmetric(horizontal: 0),
            child: Text(
              action,
              style: TextStyle(
                color: Colors.blue,
                fontSize: 16,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _CategoryWidget extends StatelessWidget {
  final MaterialColor color;
  final String name;

  const _CategoryWidget({
    Key key,
    this.color,
    this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: 100,
              height: 60,
              decoration: ShapeDecoration(
                color: color,
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                shadows: [
                  BoxShadow(
                    color: color.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 8,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
            ),
          )
        ],
      ),
    );
  }
}

class _SaleItem extends StatelessWidget {
  final MaterialColor color;
  final String title;
  final String price;
  final String time;

  const _SaleItem({
    Key key,
    this.color,
    this.title,
    this.price,
    this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 8,
              ),
            ],
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          time,
          style: TextStyle(color: Colors.grey.shade700),
        ),
        trailing: Text(
          price,
          style: TextStyle(),
        ),
      ),
    );
  }
}
