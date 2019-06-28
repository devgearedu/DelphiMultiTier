unit LockedStringListU;

interface

uses
  Classes, SysUtils, FMX_Types
  {$IFNDEF FPC}
    , Winapi.Windows
{$ELSE}
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  ,cthreads
  {$ENDIF}{$ENDIF}{$ENDIF}
  ;

type
  TLockedStringList = class
  private
    SL: TStringList;
    CS: TRTLCriticalSection;
  protected
    constructor Create;
    destructor Destroy; override;
  public
    function GetLockedStringList: TStringList;
    procedure Add(const Value: String);
    procedure UnLock;
    class function Instance: TLockedStringList;
  end;

  TCMDLockedStringList = class(TLockedStringList)
    public
    class function Instance: TCMDLockedStringList;
  end;

implementation

var
  FInstance: TLockedStringList = nil;
  FCMDInstance: TCMDLockedStringList = nil;

{ TLockedStringList }

procedure TLockedStringList.Add(const Value: String);
begin
  EnterCriticalSection(CS);
  SL.Add(Value);
  LeaveCriticalSection(CS);
end;


constructor TLockedStringList.Create;
begin
  inherited Create;
{$IFNDEF FPC}
  InitializeCriticalSection(CS);
{$ELSE}
  InitCriticalSection(CS);
{$ENDIF}

  SL := TStringList.Create;
end;


destructor TLockedStringList.Destroy;
begin
  EnterCriticalSection(CS);
  SL.Free;
  SL := nil;
{$IFNDEF FPC}
  DeleteCriticalSection(CS);
{$ELSE}
  DoneCriticalSection(CS);
{$ENDIF}
  inherited;
end;

function TLockedStringList.GetLockedStringList: TStringList;
begin
  EnterCriticalSection(CS);
  Result := SL;
end;

class function TLockedStringList.Instance: TLockedStringList;
begin
  if FInstance = nil then
    FInstance := TLockedStringList.Create;
  Result := FInstance;
end;

procedure TLockedStringList.UnLock;
begin
  LeaveCriticalSection(CS);
end;

{ TCMDLockedStringList }

class function TCMDLockedStringList.Instance: TCMDLockedStringList;
begin
  if FCMDInstance = nil then
    FCMDInstance := TCMDLockedStringList.Create;
  Result := FCMDInstance;
end;

initialization

finalization
  if assigned(FInstance) then
    FreeAndNil(FInstance);

  if assigned(FCMDInstance) then
    FreeAndNil(FCMDInstance);

end.
