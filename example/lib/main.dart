import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:palion/palion.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Example",
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: PalionTheme.light(child: const MyHomePage()).copyWith(primaryColor: Colors.green, active: Colors.green, selectedTile: Colors.green),
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
            width: 350,
            child: PalionSidebar(
              tabs: [
                PalionSidebarTab(
                  title: "Item",
                  key: null,
                  icon: const Icon(CupertinoIcons.padlock),
                ),
                PalionSidebarTab(
                  key: null,
                  title: "Category 1",
                  children: [
                    PalionSidebarTab(key: null, title: "Item 1", icon: const Icon(CupertinoIcons.device_phone_landscape)),
                    PalionSidebarTab(key: null, title: "Item 2", icon: const Icon(CupertinoIcons.ant_circle)),
                    PalionSidebarTab(key: null, title: "Item 3"),
                    PalionSidebarTab(key: null, title: "Item 4", icon: const Icon(CupertinoIcons.cart_fill)),
                    PalionSidebarTab(key: null, title: "Item 5"),
                  ],
                ),
                PalionSidebarTab(
                  key: null,
                  title: "Category 2",
                  children: [
                    PalionSidebarTab(key: null, title: "Item"),
                    PalionSidebarTab(key: null, title: "Item"),
                  ],
                ),
              ],
              header: CupertinoSliverNavigationBar(
                leading: Icon(
                  CupertinoIcons.sidebar_left,
                  size: 20,
                  color: PalionTheme.of(context).active,
                ),
                trailing: Text(
                  "Edit",
                  style: TextStyle(color: PalionTheme.of(context).active, fontSize: 16),
                ),
                largeTitle: const Text("Example"),
              ),
              onTabChanged: print,
            ),
          ),
          Container(
            width: 1,
            height: screenSize.height,
            color: PalionTheme.of(context).sidebarBorderColor,
          ),
          Expanded(
            child: Container(
              color: PalionTheme.of(context).canvas,
              child: SafeArea(
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 10),
                          PalionButton.small(
                            leading: const Icon(CupertinoIcons.play_arrow_solid),
                            label: "Play",
                            onPressed: () {},
                          ),
                          const SizedBox(height: 10),
                          PalionButton.medium(
                            leading: const Icon(CupertinoIcons.play_arrow_solid),
                            label: "Play",
                            onPressed: () {},
                          ),
                          const SizedBox(height: 10),
                          PalionButton.large(
                            leading: const Icon(CupertinoIcons.play_arrow_solid),
                            label: "Play",
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
