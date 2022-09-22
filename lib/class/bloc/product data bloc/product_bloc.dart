import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopify_admin/class/model/models.dart';
import 'package:shopify_admin/class/repository/product%20repository/product_repo.dart';
part 'product_event.dart';
part 'product_state.dart';

class ShopifyProductBloc extends Bloc<ProductEvents, ProductStates> {
  final ProductRepository _productRepository;
  ShopifyProductBloc(this._productRepository) : super(InitialState()) {
    on<HomeLoadEvent>(_onHomeLoadEvent);
    on<FetchProductEvent>(_onFetchProductEvent);
    on<DeleteProductEvent>(_onDeleteProductEvent);
    on<UpdateProductEvent>(_onUpdateProductEvent);
    on<UploadProductEvent>(_onUploadProductEvent);
    on<ProductUpdatingProductEvent>(_onUpdatingProductEvent);
    on<PickImageEvent>(_onPickImageEvent);
    on<UploadCategoryEvent>(_onUploadCategoryEvent);
    on<FetchCategoryEvent>(_onFetchCategoryEvent);
    on<DeleteCategoryEvent>(_onDeleteCategoryEvent);
    on<UploadSalesEvent>(_onUploadSalesEvent);
    on<FetchSalesEvent>(_onFetchSalesEvent);
    on<FetchOrderEvent>(_onFetchOrderEvent);
    on<UploadOrderEvent>(_onUploadOrderEvent);
  }

  late List<ProductCategory> categories;
  late List<Order> orders;
  late List<Product> products;
  late List<Sales> sales;
  late List<int?> totalEarning;
  void _onHomeLoadEvent(
      HomeLoadEvent event, Emitter<ProductStates> emit) async {
    emit(ProductLoadingState());
    switch (event.value) {
      case "sales":
        try {
          sales = await _productRepository.fetchSales();
          emit(HomeLoadedState(
              sales: sales.length,
              orders: orders.length,
              products: products.length,
              categories: categories.length,
              totalEarning:
                  totalEarning.reduce((value, newVal) => value! + newVal!)));
        } on FirebaseException catch (e) {
          emit(ErrorState(error: e.code));
        }
        break;
      case "orders":
        try {
          orders = await _productRepository.fetchOrders();
          emit(HomeLoadedState(
              sales: sales.length,
              orders: orders.length,
              products: products.length,
              categories: categories.length,
              totalEarning:
                  totalEarning.fold(0, (value, newVal) => value! + newVal!)));
        } on FirebaseException catch (e) {
          emit(ErrorState(error: e.code));
        }
        break;
      case "products":
        try {
          products = await _productRepository.fetchProduct();
          emit(HomeLoadedState(
              sales: sales.length,
              orders: orders.length,
              products: products.length,
              categories: categories.length,
              totalEarning:
                  totalEarning.reduce((value, newVal) => value! + newVal!)));
        } on FirebaseException catch (e) {
          emit(ErrorState(error: e.code));
        }
        break;
      case "setting":
        break;
      case "category":
        try {
          categories = await _productRepository.fetchCategory();
          emit(HomeLoadedState(
              sales: sales.length,
              orders: orders.length,
              products: products.length,
              categories: categories.length,
              totalEarning:
                  totalEarning.reduce((value, newVal) => value! + newVal!)));
        } on FirebaseException catch (e) {
          emit(ErrorState(error: e.code));
        }
        break;

      default:
        try {
          categories = await _productRepository.fetchCategory();

          orders = await _productRepository.fetchOrders();

          products = await _productRepository.fetchProduct();

          sales = await _productRepository.fetchSales();
          totalEarning = await _productRepository.totalEarning();

          emit(HomeLoadedState(
              sales: sales.length,
              orders: orders.length,
              products: products.length,
              categories: categories.length,
              totalEarning:
                  totalEarning.reduce((value, newVal) => value! + newVal!)));
        } on FirebaseException catch (e) {
          emit(ErrorState(error: e.code));
        }
    }
  }

// Product evetn function begin
  void _onFetchProductEvent(
      FetchProductEvent event, Emitter<ProductStates> emit) async {
    emit(ProductLoadingState());
    try {
      final product = await _productRepository.fetchProduct();
      emit(ProductLoadedState(product: product));
    } on FirebaseException catch (e) {
      emit(ErrorState(error: e.code));
    }
  }

