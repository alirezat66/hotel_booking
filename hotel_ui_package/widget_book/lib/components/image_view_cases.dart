import 'package:flutter/material.dart';
import 'package:hotel_ui_package/hotel_ui_package.dart';
import 'package:widgetbook/widgetbook.dart';

WidgetbookComponent getImageWidgets() {
  return WidgetbookComponent(
    name: 'Image View',
    useCases: [
      WidgetbookUseCase(
        name: 'Like Info',
        builder: (context) => Scaffold(
          body: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                elevation: 4,
                color: Colors.white,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                  child: FavoriteWidget(
                      initialState: context.knobs.boolean(
                        label: 'Init State',
                        initialValue: false,
                      ),
                      size: context.knobs.double.input(
                        label: 'Size',
                        initialValue: 30,
                      ),
                      onLikeChanged: context.knobs.boolean(
                        label: 'Clickable',
                        initialValue: true,
                      )
                          ? (isFavorite) {}
                          : null),
                ),
              ),
            ],
          ),
        ),
      ),
      WidgetbookUseCase(
        name: 'Image',
        builder: (context) => Scaffold(
          body: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 40,
              ),
              Card(
                  elevation: 4,
                  color: Colors.white,
                  child: AppImageView(
                    boarderRadius: context.knobs.double.input(
                      label: 'Boarder Radius',
                      initialValue: 4,
                    ),
                    url: context.knobs.string(
                      label: 'Init State',
                      initialValue:
                          'https://images.unsplash.com/photo-1506744038136-46273834b3fb?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8MXx8fGVufDB8fHx8&w=1000&q=80',
                    ),
                    aspectRatio: context.knobs.double.input(
                      label: 'Aspect Ratio',
                      initialValue: 343 / 186,
                    ),
                  )),
            ],
          ),
        ),
      ),
    ],
  );
}
