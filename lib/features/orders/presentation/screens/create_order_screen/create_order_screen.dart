import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_wiz_tech/core/developer.dart';
import 'package:pos_wiz_tech/core/enum/snakebar_tybe.dart';
import 'package:pos_wiz_tech/core/utils/app_snackbar.dart';
import 'package:pos_wiz_tech/features/floor_map/domain/entities/table_entity.dart';
import 'package:pos_wiz_tech/features/auth/domain/repositories/auth_repository.dart';
import 'package:pos_wiz_tech/features/floor_map/presentation/blocs/floor_map_bloc.dart';
import 'package:pos_wiz_tech/features/orders/presentation/screens/create_order_screen/widgets/cart_section.dart';
import 'package:pos_wiz_tech/features/orders/presentation/screens/create_order_screen/widgets/product_menu_section.dart';
import 'package:pos_wiz_tech/features/orders/presentation/screens/create_order_screen/widgets/order_success_dialog.dart';

import '../../../../../core/di/injection_container.dart';
import '../../blocs/cart_bloc/cart_bloc.dart';
import '../../../../../features/products/presentation/blocs/product_bloc/products_bloc.dart';

class CreateOrderScreen extends StatelessWidget {
  final TableEntity table;
  final VoidCallback? onNavigateBack;

  const CreateOrderScreen({
    super.key,
    required this.table,
    this.onNavigateBack,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<ProductBloc>()..add(GetMenuDataEvent()),
        ),
        BlocProvider(
          create: (context) => sl<CartBloc>()..add(LoadTableEvent(table)),
        ),
      ],
      child: BlocListener<CartBloc, CartState>(
        listener: (context, state) {
          if (state.status == CartStatus.failure) {
            AppLogger.error(state.errorMessage!);
            AppSnackBar.show(
              context,
              message: state.errorMessage ?? 'An error occurred',
              type: SnackBarType.error,
            );
          } else if (state.status == CartStatus.success &&
              state.actionPerformed) {
            context.read<FloorMapBloc>().add(const FetchTablesEvent());
            AppSnackBar.showSuccessDialog(
              context,
              title: "Success Operations",
              message: state.successMessage!,
            ).then((value) {
              if (context.mounted) {
                if (onNavigateBack != null) {
                  onNavigateBack!();
                } else {
                  Navigator.of(context).pop();
                }
              }
            });
          }
        },
        child: Scaffold(
          body: LayoutBuilder(
            builder: (context, constraints) {
              final waiterName = sl<AuthRepository>().getUserName() ?? "Unknown";
              if (constraints.maxWidth > 700) {
                return Row(
                  children: [
                    Expanded(
                      flex: 13,
                      child: ProductMenuSection(
                        table: table,
                        waiterName: waiterName,
                      ),
                    ),
                    const VerticalDivider(color: Colors.white10, width: 1),
                    const Expanded(flex: 7, child: CartSection()),
                  ],
                );
              } else {
                return Column(
                  children: [
                    Expanded(
                      flex: 3,
                      child: ProductMenuSection(
                        table: table,
                        waiterName: waiterName,
                      ),
                    ),
                    const Divider(color: Colors.white10, height: 1),
                    const Expanded(flex: 2, child: CartSection()),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
