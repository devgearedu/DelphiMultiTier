
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit ctUser;

interface

uses
  Classes;

type
  TUser = class
  private
    FFollowers: TStringList;
    FFollowing: TStringList;
    FUserName: string;
    procedure SetFollowers(const Value: TStringList);
    procedure SetUserName(const Value: string);
    procedure SetFollowing(const Value: TStringList);
  public
    constructor Create(UserName: string); virtual;
    destructor Destroy; override;
  published
    property UserName: string read FUserName write SetUserName;
    property Followers: TStringList read FFollowers write SetFollowers;
    property Following: TStringList read FFollowing write SetFollowing;
  end;

implementation

{ TctUser }

constructor TUser.Create(UserName: string);
begin
  inherited Create;
  FUserName := UserName;
  FFollowers := TStringList.Create;
  FFollowing := TStringList.Create
end;

destructor TUser.Destroy;
begin
  FFollowers.Free;
  FFollowing.Free;
  inherited;
end;

procedure TUser.SetFollowers(const Value: TStringList);
begin
  FFollowers := Value;
end;

procedure TUser.SetFollowing(const Value: TStringList);
begin
  FFollowing := Value;
end;

procedure TUser.SetUserName(const Value: string);
begin
  FUserName := Value;
end;

end.
