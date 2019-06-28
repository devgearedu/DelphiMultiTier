unit fMainConnectionDefBase;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
    Grids, DBGrids, DB, StdCtrls, ComCtrls, ExtCtrls, Buttons, 
  fMainBase,
  FireDAC.Stan.Option, FireDAC.Stan.Intf,
  FireDAC.Phys.Intf;

type
  TfrmMainConnectionDefBase = class(TfrmMainBase)
    lblUseConnectionDef: TLabel;
    pnlConnection: TPanel;
    cbDB: TComboBox;
    procedure cbDBClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure GetConnectionDefs(AList: TStrings); virtual; abstract;
    procedure SetConnDefName(AConnDefName: String); virtual; abstract;
    procedure ConnectionActive(AValue: Boolean); virtual; abstract;
    function GetFormatOptions: TFDFormatOptions; virtual; abstract;
    function GetRDBMSKind: TFDRDBMSKind; virtual; abstract;
  public
    { Public declarations }
  end;

var
  frmMainConnectionDefBase: TfrmMainConnectionDefBase;

implementation

{$R *.dfm}

{ ---------------------------------------------------------------------------- }
procedure TfrmMainConnectionDefBase.FormCreate(Sender: TObject);
begin
  GetConnectionDefs(cbDB.Items);
end;

{ ---------------------------------------------------------------------------- }
procedure TfrmMainConnectionDefBase.cbDBClick(Sender: TObject);
begin
  cbDB.DroppedDown := False;
  ConnectionActive(False);
  SetConnDefName(cbDB.Text);
  ConnectionActive(True);
  case GetRDBMSKind of
  mkMSSQL,
  mkMSAccess,
  mkASA:
    with GetFormatOptions do begin
      OwnMapRules := True;
      MapRules.Clear;
      with MapRules.Add do begin
        SourceDataType := dtWideString;
        TargetDataType := dtAnsiString;
      end;
      // FormatOptions.StrsDivLen2 := False;
    end;
  mkOracle:
    with GetFormatOptions do begin
      OwnMapRules := True;
      MapRules.Clear;
      MaxBcdPrecision := 0;
      with MapRules.Add do begin
        PrecMax := 10;
        PrecMin := 6;
        ScaleMax := 0;
        ScaleMin := 0;
        SourceDataType := dtFmtBCD;
        TargetDataType := dtInt32;
      end;
      with MapRules.Add do begin
        PrecMax := 5;
        PrecMin := 3;
        ScaleMax := 0;
        ScaleMin := 0;
        SourceDataType := dtFmtBCD;
        TargetDataType := dtInt16;
      end;
      with MapRules.Add do begin
        PrecMax := 38;
        PrecMin := 38;
        SourceDataType := dtFmtBCD;
        TargetDataType := dtDouble;
      end;
      with MapRules.Add do begin
        PrecMax := 2;
        PrecMin := 0;
        SourceDataType := dtFmtBCD;
        TargetDataType := dtBoolean;
      end;
      with MapRules.Add do begin
        SourceDataType := dtWideString;
        TargetDataType := dtAnsiString;
      end;
      with MapRules.Add do begin
        PrecMax := 19;
        PrecMin := 4;
        SourceDataType := dtFmtBCD;
        TargetDataType := dtCurrency;
      end;
      with MapRules.Add do begin
        SourceDataType := dtDateTime;
        TargetDataType := dtDateTimeStamp;
      end;
      // Following is required for Borland Oracle dbExp driver &
      // NVARCHAR/NVARCHAR2/NCHAR fields.
      // FormatOptions.StrsDivLen2 := True;
    end;
  mkMySQL:
    with GetFormatOptions do begin
      OwnMapRules := True;
      MapRules.Clear;
      with MapRules.Add do begin
        SourceDataType := dtSByte;
        TargetDataType := dtBoolean;
      end;
      with MapRules.Add do begin
        SourceDataType := dtDateTime;
        TargetDataType := dtDateTimeStamp;
      end;
      with MapRules.Add do begin
        PrecMax := 19;
        PrecMin := 4;
        SourceDataType := dtFmtBCD;
        TargetDataType := dtCurrency;
      end;
    end;
  mkDB2:
    with GetFormatOptions do begin
      OwnMapRules := True;
      MapRules.Clear;
      MaxBcdPrecision := 0;
      with MapRules.Add do begin
        PrecMax := 2;
        PrecMin := 0;
        SourceDataType := dtFmtBCD;
        TargetDataType := dtBoolean;
      end;
      with MapRules.Add do begin
        PrecMax := 19;
        PrecMin := 4;
        SourceDataType := dtFmtBCD;
        TargetDataType := dtCurrency;
      end;
      with MapRules.Add do begin
        SourceDataType := dtWideString;
        TargetDataType := dtAnsiString;
      end;
      with MapRules.Add do begin
        SourceDataType := dtDate;
        TargetDataType := dtDateTimeStamp;
      end;
    end;
  mkInterbase,
  mkPostgreSQL,
  mkSQLite:
    with GetFormatOptions do begin
      OwnMapRules := True;
      MapRules.Clear;
      MaxBcdPrecision := 0;
      with MapRules.Add do begin
        PrecMax := 19;
        PrecMin := 4;
        SourceDataType := dtFmtBCD;
        TargetDataType := dtCurrency;
      end;
      with MapRules.Add do begin
        SourceDataType := dtWideString;
        TargetDataType := dtAnsiString;
      end;
      with MapRules.Add do begin
        SourceDataType := dtDate;
        TargetDataType := dtDateTimeStamp;
      end;
      with MapRules.Add do begin
        SourceDataType := dtDateTime;
        TargetDataType := dtDateTimeStamp;
      end;
    end;
  mkADS:
    with GetFormatOptions do begin
      OwnMapRules := True;
      MapRules.Clear;
      with MapRules.Add do begin
        SourceDataType := dtDate;
        TargetDataType := dtDateTimeStamp;
      end;
    end;
  end;
end;

end.
