import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/db/db_cart_info.dart';
import '../repository/authentication_repository/authentication_repository.dart';
import '../repository/cart_repository/cart_repository.dart';

final cartProvider = StateNotifierProvider<CartProvider, List<DbCartInfo>>(
  (ref) => CartProvider(
    cartRepository: CartRepository(ref),
    authenticationRepository: AuthenticationRepository(ref),
    reader: ref,
  ),
);

class CartProvider extends StateNotifier<List<DbCartInfo>> {
  CartProvider({
    required this.authenticationRepository,
    required this.cartRepository,
    required this.reader,
  }) : super([]);

  final AuthenticationRepository authenticationRepository;

  final CartRepository cartRepository;

  final Ref reader;

  Future<void> init() async {
    final currentUserId = await getCurrentUserId();
    final carts = await cartRepository.getCartsByUser(currentUserId ?? 1);
    state = carts;
  }

  Future<int?> getCurrentUserId() async {
    final currentUserId = await authenticationRepository.getCurrentUserId();
    return currentUserId;
  }

  Future<void> addToCart(DbCartInfo cart) async {
    final currentUserId = await getCurrentUserId();

    final cartAdd = cart.copyWith(
      userInfoId: currentUserId,
    );

    print('Cart Add $cartAdd');

    try {
     await cartRepository.addCart(cartAdd);

      /// Update
      await init();
    } catch (e) {
      print(e);
    }
  }
}
