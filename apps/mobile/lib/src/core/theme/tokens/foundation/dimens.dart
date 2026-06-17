abstract final class Dimens {
  Dimens._();

  // ---------------------------------------------------------------------------
  // Spacing - Foundation
  // ---------------------------------------------------------------------------

  static const double spaceNone = 0.0;
  static const double spaceXXS = 2.0;
  static const double spaceXS = 4.0;
  static const double spaceS = 8.0;
  static const double spaceSM = 12.0;
  static const double spaceM = 16.0;
  static const double spaceL = 24.0;
  static const double spaceXL = 32.0;
  static const double spaceXXL = 48.0;
  static const double spaceHuge = 64.0;

  // ---------------------------------------------------------------------------
  // Padding - Semantic
  // ---------------------------------------------------------------------------

  static const double paddingScreen = spaceM;
  static const double paddingCard = spaceM;
  static const double paddingContent = spaceSM;
  static const double paddingItem = spaceSM;
  static const double paddingItemHorizontal = spaceM;
  static const double paddingItemVertical = spaceSM;
  static const double paddingButton = spaceS;
  static const double paddingInput = spaceM;

  static const double topBarPaddingHorizontal = spaceM;
  static const double topBarPaddingVertical = spaceS;

  static const double bottomNavPadding = spaceXS;
  static const double bottomNavMarginHorizontal = spaceM;
  static const double bottomNavMarginBottom = spaceXL;

  // ---------------------------------------------------------------------------
  // Radius - Foundation
  // ---------------------------------------------------------------------------

  static const double radiusXS = 4.0;
  static const double radiusS = 8.0;
  static const double radiusM = 12.0;
  static const double radiusL = 16.0;
  static const double radiusXL = 20.0;
  static const double radius2XL = 24.0;
  static const double radius3XL = 28.0;
  static const double radiusCircle = 50.0;
  static const double radiusPill = 500.0;

  // ---------------------------------------------------------------------------
  // Radius - Semantic
  // ---------------------------------------------------------------------------

  static const double radiusCard = radiusXL;
  static const double radiusButton = radiusPill;
  static const double radiusInput = radiusM;
  static const double radiusSheet = radius2XL;
  static const double radiusDialog = radius3XL;
  static const double radiusFeatureIcon = radiusCircle;
  static const double radiusOptionTile = radius2XL;
  static const double radiusBottomNavSelection = radius2XL;
  static const double radiusPremiumBox = radiusM;

  // ---------------------------------------------------------------------------
  // Elevation
  // ---------------------------------------------------------------------------

  static const double elevationNone = 0.0;
  static const double elevationButton = 2.0;
  static const double elevationDialog = 6.0;

  // ---------------------------------------------------------------------------
  // Component Sizes
  // ---------------------------------------------------------------------------

  static const double buttonHeight = 48.0;
  static const double buttonHeightLarge = 50.0;
  static const double inputHeight = 50.0;

  static const double featureTileHeight = 56.0;
  static const double featureTileIconContainerSize = 40.0;

  static const double topBarHeight = 56.0;
  static const double topBarItemSize = 38.0;

  static const double bottomNavHeight = 80.0;
  static const double aiButtonSize = 48.0;

  static const double sheetHandleHeight = 4.0;
  static const double sheetHandleWidth = 40.0;

  static const double progressBarHeight = 8.0;

  // ---------------------------------------------------------------------------
  // Icon Sizes
  // ---------------------------------------------------------------------------

  static const double iconSizeXXS = 12.0;
  static const double iconSizeXS = 18.0;
  static const double iconSizeS = 22.0;
  static const double iconSizeM = 24.0;

  static const double iconSizePremium = 16.0;
  static const double iconSizeStreak = 20.0;
  static const double iconSizeAi = 45.0;

  static const double topBarIcon = iconSizeM;
  static const double bottomNavIcon = iconSizeS;

  // ---------------------------------------------------------------------------
  // Layout
  // ---------------------------------------------------------------------------

  static const double screenMaxContentWidth = 600.0;

  // ---------------------------------------------------------------------------
  // Border Widths
  // ---------------------------------------------------------------------------

  static const double borderSubtle = 0.6;
  static const double borderThin = 0.8;
  static const double borderMedium = 1.5;
  static const double borderThick = 2.0;

  // ---------------------------------------------------------------------------
  // Bottom Navigation
  // ---------------------------------------------------------------------------

  static const double bottomNavShadowBlur = 20.0;
  static const double bottomNavShadowOffsetY = 5.0;
  static const double bottomNavBlur = 12.0;
  static const double bottomNavBorderWidth = 1.0;
  static const double bottomNavItemPaddingHorizontal = spaceXS;
  static const double bottomNavItemPaddingVertical = 6.0;
  static const double bottomNavIconLabelGap = 1.0;

  static const double bottomNavBackgroundOpacityLight = opacityStrong;
  static const double bottomNavBackgroundOpacityDark = opacityOverlayHigh;
  static const double bottomNavBorderOpacityLight = opacityOverlayMedium;
  static const double bottomNavBorderOpacityDark = opacityOverlayLow;
  static const double bottomNavUnselectedOpacity = opacityHalf;

  // ---------------------------------------------------------------------------
  // Opacity
  // ---------------------------------------------------------------------------

  static const double opacityGlass = 0.05;
  static const double opacityGlassBorder = 0.10;
  static const double opacityGlassBackground = 0.85;

  static const double opacityOverlayLow = 0.15;
  static const double opacityOverlayMedium = 0.35;
  static const double opacityOverlayHigh = 0.70;
  static const double opacityHalf = 0.50;
  static const double opacityStrong = 0.80;

  static const double opacitySubtle = 0.30;
  static const double opacityMuted = 0.40;
  static const double opacityLowVariant = 0.25;

  // ---------------------------------------------------------------------------
  // Blur
  // ---------------------------------------------------------------------------

  static const double blurGlass = 8.0;
}
