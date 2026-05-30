import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:usedev_uninassau/src/models/product_model.dart';
import 'package:usedev_uninassau/src/services/cart_service.dart';
import 'package:usedev_uninassau/src/widgets/main_layout_widget.dart';
import 'package:usedev_uninassau/src/widgets/custom_dropdown_widget.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  String _selectedColor = 'Bege';
  String _quantity = '1';
  String _selectedSize = 'M';

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      showBackButton: true, // Garante que o botão de voltar apareça
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                widget.product.image,
                height: 300,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 30),
            Text(
              widget.product.title,
              style: TextStyle(
                fontFamily: GoogleFonts.orbitron().fontFamily,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.share_outlined, color: Colors.purple, size: 30),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                const SizedBox(width: 20),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.favorite_border, color: Colors.purple, size: 30),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              widget.product.description,
              style: TextStyle(
                fontFamily: GoogleFonts.poppins().fontFamily,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              'R\$ ${widget.product.price.toStringAsFixed(2).replaceAll('.', ',')}',
              style: TextStyle(
                fontFamily: GoogleFonts.orbitron().fontFamily,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 25),
            Text(
              'Escolha a cor do tecido',
              style: TextStyle(
                fontFamily: GoogleFonts.poppins().fontFamily,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            _buildColorOption('Bege'),
            _buildColorOption('Branca'),
            _buildColorOption('Cinza'),
            const SizedBox(height: 25),
            CustomDropdownWidget(
              label: 'Quantidade',
              value: _quantity,
              items: ['1', '2', '3', '4', '5'],
              onChanged: (val) => setState(() => _quantity = val),
            ),
            const SizedBox(height: 15),
            CustomDropdownWidget(
              label: 'Tamanho',
              value: _selectedSize,
              items: ['PP', 'P', 'M', 'G', 'GG'],
              onChanged: (val) => setState(() => _selectedSize = val),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  CartService().addItem(
                    widget.product,
                    size: _selectedSize,
                    color: _selectedColor,
                    quantity: int.parse(_quantity),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${widget.product.title} ($_selectedSize, $_selectedColor) adicionado ao carrinho!'),
                    ),
                  );
                },
                icon: const Icon(Icons.shopping_cart_outlined),
                label: const Text('Adicionar ao carrinho'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF780BF7),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  textStyle: TextStyle(
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildColorOption(String color) {
    return RadioListTile<String>(
      title: Text(color, style: const TextStyle(fontSize: 16)),
      value: color,
      groupValue: _selectedColor,
      onChanged: (val) => setState(() => _selectedColor = val!),
      contentPadding: EdgeInsets.zero,
      visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
      activeColor: Colors.purple,
    );
  }
}
