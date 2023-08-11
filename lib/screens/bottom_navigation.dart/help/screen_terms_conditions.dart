import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScreenTermsAndConditions extends StatelessWidget {
  const ScreenTermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea( 
        child: SingleChildScrollView( 
          child: Column(
            children: [
              Row(
                children: [
                  Card(
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_rounded,
                        size: 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Terms & Conditions',
                      style: GoogleFonts.comicNeue(
                        fontWeight: FontWeight.w800,
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),            
                ], 
              ),
              Padding( 
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      ''' Amal Jose built the My Habits app as a Free app. This SERVICE is provided by Amal Jose at no cost and is intended for use as is.This page is used to inform visitors regarding my policies with the collection, use, and disclosure of Personal Information if anyone decided to use my Service.If you choose to use my Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that I collect is used for providing and improving the Service. I will not use or share your information with anyone except as described in this Privacy Policy.The terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which are accessible at My Habits unless otherwise defined in this Privacy Policy. ''',
                      style: GoogleFonts.gideonRoman(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Padding( 
                    padding: const EdgeInsets.all(8.0), 
                    child: Text(
                  ''' Amal Jose is committed to ensuring that the app is as useful and efficient as possible. For that reason, we reserve the right to make changes to the app or to charge for its services, at any time and for any reason. We will never charge you for the app or its services without making it very clear to you exactly what you’re paying for. ''',
                  style: GoogleFonts.gideonRoman(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.black,
                  ),
                    ),
                  ),
                  Padding( 
                    padding: const EdgeInsets.all(8.0), 
                    child: Text(
                  '''You should be aware that there are certain things that Amal Jose will not take responsibility.  With respect to Amal Jose’s responsibility for your use of the app, when you’re using the app, it’s important to bear in mind that although we endeavor to ensure that it is updated and correct at all times, we do rely on third parties to provide information to us so that we can make it available to you. Amal Jose accepts no liability for any loss, direct or indirect, you experience as a result of relying wholly on this functionality of the app. ''',
                  style: GoogleFonts.gideonRoman(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.black,
                  ),
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
