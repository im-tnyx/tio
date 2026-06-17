import 'package:flutter/material.dart';
import 'dimens.dart';

class Shapes {
  Shapes._();

  static const BorderRadius buttonRadius = BorderRadius.all(
    Radius.circular(Dimens.radiusButton),
  );

  static const BorderRadius cardRadius = BorderRadius.all(
    Radius.circular(Dimens.radiusCard),
  );

  static const BorderRadius inputRadius = BorderRadius.all(
    Radius.circular(Dimens.radiusInput),
  );

  static const BorderRadius optionTileRadius = BorderRadius.all(
    Radius.circular(Dimens.radiusOptionTile),
  );

  static const BorderRadius sheetRadius = BorderRadius.vertical(
    top: Radius.circular(Dimens.radiusSheet),
  );

  static const RoundedRectangleBorder button = RoundedRectangleBorder(
    borderRadius: buttonRadius,
  );

  static const RoundedRectangleBorder card = RoundedRectangleBorder(
    borderRadius: cardRadius,
  );

  static const RoundedRectangleBorder cardLight = card;
  static const RoundedRectangleBorder cardDark = card;

  static const RoundedRectangleBorder input = RoundedRectangleBorder(
    borderRadius: inputRadius,
  );

  static const RoundedRectangleBorder inputLight = input;
  static const RoundedRectangleBorder inputDark = input;

  static const RoundedRectangleBorder sheet = RoundedRectangleBorder(
    borderRadius: sheetRadius,
  );

  static const RoundedRectangleBorder sheetLight = sheet;
  static const RoundedRectangleBorder sheetDark = sheet;
}
