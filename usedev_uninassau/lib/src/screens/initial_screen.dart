import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app/src/widgets/hero_section_widget.dart';
import 'package:app/src/widgets/product_card_widget.dart';
import 'package:app/src/widgets/subscription_section_widget.dart';
import 'home/home.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu, size: 40),
        centerTitle: true,
        title: InkWell(
          onTap: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
              (route) => false,
            );
          },
          child: Image.asset('assets/logo_usedev.png', height: 40),
        ),
        actions: const [
          Icon(Icons.person_outline, size: 40),
          SizedBox(width: 10),
          Icon(Icons.shopping_cart_outlined, size: 40),
          SizedBox(width: 25),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          spacing: 20,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const HeroSectionWidget(),
            Text(
              'Promos Especial',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                fontFamily: GoogleFonts.orbitron().fontFamily,
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) => ProductCardWidget(
                nome: 'Produce 0$index',
                url: 'https://placehold.co/600x600.png',
                preco: '10$index,00',
              ),
            ),
            const SubscriptionSectionWidget(),
          ],
        ),
      ),
    );
  }
}
