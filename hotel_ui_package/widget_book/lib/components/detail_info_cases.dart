import 'package:flutter/material.dart';
import 'package:hotel_ui_package/hotel_ui_package.dart';
import 'package:widgetbook/widgetbook.dart';

WidgetbookComponent getInfo() {
  return WidgetbookComponent(
    name: 'Info',
    useCases: [
      WidgetbookUseCase(
        name: 'Detail Info',
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
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: HotelDetailWidget(
                    days: context.knobs.int.input(
                      label: 'Days',
                      initialValue: 8,
                    ),
                    nights: context.knobs.int.input(
                      label: 'Nights',
                      initialValue: 7,
                    ),
                    overallName: context.knobs.string(
                      label: 'Overall Name',
                      initialValue: 'Doppelzimmer',
                    ),
                    overallBoarding: context.knobs.string(
                      label: 'Boarding',
                      initialValue: 'Frühstück',
                    ),
                    kids: context.knobs.int.input(
                      label: 'Kids',
                      initialValue: 2,
                    ),
                    adults: context.knobs.int.input(
                      label: 'Adults',
                      initialValue: 2,
                    ),
                    isIncludeFlight: context.knobs.boolean(
                      label: 'Include Flight',
                      initialValue: true,
                    ),
                    totalPrice: context.knobs.double.input(
                      label: 'Total Price',
                      initialValue: 1279,
                    ),
                    perPersonPrice: context.knobs.double.input(
                      label: 'Per Person Price',
                      initialValue: 319.75,
                    ),
                    hasMoreOneOffer: context.knobs.boolean(
                      label: 'Has More One Offer',
                      initialValue: true,
                    ),
                    currency: context.knobs.string(
                      label: 'Currency',
                      initialValue: 'EUR',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      WidgetbookUseCase(
        name: 'General Info',
        builder: (context) => Scaffold(
          body: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                color: Colors.white,
                elevation: 4,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: HotelGeneralInfoWidget(
                    score: context.knobs.double.input(
                      label: 'Score',
                      initialValue: 4.2,
                    ),
                    hotelName: context.knobs.string(
                      label: 'Hotel Name',
                      initialValue: 'Hotel AluaVillage Blue Beach',
                    ),
                    hotelAddress: context.knobs.string(
                      label: 'Address',
                      initialValue: 'Playa de Esquinzo, Fuerteventura, Spanien',
                    ),
                    onMoreInfoTab: context.knobs.boolean(
                      label: 'Has More Info',
                      initialValue: true,
                    )
                        ? () {}
                        : null,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
