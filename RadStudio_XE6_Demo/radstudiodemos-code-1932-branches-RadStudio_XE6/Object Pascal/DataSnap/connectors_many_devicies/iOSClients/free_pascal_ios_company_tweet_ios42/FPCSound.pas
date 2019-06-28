unit FPCSound;
{$IFDEF FPC}
{$MODESWITCH ObjectiveC1}
{$LINKFRAMEWORK AVFoundation}
{$LINKFRAMEWORK AudioToolbox}
{$ENDIF}

interface

uses DSRESTTypes
{$IFDEF FPC}
    , iPhoneAll
{$ENDIF};

{$IFDEF FPC}

type
  SystemSoundID = UInt32;
  AVAudioPlayer = objcclass external(NSObject)
    public function initWithContentsOfURL_error(url: NSURL;
    outError: NSErrorPointer): id;
message 'initWithContentsOfURL:error:';

function AVplay: Boolean; message 'play';
end;

const
  kSystemSoundID_Vibrate = $00000FFF;

var
  snd: AVAudioPlayer;
procedure AudioServicesPlaySystemSound(inSystemSoundID: SystemSoundID);
  external name '_AudioServicesPlaySystemSound';

procedure PlaySound(sndFileName: NSString);
{$ENDIF}

implementation

{$IFDEF FPC}

procedure PlaySound(sndFileName: NSString);
var
  path: NSString;
  url: NSURL;
  err: NSError;
begin
  path := NSBundle.mainBundle.resourcePath.stringByAppendingPathComponent
    (sndFileName);
  url := NSURL.fileURLWithPath(path);
  snd := AVAudioPlayer.alloc.initWithContentsOfURL_error(url, @err).autorelease;
  if Assigned(snd) then
    snd.AVplay
  else
    NSlog(err.description);
end;
{$ENDIF}

end.
