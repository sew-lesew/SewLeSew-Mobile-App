// lib/features/campaign/presentation/widgets/document_uploads_page.dart
import 'package:flutter/material.dart';
import 'upload_card.dart';

class DocumentUploadsPage extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  const DocumentUploadsPage({
    super.key,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Form(
        key: formKey,
        child: Card.outlined(
          child: Column(
            children: [
              UploadCard(
                icon: Icons.description,
                label: 'TIN Certificate',
                onPressed: () {
                  // Handle TIN certificate upload
                },
              ),
              UploadCard(
                icon: Icons.assignment,
                label: 'Registration License',
                onPressed: () {
                  // Handle registration license upload
                },
              ),
              UploadCard(
                icon: Icons.image,
                label: 'Logo',
                onPressed: () {
                  // Handle logo upload
                },
              ),
              UploadCard(
                icon: Icons.photo,
                label: 'Cover Image',
                onPressed: () {
                  // Handle cover image upload
                },
              ),
              UploadCard(
                icon: Icons.folder,
                label: 'Supporting Documents',
                onPressed: () {
                  // Handle supporting documents upload
                },
              ),
              UploadCard(
                icon: Icons.photo_library,
                label: 'Other Images',
                onPressed: () {
                  // Handle other images upload
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
