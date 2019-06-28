unit fTransactions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, Menus, StdCtrls, ExtCtrls, DB, Buttons, ComCtrls,
  fMainLayers,
  FireDAC.Stan.Option, 
  FireDAC.Phys.Intf;

type
  TfrmTransactions = class(TfrmMainLayers)
    procedure cbDBClick(Sender: TObject);
  private
    { Private declarations }
    FCommIntf: IFDPhysCommand;
  public
    { Public declarations }
  end;

var
  frmTransactions: TfrmTransactions;

implementation

{$R *.dfm}

procedure TfrmTransactions.cbDBClick(Sender: TObject);
begin
  inherited cbDBClick(Sender);
  // Create command interface
  FConnIntf.CreateCommand(FCommIntf);

  Console.Lines.Add('Transaction isolation level is READ COMMITTED');
  // Set up trans isolation level
  FTxIntf.Options.Isolation := xiReadCommitted;

  Console.Lines.Add('Begin transaction');
  // Start transaction
  FTxIntf.StartTransaction;
  // Execute simple command during transaction
  try
    with FCommIntf do begin
      Prepare('delete from {id FDQA_TransTable}');
      Execute;
    end;

    Console.Lines.Add('Committing transaction');
    // Commit transaction
    FTxIntf.Commit;
  except
    Console.Lines.Add('Rollbacking transaction');
    // If exception - Rollback transaction
    FTxIntf.Rollback;
    raise;
  end;
end;

end.
