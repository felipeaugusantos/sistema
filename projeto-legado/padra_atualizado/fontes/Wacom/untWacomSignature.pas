unit untWacomSignature;

interface

uses System.Classes, System.SysUtils, Vcl.Graphics, WinApi.Windows, Vcl.Forms, System.strUtils,
  Vcl.OleCtrls, System.Variants, WinApi.ActiveX, FlWizCOMLib_TLB, FLSIGCTLLib_TLB;

const
  LITE_LICENSE = 'eyJhbGciOiJSUzUxMiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiI3YmM5Y2IxYWIxM' +
    'GE0NmUxODI2N2E5MTJkYTA2ZTI3NiIsImV4cCI6MjE0NzQ4MzY0NywiaWF0IjoxNTYwOTUwMjcyL' +
    'CJyaWdodHMiOlsiU0lHX1NES19DT1JFIiwiU0lHQ0FQVFhfQUNDRVNTIl0sImRldmljZXMiOlsiV' +
    '0FDT01fQU5ZIl0sInR5cGUiOiJwcm9kIiwibGljX25hbWUiOiJTaWduYXR1cmUgU0RLIiwid2Fjb' +
    '21faWQiOiI3YmM5Y2IxYWIxMGE0NmUxODI2N2E5MTJkYTA2ZTI3NiIsImxpY191aWQiOiJiODUyM' +
    '2ViYi0xOGI3LTQ3OGEtYTlkZS04NDlmZTIyNmIwMDIiLCJhcHBzX3dpbmRvd3MiOltdLCJhcHBzX' +
    '2lvcyI6W10sImFwcHNfYW5kcm9pZCI6W10sIm1hY2hpbmVfaWRzIjpbXX0.ONy3iYQ7lC6rQhou7' +
    'rz4iJT_OJ20087gWz7GtCgYX3uNtKjmnEaNuP3QkjgxOK_vgOrTdwzD-nm-ysiTDs2GcPlOdUPEr' +
    'Sp_bcX8kFBZVmGLyJtmeInAW6HuSp2-57ngoGFivTH_l1kkQ1KMvzDKHJbRglsPpd4nVHhx9Wkvq' +
    'czXyogldygvl0LRidyPOsS5H2GYmaPiyIp9In6meqeNQ1n9zkxSHo7B11mp_WXJXl0k1pek7py8X' +
    'YCedCNW5qnLi4UCNlfTd6Mk9qz31arsiWsesPeR9PN121LBJtiPi023yQU8mgb9piw_a-ccciviJ' +
    'uNsEuRDN3sGnqONG3dMSA';

