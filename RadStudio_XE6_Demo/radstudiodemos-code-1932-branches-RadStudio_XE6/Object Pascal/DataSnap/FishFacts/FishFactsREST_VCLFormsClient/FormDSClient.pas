
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit FormDSClient;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, ClientModuleUnit_FishFactsIndy,
  ClientClassesUnit_FishFactsIndy, jpeg;

type
  TFormDSClient1 = class(TForm)
    Label1: TLabel;
    Panel1: TPanel;
    Image_Image: TImage;
    PanelAbout: TPanel;
    MemoNotes: TMemo;
    PanelPictureCaption: TPanel;
    Panel_Caption_Category: TPanel;
    Edit_Category: TEdit;
    Panel4: TPanel;
    Edit_SpeciesName: TEdit;
    Panel5: TPanel;
    Edit_LengthCm: TEdit;
    Panel6: TPanel;
    Edit_LengthIn: TEdit;
    SpeedButton_Up: TSpeedButton;
    SpeedButton_Down: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SpeedButton_UpClick(Sender: TObject);
    procedure SpeedButton_DownClick(Sender: TObject);
  private
    FSelectedIndex: integer;
    FCount: integer;
    FKeys: array of string;
    function Proxy: TFishFactsServerMethodsClient;
    procedure SelectionUp;
    procedure SelectionDown;
    procedure SelectionChange;
  public
    { Public declarations }
  end;

var
  FormDSClient1: TFormDSClient1;

implementation

uses System.JSON;

{$R *.dfm}

procedure TFormDSClient1.FormCreate(Sender: TObject);
var keys: TJSONArray; i: integer;
begin
  FSelectedIndex := 0;
  FCount := 0;
  SetLength(FKeys, FCount);

  try
    keys := Proxy.GetKeys;
    FCount := keys.Size;
    SetLength(FKeys, FCount);
    for i := 0 to FCount-1  do
      FKeys[i] := keys.Get(i).Value;
  except
    on e: Exception do
    begin
      ShowMessage('Failed to connect to FishFactsServer ['
        + e.ClassName + ' - ' + e.Message + ']');
      exit;
    end;
  end;
end;

procedure TFormDSClient1.FormDestroy(Sender: TObject);
begin
  Finalize(FKeys);
end;

function TFormDSClient1.Proxy: TFishFactsServerMethodsClient;
begin
  Result := ClientModule_FishFactsIndy.FishFactsServerMethodsClient;
end;

procedure TFormDSClient1.SelectionChange;
var
  s: string; img: TStream; pic: TJPEGImage;
  aSpeciesName, aCategory, aCommonName: string;
  aLengthIn, aLengthCm: double;
begin
   SpeedButton_Up.Enabled := (FCount > 0) and (FSelectedIndex > 0);
   SpeedButton_Down.Enabled := (FCount > 0) and (FSelectedIndex < FCount-1);

   // ClearView; // ?
   if FCount > 0 then
   begin
     Proxy.GetNotes(FKeys[FSelectedIndex], s);
     MemoNotes.Text := s;

     Proxy.GetFacts(FKeys[FSelectedIndex], aSpeciesName, aCategory, aCommonName, aLengthIn, aLengthCm);
     Edit_SpeciesName.Text := aSpeciesName;
     Edit_Category.Text := aCategory;
     Edit_LengthCm.Text := FloatToStrF(aLengthCm, ffNumber, 18, 2);
     Edit_LengthIn.Text := FloatToStrF(aLengthIn, ffNumber, 18, 2);

     PanelAbout.Caption := 'About the ' + aCommonName;
     PanelPictureCaption.Caption := aCommonName;

     img := Proxy.GetImage(FKeys[FSelectedIndex]);
     if img <> nil then
     begin
       pic := TJPEGImage.Create;
       try
         pic.LoadFromStream(img);
         Image_Image.Picture.Assign(pic);
       finally
         pic.Free;
       end;
     end;

   end;
end;

procedure TFormDSClient1.SelectionDown;
begin
  if FSelectedIndex < FCount - 1 then
  begin
    inc(FSelectedIndex);
    SelectionChange;
  end;
end;

procedure TFormDSClient1.SelectionUp;
begin
  if FSelectedIndex > 0 then
  begin
    dec(FSelectedIndex);
    SelectionChange;
  end;
end;

procedure TFormDSClient1.SpeedButton_DownClick(Sender: TObject);
begin
  SelectionDown;
end;

procedure TFormDSClient1.SpeedButton_UpClick(Sender: TObject);
begin
  SelectionUp;
end;

end.
