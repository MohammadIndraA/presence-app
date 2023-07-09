import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/detail_absensi_controller.dart';

class DetailAbsensiView extends GetView<DetailAbsensiController> {
  DetailAbsensiView({Key? key}) : super(key: key);
  final Map<String, dynamic> data = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('DetailAbsensiView'),
          centerTitle: true,
          backgroundColor: Colors.grey,
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey[200],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        DateFormat.yMMMMEEEEd()
                            .format(DateTime.parse(data['date'])),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 7),
                    Text(
                      'Masuk',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 7),
                    Text('Jam : ${DateTime.parse(data['masuk']['date'])}'),
                    Text(
                        'Posisi : ${data['masuk']['lat']} ${data['masuk']['long']}'),
                    Text('Status : ${data['masuk']['status']}'),
                    Text(
                        'Jarak : ${data['masuk']['distance'].toString().split('.').first} meter'),
                    SizedBox(height: 7),
                    Text(
                      'Keluar',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 7),
                    Text(data['keluar']?['date'] == null
                        ? "Jam : -"
                        : ' Jam :${DateFormat.jms().format(
                            DateTime.parse(
                              data['keluar']['date'],
                            ),
                          )}'),
                    Text(data['keluar']?['lat'] == null &&
                            data['keluar']?['long'] == null
                        ? "Posisi : -"
                        : 'Posisi : ${data['masuk']['lat']} ${data['masuk']['long']}'),
                    Text(data['keluar']?['status'] == null
                        ? 'Status : -'
                        : 'Status : ${data['keluar']!['status']}'),
                    Text(data['keluar']?['distance'] == null
                        ? 'Jrak : -'
                        : 'Jarak : ${data['keluar']!['distance'].toString().split('.').first} meter'),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
