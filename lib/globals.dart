import 'package:flutter/material.dart';

const String appTitle = 'ezDatepad';
const String appVersion = '1.1';
const String appAuthor = 'Adrie Berg';
const String appTheAuthor = 'the author';
const String appEmail = 'adrieberg@gmail.com';

/// menu constants are used to disable the menuitem referring to the current
/// page
const String menuItemEditCurrentDate = 'editCurrentDate';
const String menuItemEditCurrentDateTime = 'editCurrentDateTime';
const String menuItemEditSelectTime = 'editSelectTime';
const String menuItemEditSelectDate = 'editSelectDate';
const String menuItemEditSelectDateTime = 'editSelectDateTime';
const String menuItemList = 'list';
const String menuItemSettings = 'settings';
const String menuItemAbout = 'about';

/*
 * Colors that need to be fixes, independent of the light/dark theme
 */
const Color gColorWhite         = Colors.white;
const Color gColorBlack         = Colors.black;
const Color gColorWarning       = Colors.red;
const double gFontSizeSmall     = 10.5;

/// Icons used throughout the app
const Icon gIconAdd             = Icon(Icons.add);
const Icon gIconArrowDown       = Icon(Icons.arrow_downward);
const Icon gIconArrowLeft       = Icon(Icons.arrow_left);
const Icon gIconArrowRight      = Icon(Icons.arrow_right);
const Icon gIconArrowUp         = Icon(Icons.arrow_upward);
const Icon gIconCalendar        = Icon(Icons.calendar_month);
const Icon gIconCalendarMonth   = Icon(Icons.calendar_month);
const Icon gIconCalendarWeek    = Icon(Icons.calendar_month);
const Icon gIconCalendarSimple  = Icon(Icons.calendar_today);
const Icon gIconCancel          = Icon(Icons.cancel);
const Icon gIconCreateDate      = Icon(Icons.date_range);
const Icon gIconCreateDateTime  = Icon(Icons.date_range);
const Icon gIconCreateTime      = Icon(Icons.watch_later);
const Icon gIconDate            = Icon(Icons.date_range);
const Icon gIconDateTime        = Icon(Icons.date_range);
const Icon gIconEye             = Icon(Icons.remove_red_eye_outlined);
const Icon gIconTime            = Icon(Icons.watch_later);
const Icon gIconDeleteWhite     = Icon(Icons.delete, color: gColorWhite);
const Icon gIconDeleteRed       = Icon(Icons.delete, color: gColorWarning);
const Icon gIconDelete          = Icon(Icons.delete);
const Icon gIconEdit            = Icon(Icons.mode_outlined);
const Icon gIconInfo            = Icon(Icons.info);
const Icon gIconKeyboard        = Icon(Icons.keyboard);
const Icon gIconKeyboardHide    = Icon(Icons.keyboard_hide);
const Icon gIconList            = Icon(Icons.view_headline);
const Icon gIconListDay         = Icon(Icons.date_range);
const Icon gIconListDayWhite    = Icon(Icons.date_range, color: gColorWhite);
const Icon gIconListTime        = Icon(Icons.watch_later);
const Icon gIconListTimeWhite   = Icon(Icons.watch_later, color: gColorWhite);
const Icon gIconMoreHoriz       = Icon(Icons.more_horiz);
const Icon gIconMoreVert        = Icon(Icons.more_vert);
const Icon gIconOpenNewScreen   = Icon(Icons.chevron_right);
const Icon gIconSearch          = Icon(Icons.search);
const Icon gIconSettings        = Icon(Icons.settings);
const Icon gIconWarning         = Icon(Icons.warning);
const Icon gIconWarningRed      = Icon(Icons.warning, color: gColorWarning);

String gPrefStartPage = '';
String gPrefActionButton = '';
String gPrefColorScheme = '';
int gPrefSummaryLines = 3;
bool gPrefSummaryNewlines = true;
bool gPrefAllowEmpty = true;

const double listViewPadding = 8.0;
const double textFieldPadding = 8.0;

const String textSearch = 'Search...';
const String textEntryDefault = '';
const String textBtnOK = 'OK';
const String textBtnCancel = 'Cancel';

String globalTooltipStart = '[';
String globalTooltipEnd = ']';

