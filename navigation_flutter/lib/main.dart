import 'package:flutter/material.dart';
import 'package:navigation_flutter/list_page.dart';
import 'package:navigation_flutter/setting_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Navigation Demo',
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
        primarySwatch: Colors.purple,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ContainerPage(),
    );
  }
}

class ContainerPage extends StatefulWidget {
  @override
  _ContainerPageState createState() => _ContainerPageState();
}

class _ContainerPageState extends State<ContainerPage> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    Widget body;
    switch (_index) {
      case 1:
        body = ListPage();
        break;
      case 2:
        body = SettingPage();
        break;
      default:
        body = HomePage();
    }

    final bottomAppBar = BottomAppBar(
      child: Container(
        height: 56,
      ),
      shape: CircularNotchedRectangle(),
      notchMargin: 10.0,
    );

    return Scaffold(
      appBar: createAppBar("Home"),
      drawer: AppDrawer(
        index: _index,
        onChanged: (index) {
          setState(() {
            _index = index;
          });
        },
      ),
      bottomNavigationBar: BottomNav(),
      body: body,
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Home Page"),
    );
  }
}

AppBar createAppBar(String title) {
  return AppBar(
    title: Text(title),
  );
}

typedef void OnChanged(int index);

class AppDrawer extends StatelessWidget {
  final int index;
  final OnChanged onChanged;

  const AppDrawer({
    Key key,
    this.index,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.only(top: 0),
        children: [
          DrawerHeader(
            child: Text(
              "Neuron.io",
            ),
            decoration: BoxDecoration(
              color: Colors.purple,
            ),
          ),
          ListTile(
            selected: index == 0,
            leading: Icon(
              Icons.home,
            ),
            title: Text("Home"),
            onTap: () {
              Navigator.pop(context);
              onChanged(0);

            },
          ),
          ListTile(
            selected: index == 1,
            leading: Icon(
              Icons.view_list,
            ),
            title: Text("List"),
            onTap: () {
              Navigator.pop(context);
              onChanged(1);
            },
          ),
          ListTile(
            selected: index == 2,
            leading: Icon(
              Icons.settings,
            ),
            title: Text("Setting"),
            onTap: () {
              Navigator.pop(context);
              onChanged(2);
            },
          ),
        ],
      ),
    );
  }
}

class BottomNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showUnselectedLabels: false,
      backgroundColor: Theme.of(context).primaryColor,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white.withOpacity(0.4),
      currentIndex: 1,
      onTap: (index) {
        print("$index");
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          title: Text("Dashboard"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          title: Text("Notifications"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.more_horiz),
          title: Text("More"),
        ),
      ],
    );
  }
}
