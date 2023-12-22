import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:social_app/core/internet/internet_checker.dart';

class InternetCheckerImpl implements InternetChecker {
  final InternetConnectionChecker connectionChecker;

  const InternetCheckerImpl({required this.connectionChecker});

  @override
  Future<bool> get isConnected async => await connectionChecker.hasConnection;
}
