import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroPageTwo extends StatelessWidget {
  const IntroPageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/assets/images/screen_2.webp"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          
          
          children: [
             const SizedBox(height: 130,), 
            Text('Visualize your habits progress in charts',
                    style: GoogleFonts.urbanist(
                        fontSize: 20, 
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),  
            Row(
              mainAxisAlignment: MainAxisAlignment.center ,
              children: [
                Text('Enjoy your journey', 
                          style: GoogleFonts.urbanist(
                              fontSize: 20, 
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
              ],
            ),
            
          ],
        ));
  }
}
