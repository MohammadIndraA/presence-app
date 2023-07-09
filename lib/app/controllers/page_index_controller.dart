import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;

class PageIndexController extends GetxController {
  RxBool isLoading = false.obs;
  RxInt index = 0.obs;
  double? latKantor;
  double? longKantor;
  void changePage(int i) async {
    print("index ke = $i");
    switch (i) {
      case 1:
        index.value = i;
        Get.offAllNamed(Routes.KARYAWAN);
        break;
      case 2:
        print('ABSENSI');
        Map<String, dynamic> dataResponse = await determinePosition();
        if (dataResponse != null) {
          Position position = dataResponse['position'];
          // List<Placemark> placemarks = await placemarkFromCoordinates(
          //     position.latitude, position.longitude);
          // String addres =

          //     "${placemarks[0].name}, ${placemarks[0].subLocality} , ${placemarks[0].locality}";
          // await getIdKantor(latKantor, longKantor);
          await updatePosisi(position);
          // posisi
          CollectionReference kantor = firestore.collection('kantor');
          CollectionReference<Map<String, dynamic>> btId =
              firestore.collection('kantor');
          QuerySnapshot<Map<String, dynamic>> jumlah = await btId.get();
          // print(latKantor);
          // print(longKantor);
          print(" lat :${jumlah.docs.first['lat']}");
          print(" long :${jumlah.docs.first['long']}");
          if (jumlah.docs.first['lat'] != null &&
              jumlah.docs.first['long'] != null) {
            double distance = Geolocator.distanceBetween(
                jumlah.docs.first['lat']!,
                jumlah.docs.first['long']!,
                position.latitude,
                position.longitude);
            await presensi(position, distance);

            Get.snackbar("Succesfull", "${dataResponse['message']}");
          } else {
            Get.snackbar("Error", "Tidak dapat meneukakn lokasi kantor");
          }
          // print(placemarks);
        } else {
          Get.snackbar("Error", "${dataResponse['message']}");
        }
        break;
      case 3:
        index.value = i;
        Get.offAllNamed(Routes.KANTOR);
        // Position posisi = await getPosisiKantor();
        // print(posisi);
        // latKantor = posisi.latitude;
        // longKantor = posisi.longitude;
        break;
      case 4:
        index.value = i;
        Get.offAllNamed(Routes.PROFILE);
        break;
      default:
        Get.offAllNamed(Routes.HOME);
    }
  }

