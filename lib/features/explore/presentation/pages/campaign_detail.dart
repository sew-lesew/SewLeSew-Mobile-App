import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:unity_fund/config/theme/colors.dart';
import 'package:unity_fund/features/authentication/presentation/widgets/common_widgets.dart';

class CampaignDetailScreen extends StatelessWidget {
  final List<String> images = [
    'assets/welcome/welcome1.png',
    'assets/welcome/welcome2.png',
    'assets/welcome/welcome3.png',
  ];

  final List<Map<String, String>> documents = [
    {"title": "Document 1", "image": 'assets/welcome/welcome3.png'},
    {"title": "Document 2", "image": 'assets/welcome/welcome2.png'},
    {"title": "Document 3", "image": 'assets/welcome/welcome1.png'},
  ];

  CampaignDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarLarge("Campaign Details"),
      body: Container(
        color: AppColors.primaryBackground,
        child: DefaultTabController(
          length: 2, // Number of tabs: Story and Documents
          child: Column(
            children: [
              // Campaign Image Section
              Stack(
                children: [
                  SizedBox(
                    height: 250,
                    child: PageView.builder(
                      itemCount: images.length,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          images[index],
                          fit: BoxFit.cover,
                          width: double.infinity,
                        );
                      },
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 20,
                    child: GestureDetector(
                      onTap: () {
                        Share.share("Check out this campaign:\n\n"
                            "Title: Campaign Detail\n"
                            "Creator: Titus\n\n"
                            "Description: Campaign Description\n\n"
                            "Donate now to support this campaign");
                      },
                      child: CircleAvatar(
                        backgroundColor: AppColors.primaryBackground,
                        child: Icon(
                          Icons.share,
                          color: AppColors.accentColor.withOpacity(0.5),
                          size: 28,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // Campaigner and Donor Section
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    const Icon(Icons.campaign,
                        color: AppColors.accentColor, size: 24),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Campaigner",
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                          const Text(
                            "Titus Titus",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Add logic for clickable donors
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text("Donors"),
                            content: const Text(
                                "Here you can show a list or details about the donors."),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("Close"),
                              ),
                            ],
                          ),
                        );
                      },
                      child: Row(
                        children: const [
                          Icon(Icons.people, color: Colors.grey, size: 20),
                          SizedBox(width: 4),
                          Text(
                            "257 Donors",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Donate and Share Buttons
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Add donation logic here
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Center(
                        child: Text(
                          "Donate Now",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),

              // TabBar for Story and Documents
              const TabBar(
                labelColor: AppColors.accentColor,
                unselectedLabelColor: Colors.grey,
                indicatorColor: AppColors.accentColor,
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
                tabs: [
                  Tab(text: "Story"),
                  Tab(text: "Documents"),
                ],
              ),

              // TabBarView for Story and Document Sections
              Expanded(
                child: TabBarView(
                  children: [
                    // Story Section
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Story",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.accentColor,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "This is the story section where the purpose of the campaign, "
                              "background details, and any other information can be shared.",
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Documents Section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          SizedBox(
                            height: 120,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: documents.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    // Add document viewing logic here
                                  },
                                  child: Container(
                                    width: 100,
                                    margin: const EdgeInsets.only(right: 12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Image.asset(
                                            documents[index]["image"]!,
                                            width: 100,
                                            height: 80,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          documents[index]["title"]!,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.black87,
                                          ),
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
