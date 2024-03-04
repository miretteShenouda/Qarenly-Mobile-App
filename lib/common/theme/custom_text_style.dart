import 'package:flutter/material.dart';
import '../../core/app_export.dart';

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.

class CustomTextStyles {
  // Body text style
  static get bodyLarge16 => theme.textTheme.bodyLarge!.copyWith(
        fontSize: 16.fSize,
      );
  static get bodyLargeExtraLight => theme.textTheme.bodyLarge!.copyWith(
        fontSize: 16.fSize,
        fontWeight: FontWeight.w200,
      );
  static get bodyLargeff003049 => theme.textTheme.bodyLarge!.copyWith(
        color: Color(0XFF003049),
      );
  static get bodyMedium14 => theme.textTheme.bodyMedium!.copyWith(
        fontSize: 14.fSize,
      );
  static get bodyMediumBlack900 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.black900,
      );
  static get bodyMediumff003049 => theme.textTheme.bodyMedium!.copyWith(
        color: Color(0XFF003049),
        fontSize: 14.fSize,
      );
  // Headline text style
  static get headlineSmallMedium => theme.textTheme.headlineSmall!.copyWith(
        fontSize: 24.fSize,
        fontWeight: FontWeight.w500,
      );
  static get headlineSmallSemiBold => theme.textTheme.headlineSmall!.copyWith(
        fontSize: 24.fSize,
        fontWeight: FontWeight.w600,
      );
  // Title text style
  static get titleLarge22 => theme.textTheme.titleLarge!.copyWith(
        fontSize: 22.fSize,
      );
  static get titleLargeBold => theme.textTheme.titleLarge!.copyWith(
        fontWeight: FontWeight.w700,
      );
  static get titleLargeBold22 => theme.textTheme.titleLarge!.copyWith(
        fontSize: 22.fSize,
        fontWeight: FontWeight.w700,
      );
  static get titleLargeRegular => theme.textTheme.titleLarge!.copyWith(
        fontWeight: FontWeight.w400,
      );
  static get titleLargeRegular21 => theme.textTheme.titleLarge!.copyWith(
        fontSize: 21.fSize,
        fontWeight: FontWeight.w400,
      );
  static get titleLargeRegular22 => theme.textTheme.titleLarge!.copyWith(
        fontSize: 22.fSize,
        fontWeight: FontWeight.w400,
      );
  static get titleLargeSemiBold => theme.textTheme.titleLarge!.copyWith(
        fontWeight: FontWeight.w600,
      );
  static get titleLargeff003049 => theme.textTheme.titleLarge!.copyWith(
        color: Color(0XFF003049),
        fontSize: 21.fSize,
        fontWeight: FontWeight.w400,
      );
  static get titleLargeff003049Regular => theme.textTheme.titleLarge!.copyWith(
        color: Color(0XFF003049),
        fontSize: 22.fSize,
        fontWeight: FontWeight.w400,
      );
  static get titleMedium18 => theme.textTheme.titleMedium!.copyWith(
        fontSize: 18.fSize,
      );
  static get titleMediumOnPrimaryContainer =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.onPrimaryContainer,
        fontSize: 18.fSize,
      );
  static get titleSmallBold => theme.textTheme.titleSmall!.copyWith(
        fontWeight: FontWeight.w700,
      );
  static get titleSmallMedium => theme.textTheme.titleSmall!.copyWith(
        fontWeight: FontWeight.w500,
      );
  static get titleSmallOnPrimaryContainer =>
      theme.textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.onPrimaryContainer,
        fontWeight: FontWeight.w500,
      );
  static get titleSmallOnPrimaryContainer_1 =>
      theme.textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.onPrimaryContainer,
      );
  static get titleSmallff000000 => theme.textTheme.titleSmall!.copyWith(
        color: Color(0XFF000000),
        fontWeight: FontWeight.w700,
      );
}

extension on TextStyle {
  TextStyle get inter {
    return copyWith(
      fontFamily: 'Inter',
    );
  }
}
