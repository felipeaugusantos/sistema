unit untSuportePlugins;

interface

uses
  Classes, System.SysUtils, Winapi.Windows, Vcl.Forms, Vcl.Menus, Vcl.ExtCtrls,
  Vcl.Graphics, Uni, cxImage, dxCoreGraphics, cxEdit, dxGDIPlusClasses,
  untInterfacePlugin;

type

  TPluginCallback = class
  private
    objHost: IHost;
    strNomeDll: String;
    strNomeProc: String;
  public
    constructor Create(const objHost: IHost; strNomeDll, strNomeProc: String);
    procedure pExecuta(Sender: TObject);
  end;

  TPluginHost = class(TInterfacedObject, IHost)
  private
    FOwner: TComponent;
    FMenuPrincipal: TMainMenu;
    FPainel: TPanel;
    intTopIconePlugin: Integer;
    FNomeDll: String;
    FProcName: String;
    procedure pExec(Sender: TObject);
    procedure pExec_;
  public
    constructor Create(cmpOwner: TComponent; mnuMenu: TMainMenu; pnlPanel: TPanel);
    destructor Destroy; override;
    procedure pAddMenu(strCaminho: Array of String; strDirAcesso, strProcName: String);
    procedure pAddButton(arrIcone: Array of Integer; strDirAcesso, strProcName: String);
    function fGetUsuario(): String;
    function fGetEmpresa(): String;
    function fGetQuery(): IQuery;
    property strNomeDll: String read FNomeDll write FNomeDll;
  end;

  TPluginQuery = class(TInterfacedObject, IQuery)
  private
    FQuery: TUniQuery;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
    procedure Open;
    procedure Close;
    procedure First;
    procedure Last;
    procedure Next;
    procedure Prior;
    procedure ExecSQL;
    function Eof: Boolean;
    function Bof: Boolean;
    function FieldValue(fieldName: String): Variant;
    function GetSQL: TStrings;
  End;

  procedure pCarregaPlugins(cmpOwner: TComponent; mnuMenu: TMainMenu; pnlPanel: TPanel);
  procedure pVerificaPermissaoBotoesPlugins(pnlPanel: TPanel);

implementation

uses
  untFuncoesSimples, untGravando;

var
  objHost: IHost;

{ TPluginHost }

constructor TPluginHost.Create(cmpOwner: TComponent; mnuMenu: TMainMenu; pnlPanel: TPanel);
begin
  inherited Create();
  FOwner := cmpOwner;
  FMenuPrincipal := mnuMenu;
  FPainel := pnlPanel;

  intTopIconePlugin := 0;
end;

destructor TPluginHost.Destroy;
begin
  inherited;
end;

function TPluginHost.fGetEmpresa: String;
begin
  Result := VS_strCodEmp;
end;

function TPluginHost.fGetQuery: IQuery;
begin
  Result := TPluginQuery.Create();
end;

function TPluginHost.fGetUsuario: String;
begin
  Result := strLoginUsuarioLogado;
end;

procedure TPluginHost.pAddButton(arrIcone: Array of Integer;
  strDirAcesso, strProcName: String);
var
  btnIcone: TcxImage;
  colors: TRGBColors;
  i, j: Integer;

  function fCriaIcone(var top: Integer): TcxImage;
  Begin
    Result := TcxImage.Create(FOwner);
    Result.Parent := FPainel;
    Result.Top := top;
    Result.Left := 0;
    Result.Height := 70;
    Result.Width := 80;
    Result.Properties.ShowFocusRect := False;
    Result.Style.BorderStyle := ebsNone;
    Result.Style.LookAndFeel.NativeStyle := False;
    Result.StyleFocused.BorderColor := clLime;
    Result.StyleFocused.BorderStyle := ebsThick;
    Result.StyleHot.BorderColor := clLime;
    Result.StyleHot.BorderStyle := ebsThick;
    Result.Transparent := True;
    Result.SendToBack;

    top := top + 70;
  End;

  function fConverteCores(intGRBA: Integer): TRGBQuad;
  Begin
    Result.rgbRed      := (intGRBA And $000000FF);
    Result.rgbGreen    := (intGRBA And $0000FF00) DIV $100;
    Result.rgbBlue     := (intGRBA And $00FF0000) DIV $10000;
    Result.rgbReserved := (intGRBA And $FF000000) DIV $1000000;
  End;

