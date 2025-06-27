// import 'dart:developer';

// import 'package:example/core/store.dart';
// import 'package:example/features/home/home_page_vm.dart';
// import 'package:flutter/material.dart';
// import 'package:myspace_core/myspace_core.dart';
// import 'package:myspace_ui/myspace_ui.dart';

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     log('Building HomePage');
//     return VmWatcher<HomePageVm>(
//       builder: (context, vm, child) {
//         return Center(
//           child: Column(
//             children: [
//               AppStoreWatcher<AppStore>(
//                 builder: (context, store, _) {
//                   // print('build store counter');
//                   return TextButton(
//                     onPressed: store.increment,
//                     child: Text(store.counter.toString()),
//                   );
//                 },
//               ),
//               AppStoreWatcher<AppStore>(
//                 builder: (context, store, _) {
//                   return TextButton(onPressed: () {}, child: Text("AppPlugin"));
//                 },
//               ),
//               TextButton(
//                 onPressed: () => context.go('/'),
//                 child: Text('Go to Splash'),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
