part of 'locale_bloc.dart';

abstract class LocaleEvent {}

class SetLocale extends LocaleEvent {
  final Locale locale;
  SetLocale(this.locale);
}
