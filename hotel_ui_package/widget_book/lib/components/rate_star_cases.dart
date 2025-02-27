import 'package:flutter/material.dart';
import 'package:hotel_ui_package/hotel_card/widgets/rate/rate_star_widget.dart';
import 'package:widgetbook/widgetbook.dart';

WidgetbookComponent getRateStarWidget() {
  return WidgetbookComponent(
    name: 'ShadowedCard',
    useCases: [
      WidgetbookUseCase(
        name: 'Configurable',
        builder: (context) => Scaffold(
          body: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: RateStarWidget(
                  score: context.knobs.double.input(
                    label: 'Score',
                    initialValue: 3.5,
                  ),
                  starColor: context.knobs.colorOrNull(
                    label: 'Star Color',
                    initialValue: null,
                  ),
                  size: context.knobs.double.input(
                    label: 'Size',
                    initialValue: 20.0,
                  ),
                  spacing: context.knobs.double.input(
                    label: 'Spacing',
                    initialValue: 0.0,
                  ),
                  onMoreInfoTab: context.knobs.boolean(
                    label: 'Has More Info',
                    initialValue: false,
                  )
                      ? () {}
                      : null,

                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}