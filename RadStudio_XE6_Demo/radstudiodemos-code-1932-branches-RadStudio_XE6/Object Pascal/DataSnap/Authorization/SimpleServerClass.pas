
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit SimpleServerClass;

interface
  uses DSServer, Classes, SysUtils, DSCommonServer, DBXCommon, DSReflect;

type
  TSimpleServerClass = class(TDSServerClass)
  private
    FPersistentClass: TPersistentClass;
  protected
    function GetDSClass: TDSClass; override;
  public
    constructor Create(AOwner: TComponent; AServer: TDSCustomServer; AClass: TPersistentClass); reintroduce;overload;
  end;

implementation

constructor TSimpleServerClass.Create(AOwner: TComponent; AServer: TDSCustomServer; AClass: TPersistentClass);
begin
  inherited Create(AOwner);
  FPersistentClass := AClass;
  Self.Server := AServer;
end;

function TSimpleServerClass.GetDSClass: TDSClass;
begin
  Result := TDSClass.Create(FPersistentClass, False);
end;

end.
