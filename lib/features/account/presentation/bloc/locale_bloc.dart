import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'locale_event.dart';

class LocaleBloc extends HydratedBloc<LocaleEvent, Locale> {
  LocaleBloc() : super(const Locale('en')) {
    // Default to English
    on<SetLocale>((event, emit) {
      emit(event.locale);
    });
  }

  @override
  Locale? fromJson(Map<String, dynamic> json) {
    final languageCode = json['locale'] as String?;
    return languageCode != null ? Locale(languageCode) : null;
  }

  @override
  Map<String, dynamic>? toJson(Locale state) {
    return {'locale': state.languageCode};
  }
}