type
  TWacomSignature = class;

  TProcWacomOnSigned = procedure(AWacomSignature: TWacomSignature) of object;
  TProcWacomOnCancel = procedure(AWacomSignature: TWacomSignature) of object;

  IWacomSignature = interface
    ['{539B1317-9D98-4513-925C-373660CE1919}']
    function TopText(AValue: String): IWacomSignature;
    function Details(AValue: TArray<String>): IWacomSignature;
    function WhoSign(AValue: String): IWacomSignature;
    function WhySign(AValue: String): IWacomSignature;
    function OnSigned(AValue: TProcWacomOnSigned): IWacomSignature;
    function OnCancel(AValue: TProcWacomOnCancel): IWacomSignature;
    function IsSigning(): Boolean;
    function Start(): Boolean;
    function Cancel(): Boolean;
    function Clear(): Boolean;
    function SignText(): String;
  end;

  IWacomReadSignature = interface
    ['{C7409902-097B-4AD8-A010-39DFA407FACD}']
    function WhoSign(): String;
    function WhySign(): String;
    function WhenSign(): String;
    function RenderBitmap(AFileName: String): Boolean;
  end;

  TWacomSignature = class(TComponent, IWacomSignature, IDispatch)
  private type
    TPad = record
      Model: string;
      TextFont: TFont;
      DetailFont: TFont;
      ButtonFont: TFont;
      SigLineFont: TFont;
      SignatureLineY: Integer;
      WhoY: Integer;
      WhyY: Integer;
      ButtonWidth: Integer;
    end;
  private type
    TReadSignature = class(TInterfacedObject, IWacomReadSignature)
    private
      FSigCtl: TSigCtl;
    public
      constructor Create(ASigText: String);
      destructor Destroy; override;
    public
      function WhoSign(): String;
      function WhySign(): String;
      function WhenSign(): String;
      function RenderBitmap(AFileName: String): Boolean;
    end;
  private
    FIsSigning: Boolean;
    FWizCtl: TWizCtl;
    FSigCtl: TSigCtl;
    FSigText: String;
    FPad: TPad;
    FOnSigned: TProcWacomOnSigned;
    FOnCancel: TProcWacomOnCancel;
  private
    FTopText: String;
    FDetails: TArray<String>;
    FWhoSign: String;
    FWhySign: String;
  public
    constructor Create(AOwner: TComponent); reintroduce;
    destructor Destroy; override;
  private
    procedure StartWizard();
    procedure DrawPadWindow();
    procedure SignCompleted;
    procedure SignClose;
  public
    // functions to capture the events.
    function Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer; Flags: Word; var Params;
      VarResult, ExceptInfo, ArgErr: Pointer): HResult; stdcall;
    function DoInvoke(DispID: Integer; const IID: TGUID; LocaleID: Integer; Flags: Word;
      var dps: TDispParams; pDispIds: PDispIdList; VarResult, ExcepInfo, ArgErr: Pointer): HResult;
    procedure BuildPositionalDispIds(pDispIds: PDispIdList; const dps: TDispParams);
    procedure PadEvent(const WizCtl1: IDispatch; const id: WideString; EventType: OleVariant);
  public
    function TopText(AValue: String): IWacomSignature;
    function Details(AValue: TArray<String>): IWacomSignature;
    function WhoSign(AValue: String): IWacomSignature;
    function WhySign(AValue: String): IWacomSignature;
    function OnSigned(AValue: TProcWacomOnSigned): IWacomSignature;
    function OnCancel(AValue: TProcWacomOnCancel): IWacomSignature;
    function IsSigning(): Boolean;
    function Start(): Boolean;
    function Cancel(): Boolean;
    function Clear(): Boolean;
    function SignText(): String;
  public
    class function ReadSignature(ASigText: String): IWacomReadSignature;
  end;

implementation



function CreateTPad(Model: String; SignatureLineY, WhoY, WhyY, textFontSize, detailFontSize,
  buttonFontSize, signLineSize, buttonWith: Integer): TWacomSignature.TPad;
begin
  Result.Model := Model;
  Result.SignatureLineY := SignatureLineY;
  Result.WhoY := WhoY;
  Result.WhyY := WhyY;
  Result.ButtonWidth := buttonWith;

  Result.DetailFont := TFont.Create;
  Result.DetailFont.Name := 'Courier New';
  Result.DetailFont.Size := detailFontSize;

  Result.TextFont := TFont.Create;
  Result.TextFont.Name := 'Verdana';
  Result.TextFont.Size := textFontSize;

  Result.ButtonFont := TFont.Create;
  Result.ButtonFont.Name := 'Verdana';
  Result.ButtonFont.Size := buttonFontSize;

  Result.SigLineFont := TFont.Create;
  Result.SigLineFont.Name := 'Verdana';
  Result.SigLineFont.Size := signLineSize;
end;

{ TWacomSignature }

constructor TWacomSignature.Create(AOwner: TComponent);
begin
  FIsSigning := False;
  FSigText := EmptyStr;
end;

destructor TWacomSignature.Destroy;
begin
  if Assigned(FWizCtl) then
    FreeAndNil(FWizCtl);
  if Assigned(FSigCtl) then
    FreeAndNil(FSigCtl);
  inherited;
end;

function TWacomSignature.Details(AValue: TArray<String>): IWacomSignature;
begin
  Result := Self;
  FDetails := AValue;
