import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:usedev_uninassau/src/models/product_model.dart';
import 'package:usedev_uninassau/src/screens/initial_screen.dart';
import 'package:usedev_uninassau/src/screens/cart_screen.dart';
import 'package:usedev_uninassau/src/screens/login_screen.dart';
import 'package:usedev_uninassau/src/screens/product_details_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UseDev Store',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.black,
          primary: Colors.black,
        ),
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        if (settings.name == '/product-details') {
          final product = settings.arguments as Product;
          return MaterialPageRoute(
            builder: (context) => ProductDetailsScreen(product: product),
          );
        }
        return null;
      },
      routes: {
        '/': (context) => const InitialScreen(),
        '/cart': (context) => const CartScreen(),
        '/login': (context) => const LoginScreen(),
      },
    );
  }
}
