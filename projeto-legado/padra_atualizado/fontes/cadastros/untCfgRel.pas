unit untCfgRel;

interface

uses Uni, Registry, Windows, Data.DB, frxPrinter, system.classes, vcl.forms, IOUtils, DateUtils,
  Vcl.Controls, Dialogs, untTypesSistema, Winapi.WinSpool, System.Rtti, frxClass, ShellApi, CRAccess,
  untWord, frxPreview, RLReport, RLPreviewForm, RLConsts, Vcl.AppEvnts, Winapi.Messages, Variants;

Type
  TCfgRel = class
  public
    //Funcoes utilizadas pelo cfgrel e units dependentes
    class var fCriaQuery: TfCriaQuery;
    class var fCriarQuery: TfCriarQuery;
    class var fInTransaction: TfInTransaction;
    class var fCampoTabela: TfCampoTabela;
    class var pCriarFormularios: TpCriarFormularios;
    class var pFreeAndNil: TpFreeAndNil;
    class var pMensagensErro: TpMensagensErro;
    class var fCfgSis: TfCfgSis;
    class var fEmptyStr: TfEmptyStr;
    class var pSetFocus: TpSetFocus;
    class var fMensagem: TfMensagem;
    class var pMensagemOk: TpMensagemOk;
    class var fEntraCons: TfEntraCons;
    class var fRetNomeOperador: TfRetNomeOperador;
    class var fGetTituloVersao: TfGetTituloVersao;
    class var fGetUsuarioLogado: TfGetUsuarioLogado;
    class var fGetEmpresaLogada: TfGetEmpresaLogada;
    class var fRetNomeRede: TfRetNomeRede;
    class var fGetIPAddress: TfGetIPAddress;
    class var fGetIPAddressAsString: TfGetIPAddressAsString;
    class var fGetMacAddress: TfGetMacAddress;
    class var fGetUserFromWindows: TfGetUserFromWindows;
    class var fGetComputerNetName: TfGetComputerNetName;
    class var fPesqOperador: TfPesqOperador;
    class var fPesqConfiguracaoRel: TfPesqConfiguracaoRel;

    class var VS_TSPlus: Boolean;
    class var VS_SpoolImpressaoCitel: Boolean;
    class var strNomFormTmp: String;
    class var VS_blnDlgPri: Boolean;
    class var arrFilas: TArrFilas; // Array Of TFilasImp;
    class var AtivarCfgLayoutRegraCancelamento: Boolean;
    class var blnExibirMensagem: Boolean;

    class function fNow(): TDateTime;
    class function fGetMD5(AValue: String): String;

    class function GetUltimoDiretorioAcessado: String;
    class function SetUltimoDiretorioAcessado(AValue: String): Boolean;

    class function fCheckParent(Sender, Parent: TWinControl): Boolean;

    class function fRemoveAcento(Str: String): String;

    class function fCnpjEmpresaFisica: String;
    class function fRetEmpresaFisica: String;
    class function fCampoExiste(const strTabela, strCampo: String): Boolean;

    class function fPerguntaTipo(qryCfgRel: TUniQuery): Boolean;
    class function fObtemVariavelAmbiente(const strNome: String): String;
    class function fSelecionaFilaImp(Var qryCfgRel: TUniQuery): Boolean;

    class function fSelecionaFila(strFrm: String; strInc: String = '';
      blnImpressorasCadastradas: Boolean = False; blnOpcaoNaoImprimir: Boolean = False;
      strDesFrm: String = ''; strFiltroNomeImpressora: String = ''; strUltimaFilaUtilizada: String = ''): String; overload;

    class function fSelecionaFila(strNomFrm, strAutInc, strCodOpe, strNomMaq: String;
      var strNomImp, strTipImp: String; blnImpressorasCadastradas: Boolean = False;
      blnOpcaoNaoImprimir: Boolean = False): Boolean; overload;

    class procedure pInsereFilaImpressaoUsuario(const strNomFrm, strNomImp, strTipImp, strCodOpe: String);

    class function fFilaJaExiste(strAutInc, strCodOpe, strNomMaq, strNomeForm, strCodEmp,
      strNomeFila: String): Boolean;

    class procedure pFillPrinters();

    class function fPreImpressao(qryCfgRel: TUniQuery; Var strNomeFila: String;
      Var strTipImp: String; blnLocal: Boolean; strDirImp: String = '';
      blnBoleto: Boolean = False; strUltimaFilaUtilizada: String = ''): Boolean;

    class procedure pSetPrinter(strNomImp: String);

    class procedure pConfigurarFilaDeImpressao(qryCfgRel: TUniQuery;
      strNomeForm: String);

    class procedure pCarregaConfImprRel(Const strNomeForm: String;
      Var strNomImp: String; Var strTipImp: String; strCodEmp: String = '';
      blnPreImp: Boolean = False); overload;


    class procedure pCarregaConfImpr(Var qryCfgRel: TUniQuery;
      Const strNomeForm: String; strCodEmp: String = '';
      strNomeFila: String = ''; strCodOpe: String = '');

    class function fRetTipoImpressora(var strTipImp: String): Boolean;

    class function fMostraFilas(Var strNomeFila: String;
      strNomFormul: String = ''; qryCfgRel: TUniQuery = nil;
      blnBotoes: Boolean = True): Boolean;

    class function fPadL(strTexto: String; intTamanho: Integer; strCaracter: String = ' '): String;
    class function fPadR(strTexto: String; intTamanho: Integer; strCaracter: String = ' '): String; Overload;
    class function fPadC(strTexto: String; intTamanho: Integer; strCaracter: String = ' '): String;
    class function fPadR(strTexto: String; intTamanhoMin: Integer; intTamanhoMax: Integer; strCaracter: String = ' '): String; Overload;

    class function fRetAutoIncrem(strNomeTabela, strCodEmp: String): String;

    class procedure pRetFilasImpressao(var arrFilas: TArrFilas);

    class procedure pAbrirGaveta(strImpressora, strModelo: String);

    class function fIdentificarNomeDaImpressora(AImpressora: String): String;

    class function VerImpressoraONLINE(AImpressora: String; AExibirMensagem: Boolean = True): Cardinal;

    class function IsPrinterMatrix(impressora: String): Boolean;

    class function fGetImpPadraoWindows: String;
    class function fGetImpressoraSelecionada: String;
    class function fImpressoraFastValida(AReport: TfrxReport): Boolean;

    class function fImpressoraExiste(strNomImp: String): Boolean;

    class function fVerificaImpressora(strNomeImpr: String): Boolean;

    class function fExecutePrintDialog(Var APrinterName: String): Boolean;

    class procedure pExecArquivoPrintTo(strArquivo, strImpressosa: String; Handle: THandle);

    class procedure pPrintTXT(strNomPro, strDesPro: String; strNomArq: String);
    // True se o texto foi entregue ao spooler ou a impressora; False em qualquer saida sem
    // imprimir (fila nao cadastrada, escolha cancelada, impressora vazia ou inexistente).
    class function fPrintTXT(strNomPro, strDesPro: String; strNomArq: String): Boolean;

    class procedure pPrintPDF(strNomPro, strDesPro, strNomImp: String; strArqPDF: String);

    class procedure pPrintToFile(strNomFrm, strNomImp, strNomArq: String);

    class procedure pPrintReport(strNomPro, strDesPro, strNomImp: String; AWord: TWord); overload;
    class procedure pPrintReport(strNomPro, strDesPro, strNomImp: String; AReport: IReport); overload;
    class procedure pPrintReport(strNomPro, strDesPro, strNomImp: String; AReport: TfrxReport; GrayedScale: Boolean = False); overload;
    class procedure pPrintReport(strNomPro, strDesPro, strNomImp: String; AReport: TRLReport); overload;

    class procedure pPreviewReport(strNomPro, strDesPro: String; AReport: IReport); overload;
    class procedure pPreviewReport(strNomPro, strDesPro: String; AReport: TfrxReport); overload;
    class procedure pPreviewReport(strNomPro, strDesPro: String; AReport: TRLReport; ASetup: TRLPreviewSetup); overload;

    class procedure pDesignReport(strNomPro, strDesPro: String; AReport: TfrxReport);
  End;

type
  TPreviewReport = class sealed
  private
    FNomPro: String;
    FDesPro: String;
    FReport: IReport;
    FOldPrintBClick: procedure(Sender: TObject) of Object;
  protected
    procedure OnPreview(Sender: TObject);
    procedure PrintBClick(Sender: TObject);
  public
    class procedure PreviewReport(const APrograma, ADescricao: String; AReport: IReport);
  end;

type
  TFastPreviewReport = class sealed
  private
    FNomPro: String;
    FDesPro: String;
    FReport: TFrxReport;
    FAppEvents: TApplicationEvents;
    FOldPrintBClick: procedure(Sender: TObject) of Object;
  protected
    procedure OnMessage(var Msg: tagMSG; var Handled: Boolean);
    procedure OnPreview(Sender: TObject);
    procedure PrintBClick(Sender: TObject);
  private
    constructor Create;
  public
    destructor Destroy; override;
  public
    class procedure PreviewReport(const APrograma, ADescricao: String; AReport: TfrxReport);
    class procedure DesignReport(const APrograma, ADescricao: String; AReport: TfrxReport);
  end;

type
  TFortesPreviewReport = class sealed
  private
    FNomPro: String;
    FDesPro: String;
    FReport: TRLReport;
    FSetup: TRLPreviewSetup;
  protected
    procedure OnBeforePrint(Sender: TObject);
    procedure OnBeforeSave(Sender: TObject);
  public
    class procedure PreviewReport(const APrograma, ADescricao: String; AReport: TRLReport; ASetup: TRLPreviewSetup);
  end;

implementation

uses SysUtils, StrUtils, Printers, untSelFilImpressao, untCadConfRelatorios,
  untMenuFilas, untMenuTipImp, untSpoolImpressao, untSpoolPrintDialog,
  untWorkStationInfo, untConstantes;

function KeyIsDown(const Key: Integer): Boolean;
begin
  Result := GetKeyState(Key) and 128 > 0;
end;

{ TFastPreviewReport }

class procedure TFastPreviewReport.PreviewReport(const APrograma, ADescricao: String; AReport: TfrxReport);
Var
  LPreview: TFastPreviewReport;
