part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeLoadingState extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeSuccessState extends HomeState {
  final Map<int, dynamic> userTransactions;

  HomeSuccessState(this.userTransactions);
  @override
  List<Object> get props => [userTransactions];
}

class HomeErrorState extends HomeState {
  final String? message;
  HomeErrorState({this.message});
  @override
  List<Object?> get props => [message];
}

class HomeNoInternetError extends HomeState {
  final String? message;
  HomeNoInternetError({this.message});
  @override
  List<Object?> get props => [message];
}
