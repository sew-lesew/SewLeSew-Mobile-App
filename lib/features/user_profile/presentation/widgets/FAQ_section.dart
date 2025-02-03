import 'package:flutter/material.dart';

import 'package:sewlesew_fund/features/donations/presentation/widgets/donation_widgets.dart';

class FAQSection extends StatelessWidget {
  final String title;
  final List<FAQItem> faqItems;

  const FAQSection({
    super.key,
    required this.title,
    required this.faqItems,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        lineWithText(text: title, context: context),
        SizedBox(height: 8),
        ...faqItems.map((item) => FAQItemWidget(item: item)),
      ],
    );
  }
}

class FAQItem {
  final String question;
  final String answer;

  FAQItem({required this.question, required this.answer});
}

class FAQItemWidget extends StatefulWidget {
  final FAQItem item;

  const FAQItemWidget({super.key, required this.item});

  @override
  State<FAQItemWidget> createState() => _FAQItemWidgetState();
}

class _FAQItemWidgetState extends State<FAQItemWidget> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          // color: AppColors.cardColor,
          child: ListTile(
            title: Text(
              widget.item.question,
              style: TextStyle(fontSize: 16),
            ),
            trailing: Icon(
              isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
            ),
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
          ),
        ),
        if (isExpanded)
          Card(
            // color: AppColors.cardColor,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                widget.item.answer,
                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
              ),
            ),
          ),
        Divider(height: 1, color: Colors.grey[300]),
      ],
    );
  }
}
