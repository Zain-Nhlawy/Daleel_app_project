import 'package:daleel_app_project/cubit/apartment%20cubit/apartments_cubit.dart';
import 'package:daleel_app_project/cubit/apartment%20cubit/apartments_state.dart';
import 'package:daleel_app_project/dependencies.dart';
import 'package:daleel_app_project/l10n/app_localizations.dart';
import 'package:daleel_app_project/models/user.dart';
import 'package:daleel_app_project/widget/apartment_widgets/nearpy_apartments_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHousesScreen extends StatefulWidget {
  const MyHousesScreen({super.key});

  @override
  State<MyHousesScreen> createState() => _FavoriteApartmentsScreenState();
}

class _FavoriteApartmentsScreenState extends State<MyHousesScreen> {
  final User? user = userController.user;

  @override
  void initState() {
    super.initState();
    context.read<ApartmentsCubit>().loadMyApartments(user!.userId);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.myHouses,
          style: textTheme.titleLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
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
          child: BlocBuilder<ApartmentsCubit, ApartmentState>(
            builder: (context, state) {
              if (state is ApartmentLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    color: colorScheme.onPrimary,
                  ),
                );
              } else if (state is ApartmentError) {
                return Center(
                  child: Text(
                    AppLocalizations.of(context)!.anErrorOccurred,
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.error,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              } else if (state is ApartmentLoaded) {
                final apartments = state.apartments;
                return ListView.builder(
                  padding: const EdgeInsets.only(bottom: 12),
                  itemCount: apartments.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      child: NearpyApartmentsWidgets(
                        apartment: apartments[index],
                      ),
                    );
                  },
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
