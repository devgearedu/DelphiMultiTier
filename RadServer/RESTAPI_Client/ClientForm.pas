unit ClientForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Rtti,
  FMX.Grid.Style, FMX.StdCtrls, FMX.Memo, FMX.Edit, FMX.ScrollBox, FMX.Grid,
  FMX.Controls.Presentation, Data.Bind.EngExt, Fmx.Bind.DBEngExt, Fmx.Bind.Grid,
  System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.Components,
  Data.Bind.Grid, Data.Bind.DBScope;

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
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    BindSourceDB2: TBindSourceDB;
    LinkControlToField1: TLinkControlToField;
    LinkControlToField2: TLinkControlToField;
    LinkControlToField3: TLinkControlToField;
    LinkControlToField4: TLinkControlToField;
    LinkControlToField5: TLinkControlToField;
    procedure btnLoadDataClick(Sender: TObject);
    procedure Grid1SelChanged(Sender: TObject);
  private
    { Private declarations }
    procedure LoadImage(ASeq: Integer); // Shift Ctrl C
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  DataAccessModule, REST.Types;

{$R *.fmx}

procedure TForm1.btnLoadDataClick(Sender: TObject);
begin
  DataModule1.RESTRequest1.Execute;
end;

procedure TForm1.Grid1SelChanged(Sender: TObject);
var
  Seq: Integer;
begin
  if DataModule1.FDMemTable1.RecordCount = 0 then
    Exit;
  Seq := DataModule1.FDMemTable1.FieldByName('BOOK_SEQ').AsInteger;

  DataModule1.RESTRequest2.Params.ParameterByName('item').Value := Seq.ToString;
  DataModule1.RESTRequest2.Execute;

  LoadImage(Seq);
end;

procedure TForm1.LoadImage(ASeq: Integer);
var
  Stream: TMemoryStream;
begin
  DataModule1.RESTRequest.Method := TRESTRequestMethod.rmGET; // uses REST.Types
  DataModule1.RESTRequest.Resource := '/books/{item}/photo/';
  DataModule1.RESTRequest.Params.ParameterByName('item').Value := ASeq.ToString;
  DataModule1.RESTRequest.ExecuteAsync(procedure
    begin
      if DataModule1.RESTResponse.StatusCode = 404 then
        Exit;
      Stream := TMemoryStream.Create;
      try
        Stream.WriteData(DataModule1.RESTResponse.RawBytes,
                        DataModule1.RESTResponse.ContentLength);
        ImageControl1.Bitmap.LoadFromStream(Stream);
      finally
        Stream.Free;
      end;
    end);
end;

end.
