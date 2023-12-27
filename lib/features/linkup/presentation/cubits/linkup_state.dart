part of 'linkup_cubit.dart';

abstract class LinkupState extends Equatable {
  const LinkupState();

  @override
  List<Object?> get props => [];
}

class LinkupInitial extends LinkupState {
  const LinkupInitial();
}

class ChangeBottomNavIndex extends LinkupState {
  final int index;

  const ChangeBottomNavIndex({required this.index});

  @override
  List<Object> get props => [index];
}
