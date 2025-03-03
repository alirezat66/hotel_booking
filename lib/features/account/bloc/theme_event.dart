part of 'theme_bloc.dart';

sealed class ThemeEvent {}

class SetTheme extends ThemeEvent {
  final Brightness brightness;
  SetTheme(this.brightness);
}
