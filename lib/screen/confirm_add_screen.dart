
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void showConfirmationSheet({
  required BuildContext context,
  required Function(File contractImage) onConfirm,
}) {
  File? contractImage; 

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
    ),
    builder: (ctx) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setModalState) {
          Future<void> pickContractImage() async {
            final image = await ImagePicker().pickImage(source: ImageSource.gallery);
            if (image == null) return;
            setModalState(() {
              contractImage = File(image.path);
            });
          }

          return SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 20,
              right: 20,
              top: 20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Text(
                  'Confirm Submission',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.grey[850],
                  ),
                ),
                const SizedBox(height: 12),
              
                Text(
                  'Your submission will be sent to the admin for approval. Please attach a clear image of the house contract to expedite the process.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[600], fontSize: 15, height: 1.4),
                ),
                const SizedBox(height: 24),
              
                GestureDetector(
                  onTap: pickContractImage,
                  child: Container(
                    height: 160,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.grey[300]!, width: 1.5),
                      image: contractImage != null
                          ? DecorationImage(
                              image: FileImage(contractImage!),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: contractImage == null
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.document_scanner_outlined, color: Colors.grey[700], size: 45),
                                const SizedBox(height: 10),
                                Text('Tap to add contract image', style: TextStyle(color: Colors.grey[800])),
                              ],
                            ),
                          )
                        : Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              icon: const Icon(Icons.cancel, color: Colors.white, size: 28),
                              onPressed: () => setModalState(() => contractImage = null),
                              style: IconButton.styleFrom(backgroundColor: Colors.black.withOpacity(0.5)),
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 30),
                
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(ctx),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.grey[800],
                          side: BorderSide(color: Colors.grey[400]!),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        ),
                        child: const Text('Cancel', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (contractImage == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('House contract image is required.'),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          }
    
                          Navigator.pop(ctx);
                          onConfirm(contractImage!);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF795548),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        ),
                        child: const Text('Confirm & Submit', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      );
    },
  );
}
