import 'package:app/src/widgets/searchbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../screens/auth/login_screen.dart';
import '../screens/cart/cart.dart';
import '../screens/home/home.dart';
import '../services/cart_service.dart';

class Navbar extends StatelessWidget {
  final ValueChanged<String>? onSearch;
  const Navbar({super.key, this.onSearch});

  @override
  Widget build(BuildContext context) {
    const double iconSize = 32.0;
    const Color primaryColor = Color(0xFFFF55DF);

    return Column(
      children: [
        Container(
          color: Colors.white,
          padding: const EdgeInsets.fromLTRB(8, 40, 8, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {}, // TODO: Implement Drawer
                icon: const Icon(Icons.menu, size: iconSize, color: Colors.black),
              ),
              // Logo centralizada e clicável
              GestureDetector(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const HomePage()),
                    (route) => false,
                  );
                },
                child: Image.asset(
                  'assets/logo_usedev.png',
                  height: 40,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const LoginScreen(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.person_outline,
                      size: iconSize,
                      color: Colors.black,
                    ),
                  ),
                  ListenableBuilder(
                    listenable: CartService(),
                    builder: (context, _) {
                      final count = CartService().itemCount;
                      return Badge(
                        label: Text('$count'),
                        isLabelVisible: count > 0,
                        backgroundColor: primaryColor,
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const CartPage(),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.shopping_cart_outlined,
                            size: iconSize,
                            color: Colors.black,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        Searchbar(onSearch: onSearch),
      ],
    );
  }
}
