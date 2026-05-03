import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

import '../models/player_data.dart';
import '../models/spaceship_details.dart';
import 'game_play.dart';
import 'main_menu.dart';

class SelectSpaceship extends StatefulWidget {
  const SelectSpaceship({super.key});

  @override
  State<SelectSpaceship> createState() => _SelectSpaceshipState();
}

class _SelectSpaceshipState extends State<SelectSpaceship> {
  final CarouselSliderController _carouselController = CarouselSliderController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/stars1.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                const SizedBox(height: 10),

                // Animated spaceship icon
                Transform.rotate(
                  angle: pi / 4,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          Colors.cyan.shade600.withOpacity(0.3),
                          Colors.purple.shade600.withOpacity(0.3),
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.cyan.shade300.withOpacity(0.3),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Image.asset(
                      'assets/images/ship_H.png',
                      height: 50,
                      width: 50,
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                // Game title
                const Text(
                  'CHOOSE YOUR',
                  style: TextStyle(
                    fontSize: 20,
                    letterSpacing: 3,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Text(
                  'SPACESHIP',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 4,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 15,
                        color: Colors.cyan,
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Player stats card
                Consumer<PlayerData>(
                  builder: (context, playerData, child) {
                    final spaceship = Spaceship.getSpaceshipByType(
                      playerData.spaceshipType,
                    );
                    return Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.white.withOpacity(0.1),
                            Colors.white.withOpacity(0.05),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.cyan.shade400.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildStatChip(
                            icon: Icons.rocket,
                            label: spaceship.name,
                            color: Colors.cyan,
                          ),
                          Container(
                            width: 1,
                            height: 30,
                            color: Colors.white.withOpacity(0.2),
                          ),
                          _buildStatChip(
                            icon: Icons.attach_money,
                            label: '${playerData.money}',
                            color: Colors.green,
                          ),
                        ],
                      ),
                    );
                  },
                ),

                const SizedBox(height: 20),

                // Navigation Row with Previous/Next buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Previous Button
                    _buildNavButton(
                      icon: Icons.chevron_left,
                      onPressed: () {
                        if (_currentIndex > 0) {
                          setState(() {
                            _currentIndex--;
                          });
                          _carouselController.previousPage(Durations.medium3);
                        }
                      },
                      isEnabled: _currentIndex > 0,
                    ),

                    // Current Ship Indicator
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.white.withOpacity(0.2),
                            Colors.white.withOpacity(0.05),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.cyan.shade400.withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: Colors.cyan.shade400,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.cyan.shade400,
                                  blurRadius: 5,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${_currentIndex + 1} / ${Spaceship.spaceships.length}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: Colors.cyan.shade400,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.cyan.shade400,
                                  blurRadius: 5,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Next Button
                    _buildNavButton(
                      icon: Icons.chevron_right,
                      onPressed: () {
                        if (_currentIndex < Spaceship.spaceships.length - 1) {
                          setState(() {
                            _currentIndex++;
                          });
                          _carouselController.nextPage(Durations.medium3);
                        }
                      },
                      isEnabled: _currentIndex < Spaceship.spaceships.length - 1,
                    ),
                  ],
                ),

                const SizedBox(height: 15),

