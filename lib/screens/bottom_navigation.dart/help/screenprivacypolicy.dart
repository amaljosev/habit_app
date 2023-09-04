import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';


class ScreenPrivacy extends StatefulWidget {
  const ScreenPrivacy({super.key});

  @override
  State<ScreenPrivacy> createState() => _ScreenPrivacyState();
}

class _ScreenPrivacyState extends State<ScreenPrivacy> {
    Future<void>? launchedd;
  final Uri toLaunchPlay =
    Uri(scheme: 'https', host: 'policies.google.com', path: 'privacy');
    

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
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
                        'Privacy Policy',
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
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Information Collection and Use',
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
                    ''' For a better experience, while using our Service, I may require you to provide us with certain personally identifiable information, including but not limited to email, username, password. The information that I request will be retained on your device and is not collected by me in any way.The app does use third-party services that may collect information used to identify you.Link to the privacy policy of third-party service providers used by the app''',
                    style: GoogleFonts.gideonRoman(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    onPressed: () => setState(() { 
                  launchedd = _launchInWebViewOrVC(toLaunchPlay);     
                },),
                    child: const Text('Google Play Services'),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Security',
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
                    ''' I value your trust in providing us your Personal Information, thus we are striving to use commercially acceptable means of protecting it. But remember that no method of transmission over the internet, or method of electronic storage is 100% secure and reliable, and I cannot guarantee its absolute security.''',
                    style: GoogleFonts.gideonRoman(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        ' Sharing of Information', 
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
                    ''' We do not sell, trade, or otherwise transfer your personal information to third parties without your consent, except for the purposes outlined in this Privacy Policy.''',
                    style: GoogleFonts.gideonRoman(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Changes to This Privacy Policy',
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
                    '''I may update our Privacy Policy from time to time. Thus, you are advised to review this page periodically for any changes. I will notify you of any changes by posting the new Privacy Policy on this page.This policy is effective as of 2023-08-11''',
                    style: GoogleFonts.gideonRoman(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Contact Us',
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
                    '''If you have any questions or suggestions about my Privacy Policy, do not hesitate to contact me at :''',  
                    style: GoogleFonts.gideonRoman(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                ),
                TextButton(onPressed: () async {
              // Create a mailto Uri with the recipient's email address.
              final Uri uri = Uri(
                  scheme: 'mailto',
                  path: 'flutterverseofficial@gmail.com'); 

              // Launch the mailto Uri using the url_launcher package.
              await launchUrl(uri);
            }, child: const Text('contact us'),),    
                 
              ],
            ),
          ),
        ),
      ),
    );
  }


  Future<void> _launchInWebViewOrVC(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppWebView,
      webViewConfiguration: const WebViewConfiguration(
          headers: <String, String>{'my_header_key': 'my_header_value'}),
    )) {
      throw Exception('Could not launch $url');
    }
  }
}
