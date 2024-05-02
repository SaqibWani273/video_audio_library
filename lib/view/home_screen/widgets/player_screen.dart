
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miniplayer/miniplayer.dart';

import '../../../view_model/data_bloc/data_bloc_bloc.dart';
import '../../video_player_screen/mobile_app_player_screen.dart';
import '../../video_player_screen/web_app_player_screen.dart';

class PlayerScreen extends StatelessWidget {
  const PlayerScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final deviceHeight= MediaQuery.of(context).size.height;
    final bottomStatusBarHeight=MediaQuery.of(context).viewPadding.bottom;
    // final miniplayerController=context.read<DataRepo>().miniplayerController;
    return  BlocBuilder<DataBlocBloc, DataBlocState>(
            builder: (context, state) {
              if(state is LaodedState && state.videoDataModel!=null){
                log("rebuild playerscreen");
                return Miniplayer(
                  // backgroundColor: Colors.blue,
              minHeight: deviceHeight*0.08+bottomStatusBarHeight,
              maxHeight: deviceHeight,
              // controller: miniplayerController,
              valueNotifier: ValueNotifier(deviceHeight),//to show video in
              // maxheight by default
             builder: (height, percentage) {
              if(height==deviceHeight){
                context.read<DataBlocBloc>().add(ShowMaxPlayerEvent(videoDataModel: state.videoDataModel!));
              }else{
                context.read<DataBlocBloc>().add(ShowMiniPlayerEvent(videoDataModel: state.videoDataModel!));
              }
               return 
               Container(
                margin: EdgeInsets.only(bottom: bottomStatusBarHeight),
                 child: Row(
                   mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                            
                             child: 
                      kIsWeb
                     ? WebAppPlayerScreen(videoDataModel: state.videoDataModel!)
                     : MobileAppPlayerScreen(videoData:state.videoDataModel!),
                             ),
                             if(height==  deviceHeight*0.08+bottomStatusBarHeight)
                             Expanded(child: Row(
                               mainAxisSize: MainAxisSize.min,
                               children: [
                                 Expanded(
                                   child: Padding(
                                     padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                     child: Text(state.videoDataModel!.videoDescription),
                                   ),
                                 ),
                                 Expanded(child: IconButton(onPressed: () => context.read<DataBlocBloc>().add(CancelMiniPlayerEvent()), icon: const Text("X",style: TextStyle(fontSize: 24),),),)
                               ],
                             ))
                            ],
                        ),
               );
               
               
              //  PlayerScreen(miniplayerController: miniplayerController,videoDataModel: state.videoDataModel!,playerHeight: height,);
             }, 
            );
              }
              return Container();//show nothing if there is no active video
            },
            
          );
    

  }
}