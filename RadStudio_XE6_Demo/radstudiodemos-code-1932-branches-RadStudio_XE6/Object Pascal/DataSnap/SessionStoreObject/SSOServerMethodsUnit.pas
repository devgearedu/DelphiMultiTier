
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit SSOServerMethodsUnit;

interface

uses System.SysUtils, System.Classes, Datasnap.DSServer, Datasnap.DSAuth;

type
  TMySessionClass = class
  private
    Fa: String;
    Fb: String;
    Fc: String;
  public
    property a: String read Fa write Fa;
    property b: String read Fb write Fb;
    property c: String read Fc write Fc;
  end;

{$METHODINFO ON}
  TServerMethods1 = class(TComponent)
  public
    function EchoString(Value: string): string;
    function ReverseString(Value: string): string;

    function StoreObject(key,a,b,c: string): string;
    procedure GetObject(key: string; out a,b,c: string);
  end;
{$METHODINFO OFF}

implementation


uses System.StrUtils, Datasnap.DSSession, SessionStoreObjectUI;

function TServerMethods1.EchoString(Value: string): string;
begin
  Result := Value;
end;

function TServerMethods1.ReverseString(Value: string): string;
begin
  Result := System.StrUtils.ReverseString(Value);
end;

function TServerMethods1.StoreObject(key, a, b, c: string): string;
var
  Session: TDSSession;
  Inst: TMySessionClass;
  Dest: String;
begin
  Session := TDSSessionManager.GetThreadSession;
  if Assigned(Session) then
  begin
    Inst := TMySessionClass.Create;
    Inst.a := a;
    Inst.b := b;
    Inst.c := c;
    Session.PutObject(key, Inst);

    //return the URL wish Session ID in it for
    //testing getting the session data back
    Dest := 'http://localhost:8080/datasnap/rest/TServerMethods1/GetObject/' + key + '?sid=' + Session.SessionName;

    Form3.SetThenText(Dest);

    Exit(Dest);
  end;

  Result := 'Failed to add the object to the session';
end;

procedure TServerMethods1.GetObject(key: string; out a, b, c: string);
var
  Session: TDSSession;
  Inst: TMySessionClass;
begin
  Session := TDSSessionManager.GetThreadSession;
  if Assigned(Session) then
  begin
    Inst := TMySessionClass(Session.GetObject(key));
    if Assigned(Inst) then
    begin
      a := Inst.a;
      b := Inst.b;
      c := Inst.c;
      Exit;
    end;
  end;
  a := 'Failed to load data for key: ' + key;
end;

end.

