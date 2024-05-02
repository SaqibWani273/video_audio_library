import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../view_model/data_bloc/data_bloc_bloc.dart';
import '../audio_screen.dart';
import '/constants/device_constraints.dart';
import '/view/biography/biography_screen.dart';
import 'widgets/videos_list_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentNavBarIndex = 0;
  var currentBottomNavBarIndex = 0;

  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    
    ThemeData mode = Theme.of(context);
    return 
    
    BlocBuilder<DataBlocBloc, DataBlocState>(builder: (context, state) {
      if(state is LaodedState && state.isMaxPlayer==true){
        return     const DefaultTabController(
            length: 3,
            child: SafeArea(
     child: Scaffold(
       body: TabBarView(
           children: [VideosListWidget(), AudioScreen(), BiographyScreen()]),
       bottomNavigationBar:
                 null)));
      }
      return 
    DefaultTabController(
            length: 3,
            child: SafeArea(
     child: Scaffold(
       body: const TabBarView(
           children: [VideosListWidget(), AudioScreen(), BiographyScreen()]),
       bottomNavigationBar:
                 Container(
          // color: Colors.transparent,
         decoration: BoxDecoration(
           color: mode.brightness == Brightness.dark
               ? DeviceConstraints.darkHeader
               : DeviceConstraints.lightHeader,
         ),
         height: DeviceConstraints.bottomNavBarHeight,
         child: 
         TabBar(
             tabs: const [
               Tab(
                 icon: Icon(Icons.video_settings),
                 text: "VIDEO",
               ),
               Tab(
                 icon: Icon(Icons.audio_file_outlined),
                 text: "AUDIO",
               ),
               Tab(
                 icon: Icon(Icons.person),
                 text: "BIOGRAPHY",
               )
             ],
             labelStyle: GoogleFonts.montserrat(
                 fontWeight: FontWeight.w600,
                 color: mode.brightness == Brightness.dark
                     ? DeviceConstraints.darkText
                     : DeviceConstraints.lightText)),
       ))));
       } ,//make it null whenever video 
       //is in fullscreen(i.e. not in miniplayer) mode

    );
    }
    
  }


