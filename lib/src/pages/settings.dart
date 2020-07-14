// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:momentum/momentum.dart';
import 'package:package_info/package_info.dart';
import 'package:relative_scale/relative_scale.dart';
import 'package:url_launcher/url_launcher.dart';

// Project imports:
import 'package:anime_twist/src/components/theme/index.dart';
import 'package:anime_twist/src/utils/color.dart';
import 'package:anime_twist/src/widgets/index.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> with RelativeScale {
  ThemeController _themeController;
  @override
  void didChangeDependencies() {
    initRelativeScaler(context);
    _themeController ??= Momentum.controller<ThemeController>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var currentTheme = CustomTheme.of(context);
    final key = new GlobalKey<ScaffoldState>();
    return Scaffold(
      key: key,
      appBar: AppBar(),
      body: Column(
        children: [
          ListTile(
            title: Text('Toggle theme!'),
            subtitle: Text('click to toggle the theme'),
            trailing: _themeController.model.activeTheme == 0
                ? Icon(
                    Icons.brightness_4,
                    color: getContrast(currentTheme.bodyBackground),
                  )
                : Icon(Icons.brightness_high,
                    color: getContrast(currentTheme.bodyBackground)),
            onTap: () {
              if (_themeController.model.activeTheme == 0) {
                _themeController.selectTheme(1);
              } else {
                _themeController.selectTheme(0);
              }
            },
          ),
          Divider(
            color: currentTheme.textPrimary,
          ),
          ListTile(
            title: Text('You help Anime Twist with:'),
          ),
          ListTile(
            title: Text('Bitcoin Wallet (click to copy)'),
            subtitle: Text('1ATvQNxFnyVBa4Pd5njdvjTXcECgptzcZo'),
            onTap: () {
              Clipboard.setData(
                  ClipboardData(text: '1ATvQNxFnyVBa4Pd5njdvjTXcECgptzcZo'));
              key.currentState.showSnackBar(new SnackBar(
                content: new Text("Copied to Clipboard"),
              ));
            },
            onLongPress: () async {
              const url = 'https://twist.moe/public/img/bitcoin-qr.png';
              await launchUrl(url);
            },
          ),
          ListTile(
              title: Text('Ethereum Wallet (click to copy)'),
              subtitle: Text('0x8337104096a3297a71ee16a9C922a5ff3818DF46'),
              onTap: () {
                Clipboard.setData(ClipboardData(
                    text: '0x8337104096a3297a71ee16a9C922a5ff3818DF46'));
                key.currentState.showSnackBar(new SnackBar(
                  content: new Text("Copied to Clipboard"),
                ));
              },
              onLongPress: () async {
                const url = 'https://twist.moe/public/img/ethereum-qr.png';
                await launchUrl(url);
              }),
          ListTile(
            title: Text('Patreon'),
            subtitle: Text('Click to open in browser!'),
            onTap: () async {
              const url = 'https://www.patreon.com/bePatron?c=1850965';
              await launchUrl(url);
            },
          ),
          Divider(
            color: currentTheme.textPrimary,
          ),
          ListTile(
            title: Text('About the app!'),
            subtitle: Text('Miscellaneous information regarding the app.'),
            onTap: () async {
              PackageInfo packageInfo = await PackageInfo.fromPlatform();
              var applicationLeaglese = 'By Anurag Patil (@meta-boy)';
              var applicationIcon = Image.asset(
                'assets/images/logo.png',
                height: 20,
              );
              var aboutDialog = Dialog(
                backgroundColor: currentTheme.bodyBackground,
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        packageInfo.appName,
                      ),
                      subtitle: Text(
                        applicationLeaglese,
                      ),
                      trailing: Text(packageInfo.version),
                      leading: applicationIcon,
                    ),
                    Divider(
                      color: currentTheme.textPrimary,
                    ),
                    ListTile(
                      title: Text(
                        'Github Repository',
                      ),
                      subtitle: Text('https://github.com/meta-boy/Anime-Twist'),
                      onTap: () async {
                        const url = 'https://github.com/meta-boy/Anime-Twist';
                        await launchUrl(url);
                      },
                    ),
                    ListTile(
                      title: Text('Licenses'),
                      subtitle:
                          Text('The user is bound to all these licenses.'),
                      onTap: () => showLicensePage(
                          context: context,
                          applicationIcon: applicationIcon,
                          applicationLegalese: applicationLeaglese,
                          applicationName: packageInfo.appName,
                          applicationVersion: packageInfo.version),
                    )
                  ],
                ),
              );
              await showDialog(
                context: context,
                builder: (context) => aboutDialog,
              );
            },
          )
        ],
      ),
    );
  }
}

Future launchUrl(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
