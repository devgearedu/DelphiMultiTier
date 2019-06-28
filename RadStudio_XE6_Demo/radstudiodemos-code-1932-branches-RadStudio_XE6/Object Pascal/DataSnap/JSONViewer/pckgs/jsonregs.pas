
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit jsonregs;

// ***********************************************************************
//
//   JSON components desigh-time support
//
//   pawel.glowacki@embarcadero.com
//   July 2010
//
// ***********************************************************************


interface

{$R jsondoc.dcr}

procedure Register;

implementation

uses
  Classes, jsondoc, jsonparser, jsontreeview;

procedure Register;
begin
  RegisterComponents('JSON', [TJSONDocument, TJSONParser, TJSONTreeView]);
end;

end.
