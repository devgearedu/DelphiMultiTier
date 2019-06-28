
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit FormUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DBXCommon, SampleProxyGeneratorUnit, WideStrings,
  DbxDatasnap, DB, SqlExpr, DSCommonProxy, ProxyGeneratorSettings,
  DSProxyDelphi, DSProxyCpp, DSProxyCppRest, DSProxyJavaScript, DSProxyDelphiRest, DSClientRest,
  IPPeerClient, IndyPeerImpl;  // Reference assembly

type
  TMainForm = class(TForm)
    GroupBox1: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    EditHost: TEdit;
    ComboBoxProtocol: TComboBox;
    EditPort: TEdit;
    EditURLPath: TEdit;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    EditExcludeClasses: TEdit;
    EditExcludeMethods: TEdit;
    GroupBox3: TGroupBox;
    CheckBoxWriteToFile: TCheckBox;
    EditOutputDirectory: TEdit;
    CheckBoxWriteToMemo: TCheckBox;
    ButtonGenerateProxy: TButton;
    MemoCode: TMemo;
    EditUnitName: TEdit;
    Label3: TLabel;
    SQLConnection1: TSQLConnection;
    GroupBox4: TGroupBox;
    ComboBoxLanguages: TComboBox;
    Directory: TLabel;
    EditIncludeMethods: TEdit;
    Label4: TLabel;
    EditIncludeClasses: TEdit;
    Label5: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure ButtonGenerateProxyClick(Sender: TObject);
  private
    procedure OpenConnection(ASettings: TProxyGeneratorSettings);
    function CreateCurrentSettings: TProxyGeneratorSettings;
    procedure LoadSettings;
    procedure SaveSettings;
    procedure UpdateControls;
    procedure Application_Idle(sender: TObject; var Done: Boolean);
    procedure ListLanguages;
    function GetMetaDataLoader(ASettings: TProxyGeneratorSettings): IDSProxyMetaDataLoader;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses AppEvnts, DSProxy, DSHTTPLayer, DBXStream, DBXPlatform, DSProxyWriter, DSProxyRest;

const
  sProxyGeneratorSettingsKey = 'Software\Embarcadero\Samples\SampleProxyRestGeneratorSettings';

procedure TMainForm.ButtonGenerateProxyClick(Sender: TObject);
var
   LOutputDirectory: String;
   LSettings: TProxyGeneratorSettings;
   LMetaDataLoader: IDSProxyMetaDataLoader;
begin
  LSettings := CreateCurrentSettings;
  try
    LMetaDataLoader := GetMetaDataLoader(LSettings);
    try
      if LSettings.WriteToFile then
      begin
        if (Trim(LSettings.OutputDirectory) = '') and
          (Trim(LSettings.OutputDirectory) = '') then
          raise Exception.Create('Missing unit name and output directory');
        if Trim(LSettings.OutputDirectory) = '' then
          raise Exception.Create('Missing output directory');
        if Trim(LSettings.UnitName) = '' then
          raise Exception.Create('Missing unit name');
        LOutputDirectory := ExpandFileName(IncludeTrailingPathDelimiter(LSettings.OutputDirectory));
        TSampleProxyGenerator.GenerateFile(LMetaDataLoader, LOutputDirectory,
          LSettings.UnitName, LSettings.ExcludeClasses, LSettings.ExcludeMethods,
          LSettings.IncludeClasses, LSettings.IncludeMethods, LSettings.Writer,
          function(CreatingFiles: TStrings): Boolean
          var
            I: Integer;
          begin
            Result := True;
            for I := 0 to CreatingFiles.Count - 1 do
            begin
              if FileExists(CreatingFiles[I]) then
                if MessageDlg(Format('File %s exists.  Replace?', [CreatingFiles[I]]),
                  mtConfirmation, mbYesNoCancel, 0) <> idYes then
                  begin
                    Exit(False);
                  end;
            end;
          end,
          procedure (CreatedFiles: TStrings)
          var
            I: Integer;
            LFileNames: string;
          begin
            for I := 0 to CreatedFiles.Count - 1 do
            begin
              if LFileNames <> '' then
                LFileNames := LFileNames + ', ';
              LFileNames := LFileNames + CreatedFiles[I];
            end;
            if CreatedFiles.Count > 1 then
              MessageDlg(Format('Proxy written to files: %s', [LFileNames]),
                mtInformation, [mbOK], 0)
            else
              MessageDlg(Format('Proxy written to file: %s', [LFileNames]),
                mtInformation, [mbOK], 0)
          end)
      end;
      MemoCode.Clear;
      if LSettings.WriteToMemo then
        MemoCode.Text := TSampleProxyGenerator.GenerateString(LMetaDataLoader, LOutputDirectory,
          LSettings.UnitName, LSettings.ExcludeClasses, LSettings.ExcludeMethods,
          LSettings.IncludeClasses, LSettings.IncludeMethods, LSettings.Writer);
      SaveSettings;  // Save options into registry
    finally
    end;
  finally
    LSettings.Free;
  end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  ListLanguages;
  LoadSettings;
  TApplicationEvents.Create(Self).OnIdle := Application_Idle;
