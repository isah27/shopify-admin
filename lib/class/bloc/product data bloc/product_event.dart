part of 'product_bloc.dart';

abstract class ProductEvents extends Equatable {}

class FetchProductEvent extends ProductEvents {
  @override
  List<Object?> get props => [];
}

class DeleteProductEvent extends ProductEvents {
  final Product product;

  DeleteProductEvent({required this.product});
  @override
  List<Object?> get props => [product];
}

class UpdateProductEvent extends ProductEvents {
  final Product product;
  UpdateProductEvent({required this.product});
  @override
  List<Object?> get props => [product];
}

class HomeLoadEvent extends ProductEvents {
  final String value;
  HomeLoadEvent({required this.value});
  @override
  List<Object?> get props => [value];
}

class ProductUpdatingProductEvent extends ProductEvents {
  final Product product;
  ProductUpdatingProductEvent({required this.product});
  @override
  List<Object?> get props => [product];
}

class UploadProductEvent extends ProductEvents {
  final Product product;
  final XFile image;
  UploadProductEvent({required this.product, required this.image});
  @override
  List<Object?> get props => [product, image];
}

class UploadCategoryEvent extends ProductEvents {
  final ProductCategory category;
  UploadCategoryEvent({required this.category});
  @override
  List<Object?> get props => [category];
}

// sales event start
class UploadSalesEvent extends ProductEvents {
  final Sales sales;
  UploadSalesEvent({required this.sales});
  @override
  List<Object?> get props => [sales];
}

class FetchSalesEvent extends ProductEvents {
  @override
  List<Object?> get props => [];
}

class UpdateSalesEvent extends ProductEvents {
  final Sales sales;
  UpdateSalesEvent({required this.sales});
  @override
  List<Object?> get props => [sales];
}

class DeleteSalesEvent extends ProductEvents {
  final String id;
  DeleteSalesEvent({required this.id});
  @override
  List<Object?> get props => [id];
}

// sales event end
class UploadOrderEvent extends ProductEvents {
  final Order order;
  UploadOrderEvent({required this.order});
  @override
  List<Object?> get props => [order];
}

class FetchOrderEvent extends ProductEvents {
  @override
  List<Object?> get props => [];
}

class FetchCategoryEvent extends ProductEvents {
  @override
  List<Object?> get props => [];
}

class DeleteCategoryEvent extends ProductEvents {
  final ProductCategory category;
  DeleteCategoryEvent({required this.category});
  @override
  List<Object?> get props => [category];
}

class PickImageEvent extends ProductEvents {
  @override
  List<Object?> get props => [];
}
