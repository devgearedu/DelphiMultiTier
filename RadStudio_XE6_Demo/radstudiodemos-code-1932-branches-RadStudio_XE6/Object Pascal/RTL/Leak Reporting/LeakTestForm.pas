
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit LeakTestForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfLeakTestForm = class(TForm)
    bLeak: TButton;
    bLeakAndRegister: TButton;
    Label1: TLabel;
    cbLeakReportingEnabled: TComboBox;
    bTestUnregister: TButton;
    procedure bTestUnregisterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbLeakReportingEnabledChange(Sender: TObject);
    procedure bLeakAndRegisterClick(Sender: TObject);
    procedure bLeakClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fLeakTestForm: TfLeakTestForm;

implementation

{$R *.dfm}

procedure TfLeakTestForm.bLeakClick(Sender: TObject);
begin
  TObject.Create;
end;

procedure TfLeakTestForm.bLeakAndRegisterClick(Sender: TObject);
var
  LObject: TObject;
begin
  LObject := TObject.Create;
  RegisterExpectedMemoryLeak(LObject);
end;

procedure TfLeakTestForm.cbLeakReportingEnabledChange(Sender: TObject);
begin
  ReportMemoryLeaksOnShutdown := cbLeakReportingEnabled.ItemIndex = 1;
end;

procedure TfLeakTestForm.FormCreate(Sender: TObject);
begin
  ReportMemoryLeaksOnShutdown := True;
end;

procedure TfLeakTestForm.bTestUnregisterClick(Sender: TObject);
var
  LObject: TObject;
begin
  LObject := TObject.Create;
  RegisterExpectedMemoryLeak(LObject);
  LObject.Free;
  UnregisterExpectedMemoryLeak(LObject);
end;

end.
