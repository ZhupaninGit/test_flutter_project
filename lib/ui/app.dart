import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_project/ui/screens/stickers/stickers_screen.dart';
import 'package:test_project/ui/screens/stickers/stickers_view_model.dart';
import 'package:test_project/ui/theme/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => StickersViewModel(),
        )
      ],
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text("StiJoy.com"),
            actions: [
              IconButton(
                icon: Icon(Icons.volume_up),
                onPressed: () {},
              )
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.face),
                label: "Stickers",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: "Search",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.people),
                label: "Authors",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.man_2_outlined),
                label: "Profile",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.menu),
                label: "More",
              ),
            ],
            currentIndex: 0,
          ),
          body: StickersScreen(),
        ),
        theme: AppTheme.theme,
      ),
    );
  }
}
