import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:miniplayer/miniplayer.dart';

import '../../view_model/data_bloc/data_bloc_bloc.dart';
import '../audio_screen.dart';
import '../video_player_screen/mobile_app_player_screen.dart';
import '../video_player_screen/web_app_player_screen.dart';
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
    return Stack(
      children: [
         DefaultTabController(
        length: 3,
        child: SafeArea(
          child: Scaffold(
            body: const TabBarView(
                children: [VideosListWidget(), AudioScreen(), BiographyScreen()]),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                color: mode.brightness == Brightness.dark
                    ? DeviceConstraints.darkHeader
                    : DeviceConstraints.lightHeader,
              ),
              height: DeviceConstraints.bottomNavBarHeight,
              child: TabBar(
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
            ),
          ),
        ),
      ),
      PlayerScreen()
      ],
      
    );
  }
}

class PlayerScreen extends StatelessWidget {
  const PlayerScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final deviceHeight= MediaQuery.of(context).size.height;
    // final miniplayerController=context.read<DataRepo>().miniplayerController;
    return  BlocBuilder<DataBlocBloc, DataBlocState>(
            builder: (context, state) {
              if(state is LaodedState && state.videoDataModel!=null){
                return Miniplayer(
              minHeight: deviceHeight *0.1,
              maxHeight: deviceHeight,
              // controller: miniplayerController,
              valueNotifier: ValueNotifier(deviceHeight),//to show video in
              // maxheight by default
             builder: (height, percentage) {
               return 
                   Center(child: Row(
                         children: [
                           Expanded(
                           
                            child: 
                     kIsWeb
                    ? WebAppPlayerScreen(videoDataModel: state.videoDataModel!)
                    : MobileAppPlayerScreen(videoData:state.videoDataModel!),
                            ),
                            if(height== deviceHeight *0.1)
                            Expanded(child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Text(state.videoDataModel!.videoDescription),
                                  ),
                                ),
                                Expanded(child: IconButton(onPressed: () => context.read<DataBlocBloc>().add(CancelMiniPlayerEvent()), icon: Text("X",style: TextStyle(fontSize: 24),),),)
                              ],
                            ))
                           ],
                       ));
               
               
              //  PlayerScreen(miniplayerController: miniplayerController,videoDataModel: state.videoDataModel!,playerHeight: height,);
             }, 
            );
              }
              return Container();//show nothing if there is no active video
            },
            
          );
    

  }
}
