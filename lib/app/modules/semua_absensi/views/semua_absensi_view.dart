import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../controllers/semua_absensi_controller.dart';

class SemuaAbsensiView extends GetView<SemuaAbsensiController> {
  const SemuaAbsensiView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SemuaAbsensiView'),
        centerTitle: true,
        backgroundColor: Colors.grey,
      ),
      body: GetBuilder<SemuaAbsensiController>(
        builder: (c) {
          return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
            future: c.getSemuaData(),
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.black87,
                  ),
                );
              }
              if (snap.data?.docs.length == 0 || snap.data == null) {
                return Container(
                  height: 150,
                  child: const Center(
                    child: Text('Tidak ada data'),
                  ),
                );
              }
              print(snap.data!.docs.length);
              return ListView.builder(
                itemCount: snap.data!.docs.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> data = snap.data!.docs[index].data();
                  return Padding(
                    padding: const EdgeInsets.only(
                        top: 10, left: 10, right: 10, bottom: 3),
                    child: Material(
                      color: Colors.grey[200],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: InkWell(
                        onTap: () {
                          Get.toNamed(Routes.DETAIL_ABSENSI, arguments: data);
                        },
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          margin: EdgeInsets.all(6),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Masuk',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    data['masuk']?['date'] == null
                                        ? "-"
                                        : DateFormat.yMMMEd().format(
                                            DateTime.parse(
                                                data['masuk']['date'])),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Text(DateFormat.jms().format(DateTime.now())),
                              const SizedBox(height: 4),
                              const Text(
                                'Keluar',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(data['keluar']?['date'] == null
                                  ? "-"
                                  : DateFormat.jms().format(
                                      DateTime.parse(data['keluar']['date']))),
                              const SizedBox(height: 5),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.dialog(
            Dialog(
              child: Container(
                padding: EdgeInsets.all(20),
                height: 400,
                child: SfDateRangePicker(
                  monthViewSettings:
                      DateRangePickerMonthViewSettings(firstDayOfWeek: 1),
                  selectionMode: DateRangePickerSelectionMode.range,
                  showActionButtons: true,
                  onCancel: () => Get.back(),
                  onSubmit: (obj) {
                    if (obj != null) {
                      if ((obj as PickerDateRange).endDate != null) {
                        controller.pickDate(obj.startDate!, obj.endDate!);
                        Get.back();
                      }
                    }
                  },
                ),
              ),
            ),
          );
        },
        backgroundColor: Colors.grey,
        child: Icon(Icons.format_list_bulleted_outlined),
      ),
    );
  }
}
