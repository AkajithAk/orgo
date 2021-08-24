import 'dart:io' show Platform;
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'apply_for_vendor.dart';
import '../notification/message_list.dart';
import '../../../ui/pages/page_detail.dart';
import '../../../ui/pages/webview.dart';
import '../../../../assets/presentation/m_store_icons_icons.dart';
import '../../../chat/pages/chat_rooms.dart';
import '../../../chat/pages/chat_with_admin.dart';
import '../../../models/app_state_model.dart';
import '../../../models/blocks_model.dart';
import '../../../models/post_model.dart';
import '../../../ui/accounts/settings/settings.dart';
import '../../vendor/ui/orders/order_list.dart';
import '../../vendor/ui/products/vendor_detail/vendor_detail.dart';
import '../../vendor/ui/products/vendor_products/product_list.dart';
import '../address/customer_address.dart';
import '../currency.dart';
import '../language/language.dart';
import '../login/login.dart';
import '../orders/order_list.dart';
import '../../pages/post_detail.dart';
import '../wallet.dart';
import '../wishlist.dart';
import 'account_floating_button.dart';

class UserAccount3 extends StatefulWidget {
  @override
  _UserAccount3State createState() => _UserAccount3State();
}

class _UserAccount3State extends State<UserAccount3> {
  final appStateModel = AppStateModel();
  @override
  Widget build(BuildContext context) {
    TextStyle menuTextStyle = Theme.of(context).textTheme.bodyText1;
    Color onPrimaryColor = Theme.of(context).primaryTextTheme.headline6.color;
    Color headerBackgroundColor = Theme.of(context).primaryColor;
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      floatingActionButton: AccountFloatingButton(),
      body: ScopedModelDescendant<AppStateModel>(
          builder: (context, child, model) {
            return CustomScrollView(
              slivers: <Widget>[
                buildSliverAppBar(onPrimaryColor, context, headerBackgroundColor),
                SliverPadding(padding: EdgeInsets.all(0),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate(
                        _buildList(model)
                    ),
                  ),
                )
              ],
            );
          }
      ),
    );
  }

  _buildList(AppStateModel model) {
    List<Widget> list = [];
    bool isLoggedIn = model.user?.id != null && model.user.id > 0;
    TextStyle titleStyle = Theme.of(context).textTheme.bodyText1;
    double margin = 8;

    list.add(SizedBox(height: margin/2));

    if(!isLoggedIn)
      list.add(
          CustomCard(
            child: ListTile(
              onTap: () {
                _userLogin();
              },
              leading: Icon(Icons.person),
              title: Text(model.blocks.localeText.signIn, style: titleStyle),
              trailing: Icon(Icons.arrow_right),
            ),
          )
      );

    if (isLoggedIn && !model.isVendor.contains(model.user.role) && model.blocks.settings.vendorType == 'dokan') {
      list.add(
          CustomCard(
            child: ListTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ApplyForVendor()));
              },
              leading: Icon(MStoreIcons.account_circle_fill),
              title: Text(model.blocks.localeText.becomeVendor, style: titleStyle),
              trailing: Icon(Icons.arrow_right),
            ),
          )
      );
    }

    list.add(
        CustomCard(
          child: ListTile(
            onTap: () {
              isLoggedIn ? Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Wallet())) : _userLogin();
            },
            leading: Icon(Icons.account_balance_wallet),
            title: Text(model.blocks.localeText.wallet, style: titleStyle),
            trailing: Icon(Icons.arrow_right),
          ),
        )
    );

    list.add(
        CustomCard(
          child: ListTile(
            onTap: () {
              isLoggedIn ? Navigator.push(context,
                  MaterialPageRoute(builder: (context) => WishList())) : _userLogin();
            },
            leading: Icon(MStoreIcons.heart),
            title: Text(model.blocks.localeText.wishlist, style: titleStyle),
            trailing: Icon(Icons.arrow_right),
          ),
        )
    );

    list.add(
        CustomCard(
          child: ListTile(
            onTap: () {
              isLoggedIn ? Navigator.push(context,
                  MaterialPageRoute(builder: (context) => OrderList())) : _userLogin();
            },
            leading: Icon(MStoreIcons.shopping_basket_2_fill),
            title: Text(model.blocks.localeText.orders, style: titleStyle),
            trailing: Icon(Icons.arrow_right),
          ),
        )
    );

    /*list.add(
        CustomCard(
          child: ListTile(
            onTap: () {
              isLoggedIn ? Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MessageList())) : _userLogin();
            },
            leading: Icon(MStoreIcons.shopping_basket_2_fill),
            title: Text(model.blocks.localeText.orders, style: titleStyle),
            trailing: Icon(Icons.notifications),
          ),
        )
    );*/

    list.add(
        CustomCard(
          child: ListTile(
            onTap: () {
              isLoggedIn ? Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ChatRoomList(id: model.user.id.toString()))) : _userLogin();
            },
            leading: Icon(Icons.chat_bubble),
            title: Text(model.blocks.localeText.chat, style: titleStyle),
            trailing: Icon(Icons.arrow_right),
          ),
        )
    );

    list.add(
        CustomCard(
          child: ListTile(
            onTap: () {
              isLoggedIn ? Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CustomerAddress())) : _userLogin();
            },
            leading: Icon(MStoreIcons.location),
            title: Text(model.blocks.localeText.address, style: titleStyle),
            trailing: Icon(Icons.arrow_right),
          ),
        )
    );

    list.add(
        CustomCard(
          child: ListTile(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SettingsPage()));
            },
            leading: Icon(MStoreIcons.settings),
            title: Text(model.blocks.localeText.settings, style: titleStyle),
            trailing: Icon(Icons.arrow_right),
          ),
        )
    );

    if (model.blocks?.languages != null && model.blocks.languages.length > 0)
      list.add(
          CustomCard(
            child: ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LanguagePage()));
              },
              leading: Icon(Icons.language),
              title: Text(model.blocks.localeText.language, style: titleStyle),
              trailing: Icon(Icons.arrow_right),
            ),
          )
      );

    if (model.blocks?.currencies != null && model.blocks.currencies.length > 0)
      list.add(
          CustomCard(
            child: ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CurrencyPage()));
              },
              leading: Icon(Icons.attach_money),
              title: Text(model.blocks.localeText.currency, style: titleStyle),
              trailing: Icon(Icons.arrow_right),
            ),
          )
      );

    list.add(
        CustomCard(
          child: ListTile(
            onTap: () => _shareApp(),
            leading: Icon(MStoreIcons.share),
            title: Text(model.blocks.localeText.shareApp, style: titleStyle),
            trailing: Icon(Icons.arrow_right),
          ),
        )
    );

    if (isLoggedIn)
    list.add(
        CustomCard(
          child: ListTile(
            onTap: () => model.logout(),
            leading: Icon(MStoreIcons.logout_circle_r_fill),
            title: Text(model.blocks.localeText.logout, style: titleStyle),
            trailing: Icon(Icons.arrow_right),
          ),
        )
    );

    if (model.blocks != null && model.blocks.pages.length != 0 && model.blocks.pages[0].url.isNotEmpty) {
      list.add(SizedBox(height: 24));
      model.blocks.pages.forEach((element) {
        list.add(
            CustomCard(
              child: ListTile(
                onTap: () => _onPressItem(element, context),
                leading: Icon(Icons.info),
                title: Text(element.title, style: titleStyle),
                trailing: Icon(Icons.arrow_right),
              ),
            )
        );
      });
    }

    if (isLoggedIn && ((model.isVendor.contains(model.user.role) && model.blocks.settings.isMultivendor) || model.user.role.contains('administrator'))) {
      list.add(SizedBox(height: 24));
      list.add(
          CustomCard(
            child: ListTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => VendorProductList(vendorId: model.user.id.toString())));
              },
              leading: Icon(MStoreIcons.grid_fill),
              title: Text(model.blocks.localeText.products, style: titleStyle),
              trailing: Icon(Icons.arrow_right),
            ),
          )
      );
      list.add(
          CustomCard(
            child: ListTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => VendorOrderList(vendorId: model.user.id.toString())));
              },
              leading: Icon(Icons.shopping_basket),
              title: Text(model.blocks.localeText.orders, style: titleStyle),
              trailing: Icon(Icons.arrow_right),
            ),
          )
      );
      list.add(
          CustomCard(
            child: ListTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => VendorDetails(vendorId: model.user.id.toString())));
              },
              leading: Icon(MStoreIcons.store_2_fill),
              title: Text(model.blocks.localeText.info, style: titleStyle),
              trailing: Icon(Icons.arrow_right),
            ),
          )
      );
    }

    return list;
  }

  _buildVendorList() {
    List<Widget> list = [];

    return list;
  }

  _userLogin() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
  }

  Future openLink(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _shareApp() {
    if (Platform.isIOS) {
      Share.share('Check out this app: ' +
          appStateModel.blocks.settings.shareAppIosLink);
    } else {
      Share.share('Check out this app: ' +
          appStateModel.blocks.settings.shareAppAndroidLink);
    }
  }

  _onPressItem(Child page, BuildContext context) {
    if(page.description == 'page') {
      var post = Post();
      post.id = int.parse(page.url);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  PageDetail(post: post)));
    } else if(page.description == 'post') {
      var post = Post();
      post.id = int.parse(page.url);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  PostDetail(post: post)));
    } else if(page.description == 'link') {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  WebViewPage(url: page.url, title: page.title)));
    }
  }

  SliverAppBar buildSliverAppBar(Color onPrimaryColor, BuildContext context, Color headerBackgroundColor) {
    return SliverAppBar(
      brightness: Brightness.dark,
      floating: false,
      pinned: true,
      snap: false,
      expandedHeight: 150.0,
      centerTitle: false,
      flexibleSpace: FlexibleSpaceBar(
          titlePadding: EdgeInsets.only(left: 0, bottom: 16),
          title: Row(
            children: [
              SizedBox(
                width: 10,
              ),
              CircleAvatar(
                radius: 18.0,
                backgroundColor: onPrimaryColor.withOpacity(0.6),
                child: Icon(
                  Icons.person,
                  color: Theme.of(context).primaryColor,
                  size: 18,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              ScopedModelDescendant<AppStateModel>(
                  builder: (context, child, model) {
                    return Container(
                        child: (model.user?.id != null &&
                            model.user.id > 0)
                            ? (model.user.billing.firstName != '' ||
                            model.user.billing.lastName != '')
                            ? Text(
                          model.user.billing.firstName +
                              ' ' +
                              model.user.billing.lastName,
                          style: TextStyle(color: onPrimaryColor),
                        )
                            : Container(
                          child: Text(
                            model.blocks.localeText.welcome,
                            style: TextStyle(color: onPrimaryColor),
                          ),
                        )
                            : Container(
                          child: GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login())),
                            child: Text(
                              model.blocks.localeText.signIn,
                              style: TextStyle(color: onPrimaryColor),
                            ),
                          ),
                        ));
                  }
              )
            ],
          ),
          background: buildAccountBackground2(context)),
      backgroundColor: headerBackgroundColor,
    );
  }

  Widget buildAccountBackground(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 30,
          left: -30,
          child: RotationTransition(
            turns: new AlwaysStoppedAnimation(38 / 360),
            child: Container(
              color: Theme.of(context).primaryColorLight.withOpacity(0.3),
              height: 35,
              width: 90,
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: -5,
          child: RotationTransition(
            turns: new AlwaysStoppedAnimation(127 / 360),
            child: Container(
              color: Theme.of(context).primaryColorDark.withOpacity(0.8),
              height: 35,
              width: 90,
            ),
          ),
        ),
        Positioned(
          bottom: 62,
          right: -40,
          child: RotationTransition(
            turns: new AlwaysStoppedAnimation(125 / 360),
            child: Container(
              color: Theme.of(context).primaryColorDark.withOpacity(0.8),
              height: 35,
              width: 100,
            ),
          ),
        ),
        Positioned(
          bottom: 80,
          right: -60,
          child: RotationTransition(
            turns: new AlwaysStoppedAnimation(125 / 360),
            child: Container(
              color: Theme.of(context).primaryColorLight.withOpacity(0.3),
              height: 35,
              width: 160,
            ),
          ),
        )
      ],
    );
  }

  Widget buildAccountBackground2(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).primaryColorDark,
                  Theme.of(context).primaryColorLight.withOpacity(0.1)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )),
        ),
        Positioned(
          top: 10,
          left: 80,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).primaryColorLight.withOpacity(0.3),
            ),
            height: 60,
            width: 60,
          ),
        ),
        Positioned(
          top: 0,
          left: -5,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).primaryColorLight.withOpacity(0.3),
            ),
            height: 35,
            width: 90,
          ),
        ),
        Positioned(
          bottom: 62,
          right: -40,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).primaryColorLight.withOpacity(0.3),
            ),
            height: 100,
            width: 100,
          ),
        ),
        Positioned(
          bottom: -40,
          right: 60,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).primaryColorLight.withOpacity(0.3),
            ),
            height: 80,
            width: 80,
          ),
        )
      ],
    );
  }
}

class CustomCard extends StatelessWidget {
  CustomCard({Key key, this.child}) : super(key: key);

  final Widget child;
  final double margin = 1;
  final double elevation = 0.0;
  final double borderRadius = 0;

  @override
  Widget build(BuildContext context) {
    Color color = Colors.black;//Theme.of(context).accentColor;
    return Card(
      elevation: elevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      margin: EdgeInsets.fromLTRB(margin, margin/2, margin, margin/2),
      child: child,
    );
  }
}
