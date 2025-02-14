import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sewlesew_fund/features/campaign/domain/entities/business_campaign_entity.dart';
import 'upload_card.dart';

class DocumentUploadsPage extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final BusinessCampaignEntity campaignData;
  final String campaignType;

  const DocumentUploadsPage({
    super.key,
    required this.formKey,
    required this.campaignData,
    required this.campaignType,
  });

  @override
  State<DocumentUploadsPage> createState() => _DocumentUploadsPageState();
}

class _DocumentUploadsPageState extends State<DocumentUploadsPage> {
  String? _tinCertificateName;
  String? _registrationLicenseName;
  String? _logoName;
  String? _coverImageName;
  String? _supportingDocumentsName;
  String? _otherImagesName;
  String? _personalDocumentName;

  Future<File?> _pickDocument(List<String>? allowedExtensions) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: allowedExtensions,
    );
    if (result != null) {
      return File(result.files.single.path!);
    }
    return null;
  }

  Future<File?> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return File(pickedFile.path); // Convert XFile to File
    }
    return null;
  }

  Future<List<File>?> _pickMultipleFiles() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result != null) {
      return result.paths.map((path) => File(path!)).toList();
    }
    return null;
  }

  Future<List<File>?> _pickMultipleImages() async {
    final pickedFiles = await ImagePicker().pickMultiImage();
    return pickedFiles
        .map((xFile) => File(xFile.path))
        .toList(); // Convert XFile to File
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: widget.formKey,
        child: Card.outlined(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // make a condition for only Business for the two below upload card
                if (widget.campaignType == 'Business') ...[
                  UploadCard(
                    icon: Icons.description,
                    label: 'TIN Certificate',
                    fileName: _tinCertificateName,
                    onPressed: () async {
                      final file = await _pickDocument(
                          ['pdf', 'doc', 'docx', 'jpg', 'jpeg', 'png']);
                      if (file != null) {
                        setState(() {
                          widget.campaignData.tinCertificate = file;
                          _tinCertificateName = file.path.split('/').last;
                        });
                      }
                    },
                  ),
                  UploadCard(
                    icon: Icons.assignment,
                    label: 'Registration License',
                    fileName: _registrationLicenseName,
                    onPressed: () async {
                      final file = await _pickDocument(
                          ['pdf', 'doc', 'docx', 'jpg', 'jpeg', 'png']);
                      if (file != null) {
                        setState(() {
                          widget.campaignData.registrationLicense = file;
                          _registrationLicenseName = file.path.split('/').last;
                        });
                      }
                    },
                  ),
                ],

                // for both campaign type for Business and Organizational for the logo
                if (widget.campaignType == 'Business' ||
                    widget.campaignType == 'Organizational') ...[
                  UploadCard(
                    icon: Icons.image,
                    label: 'Logo',
                    fileName: _logoName,
                    onPressed: () async {
                      final file = await _pickImage();
                      if (file != null) {
                        setState(() {
                          widget.campaignData.logo = file;
                          _logoName = file.path.split('/').last;
                        });
                      }
                    },
                  ),
                ],
                // for only personal campaign type
                if (widget.campaignType == 'Personal') ...[
                  UploadCard(
                    icon: Icons.description,
                    label: 'Personal Document',
                    fileName: _personalDocumentName,
                    onPressed: () async {
                      final file = await _pickDocument(
                          ['jpg', 'jpeg', 'png', 'pdf', 'doc', 'docx']);
                      if (file != null) {
                        setState(() {
                          widget.campaignData.personalDocuments = file;
                          _personalDocumentName =
                              '${file.length} files selected';
                        });
                      }
                    },
                  ),
                ],

                UploadCard(
                  icon: Icons.photo,
                  label: 'Cover Image',
                  fileName: _coverImageName,
                  onPressed: () async {
                    final file = await _pickImage();
                    if (file != null) {
                      setState(() {
                        widget.campaignData.coverImage = file;
                        _coverImageName = file.path.split('/').last;
                      });
                    }
                  },
                ),
                UploadCard(
                  icon: Icons.folder,
                  label: 'Supporting Documents',
                  fileName: _supportingDocumentsName,
                  onPressed: () async {
                    final files = await _pickMultipleFiles();
                    if (files != null) {
                      setState(() {
                        widget.campaignData.supportingDocuments = files;
                        _supportingDocumentsName =
                            '${files.length} files selected';
                      });
                    }
                  },
                ),
                UploadCard(
                  icon: Icons.photo_library,
                  label: 'Other Images',
                  fileName: _otherImagesName,
                  onPressed: () async {
                    final images = await _pickMultipleImages();
                    if (images != null) {
                      setState(() {
                        widget.campaignData.otherImages = images;
                        _otherImagesName = '${images.length} images selected';
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
