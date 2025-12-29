import 'package:daleel_app_project/l10n/app_localizations.dart';
import 'package:daleel_app_project/screen/home_screen/filters_screen.dart';
import 'package:daleel_app_project/screen/home_screen/notifications_screen.dart';
import 'package:daleel_app_project/screen/home_screen/search_screen.dart';
import 'package:daleel_app_project/widget/apartment_widgets/close_to_you_apartments_widget.dart';
import 'package:daleel_app_project/widget/apartment_widgets/highly_rated_apartmant_widget.dart';
import 'package:flutter/material.dart';

import '../../dependencies.dart';
import '../../models/user.dart';
import '../../widget/apartment_widgets/most_popular_apartments_widget copy.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    final User? user = userController.user;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: (user != null && user.profileImage.isNotEmpty)
                  ? NetworkImage(baseUrl + user.profileImage)
                  : const AssetImage('assets/images/user.png') as ImageProvider,
            ),
            const SizedBox(width: 15),
            Text(
              user != null
                  ? '${user.firstName} ${user.lastName}'
                  : '${AppLocalizations.of(context)!.welcome}!',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const NotificationsScreen()),
              );
            },
            icon: const Icon(
              Icons.notifications_outlined,
              color: Colors.white,
              size: 32,
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.background,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          controller: _controller,
          child: SafeArea(
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.black.withOpacity(0.15),
                    ),
                    height: 50,
                    child: Row(
                      children: [
                        const SizedBox(width: 20),
                        const Icon(
                          Icons.search,
                          size: 28,
                          color: Colors.white70,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            style: const TextStyle(color: Colors.white),
                            textInputAction: TextInputAction.search,
                            onSubmitted: (value) {
                              if (value.trim().isEmpty) return;

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => SearchScreen(search: value),
                                ),
                              );
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText:
                                  '${AppLocalizations.of(context)!.searchHere}...',
                              hintStyle: const TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                              elevation: 5,
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (context) => FilterBottomSheetContent(),
                            );
                          },
                          icon: Icon(
                            Icons.format_list_bulleted_rounded,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.mostPopular,
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      TextButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          overlayColor: WidgetStateProperty.all(
                            Colors.transparent,
                          ),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.seeAll,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: Colors.white70),
                        ),
                      ),
                    ],
                  ),
                ),
              MostPopularApartmentsWidget(),
                const SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    AppLocalizations.of(context)!.highlyRated,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                HighlyRatedApartmentsList(),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    AppLocalizations.of(context)!.closeToYou,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                CloseToYouApartmentsWidget(controller: _controller),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
