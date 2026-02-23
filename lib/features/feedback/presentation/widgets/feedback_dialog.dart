import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pos_wiz_tech/core/theme/app_color.dart';
import 'package:pos_wiz_tech/core/theme/app_text_style.dart';
import 'package:pos_wiz_tech/features/feedback/domain/entities/feedback_entity.dart';
import '../cubit/feedback_cubit.dart';
import '../cubit/feedback_state.dart';
import '../../../../core/utils/app_snackbar.dart';
import '../../../../core/enum/snakebar_tybe.dart';

class FeedbackDialog extends StatefulWidget {
  final int orderId;
  final String tableNumber;

  const FeedbackDialog({super.key, required this.orderId, required this.tableNumber});

  @override
  State<FeedbackDialog> createState() => _FeedbackDialogState();
}

class _FeedbackDialogState extends State<FeedbackDialog> {
  int _overall = 5, _food = 5, _service = 5, _speed = 5;
  final TextEditingController _commentController = TextEditingController();
  final List<String> _selectedTags = [];

  final Map<String, String> _availableTags = {
    "Delicious": "delicious",
    "Friendly Staff": "friendly_staff",
    "Fast Service": "fast_service",
    "Clean": "clean",
    "Great Ambiance": "great_ambiance",
    "Value for Money": "value_for_money",
  };

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 650,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.darkGrey,
          borderRadius: BorderRadius.circular(28),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 20),
              _buildTableBadge(),
              const SizedBox(height: 24),
               Text("RATE YOUR EXPERIENCE", style:AppTextStyles.body.copyWith(color: Colors.grey,fontSize: 14)),
              const SizedBox(height: 16),

              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 3,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildRatingBox("Overall", _overall, (v) => setState(() => _overall = v)),
                  _buildRatingBox("Food", _food, (v) => setState(() => _food = v)),
                  _buildRatingBox("Service", _service, (v) => setState(() => _service = v)),
                  _buildRatingBox("Speed", _speed, (v) => setState(() => _speed = v)),
                ],
              ),

              const SizedBox(height: 24),
              const Text("QUICK TAGS (OPTIONAL)", style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              _buildTags(),

              const SizedBox(height: 24),
              const Text("ADDITIONAL COMMENTS (OPTIONAL)", style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              _buildCommentField(),

              const SizedBox(height: 32),
              _buildFooterActions(),
            ],
          ),
        ),
      ),
    ).animate().scale(duration: 300.ms, curve: Curves.easeOutBack);
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
         Text("Customer Feedback", style: AppTextStyles.h3.copyWith(color: AppColors.white,fontWeight: FontWeight.w800)),
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close, color: Colors.white54),
          style: IconButton.styleFrom(backgroundColor: Colors.white10),
        ),
      ],
    );
  }

  Widget _buildTableBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.circle, color: AppColors.primary, size: 8),
          const SizedBox(width: 8),
          Text("Table ${widget.tableNumber}", style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w500,color: AppColors.primaryLight)),
        ],
      ),
    );
  }

  Widget _buildRatingBox(String label, int value, Function(int) onRate) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF252525),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Row(
            children: List.generate(5, (index) => GestureDetector(
              onTap: () => onRate(index + 1),
              child: Icon(
                index < value ? Icons.star_rounded : Icons.star_outline_rounded,
                color: index < value ? Colors.amber : Colors.white24,
              ),
            )),
          ),
        ],
      ),
    );
  }

  Widget _buildTags() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _availableTags.keys.map((tag) {
        final isSelected = _selectedTags.contains(_availableTags[tag]);
        return InkWell(
          onTap: () {
            setState(() {
              isSelected ? _selectedTags.remove(_availableTags[tag]) : _selectedTags.add(_availableTags[tag]!);
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primary : const Color(0xFF252525),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: isSelected ? AppColors.primary : Colors.white10),
            ),
            child: Text(tag, style: AppTextStyles.smallText.copyWith(color: isSelected ? AppColors.black : AppColors.grey)),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCommentField() {
    return TextField(
      controller: _commentController,
      maxLines: 3,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: "Any additional feedback or special remarks...",
        hintStyle: const TextStyle(color: Colors.white24),
        filled: true,
        fillColor: const Color(0xFF252525),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
      ),
    );
  }

  Widget _buildFooterActions() {
    return BlocConsumer<FeedbackCubit, FeedbackState>(
      listener: (context, state) {
        if (state is FeedbackSuccess) {
          AppSnackBar.show(context, message: state.message, type: SnackBarType.success);
          Navigator.pop(context);
        } else if (state is FeedbackError) {
          AppSnackBar.show(context, message: state.message, type: SnackBarType.error);
        }
      },
      builder: (context, state) {
        return Row(
          children: [
            TextButton(
              onPressed: state is FeedbackLoading ? null : () => Navigator.pop(context),
              child:  Text("Skip", style: AppTextStyles.body.copyWith(color: AppColors.grey)),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: ElevatedButton(
                onPressed: state is FeedbackLoading ? null : _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.green,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: state is FeedbackLoading
                    ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                    : const Text("Submit Feedback", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        );
      },
    );
  }

  void _submit() {
    final feedback = FeedbackEntity(
      orderId: widget.orderId,
      overallRating: _overall,
      foodQualityRating: _food,
      serviceRating: _service,
      speedRating: _speed,
      comment: _commentController.text.isEmpty ? null : _commentController.text,
      feedbackTags: _selectedTags,
    );
    context.read<FeedbackCubit>().submitFeedback(feedback);
  }
}