end;

procedure TWacomSignature.DrawPadWindow;
const
  DetailBeginYPos = 30;
var
  varNull: OleVariant;
  LDetailIndex: Integer;
begin
  varNull := Unassigned;
  FWizCtl.DefaultInterface.Reset;

  // insert top message
  FWizCtl.DefaultInterface.Font := IFontDisp(IDispatch(FontToOleFont(FPad.TextFont)));

  FWizCtl.DefaultInterface.AddObject(ObjectText, 'txt', 'centre', 'top', FTopText, varNull);

  // insert details
  FWizCtl.DefaultInterface.Font := IFontDisp(IDispatch(FontToOleFont(FPad.DetailFont)));

  for LDetailIndex := Low(FDetails) To High(FDetails) do
    FWizCtl.DefaultInterface.AddObject(ObjectText, 'txt', 'left', DetailBeginYPos + LDetailIndex *
      25, FDetails[LDetailIndex], varNull);

  // insert a signature line
  FWizCtl.DefaultInterface.Font := IFontDisp(IDispatch(FontToOleFont(FPad.SigLineFont)));

  if FPad.Model = 'STU-300' then
    FWizCtl.DefaultInterface.AddObject(ObjectText, 'txt', 'left', FPad.SignatureLineY,
      'X..............................', varNull)
  else
    FWizCtl.DefaultInterface.AddObject(ObjectText, 'txt', 'centre', FPad.SignatureLineY,
      'X..............................', varNull);

  // insert the signature control
  FWizCtl.DefaultInterface.Font := IFontDisp(IDispatch(FontToOleFont(FPad.TextFont)));

  FSigCtl := TSigCtl.Create(Self);
  FSigCtl.Licence := LITE_LICENSE;

  FWizCtl.DefaultInterface.AddObject(ObjectSignature, 'Sig', 0, 0, FSigCtl.Signature, varNull);

  // provide who and why for sig capture
  FWizCtl.DefaultInterface.AddObject(ObjectText, 'who', 'centre', FPad.WhoY, FWhoSign, varNull);

  FWizCtl.DefaultInterface.AddObject(ObjectText, 'why', 'right', FPad.WhyY, FWhySign, varNull);

  // insert the buttons
  FWizCtl.DefaultInterface.Font := IFontDisp(IDispatch(FontToOleFont(FPad.ButtonFont)));

  if FPad.Model = 'STU-300' then
  begin
    FWizCtl.DefaultInterface.AddObject(ObjectButton, 'Cancel', 'right', 'top', 'Cancelar',
      FPad.ButtonWidth);
    FWizCtl.DefaultInterface.AddObject(ObjectButton, 'Clear', 'right', 'middle', 'Limpar',
      FPad.ButtonWidth);
    FWizCtl.DefaultInterface.AddObject(ObjectButton, 'Ok', 'right', 'bottom', 'Confirmar',
      FPad.ButtonWidth);
  end
  else
  begin
    FWizCtl.DefaultInterface.AddObject(ObjectButton, 'Cancel', 'left', 'bottom', 'Cancelar',
      FPad.ButtonWidth);
    FWizCtl.DefaultInterface.AddObject(ObjectButton, 'Clear', 'center', 'bottom', 'Limpar',
      FPad.ButtonWidth);
    FWizCtl.DefaultInterface.AddObject(ObjectButton, 'Ok', 'right', 'bottom', 'Confirmar',
      FPad.ButtonWidth);
  end;

  // set callback when a button is pressed
  FWizCtl.DefaultInterface.SetEventHandler(Self);

  FWizCtl.DefaultInterface.Display;
end;

function TWacomSignature.Start(): Boolean;
begin
  if not FIsSigning then
    StartWizard();
  Result := True;
end;

procedure TWacomSignature.StartWizard;
var
  LSuccess: Boolean;
