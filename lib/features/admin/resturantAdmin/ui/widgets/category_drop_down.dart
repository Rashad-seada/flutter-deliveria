import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CategoryDropDown extends StatefulWidget {
  CategoryDropDown({
    super.key,
    required this.categories,
    this.selectedCategory, required this.showCategoryDropdown,
  });
  final List<String> categories;
  String? selectedCategory;
   bool showCategoryDropdown;

  @override
  State<CategoryDropDown> createState() => _CategoryDropDownState();
}

class _CategoryDropDownState extends State<CategoryDropDown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children:
            widget.categories.map((category) {
              bool isSelected = widget.selectedCategory == category;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    widget.selectedCategory = category;
                    widget.showCategoryDropdown = false;
                  });
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey[200]!,
                        width: category != widget.categories.last ? 1 : 0,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        category,
                        style: TextStyle(
                          color:
                              isSelected
                                  ? const Color(0xFFD32F2F)
                                  : Colors.black87,
                          fontSize: 14,
                        ),
                      ),
                      if (isSelected)
                        const Icon(
                          Icons.check,
                          color: Color(0xFFD32F2F),
                          size: 20,
                        ),
                    ],
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }
}
