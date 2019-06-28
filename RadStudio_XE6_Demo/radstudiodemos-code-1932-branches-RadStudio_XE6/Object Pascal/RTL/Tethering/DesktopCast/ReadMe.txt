Open DesktopCast.groupproj, which has three projects inside.

VCLTetherDesktop offers actions to the other two, and supports taking an screenshot of the main screen and sending
 it to the connected clients. The actions Start/StopLiveCast will start/stop a timer that will send an screenshot every 5 seconds.

VCLTetherClient1 is the VCL client; run it and press Connect. Once Connected you can retrieve an screenshot pressing the 
takeFullScreenshot button, or press Start/StopLiveCast buttons to take one each 5 seconds.

FMXClientTetherDesktop is the mobile client and has the same behaviour as VCLTetherClient1.