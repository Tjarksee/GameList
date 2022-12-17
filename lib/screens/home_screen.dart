import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:game_list/list/list_class.dart';
import 'package:game_list/list/main_list.dart';
import 'package:game_list/screens/addGame_screen.dart';
import 'package:game_list/screens/game_class.dart';
import 'package:game_list/screens/game_page.dart';
import 'package:game_list/screens/signin_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  MainList favedList1 = MainList();
  void changeIndex(int newIndex) {
    setState(() => _selectedIndex = newIndex);
  }

  List<List<GameItem>> mainLists = [[], [], []];

  update(favList) {
    MainList items = favList;
    mainLists[0] = items.favList;
  }

  Widget _buildMainList() {
    update(favedList1);
    return ListView.builder(
      itemCount: mainLists[_selectedIndex].length,
      itemBuilder: (BuildContext content, int index) {
        return Container(
          color: Colors.grey,
          child: ListTile(
              leading: mainLists[_selectedIndex][index].buildLeading(context),
              title: mainLists[_selectedIndex][index].buildTitle(context),
              subtitle: mainLists[_selectedIndex][index].buildSubtitle(context),
              trailing: Icon(Icons.chevron_right),
              onTap: () =>
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return game_page();
                  }))),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: MaterialApp(
            theme: ThemeData.dark(),
            home: Scaffold(
                appBar: AppBar(
                  title: Text('title'),
                  actions: [
                    IconButton(
                        onPressed: (null),
                        icon: Icon(Icons.filter_alt_rounded)),
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AddGameScreen(favList: favedList1)))
                              .then((_) {
                            setState(() {});
                          });
                        },
                        icon: Icon(Icons.search)),
                    IconButton(
                        onPressed: (null),
                        icon: Icon(Icons.format_list_bulleted_sharp))
                  ],
                ),
                drawer: Drawer(
                    child: ListView(
                  children: [
                    const SizedBox(
                      height: 64.0,
                      child: DrawerHeader(
                          margin: EdgeInsets.all(0.0),
                          padding: EdgeInsets.all(0.0),
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 113, 113, 113)),
                          child: Center(
                            child: Text("menu", textAlign: TextAlign.center),
                          )),
                    ),
                    ListTile(
                      title: const Text(
                        'Logout',
                        textAlign: TextAlign.center,
                      ),
                      onTap: () {
                        FirebaseAuth.instance.signOut().then((value) {
                          print("Signed Out");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignInScreen()));
                        });
                      },
                    ),
                    ListTile(
                      title: const Text('Item 2', textAlign: TextAlign.center),
                      onTap: () {},
                    )
                  ],
                )),
                body: _buildMainList(),
                bottomNavigationBar: _MyBottomNavigationBar(
                  updateIndex: changeIndex,
                  currentIndex: _selectedIndex,
                ))));
  }
}

class _MyBottomNavigationBar extends StatelessWidget {
  final updateIndex;
  final currentIndex;

  const _MyBottomNavigationBar({this.updateIndex, this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: const Color.fromARGB(255, 19, 19, 19),
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.newspaper),
          label: 'News',
        )
      ],
      currentIndex: currentIndex,
      selectedItemColor: Colors.amber,
      onTap: (int index) {
        updateIndex(index);
      },
    );
  }
}
