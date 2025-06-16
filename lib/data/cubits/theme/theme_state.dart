// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'theme_state.freezed.dart';

@freezed
abstract class ThemeState with _$ThemeState {
  const factory ThemeState({
    required Color primaryColor,
    required Color secondaryColor,
    required Color textColor,
    required Color backgroundColor,
    required Color elevatedBtnTextColor,
    required Color texButtonColor,
    required Color elevatedBackgroundColor,
    required Color gradiantColor,
  }) = _ThemeState;

  factory ThemeState.defaut() {
    final _default = Color.fromARGB(255, 49, 67, 101);
    return ThemeState(
      primaryColor: _default,
      secondaryColor: Colors.white,
      textColor: Colors.black,
      backgroundColor: _default,
      elevatedBtnTextColor: Colors.white,
      texButtonColor: _default,
      elevatedBackgroundColor: _default,
      gradiantColor: Color.fromARGB(255, 82, 101, 140),
    );
  }

  factory ThemeState.blue() {
    final blue = Colors.blue[800]!;
    return ThemeState(
      primaryColor: blue,
      secondaryColor: Colors.white,
      textColor: Colors.black,
      backgroundColor: blue,
      elevatedBtnTextColor: Colors.white,
      texButtonColor: blue,
      elevatedBackgroundColor: blue,
      gradiantColor: Colors.blue[500]!,
    );
  }

  factory ThemeState.orange() {
    final orange = Colors.orange[800]!;
    return ThemeState(
      primaryColor: orange,
      secondaryColor: Colors.white,
      textColor: Colors.black,
      backgroundColor: orange,
      elevatedBtnTextColor: Colors.white,
      texButtonColor: orange,
      elevatedBackgroundColor: orange,
      gradiantColor: Colors.orange[500]!,
    );
  }

  factory ThemeState.brown() {
    final brown = Color.fromARGB(255, 98, 12, 0);
    return ThemeState(
      primaryColor: brown,
      secondaryColor: Colors.white,
      textColor: Colors.black,
      backgroundColor: brown,
      elevatedBtnTextColor: Colors.white,
      texButtonColor: brown,
      elevatedBackgroundColor: brown,
      gradiantColor: Color.fromARGB(255, 140, 17, 1),
    );
  }
}
