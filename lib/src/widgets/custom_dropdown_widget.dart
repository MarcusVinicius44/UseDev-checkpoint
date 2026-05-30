import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDropdownWidget extends StatefulWidget {
  final String label;
  final String value;
  final List<String> items;
  final Function(String) onChanged;

  const CustomDropdownWidget({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  State<CustomDropdownWidget> createState() => _CustomDropdownWidgetState();
}

class _CustomDropdownWidgetState extends State<CustomDropdownWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1.5),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () => setState(() => _isExpanded = !_isExpanded),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              decoration: BoxDecoration(
                borderRadius: _isExpanded 
                    ? const BorderRadius.vertical(top: Radius.circular(25))
                    : BorderRadius.circular(25),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      _isExpanded ? widget.label : (widget.value.isNotEmpty ? widget.value : widget.label),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: GoogleFonts.poppins().fontFamily,
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: const Color(0xFF0D0D2B),
                      ),
                    ),
                  ),
                  Icon(
                    _isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                    color: Colors.black,
                    size: 30,
                  ),
                ],
              ),
            ),
          ),
          if (_isExpanded) ...[
            const Divider(height: 1.5, color: Colors.black, thickness: 1.5),
            ...widget.items.map((item) => GestureDetector(
                  onTap: () {
                    widget.onChanged(item);
                    setState(() => _isExpanded = false);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: Center(
                      child: Text(
                        item,
                        style: TextStyle(
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                )),
            const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }
}
