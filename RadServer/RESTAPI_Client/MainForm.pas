unit MainForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Rtti,
  FMX.Grid.Style, IPPeerClient, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.Bind.EngExt, Fmx.Bind.DBEngExt, Fmx.Bind.Grid,
  System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.Components,
  Data.Bind.Grid, Data.Bind.DBScope, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, REST.Response.Adapter, REST.Client,
  Data.Bind.ObjectScope, FMX.ScrollBox, FMX.Grid, FMX.Controls.Presentation,
  FMX.StdCtrls, FMX.Memo, FMX.Edit, FMX.Layouts, FMX.ExtCtrls, DataAccessModule,
  FMX.Memo.Types;

type
  TForm1 = class(TForm)
    btnLoadData: TButton;
    Grid1: TGrid;
    Label1: TLabel;
    edtTitle: TEdit;
    Label2: TLabel;
    edtAuthor: TEdit;
    Label3: TLabel;
    edtISBN: TEdit;
    Label4: TLabel;
    edtPrice: TEdit;
    Label5: TLabel;
    edtLink: TEdit;
    Label6: TLabel;
    mmoDescription: TMemo;
    btnNewData: TButton;
    btnSaveData: TButton;
    ImageControl1: TImageControl;
    btnDeleteData: TButton;
    BindSourceDB2: TBindSourceDB;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    LinkControlToField1: TLinkControlToField;
    LinkControlToField2: TLinkControlToField;
    LinkControlToField3: TLinkControlToField;
    LinkControlToField4: TLinkControlToField;
    LinkControlToField5: TLinkControlToField;
    LinkControlToField6: TLinkControlToField;
    Edit1: TEdit;
    procedure btnLoadDataClick(Sender: TObject);
    procedure Grid1SelChanged(Sender: TObject);
    procedure btnNewDataClick(Sender: TObject);
    procedure btnSaveDataClick(Sender: TObject);
    procedure btnDeleteDataClick(Sender: TObject);
  private
    FSelectedSeq: Integer;
    procedure RequestDetail(ASeq: Integer);
    procedure LoadPhoto(ASeq: Integer);
    procedure ClearControls;
    // Shift + Ctrl + C :  선언부의 메소드를 구현부에 추가 단축키
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  System.JSON, REST.Types;

{$R *.fmx}

procedure TForm1.btnLoadDataClick(Sender: TObject);
var
  path:string;
begin
   path := 'http://' + Edit1.Text + ':8080';
   dmDataAccess.RestClient1.BaseURL := path;
   dmDataAccess.RestClient1.ProxyPort := 8080;
   dmDataAccess.RestClient1.ProxyServer := Edit1.Text;
   dmDataAccess.reqList.Execute;
end;

procedure TForm1.btnNewDataClick(Sender: TObject);
begin
  FSelectedSeq := -1;
  ClearControls;
end;

procedure TForm1.btnSaveDataClick(Sender: TObject);
var
  Data: TJSONObject;
begin
  if FSelectedSeq = -1 then
  begin
    dmDataAccess.RESTRequest.Method := TRESTRequestMethod.rmPOST;
    dmDataAccess.RESTRequest.Resource := '/books/';
  end
  else
  begin
    dmDataAccess.RESTRequest.Method := TRESTRequestMethod.rmPUT;
    dmDataAccess.RESTRequest.Resource := '/books/{item}/';
    dmDataAccess.RESTRequest.Params.ParameterByName('item').Value := FSelectedSeq.ToString;
  end;
  dmDataAccess.RESTRequest.ClearBody;
  Data := dmDataAccess.GetBookData;
  dmDataAccess.RESTRequest.Body.Add(Data);
  dmDataAccess.RESTRequest.Execute;

  ShowMessage('저장');
end;

procedure TForm1.btnDeleteDataClick(Sender: TObject);
begin
  dmDataAccess.RESTRequest.Method := TRESTRequestMethod.rmDELETE;
  dmDataAccess.RESTRequest.Resource := '/books/{item}/';
  dmDataAccess.RESTRequest.Params.ParameterByName('item').Value := FSelectedSeq.ToString;
  dmDataAccess.RESTRequest.Execute;

  ShowMessage('삭제');
end;

procedure TForm1.Grid1SelChanged(Sender: TObject);
var
  Seq: Integer;
begin
  if dmDataAccess.memBookList.RecordCount = 0 then
    Exit;

  Seq := dmDataAccess.memBookList.FieldByName('BOOK_SEQ').AsInteger;
  RequestDetail(Seq);
end;

procedure TForm1.ClearControls;
begin
  dmDataAccess.memBookDetail.EmptyDataSet;
  ImageControl1.Bitmap.Assign(nil);
end;

procedure TForm1.RequestDetail(ASeq: Integer);
begin
  FSelectedSeq := ASeq;

  ClearControls;

  dmDataAccess.reqDetail.Params.ParameterByName('item').Value := ASeq.ToString;
  BindSourceDB2.DataSource.Enabled := False;
  dmDataAccess.reqDetail.ExecuteAsync(procedure
  begin
    BindSourceDB2.DataSource.Enabled := True;
  end);

  LoadPhoto(ASeq);
end;

procedure TForm1.LoadPhoto(ASeq: Integer);
var
  Stream: TMemoryStream;
begin
  dmDataAccess.RESTRequest.Method := TRESTRequestMethod.rmGET;
  dmDataAccess.RESTRequest.Resource := '/books/{item}/photo/';
  dmDataAccess.RESTRequest.Params.ParameterByName('item').Value := ASeq.ToString;
Exit;
  dmDataAccess.RESTRequest.ExecuteAsync(procedure
    begin
      if dmDataAccess.RESTResponse.StatusCode = 404 then
        Exit;
      Stream := TMemoryStream.Create;
      try
        Stream.WriteData(
            dmDataAccess.RESTResponse.RawBytes,
            dmDataAccess.RESTResponse.ContentLength);
        ImageControl1.Bitmap.LoadFromStream(Stream);
      finally
        Stream.Free;
      end;
    end);

end;

end.
