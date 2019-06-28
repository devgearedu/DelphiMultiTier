unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Def, FireDAC.Phys.Intf,
  FireDAC.DatS, FireDAC.Stan.Param, FireDAC.DApt.Intf, StdCtrls, Grids, DBGrids,
  DB, FireDAC.Phys, FireDAC.Phys.MSAcc, FireDAC.VCLUI.Wait, FireDAC.Comp.UI, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TShowDataProc = procedure (ACliHandle: LongWord); stdcall;
  TShutdownProc = procedure; stdcall;

  TForm1 = class(TForm)
    FDConnection1: TFDConnection;
    FDQuery1: TFDQuery;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDPhysMSAccessDriverLink1: TFDPhysMSAccessDriverLink;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    FhDll: THandle;
    FpShowData: TShowDataProc;
    FpShutdown: TShutdownProc;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  FireDAC.Stan.Util;

procedure TForm1.Button1Click(Sender: TObject);
begin
  FhDll := LoadLibrary(PChar('Project2.dll'));
  if FhDll = 0 then
    raise Exception.Create(FDLastSystemErrorMsg);
  @FpShowData := GetProcAddress(FhDll, PChar('ShowData'));
  if not Assigned(FpShowData) then
    raise Exception.Create(FDLastSystemErrorMsg);
  @FpShutdown := GetProcAddress(FhDll, PChar('Shutdown'));
  if not Assigned(FpShutdown) then
    raise Exception.Create(FDLastSystemErrorMsg);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  FpShowData(FDConnection1.CliHandle);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  FpShutdown();
  FreeLibrary(FhDll);
  FhDll := 0;
  @FpShowData := nil;
  @FpShutdown := nil;
end;

end.
