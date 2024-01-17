import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class NavigateBetweenPagesParams extends Equatable {
  final BuildContext context;
  final PageController pageController;
  final bool isLastBoarding;

  const NavigateBetweenPagesParams({
    required this.context,
    required this.pageController,
    required this.isLastBoarding,
  });

  @override
  List<Object?> get props => [context, pageController, isLastBoarding];
}
