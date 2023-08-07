import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroPageOne extends StatelessWidget {
  const IntroPageOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("lib/assets/images/screen_1.webp"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 60,),  
          Text('Welcome to My Habits ',
              style: GoogleFonts.dangrek( 
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
                  const SizedBox(height: 130,),  
          Row(
            mainAxisAlignment: MainAxisAlignment.center, 
            children: [
              Text('Build the better you',
                  style: GoogleFonts.comicNeue( 
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ],
          ),
          const SizedBox(height: 30,), 
          Column(

            children: [
              Row(
                
                children: [
                  const SizedBox(
                    width: 30, 
                  ),
                  const Icon(
                    Icons.file_download_done_sharp,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text('Plan a habit for daily',
                      style: GoogleFonts.urbanist(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ],
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 30,
                  ),
                  const Icon(
                    Icons.radar_outlined,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text('Track habits',
                      style: GoogleFonts.urbanist(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ],
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 30,
                  ),
                  const Icon(
                    Icons.map,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text('Build routines',
                      style: GoogleFonts.urbanist(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ],
              ),
              Row(
                children: [
                  const SizedBox(
                   width: 30,
                  ),
                  const Icon(
                    Icons.celebration,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text('Accomplish goals',
                      style: GoogleFonts.urbanist(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ],
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 30, 
                  ),
                  const Icon(
                    Icons.health_and_safety,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text('Get your life in order',
                      style: GoogleFonts.urbanist(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
