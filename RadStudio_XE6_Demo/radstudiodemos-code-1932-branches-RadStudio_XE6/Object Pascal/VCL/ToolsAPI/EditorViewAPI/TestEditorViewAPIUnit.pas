
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit TestEditorViewAPIUnit;

interface

procedure Register;

implementation

uses
  SysUtils, Dialogs, Classes, Forms, Menus, ToolsAPI, DesignIntf, EditorTabFrame,
  FileInfoFrame, BouncyBallOptions, StdCtrls, Variants, TypInfo,
  BouncyBallDataMod;

type

  TFileInfoEditorSubView = class(TInterfacedObject, INTACustomEditorSubView)
  private
    FEditorViewServices: IOTAEditorViewServices;
    FModuleServices: IOTAModuleServices;
    function GetEditorViewServices: IOTAEditorViewServices;
    function GetModuleServices: IOTAModuleServices;
  public
    procedure Display(const AContext: IInterface; AViewObject: TObject);
    function EditAction(const AContext: IInterface; Action: TEditAction;
      AViewObject: TObject): Boolean;
    procedure FrameCreated(AFrame: TCustomFrame);
    function GetCanCloneView: Boolean;
    function GetCaption: string;
    function GetEditState(const AContext: IInterface;
      AViewObject: TObject): TEditState;
    function GetFrameClass: TCustomFrameClass;
    function GetPriority: Integer;
    function GetViewIdentifier: string;
    function Handles(const AContext: IInterface): Boolean;
    procedure Hide(const AContext: IInterface; AViewObject: TObject);
    procedure ViewClosed(const AContext: IInterface; AViewObject: TObject);
  end;

  TBouncyBallAddinOptions = class(TInterfacedObject, INTAAddinOptions, IOTACustomOptions)
  private
    FFrame: TBouncyBallOptionsFrame;
  public
    procedure DialogClosed(Accepted: Boolean);
    procedure FrameCreated(AFrame: TCustomFrame);
    function GetArea: string;
    function GetCaption: string;
    function GetFrameClass: TCustomFrameClass;
    function GetHelpContext: Integer;
    function IncludeInIDEInsight: Boolean;
    function ValidateContents: Boolean;
    function GetOptionNames: TOTAOptionNameArray;
    function GetOptionValue(const ValueName: string): Variant;
    procedure SetOptionValue(const ValueName: string; const Value: Variant);
  end;

var
  MyEditorViewRef: Pointer;
  ViewMenuItem: TMenuItem;
  CloseMenuItem: TMenuItem;
  BouncyBallOptions: INTAAddinOptions;
  BouncyBallDM: TBouncyBallDataModule;

procedure AddViewMenuItems;
begin
  ViewMenuItem := Menus.NewItem(sBouncyBall, 0, False, True, TEditorTabHandler.OnViewMenuClick, 0, 'ViewBouncyBallItem');
  ViewMenuItem.ImageIndex := IDEBaseImageIndex + cBouncyBallViewGlyphIndex;
  CloseMenuItem := Menus.NewItem(sCloseBouncyBall, 0, False, True, TEditorTabHandler.OnCloseMenuClick, 0, 'CloseBouncyBallItem');
  (BorlandIDEServices as INTAServices).AddActionMenu('DockEditWindow1', nil, CloseMenuItem);
  (BorlandIDEServices as INTAServices).AddActionMenu('DockEditWindow1', nil, ViewMenuItem);
end;

procedure Register;
begin
  BouncyBallDM :=  TBouncyBallDataModule.Create(nil);
  EditorBaseImageIndex := (BorlandIDEServices as INTAEditorViewServices).AddImages(BouncyBallDM.BouncyBallImages, cViewIdentifier);
  IDEBaseImageIndex := (BorlandIDEServices as INTAServices).AddImages(BouncyBallDM.BouncyBallImages, cViewIdentifier);
  MyEditorViewRef :=
    (BorlandIDEServices as IOTAEditorViewServices).RegisterEditorSubView(TFileInfoEditorSubView.Create as INTACustomEditorSubView);
  (BorlandIDEServices as IOTAEditorViewServices).RegisterEditorView(cViewIdentifier, EditorTabFrame.RecreateTab);
  BouncyBallOptions := TBouncyBallAddinOptions.Create;
  (BorlandIDEServices as INTAEnvironmentOptionsServices).RegisterAddInOptions(BouncyBallOptions);
  AddViewMenuItems;
