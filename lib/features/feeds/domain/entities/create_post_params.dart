import 'package:equatable/equatable.dart';

class CreatePostParams extends Equatable {
  final String date;
  final String time;
  final String text;
  final String? postImage;

  const CreatePostParams({
    required this.date,
    required this.time,
    required this.text,
    this.postImage,
  });

  @override
  List<Object?> get props => [date, time, text, postImage];
}
