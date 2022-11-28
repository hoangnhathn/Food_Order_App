class DbTableNames {
  DbTableNames._();

  static const loginInfo = 'tb_login_info';

  static const userInfo = 'tb_user_info';
  static const foodInfo = 'tb_food_info';
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
  static const username = 'username';
  static const password = 'password';
}

class DbFoodInfoFields {
  DbFoodInfoFields._();

  static const id = 'id';
  static const title = 'title';
  static const subTitle = 'subTitle';
  static const price = 'price';
  static const banner = 'banner';
  static const time = 'time';
  static const distance = 'distance';
  static const category = 'category';
}
