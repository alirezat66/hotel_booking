import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'theme_event.dart';

class ThemeBloc extends HydratedBloc<ThemeEvent, Brightness> {
  ThemeBloc() : super(Brightness.light) {
    on<SetTheme>((event, emit) {
      emit(event.brightness);
    });
  }

  @override
  Brightness? fromJson(Map<String, dynamic> json) {
    final isDark = json['isDark'] as bool?;
    return isDark == true ? Brightness.dark : Brightness.light;
  }

  @override
  Map<String, dynamic>? toJson(Brightness state) {
    return {'isDark': state == Brightness.dark};
  }
}
