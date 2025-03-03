import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'theme_event.dart';

class ThemeBloc extends HydratedBloc<ThemeEvent, Brightness> {
  ThemeBloc() : super(Brightness.light) {
    // Default to English
    on<SetTheme>((event, emit) {
      emit(event.brightness);
    });
  }

  @override
  Brightness? fromJson(Map<String, dynamic> json) {
    final brightness = json['brightness'] as bool?;
    return (brightness ?? false) ? Brightness.light : Brightness.dark;
  }

  @override
  Map<String, dynamic>? toJson(Brightness state) {
    return {'locale': state != Brightness.light};
  }
}
