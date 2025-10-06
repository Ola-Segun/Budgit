import 'package:flutter/material.dart';

import '../../domain/entities/account.dart';

/// Card displaying account information
class AccountCard extends StatelessWidget {
  const AccountCard({
    super.key,
    required this.account,
    this.onTap,
  });

  final Account account;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Account Icon
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Color(account.type.color).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  _getIconData(account.type.icon),
                  color: Color(account.type.color),
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),

              // Account Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      account.displayName,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (account.description != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        account.description!,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),

              // Balance
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    account.formattedBalance,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: account.isLiability
                              ? Theme.of(context).colorScheme.error
                              : Theme.of(context).colorScheme.primary,
                        ),
                  ),
                  if (account.type == AccountType.creditCard && account.creditLimit != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      'Limit: \$${account.creditLimit!.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),
                  ],
                ],
              ),

              // Chevron
              Icon(
                Icons.chevron_right,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'account_balance':
        return Icons.account_balance;
      case 'credit_card':
        return Icons.credit_card;
      case 'account_balance_wallet':
        return Icons.account_balance_wallet;
      case 'trending_up':
        return Icons.trending_up;
      case 'edit':
        return Icons.edit;
      default:
        return Icons.account_balance_wallet;
    }
  }
}