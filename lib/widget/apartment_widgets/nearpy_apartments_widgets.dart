import 'package:daleel_app_project/models/apartments.dart';
import 'package:flutter/material.dart';

class NearpyApartmentsWidgets extends StatelessWidget {
  const NearpyApartmentsWidgets({super.key, required this.apartment});

  final Apartments apartment;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {},
        child: SizedBox(
          height: 130,
          child: Row(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
                child: Image.asset(
                  apartment.apartmentPicture,
                  width: 150,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        apartment.apartmentHeadDescripton,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),

                      Text(
                        apartment.apartmentCountry,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),

                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.orange,
                            size: 18,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            apartment.apartmentRate.toString(),
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 10),
            ],
          ),
        ),
      ),
    );
  }
}
