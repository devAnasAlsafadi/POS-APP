import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../domain/entities/location_entity.dart';
import '../blocs/floor_map_bloc.dart';

class FloorMapHeader extends StatelessWidget {
  const FloorMapHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FloorMapBloc, FloorMapState>(

        builder:(context, state) {
          final availableCount = state.filteredTables.where((t) => t.status == 'available').length;
          final occupiedCount = state.filteredTables.where((element) =>  element.status == 'occupied',).length;
          final diningCount = state.filteredTables.where((t) => t.status == 'dining').length;
          final billingCount = state.filteredTables.where((t) => t.status == 'billing').length;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Floor Map",
                          style: AppTextStyles.h3.copyWith(fontSize: 28, color: AppColors.white)),
                      const SizedBox(height: 4),
                      Text(
                        "$occupiedCount Occupied •  $availableCount Available  $diningCount Dining  $billingCount Billing",
                        style: const TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),

                  _buildLocationDropdown(context, state),
                ],
              ),
              const SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildStatusIndicator("Available", AppColors.available),
                    _buildStatusIndicator("Occupied", AppColors.occupied),
                    _buildStatusIndicator("Dining", AppColors.dining),
                    _buildStatusIndicator("Billing", AppColors.billing),
                    _buildStatusIndicator("Reserved", AppColors.reserved),
                  ],
                ),
              ),
              const Divider(color: Colors.grey, height: 40, thickness: 0.2),
            ],
          );
        },
    );
  }
  Widget _buildLocationDropdown(BuildContext context, FloorMapState state) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.orange.withValues(alpha: 0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<LocationEntity>(
          value: state.selectedLocation,
          dropdownColor: const Color(0xFF252525),
          icon: const Icon(Icons.unfold_more_rounded, color: Colors.orange),
          hint: const Text(
            "Select Floor",
            style: TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.w500),
          ),
          borderRadius: BorderRadius.circular(15),
          items: state.locations.map((location) {
            return DropdownMenuItem(
              value: location,
              child: Row(
                children: [
                  const Icon(Icons.layers_outlined, size: 18, color: Colors.orange),
                  const SizedBox(width: 10),
                  Text(
                    location.locationName,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
            );
          }).toList(),
          onChanged: (newLocation) {
            if (newLocation != null) {
              context.read<FloorMapBloc>().add(ChangeLocationEvent(newLocation));
            }
          },
        ),
      ),
    );
  }
  Widget _buildStatusIndicator(String label, Color color) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Row(
        children: [
          CircleAvatar(radius: 4, backgroundColor: color),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }

}

