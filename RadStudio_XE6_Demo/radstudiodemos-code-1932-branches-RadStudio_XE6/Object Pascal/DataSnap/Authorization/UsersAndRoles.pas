
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit UsersAndRoles;

interface

uses Classes;

type
  TUserRoleItem = class(TCollectionItem)
  private
    FUserNames: TStrings;
    FRoles: TStrings;
    procedure SetRoles(const Value: TStrings);
    procedure SetUserNames(const Value: TStrings);
    procedure Changed;
  protected
    procedure AssignTo(Dest: TPersistent); override;
  public
    constructor Create(Collection: TCollection); overload; override;
    destructor Destroy; override;
    property UserNames : TStrings read FUserNames write SetUserNames;
    property Roles : TStrings read FRoles write SetRoles;
  end;

  TUserRoleItems = class(TCollection)
  private
    FOwner: TPersistent;
  protected
    function GetOwner: TPersistent; override;
    function GetItem(Index: Integer): TUserRoleItem;
    procedure SetItem(Index: Integer; const Value: TUserRoleItem);
  public
    constructor Create(AOwner: TPersistent); virtual;
    property Items[Index: Integer]: TUserRoleItem read GetItem write SetItem; default;
  end;

implementation


{ TUserRoleItem }

procedure TUserRoleItem.AssignTo(Dest: TPersistent);
begin
  if Dest.InheritsFrom(TUserRoleItem) then
  begin
    TUserRoleItem(Dest).FUserNames.Assign(FUserNames);
    TUserRoleItem(Dest).FRoles.Assign(FRoles);
  end
  else
    inherited;
end;

procedure TUserRoleItem.Changed;
begin
  // TODO: If there is a list of TRoleAuth then clear it here because something changed
end;

constructor TUserRoleItem.Create(Collection: TCollection);
begin
  inherited;
  FUserNames := TStringList.Create;
  FRoles := TStringList.Create;
end;

destructor TUserRoleItem.Destroy;
begin
  FUserNames.Free;
  FRoles.Free;
  inherited;
end;

procedure TUserRoleItem.SetUserNames(const Value: TStrings);
begin
  Changed;
  FUserNames.Assign(Value);
end;

procedure TUserRoleItem.SetRoles(const Value: TStrings);
begin
  Changed;
  FRoles.Assign(Value);
end;

{ TUserRoleItems }

constructor TUserRoleItems.Create(AOwner: TPersistent);
begin
  FOwner := AOwner;
  inherited Create(TUserRoleItem);
end;

function TUserRoleItems.GetItem(Index: Integer): TUserRoleItem;
begin
  Result := TUserRoleItem(inherited GetItem(Index));
end;

function TUserRoleItems.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

procedure TUserRoleItems.SetItem(Index: Integer; const Value: TUserRoleItem);
begin
  inherited SetItem(Index, Value);
end;

initialization
end.
