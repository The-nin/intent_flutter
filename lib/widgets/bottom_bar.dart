// import 'package:exercise8_5_25/pages/home_page.dart';
// import 'package:flutter/material.dart';

// class BottomBar extends StatefulWidget {
//   const BottomBar({super.key});

//   @override
//   State<BottomBar> createState() => _BottomBarState();
// }

// class _BottomBarState extends State<BottomBar> {
//   int _slectedIndex = 0;

//   static const TextStyle optionStyle = TextStyle(
//     fontSize: 30,
//     fontWeight: .bold,
//   );

//   static const List<Widget> _widgetOptions = <Widget>[
//     HomePage(),
//     Text('Index 1: MyOrder', style: optionStyle),
//     Text('Index 2: Favorite', style: optionStyle),
//     Text('Index 3: Profile', style: optionStyle),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _slectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(child: _widgetOptions.elementAt(_slectedIndex)),
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.shopping_bag),
//             label: 'MyOrder',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.favorite),
//             label: 'Favorite',
//           ),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
//         ],
//         currentIndex: _slectedIndex,
//         selectedItemColor: Colors.amber[800],
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }
