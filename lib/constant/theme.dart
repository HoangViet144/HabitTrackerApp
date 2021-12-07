import 'package:flutter/material.dart';
import 'package:habit_tracker_app/constant/color.dart';

final ThemeData theme = _buildTheme();

ThemeData _buildTheme() {
  final ThemeData base = ThemeData(primarySwatch: Colors.blue);
  return base.copyWith(
    backgroundColor: secondary,
    // textTheme: _buildShrineTextTheme(base.textTheme),
    // textSelectionTheme: const TextSelectionThemeData(
    //   selectionColor: kShrinePink100,
    // ),
  );
}

// TextTheme _buildTextTheme(TextTheme base) {
//   return base
//       .copyWith(
//         headline5: base.headline5!.copyWith(
//           fontWeight: FontWeight.w500,
//         ),
//         headline6: base.headline6!.copyWith(
//           fontSize: 18.0,
//         ),
//         caption: base.caption!.copyWith(
//           fontWeight: FontWeight.w400,
//           fontSize: 14.0,
//         ),
//         bodyText1: base.bodyText1!.copyWith(
//           fontWeight: FontWeight.w500,
//           fontSize: 16.0,
//         ),
//       )
//       .apply(
//         fontFamily: 'Rubik',
//         // displayColor: kShrineBrown900,
//         // bodyColor: kShrineBrown900,
//       );
// }
