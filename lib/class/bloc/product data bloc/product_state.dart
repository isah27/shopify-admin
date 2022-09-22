// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'product_bloc.dart';

abstract class ProductStates extends Equatable {}

class InitialState extends ProductStates {
  @override
  List<Object?> get props => [];
}

class ProductLoadingState extends ProductStates {
  @override
  List<Object?> get props => [];
}

class UploadedState extends ProductStates {
  @override
  List<Object?> get props => [];
}

class ProductUpdatingState extends ProductStates {
  final Product product;
  ProductUpdatingState({required this.product});
  @override
  List<Object?> get props => [product];
}

class UpdatedState extends ProductStates {
  @override
  List<Object?> get props => [];
}

class DeletedState extends ProductStates {
  @override
  List<Object?> get props => [];
}

class HomeLoadedState extends ProductStates {
  final int sales;
  final int orders;
  final int products;
  final int categories;
  final int? totalEarning;
  HomeLoadedState({
    required this.sales,
    required this.orders,
    required this.products,
    required this.categories,
    required this.totalEarning,
  });
  @override
  List<Object?> get props =>[sales,orders,products,categories,totalEarning];

}

class SalesLoadedState extends ProductStates {
  SalesLoadedState({required this.sales});
  final List<Sales> sales;
  @override
  List<Object?> get props => [sales];
}

class ImageLoadedState extends ProductStates {
  ImageLoadedState({required this.image});
  final XFile image;
  @override
  List<Object?> get props => [image];
}

class OrderLoadedState extends ProductStates {
  OrderLoadedState({required this.order});
  final List<Order> order;
  @override
  List<Object?> get props => [order];
}

class CategoryLoadedState extends ProductStates {
  final List<ProductCategory> category;
  CategoryLoadedState({required this.category});
  @override
  List<Object?> get props => [category];
}

class ProductLoadedState extends ProductStates {
  final List<Product> product;

  ProductLoadedState({required this.product});
  @override
  List<Object?> get props => [product];
}

class ErrorState extends ProductStates {
  final String error;
  ErrorState({required this.error});
  @override
  List<Object?> get props => [error];
}
