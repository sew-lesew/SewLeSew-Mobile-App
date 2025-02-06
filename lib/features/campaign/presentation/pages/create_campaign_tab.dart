import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../domain/entities/business_campaign_entity.dart';

class CreateCampaignTab extends StatefulWidget {
  const CreateCampaignTab({super.key});

  @override
  _CreateCampaignTabState createState() => _CreateCampaignTabState();
}

class _CreateCampaignTabState extends State<CreateCampaignTab> {
  final PageController _pageController = PageController();
  final _formKey = GlobalKey<FormState>();
  int _currentPage = 0;
  final List<Widget> _pages = [];

  final BusinessCampaignEntity _campaignData = BusinessCampaignEntity(
    fullName: '',
    contactEmail: '',
    contactPhoneNumber: '',
    region: '',
    city: '',
    title: '',
    goalAmount: 0,
    description: '',
    deadline: '',
    bankName: '',
    holderName: '',
    accountNumber: '',
    sector: '',
    tinNumber: '',
    licenseNumber: '',
    category: '',
  );

  @override
  void initState() {
    super.initState();
    _pages.addAll([
      _BasicInfoForm(campaignData: _campaignData),
      _LocationInfoForm(campaignData: _campaignData),
      _FinancialInfoForm(campaignData: _campaignData),
      _DocumentUploadForm(campaignData: _campaignData),
    ]);
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Submit logic here
      print(_campaignData);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Campaign Submitted Successfully')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _pages.length,
              itemBuilder: (context, index) => _pages[index],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_currentPage > 0)
                  ElevatedButton(
                    onPressed: () {
                      _pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                      setState(() => _currentPage--);
                    },
                    child: const Text('Back'),
                  ),
                if (_currentPage < _pages.length - 1)
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                        setState(() => _currentPage++);
                      }
                    },
                    child: const Text('Next'),
                  ),
                if (_currentPage == _pages.length - 1)
                  ElevatedButton(
                    onPressed: _submitForm,
                    child: const Text('Submit'),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Step 1: Basic Information
class _BasicInfoForm extends StatelessWidget {
  final BusinessCampaignEntity campaignData;

  const _BasicInfoForm({required this.campaignData});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            decoration: const InputDecoration(labelText: 'Full Name'),
            validator: (value) => value!.isEmpty ? 'Required' : null,
            onSaved: (value) => campaignData.fullName = value!,
          ),
          // Add similar fields for other basic info
          TextFormField(
            decoration: const InputDecoration(labelText: 'Campaign Title'),
            validator: (value) => value!.isEmpty ? 'Required' : null,
            onSaved: (value) => campaignData.title = value!,
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Description'),
            maxLines: 5,
            validator: (value) => value!.isEmpty ? 'Required' : null,
            onSaved: (value) => campaignData.description = value!,
          ),
        ],
      ),
    );
  }
}

// Step 2: Location Information
class _LocationInfoForm extends StatelessWidget {
  final BusinessCampaignEntity campaignData;

  const _LocationInfoForm({required this.campaignData});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(labelText: 'Region'),
            validator: (value) => value!.isEmpty ? 'Required' : null,
            onSaved: (value) => campaignData.region = value!,
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'City'),
            validator: (value) => value!.isEmpty ? 'Required' : null,
            onSaved: (value) => campaignData.city = value!,
          ),
        ],
      ),
    );
  }
}

// Step 3: Financial Information
class _FinancialInfoForm extends StatelessWidget {
  final BusinessCampaignEntity campaignData;

  const _FinancialInfoForm({required this.campaignData});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(labelText: 'Goal Amount (Birr)'),
            keyboardType: TextInputType.number,
            validator: (value) => value!.isEmpty ? 'Required' : null,
            onSaved: (value) => campaignData.goalAmount = double.parse(value!),
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Bank Name'),
            validator: (value) => value!.isEmpty ? 'Required' : null,
            onSaved: (value) => campaignData.bankName = value!,
          ),
        ],
      ),
    );
  }
}

// Step 4: Document Upload
class _DocumentUploadForm extends StatefulWidget {
  final BusinessCampaignEntity campaignData;

  const _DocumentUploadForm({required this.campaignData});

  @override
  __DocumentUploadFormState createState() => __DocumentUploadFormState();
}

class __DocumentUploadFormState extends State<_DocumentUploadForm> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickFile(File? file, Function(File?) setFile) async {
    final XFile? result = await _picker.pickImage(source: ImageSource.gallery);
    if (result != null) {
      setState(() => setFile(File(result.path)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _FileUploadButton(
            label: 'Upload TIN Certificate',
            onPressed: () => _pickFile(
              widget.campaignData.tinCertificate,
              (file) => widget.campaignData.tinCertificate = file,
            ),
          ),
          _FileUploadButton(
            label: 'Upload Logo',
            onPressed: () => _pickFile(
              widget.campaignData.logo,
              (file) => widget.campaignData.logo = file,
            ),
          ),
          // Add similar buttons for other files
        ],
      ),
    );
  }
}

class _FileUploadButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const _FileUploadButton({
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.upload_file),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
      ),
    );
  }
}
