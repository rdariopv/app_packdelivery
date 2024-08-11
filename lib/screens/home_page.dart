import 'package:app_packdelivery/components/bottom_nav_bar.dart';
import 'package:app_packdelivery/components/my_list_tile.dart';
import 'package:app_packdelivery/controller/auth_provider.dart';
import 'package:app_packdelivery/screens/delivery_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'list_pack_page.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
// this select index is to control the bottom nav bar
  int _selectedIndex = 0;

  // this method will update our selected index
  // when the user taps on the bottom bar
  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }



 // @override
 // Widget build(BuildContext context) {
 //   return Scaffold(
 //     appBar: AppBar(title: Text('Paquetes por entregar')),
 //     body: Center(child: Text('no tienes ninguna entrega pendiente')),
 //   );
 // }
  // page to display
  final List<Widget> _pages = [
    // shop page
    const ListPackPage(),

    // cart page
    //const CartPages(),
  ];

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: Colors.grey[300],
     // bottomNavigationBar: MyBottomNavBar(
     //   onTabChange: (index) => navigateBottomBar(index),
     // ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Padding(
              padding: EdgeInsets.only(left: 12.0),
              child: Icon(
                Icons.menu,
                color: Colors.black,
              ),
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),
      drawer: Drawer(
        // backgroundColor: Colors.grey[900],
        backgroundColor: Theme.of(context).colorScheme.background,
        child: Column(
          children: [
            DrawerHeader(
              // Image.asset('lib/images/nike.png',color: Colors.white,
              child: Center(
                  //Image.asset('lib/images/nike.png',color: Colors.white,
               // child: Icon(
               //   Icons.shopping_bag,
               //   size: 72,
               //   color: Theme.of(context).colorScheme.outline,
               // ),
                  child: CircleAvatar(
                    radius: 75,
                    backgroundImage: AssetImage('lib/images/nike.png'),
                  )
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Divider(
                color: Colors.grey[800],
              ),
            ),

            // other pages
            MyListTile(
              text: 'usuario:  ${authProvider.user?.username}' ,
              icon: FontAwesomeIcons.user,

              onTap: () =>{
                navigateBottomBar(0),
                Navigator.pop(context),
              },
            ),
            MyListTile(
              text: 'mail: ${authProvider.user?.email}',
              icon: FontAwesomeIcons.envelope,
              onTap: ()=> {
               // navigateBottomBar(0),
               // Navigator.pop(context),

                // Navigator.of(context).push(MaterialPageRoute(builder: (context) => CartPages(),),);
              },
            ),
            MyListTile(
              text: "id_chofer: ${authProvider.user?.id_chofer}",
              icon: Icons.info,
              onTap: () => {
              //  navigateBottomBar(1),
              //  Navigator.pop(context),
              },
            ),
            MyListTile(
              text: "logout",
              icon: Icons.logout,
              onTap: () {
                authProvider.logout();
               // Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
    );
  }


}
