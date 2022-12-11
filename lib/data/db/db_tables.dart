class DbTableNames {
  DbTableNames._();

  static const loginInfo = 'tb_login_info';

  static const userInfo = 'tb_user_info';
  static const shopInfo = 'tb_shop_info';
  static const foodInfo = 'tb_food_info';
  static const cartInfo = 'tb_cart_info';
  static const orderInfo = 'tb_order_info';
  static const orderItemInfo = 'tb_order_item_info';
}

class DbLoginInfoFields {
  DbLoginInfoFields._();

  static const id = 'id';
  static const username = 'username';
  static const password = 'password';
}

class DbUserInfoFields {
  DbUserInfoFields._();

  static const id = 'id';
  static const name = 'name';
  static const username = 'username';
  static const password = 'password';
}

class DbShopInfoFields {
  DbShopInfoFields._();

  static const id = 'id';
  static const name = 'name';
  static const title = 'title';
  static const banner = 'banner';
  static const time = 'time';
  static const rating = 'rating';
  static const comment = 'comment';
  static const distance = 'distance';
}

class DbFoodInfoFields {
  DbFoodInfoFields._();

  static const id = 'id';
  static const shopInfoId = 'shopInfoId';
  static const title = 'title';
  static const price = 'price';
  static const banner = 'banner';
  static const sold = 'sold';
  static const favorite = 'favorite';
  static const category = 'category';
}

class DbCartInfoFields {
  DbCartInfoFields._();

  static const id = 'id';
  static const userInfoId = 'user_info_id';
  static const foodInfoId = 'food_info_id';
  static const quantity = 'quantity';
  static const price = 'price';
  static const time = 'time';
  static const isActive = 'is_active';
}

class DbOrderInfoFields {
  DbOrderInfoFields._();

  static const id = 'id';
  static const userInfoId = 'user_info_id';
  static const shopInfoId = 'shop_info_id';
  static const time = 'time';
}

class DbOrderItemInfoFields {
  DbOrderItemInfoFields._();

  static const id = 'id';
  static const orderInfoId = 'order_info_id';
  static const foodInfoId = 'food_info_id';
  static const title = 'title';
  static const banner = 'banner';
  static const quantity = 'quantity';
  static const price = 'price';
}
