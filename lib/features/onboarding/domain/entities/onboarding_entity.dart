import 'package:equatable/equatable.dart';

class OnboardingEntity extends Equatable {
  final String image;
  final String heading;
  final String subHeading;

  const OnboardingEntity({
    required this.image,
    required this.heading,
    required this.subHeading,
  });

  @override
  List<Object?> get props => [image, heading, subHeading];
}
