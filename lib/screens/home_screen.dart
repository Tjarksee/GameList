import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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

  void changeIndex(int newIndex) {
    setState(() => _selectedIndex = newIndex);
  }

  final List<List<GameInfo>> _MainLists = [
    [testGame1, testGame2],
    [testGame1, testGame2],
    [testGame1, testGame2]
  ];

  Widget _buildMainList() {
    return ListView.builder(
      itemCount: _MainLists[_selectedIndex].length,
      itemBuilder: (BuildContext content, int index) {
        Image cover = _MainLists[_selectedIndex][index].cover;
        String gameName = _MainLists[_selectedIndex][index].name;
        String platform = _MainLists[_selectedIndex][index].platform;
        return Container(
          color: Colors.grey,
          child: ListTile(
              leading: cover,
              title: Text(
                '$gameName',
                style: TextStyle(fontSize: 24.0),
                textAlign: TextAlign.center,
              ),
              subtitle: Text('$platform',
                  style: TextStyle(fontSize: 15.0),
                  textAlign: TextAlign.center),
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
                                  builder: (context) => const AddGameScreen()));
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
