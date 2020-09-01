import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sqflite_flutter/developer_edit_page.dart';
import 'package:sqflite_flutter/model/developer.dart';
import 'package:sqflite_flutter/repo/developer_repo.dart';

const languages = [
  "Java",
  "Kotlin",
  "Swift",
  "Python",
  "Dart",
  "C++",
  "Matlab",
  "Octave",
  "C",
  "Go",
  "C#",
  "Scala",
  "Ruby",
  "Javascript",
];

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
        primarySwatch: Colors.green,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: DevelopersPage(repo: DeveloperRepo()),
    );
  }
}

class DevelopersPage extends StatefulWidget {
  final DeveloperRepo repo;

  const DevelopersPage({
    Key key,
    this.repo,
  }) : super(key: key);

  @override
  _DevelopersPageState createState() => _DevelopersPageState();
}

class _DevelopersPageState extends State<DevelopersPage> {
  List<Developer> _list;

  TextEditingController _searchController;

  String _heading;

  void insertRandom() async {
    final random = Random();
    var dev = Developer(
      name: "DEV ${_list.length + 1}",
      heading: languages[random.nextInt(6)],
      age: random.nextInt(18),
    );

    final result = await widget.repo.insert(dev);
    setState(() {
      _list.add(result);
    });
  }

  void saveDeveloper(Developer dev) {
    final route = CupertinoPageRoute<bool>(
      builder: (context) => DeveloperEditPage(dev: dev, repo: widget.repo),
    );

    Navigator.push(
      context,
      route,
    ).then((result) {
      if (result ?? false) {
        findAllDeveloper();
      }
    });
  }

  void deleteDeveloper({int id, int index}) async {
    await widget.repo.delete(id);
    setState(() {
      _list.removeAt(index);
    });
  }

  void findAllDeveloper({String name, String heading}) async {
    final list = await widget.repo.findAll(name: name, heading: heading);
    setState(() {
      _list = list;
    });
  }

  @override
  void initState() {
    super.initState();
    _list = List.empty(growable: true);
    _searchController = TextEditingController();
    findAllDeveloper();
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          ),
        ),
        child: Row(
          children: [
            Icon(Icons.search, color: Colors.grey),
            SizedBox(width: 8),
            Expanded(
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  findAllDeveloper(name: value, heading: _heading);
                },
                decoration: InputDecoration.collapsed(
                  hintText: "Search...",
                ),
              ),
            ),
          ],
        ),
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(46),
        child: Container(
          color: Colors.white,
          height: 46,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: languages.length,
            itemBuilder: (context, index) {
              return ChoiceChip(
                label: Text(languages[index]),
                selected: _heading == languages[index],
                onSelected: (selected) {
                  _heading = selected ? languages[index] : null;

                  findAllDeveloper(
                    name: _searchController.text,
                    heading: _heading,
                  );
                },
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(width: 8);
            },
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: appBar,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          saveDeveloper(Developer());
        },
        child: Icon(Icons.add),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: _list.length,
        separatorBuilder: (context, index) {
          return Divider(
            indent: 16,
            height: 1,
          );
        },
        itemBuilder: (context, index) {
          final dev = _list[index];
          return Dismissible(
            key: Key(dev.id.toString()),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
            ),
            onDismissed: (direction) {
              deleteDeveloper(id: dev.id, index: index);
            },
            confirmDismiss: (direction) {
              return showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text(
                      "Are you sure to delete?",
                    ),
                    actions: [
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: Text("NO"),
                      ),
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        child: Text("YES"),
                      ),
                    ],
                  );
                },
              );
            },
            child: ListTile(
              onTap: () {
                saveDeveloper(dev);
              },
              leading: Container(
                width: 60,
                height: 60,
                child: Image.asset("images/profile.png"),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[600].withOpacity(0.5),
                      blurRadius: 6,
                      spreadRadius: 1,
                      offset: Offset(0.6, 0.6),
                    )
                  ],
                ),
              ),
              title: Text(
                dev.name ?? "None",
              ),
              subtitle: Text(
                dev.heading ?? "None",
              ),
              trailing: Text("${dev.age ?? "0"}"),
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1, color: Colors.green),
              ),
            ),
          );
        },
      ),
    );
  }
}