/// Terms and conditions and privacy policy generated at:
/// https://app-privacy-policy-generator.firebaseapp.com/
const String mdTerms = """

**Terms & Conditions**

By downloading or using $appTitle (this app), these terms will automatically apply to you – you should make sure therefore that you read them carefully before using the app. You’re not allowed to copy or modify the app, any part of the app, or our trademarks in any way. You’re not allowed to attempt to extract the source code of the app, and you also shouldn’t try to translate the app into other languages or make derivative versions. The app itself, and all the trademarks, copyright, database rights, and other intellectual property rights related to it, still belong to $appAuthor ($appTheAuthor).

$appAuthor is committed to ensuring that the app is as useful and efficient as possible. For that reason, we reserve the right to make changes to the app or to charge for its services, at any time and for any reason. We will never charge you for the app or its services without making it very clear to you exactly what you’re paying for.

The $appTitle app stores and processes personal data that you have provided, to provide my Service. It’s your responsibility to keep your phone and access to the app secure. We therefore recommend that you do not jailbreak or root your phone, which is the process of removing software restrictions and limitations imposed by the official operating system of your device. It could make your phone vulnerable to malware/viruses/malicious programs, compromise your phone’s security features and it could mean that the $appTitle app won’t work properly or at all.

You should be aware that there are certain things that $appTheAuthor will not take responsibility for. Certain functions of the app will require the app to have an active internet connection. The connection can be Wi-Fi or provided by your mobile network provider, but $appTheAuthor cannot take responsibility for the app not working at full functionality if you don’t have access to Wi-Fi, and you don’t have any of your data allowance left.

If you’re using the app outside of an area with Wi-Fi, you should remember that the terms of the agreement with your mobile network provider will still apply. As a result, you may be charged by your mobile provider for the cost of data for the duration of the connection while accessing the app, or other third-party charges. In using the app, you’re accepting responsibility for any such charges, including roaming data charges if you use the app outside of your home territory (i.e. region or country) without turning off data roaming. If you are not the bill payer for the device on which you’re using the app, please be aware that we assume that you have received permission from the bill payer for using the app.

Along the same lines, $appTheAuthor cannot always take responsibility for the way you use the app i.e. You need to make sure that your device stays charged – if it runs out of battery and you can’t turn it on to avail the Service, $appTheAuthor cannot accept responsibility.

With respect to $appTheAuthor’s responsibility for your use of the app, when you’re using the app, it’s important to bear in mind that although we endeavor to ensure that it is updated and correct at all times, we do rely on third parties to provide information to us so that we can make it available to you. $appAuthor accepts no liability for any loss, direct or indirect, you experience as a result of relying wholly on this functionality of the app.

At some point, we may wish to update the app. The app is currently available on Android & iOS – the requirements for the both systems(and for any additional systems we decide to extend the availability of the app to) may change, and you’ll need to download the updates if you want to keep using the app. $appAuthor does not promise that it will always update the app so that it is relevant to you and/or works with the Android & iOS version that you have installed on your device. However, you promise to always accept updates to the application when offered to you, We may also wish to stop providing the app, and may terminate use of it at any time without giving notice of termination to you. Unless we tell you otherwise, upon any termination, (a) the rights and licenses granted to you in these terms will end; (b) you must stop using the app, and (if needed) delete it from your device.

**Changes to This Terms and Conditions**

I may update our Terms and Conditions from time to time. Thus, you are advised to review this page periodically for any changes. I will notify you of any changes by posting the new Terms and Conditions on this page.

These terms and conditions are effective as of 2022-11-24

**Contact Us**

If you have any questions or suggestions about my Terms and Conditions, do not hesitate to contact me at $appEmail.

""";

/// Terms and conditions and privacy policy generated at:
/// https://app-privacy-policy-generator.firebaseapp.com/
const String mdPrivacy = """

**Privacy Policy**

$appAuthor ($appTheAuthor) built $appTitle as a free app. This app is provided by $appTheAuthor at no cost and is intended for use as is.

This text is used to inform users of the app regarding my policies with the collection, use, and disclosure of personal information if anyone decided to use this app.

If you choose to use this app, then you agree to the collection and use of information in relation to this policy. The personal information that I collect is used for providing and improving the app. I will not use or share your information with anyone except as described in this Privacy Policy.

The terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which are accessible at $appTitle unless otherwise defined in this Privacy Policy.

**Information Collection and Use**

For a better experience, while using this app, I may require you to provide us with certain personally identifiable information. The information that I request will be retained on your device and is not collected by me in any way.

**Log Data**

I want to inform you that whenever you use my app, in a case of an error in the app I collect data and information (through third-party products) on your phone called Log Data. This Log Data may include information such as your device Internet Protocol (“IP”) address, device name, operating system version, the configuration of the app when utilizing my Service, the time and date of your use of the Service, and other statistics.

**Cookies**

Cookies are files with a small amount of data that are commonly used as anonymous unique identifiers. These are sent to your browser from the websites that you visit and are stored on your device's internal memory.

This Service does not use these “cookies” explicitly. However, the app may use third-party code and libraries that use “cookies” to collect information and improve their services. You have the option to either accept or refuse these cookies and know when a cookie is being sent to your device. If you choose to refuse our cookies, you may not be able to use some portions of this Service.

**Service Providers**

I may employ third-party companies and individuals due to the following reasons:

*   To facilitate our Service;
*   To provide the Service on our behalf;
*   To perform Service-related services; or
*   To assist us in analyzing how our Service is used.

I want to inform users of this Service that these third parties have access to their Personal Information. The reason is to perform the tasks assigned to them on our behalf. However, they are obligated not to disclose or use the information for any other purpose.

**Children’s Privacy**

I do not knowingly collect personally identifiable information from children. I encourage all children to never submit any personally identifiable information through the Application and/or Services. I encourage parents and legal guardians to monitor their children's Internet usage and to help enforce this Policy by instructing their children never to provide personally identifiable information through the Application and/or Services without their permission. If you have reason to believe that a child has provided personally identifiable information to us through the Application and/or Services, please contact us. You must also be at least 16 years of age to consent to the processing of your personally identifiable information in your country (in some countries we may allow your parent or guardian to do so on your behalf).

**Changes to This Privacy Policy**

I may update our Privacy Policy from time to time. Thus, you are advised to review this page periodically for any changes. I will notify you of any changes by posting the new Privacy Policy on this page.

This policy is effective as of 2022-11-24

**Contact Us**

If you have any questions or suggestions about my Privacy Policy, do not hesitate to contact me at $appEmail.

""";

const String mdAuthor = """

**Version**

This is $appTitle version $appVersion for iOS. First Windows version was released in 2001. First Android version is from 2020.

**Author**

Created by $appAuthor. ($appEmail) 

""";
