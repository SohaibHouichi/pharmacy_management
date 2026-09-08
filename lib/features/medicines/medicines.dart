/// Public surface of the medicines feature.
/// Data layer stays internal — other features must not reach into it.
library;

export 'domain/entity/category_entity.dart';
export 'domain/entity/medicine_params.dart';
export 'domain/entity/medicine_status_x.dart';
export 'domain/entity/medicines_entity.dart';
export 'domain/repository/medicines_repository.dart';
export 'domain/usecase/add_medicine.dart';
export 'domain/usecase/delete_medicine.dart';
export 'domain/usecase/get_categories.dart';
export 'domain/usecase/get_medicine_by_id.dart';
export 'domain/usecase/get_medicines.dart';
export 'domain/usecase/update_medicine.dart';

export 'presentation/bindings/medicines_binding.dart';
export 'presentation/bindings/medicine_form_binding.dart';
export 'presentation/bindings/medicine_detail_binding.dart';
export 'presentation/controllers/medicines_controller.dart';
export 'presentation/pages/medicines_page.dart';
export 'presentation/pages/medicine_form_page.dart';
export 'presentation/pages/medicine_detail_page.dart';
export 'presentation/widgets/medicine_tile.dart';