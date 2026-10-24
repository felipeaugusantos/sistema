unit untConfImpressora;

interface

uses
{$IF Defined(LINUX)}
  FMX.frxClass, FMX.frxPreview,
{$ELSE}
  untSpoolPrintDialog, untSelPontoImpressao,
  frxClass, frxPreview, Controls, AppEvnts, Printers,
  Registry, Windows, Messages, ShellAPI,
{$IFEND}
  Uni, Classes, DB;

type
{$IF NOT Defined(LINUX)}
{$IFDEF UNIDAC}
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
  end;
{$ENDIF}  
{$IFEND}
  TFilasImp = Record
    strNomeFila: String;
    blnMostrar : Boolean;
  End;

  TarrFilas = Array Of TFilasImp;

{$IF not Defined(LINUX)}
  function fObtemVariavelAmbiente(const strNome: String): String;
  procedure pPrintPDF(strNomArq, strNomImp: String);
{$IFEND}

  function fPreImpressao(Var strNomeFila : String; blnUsaCadImpressoras: Boolean): Boolean;

  procedure pSetPrinter(strNomImp: String);
  procedure pRetFilasImpressao(Var arrFilas: TarrFilas; blnUsaCadImpressoras: Boolean);
  function fGetImpPadraoWindows: String;

  procedure pPrintReport(strNomPro, strDesPro, strNomImp: String; AReport: TfrxReport);
  procedure pPreviewReport(strNomPro, strDesPro: String; AReport: TfrxReport);
  function fPDFToPrinterQuantidadeDeCopias: String;
  procedure pPrintPDFSpool(strNomPro, strDesPro, strNomImp, strArquivo: String);

{$IFDEF UNIDAC}
  function fUtilizaSpoolImpressaoCitel(ACodEmp: String = ''): Boolean;
  function fSelecionaPontoImpressao(): String;
{$ENDIF}  

implementation

uses
  {$IFDEF UNIDAC} untSpoolImpressao, {$ENDIF}
  SysUtils, StrUtils, untUtil;

{$IF Defined(LINUX)}
{$ELSE}
function KeyIsDown(const Key: Integer): Boolean;
begin
  Result := GetKeyState(Key) and 128 > 0;
end;
{$IFEND}

{$IF Defined(LINUX)}
{$ELSE}
function fObtemVariavelAmbiente(const strNome: String): String;
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
{$IFEND}

procedure pSetPrinter(strNomImp: String);
{$IF Defined(LINUX)}
begin
end;
{$ELSE}
  Var
    buffer1 : Array[0..250] Of Char;
    buffer2 : Array[0..250] Of Char;
    buffer3 : Array[0..250] Of Char;
    ADevice, ADriver, APort : PChar;
    hDm :  THandle;
begin
  ADevice := buffer1;
  ADriver := buffer2;
  APort   := buffer3;
  Printer.GetPrinter(ADevice, ADriver, APort, hDm);
  printer.SetPrinter(PChar(strNomImp), ADriver, APort, 0);
end;
{$IFEND}

function fGetImpPadraoWindows: String;
{$IF Defined(LINUX)}
begin
end;
{$ELSE}
  Var
    Device: Array[0..255] Of Char;
    Driver: Array[0..255] Of Char;
    Port  : Array[0..255] Of Char;
    Handle: THandle;
begin
  Printer.PrinterIndex := -1;
  Printer.GetPrinter(Device, Driver, Port, Handle);

  Result := Device;

  If fEmptyStr(Result) Then
    raise Exception.Create('Nenhuma impressora padrão foi encontrada. É necessário definir uma impressora padrão '+
                 'em Disposistivos e Impressoras.');
end;
{$IFEND}

