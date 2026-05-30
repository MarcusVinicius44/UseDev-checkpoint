import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SubscriptionSectionWidget extends StatelessWidget {
  const SubscriptionSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Seção Verde (Newsletter)
        Container(
          width: double.infinity,
          color: const Color(0xFF8FFF24),
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
          child: Column(
            children: [
              Text(
                'Inscreva-se para ganhar descontos!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: GoogleFonts.orbitron().fontFamily,
                  color: const Color(0xFF0D0D2B),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Cadastre seu email, receba novidades e descontos imperdíveis antes de todo mundo!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  color: const Color(0xFF0D0D2B),
                ),
              ),
              const SizedBox(height: 25),
              Container(
                constraints: const BoxConstraints(maxWidth: 500),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: Colors.black, width: 1),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Digite seu melhor endereço de email',
                            hintStyle: TextStyle(
                              fontFamily: GoogleFonts.poppins().fontFamily,
                              fontSize: 14,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF780BF7),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        child: const Text('Inscrever', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Seção Escura (Links e Info)
        Container(
          width: double.infinity,
          color: const Color(0xFF0D0D2B),
          padding: const EdgeInsets.all(40),
          child: Column(
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  return Wrap(
                    spacing: 40,
                    runSpacing: 40,
                    alignment: WrapAlignment.center,
                    children: [
                      // Logo
                      SizedBox(
                        width: 200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset('assets/logo_usedev.png', height: 40, color: const Color(0xFF8FFF24)),
                            const SizedBox(height: 10),
                            const Text(
                              'Hora de abraçar seu lado geek!',
                              style: TextStyle(color: Color(0xFF8FFF24), fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      _buildFooterColumn('Funcionamento', [
                        'Segunda a Sexta - 8h às 18h',
                        'sac@usedev.com.br',
                        '0800 541 320',
                      ]),
                      _buildFooterColumn('Institucional', [
                        'Sobre nós',
                        'Contato',
                        'Política de Privacidade',
                        'LGPD - Lei de proteção de dados',
                      ]),
                      _buildFooterColumn('Informações', [
                        'Entregas',
                        'Garantia',
                        'Trocas e devoluções',
                      ]),
                    ],
                  );
                },
              ),
              const SizedBox(height: 40),
              const Divider(color: Colors.white24),
              const SizedBox(height: 20),
              Wrap(
                spacing: 40,
                runSpacing: 20,
                alignment: WrapAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Formas de Pagamento', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          _buildPaymentIcon(Icons.credit_card),
                          const SizedBox(width: 8),
                          _buildPaymentIcon(Icons.payments),
                          const SizedBox(width: 8),
                          _buildPaymentIcon(Icons.qr_code),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Siga nossas redes:', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.chat_bubble_outline, color: Colors.purple[300], size: 28),
                          const SizedBox(width: 15),
                          Icon(Icons.camera_alt_outlined, color: Colors.purple[300], size: 28),
                          const SizedBox(width: 15),
                          Icon(Icons.music_note_outlined, color: Colors.purple[300], size: 28),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFooterColumn(String title, List<String> items) {
    return SizedBox(
      width: 180,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 15),
          ...items.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(item, style: const TextStyle(color: Colors.white70, fontSize: 13)),
              )),
        ],
      ),
    );
  }

  Widget _buildPaymentIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Icon(icon, color: Colors.white, size: 20),
    );
  }
}
