import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String message;
  final String imagePath; // Path to the image to show in the dialog
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const ConfirmationDialog({
    super.key,
    required this.title,
    required this.message,
    required this.imagePath,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Close Button
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.black,
                  child: Icon(Icons.close, color: Colors.white, size: 16),
                ),
              ),
            ),
            // Image
            Image.asset(
              imagePath,
              height: 100,
            ),
            SizedBox(height: 16),
            // Title
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            // Message
            Text(
              message,
              style: TextStyle(fontSize: 14),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Confirm Button
                ElevatedButton(
                  onPressed: onConfirm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text("Yes"),
                ),
                // Cancel Button
                ElevatedButton(
                  onPressed: onCancel,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text("No"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void showConfirmationDialog(BuildContext context, String title, String message,
    String imagePath, VoidCallback onConfirm) {
  showDialog(
    context: context,
    builder: (context) => ConfirmationDialog(
      title: title,
      message: message,
      imagePath: imagePath,
      onConfirm: onConfirm,
      onCancel: () {
        Navigator.of(context).pop(); // Close dialog on cancel
      },
    ),
  );
}

// Example: Log Out
void showLogOutDialog(BuildContext context) {
  showConfirmationDialog(
    context,
    "Are you sure you want to log out?",
    "You will need to log in again to access your account.",
    "assets/icons/logout1.png", // Provide the path to your logout image
    () {
      // Log out logic
      Navigator.of(context).pop(); // Close dialog
    },
  );
}

// Example: Deactivate Account
void showDeactivateAccountDialog(BuildContext context) {
  showConfirmationDialog(
    context,
    "Are you sure you want to delete your account?",
    "All your account data will be permanently removed.",
    "assets/icons/delete_account.png", // Provide the path to your deactivate image
    () {
      // Deactivate account logic
      Navigator.of(context).pop(); // Close dialog
    },
  );
}
