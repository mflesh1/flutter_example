import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_example/components/components.dart';
import 'package:flutter_example/components/mixins/screen.dart';
import 'package:flutter_example/models/barrel.dart';
import 'package:flutter_example/theme/constants.dart';
import 'package:flutter_example/theme/theme.dart';

import 'bloc/barrel.dart';

class StudentListingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Students"),
      ),
      body: Body(),
    );
  }
}

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> with ScreenHelpers {
  List students = [];

  Widget buildNoDataAvailable(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          SizedBox(height: Constants.paragraphPadding),
          Text('No data.'),
        ],
      ),
    );
  }

  Widget buildBody(BuildContext context, ScreenState state) {
    if (state is FetchingStudents) {
      return LoadingIndicator();
    }

    return Stack(
      fit: StackFit.expand,
      children: <Widget>[buildList(context), buildFabAdd(context)],
    );
  }


  Widget buildList(BuildContext context) {

    if (students.isEmpty) {
      return buildNoDataAvailable(context);
    }

    return ListView.builder(
      itemCount: students.length,
      itemBuilder: (BuildContext context, int index) {
        return buildListItem(context, students[index]);
      },
    );
  }

  Widget buildListItem(BuildContext context, Student student) {
    return Slidable(
      actionPane: SlidableBehindActionPane(),
      actionExtentRatio: 0.25,
      key: ValueKey(student.id),
      child: ListTile (
        title: new Text(student.name),
        subtitle: Text(student.schoolName),
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FaIcon(
              FontAwesomeIcons.child,
              color: ThemeColors.primaryColor,
            ),
          ],
        ),
        trailing: Icon(
          Icons.arrow_right,
          color: ThemeColors.primaryColor,
        ),
        onTap: () {
          showInfoMessage(context, "Student Detail!");
        },
      ),
      secondaryActions: <Widget>[
        IconSlideAction(
            caption: 'Delete',
            color: Colors.red,
            icon: Icons.delete_forever,
            onTap: () {
              BlocProvider.of<ScreenBloc>(context).add(DeleteStudent(student.id));
            }),
      ],
    );
  }

  Widget buildFabAdd(BuildContext context) {
    return Positioned(
      bottom: 15,
      right: 15,
      child: FloatingActionButton(
        heroTag: 'current',
        onPressed: () {
        },
        child: Icon(Icons.add),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) {
          return ScreenBloc()
            ..add(GetStudents());
        },
        child: BlocListener<ScreenBloc, ScreenState>(
          listener: (context, state) {
            if (state is FetchedStudents) {
              if (state.error != null) {
                showErrorMessage(context, state.error);
              } else {
                students = state.students;
              }
            }
            if (state is DeleteStudentFailed) {
              showErrorMessage(context, state.error);
            }
          },
          child: BlocBuilder<ScreenBloc, ScreenState>(
            builder: (context, state) {
              return buildBody(context, state);
            },
          ),
        ));
  }


}