end;

procedure TMainForm.ListLanguages;
var
  L: TDBXStringArray;
  I: Integer;
begin
  ComboBoxLanguages.Items.Clear;
  ComboBoxLanguages.Items.Add('');
  L := DSProxyWriter.TDSProxyWriterFactory.RegisteredWritersList;
  try
    for I := 0 to Length(L) - 1 do
      ComboBoxLanguages.Items.Add(L[I]);
  finally

  end;
end;

function TMainForm.GetMetaDataLoader(ASettings: TProxyGeneratorSettings): IDSProxyMetaDataLoader;
begin
  Result := TDSProxyMetaDataLoader.Create(
    function: TDBXConnection
    begin
      OpenConnection(ASettings);
      Result := SQLConnection1.DBXConnection;
    end,
    procedure(AConnection: TDBXConnection)
    begin
      SQLConnection1.Close;
    end
    );
end;

procedure TMainForm.OpenConnection(ASettings: TProxyGeneratorSettings);
begin
  try
    SQLConnection1.Close;
  except
  end;
  SQLConnection1.Params.Values['port'] := IntToStr(ASettings.Port);
  SQLConnection1.Params.Values['hostname'] := ASettings.Host;
  SQLConnection1.Params.Values['communicationprotocol'] := ASettings.Protocol;
  SQLConnection1.Params.Values['urlpath'] := ASettings.URLPath;
  SQLConnection1.Open;
end;

procedure TMainForm.Application_Idle(sender: TObject; var Done: Boolean);
begin
  UpdateControls;
end;

procedure TMainForm.UpdateControls;
begin
  EditOutputDirectory.Enabled := checkBoxWriteToFile.Checked;
  buttonGenerateProxy.Enabled := checkBoxWriteToFile.Checked or checkBoxWriteToMemo.Checked;
end;

procedure TMainForm.LoadSettings;
var
  LSettings: TProxyGeneratorSettings;
begin
  LSettings := TProxyGeneratorSettings.LoadSettings(sProxyGeneratorSettingsKey);
  try
    if LSettings <> nil then
    begin
      comboBoxProtocol.ItemIndex := comboBoxProtocol.Items.IndexOf(LSettings.Protocol);
      EditHost.Text := LSettings.Host;
      EditPort.Text := IntToStr(LSettings.Port);
      EditURLPath.Text := LSettings.URLPath;
      EditExcludeClasses.Text := LSettings.ExcludeClasses;
      EditExcludeMethods.Text := LSettings.ExcludeMethods;
      EditIncludeClasses.Text := LSettings.IncludeClasses;
      EditIncludeMethods.Text := LSettings.IncludeMethods;
      EditUnitName.Text := LSettings.UnitName;
      EditOutputDirectory.Text := LSettings.OutputDirectory;
      checkBoxWriteToFile.Checked := LSettings.WriteToFile;
      checkBoxWriteToMemo.Checked := LSettings.WriteToMemo;
      ComboBoxLanguages.ItemIndex := ComboBoxLanguages.Items.IndexOf(LSettings.Writer);
    end;
  finally
    LSettings.Free;
  end;
end;

function TMainForm.CreateCurrentSettings: TProxyGeneratorSettings;
begin
  Result := TProxyGeneratorSettings.Create;
  Result.Host := EditHost.Text;
  try
    Result.Protocol := comboBoxProtocol.Items[comboBoxProtocol.ItemIndex];
  except
    Result.Protocol := '';
  end;
  Result.Port := StrToInt(EditPort.Text);
  Result.URLPath := EditURLPath.Text;
  Result.ExcludeClasses := EditExcludeClasses.Text;
  Result.ExcludeMethods := EditExcludeMethods.Text;
  Result.IncludeClasses := EditIncludeClasses.Text;
  Result.IncludeMethods := EditIncludeMethods.Text;
  Result.OutputDirectory := EditOutputDirectory.Text;
  Result.WriteToFile := checkBoxWriteToFile.Checked;
  Result.WriteToMemo := checkBoxWriteToMemo.Checked;
  Result.UnitName := EditUnitName.Text;
  try
    Result.Writer := comboBoxLanguages.Items[comboBoxLanguages.ItemIndex];
  except
    Result.Writer := '';
  end;
end;

procedure TMainForm.SaveSettings;
var
  LSettings: TProxyGeneratorSettings;
begin
  LSettings := CreateCurrentSettings;
  try
    TProxyGeneratorSettings.SaveSettings(sProxyGeneratorSettingsKey, LSettings);
  finally
    LSettings.Free;
  end;
end;

end.