begin
  LPreview := TFastPreviewReport.Create;
  Try
    LPreview.FNomPro := APrograma;
    LPreview.FDesPro := ADescricao;
    LPreview.FReport := AReport;
    AReport.OnPreview := LPreview.OnPreview;
    AReport.ShowReport;
  Finally
    FreeAndNil(LPreview);
  End;
end;

class procedure TFastPreviewReport.DesignReport(const APrograma, ADescricao: String; AReport: TfrxReport);
Var
  LPreview: TFastPreviewReport;
begin
  LPreview := TFastPreviewReport.Create;
  Try
    LPreview.FNomPro := APrograma;
    LPreview.FDesPro := ADescricao;
    LPreview.FReport := AReport;
    AReport.OnPreview := LPreview.OnPreview;
    AReport.DesignReport;
  Finally
    FreeAndNil(LPreview);
  End;
end;

constructor TFastPreviewReport.Create;
begin
  FAppEvents := TApplicationEvents.Create(nil);
  FAppEvents.OnMessage := Self.OnMessage;
end;

destructor TFastPreviewReport.Destroy;
begin
  FreeAndNil(FAppEvents);
  inherited;
end;

procedure TFastPreviewReport.OnMessage(var Msg: tagMSG; var Handled: Boolean);
begin
  if Assigned(FReport) and Assigned(FReport.Preview) then
    if Msg.hwnd = FReport.Preview.Handle then
    begin
      if (Msg.message = WM_KEYFIRST) and
        ((Msg.wParam = Ord('p')) or (Msg.wParam = Ord('P'))) then
      begin
        if KeyIsDown(VK_CONTROL) then
        begin
          Msg.message := 0;
          PrintBClick(nil);
        end;
      end;
    end;
end;

procedure TFastPreviewReport.OnPreview(Sender: TObject);
begin
  TfrxPreviewForm(FReport.PreviewForm).Caption := FDesPro;
  FOldPrintBClick := TfrxPreviewForm(FReport.PreviewForm).PrintB.OnClick;
  TfrxPreviewForm(FReport.PreviewForm).PrintB.OnClick := Self.PrintBClick;
end;

procedure TFastPreviewReport.PrintBClick(Sender: TObject);
Var
  LFrmDlg: TSpoolPrintDialog;
begin
  If TCfgRel.VS_SpoolImpressaoCitel Then
  Begin
    LFrmDlg := TSpoolPrintDialog.Create(nil);
    Try
      LFrmDlg.Caption := FDesPro;
      LFrmDlg.FReport := FReport;
      If LFrmDlg.ShowModal = mrOk Then
        If Assigned(LFrmDlg.PrintersCB.Selected) Then
          TCfgRel.pPrintReport(FNomPro, FDesPro, LFrmDlg.PrintersCB.Selected.Text,
            FReport, LFrmDlg.GrayedScale.Checked);
    Finally
      FreeAndNil(LFrmDlg);
    End;
  End
  Else
    FOldPrintBClick(Sender);
end;

{ TFortesPreviewReport }

procedure TFortesPreviewReport.OnBeforePrint(Sender: TObject);
Var
  LQuery: TUniQuery;
  LNomImp: String;
  LTipImp: String;
begin
  If TCfgRel.VS_SpoolImpressaoCitel Then
  Begin
    LQuery := TCfgRel.fCriaQuery(nil);
    Try
      TCfgRel.pCarregaConfImpr(LQuery, FNomPro);
      If TCfgRel.fPreImpressao(LQuery, LNomImp, LTipImp, False) Then
        TCfgRel.pPrintReport(FNomPro, FDesPro, LNomImp, FReport);
    Finally
      FreeAndNil(LQuery);
    End;
    Abort;
  End;
end;

procedure TFortesPreviewReport.OnBeforeSave(Sender: TObject);
Var
  LNomImp: String;
begin
  If TCfgRel.VS_SpoolImpressaoCitel Then
  Begin
    Try
      LNomImp := TCfgRel.fSelecionaFila('', '', False, False, 'Selecione uma impressora PDF', 'PDF|UNIVERSAL PRINTER');
      If Not LNomImp.IsEmpty Then
      Begin
        Printer.PrinterIndex := Printer.Printers.IndexOf(LNomImp);
        FReport.Print;
      End;
    Finally
      Abort;
    End;
  End;
end;

class procedure TFortesPreviewReport.PreviewReport(const APrograma,
  ADescricao: String; AReport: TRLReport; ASetup: TRLPreviewSetup);
Var
  LPreview: TFortesPreviewReport;
begin
  LPreview := TFortesPreviewReport.Create;
  Try
    LPreview.FNomPro := APrograma;
    LPreview.FDesPro := ADescricao;
    LPreview.FReport := AReport;
    LPreview.FSetup  := ASetup;
    ASetup.BeforePrint := LPreview.OnBeforePrint;
    ASetup.BeforeSave := LPreview.OnBeforeSave;
    If TCfgRel.VS_SpoolImpressaoCitel Then
    Begin
      LocaleStrings.LS_SaveStr := 'PDF';
      LocaleStrings.LS_SaveToFileStr := 'Selecionar uma impressora PDF';
    End;
    AReport.PreviewModal;
  Finally
    FreeAndNil(LPreview);
  End;
end;

class function TCfgRel.fVerificaImpressora(strNomeImpr: String): Boolean;
Var
  txtImpressora: TextFile;
Begin
  If TCfgRel.VS_SpoolImpressaoCitel Then
  Begin
    Result := TCfgRel.fImpressoraExiste(strNomeImpr);
    Exit;
  End;

  Result := True;
  Try
    AssignFile(txtImpressora, strNomeImpr);
    Rewrite(txtImpressora);

    CloseFile(txtImpressora);
  Except
    On E: Exception Do
    Begin
      Result := False;
      If Pos('file access denied', LowerCase(E.Message)) > 0 Then
        Result := True;
    End;
  End;

  If (Not Result) And (Win32Platform = 1) Then
  Begin
    Result := True;
    Try
      AssignFile(txtImpressora, 'LPT1');
      Rewrite(txtImpressora);

      CloseFile(txtImpressora);
    Except
      On E: Exception Do
      Begin
        Result := False;
        If Pos('file access denied', LowerCase(E.Message)) > 0 Then
          Result := True;
      End;
    End;
  End;

End;

class function TCfgRel.GetUltimoDiretorioAcessado: String;
begin
  Result := fCampoTabela('OPE_ULTDIR', 'CADOPE', ['OPE_CODOPE'], [fGetUsuarioLogado]);
end;

class function TCfgRel.fImpressoraExiste(strNomImp: String): Boolean;
begin
  Result := VerImpressoraONLINE(fIdentificarNomeDaImpressora(strNomImp), False) = 0;
end;

class procedure TCfgRel.pRetFilasImpressao(Var arrFilas: TArrFilas);
Var
  intContador: Integer;
  strNomRed: String;
begin
  If TCfgRel.VS_SpoolImpressaoCitel Then
  Begin
    SetLength(arrFilas, 0);
    Exit;
  End;

  strNomRed := TCfgRel.fRetNomeRede();

  SetLength(arrFilas, Printer.Printers.Count);
  For intContador := 0 To Printer.Printers.Count - 1 Do
  Begin
    arrFilas[intContador].strNomeFila := Printer.Printers[intContador];

    If Not TCfgRel.fCfgSis('CADIMP', VarBoolean) Then
    Begin
      If (Pos(' on ', arrFilas[intContador].strNomeFila) > 0) Then
        arrFilas[intContador].strNomeFila :=
          Trim(LeftStr(arrFilas[intContador].strNomeFila,
          Pos(' on ', arrFilas[intContador].strNomeFila)));

      If (Copy(arrFilas[intContador].strNomeFila, 1, 2) <> '\\') Then
        arrFilas[intContador].strNomeFila := '\\' + strNomRed + '\' +
          arrFilas[intContador].strNomeFila;
    End;

    arrFilas[intContador].blnMostrar := True;
  End;
end;

class function TCfgRel.fIdentificarNomeDaImpressora
  (AImpressora: String): String;
