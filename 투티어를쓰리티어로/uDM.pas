unit Udm;

interface

uses
  System.SysUtils, System.Classes,System.DateUtils,
  Datasnap.DBClient, Datasnap.DSConnect, Data.DbxDatasnap, Data.DBXCommon,
  IPPeerClient, Data.SqlExpr, UClientClass, Data.DB;

type
  TDM = class(TDataModule)
    InsaQuerySource: TDataSource;
    DeptSource: TDataSource;
    InsaSource: TDataSource;
    DSProviderConnection1: TDSProviderConnection;
    Dept: TClientDataSet;
    insa: TClientDataSet;
    insaquery: TClientDataSet;
    fdConnection1: TSQLConnection;
    insaID: TIntegerField;
    insaNAME: TStringField;
    insaAGE: TSmallintField;
    insaDEPT_CODE: TStringField;
    insaIPSA_DATE: TDateField;
    insaCLASS: TStringField;
    insaSALARY: TIntegerField;
    insaPHOTO: TBlobField;
    insaGRADE: TStringField;
    insaduring: TIntegerField;
    insatax: TFloatField;
    insasection: TStringField;
    procedure insaCalcFields(DataSet: TDataSet);
    procedure insaBeforeInsert(DataSet: TDataSet);
    procedure insaNewRecord(DataSet: TDataSet);
    procedure InsaSourceStateChange(Sender: TObject);
    procedure InsaSourceDataChange(Sender: TObject; Field: TField);
    procedure DeptSourceDataChange(Sender: TObject; Field: TField);
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure insaReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;
  demo_Client : TServerMethods1Client;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses UInsa, Vcl.RecError;

{$R *.dfm}

procedure TDM.DataModuleCreate(Sender: TObject);
begin
   demo_client := TServerMethods1Client.Create(fdconnection1.DBXConnection);
end;

procedure TDM.DataModuleDestroy(Sender: TObject);
begin
  demo_client.Free;
end;

procedure TDM.DeptSourceDataChange(Sender: TObject; Field: TField);
begin
  InsaQuery.Close;
  InsaQuery.ParamByName('code').AsString :=
  DM.Dept.Fields[0].AsString;
  InsaQuery.Open;
end;

procedure TDM.insaBeforeInsert(DataSet: TDataSet);
begin
    InsaForm.DBEdit2.SetFocus;
end;

procedure TDM.InsaCalcFields(DataSet: TDataSet);
var
 yy1,mm1,dd1:word;
 yy2,mm2,dd2:word;
begin
  DecodeDate(Now, yy1,mm1,dd1);
  DecodeDate(DM.InsaIpsa_Date.Value, yy2,mm2,dd2 );

//  if (yy1 = yy2) and (mm1 = mm2) then
//     InsaDuring.value := 0
//  else
//     InsaDuring.Value := yy1 - yy2;

  InsaDuring.value := trunc(MonthsBetween(insaIpsa_Date.value, Now)/12 );

  InsaTax.Value := InsaSalary.Value * 0.1;
end;

procedure TDM.insaNewRecord(DataSet: TDataSet);
begin
  InsaSalary.Value := 5000000;
  InsaGrade.Value := '1';
  InsaIpsa_Date.Value := Date;
end;

procedure TDM.insaReconcileError(DataSet: TCustomClientDataSet;
  E: EReconcileError; UpdateKind: TUpdateKind; var Action: TReconcileAction);
begin
 action := HandleReconcileError(Dataset, updatekind, e);
end;

procedure TDM.InsaSourceDataChange(Sender: TObject; Field: TField);
begin
  InsaForm.SpeedButton1.Enabled := not Insa.Bof;
  InsaForm.SpeedButton2.Enabled := not Insa.Bof;
  InsaForm.SpeedButton3.Enabled := not Insa.Eof;
  InsaForm.SpeedButton4.Enabled := not Insa.Eof;
end;

procedure TDM.InsaSourceStateChange(Sender: TObject);
begin
  InsaForm.Button1.Enabled := Insa.State = dsBrowse;
  InsaForm.Button2.Enabled := Insa.State = dsBrowse;
  InsaForm.Button3.Enabled := Insa.State in [dsInsert, dsEdit];
  InsaForm.Button4.Enabled := Insa.State in [dsInsert, dsEdit];

end;


end.
