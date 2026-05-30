import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:usedev_uninassau/src/services/cart_service.dart';
import 'package:usedev_uninassau/src/services/auth_service.dart';
import 'package:usedev_uninassau/src/widgets/main_layout_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  void _checkout(BuildContext context) async {
    final authService = AuthService();
    final isLoggedIn = await authService.isLoggedIn();

    if (!context.mounted) return;

    if (!isLoggedIn) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Acesso Bloqueado'),
          content: const Text('Você precisa estar logado para finalizar a compra.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('CANCELAR'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/login');
              },
              child: const Text('LOGIN'),
            ),
          ],
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pedido realizado com sucesso!')),
      );
      CartService().clearCart();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      showBackButton: true,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: ListenableBuilder(
          listenable: CartService(),
          builder: (context, child) {
            final cart = CartService();

            return Column(
              children: [
                Text(
                  'Carrinho de Compras',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    fontFamily: GoogleFonts.orbitron().fontFamily,
                    color: const Color(0xFF0D0D2B),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F0F5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.info_outline, size: 20),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Atenção, os produtos no carrinho não ficam reservados. Finalize a compra para garantir! :)',
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                LayoutBuilder(
                  builder: (context, constraints) {
                    bool isWide = constraints.maxWidth > 900;
                    return Wrap(
                      spacing: 30,
                      runSpacing: 30,
                      children: [
                        // Detalhes da Compra
                        SizedBox(
                          width: isWide ? constraints.maxWidth * 0.6 : constraints.maxWidth,
                          child: _buildPurchaseDetails(cart),
                        ),
                        // Sumário
                        SizedBox(
                          width: isWide ? constraints.maxWidth * 0.35 : constraints.maxWidth,
                          child: _buildSummary(context, cart),
                        ),
                      ],
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildPurchaseDetails(CartService cart) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Detalhes da compra',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: GoogleFonts.poppins().fontFamily,
            ),
          ),
          const SizedBox(height: 20),
          if (cart.items.isEmpty)
            const Center(child: Text('Seu carrinho está vazio.'))
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: cart.items.length,
              separatorBuilder: (context, index) => const Divider(height: 40),
              itemBuilder: (context, index) {
                final item = cart.items[index];
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.network(item.product.image, width: 60, height: 60, fit: BoxFit.contain),
                    const SizedBox(width: 15),
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.product.title,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            'Cor: ${item.selectedColor} | Tam: ${item.selectedSize}',
                            style: const TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 1,
                      child: Text(
                        'R\$ ${item.product.price.toStringAsFixed(0)}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    const SizedBox(width: 15),
                    _buildQuantitySelector(cart, item),
                    const SizedBox(width: 15),
                    IconButton(
                      icon: const Icon(Icons.delete_outline, color: Color(0xFF0D0D2B)),
                      onPressed: () => cart.removeItem(item.product.id, item.selectedSize, item.selectedColor),
                    ),
                  ],
                );
              },
            ),
        ],
      ),
    );
  }

  Widget _buildQuantitySelector(CartService cart, item) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildCircleButton(Icons.remove, () => cart.decrementQuantity(item.product.id, item.selectedSize, item.selectedColor)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text('${item.quantity}'),
        ),
        _buildCircleButton(Icons.add, () => cart.incrementQuantity(item.product.id, item.selectedSize, item.selectedColor)),
      ],
    );
  }

  Widget _buildCircleButton(IconData icon, VoidCallback onPressed) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.black26),
      ),
      child: InkWell(
        onTap: onPressed,
        child: Icon(icon, size: 18),
      ),
    );
  }

  Widget _buildSummary(BuildContext context, CartService cart) {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Sumário',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 25),
          _buildSummaryField('Cupom de desconto'),
          const SizedBox(height: 15),
          _buildSummaryField('Frete'),
          const SizedBox(height: 30),
          const Divider(),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${cart.items.length.toString().padLeft(2, '0')} Produtos'),
              Text('R\$ ${cart.totalValue.toStringAsFixed(0)}'),
            ],
          ),
          const SizedBox(height: 10),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Frete'),
              Text('R\$ 8'),
            ],
          ),
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Total:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.purple)),
              Text(
                'R\$ ${(cart.totalValue + 8).toStringAsFixed(0)}',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.purple),
              ),
            ],
          ),
          const SizedBox(height: 40),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => Navigator.pop(context),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFF780BF7)),
                foregroundColor: const Color(0xFF780BF7),
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
              ),
              child: const Text('Continuar comprando', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _checkout(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF780BF7),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
              ),
              child: const Text('Ir para pagamento', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryField(String hint) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Digite o cupom',
              labelText: hint,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            ),
          ),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF780BF7),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          ),
          child: const Text('Ok'),
        ),
      ],
    );
  }
}
