unit Utree;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, DB,  Data.FMTBcd, Data.SqlExpr, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Datasnap.DBClient;

type
  TTreeForm = class(TForm)
    TreeView1: TTreeView;
    ListView1: TListView;
    FDQuery1: TClientDataSet;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TreeView1Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  MyRec = record
   Code:string;
   Dept:string;
  end;

  Prt_MyRec = ^MyRec;

var
  TreeForm: TTreeForm;

implementation

uses udm;
var
  Wk_Dept:string;
  p:Prt_MyRec;
  OldWidth, OldHeight : integer;

{$R *.dfm}

procedure TTreeForm.FormClose(Sender: TObject; var Action: TCloseAction);
var
  j:byte;
begin
  for j := 0 to Treeview1.Items.Count - 1 do
    if TreeView1.Items[j].Data <> nil then
       Dispose(Prt_MyRec(TreeView1.Items[j].Data));

   Action := caFree;
end;

procedure TTreeForm.FormCreate(Sender: TObject);
begin
  OldHeight := Height;
  OldWidth := Width;

  FDQuery1.Open;
  with FDQuery1, Treeview1 do
  Begin
    while Not Eof  do
    Begin
    if Wk_Dept <> FieldByName('Dept').asString then
      Begin
      Selected :=
      Items.Add(Selected,FieldByName('Dept').asString);
      Wk_Dept := FieldByName('Dept').asString;
      End;
      New(p);
      p^.Code := FieldByName('Code').asString;
      Items.AddChildobject(Selected,FieldByName('section').asString,p);
//    items.AddChild(selected,FieldByName('section').asstring);
      Next;
    End;
  End;
end;

procedure TTreeForm.FormResize(Sender: TObject);
var
  t,px,py : real ;
  i : byte ;
begin
  px := OldWidth / Width;
  py := OldHeight / Height;

  for i := 0 to Componentcount -1 do
    if Components[i] is TControl then
    begin
      t := (Components[i] as TControl).Left;
      (Components[i] as TControl).Left := Trunc(t/px);

      t := (Components[i] as TControl).Top;
      (Components[i] as TControl).Top := Trunc(t/py);

      t := (Components[i] as TControl).Width;
      (Components[i] as TControl).Width := Trunc(t/px);

      t := (Components[i] as TControl).Height;
      (Components[i] as TControl).Height := Trunc(t/py);

    end;
  OldWidth := Width ;
  OldHeight := Height;
end;

procedure TTreeForm.TreeView1Click(Sender: TObject);
var
  ListItem:TListitem;
begin
  if not Treeview1.Selected.HasChildren then
  Begin
   DM.InsaQuery.Close;
   DM.InsaQuery.Params[0].AsString :=
   Prt_MyRec(TreeView1.Selected.Data)^.Code;
   DM.InsaQuery.Open;
   ListView1.Clear;
   while not DM.InsaQuery.Eof do
   Begin
   ListItem := ListView1.Items.Add;
   ListItem.Caption :=
   DM.InsaQuery.Fieldbyname('Name').asString;
   ListItem.SubItems.Add(DM.InsaQuery.Fieldbyname('class').asstring);
   DM.InsaQuery.Next;
   End;
  End;

end;
end.
