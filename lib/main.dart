import 'package:firebase/app/controllers/page_index_controller.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'app/routes/app_pages.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final pages = Get.put(PageIndexController(), permanent: true);
  runApp(
    StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Application",
          initialRoute: snapshot.data != null ? Routes.HOME : Routes.LOGIN,
          getPages: AppPages.routes,
          theme: ThemeData(fontFamily: GoogleFonts.poppins().fontFamily
              // Properti lain
              ),
        );
      },
    ),
  );
}
