import 'package:get/get.dart';

import '../modules/add_karyawan/bindings/add_karyawan_binding.dart';
import '../modules/add_karyawan/views/add_karyawan_view.dart';
import '../modules/add_pegawai/bindings/add_pegawai_binding.dart';
import '../modules/add_pegawai/views/add_pegawai_view.dart';
import '../modules/detail_absensi/bindings/detail_absensi_binding.dart';
import '../modules/detail_absensi/views/detail_absensi_view.dart';
import '../modules/edit_karyawan/bindings/edit_karyawan_binding.dart';
import '../modules/edit_karyawan/views/edit_karyawan_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/kantor/bindings/kantor_binding.dart';
import '../modules/kantor/views/kantor_view.dart';
import '../modules/karyawan/bindings/karyawan_binding.dart';
import '../modules/karyawan/views/karyawan_view.dart';
import '../modules/karyawan_search/bindings/karyawan_search_binding.dart';
import '../modules/karyawan_search/views/karyawan_search_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/new_password/bindings/new_password_binding.dart';
import '../modules/new_password/views/new_password_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/resetPassword/bindings/reset_password_binding.dart';
import '../modules/resetPassword/views/reset_password_view.dart';
import '../modules/semua_absensi/bindings/semua_absensi_binding.dart';
import '../modules/semua_absensi/views/semua_absensi_view.dart';
import '../modules/update_password/bindings/update_password_binding.dart';
import '../modules/update_password/views/update_password_view.dart';
import '../modules/update_profile/bindings/update_profile_binding.dart';
import '../modules/update_profile/views/update_profile_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.ADD_PEGAWAI,
      page: () => const AddPegawaiView(),
      binding: AddPegawaiBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.RESET_PASSWORD,
      page: () => ResetPasswordView(),
      binding: ResetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.NEW_PASSWORD,
      page: () => const NewPasswordView(),
      binding: NewPasswordBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.UPDATE_PROFILE,
      page: () => UpdateProfileView(),
      binding: UpdateProfileBinding(),
    ),
    GetPage(
      name: _Paths.UPDATE_PASSWORD,
      page: () => const UpdatePasswordView(),
      binding: UpdatePasswordBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_ABSENSI,
      page: () => DetailAbsensiView(),
      binding: DetailAbsensiBinding(),
    ),
    GetPage(
      name: _Paths.SEMUA_ABSENSI,
      page: () => const SemuaAbsensiView(),
      binding: SemuaAbsensiBinding(),
    ),
    GetPage(
      name: _Paths.KANTOR,
      page: () => KantorView(),
      binding: KantorBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.KARYAWAN,
      page: () => KaryawanView(),
      binding: KaryawanBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.ADD_KARYAWAN,
      page: () => const AddKaryawanView(),
      binding: AddKaryawanBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_KARYAWAN,
      page: () => const EditKaryawanView(),
      binding: EditKaryawanBinding(),
    ),
    GetPage(
      name: _Paths.KARYAWAN_SEARCH,
      page: () => const KaryawanSearchView(),
      binding: KaryawanSearchBinding(),
    ),
  ];
}
