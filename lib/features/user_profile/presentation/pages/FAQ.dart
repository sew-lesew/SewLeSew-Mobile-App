import 'package:flutter/material.dart';

import '../../../../config/theme/colors.dart';
import '../widgets/FAQ_section.dart';

class FAQ extends StatelessWidget {
  const FAQ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FAQs"),
      ),
      body: Container(
        // color: AppColors.primaryBackground,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            TextField(
              decoration: InputDecoration(
                // fillColor: AppColors.cardColor,
                filled: true,
                hintText: "How can I help you?",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            FAQSection(
              title: " GENERAL",
              faqItems: [
                FAQItem(
                  question: "Who can contribute to a fundraiser?",
                  answer:
                      "Anyone can contribute to a fundraiser, regardless of location or relation to the fundraiser.",
                ),
                FAQItem(
                  question: "How can I contribute to a fundraiser?",
                  answer:
                      "You can contribute by clicking the 'Donate' button and completing the payment process.",
                ),
                FAQItem(
                  question:
                      "What is the minimum I can contribute to a fundraiser?",
                  answer:
                      "The minimum contribution amount varies and is set by the fundraiser organizer.",
                ),
                FAQItem(
                  question: "Do I need to register to make a contribution?",
                  answer:
                      "No, you can contribute without registering. However, creating an account helps track your contributions.",
                ),
                FAQItem(
                  question: "Can I make a contribution anonymously?",
                  answer:
                      "Yes, you can choose to hide your name while making a contribution.",
                ),
                FAQItem(
                  question: "Why should I donate monthly?",
                  answer:
                      "Monthly donations provide consistent support and help fundraisers plan better.",
                ),
                FAQItem(
                  question: "How do I know where my donations go?",
                  answer:
                      "You can track your donation history and see updates from the fundraiser organizer.",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
