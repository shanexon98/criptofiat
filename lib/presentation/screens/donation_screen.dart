import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/color_schemes.dart';

class DonationScreen extends StatelessWidget {
  const DonationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: ColorSchemes.purpleGradient,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    'Support the Project',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'If you find this app useful, consider supporting its development',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.white.withOpacity(0.9),
                        ),
                  ),
                  const SizedBox(height: 24),
                  _buildDonationCard(
                    context,
                    'USDT (Red TRON)',
                    'TKAqRUV1KK9P3A1fZZUjkLpSqbC8X8dPec',
                    Icons.account_balance_wallet,
                  ),
                  const SizedBox(height: 16),
                  _buildDonationCard(
                    context,
                    'Bitcoin',
                    '12i11TRDgF2z4qTJsDu4rJ5PLPxRusrRQi',
                    Icons.currency_bitcoin,
                  ),
                  const SizedBox(height: 16),
                  _buildDonationCard(
                    context,
                    'Ethereum',
                    '0x63c022786a6b1cc36a89dd097da4e18d68e29886',
                    Icons.currency_exchange,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDonationCard(
    BuildContext context,
    String title,
    String address,
    IconData icon,
  ) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.surface.withOpacity(0.7),
              Theme.of(context).colorScheme.surface.withOpacity(0.2),
            ],
          ),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(16),
          leading: Icon(
            icon,
            size: 40,
            color: Colors.white,
          ),
          title: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              address,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withOpacity(0.9),
                  ),
            ),
          ),
          trailing: IconButton(
            icon: const Icon(
              Icons.copy,
              color: Colors.white,
            ),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: address));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Address copied to clipboard'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}