procedure pPrintReport(strNomPro, strDesPro, strNomImp: String; AReport: TfrxReport);

  function fDesRel(const aDesRel: string): string;
  begin
    Result := Trim(aDesRel);
    Result := AnsiReplaceStr(Result,'\','');
    Result := AnsiReplaceStr(Result,'/','');
    Result := AnsiReplaceStr(Result,':','');
    Result := AnsiReplaceStr(Result,'*','');
    Result := AnsiReplaceStr(Result,'?','');
    Result := AnsiReplaceStr(Result,'"','');
    Result := AnsiReplaceStr(Result,'<','');
    Result := AnsiReplaceStr(Result,'>','');
    Result := AnsiReplaceStr(Result,'|','');
  end;

begin
  pLogImp(Format('%s pPrintReport(%s em %s)', [strNomPro, strDesPro, strNomImp]));

  AReport.ReportOptions.Name := fDesRel(strDesPro);

  If fEmptyStr(strNomImp) Then
    strNomImp := AReport.PrintOptions.Printer;

{$IFDEF LINUX}
  If fUtilizaSpoolImpressaoCitel And TSpoolImpressaoCitel.fGetPontoImpressao(strNomImp).Existe Then
    TSpoolImpressaoCitel.fEnviarParaImpressao(strNomPro, strDesPro, strNomImp, AReport)
{$ELSE}
 {$IFDEF UNIDAC}
  If fUtilizaSpoolImpressaoCitel Then
  Begin
    If TSpoolImpressaoCitel.fGetPontoImpressao(strNomImp).Existe Then
      TSpoolImpressaoCitel.fEnviarParaImpressao(strNomPro, strDesPro, strNomImp, AReport);
  End
  Else
 {$ENDIF}
    AReport.Print;
{$ENDIF}
end;

procedure pPreviewReport(strNomPro, strDesPro: String; AReport: TfrxReport);
{$IF Defined(LINUX)}
begin
end;
{$ELSE}
begin
  pLogImp(Format('%s pPreviewReport(%s)', [strNomPro, strDesPro]));

  {$IFDEF UNIDAC}
  TFastPreviewReport.PreviewReport(strNomPro, strDesPro, AReport);
  {$ELSE}
  AReport.ShowReport();
  {$ENDIF}
end;
{$IFEND}

function fPDFToPrinterQuantidadeDeCopias: String;
var
  strCopias: String;
begin
  strCopias := fCfgSis('QTDNFS', VS_strCodEmp);

  Result := ' copies=' + IIF(fEmptyStr(strCopias), '1', strCopias);
end;

{$IF Defined(LINUX)}
{$ELSE}
procedure pPrintPDF(strNomArq, strNomImp: String);
var
  strArquivo: String;
begin
  If (fCfgSis('PDFENO', VS_strCodEmp) = 'S') Then
  Begin
    strArquivo := fRetNomeArquivoPDFtoPrinter + ' ' + strNomArq + ' "'+strNomImp+'"' + fPDFToPrinterQuantidadeDeCopias;
    pLogImp('NfeImpressao - pPrintPDF - Comando a ser executado no ShellExecuteAndWait: ' + strArquivo);
    ShellExecuteAndWait('', fRetNomeArquivoPDFtoPrinter, PChar(strNomArq+' "'+strNomImp+'"' + fPDFToPrinterQuantidadeDeCopias), '', SW_NORMAL, True);
    pLogImp('NfeImpressao - pPrintPDF - Executou ShellExecuteAndWait');
  End
  Else
  Begin
    pLogImp('NfeImpressao - pPrintPDF - Comando a ser executado no shellExecute: ' + strNomArq);
    shellExecute(0, nil, PChar(strNomArq), nil, '', SW_NORMAL);
    pLogImp('NfeImpressao - pPrintPDF - Executou shellExecute');
  End;
end;
{$IFEND}

procedure pPrintPDFSpool(strNomPro, strDesPro, strNomImp, strArquivo: String);
begin
  pLogImp(Format('%s pPrintPDFSpool(%s em %s)', [strNomPro, strDesPro, strNomImp]));

  {$IFDEF UNIDAC}
  If fUtilizaSpoolImpressaoCitel And TSpoolImpressaoCitel.fGetPontoImpressao(strNomImp).Existe Then
    TSpoolImpressaoCitel.fEnviarParaImpressao(strNomPro, strDesPro, strNomImp, strArquivo);
  {$ENDIF}
end;

function fUtilizaSpoolImpressaoCitel(ACodEmp: String = ''): Boolean;
begin
  Result := False;

  If fEmptyStr(ACodEmp) Then
    ACodEmp := VS_strCodEmp;

  If fArqIniLocal(0, 'GERAL', 'SPOOL_IMPRESSAO_CITEL', 'S', fPathOpcoesIni) <> 'N' Then
    Result := (fCfgSis('SPOIMP', ACodEmp) = 'S');
end;

{*****************************************}
{* PERGUNTA TIPO E LOCAL DE IMPRESSÃO    *}
{**************************************MV*}
function fPreImpressao(Var strNomeFila : String; blnUsaCadImpressoras: Boolean): Boolean;
{$IF Defined(LINUX)}
begin
end;
{$ELSE}
  Var
    intContador  : Integer;
    strNomFilTmp : String;

    {*****************************************}
    {* VARIAVEIS DE IMPRESSORA DEFAULT       *}
    {**************************************AF*}
    Device: Array[0..255] Of Char;
    Driver: Array[0..255] Of Char;
    Port  : Array[0..255] Of Char;
    Handle: THandle;
    arrFilas :TarrFilas;
    LAchouImpressora: Boolean;
    strNomFormTmp: string;
begin
  Result := True;

  {$IFDEF UNIDAC}
  If fUtilizaSpoolImpressaoCitel Then
    Exit;
  {$ENDIF}  

  Printer.Refresh;

  Try
    Printer.GetPrinter(Device, Driver, Port, Handle);
  Except
    On E: Exception Do
    Begin
      {*******************************************}
      {* TRATAMENTO QUANDO SPOOLER ESTIVER PARADO*}
      {* System Error.  Code: 1722.              *}
      {* O servidor RPC não está disponível.     *}
      {****************************************NC*}
      If Printer.Printers.Count = 0 Then
      Begin
        WinExec(PAnsiChar('cmd /c net start spooler'), SW_HIDE);
        Sleep(5000);
        Printer.Refresh;

        If Printer.Printers.Count <= 0 Then
        Begin
          If E.Message = 'System Error.  Code: 1722.'#$D#$A'O servidor RPC não está disponível' Then
            raise Exception.Create('Spooler de Impressão do Windows não está iniciado ou está com erro. É necessário reiniciá-lo em Serviços do Windows.');
        End;
      End;

      Try
        Printer.PrinterIndex := -1;
      Except
        On E: Exception Do
        Begin
          If E.Message = 'System Error.  Code: 1722.'#$D#$A'O servidor RPC não está disponível' Then
            raise Exception.Create('Spooler de Impressão do Windows não está iniciado ou está com erro. É necessário reiniciá-lo em Serviços do Windows.');
        End;
      End;
      Printer.GetPrinter(Device, Driver, Port, Handle);
    End;
  End;

  strNomFilTmp := fObtemVariavelAmbiente(strNomFormTmp);
  If Not fEmptyStr(strNomFilTmp) Then
    strNomeFila := strNomFilTmp;

  if fEmptyStr(strNomeFila) then
  begin
    strNomeFila := fGetImpPadraoWindows;
    pSetPrinter(strNomeFila);
  end
  else
  begin

    If Not blnUsaCadImpressoras Then
    Begin
      If (Copy(strNomeFila, 1, 2) <> '\\') Then
        strNomeFila := '\\' + fRetNomeRede + '\' + strNomeFila;
    End;

    LAchouImpressora := False;
    pRetFilasImpressao(arrFilas, blnUsaCadImpressoras);

    For intContador := 0 To Length(arrFilas) -1 Do
    Begin
      If AnsiLowerCase(strNomeFila) = AnsiLowerCase(AnsiLeftStr(arrFilas[intContador].strNomeFila, Length(strNomeFila)))  Then
      Begin
        pSetPrinter(AnsiReplaceStr(LeftStr(arrFilas[intContador].strNomeFila, Length(strNomeFila)),'\\' + fRetNomeRede + '\',''));
        LAchouImpressora := True;
      End;
    End;

    If not LAchouImpressora Then
    Begin
      //Carrega a Impressora Padrao do Windows
      strNomeFila  := fGetImpPadraoWindows;
      pSetPrinter(strNomeFila);
    end;
  end;
  strNomeFila := AnsiReplaceStr(strNomeFila,'\\' + fRetNomeRede + '\','');
end;
{$IFEND}

{*****************************************}
{* POPULA A MATRIZ 'arrFilas' COM O NOME *}
{* DAS FILAS E SE MOSTRA A FILA OU NAO   *}
{**************************************MV*}
procedure pRetFilasImpressao(Var arrFilas: TarrFilas; blnUsaCadImpressoras: Boolean);
{$IF Defined(LINUX)}
begin
end;
{$ELSE}
  Var
    intContador: Integer;
    strNomRed: String;
begin

  strNomRed := fRetNomeRede;

  SetLength(arrFilas, Printer.Printers.Count);
  For intContador := 0 To Printer.Printers.Count -1 Do
  Begin
    arrFilas[intContador].strNomeFila := Printer.Printers[intContador];

    If Not blnUsaCadImpressoras Then
    Begin
      If (Pos(' on ', arrFilas[intContador].strNomeFila) > 0) Then
        arrFilas[intContador].strNomeFila := Trim(LeftStr(arrFilas[intContador].strNomeFila, Pos(' on ', arrFilas[intContador].strNomeFila)));

      If (Copy(arrFilas[intContador].strNomeFila, 1, 2) <> '\\') Then
        arrFilas[intContador].strNomeFila := '\\' + strNomRed + '\' + arrFilas[intContador].strNomeFila;
    End;

    arrFilas[intContador].blnMostrar  := True;
  End;
end;
{$IFEND}

{$IFDEF UNIDAC}
function fSelecionaPontoImpressao(): String;
{$IF Defined(LINUX)}
begin
end;
{$ELSE}
Var
  LForm: TfrmSelPontoImpressao;
begin
  LForm := TfrmSelPontoImpressao.Create(nil);
  Try
    LForm.ShowModal;
    Result := LForm.strImpSelecionada;
  Finally
    FreeAndNil(LForm);
  End;
end;
{$IFEND}
{$ENDIF}

{ TFastPreviewReport }

{$IF not Defined(LINUX) and Defined(UNIDAC)}
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
    AReport.ShowPreparedReport;
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
  If fUtilizaSpoolImpressaoCitel Then
  Begin
    LFrmDlg := TSpoolPrintDialog.Create(nil);
    Try
      LFrmDlg.Caption := FDesPro;
      LFrmDlg.FReport := FReport;
      If LFrmDlg.ShowModal = mrOk Then
      Begin
        If TSpoolImpressaoCitel.fGetPontoImpressao(LFrmDlg.PrintersCB.Text).Existe Then
          pPrintReport(FNomPro, FDesPro, LFrmDlg.PrintersCB.Text, FReport);
      End;
    Finally
      FreeAndNil(LFrmDlg);
    End;
  End
  Else
    FOldPrintBClick(Sender);
end;
{$IFEND}

end.
