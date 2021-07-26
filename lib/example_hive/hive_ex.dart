// import 'package:flutter/material.dart';
// import 'package:flutter_lesson_1/example_hive/hive_model.dart';

// class HiveExample extends StatefulWidget {
//   const HiveExample({Key? key}) : super(key: key);

//   @override
//   _HiveExampleState createState() => _HiveExampleState();
// }

// class _HiveExampleState extends State<HiveExample> {
//   final HiveModelExample model = HiveModelExample();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Center(
//           child: Column(
//             children: [
//               ElevatedButton(
//                 onPressed: () => model.setUp(),
//                 child: const Text('Set Up'),
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () => model.doSome(),
//                 child: const Text('Click me'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
