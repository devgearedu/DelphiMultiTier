unit fDatSLayerBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, StdCtrls, ExtCtrls, ComCtrls,
  fMainBase;

type
  TfrmDatSLayerBase = class(TfrmMainBase)
    pnlControlButtons: TPanel;
    Console: TMemo;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDatSLayerBase: TfrmDatSLayerBase;

implementation

{$R *.dfm}

end.
