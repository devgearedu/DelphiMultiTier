library Project2;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  SysUtils,
  Classes,
  Forms,
  FireDAC.Comp.Client,
  FireDAC.Stan.Factory,
  Unit2 in 'Unit2.pas' {Form2};

{$R *.res}

procedure ShowData(ACliHandle: LongWord); stdcall;
begin
  TForm2.ShowData(ACliHandle);
end;

procedure Shutdown; stdcall;
var
  i: Integer;
begin
  for i := Application.ComponentCount - 1 downto 0 do
    if Application.Components[i] is TForm then
      Application.Components[i].Free;
  FDTerminate;
end;

exports
  ShowData,
  Shutdown;

begin
end.
