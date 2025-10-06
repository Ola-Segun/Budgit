import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/goal.dart';

/// Card widget displaying goal timeline and deadline information
class GoalTimelineCard extends StatelessWidget {
  const GoalTimelineCard({
    super.key,
    required this.goal,
  });

  final Goal goal;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final daysRemaining = goal.daysRemaining;
    final isOverdue = goal.isOverdue;
    final isCompleted = goal.isCompleted;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.schedule,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Timeline',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Timeline visualization
            Container(
              height: 4,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceVariant,
                borderRadius: BorderRadius.circular(2),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: _calculateTimelineProgress(),
                child: Container(
                  decoration: BoxDecoration(
                    color: isCompleted
                        ? Colors.green
                        : isOverdue
                            ? Colors.red
                            : Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Timeline markers
            Row(
              children: [
                _buildTimelineMarker(
                  context,
                  'Started',
                  DateFormat('MMM dd').format(goal.createdAt),
                  isPast: true,
                ),
                Expanded(
                  child: Container(
                    height: 1,
                    color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
                  ),
                ),
                _buildTimelineMarker(
                  context,
                  isCompleted ? 'Completed' : 'Target',
                  DateFormat('MMM dd').format(goal.deadline),
                  isPast: isCompleted || now.isAfter(goal.deadline),
                  isCurrent: !isCompleted && !isOverdue && daysRemaining <= 30,
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Status information
            if (isCompleted) ...[
              _buildStatusRow(
                context,
                'Status',
                'Goal Completed!',
                Colors.green,
              ),
              const SizedBox(height: 8),
              _buildStatusRow(
                context,
                'Completed On',
                DateFormat('MMMM dd, yyyy').format(goal.deadline),
                Colors.green,
              ),
            ] else if (isOverdue) ...[
              _buildStatusRow(
                context,
                'Status',
                'Overdue',
                Colors.red,
              ),
              const SizedBox(height: 8),
              _buildStatusRow(
                context,
                'Days Overdue',
                '${daysRemaining.abs()}',
                Colors.red,
              ),
            ] else ...[
              _buildStatusRow(
                context,
                'Days Remaining',
                '$daysRemaining',
                Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 8),
              _buildStatusRow(
                context,
                'Target Date',
                DateFormat('MMMM dd, yyyy').format(goal.deadline),
                Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ],

            if (!isCompleted && goal.projectedCompletionDate != null) ...[
              const SizedBox(height: 8),
              _buildStatusRow(
                context,
                'Projected Completion',
                DateFormat('MMM dd, yyyy').format(goal.projectedCompletionDate!),
                Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ],
          ],
        ),
      ),
    );
  }

  double _calculateTimelineProgress() {
    final now = DateTime.now();
    final totalDuration = goal.deadline.difference(goal.createdAt).inDays;
    final elapsedDuration = now.difference(goal.createdAt).inDays;

    if (totalDuration <= 0) return 1.0;
    if (goal.isCompleted) return 1.0;

    return (elapsedDuration / totalDuration).clamp(0.0, 1.0);
  }

  Widget _buildTimelineMarker(
    BuildContext context,
    String label,
    String date, {
    required bool isPast,
    bool isCurrent = false,
  }) {
    return Column(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isCurrent
                ? Theme.of(context).colorScheme.primary
                : isPast
                    ? Colors.green
                    : Theme.of(context).colorScheme.outline,
            border: Border.all(
              color: Theme.of(context).colorScheme.surface,
              width: 2,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w500,
                color: isCurrent
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
        Text(
          date,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
      ],
    );
  }

  Widget _buildStatusRow(
    BuildContext context,
    String label,
    String value,
    Color valueColor,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: valueColor,
              ),
        ),
      ],
    );
  }
}