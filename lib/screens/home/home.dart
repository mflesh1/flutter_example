import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:flutter_example/bloc/authentication/barrel.dart';
import 'package:flutter_example/bloc/notification/barrel.dart';
import 'package:flutter_example/components/components.dart';
import 'package:flutter_example/components/mixins/screen.dart';
import 'package:flutter_example/config/router.dart';
import 'package:flutter_example/models/barrel.dart';
import 'package:flutter_example/repositories/barrel.dart';
import 'package:flutter_example/screens/home/bloc/screen_bloc.dart';
import 'package:flutter_example/services/navigation_service.dart';
import 'package:flutter_example/theme/constants.dart';
import 'package:flutter_example/theme/theme.dart';

import '../../config/injection.dart';
import 'bloc/barrel.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenWidget();
  }
}

class ScreenWidget extends StatefulWidget {
  @override
  State<ScreenWidget> createState() => _ScreenState();
}

class _ScreenState extends State<ScreenWidget> with ScreenHelpers {

  @override
  Widget build(BuildContext buildContext) {
    return BlocProvider(
        create: (buildContext) {
          return ScreenBloc();
        },
        child: MultiBlocListener(
          listeners: [
            BlocListener<NotificationBloc, NotificationState>(
              listener: (context, state) {

              },
            )
          ],
          child: BlocBuilder<ScreenBloc, ScreenState>(
            builder: (context, state) {
              return Scaffold(
                appBar: buildAppBar(context),
                drawer: DrawerWidget(),
                body: BodyWidget(),
              );
            },
          ),
        ));
  }

  Widget buildAppBar(BuildContext context) {
    return new AppBar(
      title: new Text("Home"),
    );
  }

}

class BodyWidget extends StatefulWidget {
  @override
  State<BodyWidget> createState() => _BodyState();
}

class _BodyState extends State<BodyWidget> with ScreenHelpers {

  List<Message> messages = [];


  Widget buildBody(BuildContext context, BodyState state) {
    if (state is LoadingBodyState) {
      return LoadingIndicator();
    }
    return buildList(context);
  }

  Widget buildNoDataAvailable(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          SizedBox(height: Constants.paragraphPadding),
          Text('No messages available.'),
        ],
      ),
    );
  }

  Widget buildList(BuildContext context) {
    if (messages.isEmpty) {
      return buildNoDataAvailable(context);
    }
    return ListView.builder(
      itemCount: messages.length,
      itemBuilder: (BuildContext context, int index) {
        return buildListItem(context, messages[index]);
      },
    );
  }

  Widget buildListItem(BuildContext context, Message item) {
    return GestureDetector(
      onTap: (){

      },
      child: Padding(
        padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
        child: Row (
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(item.message, style: Theme.of(context).textTheme.body2,),
                  SizedBox(height: 4.0),
                  Text(DateFormat.yMMMEd().add_jm().format(item.date.toLocal()), style: Theme.of(context).textTheme.caption)
                ],
              ),
            ),
            Icon(
              Icons.arrow_right,
              color: ThemeColors.primaryColor,
            )
          ],

        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) {
          return BodyBloc()..add(LoadBody());
        },
        child: MultiBlocListener(
          listeners: [
            BlocListener<BodyBloc, BodyState>(listener: (context, state) {
              if (state is LoadedBodyState) {
                setState(() {
                  messages = state.messages;
                });
              } else if (state is LoadBodyFailed) {
                showErrorMessage(context, state.message);
              }
            }),
            BlocListener<ScreenBloc, ScreenState>(listener: (context, state) {
                if (state is RefreshScreenState) {
                  BlocProvider.of<BodyBloc>(context).add(LoadBody());
                }
            })
          ],
          child: BlocBuilder<BodyBloc, BodyState>(
            builder: (context, state) {
              return buildBody(context, state);
            },
          ),
        ));
  }
}

class DrawerWidget extends StatefulWidget {
  @override
  State<DrawerWidget> createState() => _DrawerState();
}

class _DrawerState extends State<DrawerWidget> with ScreenHelpers {
  User user;

  Widget buildDrawer(BuildContext context, DrawerState state) {
    if (state is LoadingDrawerState) {
      return LoadingIndicator();
    }
    return new Drawer(
      child: Column(
        children: <Widget>[
          Container(
            child: new DrawerHeader(
              child: Container(
                constraints: BoxConstraints.expand(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(user.name, textAlign: TextAlign.start, style: TextStyle(fontSize: 20, color: Color(0xFF3A3A3A))),
                  ],
                ),
              ),
              decoration: new BoxDecoration(
                color: Color(0xFFF3F4F5),
              ),
            ),
          ),
          new ListView(
            shrinkWrap: true,
            children: <Widget>[
              ListTile(
                title: Text(
                  "Students",
                  style: ThemeTextStyles.drawerMenuItem,
                ),
                leading: FaIcon(
                  FontAwesomeIcons.child,
                  color: ThemeColors.primaryColor,
                ),
                trailing: Icon(
                  Icons.arrow_right,
                  color: ThemeColors.primaryColor,
                ),
                onTap: () {
                  _navigate(context, routeStudentList);
                },
              ),
              ListTile(
                title: Text("Logout", style: ThemeTextStyles.drawerMenuItem),
                leading: Icon(
                  Icons.exit_to_app,
                  color: ThemeColors.primaryColor,
                ),
                trailing: Icon(
                  Icons.arrow_right,
                  color: ThemeColors.primaryColor,
                ),
                onTap: () {
                  BlocProvider.of<AuthBloc>(context).add(new LoggingOutEvent());
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) {
          return DrawerBloc(accountRepository: locator<AccountRepository>(), dataRepository: locator<DataRepository>())..add(LoadDrawer());
        },
        child: BlocListener<DrawerBloc, DrawerState>(
          listener: (context, state) {
            if (state is LoadedDrawerState) {
              setState(() {
                user = state.user;
              });
            }
          },
          child: BlocBuilder<DrawerBloc, DrawerState>(
            builder: (context, state) {
              return buildDrawer(context, state);
            },
          ),
        ));
  }

  _navigate(BuildContext context, String route) {
    locator<NavigationService>().navigateTo(route).then((value) {
      BlocProvider.of<ScreenBloc>(context).add(ScreenRefreshEvent());
      locator<NavigationService>().pop();
    });
  }
}

class HomeScreenArguments {
  final bool fromOnBoarding;

  HomeScreenArguments(this.fromOnBoarding);
}
