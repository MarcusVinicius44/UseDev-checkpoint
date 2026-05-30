import 'package:flutter/material.dart';
import 'package:usedev_uninassau/src/services/cart_service.dart';

class CustomAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final bool showBackButton;

  const CustomAppBarWidget({super.key, this.showBackButton = false});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back, size: 30),
              onPressed: () => Navigator.pop(context),
            )
          : const Icon(Icons.menu, size: 40),
      title: Image.asset('assets/logo_usedev.png', height: 40),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.person_outline, size: 30),
          onPressed: () {
            Navigator.pushNamed(context, '/login');
          },
        ),
        ListenableBuilder(
          listenable: CartService(),
          builder: (context, child) {
            // Alterado para contar apenas o número de itens (linhas) no carrinho
            final cartCount = CartService().items.length;
            return Stack(
              alignment: Alignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.shopping_cart_outlined, size: 30),
                  onPressed: () {
                    Navigator.pushNamed(context, '/cart');
                  },
                ),
                if (cartCount > 0)
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Text(
                        '$cartCount',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
        const SizedBox(width: 15),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
