// // ignore_for_file: camel_case_types

// import 'package:flutter/material.dart';
// import 'package:myspace_core/myspace_core.dart';
// import 'package:myspace_ui/myspace_ui.dart';

// class FirstPageVm extends Vm {
//   int counter = 0;
//   void increment() {
//     counter++;
//     notifyListeners();
//   }
// }

// final firstLayout = UIRoute<FirstPageVm>.layout(
//   vm: (context, state) => FirstPageVm(),
//   layoutBuilder:
//       (context, state, navigationShell) =>
//           FirstPageLayout(shell: navigationShell),
//   branches: [
//     //todo:
//     UIBranch(
//       pages: [
//         UIRoute.page(
//           path: '/page1',
//           builder: (context, state) => const Page1(),
//         ),
//       ],
//     ),
//     UIBranch(
//       pages: [
//         UIRoute.page(
//           path: '/page2',
//           builder: (context, state) => const Page2(),
//         ),
//       ],
//     ),

//     UIBranch(
//       pages: [
//         UIRoute.page(
//           path: '/page3',
//           builder: (context, state) {
//             return const SizedBox.shrink();
//           },
//           pages: [
//             UIRoute.layout(
//               layoutBuilder:
//                   (context, state, navigationShell) =>
//                       Page3Layout(shell: navigationShell),
//               branches: [
//                 UIBranch(
//                   pages: [
//                     UIRoute.page(
//                       path: '/1',
//                       transitionType: TransitionType.slideFromLeft,
//                       builder: (context, state) => const Page3_1(),
//                     ),
//                   ],
//                 ),
//                 UIBranch(
//                   pages: [
//                     UIRoute.page(
//                       path: '/2',
//                       transitionType: TransitionType.slideFromRight,
//                       builder: (context, state) => const Page3_2(),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ],
//     ),
//   ],
// );

// class FirstPageLayout extends StatelessWidget {
//   const FirstPageLayout({super.key, required this.shell});

//   final StatefulNavigationShell shell;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: VmWatcher<FirstPageVm>(
//           builder: (context, vm, _) {
//             final matchedLocation = context.fullRoutePath;
//             print(vm.counter);
//             return Text('First Page - $matchedLocation');
//           },
//         ),
//       ),
//       body: shell,
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: shell.currentIndex,
//         onTap: shell.goBranch,
//         items: [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.settings),
//             label: 'Settings',
//           ),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
//         ],
//       ),
//     );
//   }
// }

// class Page1 extends StatelessWidget {
//   const Page1({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.red,
//       child: Column(
//         children: [
//           VmWatcher<FirstPageVm>(
//             builder: (context, vm, _) {
//               return TextButton(
//                 child: Text('Counter: ${vm.counter}'),
//                 onPressed: () {
//                   vm.increment();
//                 },
//               );
//             },
//           ),
//           ElevatedButton(
//             onPressed: () {
//               context.go('/');
//             },
//             child: Text('Go to Splash Page'),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class Page2 extends StatelessWidget {
//   const Page2({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.green,
//       child: Column(
//         children: [
//           VmWatcher<FirstPageVm>(
//             builder: (context, vm, _) {
//               return TextButton(
//                 child: Text('Counter: ${vm.counter}'),
//                 onPressed: () {
//                   vm.increment();
//                 },
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// class Page3Layout extends StatelessWidget {
//   const Page3Layout({super.key, required this.shell});

//   final StatefulNavigationShell shell;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: shell,
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: shell.currentIndex,
//         onTap: shell.goBranch,
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.pageview),
//             label: 'Page 3.1',
//           ),
//           BottomNavigationBarItem(icon: Icon(Icons.pages), label: 'Page 3.2'),
//         ],
//       ),
//     );
//   }
// }

// class Page3_1 extends StatelessWidget {
//   const Page3_1({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.blue,
//       child: Center(child: Text('Page 3.1')),
//     );
//   }
// }

// class Page3_2 extends StatelessWidget {
//   const Page3_2({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.yellow,
//       child: Center(child: Text('Page 3.2')),
//     );
//   }
// }
