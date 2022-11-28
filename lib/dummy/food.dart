import '../data/model/db/db_food_info.dart';

final dummyPopularFoods = [
  /// Category 1 - Food
  DbFoodInfo(
    title: 'Tiên Nga Quán',
    subTitle: 'Phở, Cơm & Đồ Nhậu',
    banner:
        'https://images.foody.vn/res/g102/1013052/prof/s640x400/foody-upload-api-foody-mobile-7ae38dce47eebcb0e5ff-200318101643.jpg',
    price: 30000,
    time: 12,
    distance: 30,
    rating: 5,
    category: 1,
  ),
  DbFoodInfo(
    title: 'Đồ Ăn Vặt & Đồ Uống',
    subTitle: 'Hai Béo',
    banner:
        'https://images.foody.vn/res/g109/1085586/prof/s640x400/file_restaurant_photo_drej_16358-490cb345-211103042456.jpeg',
    price: 40000,
    time: 18,
    distance: 20,
    category: 1,
  ),
  DbFoodInfo(
    title: 'Dương Mập Quán',
    subTitle: 'Đồ Ăn Vặt & Hoa Quả Dầm',
    banner:
        'https://images.foody.vn/res/g26/257709/prof/s640x400/foody-upload-api-foody-mobile-untitled-1-jpg-181130143526.jpg',
    price: 25000,
    time: 16,
    distance: 10,
    category: 3,
  ),

  /// Category 2 - Drink
  DbFoodInfo(
    title: 'Phúc Long New Skyline',
    subTitle: 'Uống là mê',
    banner:
        'https://images.foody.vn/res/g98/979688/prof/s640x400/image-58a25fbb-221116184338.jpg',
    price: 45000,
    time: 15,
    distance: 20,
    rating: 5,
    category: 2,
  ),
  DbFoodInfo(
    title: 'YiHeTang',
    subTitle: 'Hai BéoĐệ Nhất Trà Sữa Nướng',
    banner:
        'https://images.foody.vn/res/g99/986863/prof/s640x400/foody-upload-api-foody-mobile-foody-upload-api-foo-191204154528.jpg',
    price: 35000,
    time: 18,
    distance: 20,
    category: 2,
  ),
  DbFoodInfo(
    title: 'The Alley',
    subTitle: 'Trà Sữa Đài Loan',
    banner:
        'https://images.foody.vn/res/g89/884783/prof/s640x400/foody-upload-api-foody-mobile-foody-upload-api-foo-190624100541.jpg',
    price: 60000,
    time: 19,
    distance: 18,
    category: 2,
  ),

  /// Category 3 - Vegetable
  DbFoodInfo(
    title: 'Rau Má Tươi Healthy',
    subTitle: 'Uống là mê',
    banner:
        'https://images.foody.vn/res/g93/925953/prof/s640x400/file_restaurant_photo_nmzq_16343-ac77edc4-211016221620.jpg',
    price: 20000,
    time: 15,
    distance: 20,
    rating: 5,
    category: 3,
  ),
  DbFoodInfo(
    title: 'Garden House',
    subTitle: 'Rau Má Mix',
    banner:
        'https://images.foody.vn/res/g115/1147983/prof/s640x400/foody-upload-api-foody-mobile-fo-c468dde8-220817160707.jpeg',
    price: 40000,
    time: 30,
    distance: 30,
    category: 3,
  ),
  DbFoodInfo(
    title: 'Rau Má Lá',
    subTitle: 'Nước Dừa & Sữa Đậu Nành',
    banner:
        'https://images.foody.vn/res/g104/1037842/prof/s640x400/file_restaurant_photo_4r0b_16391-fb4bdb62-211210091742.jpeg',
    price: 35000,
    time: 20,
    distance: 15,
    category: 3,
  ),

  /// Category 4 - Burger
  DbFoodInfo(
    title: 'Burger, Gà',
    subTitle: 'Lotteria - Hà Đông CoopMart',
    banner:
        'https://images.foody.vn/res/g4/35883/prof/s640x400/image-50810771-210614102958.jpeg',
    price: 88000,
    time: 10,
    distance: 5,
    rating: 5,
    category: 4,
  ),
  DbFoodInfo(
    title: 'Pizza Hut',
    subTitle: 'Thế mới ngon',
    banner:
        'https://images.foody.vn/res/g12/110368/prof/s640x400/image-001466b2-221101150609.jpg',
    price: 350000,
    time: 25,
    distance: 16,
    category: 4,
  ),
  DbFoodInfo(
    title: 'Gà rán và Mì Ý',
    subTitle: 'Jollibee',
    banner:
        'https://images.foody.vn/res/g4/36599/prof/s640x400/foody-mobile-5879-jpg-659-636341506916365805.jpg',
    price: 44000,
    time: 21,
    distance: 15,
    category: 4,
  ),

  /// Category 5 - Cake
  DbFoodInfo(
    title: 'Luna Bakery',
    subTitle: 'Shop Online',
    banner:
        'https://images.foody.vn/res/g105/1042755/prof/s640x400/foody-upload-api-foody-mobile-320-200817175402.jpg',
    price: 100000,
    time: 35,
    distance: 14,
    rating: 4,
    category: 5,
  ),
  DbFoodInfo(
    title: 'TOUS les JOURS',
    subTitle: 'Machinco Trần Phú',
    banner:
        'https://images.foody.vn/res/g75/745151/prof/s640x400/image-847ce222-210409141455.jpeg',
    price: 550000,
    time: 36,
    distance: 10,
    category: 5,
  ),
  DbFoodInfo(
    title: 'Chang Cake',
    subTitle: 'Shop Online',
    banner:
        'https://images.foody.vn/res/g74/735149/prof/s640x400/foody-upload-api-foody-mobile-1-jpg-180423095022.jpg',
    price: 110000,
    time: 28,
    distance: 12,
    category: 5,
  ),

  /// Category 6 - Pho
  DbFoodInfo(
    title: 'Bún Hải Sản 2S',
    subTitle: 'Phở, bún miễn chê',
    banner:
        'https://images.foody.vn/res/g68/678697/prof/s640x400/foody-upload-api-foody-mobile-z3-6b85ec0f-220808152410.jpeg',
    price: 50000,
    time: 15,
    distance: 10,
    rating: 5,
    category: 6,
  ),
  DbFoodInfo(
    title: 'Bún Chả, Cua, Ốc, Cá, Mọc',
    subTitle: 'Bún chả số 1',
    banner:
        'https://images.foody.vn/res/g102/1019046/prof/s640x400/foody-upload-api-foody-mobile-1-200413161429.jpg',
    price: 40000,
    time: 16,
    distance: 8,
    category: 6,
  ),
  DbFoodInfo(
    title: 'Bún Riêu Cá Trường Sa',
    subTitle: 'Shop Online',
    banner:
        'https://images.foody.vn/res/g67/662591/prof/s640x400/foody-mobile-1608-jpg-468-636317403932216398.jpg',
    price: 30000,
    time: 25,
    distance: 11,
    category: 6,
  ),

  /// Category 7 - Vegetarian Food
  DbFoodInfo(
    title: 'Peace Vegan',
    subTitle: 'Buffet Chay & Đồ Uống',
    banner:
        'https://images.foody.vn/res/g103/1028629/prof/s640x400/file_restaurant_photo_sj2z_16256-a3cdbe5d-210707162158.jpeg',
    price: 200000,
    time: 14,
    distance: 8,
    rating: 5,
    category: 7,
  ),
  DbFoodInfo(
    title: 'Cơm Chay An Vui',
    subTitle: 'Đồ Chay Tuệ Lâm',
    banner:
        'https://images.foody.vn/res/g115/1149341/prof/s640x400/file_restaurant_photo_kjm5_16641-45f93a41-220925201640.jpg',
    price: 75000,
    time: 12,
    distance: 18,
    category: 7,
  ),
  DbFoodInfo(
    title: 'Chay Phúc Nguyên Hưng',
    subTitle: 'Đồ chay cực đỉnh',
    banner:
        'https://images.foody.vn/res/g97/960747/prof/s640x400/file_restaurant_photo_gr6o_16322-99b91fd7-210922091957.jpg',
    price: 100000,
    time: 20,
    distance: 16,
    category: 7,
  ),

  /// Category 8 - Rice
  DbFoodInfo(
    title: 'XOI FOOD',
    subTitle: 'Buffet Chay & Đồ UốngXôi Nếp Nương & Cơm Văn Phòng',
    banner:
        'https://images.foody.vn/res/g96/959478/prof/s640x400/file_restaurant_photo_azcv_16188-193caed1-210419110858.jpeg',
    price: 30000,
    time: 20,
    distance: 6,
    rating: 5,
    category: 8,
  ),
  DbFoodInfo(
    title: 'Cơm Ngon Mẹ Nấu',
    subTitle: 'Cơm ngon văn phòng',
    banner:
        'https://images.foody.vn/res/g107/1066834/prof/s640x400/foody-upload-api-foody-mobile-image-5f06df9e-20091-210222115219.jpeg',
    price: 40000,
    time: 15,
    distance: 16,
    category: 7,
  ),
  DbFoodInfo(
    title: 'Cơm Thố Anh Nguyễn ',
    subTitle: 'Cơm Thố số 1',
    banner:
        'https://images.foody.vn/res/g106/1056668/prof/s640x400/file_restaurant_photo_rnuw_16140-7092944b-210223175632.jpeg',
    price: 200000,
    time: 16,
    distance: 5,
    category: 7,
  )
];

final dummyRecommendFoods = [
  DbFoodInfo(
    title: 'Bánh Gà & Chè - Chính Kinh',
    subTitle: 'Chén Cả Thế Giới',
    banner:
        'https://images.foody.vn/res/g100/992832/prof/s640x400/image-77ee2c72-200910115815.jpeg',
    price: 15000,
    time: 15,
    distance: 20,
    category: 1,
  ),
  DbFoodInfo(
    title: 'Mì Trộn Indomie Online',
    subTitle: 'Đức Food - Kim Giang',
    banner:
        'https://images.foody.vn/res/g103/1024850/prof/s640x400/foody-upload-api-foody-mobile-mif1-200811103546.jpg',
    price: 32000,
    time: 20,
    distance: 30,
    category: 2,
  ),
  DbFoodInfo(
    title: 'Family Chicken',
    subTitle: 'Gà Rán, Bánh Gà & Đồ Ăn Vặt',
    banner:
        'https://images.foody.vn/res/g100002/1000012378/prof/s640x400/file_restaurant_photo_wnh1_16217-295629e0-210523024335.jpeg',
    price: 60000,
    time: 30,
    distance: 10,
    category: 3,
  )
];
