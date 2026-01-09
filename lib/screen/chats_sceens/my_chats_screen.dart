import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daleel_app_project/dependencies.dart';
import 'package:daleel_app_project/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'chat_screen.dart';

class MyChatsScreen extends StatelessWidget {
  const MyChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUserId = userController.user?.userId.toString() ?? '';
    final theme = Theme.of(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          AppLocalizations.of(context)!.myChats,
          style: theme.textTheme.titleLarge?.copyWith(
            color: theme.colorScheme.onPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.background,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('chats')
                .where('users', arrayContains: currentUserId)
                .orderBy('lastMessageTime', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: theme.colorScheme.onPrimary,
                  ),
                );
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.chat_bubble_outline,
                        size: 60,
                        color: theme.colorScheme.onPrimary.withOpacity(0.5),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        AppLocalizations.of(
                          context,
                        )!.noChatsYetExplorePropertiesToContactOwners,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onPrimary.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                );
              }

              final docs = snapshot.data!.docs;

              return ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                itemCount: docs.length,
                itemBuilder: (context, index) {
                  final data = docs[index].data() as Map<String, dynamic>;
                  final List<dynamic> users = data['users'] ?? [];
                  final String otherUserId = users.firstWhere(
                    (id) => id.toString() != currentUserId,
                    orElse: () => '',
                  );

                  if (otherUserId.isEmpty) return const SizedBox.shrink();

                  final Map<String, dynamic> names = Map<String, dynamic>.from(
                    data['userNames'] ?? {},
                  );
                  final String displayName =
                      names[otherUserId] ?? "User $otherUserId";

                  final Map<String, dynamic> images = Map<String, dynamic>.from(
                    data['userImages'] ?? {},
                  );
                  final String displayImage = images[otherUserId] ?? "";

                  final lastMessage = data['lastMessage'] ?? '';
                  final Timestamp? ts = data['lastMessageTime'];
                  String timeDisplay = ts != null
                      ? "${ts.toDate().hour}:${ts.toDate().minute.toString().padLeft(2, '0')}"
                      : "";

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.onBackground.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: theme.colorScheme.onBackground.withOpacity(0.1),
                      ),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      leading: CircleAvatar(
                        radius: 28,
                        backgroundColor: theme.colorScheme.onBackground
                            .withOpacity(0.3),
                        backgroundImage: displayImage.isNotEmpty
                            ? (displayImage.startsWith('http')
                                  ? NetworkImage(displayImage)
                                  : NetworkImage('$baseUrl$displayImage'))
                            : null,
                        child: displayImage.isEmpty
                            ? Text(
                                displayName.isNotEmpty
                                    ? displayName[0].toUpperCase()
                                    : "?",
                                style: theme.textTheme.titleMedium?.copyWith(
                                  color: theme.colorScheme.onPrimary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              )
                            : null,
                      ),
                      title: Text(
                        displayName,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onPrimary,
                        ),
                      ),
                      subtitle: Text(
                        lastMessage,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onPrimary.withOpacity(0.7),
                        ),
                      ),
                      trailing: Text(
                        timeDisplay,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onPrimary.withOpacity(0.6),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatScreen(
                              receiverId: otherUserId,
                              receiverName: displayName,
                              receiverImage: displayImage,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
