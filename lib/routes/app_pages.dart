import 'package:eq_tech_practical/routes/app_routes.dart';
import 'package:eq_tech_practical/view/categories/categories_screen.dart';
import 'package:eq_tech_practical/view/companies/companies_screen.dart';
import 'package:eq_tech_practical/view/home_screen.dart';
import 'package:eq_tech_practical/view/product/add_product_screen.dart';
import 'package:eq_tech_practical/view/product/product_details_screen.dart';
import 'package:eq_tech_practical/view/product/products_screen.dart';
import 'package:get/get.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.homeScreen,
      page: () => HomeScreen(),
    ),
    GetPage(
      name: AppRoutes.productsScreen,
      page: () => ProductsScreen(),
    ),
    GetPage(
      name: AppRoutes.addProductScreen,
      page: () => AddProductScreen(),
    ),
    GetPage(
      name: AppRoutes.productDetailScreen,
      page: () =>  ProductDetailScreen(),
    ),
    GetPage(
      name: AppRoutes.manageCategoryScreen,
      page: () => CategoriesScreen(),
    ),
    GetPage(
      name: AppRoutes.manageCompanyScreen,
      page: () => CompaniesScreen(),
    ),
  ];
}
