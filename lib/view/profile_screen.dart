import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:stitbd_task/utils/size_config.dart';
import 'package:stitbd_task/utils/style.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      width: SizeConfig.getScreenWidth(context) - 20,
      height: SizeConfig.getScreenHeight(context) - 20,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                kPrimaryColor,
                kErrorColor,
              ])),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          width: SizeConfig.getScreenWidth(context) - 30,
          height: SizeConfig.getScreenHeight(context) - 30,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.white,
          ),
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: ListView.builder(
                itemCount: 16,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(30.0)),
                    child: const ListTile(
                      title: Text("data"),
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}


























// Stack(
//       children: [
//         Container(
//           margin: const EdgeInsets.all(16.0),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(30),
//             gradient: const LinearGradient(
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//               transform: GradientRotation(math.pi),
//               colors: [
//                 Colors.redAccent,
//                 Colors.greenAccent,
//                 Colors.blueAccent,
//               ],
//             ),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(4),
//             child: ListView.builder(
//                 itemCount: 16,
//                 itemBuilder: (context, index) {
//                   return Container(
//                     decoration: BoxDecoration(
//                         color: Colors.transparent,
//                         borderRadius: BorderRadius.circular(30.0)),
//                     child: const ListTile(
//                       title: Text("data"),
//                     ),
//                   );
//                 }),
//           ),
//         ),
      
//       ],
//     );