begin
  SetLength(colors, TAMANHO_ICONE * TAMANHO_ICONE);
  For i := 0 To TAMANHO_ICONE - 1 Do
    For j := 0 To TAMANHO_ICONE - 1 Do
      colors[j * TAMANHO_ICONE + i] := fConverteCores(arrIcone[i * TAMANHO_ICONE + j]);

  btnIcone := fCriaIcone(intTopIconePlugin);
  btnIcone.Picture.Graphic := TdxPNGImage.CreateFromBits(TAMANHO_ICONE, TAMANHO_ICONE, colors, True);
  btnIcone.Hint := strDirAcesso;

  FProcName := strProcName;
  btnIcone.OnClick := pExec;
end;

procedure TPluginHost.pAddMenu(strCaminho: Array of String;
  strDirAcesso, strProcName: String);
var
  mnuInicial, mnuFinal: TMenuItem;

  function fJaTemHint(mnuRaiz: TMenuItem; strHint: String): Boolean;
  var
    intIdx: Integer;
    mnuAtual: TMenuItem;
  Begin
    Result := False;
    For intIdx := 0 To mnuRaiz.Count - 1 Do
    Begin
      mnuAtual := mnuRaiz.Items[intIdx];
      If UpperCase(mnuAtual.Hint) = UpperCase(strHint) Then
        Result := True
      Else
        Result := fJaTemHint(mnuAtual, strHint);

      If Result Then
        Break;
    End;
  End;

  function fHintUnico(strHint: String): String;
  var
    intSufixo: Integer;
  Begin
    Result := strHint;
    intSufixo := 0;
    While fJaTemHint(FMenuPrincipal.Items, Result) Do
    Begin
      Inc(intSufixo);
      Result := strHint + IntToStr(intSufixo);
    End;
  End;

  function fCriaMenu(strCamParc: array of String; intIdx: Integer; mnuPai: TMenuItem; blnVisible: Boolean): TMenuItem;
  var
    mnuFilho: TMenuItem;
  Begin
    mnuFilho := mnuPai.Find(strCamParc[intIdx]);
    If mnuFilho = nil Then
    Begin
      mnuFilho := TMenuItem.Create(FOwner);
      mnuFilho.Caption := strCamParc[intIdx];
      mnuFilho.Hint := fHintUnico(fTiraCaracEspeciais(UpperCase(strCamParc[intIdx]), True, True));
      mnuFilho.Visible := blnVisible;
      mnuFilho.Tag := IIF(blnVisible, 0, 1);
      mnuPai.Add(mnuFilho);
      QuickSort(mnuPai, 0, mnuPai.Count-1);
    End;

    If Length(strCamParc) = intIdx + 1 Then
      Result := mnuFilho
    Else
      Result := fCriaMenu(strCamParc, intIdx + 1, mnuFilho, blnVisible);
  End;

begin
  mnuInicial := FMenuPrincipal.Items.Find(strCaminho[0]);
  If mnuInicial = nil Then
  Begin
    mnuInicial := TMenuItem.Create(FOwner);
    mnuInicial.Caption := strCaminho[0];
    mnuInicial.Hint := fHintUnico(fTiraCaracEspeciais(UpperCase(strCaminho[0]), True, True));
    mnuInicial.Visible := strProcName <> '';
    mnuInicial.Tag := IIF(strProcName <> '', 0, 1);
    FMenuPrincipal.Items.Add(mnuInicial);
  End;

  mnuFinal := fCriaMenu(strCaminho, 1, mnuInicial, strProcName <> '');
  mnuFinal.Hint := strDirAcesso;
  If strProcName <> '' Then
  Begin
    FProcName := strProcName;
    mnuFinal.OnClick := pExec;
  End;
end;

procedure TPluginHost.pExec(Sender: TObject);
begin
  TfrmGravando.fExecutarModalA(pExec_, 'Gerando dashboard, aguarde...', '');
end;

