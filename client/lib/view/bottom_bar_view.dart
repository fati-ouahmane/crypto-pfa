import 'package:crypto_app/view/Profile/profile_view.dart';
import 'package:crypto_app/view/market/market_view.dart';
import 'package:crypto_app/view/wallet/wallet_view.dart';
import 'package:crypto_app/view_model/bottom_bar_view_model.dart';
import 'package:crypto_app/view_model/market_view_model.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';



class BottomBarView extends StatelessWidget {
  final String token;

  BottomBarView({required this.token, Key? key}) : super(key: key) {
    // Initialize the pages list using the token
    pages = [
      MarketView(),
      WalletView(),
      ProfileView(token: token),
    ];
  }

  late List<Widget> pages;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BottomBarViewModel()),
        ChangeNotifierProvider(create: (context) => MarketViewModel()),
      ],
      builder: (context, child) {
        return Consumer<BottomBarViewModel>(
          builder: (context, bottomBarViewModel, child) {
            return Scaffold(
              body: pages[bottomBarViewModel.index],
              bottomNavigationBar: BottomNavigationBar(
                backgroundColor: const Color(0xFF282159),
                elevation: 0,
                currentIndex: bottomBarViewModel.index,
                selectedIconTheme:
                    const IconThemeData(color: Colors.white, size: 26),
                unselectedIconTheme:
                    const IconThemeData(color: Color.fromARGB(
                        255, 89, 112, 157), size: 26),
                selectedFontSize: 15,
                unselectedFontSize: 14,
                selectedLabelStyle:
                    const TextStyle(fontWeight: FontWeight.w600),
                selectedItemColor: Colors.white,
                unselectedLabelStyle:
                    const TextStyle(fontWeight: FontWeight.w600),
                unselectedItemColor: Color.fromARGB(
                  255, 89, 112, 157),
                onTap: (value) {
                  bottomBarViewModel.changePage(value);
                },
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Iconsax.home), label: "Home"),
                  BottomNavigationBarItem(
                      icon: Icon(Iconsax.wallet_1), label: "Wallet"),
                  BottomNavigationBarItem(
                    icon: Icon(Iconsax.user),
                    label: "Profile"
                  ),

                ],
              ),
            );
          },
        );
      },
    );
  }
}