begin
  Try
    FWizCtl := TWizCtl.Create(Self);
  Except
    On E: Exception Do
      raise Exception.Create('Erro ao iniciar objetos do Tablet.' + #13#10 +
        'Favor verificar se os drivers e bibliotecas foram instalados corretamente! ' + #13#10 +
        'Error: ' + E.Message);
  End;

  FWizCtl.Licence := LITE_LICENSE;

  LSuccess := FWizCtl.DefaultInterface.PadConnect();

  if not LSuccess then
    raise Exception.Create('Não foi possível se conectar ao Tablet. Favor verificar se o ' +
      'mesmo está conectado na entrada USB e se os drivers foram instalados corretamente!');

  FIsSigning := True;
  FSigText := EmptyStr;

  case FWizCtl.DefaultInterface.PadWidth of
    396:
      begin
        FPad := CreateTPad('STU-300', 60, 200, 200, 8, 8, 8, 16, 70);
        // 396 x 100
      end;
    640:
      begin
        FPad := CreateTPad('STU-500', 270, 330, 360, 16, 14, 22, 32, 110);
        // 640 x 800
      end;
    800:
      begin
        FPad := CreateTPad('STU-520 or STU-530', 270, 330, 360, 16, 14, 22, 32, 110);
        // 800 x 480
      end;
    320:
      begin
        FPad := CreateTPad('STU-430 or ePad', 100, 130, 150, 10, 10, 12, 16, 110);
        // 320 x 200
      end;
  else
    raise Exception.Create('Dispositivo não é compatível!');
  end;

  DrawPadWindow();
end;

function TWacomSignature.TopText(AValue: String): IWacomSignature;
begin
  Result := Self;
  FTopText := AValue;
end;

function TWacomSignature.WhoSign(AValue: String): IWacomSignature;
begin
  Result := Self;
  FWhoSign := AValue;
end;

function TWacomSignature.WhySign(AValue: String): IWacomSignature;
begin
  Result := Self;
  FWhySign := AValue;
end;

function TWacomSignature.Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer; Flags: Word;
  var Params; VarResult, ExceptInfo, ArgErr: Pointer): HResult;
var
  dps: TDispParams absolute Params;
  bHasParams: Boolean;
  pDispIds: PDispIdList;
  iDispIdsSize: Integer;
begin
  if (Flags AND DISPATCH_METHOD = 0) then
    Raise Exception.Create('Somente chamadas de métodos são suportadas');

  pDispIds := nil;
  iDispIdsSize := 0;
  bHasParams := (dps.cArgs > 0);

  if (bHasParams) then
  begin
    iDispIdsSize := dps.cArgs * SizeOf(TDispId);
    GetMem(pDispIds, iDispIdsSize);
  end;

  try
    if (bHasParams) then
      BuildPositionalDispIds(pDispIds, dps);
    Result := DoInvoke(DispID, IID, LocaleID, Flags, dps, pDispIds, VarResult, ExceptInfo, ArgErr);
  finally
    if (bHasParams) then
      FreeMem(pDispIds, iDispIdsSize);
  end;

end;

function TWacomSignature.IsSigning: Boolean;
begin
  Result := FIsSigning;
end;

function TWacomSignature.OnCancel(AValue: TProcWacomOnCancel): IWacomSignature;
begin
  Result := Self;
  FOnCancel := AValue;
end;

function TWacomSignature.OnSigned(AValue: TProcWacomOnSigned): IWacomSignature;
begin
  Result := Self;
  FOnSigned := AValue;
end;

function TWacomSignature.DoInvoke(DispID: Integer; const IID: TGUID; LocaleID: Integer; Flags: Word;
  var dps: TDispParams; pDispIds: PDispIdList; VarResult, ExcepInfo, ArgErr: Pointer): HResult;
type
  POleVariant = ^OleVariant;
begin
  Result := DISP_E_MEMBERNOTFOUND;
  case DispId of
    0:
      begin
        PadEvent(IDispatch(dps.rgvarg^[pDispIds^[0]].dispval), dps.rgvarg^[pDispIds^[1]].bstrval,
          OleVariant(dps.rgvarg^[pDispIds^[2]]));
        Result := S_OK;
      end;
  end;