end;

procedure UnregisterItems;
begin
  (BorlandIDEServices as IOTAEditorViewServices).UnregisterEditorSubView(MyEditorViewRef);
  (BorlandIDEServices as IOTAEditorViewServices).UnregisterEditorView(cViewIdentifier);
  (BorlandIDEServices as INTAEnvironmentOptionsServices).UnregisterAddInOptions(BouncyBallOptions);
  BouncyBallOptions := nil;
  FreeAndNil(ViewMenuItem);
  FreeAndNil(CloseMenuItem);
  FreeAndNil(BouncyBallDM);
end;

{ TFileInfoEditorSubView }

procedure TFileInfoEditorSubView.Display(const AContext: IInterface;
  AViewObject: TObject);
var
  LModule: IOTAModule;
begin
  if (AViewObject is TFileInfoFrame) and
    GetEditorViewServices.ContextToModule(AContext, LModule) then
  begin
    TFileInfoFrame(AViewObject).Module := LModule;
  end;
end;

function TFileInfoEditorSubView.EditAction(const AContext: IInterface;
  Action: TEditAction; AViewObject: TObject): Boolean;
begin
  Result := False;
end;

procedure TFileInfoEditorSubView.FrameCreated(AFrame: TCustomFrame);
begin

end;

function TFileInfoEditorSubView.GetCanCloneView: Boolean;
begin
  Result := True;
end;

function TFileInfoEditorSubView.GetCaption: string;
begin
  Result := 'OS File Information';
end;

function TFileInfoEditorSubView.GetEditorViewServices: IOTAEditorViewServices;
begin
  if FEditorViewServices = nil then
    Supports(BorlandIDEServices, IOTAEditorViewServices, FEditorViewServices);
  Result := FEditorViewServices;
  assert(Result <> nil);
end;

function TFileInfoEditorSubView.GetEditState(const AContext: IInterface;
  AViewObject: TObject): TEditState;
begin
  Result := [];
end;

function TFileInfoEditorSubView.GetFrameClass: TCustomFrameClass;
begin
  Result := TFileInfoFrame;
end;

function TFileInfoEditorSubView.GetModuleServices: IOTAModuleServices;
begin
  if FModuleServices = nil then
    Supports(BorlandIDEServices, IOTAModuleServices, FModuleServices);
  Result := FModuleServices;
  assert(Result <> nil);
end;

function TFileInfoEditorSubView.GetPriority: Integer;
begin
  Result := svpNormal;
end;

function TFileInfoEditorSubView.GetViewIdentifier: string;
begin
  Result := 'OSFileInformation';
end;

function TFileInfoEditorSubView.Handles(const AContext: IInterface): Boolean;
var
  LModule: IOTAModule;
begin
  Result := GetEditorViewServices.ContextToModule(AContext, LModule) and (LModule.ModuleFileCount > 0) and
    ((LModule.FileSystem = '') or GetModuleServices.FindFileSystem(LModule.FileSystem).IsFileBased);
end;

procedure TFileInfoEditorSubView.Hide(const AContext: IInterface;
  AViewObject: TObject);
begin

end;

procedure TFileInfoEditorSubView.ViewClosed(const AContext: IInterface;
  AViewObject: TObject);
var
  LModule: IOTAModule;
begin
  if (AViewObject is TFileInfoFrame) and
    GetEditorViewServices.ContextToModule(AContext, LModule) then
  begin
    TFileInfoFrame(AViewObject).Module := nil;
  end;
end;

{ TBouncyBallAddinOptions }

procedure TBouncyBallAddinOptions.DialogClosed(Accepted: Boolean);
begin
  if Accepted then
  begin
    BouncyBallOpts.HorzMove := FFrame.HStepUpDown.Position;
    BouncyBallOpts.VertMove := FFrame.VStepUpDown.Position;
    BouncyBallOpts.CycleColors := FFrame.CycleColorsCB.Checked;
    BouncyBallOpts.UseExistingView := FFrame.UseExistingCB.Checked;
    BouncyBallOpts.Color := FFrame.BallColorBox.Selected;
  end;
end;

