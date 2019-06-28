unit fClients;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, StdCtrls, ExtCtrls,
  fMainLayers,
  FireDAC.Stan.Intf,
  FireDAC.Phys.Intf, FireDAC.Moni.FlatFile, FireDAC.Moni.Base, FireDAC.Moni.RemoteClient;

type
  TfrmClients = class(TfrmMainLayers)
    Panel1: TPanel;
    rgClients: TRadioGroup;
    mmInfo: TMemo;
    FDMoniRemoteClientLink1: TFDMoniRemoteClientLink;
    FDMoniFlatFileClientLink1: TFDMoniFlatFileClientLink;
    procedure cbDBClick(Sender: TObject);
  end;

var
  frmClients: TfrmClients;

implementation

uses
  dmMainBase, FireDAC.Stan.Factory;

{$R *.dfm}

procedure TfrmClients.cbDBClick(Sender: TObject);
var
  oConnectionDef: IFDStanConnectionDef;
  oRemMoni: IFDMoniRemoteClient;
  oFFMoni: IFDMoniFlatFileClient;
  oMoni: IFDMoniClient;
  oStream: TStream;
begin
  // 1) Set connection definition to use none, remote or flat file monitoring
  oConnectionDef := FDPhysManager.ConnectionDefs.ConnectionDefByName(cbDB.Text);
  case rgClients.ItemIndex of
  0: // turn off
    oConnectionDef.MonitorBy := '';
  1: // remote
    begin
      oConnectionDef.MonitorBy := 'Remote';
      FDMoniRemoteClientLink1.Tracing := True;
    end;
  2: // flat file
    begin
      oConnectionDef.MonitorBy := 'FlatFile';
      FDMoniFlatFileClientLink1.Tracing := True;
    end;
  end;

  // 2) connecting to RDBMS
  inherited cbDBClick(Sender);

  // 3) Get remote or flat file monitoring client
  case rgClients.ItemIndex of
  0: // turn off
    Exit;
  1: // remote
    begin
      FDCreateInterface(IFDMoniRemoteClient, oRemMoni);
      oMoni := oRemMoni as IFDMoniClient;
    end;
  2: // flat file
    begin
      FDCreateInterface(IFDMoniFlatFileClient, oFFMoni);
      oMoni := oFFMoni as IFDMoniClient;
    end;
  end;

  // 4) Produce custom trace output
  oMoni.Tracing := True;
  oMoni.Notify(ekVendor, esStart,    Self, 'Start monitoring',        ['Form', 'frmClients']);
  oMoni.Notify(ekVendor, esProgress, Self, 'Progress monitoring',     ['Form', 'frmClients']);
  oMoni.Notify(ekVendor, esEnd,      Self, 'End monitoring',          ['Form', 'frmClients']);
  oMoni.Notify(ekError,  esProgress, Self, 'Error during monitoring', ['Form', 'frmClients']);
  oMoni.Tracing := False;

  // 5) Print flat file
  if rgClients.ItemIndex = 2 then begin
    FDCreateInterface(IFDMoniFlatFileClient, oFFMoni);
    oStream := TFileStream.Create(oFFMoni.FileName, fmOpenRead or fmShareDenyNone);
    try
      Console.Lines.LoadFromStream(oStream);
    finally
      oStream.Free;
    end;
  end;
end;

end.