end;

function TWacomSignature.Cancel(): Boolean;
begin
  If FIsSigning Then
  begin
    SignClose;
    if Assigned(FOnCancel) then
      FOnCancel(Self);
  end;
  Result := True;
end;

function TWacomSignature.Clear: Boolean;
begin
  If FIsSigning Then
  Begin
    SignClose;
    StartWizard;
  End;
  Result := True;
end;

procedure TWacomSignature.BuildPositionalDispIds(pDispIds: PDispIdList; const dps: TDispParams);
var
  i: Integer;
begin
  Assert(pDispIds <> nil);

  { by default, directly arrange in reverse order }
  for i := 0 to dps.cArgs - 1 do
    pDispIds^[i] := dps.cArgs - 1 - i;

  { check for named args }
  if (dps.cNamedArgs <= 0) then
    Exit;

  { parse named args }
  for i := 0 to dps.cNamedArgs - 1 do
    pDispIds^[dps.rgdispidNamedArgs^[i]] := i;
end;

procedure TWacomSignature.PadEvent(const WizCtl1: IDispatch; const id: WideString;
  EventType: OleVariant);
begin
  if id = 'Ok' then
  begin
    SignCompleted();
    if Assigned(FOnSigned) then
      FOnSigned(Self);
  end
  else if id = 'Cancel' then
  begin
    SignClose();
    if Assigned(FOnCancel) then
      FOnCancel(Self);
  end;
end;

class function TWacomSignature.ReadSignature(ASigText: String): IWacomReadSignature;
begin
  Result := TReadSignature.Create(ASigText);
end;

procedure TWacomSignature.SignCompleted;
var
  LSigObj: SigObj;
  LIndex: Integer;
begin
  LSigObj := SigObj(FSigCtl.Signature);

  LSigObj.ExtraData['TopText'] := FTopText;
  for LIndex := Low(FDetails) to High(FDetails) do
    LSigObj.ExtraData['Detail[' + LIndex.ToString + ']'] := FDetails[LIndex];
  LSigObj.ExtraData['WhoSign'] := FWhoSign;
  LSigObj.ExtraData['WhySign'] := FWhySign;

  FSigText := LSigObj.SigText;

  SignClose();
end;

function TWacomSignature.SignText: String;
begin
  Result := FSigText;
end;

procedure TWacomSignature.SignClose;
begin
  FIsSigning := False;
  FWizCtl.DefaultInterface.Reset;
  FWizCtl.DefaultInterface.Display;
  FWizCtl.DefaultInterface.PadDisconnect;
  FWizCtl.DefaultInterface.SetEventHandler(nil);
end;

{ TWacomSignature.TReadSignature }

constructor TWacomSignature.TReadSignature.Create(ASigText: String);
begin
  FSigCtl := TSigCtl.Create(nil);
  FSigCtl.Licence := LITE_LICENSE;
  SigObj(FSigCtl.Signature).SigText := ASigText;
end;

destructor TWacomSignature.TReadSignature.Destroy;
begin
  FreeAndNil(FSigCtl);
  inherited;
end;

function TWacomSignature.TReadSignature.RenderBitmap(AFileName: String): Boolean;
begin
  SigObj(FSigCtl.Signature).RenderBitmap(AFileName, 200, 150, 'image/bmp', 0.5, $FF0000, $FFFFFF,
    -1.0, -1.0, RenderOutputFilename or RenderColor32BPP or RenderEncodeData);
  Result := FileExists(AFileName);
end;

function TWacomSignature.TReadSignature.WhenSign: String;
begin
  Result := DateTimeToStr(SigObj(FSigCtl.Signature).When[TimeLocal]);
end;

function TWacomSignature.TReadSignature.WhoSign: String;
begin
  Result := SigObj(FSigCtl.Signature).Who;
end;

function TWacomSignature.TReadSignature.WhySign: String;
begin
  Result := SigObj(FSigCtl.Signature).Why;
end;

end.
