unit Udm;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  vcl.dialogs, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.IB,
  FireDAC.Phys.IBDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Comp.UI, FireDAC.Phys.IBBase,
  FireDAC.Moni.Base, FireDAC.Moni.FlatFile, FireDAC.VCLUI.Error,
  Datasnap.DBClient, Datasnap.DSConnect, Data.SqlExpr, Data.DBXDataSnap,
  Data.DBXCommon, IPPeerClient, uClientClass;

type
  TDM = class(TDataModule)
    InsaQuerySource: TDataSource;
    DeptSource: TDataSource;
    InsaSource: TDataSource;
    SQLConnection1: TSQLConnection;
    DSProviderConnection1: TDSProviderConnection;
    Dept: TClientDataSet;
    Insa: TClientDataSet;
    InsaQuery: TClientDataSet;
    InsaID: TIntegerField;
    InsaNAME: TStringField;
    InsaAGE: TSmallintField;
    InsaDEPT_CODE: TStringField;
    InsaSection: TStringField;
    InsaIPSA_DATE: TDateField;
    InsaDuring: TIntegerField;
    InsaCLASS: TStringField;
    InsaSALARY: TIntegerField;
    InsaTax: TFloatField;
    InsaPHOTO: TBlobField;
    InsaGRADE: TStringField;
    procedure insaCalcFields(DataSet: TDataSet);
    procedure insaBeforeInsert(DataSet: TDataSet);
    procedure insaNewRecord(DataSet: TDataSet);
    procedure insaAfterPost(DataSet: TDataSet);
    procedure InsaSourceStateChange(Sender: TObject);
    procedure InsaSourceDataChange(Sender: TObject; Field: TField);
    procedure DeptSourceDataChange(Sender: TObject; Field: TField);
    procedure InsaAfterApplyUpdates(Sender: TObject; var OwnerData: OleVariant);
    procedure InsaReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;
  Demo:TServerMethods1Client;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses UInsa, Vcl.RecError;

{$R *.dfm}

procedure TDM.DataModuleCreate(Sender: TObject);
begin
 demo := TServerMethods1Client.create(SqlConnection1.dbxconnection);
end;

procedure TDM.DataModuleDestroy(Sender: TObject);
begin
  demo.free;
end;

procedure TDM.DeptSourceDataChange(Sender: TObject; Field: TField);
begin
  InsaQuery.Close;
  InsaQuery.ParamByName('code').AsString :=
  DM.Dept.Fields[0].AsString;
  InsaQuery.Open;
end;

procedure TDM.InsaAfterApplyUpdates(Sender: TObject; var OwnerData: OleVariant);
begin
  ShowMessage('등록/수정 완료');
end;

procedure TDM.insaAfterPost(DataSet: TDataSet);
begin
  ShowMessage('등록/수정 완료');
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

  if (yy1 = yy2) and (mm1 = mm2) then
     InsaDuring.value := 0
  else
     InsaDuring.Value := yy1 - yy2;


  InsaTax.Value := InsaSalary.Value * 0.1;
end;

procedure TDM.insaNewRecord(DataSet: TDataSet);
begin
  InsaId.value := -1;
  InsaSalary.Value := 5000000;
  InsaGrade.Value := '1';
  InsaIpsa_Date.Value := Date;
end;

procedure TDM.InsaReconcileError(DataSet: TCustomClientDataSet;
  E: EReconcileError; UpdateKind: TUpdateKind; var Action: TReconcileAction);
begin
  action := HandleReconcileError(DataSet,UpdateKind,e);

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
