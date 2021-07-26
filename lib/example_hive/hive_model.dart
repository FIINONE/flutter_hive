// import 'package:hive/hive.dart';
// import 'package:hive_flutter/hive_flutter.dart';

// part 'hive_model.g.dart';

// class HiveModelExample {
//   Future<Box<User>>? userBox;

//   HiveModelExample() {
//     userBox = userBox;
//   }

//   void setUp() {
//     if (!Hive.isAdapterRegistered(0)) {
//       Hive.registerAdapter(UserAdapter());
//     }
//     userBox = Hive.openBox<User>('User');
//     userBox?.then(
//       (box) {
//         box.listenable().addListener(
//           () {
//             print(box.length);
//           },
//         );
//       },
//     );

//     Hive.boxExists('User')..then((value) => print(value));

//     print('object');
//   }

//   Future<void> doSome() async {
//     print(Hive.isBoxOpen('User'));
//     // userBox = Hive.openBox<User>('User');
//     final box = await userBox;
//     // userBox = await Hive.openBox<User>('User');
//     final azamat = User(age: 27, name: 'Azamat');
//     // print(azamat);
//     await box?.add(azamat);

//     // try {

//     //   await box.add(user);
//     // } on Exception catch (e) {
//     //   print('$e');
//     // }
//     // // print(box.isEmpty);
//     print(box?.values);
//     // print(box.getAt(2));
//     // print(userBox?.values);
//     // box.put(key, value)
//     // await box.deleteAll(box.keys);
//     // await box.deleteFromDisk();
//     // print('object');
//     // int c = await box.clear();
//     // print(c);
//     // await Hive.deleteFromDisk();

//     // bool d = Hive.isBoxOpen('Box');
//     // print(d);

//     // bool b = await Hive.boxExists('Box');
//     // print('$b');
//     // await box.close();
//   }
// }

// @HiveType(typeId: 0)
// class User extends HiveObject {
//   @HiveField(0)
//   String? name;

//   @HiveField(1)
//   int? age;

//   User({
//     this.name,
//     this.age,
//   });

//   @override
//   String toString() => 'User(name: $name, age: $age)';
// }