                // Carousel
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.38,
                  child: CarouselSlider.builder(
                    itemCount: Spaceship.spaceships.length,
                      controller: _carouselController,
                    slideBuilder: (index) {
                      final spaceship =
                          Spaceship.spaceships.entries.elementAt(index).value;

                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.white.withOpacity(0.1),
                              Colors.white.withOpacity(0.05),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: Colors.cyan.shade400.withOpacity(0.3),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Spaceship Image
                            Expanded(
                              flex: 3,
                              child: Transform.rotate(
                                angle: pi / 4,
                                child: Image.asset(
                                  spaceship.assetPath,
                                  height: 100,
                                  width: 100,
                                ),
                              ),
                            ),

                            const SizedBox(height: 8),

                            // Spaceship Name
                            Text(
                              spaceship.name,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 1,
                              ),
                            ),

                            const SizedBox(height: 8),

                            // Stats Row
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  _buildStatBadge(
                                    icon: Icons.speed,
                                    value: '${spaceship.speed}',
                                    color: Colors.orange,
                                  ),
                                  _buildStatBadge(
                                    icon: Icons.trending_up,
                                    value: '${spaceship.level}',
                                    color: Colors.purple,
                                  ),
                                  _buildStatBadge(
                                    icon: Icons.attach_money,
                                    value: '${spaceship.cost}',
                                    color: Colors.green,
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 12),

                            // Action Button
                            Consumer<PlayerData>(
                              builder: (context, playerData, child) {
                                final type = Spaceship.spaceships.entries
                                    .elementAt(index)
                                    .key;
                                final isEquipped = playerData.isEquipped(type);
                                final isOwned = playerData.isOwned(type);
                                final canBuy = playerData.canBuy(type);

                                return _buildActionButton(
                                  context: context,
                                  isEquipped: isEquipped,
                                  isOwned: isOwned,
                                  canBuy: canBuy,
                                  onPressed: () {
                                    if (isEquipped) return;
                                    if (isOwned) {
                                      playerData.equip(type);
                                    } else if (canBuy) {
                                      playerData.buy(type);
                                    } else {
                                      _showInsufficientFundsDialog(
                                        context,
                                        spaceship.cost - playerData.money,
                                      );
                                    }
                                  },
                                );
                              },
                            ),

                            const SizedBox(height: 16),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 15),

                // Start Button
                SizedBox(
                  width: 250,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const GamePlay(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.play_arrow, size: 24),
                    label: const Text(
                      'LAUNCH MISSION',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.transparent,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: const BorderSide(color: Colors.cyan, width: 2),
                      ),
                      elevation: 0,
                      shadowColor: Colors.cyan.withOpacity(0.5),
                    ),
                  ),
                ),

                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavButton({
    required IconData icon,
    required VoidCallback onPressed,
    required bool isEnabled,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: isEnabled
            ? LinearGradient(
          colors: [
            Colors.cyan.shade600.withOpacity(0.6),
            Colors.purple.shade600.withOpacity(0.6),
          ],
        )
            : null,
        border: Border.all(
          color: isEnabled
              ? Colors.cyan.shade400
              : Colors.white.withOpacity(0.2),
          width: 1.5,
        ),
        boxShadow: isEnabled
            ? [
          BoxShadow(
            color: Colors.cyan.shade400.withOpacity(0.3),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isEnabled ? onPressed : null,
          customBorder: const CircleBorder(),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Icon(
              icon,
              color: isEnabled ? Colors.white : Colors.white.withOpacity(0.3),
              size: 28,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatChip({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Row(
      children: [
        Icon(icon, color: color, size: 18),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildStatBadge({
    required IconData icon,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 12),
          const SizedBox(width: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required BuildContext context,
    required bool isEquipped,
    required bool isOwned,
    required bool canBuy,
    required VoidCallback onPressed,
  }) {
    String buttonText = 'BUY';
    Color buttonColor = Colors.green;

    if (isEquipped) {
      buttonText = 'EQUIPPED';
      buttonColor = Colors.cyan;
    } else if (isOwned) {
      buttonText = 'EQUIP';
      buttonColor = Colors.orange;
    } else if (!canBuy) {
      buttonText = 'LOCKED';
      buttonColor = Colors.grey;
    }

    return SizedBox(
      width: 130,
      child: ElevatedButton(
        onPressed: (isEquipped || (!isOwned && !canBuy)) ? null : onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: buttonColor.withOpacity(0.8),
          padding: const EdgeInsets.symmetric(vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          buttonText,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }

  void _showInsufficientFundsDialog(BuildContext context, int amountNeeded) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1A1A2E),
          title: const Row(
            children: [
              Icon(Icons.warning, color: Colors.red, size: 28),
              SizedBox(width: 10),
              Text(
                'Insufficient Balance',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          content: Text(
            'Need $amountNeeded more credits to purchase this spaceship!',
            style: const TextStyle(color: Colors.white70),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'CLOSE',
                style: TextStyle(color: Colors.cyan),
              ),
            ),
          ],
        );
      },
    );
  }
}