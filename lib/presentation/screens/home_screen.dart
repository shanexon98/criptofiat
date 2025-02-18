import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:criptofiat/presentation/screens/currency_exchange_screen.dart';
import 'package:criptofiat/presentation/screens/news_screen.dart';
import 'package:criptofiat/presentation/theme/color_schemes.dart';
import 'package:criptofiat/data/repositories/news_repository_impl.dart';
import 'package:criptofiat/presentation/bloc/news_bloc.dart';
import 'package:criptofiat/presentation/screens/donation_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          const CurrencyExchangeScreen(),
          BlocProvider(
            create: (context) => NewsBloc(
              newsRepository: NewsRepositoryImpl(),
            ),
            child: const NewsScreen(),
          ),
          const DonationScreen(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              ColorSchemes.primaryPurple,
              ColorSchemes.surfaceDark,
            ],
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          backgroundColor: Colors.transparent,
          selectedItemColor: ColorSchemes.accentPurple,
          unselectedItemColor: Colors.white.withOpacity(0.6),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.currency_exchange),
              label: 'Exchange',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.newspaper),
              label: 'News',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.volunteer_activism),
              label: 'Donate',
            ),
          ],
        ),
      ),
    );
  }
}