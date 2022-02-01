import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:palion/utilities/colors.dart';
import 'package:palion/widgets/sidebar/sidebar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Row(
        children: [
          SizedBox(
            width: 300,
            child: Sidebar(
              tabs: [
                SidebarTab(
                  key: "chapwadatera",
                  title: "titdawlea",
                  icon: Icon(CupertinoIcons.padlock),
                ),
                SidebarTab(
                  key: "chaptera",
                  title: "titlea",
                  children: [
                    SidebarTab(key: "key", title: "cool", icon: Icon(CupertinoIcons.padlock)),
                    SidebarTab(key: "key2", title: "cool123", icon: Icon(CupertinoIcons.ant_circle)),
                    SidebarTab(key: "kedgrty2", title: "cooladwaw123"),
                  ],
                ),
                SidebarTab(
                  key: "chgfhgdfaptera",
                  title: "titfggfhlea",
                  children: [
                    SidebarTab(key: "keggfy", title: "cogfghol"),
                    SidebarTab(key: "kegffghy2", title: "cogfgfol123"),
                  ],
                ),
              ],
              header: const CupertinoSliverNavigationBar(
                leading: Icon(
                  CupertinoIcons.sidebar_left,
                  size: 20,
                  color: CupertinoColors.activeBlue,
                ),
                trailing: Text(
                  "Edit",
                  style: TextStyle(color: CupertinoColors.activeBlue, fontSize: 16),
                ),
                largeTitle: Text("Example"),
              ),
              onTabChanged: print,
            ),
          ),
          Container(
            width: 1,
            height: screenSize.height,
            color: PalionColors.from(context).sidebarBorderColor,
          ),
          Expanded(
            child: Container(
              color: PalionColors.from(context).canvas,
              child: const Center(child: Text("example")),
            ),
          ),
        ],
      ),
    );
  }
}