  Future<void> presensi(Position position, double distance) async {
    String uid = auth.currentUser!.uid;

    CollectionReference<Map<String, dynamic>> colReference =
        firestore.collection('pegawai').doc(uid).collection('presence');

    QuerySnapshot<Map<String, dynamic>> snapPresence = await colReference.get();

    DateTime now = DateTime.now();

    String todayIdDoc = DateFormat.yMd().format(now).replaceAll('/', '-');
    String status = "Di Luar jangakouan area";
    if (distance <= 50) {
      String status = "Di Luar dalalm area";
    }
    if (snapPresence.docs.length == 0) {
      await Get.defaultDialog(
        title: 'Confirmation',
        middleText: 'Absen Masuk?',
        cancel: TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('CANCEL'),
        ),
        confirm: ElevatedButton(
          onPressed: () async {
            if (distance >= 51) {
              Get.back();
              Get.snackbar('Warning!',
                  'Maaf anda diluar radius, barada ${distance} meter');
            } else {
              await colReference.doc(todayIdDoc).set({
                "date": now.toIso8601String(),
                "masuk": {
                  'date': now.toIso8601String(),
                  'lat': position.latitude,
                  'long': position.longitude,
                  'status': status,
                  'distance': distance,
                },
              });
              Get.back();
              Get.snackbar('Succesfull', 'Terimaksih sudah absen masuk');
            }
          },
          child: const Text('YES'),
        ),
      );
    } else {
      //
      DocumentSnapshot<Map<String, dynamic>> todayId =
          await colReference.doc(todayIdDoc).get();

      if (todayId.exists == true) {
        Map<String, dynamic>? dataPresenToday = todayId.data();
        if (dataPresenToday?['keluar'] != null) {
          Get.snackbar(
              'Warning', 'Anda telah absen keluar dan masuk Terimakasih');
        } else {
          await Get.defaultDialog(
            title: 'Confirmation',
            middleText: 'Absen Pulang?',
            cancel: TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('CANCEL'),
            ),
            confirm: ElevatedButton(
              onPressed: () async {
                if (distance >= 51) {
                  Get.back();
                  Get.snackbar('Warning!',
                      'Maaf anda diluar radius, barada ${distance} meter');
                } else {
                  await colReference.doc(todayIdDoc).update({
                    "keluar": {
                      'date': now.toIso8601String(),
                      'lat': position.latitude,
                      'long': position.longitude,
                      'status': status,
                      'distance': distance,
                    },
                  });
                  Get.back();
                  Get.snackbar('Succesfull', 'Terimaksih sudah absen Keluar');
                }
              },
              child: const Text('YES'),
            ),
          );
        }
      } else {
        // absen masuk
        await Get.defaultDialog(
          title: 'Confirmation',
          middleText: 'Absen Masuk?',
          cancel: TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('CANCEL'),
          ),
          confirm: ElevatedButton(
            onPressed: () async {
              if (distance >= 51) {
                Get.back();
                Get.snackbar('Warning!',
                    'Maaf anda diluar radius, barada ${distance} meter');
              } else {
                await colReference.doc(todayIdDoc).set({
                  "date": now.toIso8601String(),
                  "masuk": {
                    'date': now.toIso8601String(),
                    'lat': position.latitude,
                    'long': position.longitude,
                    'status': status,
                    'distance': distance,
                  },
                });
                Get.back();
                Get.snackbar('Succesfull', 'Terimaksih sudah absen masuk');
              }
            },
            child: const Text('YES'),
          ),
        );
      }
    }
  }

  Future<void> updatePosisi(Position position) async {
    String uid = auth.currentUser!.uid;
    await firestore.collection('pegawai').doc(uid).update({
      'position': {
        'lat': position.latitude,
        'long': position.longitude,
      },
    });
  }

  Future<Map<String, dynamic>> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return {
        'message': 'Tidak Dapat mengambil lokasi',
        'error': true,
      };
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return {
          'message': 'Izin lokasi Gps di tolak',
          'error': true,
        };
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return {
        'message': 'Settingan device menolak akses lokasi',
        'error': true,
      };
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position position = await Geolocator.getCurrentPosition();
    return {
      'position': position,
      'message': 'berhasil mendapatkan posisi',
      'error': false,
    };
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> getPosisiKantor() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  void UpdateLokasiKantor(String id) async {
    isLoading.value = true;

    Position posisi = await getPosisiKantor();
    latKantor = posisi.latitude;
    longKantor = posisi.longitude;
    DateTime date = DateTime.now();
    CollectionReference kantor = firestore.collection('kantor');
    CollectionReference<Map<String, dynamic>> btId =
        firestore.collection('kantor');
    QuerySnapshot<Map<String, dynamic>> jumlah = await btId.get();
    print(" lat kantor ini : ${jumlah.docs.first['lat']}");
    if (jumlah.docs.length == 0) {
      try {
        await btId.doc(id).set({
          'date': date.toIso8601String(),
          'lat': latKantor,
          'long': longKantor,
        });
        await getIdKantor();
        Get.snackbar('success', 'Berhasil Tambah posisi kantor');
      } catch (e) {
        Get.snackbar('error', 'Gagal Update posisi kantor');
      } finally {
        isLoading.value = false;
      }
    } else {
      try {
        await btId.doc(id).update({
          'date': date.toIso8601String(),
          'lat': latKantor,
          'long': longKantor,
        });
        await getIdKantor();
        Get.snackbar('success', 'Berhasil Update posisi kantor');
      } catch (e) {
        Get.snackbar('error', 'Gagal Update posisi kantor');
      } finally {
        isLoading.value = false;
      }
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getIdKantor() async {
    return firestore
        .collection('kantor')
        .orderBy('date', descending: true)
        .limit(1)
        .get();
  }
}
