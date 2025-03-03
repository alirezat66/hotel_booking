# Hotel Booking

Hotel Booking is a Flutter project designed to fetch hotels from remote source and with facility of add a hotel to favorite, I implemented this project in both **Clean Architecture** and **MVVM (Model-View-ViewModel) architecture**, and also  utilizing **Bloc for state management** and **Hydrated Bloc for persistence**.

## Some Info About the Project

[![MIT License](https://img.shields.io/apm/l/atomic-design-ui.svg?)](https://github.com/tterb/atomic-design-ui/blob/master/LICENSEs)
[![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev/)
[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev/)
[![Maintain Status](https://img.shields.io/badge/Maintained%3F-no-red.svg)]()
[![Ask me](https://img.shields.io/badge/Ask%20me-anything-1abc9c.svg)](https://alirezat66.github.io/)

## Description

This application is designed to fetch hotels, show the hotels as list, and toggle a hotel to favorite and remove from it. It ensures maintainability, expandability, and reusability by following **best practices in state management, dependency injection, and routing**.

I implemented **Theme Controller** and also the app supports multi languages that implemented by **Easy Localization**. 

I should mentioned I separated UI widgets as a separated package with name **hotel_ui_package** and for checking it used **Widget book** which can be interesting for who looking for implementation of widget book.

## Clean Architecture

Although I usually work with recomanded architecture of flutter (MMVM), For this project I switch to Clean Architecture, both of these two architectures, have same goal: separation Bussiness with Logic implementation. Although test development is most easier in CleanArchitecture, It has more additional codes. I prevent to implement entities in my implementation. 

## Libraries Used

- **dio:** For making network requests.
- **pretty_dio_logger:** For logging network requests.
- **get_it:** For dependency injection.
- **mockito:** For mocking dependencies in tests.
- **flutter_bloc:** For state management.
- **equatable:** For value equality.
- **auto_route:** For routing.
- **intl:** For internationalization.
- **gap:** For spacing widgets.
- **flutter_localizations:** For localization support.
-  **easy_localization:** MultiLanguage.
- **hydrated_bloc:** For state persistence for theme and locale.
- **hive_flutter:** For local storage.
- **flutter_svg:** showing svgs.


For state management, we use **hydrated_bloc**, which is well-suited for this type of application. With **hydrated_bloc**, we don’t need separate storage to temporarily save data and reload it when reopening the app, preventing tightly coupled dependencies in such cases.  

## Routing

Hotel Booking uses **AutoRoute** for navigation:
it is my first experience to use AutoRoute, I did not go deep, but in first touch it looks good and fast and also reliable. I had challenge to find good place to putting bloc provider on them.



### Testing  
For testing, we rely on:  
- **mockito** for mocking dependencies  
- **bloc_test** for testing Bloc logic  

### Dependency Injection  
We use **get_it** as our dependency injection framework and service locator.  

### Networking  
For API calls, we use **dio** along with **pretty_dio_logger** for logging network requests and responses.


## Tech Stack

- **Language:** Dart
- **Framework:** Flutter
- **State Management:** Bloc, Hydrated Bloc
- **Dependency Injection:** GetIt
- **Networking:** Dio
- **Routing:** AutoRoute
- **Storage:** Hydrated Bloc (Local Persistence)
- **Architecture:** Clean And MMVM (See other branch)
## Design Patterns
During working on project, I found three part of coding suitable for using design patterns.

We have to Card type in app (compacted and detailed). Although you can easily use an if-else and just implement two separated widget I challenged my selfe to make it more expandable and reusable structure.
because of that I combined Factory and Strategy Design Patterns. 
### Strategy and Factory


```dart
abstract class CardStrategy {
  Widget build(HotelData hotel,
      {Function(bool)? onFavoriteChanged,
      VoidCallback? onActionPressed,
      VoidCallback? onMoreInfoTab});
}
```

```dart
class CompactCardStrategy implements CardStrategy {
  @override
  Widget build(HotelData hotel,
      {Function(bool)? onFavoriteChanged,
      VoidCallback? onActionPressed,
      VoidCallback? onMoreInfoTab}) {
    return Column(
      children: [
          //implementation is here
      ],
    );
  }
}
```

```dart
class DetailedCardStrategy implements CardStrategy {
  @override
  Widget build(HotelData hotel,
      {Function(bool)? onFavoriteChanged,
      VoidCallback? onActionPressed,
      VoidCallback? onMoreInfoTab}) {
    return Column(
      children: [
          //another implementation is here
      ],
    );
  }
}
```
```dart

class HotelCardFactory {
  static Map<HotelCardType, CardStrategy> strategies = {
    HotelCardType.compact: CompactCardStrategy(),
    HotelCardType.detailed: DetailedCardStrategy(),
  };

  static CardStrategy getStrategy(HotelCardType type) {
    return strategies[type]!;
  }
}
```
and this is very important that I did not use switch case here, it means as soon as you add new strategy,
you just need add it here in this map with name of strategies. Strategies could define also in di, and make it more expandable. We also can do it automatically with a package with name of Reflectable.

We also could implement it with component-based architecture, I mean you can create a component with name of CardComponent and a HotelCard created with couple of components but I prefer doing this approach.

### Algorithm
The other part that I liked, was related to Satisfication level, since we had different badge, with different color and different icons (green,yeallo, red) or (dark green, green, yellow,light red, red)

what happens if we want to change range and also colors or icons????
```dart
For making it expandable I create bellow class in my package:
abstract class SatisfactionLevel {
  final IconData icon;

  const SatisfactionLevel({
    required this.icon,
  });

  /// Determines if the score falls within this level's range
  bool isInRange(double score);

  /// Get color from theme
  Color getColor(RatingBadgeTheme theme);

  /// Default predefined levels
  static final List<SatisfactionLevel> _defaultLevels = [
    VeryDissatisfiedLevel(),
    DissatisfiedLevel(),
    NeutralLevel(),
    SatisfiedLevel(),
    VerySatisfiedLevel(),
  ];

  /// The current active predefined levels
  static final List<SatisfactionLevel> _predefinedLevels = [..._defaultLevels];

  /// Flag to track if the class has been initialized
  static bool _initialized = false;

  /// Retrieves the current predefined levels, initializing if necessary
  static List<SatisfactionLevel> get levels {
    _ensureInitialized();
    return List.unmodifiable(_predefinedLevels);
  }

  /// Ensures the class is properly initialized
  static void _ensureInitialized() {
    if (!_initialized) {
      _recalculateScoreRanges();
      _initialized = true;
    }
  }

  /// Dynamically calculated min/max scores
  static void _recalculateScoreRanges() {
    int levelCount = _predefinedLevels.length;
    if (levelCount == 0) return;

    // Sort levels in the intended order
    _predefinedLevels.sort((a, b) {
      final List<Type> orderTypes = [
        VeryDissatisfiedLevel,
        DissatisfiedLevel,
        NeutralLevel,
        SatisfiedLevel,
        VerySatisfiedLevel,
      ];

      int indexA = orderTypes.indexOf(a.runtimeType);
      int indexB = orderTypes.indexOf(b.runtimeType);

      if (indexA == -1) indexA = orderTypes.length;
      if (indexB == -1) indexB = orderTypes.length;

      return indexA.compareTo(indexB);
    });

    double step = 5.0 / levelCount;

    for (int i = 0; i < levelCount; i++) {
      if (_predefinedLevels[i] is ScoreRangeBasedLevel) {
        double minScore = i * step;
        double maxScore = (i == levelCount - 1) ? 5.0 : (i + 1) * step;

        (_predefinedLevels[i] as ScoreRangeBasedLevel)
            .updateScoreRange(minScore, maxScore);
      }
    }
  }

  /// Factory method to determine level from score
  static SatisfactionLevel fromScore(double score) {
    _ensureInitialized();

    for (var level in _predefinedLevels) {
      if (level.isInRange(score)) {
        return level;
      }
    }

    // Fallback to most appropriate level
    if (score <= 0) return _predefinedLevels.first;
    if (score >= 5) return _predefinedLevels.last;

    // Find closest level if none matches exactly
    return _predefinedLevels.reduce((current, next) {
      if (current is ScoreRangeBasedLevel && next is ScoreRangeBasedLevel) {
        double currentMid = (current.minScore + current.maxScore) / 2;
        double nextMid = (next.minScore + next.maxScore) / 2;
        return (score - currentMid).abs() < (score - nextMid).abs()
            ? current
            : next;
      }
      return current;
    });
  }

  /// Allows users to **override default levels** (replaces existing levels)
  static void setLevels(List<SatisfactionLevel> levels) {
    _predefinedLevels
      ..clear()
      ..addAll(levels);
    _recalculateScoreRanges();
    _initialized = true;
  }

  /// Allows users to **add additional levels** dynamically
  static void addLevel(SatisfactionLevel level) {
    _predefinedLevels.add(level);
    _recalculateScoreRanges();
    _initialized = true;
  }
}

```
in this way user can reduse, increase or evan have it's own categories about satisfication, includes color and icons. Rate automatically calculated based on number of states. for default we have 5.


### Again Factory

this time for ui I used factory, and mix it with state:
class HotelStateWidgetFactory {
  static Widget build(HotelState state) {
    switch (state.runtimeType) {
      case const (HotelLoading):
        return const HotelLoadingWidget();
      case const (HotelSuccess):
        final successState = state as HotelSuccess;
        return HotelSuccessWidget(
          hotels: successState.hotels,
          numberOfHotels: successState.numberOfHotels,
        );
      case const (HotelFailure):
        final failureState = state as HotelFailure;
        return HotelFailureWidget(
          errorMessage: failureState.errorMessage,
        );
      default:
        return const HotelLoadingWidget();
    }
  }
}

but why we don't use map here to make it expandable because probably we don't change states.
## Folder Structure

```
lib
├── core
│   ├── bloc
│   │   └── bloc_observer.dart
│   ├── di
│   │   └── service_locator.dart
│   ├── extension
│   │   ├── hotel_ext.dart
│   │   └── hotel_favorite_ext.dart
│   ├── navigation
│   │   ├── app_router.dart
│   │   └── app_router.gr.dart
│   ├── network
│   │   ├── api_client.dart
│   │   ├── config
│   │   │   └── client_config.dart
│   │   ├── dio_client.dart
│   │   └── network_response.dart
│   └── widgets
│       └── hotel_list_view.dart
├── features
│   ├── account
│   │   └── presentation
│   │       ├── bloc
│   │       │   ├── locale_bloc.dart
│   │       │   ├── locale_event.dart
│   │       │   ├── theme_bloc.dart
│   │       │   └── theme_event.dart
│   │       └── view
│   │           └── account_page.dart
│   ├── favorite
│   │   ├── data
│   │   │   ├── datasource
│   │   │   │   └── local_data_source.dart
│   │   │   ├── model
│   │   │   │   └── hotel_favorite.dart
│   │   │   └── repository
│   │   │       └── favorite_repository_impl.dart
│   │   ├── domain
│   │   │   ├── repository
│   │   │   │   └── favorite_repository.dart
│   │   │   └── usecase
│   │   │       ├── add_favorite_use_case.dart
│   │   │       ├── get_favorites_use_case.dart
│   │   │       ├── remove_favorite_use_case.dart
│   │   │       └── watch_use_case.dart
│   │   └── presentation
│   │       ├── cubit
│   │       │   └── favorite_cubit.dart
│   │       └── view
│   │           ├── favorite_list_view.dart
│   │           ├── favorite_page.dart
│   │           └── widgets
│   │               └── favorite_empty_view.dart
│   ├── hotels
│   │   ├── data
│   │   │   ├── datasource
│   │   │   │   └── remote_data_source.dart
│   │   │   ├── models
│   │   │   │   ├── hotel_model.dart
│   │   │   │   └── hotel_response.dart
│   │   │   └── repository
│   │   │       └── hotel_repository_impl.dart
│   │   ├── domain
│   │   │   ├── repository
│   │   │   │   └── hotel_repository.dart
│   │   │   └── usecases
│   │   │       └── get_hotels_use_case.dart
│   │   └── presentation
│   │       ├── cubit
│   │       │   ├── hotel_cubit.dart
│   │       │   └── hotel_state.dart
│   │       └── view
│   │           ├── hotel_page.dart
│   │           └── widgets
│   │               ├── factory
│   │               │   └── hotel_state_widget_factory.dart
│   │               ├── hotel_failure_widget.dart
│   │               ├── hotel_list_header.dart
│   │               ├── hotel_loading_widget.dart
│   │               └── hotel_success_widget.dart
│   └── overview
│       └── overview_page.dart
└── main.dart
```


## Conclusion

**Hotel Booling** is a well-structured **Flutter Clean project** that efficiently fetch and favorite hotels. It leverages **Bloc, Hydrated Bloc, AutoRoute, and Dio** to provide a smooth and maintainable architecture.
