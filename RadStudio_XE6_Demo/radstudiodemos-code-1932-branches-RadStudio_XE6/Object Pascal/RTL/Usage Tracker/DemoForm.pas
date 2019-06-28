
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit DemoForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, MemoryManagerUsageTracker;

type
  TfDemo = class(TForm)
    bShowTracker: TButton;
    gbMinimumBlockAlignment: TGroupBox;
    Label1: TLabel;
    cbMinimumBlockAlignment: TComboBox;
    procedure cbMinimumBlockAlignmentChange(Sender: TObject);
    procedure bShowTrackerClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fDemo: TfDemo;

implementation

{$R *.dfm}

procedure TfDemo.bShowTrackerClick(Sender: TObject);
begin
  ShowMemoryManagerUsageTracker;
end;

procedure TfDemo.cbMinimumBlockAlignmentChange(Sender: TObject);
begin
  if cbMinimumBlockAlignment.ItemIndex = 0 then
    SetMinimumBlockAlignment(mba8Byte)
  else
    SetMinimumBlockAlignment(mba16Byte);
end;

end.