procedure TPluginHost.pExec_;
begin
  TPluginCallback.Create(Self, FNomeDll, FProcName).pExecuta(Self);
end;

{ TPluginQuery }

function TPluginQuery.Bof: Boolean;
begin
  Result := FQuery.Bof;
end;

procedure TPluginQuery.Close;
begin
  FQuery.Close;
end;

constructor TPluginQuery.Create;
begin
  inherited Create;
  FQuery := fCriaQuery();
end;

destructor TPluginQuery.Destroy;
begin
  FreeAndNil(FQuery);
  inherited;
end;

function TPluginQuery.Eof: Boolean;
begin
  Result := FQuery.Eof;
end;

procedure TPluginQuery.ExecSQL;
begin
  FQuery.ExecSQL;
end;

function TPluginQuery.FieldValue(fieldName: String): Variant;
begin
  Result := FQuery.FieldByName(fieldName).Value;
end;

procedure TPluginQuery.First;
begin
  FQuery.First;
end;

function TPluginQuery.GetSQL: TStrings;
begin
  Result := FQuery.SQL;
end;

procedure TPluginQuery.Last;
begin
  FQuery.Last;
end;

procedure TPluginQuery.Next;
begin
  FQuery.Next;
end;

procedure TPluginQuery.Open;
begin
  FQuery.Open;
end;

procedure TPluginQuery.Prior;
begin
  FQuery.Prior;
end;

procedure pCarregaPlugins(cmpOwner: TComponent; mnuMenu: TMainMenu; pnlPanel: TPanel);
var
  srcArquivo : TSearchRec;
  intAchou : Integer;
  strPath : String;
  HandlePlugin: THandle;
  FiremonkeyDashboard: Boolean;
  execProc: TProcExecPlugin;
begin
  objHost := TPluginHost.Create(cmpOwner, mnuMenu, pnlPanel);
  strPath := ExtractFilePath(Application.ExeName);

  intAchou := FindFirst(strPath + 'lib*Plugin.dll', faArchive, srcArquivo);
  If (intAchou = 0) Then
  Begin
    Repeat
      FiremonkeyDashboard := Pos('Dashboard'.ToUpper, String(srcArquivo.Name).ToUpper) > 0;

      If (Not VersaoWindowsSuportaFiremonkey) And (FiremonkeyDashboard) Then
        HandlePlugin := 0
      Else
        HandlePlugin := LoadLibrary(PChar(srcArquivo.Name));

      Try
        If (HandlePlugin <> 0) then
        begin
          @execProc := GetProcAddress(HandlePlugin, 'pInicializaPlugin');
          if Assigned(execProc) then
          Begin
            TPluginHost(objHost).strNomeDll := srcArquivo.Name;
            execProc(objHost);
          End;
        end;
      Finally
        FreeLibrary(HandlePlugin);
      End;
    Until FindNext(srcArquivo) <> 0;
  End;
end;

{ TPluginCallback }

constructor TPluginCallback.Create(const objHost: IHost; strNomeDll, strNomeProc: String);
begin
  inherited Create;
  Self.objHost     := objHost;
  Self.strNomeDll  := strNomeDll;
  Self.strNomeProc := strNomeProc;
end;

procedure TPluginCallback.pExecuta(Sender: TObject);
var
  HandlePlugin: THandle;
  execProc: TProcExecPlugin;
begin
  HandlePlugin := GetModuleHandle(PChar(strNomeDll));
  If HandlePlugin = 0 then
    HandlePlugin := LoadLibrary(PChar(strNomeDll));
  Try
    If HandlePlugin <> 0 then
    begin
      @execProc := GetProcAddress(HandlePlugin, PChar(strNomeProc));
      if Assigned(execProc) then
        execProc(objHost);
    end;
  Finally
    pTrimAppMemorySize;
  End;
end;

procedure pVerificaPermissaoBotoesPlugins(pnlPanel: TPanel);
var
  idx: Integer;
Begin
  For idx := 0 to pnlPanel.ControlCount - 1 Do
  Begin
    pnlPanel.Controls[idx].Visible := fVerificaAcessoSistema(pnlPanel.Controls[idx].Hint);
  End;
End;

end.
