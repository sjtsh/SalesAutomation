import 'package:flutter/material.dart';

import 'AchievementsHeader.dart';

class Achievements extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        padding: EdgeInsets.only(top: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 3,
                offset: Offset(0, 2))
          ],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            AchievementsHeader(),
            Row(
              children: [
              SizedBox(width: 12,),
                Column(
                  children: [
                    Image.asset(
                      "assets/BestSOTrophy.png",
                      width: 80,
                      fit: BoxFit.contain,
                    ),
                    Image.asset(
                      "assets/BestPerformerTrophy.png",
                      width: 80,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
                Expanded(
                  child: Image.asset(
                    "assets/BestEmployeeTrophy.png",
                    fit: BoxFit.contain,
                  ),
                ),
                Column(
                  children: [
                    Image.asset(
                      "assets/BestPerformerTrophy.png",
                      width: 80,
                      fit: BoxFit.contain,
                    ),Image.asset(
                      "assets/BestSOTrophy.png",
                      width: 80,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
                SizedBox(width: 12,),
              ],
            )
          ],
        ),
      ),
    );
  }
}
