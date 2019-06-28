unit DBXConnectionEventListener;
{$IFDEF FPC}
{$mode DELPHI}
{$ENDIF}

interface

uses DSRESTTypes
{$IFDEF FPC}
    , iphoneALL
{$ENDIF};

type
{$IFDEF FPC}
  TDBXConnectionEventHook = objcclass(NSObject)
{$ELSE}
    TDBXConnectionEventHook = class
{$ENDIF}
    public function connection_willSendRequest_redirectResponse
    (connection: NSURLConnection; request: NSURLRequest;
    response: NSURLResponse): NSURLRequest;
{$IFDEF FPC} override;
message 'connection:willSendRequest:redirectResponse:'; {$ENDIF}
function connection_needNewBodyStream(connection: NSURLConnection;
  request: NSURLRequest): NSInputStream;
{$IFDEF FPC} override; message 'connection:needNewBodyStream:'; {$ENDIF}
function connection_canAuthenticateAgainstProtectionSpace
  (connection: NSURLConnection; protectionSpace: NSURLProtectionSpace): boolean;
{$IFDEF FPC} override;
  message 'connection:canAuthenticateAgainstProtectionSpace:'; {$ENDIF}
procedure connection_didReceiveAuthenticationChallenge
  (connection: NSURLConnection; challenge: NSURLAuthenticationChallenge);
{$IFDEF FPC} override; message 'connection:didReceiveAuthenticationChallenge:';
{$ENDIF}
procedure connection_didCancelAuthenticationChallenge
  (connection: NSURLConnection; challenge: NSURLAuthenticationChallenge);
{$IFDEF FPC}override; message 'connection:didCancelAuthenticationChallenge:';
{$ENDIF}
function connectionShouldUseCredentialStorage
  (connection: NSURLConnection): boolean;
{$IFDEF FPC} override; message 'connectionShouldUseCredentialStorage:'; {$ENDIF}
procedure connection_didReceiveResponse(connection: NSURLConnection;
  response: NSURLResponse);
{$IFDEF FPC} override; message 'connection:didReceiveResponse:'; {$ENDIF}
procedure connection_didReceiveData(connection: NSURLConnection; data: NSData);
{$IFDEF FPC} override; message 'connection:didReceiveData:'; {$ENDIF}
procedure connection_didSendBodyData_totalBytesWritten_totalBytesExpectedToWrite
  (connection: NSURLConnection; bytesWritten: NSInteger;
  totalBytesWritten: NSInteger; totalBytesExpectedToWrite: NSInteger);

{$IFDEF FPC}override;
  message 'connection:didSendBodyData:totalBytesWritten:totalBytesExpectedToWrite:';
{$ENDIF}
procedure connectionDidFinishLoading(connection: NSURLConnection);
{$IFDEF FPC}override; message 'connectionDidFinishLoading:'; {$ENDIF}
procedure connection_didFailWithError(connection: NSURLConnection;
  error: NSError);
{$IFDEF FPC} override; message 'connection:didFailWithError:'; {$ENDIF}
function connection_willCacheResponse(connection: NSURLConnection;
  cachedResponse: NSCachedURLResponse): NSCachedURLResponse;
{$IFDEF FPC} override; message 'connection:willCacheResponse:'; {$ENDIF}
end;

implementation

{ TDBXConnectionEventHook }

procedure TDBXConnectionEventHook.connectionDidFinishLoading(
  connection: NSURLConnection);
begin

end;

function TDBXConnectionEventHook.connectionShouldUseCredentialStorage(
  connection: NSURLConnection): boolean;
begin

end;

function TDBXConnectionEventHook.connection_canAuthenticateAgainstProtectionSpace(
  connection: NSURLConnection; protectionSpace: NSURLProtectionSpace): boolean;
begin

end;

procedure TDBXConnectionEventHook.connection_didCancelAuthenticationChallenge(
  connection: NSURLConnection; challenge: NSURLAuthenticationChallenge);
begin

end;

procedure TDBXConnectionEventHook.connection_didFailWithError(
  connection: NSURLConnection; error: NSError);
begin

end;

procedure TDBXConnectionEventHook.connection_didReceiveAuthenticationChallenge(
  connection: NSURLConnection; challenge: NSURLAuthenticationChallenge);
begin

end;

procedure TDBXConnectionEventHook.connection_didReceiveData(
  connection: NSURLConnection; data: NSData);
begin

end;

procedure TDBXConnectionEventHook.connection_didReceiveResponse(
  connection: NSURLConnection; response: NSURLResponse);
begin

end;

procedure TDBXConnectionEventHook.connection_didSendBodyData_totalBytesWritten_totalBytesExpectedToWrite(
  connection: NSURLConnection; bytesWritten, totalBytesWritten,
  totalBytesExpectedToWrite: NSInteger);
begin

end;

function TDBXConnectionEventHook.connection_needNewBodyStream(
  connection: NSURLConnection; request: NSURLRequest): NSInputStream;
begin

end;

function TDBXConnectionEventHook.connection_willCacheResponse(
  connection: NSURLConnection;
  cachedResponse: NSCachedURLResponse): NSCachedURLResponse;
begin

end;

function TDBXConnectionEventHook.connection_willSendRequest_redirectResponse(
  connection: NSURLConnection; request: NSURLRequest;
  response: NSURLResponse): NSURLRequest;
begin

end;

end.