  void _onDeleteProductEvent(
      DeleteProductEvent event, Emitter<ProductStates> emit) async {
    emit(ProductLoadingState());
    try {
      await _productRepository.deleteProduct(product: event.product);
      emit(DeletedState());
    } on FirebaseException catch (e) {
      emit(ErrorState(error: e.code));
    }
  }

  void _onUpdatingProductEvent(
      ProductUpdatingProductEvent event, Emitter<ProductStates> emit) {
    emit(ProductUpdatingState(product: event.product));
  }

  void _onUpdateProductEvent(
      UpdateProductEvent event, Emitter<ProductStates> emit) async {
    emit(ProductLoadingState());
    try {
      await _productRepository.updateProduct(product: event.product);
      emit(UpdatedState());
    } on FirebaseException catch (e) {
      emit(ErrorState(error: e.code));
    }
  }

  void _onUploadProductEvent(
      UploadProductEvent event, Emitter<ProductStates> emit) async {
    emit(ProductLoadingState());
    try {
      await _productRepository.uploadProduct(
          product: event.product, image: event.image);
      emit(UploadedState());
    } on FirebaseException catch (e) {
      emit(ErrorState(error: e.code));
    }
  }

  void _onPickImageEvent(
      PickImageEvent event, Emitter<ProductStates> emit) async {
    emit(ProductLoadingState());
    try {
      final image = await _productRepository.pickImage();
      emit(ImageLoadedState(image: image));
    } catch (e) {
      emit(ErrorState(error: e.toString()));
    }
  }
// Product evetn function end

//  Category evetn function begin
  void _onUploadCategoryEvent(
      UploadCategoryEvent event, Emitter<ProductStates> emit) async {
    emit(ProductLoadingState());
    try {
      await _productRepository.uploadCategory(event.category);
      emit(UploadedState());
    } on FirebaseException catch (e) {
      emit(ErrorState(error: e.code));
    }
  }

  void _onFetchCategoryEvent(
      FetchCategoryEvent event, Emitter<ProductStates> emit) async {
    emit(ProductLoadingState());
    try {
      final category = await _productRepository.fetchCategory();
      emit(CategoryLoadedState(category: category));
    } on FirebaseException catch (e) {
      emit(ErrorState(error: e.code));
    }
  }

  void _onDeleteCategoryEvent(
      DeleteCategoryEvent event, Emitter<ProductStates> emit) async {
    emit(ProductLoadingState());
    try {
      await _productRepository.deleteCategory(event.category);
      emit(DeletedState());
    } on FirebaseException catch (e) {
      emit(ErrorState(error: e.code));
    }
  }
//  Category evetn function end

//  Sales evetn function begin
  void _onUploadSalesEvent(
      UploadSalesEvent event, Emitter<ProductStates> emit) async {
    emit(ProductLoadingState());
    try {
      await _productRepository.uploadSalesProduct(sales: event.sales);
      emit(UploadedState());
    } on FirebaseException catch (e) {
      emit(ErrorState(error: e.code));
    }
  }

  void _onFetchSalesEvent(
      FetchSalesEvent event, Emitter<ProductStates> emit) async {
    emit(ProductLoadingState());
    try {
      final sales = await _productRepository.fetchSales();
      emit(SalesLoadedState(sales: sales));
    } on FirebaseException catch (e) {
      emit(ErrorState(error: e.code));
    }
  }
//  Sales evetn function end

//  Order evetn function begin
  void _onUploadOrderEvent(
      UploadOrderEvent event, Emitter<ProductStates> emit) async {
    emit(ProductLoadingState());
    try {
      await _productRepository.uploadOrder(order: event.order);
      emit(UploadedState());
    } on FirebaseException catch (e) {
      emit(ErrorState(error: e.code));
    }
  }

  void _onFetchOrderEvent(
      FetchOrderEvent event, Emitter<ProductStates> emit) async {
    emit(ProductLoadingState());
    try {
      final orders = await _productRepository.fetchOrders();
      emit(OrderLoadedState(order: orders));
    } on FirebaseException catch (e) {
      emit(ErrorState(error: e.code));
    }
  }
//  Order evetn function end
}
