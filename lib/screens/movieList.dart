import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:noname/screens/home_screen.dart';
import 'package:noname/models/movie.dart';
List<String> Names = [
  'Watch Later','Action Movies','Comedies','Horror', 'Favorite Movies','Shrek Movies'
];
List<Movie> movies = [];
enum SlidableAction{edit, details, delete}

void main() {
  //Widget testwidget = new MediaQuery(
  //    data: new MediaQueryData(),
  //    child: new MaterialApp(home: new SettingsPage()));
  runApp(NewMovieList());
}
class NewMovieList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'avenir'
      ),
      home: Home(),
    );
  }
}
class MovieList extends StatefulWidget {
  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {

  Widget buildListTile(String name) => ListTile(
    contentPadding: EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 16,
    ),
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 4),
        Text(name,
        style: TextStyle(
          color: Colors.white,)
        ),
      ],
    ),
    onTap: () {},
  );
  void dismissableSlidableItem(
      BuildContext context, int index, SlidableAction action) {
    setState(() {
      Names.removeAt(index);
    });

    switch (action) {
      case SlidableAction.delete:
        break;
    }
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff151c26),
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text("Movie List", style: TextStyle(
            fontSize: 25
        ),),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
          },//Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));},
        ),
      ),
      body:  new Container(
        child:
        new ListView.separated(
          reverse: false,
          separatorBuilder: (context, index) => Divider(),
          itemBuilder: (context,index){
            final name = Names[index];
            return SlidableWidget(
              child: buildListTile(name),
              onDismissed: (action) => dismissableSlidableItem(context, index, action),
            );
          },
          itemCount: Names.length,
        ),
      ),
    );
  }
}


class SlidableWidget<T> extends StatelessWidget {
  final Widget child;
  final Function(SlidableAction action) onDismissed;

  const SlidableWidget({
    @required this.child,
    @required this.onDismissed,
    Key key,
  }) : super(key: key);

  Widget build(BuildContext context) => Slidable(
    actionPane: SlidableDrawerActionPane(),
    child: child,
    /// right side
    secondaryActions: <Widget>[
      IconSlideAction(
        caption: 'Edit',
        color: Colors.white,
        icon: Icons.edit,
        onTap: () => onDismissed(SlidableAction.edit),
      ),
      IconSlideAction(
        caption: 'Details',
        color: Colors.white,
        icon: Icons.comment_rounded,
        onTap: () => onDismissed(SlidableAction.details),
      ),
      IconSlideAction(
        caption: 'Delete',
        color: Colors.red,
        icon: Icons.delete,
        onTap: () => onDismissed(SlidableAction.delete),
      ),
    ],
  );
}