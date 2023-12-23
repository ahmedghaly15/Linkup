import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ChangeIndexParams extends Equatable {
  final BuildContext? context;
  final int? index;

  const ChangeIndexParams({
    this.index,
    this.context,
  });

  @override
  List<Object?> get props => [index, context];
}
