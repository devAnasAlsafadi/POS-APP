import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_wiz_tech/core/theme/app_text_style.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../../core/theme/app_color.dart';
import 'package:pos_wiz_tech/features/products/presentation/blocs/product_bloc/products_bloc.dart';

class CategoryBar extends StatelessWidget {
  const CategoryBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductsState>(
      builder: (context, state) {
        return Container(
          height: 50,
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            itemCount: state.categories.length + 1, 
            itemBuilder: (context, index) {
              bool isSelected;
              String title;
              int id;

              if (index == 0) {
                isSelected = state.selectedCategoryId == 0;
                title = "All";
                id = 0;
              } else {
                final category = state.categories[index - 1];
                isSelected = state.selectedCategoryId == category.id;
                title = Localizations.localeOf(context).languageCode == 'ar' ? category.nameAr : category.nameEn;
                id = category.id;
              }

              return GestureDetector(
                onTap: () => context.read<ProductBloc>().add(ChangeCategoryEvent(id)),
                child: Container(
                  margin: const EdgeInsetsDirectional.only(start: 5),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary : AppColors.white.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(title, style: isSelected ? AppTextStyles.caption.copyWith(color: AppColors.white) : AppTextStyles.caption),
                  ),
                )
                .animate(target: isSelected ? 1 : 0)
                .scale(begin: const Offset(1, 1), end: const Offset(1.1, 1.1), duration: 200.ms, curve: Curves.easeOutBack)
                .elevation(begin: 0, end: 8, color: AppColors.primary.withValues(alpha: 0.5)),
              );
            },
          ),
        );
      },
    );
  }
}