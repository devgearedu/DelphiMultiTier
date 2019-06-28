
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit Frmmain;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, DB, StdCtrls;

type
  TFrmLauncher = class(TForm)
    BtnTrigg: TButton;
    BtnViews: TButton;
    BtnQrySP: TButton;
    BtnExecSP: TButton;
    BtnClose: TButton;
    BtnTrans: TButton;
    procedure BtnCloseClick(Sender: TObject);
    procedure BtnViewsClick(Sender: TObject);
    procedure BtnTriggClick(Sender: TObject);
    procedure BtnQrySPClick(Sender: TObject);
    procedure BtnExecSPClick(Sender: TObject);
    procedure BtnTransClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmLauncher: TFrmLauncher;

implementation

{$R *.dfm}

uses
   FrmExeSP,   { The Executable Stored Procedure Demo }
   FrmQrySP,   { The Query Stored Procedure demo }
   FrmTrans,   { The Transaction Editing demo }
   FrmTrigg,   { The Trigger Demo }
   FrmViews,   { The View Demo }
   Variants;

procedure TFrmLauncher.BtnCloseClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmLauncher.BtnViewsClick(Sender: TObject);
begin
  FrmViewDemo.ShowModal;
end;

procedure TFrmLauncher.BtnTriggClick(Sender: TObject);
begin
  FrmTriggerDemo.ShowModal;
end;

procedure TFrmLauncher.BtnQrySPClick(Sender: TObject);
begin
  FrmQueryProc.ShowModal;
end;

procedure TFrmLauncher.BtnExecSPClick(Sender: TObject);
begin
  FrmExecProc.ShowModal;
end;

procedure TFrmLauncher.BtnTransClick(Sender: TObject);
begin
  FrmTransDemo.ShowModal;
end;

end.
