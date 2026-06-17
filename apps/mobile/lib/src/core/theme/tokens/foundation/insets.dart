import 'package:flutter/material.dart';
import 'dimens.dart';

sealed class Insets {
  Insets._();

  static const EdgeInsets screen = EdgeInsets.all(Dimens.paddingScreen);
  static const EdgeInsets button = EdgeInsets.symmetric(
    horizontal: Dimens.spaceM,
    vertical: Dimens.spaceSM,
  );
  static const EdgeInsets input = EdgeInsets.symmetric(
    horizontal: Dimens.spaceSM,
    vertical: Dimens.spaceS,
  );
  static const EdgeInsets optionTile = EdgeInsets.symmetric(
    horizontal: Dimens.paddingItemHorizontal,
    vertical: Dimens.paddingItemVertical,
  );
  static const EdgeInsets textButton = EdgeInsets.symmetric(
    horizontal: Dimens.spaceSM,
    vertical: Dimens.spaceXS,
  );
  static const EdgeInsets topBar = EdgeInsets.symmetric(
    horizontal: Dimens.topBarPaddingHorizontal,
    vertical: Dimens.topBarPaddingVertical,
  );
  static const EdgeInsets fieldFeedback = EdgeInsets.only(
    left: Dimens.spaceS,
    top: Dimens.spaceXS,
  );

  static const EdgeInsets buttonPadding = button;
  static const EdgeInsets inputPadding = input;
}