Var
  LImpressora: String;
  LExpressoes: TArray<String>;

  function fIdentificouImpressora(): Boolean;
  Var
    LExpressao: String;
  begin
    Result := False;
    For LExpressao In LExpressoes Do
      If TCfgRel.fCampoTabela(LImpressora.QuotedString + ' LIKE ' +
        LExpressao.Replace('NOME_IMPRESSORA', AImpressora).Replace('\', '\\')
        .QuotedString, '', [], [], False) > 0 Then
      Begin
        Result := True;
        Break;
      End;
  end;

begin
  Result := AImpressora;

  If TCfgRel.fEmptyStr(Result) Then
    Exit;

  If TCfgRel.VS_SpoolImpressaoCitel Then
    Exit;

  If Not TCfgRel.fCfgSis('CADIMP', VarBoolean) Then
    Exit;

  Try
    LExpressoes :=
      String(TCfgRel.fCampoTabela('GROUP_CONCAT(IDE_EXPRES SEPARATOR "->")',
      'IDEIMP', [], [], False)).Split(['->']);

    Printer.Refresh;

    For LImpressora In Printer.Printers Do
      If fIdentificouImpressora() Then
        Exit(LImpressora);

  Finally
    SetLength(LExpressoes, 0);
  End;
end;


class function TCfgRel.IsPrinterMatrix(impressora: String): Boolean;
var
  DeviceMode: THandle;
  Device, Driver, Port: array [0..79] of Char;
  pDevice, pDriver, pPort: PChar;
begin
  // Com o spool Citel o nome é de um ponto de impressão, e consultar o Printer depende do Spooler
  // do Windows (erro 1722 com ele desligado): o tipo vem do cadastro do ponto.
  If TCfgRel.VS_SpoolImpressaoCitel Then
    Exit(TSpoolImpressaoCitel.fGetPontoImpressao(impressora).TipoImpressora = 'M');

  impressora := fIdentificarNomeDaImpressora(impressora);
  // Determina se a impressora é um Dot-Matrix (Matricial)

  Result:= False;
  If (TCfgRel.fEmptyStr(Trim(impressora))) Then
    Exit;

  pDevice := @Device;
  pDriver := @Driver;
  pPort   := @Port;

  Device  := #0;
  Driver  := #0;
  Port    := #0;

  Printer.PrinterIndex := Printer.Printers.IndexOf(impressora);
  Printer.GetPrinter(pDevice, pDriver, pPort, DeviceMode);

  // A impressora pode ser matricial quando o número de cores é no máximo 16
  // e quando a impressora é capaz de imprimir apenas para TRUETYPE
  // fontes como gráficos (impressoras matriciais e PCL são capazes para isso).

  if (GetDeviceCaps(Printer.Handle,NUMCOLORS)<=16) and
     (DeviceCapabilities(pDevice, pPort,DC_TRUETYPE,nil,nil) = DCTT_BITMAP)
  then
    Result := True;
end;

class function TCfgRel.VerImpressoraONLINE(AImpressora: String; AExibirMensagem: Boolean = True): Cardinal;
const
  STATUS_ONLINE = 0;
Var
  pInfo: PPrinterInfo2;
  bytesNeeded: DWORD;
  hPrinter: THandle;
  LPontoImp: TPontoImpressao;

  Function GetCurrentPrinterHandle: Boolean;
  Var
    Device, Driver, Port: array [0 .. 255] of char;
  Begin
    Printer.GetPrinter(Device, Driver, Port, hPrinter);
    Result := (OpenPrinter(@Device, hPrinter, nil))
  End;

  Procedure MostraMensagem;
  Begin
    if AExibirMensagem And blnExibirMensagem And (not TCfgRel.fInTransaction()) then
    begin
      If TCfgRel.VS_SpoolImpressaoCitel Then
        TCfgRel.fMensagem('ATENÇÃO!', 'Ponto de Impressão não encontrado ou não disponível ("' + AImpressora + '").', ['&OK'])
      Else
        TCfgRel.fMensagem('ATENÇÃO!', 'Impressora não encontrada ou não disponível. Impressora: "' + AImpressora + '".', ['&OK']);
    end;
    Result := 1;
  End;

begin
  If TCfgRel.VS_SpoolImpressaoCitel Then
  Begin
    If Not (TCfgRel.fEmptyStr(Trim(AImpressora))) Then
    Begin
      LPontoImp := TSpoolImpressaoCitel.fGetPontoImpressao(AImpressora);
      If Not LPontoImp.Existe Then
      Begin
        MostraMensagem;
        Exit(1);
      End
      Else If LPontoImp.Status <> 'ONLINE' Then
      Begin
        MostraMensagem;
        Exit(1);
      End;
    End;
    Exit(0);
  End;

  AImpressora := fIdentificarNomeDaImpressora(AImpressora);
  Try
    If (TCfgRel.fEmptyStr(Trim(AImpressora))) Then
    Begin
      Result := 0;
    End
    Else
    Begin
      If (Printer.Printers.IndexOf(AImpressora) < 0) Then
      Begin
        MostraMensagem();
      End
      Else
      Begin;
        Printer.PrinterIndex := Printer.Printers.IndexOf(AImpressora);

        If (Not GetCurrentPrinterHandle()) Then
        Begin
          MostraMensagem();
        End
        Else
        Begin
          Try
            GetPrinter(hPrinter, 2, Nil, 0, @bytesNeeded);
            pInfo := AllocMem(bytesNeeded);

            Try
              GetPrinter(hPrinter, 2, pInfo, bytesNeeded, @bytesNeeded);
              case pInfo^.Status of
                PRINTER_STATUS_OFFLINE,
                PRINTER_STATUS_ERROR,
                PRINTER_STATUS_NOT_AVAILABLE,
                PRINTER_STATUS_PENDING_DELETION: Result := pInfo^.Status;
              else
                Result := STATUS_ONLINE;
              end;
            Finally
              FreeMem(pInfo);
            End;
          Finally
            ClosePrinter(hPrinter);
          End;
        End;
      End;
    End;
  Except
    On E: Exception Do
      TCfgRel.pMensagensErro(E.Message,
        '[untFuncoesSimples.VerImpressoraONLINE]');
  End;
end;

{ ***************************************** }
{ * VERIFICA SE É NECESSARIO PERGUNTAR O  * }
{ * TIPO DE IMPRESSÃO                     * }
{ **************************************MV* }
class function TCfgRel.fPerguntaTipo(qryCfgRel: TUniQuery): Boolean;
begin
  Result := True;
  If (TCfgRel.fEmptyStr(qryCfgRel.FieldByName('REL_PERGUN').AsString)) Or
    (qryCfgRel.FieldByName('REL_PERGUN').AsString = 'N') Then
  Begin
    Result := False;
  End;
end;

class function TCfgRel.fObtemVariavelAmbiente(const strNome: String): String;
Begin
  With TRegistry.Create do
    Try
      RootKey := HKEY_CURRENT_USER;
      OpenKey('Environment', False);
      Result := ReadString(strNome);
    Finally
      Free
    End;
End;

class procedure TCfgRel.pSetPrinter(strNomImp: String);
Var
  buffer1: Array [0 .. 250] Of char;
  buffer2: Array [0 .. 250] Of char;
  buffer3: Array [0 .. 250] Of char;
  ADevice, ADriver, APort: PChar;
  hDm: THandle;
begin
  ADevice := buffer1;
  ADriver := buffer2;
  APort := buffer3;
  Printer.GetPrinter(ADevice, ADriver, APort, hDm);
  Printer.SetPrinter(PChar(strNomImp), ADriver, APort, hDm);
end;

class function TCfgRel.SetUltimoDiretorioAcessado(AValue: String): Boolean;
var
  LQuery: TUniQuery;
begin
  LQuery := fCriaQuery;
  Try
    LQuery.SQL.Add('UPDATE CADOPE SET OPE_ULTDIR = :ULTDIR WHERE OPE_CODOPE = :CODOPE');
    LQuery.ParamByName('ULTDIR').AsString := AValue;
    LQuery.ParamByName('CODOPE').AsString := fGetUsuarioLogado;
    LQuery.ExecSQL;
    Result := True;
  Finally
    FreeAndNil(LQuery);
  End;
end;

class function TCfgRel.fRemoveAcento(Str:String): String;
Const
  ComAcento = 'àâêôûãõáéíóúçüÀÂÊÔÛÃÕÁÉÍÓÚÇÜ"´';
  SemAcento = 'aaeouaoaeioucuAAEOUAOAEIOUCU  ';
Var
   x : Integer;
Begin
  For x := 1 to Length(Str) do
    If Pos(Str[x],ComAcento)<>0 Then
      Str[x] := SemAcento[Pos(Str[x],ComAcento)];
  Result := Str;
end;

class function TCfgRel.fCheckParent(Sender, Parent: TWinControl): Boolean;
begin
  If Sender = Nil Then
  Begin
    Result := False;
    Exit;
  End;

  If Sender.Parent = nil Then
    Result := False
  Else If Sender.Parent = Parent Then
    Result := True
  Else
    Result := fCheckParent(Sender.Parent, Parent);
end;

class function TCfgRel.fSelecionaFilaImp(Var qryCfgRel: TUniQuery): Boolean;
Var
  strNomFil: String;
begin
  Result := True;
  If Assigned(qryCfgRel) And (qryCfgRel.RecordCount > 1) Then
  Begin
    Result := TCfgRel.fMostraFilas(strNomFil,
      qryCfgRel.FieldByName('REL_NOMPRO').AsString, qryCfgRel);
    If Result Then
    Begin
      pCarregaConfImpr(qryCfgRel, qryCfgRel.FieldByName('REL_NOMPRO').AsString,
        qryCfgRel.FieldByName('REL_CODEMP').AsString, strNomFil);
    End;

  End;
end;

{ ***************************************** }
{ * CARREGA OS DADOS DE IMPRESSÃO DE UM   * }
{ * DETERMINADO FORM                      * }
{ **************************************MV* }
type
  TFiltroCfgRel=(opUsuarioLogado, opNomeMaquina, opTodos);

class procedure TCfgRel.pCarregaConfImpr(Var qryCfgRel: TUniQuery;
  Const strNomeForm: String; strCodEmp: String = ''; strNomeFila: String = ''; strCodOpe: String = '');

  procedure pOpenCfgRel(AFiltro: TFiltroCfgRel);
  Var
    strSQL: String;
  begin
    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  * ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CFGREL ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  REL_NOMPRO = :NOMPRO AND ';
    strSQL := strSQL + '  REL_CODEMP = :CODEMP ';

    If Not TCfgRel.fEmptyStr(strNomeFila) Then
      strSQL := strSQL + '  AND REL_NOMFIL = :NOMFIL ';

    If (Not fEmptyStr(strCodOpe)) Then
      strSQL := strSQL + ' AND REL_CODOPE = ' + strCodOpe.QuotedString()
    Else If AFiltro = opUsuarioLogado Then
      strSQL := strSQL + ' AND REL_CODOPE = ' +
        TCfgRel.fGetUsuarioLogado.QuotedString()
    Else
      strSQL := strSQL + ' AND REL_CODOPE IS NULL ';

    If AFiltro = opNomeMaquina Then
      strSQL := strSQL + ' AND REL_NOMMAQ = ' +
        TWorkStationInfo.fGetWorkstationID.QuotedString()
    Else
      strSQL := strSQL + ' AND REL_NOMMAQ IS NULL ';

    If VS_SpoolImpressaoCitel Then
      strSQL := strSQL + ' AND REL_SPOIMP = "S" '
    Else
      strSQL := strSQL + ' AND REL_SPOIMP <> "S" ';

    With qryCfgRel Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NOMPRO').AsString := strNomeForm;
      ParamByName('CODEMP').AsString := strCodEmp;

      If Not TCfgRel.fEmptyStr(strNomeFila) Then
        ParamByName('NOMFIL').AsString := strNomeFila;
      Open;
    End;
  end;

  procedure pOpenEmptyCfgRel;
  Var
    strSQL: String;
  begin
    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  * ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CFGREL ';
    strSQL := strSQL + 'WHERE FALSE';

    With qryCfgRel Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      Open;
    End;
  end;

begin
  strNomFormTmp := strNomeForm;

  If TCfgRel.fEmptyStr(strCodEmp) Then
    strCodEmp := TCfgRel.fGetEmpresaLogada();

  pOpenCfgRel(opUsuarioLogado);

  If qryCfgRel.IsEmpty Then
    pOpenCfgRel(opNomeMaquina);

  If qryCfgRel.IsEmpty Then
    pOpenCfgRel(opTodos);

  If (Not qryCfgRel.IsEmpty) Then
  Begin
    qryCfgRel.Edit;

    If (qryCfgRel.FieldByName('REL_IMPPAD').AsString = 'S') And Not TCfgRel.VS_SpoolImpressaoCitel Then
      qryCfgRel.FieldByName('REL_NOMFIL').AsString := fGetImpPadraoWindows();

    { ************************************************************************** }
    { AS SUBSTITUIÇÕES ABAIXO SÃO REALIZADAS PARA AVALIAR SE A IMPRESSORA ESTÁ }
    { INSTALADA LOCALMENTE NA MÁQUINA QUE ESTÁ REQUISITANDO A IMPRESSÃO DE UM }
    { DOCUMENTO. EM SEGUIDA, SE UMA IMPRESSORA É RETORNADA PELA ROTINA DE FILAS }
    { DE IMPRESSÃO, SERÁ VERIFICADO SE A IMPRESSORA ESTÁ ATIVA. SE NÃO ESTIVER }
    { UMA MENSAGEM DE ALERTA SERÁ EMITIDA AO USUÁRIO }
    { ***********************************************************************DF* }
    qryCfgRel.FieldByName('REL_NOMFIL').AsString :=
      AnsiReplaceStr(qryCfgRel.FieldByName('REL_NOMFIL').AsString,
      '\\' + TCfgRel.fRetNomeRede() + '\', '');

    qryCfgRel.FieldByName('REL_NOMFIL').AsString :=
      AnsiReplaceStr(qryCfgRel.FieldByName('REL_NOMFIL').AsString,
      '\\' + TCfgRel.fGetComputerNetName() + '\', '');

    qryCfgRel.FieldByName('REL_NOMFIL').AsString :=
      AnsiReplaceStr(qryCfgRel.FieldByName('REL_NOMFIL').AsString,
      '\\' + TCfgRel.fGetIPAddressAsString() + '\', '');

    If (Not TCfgRel.fEmptyStr(qryCfgRel.FieldByName('REL_NOMFIL').AsString)) And (qryCfgRel.RecordCount = 1) Then
      If (TCfgRel.VerImpressoraONLINE(qryCfgRel.FieldByName('REL_NOMFIL').AsString) <> 0) Then
      begin
        if not TCfgRel.fInTransaction() then
        begin
          If TCfgRel.VS_SpoolImpressaoCitel Then
            TCfgRel.fMensagem('ATENÇÃO!', 'Ponto de Impressão "' + qryCfgRel.FieldByName('REL_NOMFIL').AsString + '" está OFFLINE!', ['&OK'])
          Else
            TCfgRel.fMensagem('ATENÇÃO!', 'Impressora "' + qryCfgRel.FieldByName('REL_NOMFIL').AsString + '" está OFFLINE!', ['&OK']);
          pOpenEmptyCfgRel;
        end;
      end;
  End;

end;

class function TCfgRel.fCampoExiste(const strTabela, strCampo: String): Boolean;
  Var
    qryAux: TUniQuery;
begin
  qryAux := TCfgRel.fCriaQuery();
  qryAux.SQL.Add('DESC ' + strTabela);
  qryAux.Open;

  Result := False;
  While (Not qryAux.Eof) Do
  Begin
    If qryAux.FieldByName('Field').AsString = strCampo Then
    Begin
      Result := True;
      Break;
    End;

    qryAux.Next;
  End;

  FreeAndNil(qryAux);
end;

class function TCfgRel.fCnpjEmpresaFisica: String;
begin
  Result  := fCampoTabela('EMP_C_G_C_', 'CADEMP', ['EMP_CODEMP'], [fRetEmpresaFisica], False);
end;

class procedure TCfgRel.pExecArquivoPrintTo(strArquivo, strImpressosa: String; Handle: THandle);
Var
  Result: String;
Begin
  Case ShellExecute(Handle, 'printto', PChar(strArquivo), PChar(strImpressosa), nil, SW_HIDE) Of
    ERROR_FILE_NOT_FOUND: Result := 'The specified file was not found.';
    ERROR_PATH_NOT_FOUND: Result := 'The specified path was not found.';
    ERROR_BAD_FORMAT: Result := 'The .EXE file is invalid (non-Win32 .EXE or error in .EXE image).';
    SE_ERR_ACCESSDENIED: Result := 'Windows 95 only: The operating system denied access to the specified file.';
    SE_ERR_ASSOCINCOMPLETE: Result := 'The filename association is incomplete or invalid.';
    SE_ERR_DDEBUSY: Result := 'The DDE transaction could not be completed because other DDE transactions were being processed.';
    SE_ERR_DDEFAIL: Result := 'The DDE transaction failed.';
    SE_ERR_DDETIMEOUT: Result := 'The DDE transaction could not be completed because the request timed out.';
    SE_ERR_DLLNOTFOUND: Result := 'Windows 95 only: The specified dynamic-link library was not found.';
    SE_ERR_NOASSOC: Result := 'There is no application associated with the given filename extension.';
    SE_ERR_OOM: Result := 'Windows 95 only: There was not enough memory to complete the operation.';
    SE_ERR_SHARE: Result := 'A sharing violation occurred.';
  Else
    Exit;
  End;
  ShowMessage(Result);
end;

class function TCfgRel.fExecutePrintDialog(Var APrinterName: String): Boolean;
Var
  LPrintDialog: TPrintDialog;
begin
  APrinterName := '';
  Try
    If TCfgRel.VS_SpoolImpressaoCitel Then
    Begin
      APrinterName := TCfgRel.fSelecionaFila('', '', True);
    End
    Else If TCfgRel.VS_TSPlus Then
    Begin
      APrinterName := TCfgRel.fSelecionaFila('', '', True);
      If Not TCfgRel.fEmptyStr(APrinterName) Then
        TCfgRel.pSetPrinter(fIdentificarNomeDaImpressora(APrinterName));
    End
    Else
    Begin
      LPrintDialog := TPrintDialog.Create(nil);
      Try
        LPrintDialog.Options := [poWarning, poHelp, poDisablePrintToFile];
        If LPrintDialog.Execute() Then
          APrinterName := TCfgRel.fGetImpressoraSelecionada;
      Finally
        FreeAndNil(LPrintDialog);
      End;
    End;
  Finally
    Result := Not TCfgRel.fEmptyStr(APrinterName);
  End;
end;

class function TCfgRel.fFilaJaExiste(strAutInc, strCodOpe, strNomMaq, strNomeForm,
  strCodEmp, strNomeFila: String): Boolean;
Var
  strSQL: String;
  qryCfg: TUniQuery;
begin
  qryCfg := TCfgRel.fCriaQuery();

  If TCfgRel.fEmptyStr(strCodEmp) Then
    strCodEmp := TCfgRel.fGetEmpresaLogada();

  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CFGREL ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  REL_NOMPRO = :NOMPRO AND ';
  strSQL := strSQL + '  REL_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '  REL_NOMFIL = :NOMFIL ';

  If Not TCfgRel.fEmptyStr(strCodOpe) Then
    strSQL := strSQL + '  AND REL_CODOPE = :CODOPE '
  Else
    strSQL := strSQL + '  AND REL_CODOPE IS NULL ';

  If Not TCfgRel.fEmptyStr(strNomMaq) Then
    strSQL := strSQL + '  AND REL_NOMMAQ = :NOMMAQ '
  Else
    strSQL := strSQL + '  AND REL_CODOPE IS NULL ';

  If Not TCfgRel.fEmptyStr(strAutInc) Then
    strSQL := strSQL + '  AND AUTOINCREM <> :AUTINC ';

  If VS_SpoolImpressaoCitel Then
    strSQL := strSQL + ' AND REL_SPOIMP = "S" '
  Else
    strSQL := strSQL + ' AND REL_SPOIMP <> "S" ';

  With qryCfg Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('NOMPRO').AsString := strNomeForm;
    ParamByName('CODEMP').AsString := strCodEmp;
    ParamByName('NOMFIL').AsString := strNomeFila;

    If Not TCfgRel.fEmptyStr(strCodOpe) Then
      ParamByName('CODOPE').AsString := strCodOpe;

    If Not TCfgRel.fEmptyStr(strNomMaq) Then
      ParamByName('NOMMAQ').AsString := strNomMaq;

    If Not TCfgRel.fEmptyStr(strAutInc) Then
      ParamByName('AUTINC').AsString := strAutInc;

    Open;

    Result := Not IsEmpty;
  End;

  FreeAndNil(qryCfg);
end;

{ ***************************************** }
{ * PERGUNTA TIPO E LOCAL DE IMPRESSÃO    * }
{ **************************************MV* }
class function TCfgRel.fPreImpressao(qryCfgRel: TUniQuery;
  Var strNomeFila: String; Var strTipImp: String; blnLocal: Boolean;
  strDirImp: String = ''; blnBoleto: Boolean = False; strUltimaFilaUtilizada: String = ''): Boolean;
Var
  blnMostraFila: Boolean;
  intContador: Integer;
  strNomFilTmp: String;

  { ***************************************** }
  { * VARIAVEIS DE IMPRESSORA DEFAULT       * }
  { **************************************AF* }
  Device: Array [0 .. 255] Of char;
  Driver: Array [0 .. 255] Of char;
  Port: Array [0 .. 255] Of char;
  Handle: THandle;
begin
  blnMostraFila := True;
  VS_blnDlgPri := True;

  Result := True;

  pFillPrinters;

  Try
    If Not TCfgRel.VS_SpoolImpressaoCitel Then
      Printer.GetPrinter(Device, Driver, Port, Handle);
  Except
    On E: Exception Do
    Begin
      { ******************************************* }
      { * TRATAMENTO QUANDO SPOOLER ESTIVER PARADO* }
      { * System Error.  Code: 1722.              * }
      { * O servidor RPC não está disponível.     * }
      { ****************************************NC* }
      If Printer.Printers.Count = 0 Then
      Begin
        WinExec(PAnsiChar('cmd /c net start spooler'), SW_HIDE);
        Sleep(5000);

        pFillPrinters;

        If Printer.Printers.Count <= 0 Then
        Begin
          If E.Message =
            'System Error.  Code: 1722.'#$D#$A'O servidor RPC não está disponível'
          Then
          Begin
            TCfgRel.fMensagem('',
              'Spooler de Impressão do Windows não está iniciado ou está com erro. É necessário reiniciá-lo em Serviços do Windows.',
              ['&OK']);
            Result := False;
            Exit;
          End;
        End;
      End;

      Try
        Printer.PrinterIndex := -1;
      Except
        On E: Exception Do
        Begin
          If E.Message =
            'System Error.  Code: 1722.'#$D#$A'O servidor RPC não está disponível'
          Then
          Begin
            TCfgRel.fMensagem('',
              'Spooler de Impressão do Windows não está iniciado ou está com erro. É necessário reiniciá-lo em Serviços do Windows.',
              ['&OK']);
            Result := False;
            Exit;
          End;
        End;
      End;
      Printer.GetPrinter(Device, Driver, Port, Handle);
    End;
  End;

  strNomFilTmp := TCfgRel.fIdentificarNomeDaImpressora
    (fObtemVariavelAmbiente(strNomFormTmp));

  If TCfgRel.fEmptyStr(strDirImp) Or (Pos(strDirImp, 'I_') > 0) Then
    Result := fSelecionaFilaImp(qryCfgRel);

  If (Not TCfgRel.fEmptyStr(qryCfgRel.FieldByName('REL_NOMFIL').AsString)) Or
    (Not TCfgRel.fEmptyStr(strNomFilTmp)) Then
  Begin
    blnMostraFila := False;
  End;

  If ((blnMostraFila) Or (blnLocal)) And (Result) Then
  Begin

    If (qryCfgRel.FieldByName('REL_IMPPAD').AsString = 'S') And Not TCfgRel.VS_SpoolImpressaoCitel Then
    Begin
      // Carrega a Impressora Padrao do Windows
      strNomeFila := fGetImpPadraoWindows();

      If TCfgRel.fEmptyStr(strNomeFila) Then
      Begin
        TCfgRel.fMensagem('',
          'Relatório está configurado para utilizar impressora padrão do Windows e '
          + 'não existe uma impressora padrão definida. É necessário definir uma impressora padrão '
          + 'em Disposistivos e Impressoras.', ['&OK']);
        Result := False;
        Exit;
      End;
      pSetPrinter(strNomeFila);
      VS_blnDlgPri := False;
    End;

    If (Pos(strDirImp, 'V_E_G_') > 0) Then
    Begin
      VS_blnDlgPri := False;
    End
    Else If (qryCfgRel.FieldByName('REL_IMPPAD').AsString = 'N') Or
      (qryCfgRel.FieldByName('REL_IMPPAD').AsString = '') Then
    Begin
      strNomeFila := fSelecionaFila(strNomFormTmp, '', Self.VS_TSPlus Or TCfgRel.VS_SpoolImpressaoCitel, False, '', '', strUltimaFilaUtilizada);
      If TCfgRel.fEmptyStr(strNomeFila) Then
      Begin
        Result := False;
        Exit;
      End
      Else
      Begin
        If Not TCfgRel.VS_SpoolImpressaoCitel Then
          pSetPrinter(strNomeFila);
        VS_blnDlgPri := False;
      End;
    End;

  End
  Else
  Begin
    TCfgRel.pRetFilasImpressao(arrFilas);
    strNomeFila := TCfgRel.fIdentificarNomeDaImpressora
      (qryCfgRel.FieldByName('REL_NOMFIL').AsString);

    If Not TCfgRel.fEmptyStr(strNomFilTmp) Then
      strNomeFila := strNomFilTmp;

    If Not TCfgRel.fCfgSis('CADIMP', VarBoolean) And Not TCfgRel.VS_SpoolImpressaoCitel Then
      If (Copy(strNomeFila, 1, 2) <> '\\') Then
        strNomeFila := '\\' + TCfgRel.fRetNomeRede() + '\' + strNomeFila;

    For intContador := 0 To Length(arrFilas) - 1 Do
    Begin
      If AnsiLowerCase(LeftStr(arrFilas[intContador].strNomeFila,
        Length(strNomeFila))) = AnsiLowerCase(strNomeFila) Then
      Begin
        pSetPrinter(AnsiReplaceStr(LeftStr(arrFilas[intContador].strNomeFila,
          Length(strNomeFila)), '\\' + TCfgRel.fRetNomeRede() + '\', ''));
        VS_blnDlgPri := False;
      End;
    End;

  End;

  strNomeFila := AnsiReplaceStr(strNomeFila, '\\' + TCfgRel.fRetNomeRede()
    + '\', '');

  If Not fPerguntaTipo(qryCfgRel) Then
  Begin

    If qryCfgRel.FieldByName('REL_IDEIMP').AsString = 'P' Then
    Begin
      strTipImp := TCfgRel.fCfgSis('TIPIMP');
    End
    Else
    Begin
      strTipImp := qryCfgRel.FieldByName('REL_IDEIMP').AsString;
    End;

  End
  Else
  Begin
    strTipImp := '';
  End;

  If (Result) And (strTipImp = '') And TCfgRel.VS_SpoolImpressaoCitel Then
    strTipImp := TSpoolImpressaoCitel.fGetPontoImpressao(strNomeFila).TipoImpressora;

  If (Result) And (strTipImp = '') Then
  Begin

    { ************************************************* }
    { * SE FOR VIDEO, GRÁFICO OU EXCEL NÃO PERGUNTA   * }
    { * TIPO DE IMPRESSÃO: MATRICIAL OU JATO DE TINTA * }
    { *******************************************MV/RV* }
    If (Pos(strDirImp, 'V_E_G_') <= 0) And (Not blnBoleto) Then
    Begin
      If (Not TCfgRel.fRetTipoImpressora(strTipImp)) Then
      Begin
        Result := False
      End
    End
    Else
      strTipImp := 'J';

  End;

end;

class function TCfgRel.fMostraFilas(Var strNomeFila: String;
  strNomFormul: String = ''; qryCfgRel: TUniQuery = nil;
  blnBotoes: Boolean = True): Boolean;
Var
  frmFilas: TfrmMenuFilas;
begin
  Try
    TCfgRel.pCriarFormularios(TfrmMenuFilas, frmFilas);
    frmFilas.strNomForm := strNomFormul;
    frmFilas.qryCfgRel := qryCfgRel;
    frmFilas.blnBotoes := blnBotoes;

    frmFilas.ShowModal;

    Result := frmFilas.blnConfirma;
    strNomeFila := frmFilas.strNomeFila;

  Except
    On E: Exception Do
    Begin
      Result := False;
      TCfgRel.pMensagensErro(E.Message, '[fMostraFilas]');
    End;
  End;

  TCfgRel.pFreeAndNil(frmFilas);
end;

class function TCfgRel.fNow: TDateTime;
Var
  LQry: TUniQuery;
begin
  LQry := TCfgRel.fCriaQuery(nil);
  Try
    LQry.SQL.Text := 'SELECT CAST(CONCAT(CURRENT_DATE, " ", CURRENT_TIME) AS DATETIME)';
    LQry.Open;
    Result := LQry.Fields[0].AsDateTime;
  Finally
    FreeAndNil(LQry);
  End;
end;

class function TCfgRel.fGetMD5(AValue: String): String;
Var
  LQry: TUniQuery;
begin
  LQry := TCfgRel.fCriaQuery(nil);
  Try
    LQry.SQL.Text := 'SELECT MD5("'+AValue+'")';
    LQry.Open;
    Result := LQry.Fields[0].AsString;
  Finally
    FreeAndNil(LQry);
  End;
end;

{*****************************************}
{* FAZ ALINHAMENTO (PAD) À ESQUERDA      *}
{**************************************WI*}
class function TCfgRel.fPadL(strTexto: String; intTamanho: Integer; strCaracter: String = ' '): String;
  Var
    intContador: Integer;
begin
  {Result := strTexto;
  intTamanho := intTamanho - Length(strTexto);
  For intContador := 1 To intTamanho Do
    Result := strCaracter + Result;}

  Result := strTexto;

  If Length(strTexto) < intTamanho Then
  Begin
    intTamanho := intTamanho - Length(strTexto);
  End
  Else
  Begin
    Result := Copy(strTexto, (Length(strTexto) + 1) - intTamanho, intTamanho);
    Exit;
  End;

  For intContador := 1 To intTamanho Do
    Result := strCaracter + Result;
end;


{*****************************************}
{* FAZ ALINHAMENTO (PAD) CENTRAL         *}
{**************************************MV*}
class function TCfgRel.fPadC(strTexto: String; intTamanho: Integer; strCaracter: String = ' '): String;
  Var
    intDir, intEsq: Integer;
    intContador: Integer;
begin
  If Length(strTexto) < intTamanho Then
  begin
    intTamanho := intTamanho - Length(strTexto);
    intDir := (intTamanho Div 2);
    intEsq := (intTamanho Div 2) + intTamanho Mod 2;

    Result := strTexto;
    For intContador := 1 To intDir Do
      Result := Result + strCaracter;
    For intContador := 1 To intEsq Do
      Result := strCaracter + Result;

  end
  else
    Result := Copy(strTexto,1,intTamanho);

end;

class function TCfgRel.fPadR(strTexto: String; intTamanhoMin: Integer; intTamanhoMax: Integer; strCaracter: String = ' '): String;
begin
  If Length(strTexto) < intTamanhoMin Then
    Result := fPadR(strTexto, intTamanhoMin, strCaracter)
  Else Result := Copy(strTexto, 1, intTamanhoMax)
end;

{*****************************************}
{* FAZ ALINHAENTO (PAD) À DIREITA       *}
{**************************************WI*}
class function TCfgRel.fPadR(strTexto: String; intTamanho: Integer; strCaracter: String = ' '): String;
  Var
    intContador: Integer;
begin
{  Result := strTexto;
  intTamanho := intTamanho - Length(strTexto);
  For intContador := 1 To intTamanho Do
    Result := Result + strCaracter;}

  Result := strTexto;
  If Length(strTexto) < intTamanho Then
  Begin
    intTamanho := intTamanho - Length(strTexto);
  End
  Else
  Begin
    Result := Copy(strTexto,1,intTamanho);
    Exit;
  End;

  For intContador := 1 To intTamanho Do
    Result := Result + strCaracter;
end;

class function TCfgRel.fRetAutoIncrem(strNomeTabela, strCodEmp: String): String;
  Var
    intAutIncAtu: Integer;

    strSQL,
    strProEmp: String;
    qryGenCod: TUniQuery;
    conAutoincrem: TUniConnection;

    procedure pCriarConexaoAutoincrem;
    var
      LQuery: TUniQuery;
    begin
      LQuery := fCriaQuery;
      try
        conAutoincrem := TUniConnection.Create(nil);
        conAutoincrem.ProviderName := LQuery.Connection.ProviderName;
        conAutoincrem.Username := LQuery.Connection.Username;
        conAutoincrem.Password := LQuery.Connection.Password;
        conAutoincrem.Server := LQuery.Connection.Server;
        conAutoincrem.Database := LQuery.Connection.Database;
        conAutoincrem.Port := LQuery.Connection.Port;
        conAutoincrem.DefaultTransaction.IsolationLevel := DEFAULT_ISOLATION_LEVEL_UNIDAC;
        conAutoincrem.PoolingOptions.MaxPoolSize := TDefaultPoolingOptions.MaxPoolSize;
        conAutoincrem.PoolingOptions.MinPoolSize := TDefaultPoolingOptions.MinPoolSize;
        conAutoincrem.PoolingOptions.Validate := TDefaultPoolingOptions.Validate;
        conAutoincrem.PoolingOptions.ConnectionLifetime := TDefaultPoolingOptions.ConnectionLifetime;
        conAutoincrem.Pooling := TDefaultPoolingOptions.Pooling;
        Try
          conAutoincrem.Connect;
        Except
          On E: Exception Do
          Begin
            Sleep(1000);
            conAutoincrem.Connect;
          End;
        End;
      finally
        FreeAndNil(LQuery);
      end;
    end;

    function fRetEmpresaFisica: String;
    begin
      Result := fCampoTabela('PRO_CODEMP', 'PROCOD', ['PRO_NOMARQ'], ['MOVGER'], False, '', conAutoincrem);
    end;

    function fFormataAutInc(intAutInc: Integer; strCodEmp: String; strProEmp: String = ''): String;
    begin
      If fEmptyStr(strProEmp) Then
        strProEmp := fRetEmpresaFisica;

      Result := strProEmp + fPadL(IntToStr(intAutInc) + strCodEmp, 17, '0');
    end;

    function fAutoIncremCadastrado: Boolean;
      Var
        qryGenTmp : TUniQuery;

    begin
      Try

        qryGenTmp := fCriaQuery(nil, conAutoincrem);

        With qryGenTmp Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT SQL_NO_CACHE AUTOINCREM FROM ' + strNomeTabela + ' WHERE AUTOINCREM = :AUTINC LIMIT 1');
          ParamByName('AUTINC').AsString := fFormataAutInc(intAutIncAtu, strCodEmp, strProEmp);
          Open;
          Result := (Not IsEmpty);
          Close;
        End;

        Finally
          FreeAndNil(qryGenTmp);
        End;

    end;

begin
  try
    pCriarConexaoAutoincrem;
    qryGenCod := fCriaQuery(Nil, conAutoincrem);

    Repeat
      conAutoincrem.StartTransaction;
      Try
        strSQL := '';
        strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
        strSQL := strSQL + '  PRO_AUTINC AS AUTINC ';
        strSQL := strSQL + 'FROM ';
        strSQL := strSQL + '  PROINC ';
        strSQL := strSQL + 'WHERE ';
        strSQL := strSQL + '  PRO_NOMARQ = :NOMARQ ';
        strSQL := strSQL + ' FOR UPDATE ';

        With qryGenCod Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(strSQL);
          ParamByName('NOMARQ').AsString := strNomeTabela;
          Open;

          If IsEmpty Then
          Begin
            Close;
            FreeAndNil(qryGenCod);
            Raise Exception.Create('A tabela ' + strNomeTabela + ' não está cadastrada ' +
                                   'na tabela de Próximos Codigos! Verifique.' + #13#10);
          End;

          strProEmp := fRetEmpresaFisica;

          If FieldByName('AUTINC').Value = Null Then
            intAutIncAtu := 1
          Else
            intAutIncAtu := FieldByName('AUTINC').AsInteger;

          Close;
        End;

        strSQL := '';
        strSQL := strSQL + 'UPDATE ';
        strSQL := strSQL + '  PROINC ';
        strSQL := strSQL + 'SET ';

        If intAutIncAtu = 1 Then
          strSQL := strSQL + '  PRO_AUTINC = 2 '
        Else
          strSQL := strSQL + '  PRO_AUTINC = PRO_AUTINC + 1 ';

        strSQL := strSQL + 'WHERE ';
        strSQL := strSQL + '  PRO_NOMARQ = :NOMARQ ';

        With qryGenCod Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(strSQL);
          ParamByName('NOMARQ').AsString := strNomeTabela;
          ExecSQL;
          Close;
        End;

        Result :=  strProEmp + fPadL(IntToStr(intAutIncAtu) + strCodEmp, 17, '0');

        conAutoincrem.Commit;

      Except
        On E: Exception Do
        Begin
          conAutoincrem.Rollback;
          FreeAndNil(qryGenCod);
          Raise Exception.Create(E.message + 'Não consegui pegar o proximo sequencial. Tente novamente!');
        End;
      End;

    Until (Not fAutoIncremCadastrado);

    FreeAndNil(qryGenCod);
  finally
    if Assigned(conAutoincrem) then
    begin
      conAutoincrem.Disconnect;
      FreeAndNil(conAutoincrem);
    end;
  end;
end;


class function TCfgRel.fRetEmpresaFisica: String;
begin
  Result := fCampoTabela('PRO_CODEMP', 'PROCOD', ['PRO_NOMARQ'], ['MOVGER'], False);
end;

class function TCfgRel.fRetTipoImpressora(var strTipImp: String): Boolean;
  Var
    frmMenuTipImp : TfrmMenuTipImp;
begin
  Try
    TCfgRel.pCriarFormularios(TfrmMenuTipImp, frmMenuTipImp);

    frmMenuTipImp.ShowModal;

    Result := frmMenuTipImp.blnConfirma;
    strTipImp := frmMenuTipImp.strTipImp;

  Except
    On E: Exception Do
    Begin
      Result := False;
      TCfgRel.pMensagensErro(E.Message, '[fRetTipoImpressora]');
    End;
  End;

  TCfgRel.pFreeAndNil(frmMenuTipImp);
end;

class procedure TCfgRel.pCarregaConfImprRel(Const strNomeForm: String;
  Var strNomImp: String; Var strTipImp: String; strCodEmp: String = '';
  blnPreImp: Boolean = False);
Var
  qryCfgRel: TUniQuery;
Begin
  qryCfgRel := TCfgRel.fCriaQuery(Nil);
  pCarregaConfImpr(qryCfgRel, strNomeForm, strCodEmp);
  strNomImp := TCfgRel.fIdentificarNomeDaImpressora
    (qryCfgRel.FieldByName('REL_NOMFIL').AsString);
  strTipImp := qryCfgRel.FieldByName('REL_IDEIMP').AsString;

  If blnPreImp Then
    fPreImpressao(qryCfgRel, strNomImp, strTipImp, False);

  FreeAndNil(qryCfgRel);
End;

class function TCfgRel.fSelecionaFila(strFrm: String; strInc: String = '';
  blnImpressorasCadastradas: Boolean = False; blnOpcaoNaoImprimir: Boolean = False;
  strDesFrm: String = ''; strFiltroNomeImpressora: String = ''; strUltimaFilaUtilizada: String = ''): String;
Var
  frm: TfrmSelFilImpressao;
begin
  Try
    TCfgRel.pCriarFormularios(TfrmSelFilImpressao, frm);
    frm.strFrm := strFrm;
    frm.strDesFrm := strDesFrm;
    frm.strAutInc := strInc;
    frm.blnOpcaoNaoImprimir := blnOpcaoNaoImprimir;
    frm.blnImpressorasCadastradas := blnImpressorasCadastradas;
    frm.strFiltroNomeImpressora := strFiltroNomeImpressora;
    frm.strUltimaFilaUtilizada := strUltimaFilaUtilizada;

    frm.ShowModal;

    Result := frm.strImpSelecionada;

    if not frm.strImpSelecionada.IsEmpty And frm.chkNaoPerguntar.Visible and frm.chkNaoPerguntar.Checked then
      pInsereFilaImpressaoUsuario(strFrm, frm.strImpSelecionada, frm.strTipoImpSelecionada, fGetUsuarioLogado);
  Except
    On E: Exception Do
    Begin
      Result := '';
      TCfgRel.pMensagensErro(E.Message, '[fSelecionaFila]');
    End;
  End;

  TCfgRel.pFreeAndNil(frm);
end;

class function TCfgRel.fSelecionaFila(strNomFrm, strAutInc, strCodOpe, strNomMaq: String;
  Var strNomImp, strTipImp: String; blnImpressorasCadastradas: Boolean = False;
  blnOpcaoNaoImprimir: Boolean = False): Boolean;
Var
  frm: TfrmSelFilImpressao;
begin
  Try
    TCfgRel.pCriarFormularios(TfrmSelFilImpressao, frm);
    frm.strFrm := strNomFrm;
    frm.strAutInc := strAutInc;
    frm.strCodOpe := strCodOpe;
    frm.strNomMaq := strNomMaq;
    frm.blnOpcaoNaoImprimir := blnOpcaoNaoImprimir;
    frm.blnImpressorasCadastradas := blnImpressorasCadastradas;

    frm.ShowModal;

    Result := Not frm.strImpSelecionada.IsEmpty;

    strNomImp := frm.strImpSelecionada;
    strTipImp := frm.strTipoImpSelecionada;

    if not frm.strImpSelecionada.IsEmpty And frm.chkNaoPerguntar.Visible and frm.chkNaoPerguntar.Checked then
      pInsereFilaImpressaoUsuario(strNomFrm, frm.strImpSelecionada, frm.strTipoImpSelecionada, fGetUsuarioLogado);
  Except
    On E: Exception Do
    Begin
      Result := False;
      TCfgRel.pMensagensErro(E.Message, '[fSelecionaFila]');
    End;
  End;
  TCfgRel.pFreeAndNil(frm);
end;

class procedure TCfgRel.pConfigurarFilaDeImpressao(qryCfgRel: TUniQuery;
  strNomeForm: String);
begin
  Try
    TCfgRel.pCriarFormularios(TfrmCadConfRelatorios, frmCadConfRelatorios);
    frmCadConfRelatorios.strNomeForm := strNomeForm;
    frmCadConfRelatorios.ShowModal;
  Except
    On E: Exception Do
    Begin
      TCfgRel.pMensagensErro(E.Message, '[frmPai.mnuConfigurarRelClick]');
    End;
  End;
  TCfgRel.pFreeAndNil(frmCadConfRelatorios);

  If Assigned(qryCfgRel) Then
    pCarregaConfImpr(qryCfgRel, strNomeForm);
end;

class procedure TCfgRel.pFillPrinters;
Var
  I: Integer;
  LNomeImpressora: String;
  LCadastroImpressoras: TArray<String>;
  LImpressoraIdentificada: String;
  LImpressorasIdentificadas: TArray<String>;
  LField: TRttiField;
  LPrinterList: TList;
begin
  Printer.Refresh;

  frxPrinter.frxPrinters.FillPrinters;

  If TCfgRel.VS_SpoolImpressaoCitel Then
    Exit;

  If Not TCfgRel.fCfgSis('CADIMP', VarBoolean) Then
    Exit;

  If Not TCfgRel.VS_TSPlus Then
    Exit;

  LCadastroImpressoras :=
    String(TCfgRel.fCampoTabela('GROUP_CONCAT(IMP_NOMIMP SEPARATOR "->")',
    'CADIMP', [], [], False)).Split(['->']);

  SetLength(LImpressorasIdentificadas, 0);

  For LNomeImpressora In LCadastroImpressoras Do
  Begin
    LImpressoraIdentificada := fIdentificarNomeDaImpressora(LNomeImpressora);
    SetLength(LImpressorasIdentificadas, Length(LImpressorasIdentificadas)+1);
    LImpressorasIdentificadas[Length(LImpressorasIdentificadas)-1] := LImpressoraIdentificada;
  End;

  I := 0;
  While I <= frxPrinter.frxPrinters.Printers.Count -1 Do
  Begin
    If Not MatchStr(frxPrinter.frxPrinters.Printers[I], LImpressorasIdentificadas) Then
    Begin
      LField := TRttiContext.create.GetType(TfrxPrinters).GetField('FPrinterList');
      LPrinterList := TList(LField.GetValue(frxPrinters).AsObject);
      LPrinterList.Delete(I);
      frxPrinter.frxPrinters.Printers.Delete(I);
      Continue;
    End;
    Inc(I);
  End;

  frxPrinter.frxPrinters.PrinterIndex := frxPrinter.frxPrinters.Printers.Count -1;

end;

class procedure TCfgRel.pInsereFilaImpressaoUsuario(const strNomFrm, strNomImp,
  strTipImp, strCodOpe: String);
var
  LQuery: TUniQuery;
begin
  if fFilaJaExiste('', strCodOpe, '', strNomFrm, fGetEmpresaLogada, strNomImp) then
    Exit;

  LQuery := fCriarQuery('SELECT * FROM CFGREL WHERE FALSE');
  try
    LQuery.Open;
    LQuery.Append;
    LQuery.FieldByName('REL_NOMPRO').AsString := strNomFrm;
    LQuery.FieldByName('REL_DESPRO').AsString := Format('%s (%s)', [strNomFrm, strCodOpe]);
    LQuery.FieldByName('REL_NOMFIL').AsString := strNomImp;
    LQuery.FieldByName('REL_IDEIMP').AsString := strTipImp;
    LQuery.FieldByName('REL_PERGUN').AsString := 'N';
    LQuery.FieldByName('REL_CODEMP').AsString := fGetEmpresaLogada;
    LQuery.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CFGREL', fGetEmpresaLogada);
    LQuery.FieldByName('REL_IMPPAD').AsString := 'N';
    LQuery.FieldByName('REL_CODOPE').AsString := strCodOpe;
    LQuery.FieldByName('REL_NOMPON').AsString := TSpoolImpressaoCitel.fGetPontoImpressao(strNomImp).Nome;
    LQuery.FieldByName('REL_NOMIMP').AsString := TSpoolImpressaoCitel.fGetPontoImpressao(strNomImp).Impressora;
    LQuery.FieldByName('REL_SPOIMP').AsString := IfThen(VS_SpoolImpressaoCitel, 'S', 'N');
    LQuery.Post;
  finally
    FreeAndNil(LQuery);
  end;
end;

class procedure TCfgRel.pPreviewReport(strNomPro, strDesPro: String;
  AReport: IReport);
begin
  TPreviewReport.PreviewReport(strNomPro, strDesPro, AReport);
end;

class procedure TCfgRel.pPreviewReport(strNomPro, strDesPro: String;
  AReport: TfrxReport);
begin
  TFastPreviewReport.PreviewReport(strNomPro, strDesPro, AReport);
end;

class procedure TCfgRel.pPreviewReport(strNomPro, strDesPro: String;
  AReport: TRLReport; ASetup: TRLPreviewSetup);
begin
  TFortesPreviewReport.PreviewReport(strNomPro, strDesPro, AReport, ASetup);
end;

class procedure TCfgRel.pDesignReport(strNomPro, strDesPro: String;
  AReport: TfrxReport);
begin
  TFastPreviewReport.DesignReport(strNomPro, strDesPro, AReport);
end;

class procedure TCfgRel.pPrintPDF(strNomPro, strDesPro, strNomImp, strArqPDF: String);
var
  strNomeAdobe: String;
  timAdobe: TTime;
  HandleAdobe: HWND;
begin
  If TCfgRel.VS_SpoolImpressaoCitel Then
  Begin
    TSpoolImpressaoCitel.fEnviarPDFParaImpressao(strNomPro, strDesPro, strNomImp, strArqPDF);
    Exit;
  End;
  pExecArquivoPrintTo(strArqPDF, strNomImp, 0);
  strNomeAdobe := fCfgSis('ADOACR'); // 'Adobe Acrobat Reader DC'
  timAdobe := Time;
  Repeat
    HandleAdobe := FindWindow(nil, pChar(strNomeAdobe));
  until (HandleAdobe <> 0) Or ((SecondOf(Time - timAdobe) > 10));
  timAdobe := Time;
  Repeat
    if HandleAdobe <> 0 then
    Begin
      SendMessage(HandleAdobe, WM_CLOSE, 0, 0);
      Sleep(1000);
    End;
    HandleAdobe := FindWindow(nil, pChar(strNomeAdobe));
  until (HandleAdobe = 0) Or ((SecondOf(Time - timAdobe) > 10));
end;

class procedure TCfgRel.pPrintReport(strNomPro, strDesPro, strNomImp: String; AReport: TRLReport);
begin
  If TCfgRel.VS_SpoolImpressaoCitel Then
  Begin
    If strNomImp.IsEmpty And Not TCfgRel.fInTransaction() Then
      strNomImp := TCfgRel.fSelecionaFila(strNomPro,'',True);

    If strNomImp.IsEmpty Then
      Exit;

    TSpoolImpressaoCitel.fEnviarParaImpressao(strNomPro, strDesPro, strNomImp, AReport);
  End
  Else
    AReport.Print;
end;

class procedure TCfgRel.pPrintReport(strNomPro, strDesPro, strNomImp: String;
  AReport: IReport);
begin
  If Not TCfgRel.VS_SpoolImpressaoCitel Then
  Begin
    AReport.Print;
    Exit;
  End;

  If strNomImp.IsEmpty Then
    If Not AReport.Printer.Equals('Default') Then
      If Not AReport.Printer.Equals('Padrão') Then
        strNomImp := AReport.Printer;

  If strNomImp.IsEmpty And Not TCfgRel.fInTransaction() Then
    strNomImp := TCfgRel.fSelecionaFila(strNomPro,'',True,False,strDesPro);

  If strNomImp.IsEmpty Then
    Exit;

  If AReport.PagesCount = 0 Then
    AReport.PrepareReport;

  TSpoolImpressaoCitel.fEnviarParaImpressao(strNomPro, strDesPro, strNomImp, AReport);
end;

class procedure TCfgRel.pAbrirGaveta(strImpressora, strModelo: String);

  procedure pWriteRawStringToPrinter(PrinterName:String; S:String);
  var
    Handle: THandle;
    N: DWORD;
    DocInfo1: TDocInfo1;
  begin
    if not OpenPrinter(PChar(PrinterName), Handle, nil) then
    begin
      pMensagensErro(IntToStr(GetLastError), '[pWriteRawStringToPrinter]');
      Exit;
    end;

    with DocInfo1 do
    begin
      pDocName := PChar('gaveta');
      pOutputFile := nil;
      pDataType := 'RAW';
    end;

    StartDocPrinter(Handle, 1, @DocInfo1);
    StartPagePrinter(Handle);
    WritePrinter(Handle, PChar(S), Length(S), N);
    EndPagePrinter(Handle);
    EndDocPrinter(Handle);
    ClosePrinter(Handle);
  end;

  procedure pWriteRawStringToPrinterAnsi(PrinterName:String; S:AnsiString);
  var
    Handle: THandle;
    N: DWORD;
    DocInfo1: TDocInfo1;
  begin
    if not OpenPrinter(PChar(PrinterName), Handle, nil) then
    begin
      pMensagensErro(IntToStr(GetLastError), '[pWriteRawStringToPrinter]');
      Exit;
    end;

    with DocInfo1 do
    begin
      pDocName := PChar('gaveta');
      pOutputFile := nil;
      pDataType := 'RAW';
    end;

    StartDocPrinter(Handle, 1, @DocInfo1);
    StartPagePrinter(Handle);
    WritePrinter(Handle, PAnsiChar(S), Length(S), N);
    EndPagePrinter(Handle);
    EndDocPrinter(Handle);
    ClosePrinter(Handle);
  end;

begin
  if VS_SpoolImpressaoCitel then
    TSpoolImpressaoCitel.fEnviarTextoParaImpressao('pAbrirGaveta', 'ABRIR GAVETA', strImpressora, TSpoolImpressaoCitel.AbrirGavetaDinheiro + '|' + strModelo)
  Else If UpperCase(strModelo) = 'ELGIN' then
    pWriteRawStringToPrinterAnsi(strImpressora, AnsiString(#27 + #112 + #0 + #100 + #200))
  Else If (UpperCase(strModelo) = 'EPSON') Or (UpperCase(strModelo) = 'DARUMA') then
    pWriteRawStringToPrinterAnsi(strImpressora, AnsiString(chr($1b) + chr($70) + chr($30) + chr($a) + chr($64)))
  Else If strModelo = 'DIEBOLD' then
    pWriteRawStringToPrinter(strImpressora, AnsiString(#27 + '&0' + #12 + #48))
  else if (strModelo = 'DIEBOLD ANSI') then
    pWriteRawStringToPrinterAnsi(strImpressora, AnsiString(#27 + '&0' + #12 + #48))
  Else If Pos('BEMATECH', UpperCase(strModelo)) > 0 then
    pWriteRawStringToPrinterAnsi(strImpressora, AnsiString(#29 + #249 + #32 + #0 + #27 + #116 + #8 + #27 + #118 + #140));
end;

class procedure TCfgRel.pPrintToFile(strNomFrm, strNomImp, strNomArq: String);
begin
  if TCfgRel.VS_SpoolImpressaoCitel then
    if ExtractFileExt(strNomArq).ToLower.Equals('.pdf') then
      TSpoolImpressaoCitel.fEnviarPDFParaImpressao(strNomFrm, ExtractFileName(strNomArq),
        strNomImp, strNomArq)
    else
      TSpoolImpressaoCitel.fEnviarTextoParaImpressao(strNomFrm, ExtractFileName(strNomArq),
        strNomImp, TFile.ReadAllText(strNomArq, TEncoding.ANSI));
end;

class procedure TCfgRel.pPrintTXT(strNomPro, strDesPro: String; strNomArq: String);
begin
  fPrintTXT(strNomPro, strDesPro, strNomArq);
end;

class function TCfgRel.fPrintTXT(strNomPro, strDesPro: String; strNomArq: String): Boolean;
var
  LCfgRel: TUniQuery;
  LFile: TextFile;
  LIndice: integer;
  LSLText: TStringList;
  LNomImp: string;
  LTipImp: String;
  LIdxImp: Integer;
begin
  Result := False;
  LCfgRel := fCriaQuery(nil);
  Try
    pCarregaConfImpr(LCfgRel, strNomPro);

    if LCfgRel.IsEmpty then
      Exit;

    if not fPreImpressao(LCfgRel, LNomImp, LTipImp, False, 'I') then
      Exit;

    if fEmptyStr(LNomImp) then
      Exit;

    If TCfgRel.VS_SpoolImpressaoCitel Then
    Begin
      // A fila "NAO IMPRIMIR" e aceita pelo spooler sem imprimir nada: para quem pergunta
      // se imprimiu, e False.
      Result := TSpoolImpressaoCitel.fEnviarTextoParaImpressao(strNomPro, strDesPro,
        LNomImp, TFile.ReadAllText(strNomArq, TEncoding.ANSI))
        And (Not LNomImp.Equals(TSpoolImpressaoCitel.PontoNaoImprimir));
      Exit;
    End;

    // Testar antes de atribuir: PrinterIndex := -1 seleciona a impressora padrao, e o teste
    // feito depois da atribuicao nunca barrava - o texto saia na padrao em vez de nao sair.
    LIdxImp := Printer.Printers.IndexOf(LNomImp);
    if LIdxImp < 0 then
    begin
      TCfgRel.fMensagem('ATENÇÃO!', 'Impressora não encontrada ou não disponível. Impressora: "' + LNomImp + '". ' +
        '"' + strDesPro + '" não foi impressa.', ['&OK']);
      Exit;
    end;
    Printer.PrinterIndex := LIdxImp;

    LSLText := TStringList.Create;
    try
      LSLText.LoadFromFile(strNomArq);
      AssignPrn(LFile);
      Rewrite(LFile);
      try
        for LIndice := 0 to LSLText.Count - 1 do
          Writeln(LFile, LSLText[LIndice]);
        Result := True;
      finally
        CloseFile(LFile);
      end;
    finally
      FreeAndNil(LSLText);
    end;

  Finally
    FreeAndNil(LCfgRel);
  End;
end;

class procedure TCfgRel.pPrintReport(strNomPro, strDesPro, strNomImp: String; AWord: TWord);
begin
  If Not TCfgRel.VS_SpoolImpressaoCitel Then
  Begin
    AWord.pSetarImpressora(AnsiReplaceStr(strNomImp, '\\' + fRetNomeRede + '\',''));
    AWord.pPrint;
  End;

  If strNomImp.IsEmpty And Not TCfgRel.fInTransaction() Then
    strNomImp := TCfgRel.fSelecionaFila(strNomPro,'',True,False,strDesPro);

  If strNomImp.IsEmpty Then
    Exit;

  TSpoolImpressaoCitel.fEnviarParaImpressao(strNomPro, strDesPro, strNomImp, AWord);
end;

class function TCfgRel.fImpressoraFastValida(AReport: TfrxReport): Boolean;
Var
  strImpressora: String;
  intIndice: Integer;
begin
  Result := False;

  If Not Assigned(AReport) Then
    Exit;

  If frxPrinter.frxPrinters.Printers.Count = 0 Then
    Exit;

  strImpressora := AReport.PrintOptions.Printer;

  If (Not fEmptyStr(strImpressora)) And
     (Not strImpressora.Equals('Default')) And
     (Not strImpressora.Equals('Padrão')) Then
  Begin
    Result := frxPrinter.frxPrinters.Printers.IndexOf(strImpressora) >= 0;
    Exit;
  End;

  intIndice := frxPrinter.frxPrinters.PrinterIndex;
  Result := (intIndice >= 0) And (intIndice <= frxPrinter.frxPrinters.Printers.Count - 1);
end;

class procedure TCfgRel.pPrintReport(strNomPro, strDesPro, strNomImp: String;
  AReport: TfrxReport; GrayedScale: Boolean = False);
begin
  If Not TCfgRel.VS_SpoolImpressaoCitel Then
  Begin
    If Not TCfgRel.fImpressoraFastValida(AReport) Then
    Begin
      TCfgRel.fMensagem('ATENÇÃO!', 'Nenhuma impressora válida foi encontrada para esta impressão. Verifique se há uma impressora instalada e selecionada no Windows antes de imprimir.', ['&OK']);
      Exit;
    End;

    AReport.Print;
    Exit;
  End;

  If strNomImp.IsEmpty Then
    If Not AReport.PrintOptions.Printer.Equals('Default') Then
      If Not AReport.PrintOptions.Printer.Equals('Padrão') Then
        strNomImp := AReport.PrintOptions.Printer;

  If strNomImp.IsEmpty And Not TCfgRel.fInTransaction() Then
    strNomImp := TCfgRel.fSelecionaFila(strNomPro,'',True,False,strDesPro);

  If strNomImp.IsEmpty Then
    Exit;

  If AReport.PreviewPages.Count = 0 Then
    AReport.PrepareReport;

  TSpoolImpressaoCitel.fEnviarParaImpressao(strNomPro, strDesPro, strNomImp, AReport, GrayedScale);
end;

class function TCfgRel.fGetImpPadraoWindows: String;
Var
  Device: Array [0 .. 255] Of char;
  Driver: Array [0 .. 255] Of char;
  Port: Array [0 .. 255] Of char;
  Handle: THandle;
begin
  Printer.PrinterIndex := -1;
  Printer.GetPrinter(Device, Driver, Port, Handle);
  Result := Device;
end;

class function TCfgRel.fGetImpressoraSelecionada: String;
begin
  Try
    Result := Printer.Printers[Printer.PrinterIndex];
  Except
    If TCfgRel.VS_SpoolImpressaoCitel Then
      Result := EmptyStr
    Else
      Raise;
  End;
end;

{ TPreviewReport }

procedure TPreviewReport.OnPreview(Sender: TObject);
begin
  FOldPrintBClick := FReport.GetPrintBClick;
  FReport.SetPrintBClick(Self.PrintBClick);
end;

class procedure TPreviewReport.PreviewReport(const APrograma,
  ADescricao: String; AReport: IReport);
Var
  LPreview: TPreviewReport;
begin
  LPreview := TPreviewReport.Create;
  Try
    LPreview.FNomPro := APrograma;
    LPreview.FDesPro := ADescricao;
    LPreview.FReport := AReport;
    AReport.SetOnPreview(LPreview.OnPreview);
    AReport.ShowReport;
  Finally
    FreeAndNil(LPreview);
  End;
end;

procedure TPreviewReport.PrintBClick(Sender: TObject);
Var
  LQuery: TUniQuery;
  LNomImp: String;
  LTipImp: String;
begin
  If TCfgRel.VS_SpoolImpressaoCitel Then
  Begin
    LQuery := TCfgRel.fCriaQuery(nil);
    Try
      LNomImp := FReport.Printer;

      If TCfgRel.VerImpressoraONLINE(LNomImp, False) <> 0 Then
      Begin
        TCfgRel.pCarregaConfImpr(LQuery, FNomPro);
        If Not TCfgRel.fPreImpressao(LQuery, LNomImp, LTipImp, False) Then
          Exit;
      End;

      TCfgRel.pPrintReport(FNomPro, FDesPro, LNomImp, FReport);
    Finally
      FreeAndNil(LQuery);
    End;
  End
  Else
    FOldPrintBClick(Sender);
end;

initialization
  TCfgRel.AtivarCfgLayoutRegraCancelamento := False;
  TCfgRel.blnExibirMensagem := True;

end.
