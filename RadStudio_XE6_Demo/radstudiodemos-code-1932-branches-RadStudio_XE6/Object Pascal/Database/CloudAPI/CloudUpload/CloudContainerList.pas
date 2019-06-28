
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit CloudContainerList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.StdCtrls;

type
  TContainerAction = (caNone, caCreate, caUpload);

  TFrmContainerList = class(TForm)
    lbContainers: TListBox;
    bbNew: TButton;
    bbUpload: TBitBtn;
    procedure bbNewClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure bbUploadClick(Sender: TObject);
  private
    FContainer: String;
    FAction: TContainerAction;
    procedure SetContainer(const Value: String);
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; List: TStrings; CloudName: String);
      reintroduce; overload;
    property Container: String read FContainer write SetContainer;
    property Action: TContainerAction read FAction;
  end;

var
  FrmContainerList: TFrmContainerList;

implementation

uses CloudDM;


{$R *.dfm}

procedure TFrmContainerList.bbNewClick(Sender: TObject);
begin
  if InputQuery(Self.Caption, 'Container/Bucket name',
    FContainer) then
    begin
      FAction := caCreate;
      Close;
    end
  else
    FAction := caNone;

end;

procedure TFrmContainerList.bbUploadClick(Sender: TObject);
begin
  FContainer := lbContainers.Items[lbContainers.ItemIndex];
  FAction := caUpload;
end;

constructor TFrmContainerList.Create(AOwner: TComponent; List: TStrings;
  CloudName: String);
begin
  inherited Create(AOwner);
  Caption := CloudName;
  lbContainers.Items := List;
  lbContainers.ItemIndex := 0;
  if TClouds[AmazonIndex] = CloudName then
     bbNew.Caption := 'New Bucket'
  else
     bbNew.Caption := 'New Container';

end;

procedure TFrmContainerList.FormCreate(Sender: TObject);
begin
  FAction := caNone;
end;

procedure TFrmContainerList.SetContainer(const Value: String);
begin
  if FContainer <> Value then
     FContainer := LowerCase(StringReplace(Value, ' ', '', []));
end;

end.
