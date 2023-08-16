part of 'banner_cubit.dart';

@immutable
abstract class BannerState {}

class BannerInitial extends BannerState {}

class BannerLoading extends BannerState {}

class BannerSuccess extends BannerState {}

class BannerFailure extends BannerState {
  final String errorMessage;

  BannerFailure({required this.errorMessage});
}
