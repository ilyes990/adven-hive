import 'package:get/get.dart';
import '../core/adventure_repo_implmnt.dart';

void setupLocator() {
  // Register repository as singleton using GetX
  Get.lazyPut<AdventureRepository>(
    () => AdventureRepositoryImpl(),
  );
}