procedure TBouncyBallAddinOptions.FrameCreated(AFrame: TCustomFrame);
begin
  FFrame := TBouncyBallOptionsFrame(AFrame);
  FFrame.HStepUpDown.Position := BouncyBallOpts.HorzMove;
  FFrame.VStepUpDown.Position := BouncyBallOpts.VertMove;
  FFrame.CycleColorsCB.Checked := BouncyBallOpts.CycleColors;
  FFrame.UseExistingCB.Checked := BouncyBallOpts.UseExistingView;
  FFrame.BallColorBox.Selected := BouncyBallOpts.Color;
end;

function TBouncyBallAddinOptions.GetArea: string;
begin
  Result := '';
end;

function TBouncyBallAddinOptions.GetCaption: string;
begin
  Result := sBouncyBall;
end;

function TBouncyBallAddinOptions.GetFrameClass: TCustomFrameClass;
begin
  Result := TBouncyBallOptionsFrame;
end;

function TBouncyBallAddinOptions.GetHelpContext: Integer;
begin
  Result := 0;
end;

const
  cVertMoveOption = 'BouncyBallVertMove';
  cHorzMoveOption = 'BouncyBallHorzMove';
  cColorOption =  'BouncyBallColor';
  cCycleColorsOption =  'BouncyBallCycleColors';
  cUseExistingViewOption =  'BouncyBallUseExistingView';

function TBouncyBallAddinOptions.GetOptionNames: TOTAOptionNameArray;
begin
  SetLength(Result, 5);
  Result[0].Name := cVertMoveOption;
  Result[0].Kind := tkInteger;
  Result[1].Name := cHorzMoveOption;
  Result[1].Kind := tkInteger;
  Result[2].Name := cColorOption;
  Result[2].Kind := tkInteger;
  Result[3].Name := cCycleColorsOption;
  Result[3].Kind := tkEnumeration;
  Result[3].Name := cUseExistingViewOption;
  Result[3].Kind := tkEnumeration;
end;

function TBouncyBallAddinOptions.GetOptionValue(
  const ValueName: string): Variant;
begin
  if ValueName = cVertMoveOption then
    Result := BouncyBallOpts.VertMove
  else if ValueName = cHorzMoveOption then
    Result := BouncyBallOpts.HorzMove
  else if ValueName = cColorOption then
    Result := BouncyBallOpts.Color
  else if ValueName = cCycleColorsOption then
    Result := BouncyBallOpts.CycleColors
  else if ValueName = cUseExistingViewOption then
    Result := BouncyBallOpts.UseExistingView
  else
    Result := Unassigned;
end;

function TBouncyBallAddinOptions.IncludeInIDEInsight: Boolean;
begin
  Result := True;
end;

procedure TBouncyBallAddinOptions.SetOptionValue(const ValueName: string;
  const Value: Variant);
begin
  if ValueName = cVertMoveOption then
    BouncyBallOpts.VertMove := Value
  else if ValueName = cHorzMoveOption then
    BouncyBallOpts.HorzMove := Value
  else if ValueName = cColorOption then
    BouncyBallOpts.Color := Value
  else if ValueName = cCycleColorsOption then
    BouncyBallOpts.CycleColors := Value
  else if ValueName = cUseExistingViewOption then
    BouncyBallOpts.UseExistingView := Value;
end;

function TBouncyBallAddinOptions.ValidateContents: Boolean;
var
  ResultVal: Integer;
resourcestring
  sInvalidValue = 'Invalid value in %s. The value should be from %d to %d';

  function LabelDisplayName(const Name: string): string;
  begin
    Result := StripHotKey(Name);
    if (Length(Result) > 0) and (Result[Length(Result)] = ':') then
      SetLength(Result, Length(Result) - 1);
    Result := Trim(Result);
  end;

begin
  Result := False;
  if not TryStrToInt(FFrame.HStepEdit.Text, ResultVal) or (ResultVal < FFrame.HStepUpDown.Min) or (ResultVal > FFrame.HStepUpDown.Max) then
    ShowMessage(Format(SInvalidValue, [LabelDisplayName(FFrame.lbHStep.Caption), FFrame.HStepUpDown.Min, FFrame.HStepUpDown.Max]))
  else if not TryStrToInt(FFrame.VStepEdit.Text, ResultVal) or (ResultVal < FFrame.VStepUpDown.Min) or (ResultVal > FFrame.VStepUpDown.Max) then
    ShowMessage(Format(SInvalidValue, [LabelDisplayName(FFrame.lbVStep.Caption), FFrame.VStepUpDown.Min, FFrame.VStepUpDown.Max]))
  else
    Result := True;
end;

initialization
finalization
  UnregisterItems;
end.
