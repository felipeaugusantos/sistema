unit untEntImportacaoNotaEletronica;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiOrdena, DB, UniClientDataSet, UniDataSetProvider, Uni, AppEvnts,
  Menus, StdCtrls, EditFocus, Mask, MaskEditFocus, Grids, DBGridCitel, DBGrids, Buttons, ExtCtrls,
  frxClass, frxDBSet, StrUtils, Math, BitBtnLockedIncrem, DirectoryEditFocus, untTypesSistema,
  ComCtrls, ShlObj, cxShellCommon, cxControls, cxContainer, cxShellListView, FileCtrl,
  XMLDoc, CheckLst, ShellApi, untZClient, MemDS, DBAccess, Provider, frxExportCSVTestabilidade,
  cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit,
  Datasnap.DBClient, untEntNfeXml, untFuncoesSimples, untLiberacao, cxProgressBar,
  FilenameEditFocus, untGravando, Vcl.DBCtrls, DBMemoFocus, untTLock,
  untFrameDirectoryEditFocus, VirtualTable, untLogImportacaoNotaEletronica;

type

  TfrmEntImportacaoNotaEletronica = class(TfrmPaiOrdena)
    lblInformacao: TLabel;
    Panel1: TPanel;
    lblPastaArq: TLabel;
    splSepador: TSplitter;
    cdsConsultaB08_NNF: TStringField;
    cdsConsultaB07_SERIE: TStringField;
    cdsConsultaB09_DEMI: TDateField;
    cdsConsultaC03_XNOME: TStringField;
    cdsConsultaNOMARQ: TStringField;
    Splitter1: TSplitter;
    frxReportJ: TfrxReport;
    frxReportM: TfrxReport;
    frxDBErros: TfrxDBDataset;
    cdsErros: TUniClientDataSet;
    cdsErrosNOMARQ: TStringField;
    cdsErrosNUMDOC: TStringField;
    cdsErrosNSERIE: TStringField;
    cdsErrosMOTIV: TStringField;
    cdsErrosCODITE: TStringField;
    cdsErrosCODBAR: TStringField;
    cdsErrosDESITE: TStringField;
    cklArqXML: TCheckListBox;
    pgcInformacoes: TPageControl;
    tbsLogErr: TTabSheet;
    memLogErr: TMemo;
    tbsErrItens: TTabSheet;
    cdsIteFor: TUniClientDataSet;
    cdsIteForITE_CODITE: TStringField;
    cdsIteForITE_CODFOR: TStringField;
    cdsIteForFOR_NOMFOR: TStringField;
    cdsIteForITE_CODITF: TStringField;
    dtsIteFor: TDataSource;
    dbgIteFor: TDBGridCitel;
    cdsIteForITE_DESITF: TStringField;
    Panel2: TPanel;
    pgbProgresso: TProgressBar;
    cdsIteForITE_DESITE: TStringField;
    cdsIteForITE_NUMDOC: TStringField;
    Label1: TLabel;
    cdsIteForITE_CODFAB: TStringField;
    btnConfCodigos: TBitBtnLocked;
    cdsConsultaGER_CODFOR: TStringField;
    cdsIteForITE_CODBAR: TStringField;
    frxDBClaIpi: TfrxDBDataset;
    frxReportM_ClaIPI: TfrxReport;
    frxReportJ_ClaIPI: TfrxReport;
    cdsConsultaDIV_CST: TBooleanField;
    btnCadastroDeProduto: TBitBtnLocked;
    cdsIteForITE_UNIDAD: TStringField;
    cdsIteForITE_UNITAR: TFloatField;
    Label2: TLabel;
    edtChaveAcesso: TMaskEditFocus;
    cdsConsultaVRDUPDIVCON: TBooleanField;
    cdsIteForITE_CLAIPI: TStringField;
    cdsIteForITE_CLAFIS: TStringField;
    cdsIteForITE_CODSIT: TStringField;
    cdsIteForITE_NUMFCI: TStringField;
    cdsIteForITE_FATUTR: TFloatField;
    cdsIteForITE_FREENT: TFloatField;
    cdsIteForITE_PER_CI: TFloatField;
    cdsIteForITE_IPIENT: TFloatField;
    cdsIteForITE_ICMENT: TFloatField;
    cdsIteForITE_SUBSTI: TFloatField;
    cdsIteForITE_APLICA: TMemoField;
    fraPathXml: TfraDirectoryEditFocus;
    pnlAplicacao: TPanel;
    pnlAplica: TPanel;
    mmoAplica: TDBMemoFocus;
    btnMarcaDesmarcaTodos: TBitBtnLocked;
    btnRelErr: TBitBtnLocked;
    btnImporta: TBitBtnLocked;
    btnCadFornecedor: TBitBtnLocked;
    cdsIteForITE_CDCEST: TStringField;
    cdsIteForITE_EAN: TStringField;
    cdsIteForITE_EANTRIB: TStringField;
    cdsIteForITE_CODITEANT: TStringField;
    cdsIteForITE_ATUALIZATABELAITEFOR: TIntegerField;
    cdsIteForAutIncITEFOR: TStringField;
    cdsConsultaTIPOFOR: TStringField;
    cdsIteForC12_UF: TStringField;
    cdsConsultaC12_UF: TStringField;
    cdsConsultaTIPAJUSTE: TStringField;
    btnDownloadFiles: TBitBtnLocked;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure dbgConsultaEnter(Sender: TObject);
    procedure dbgConsultaExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnImportaClick(Sender: TObject);
    procedure btnRelErrClick(Sender: TObject);
    procedure OnAcept(Sender: TObject);
    procedure dbgIteForKeyPress(Sender: TObject; var Key: Char);
    procedure cdsIteForBeforePost(DataSet: TDataSet);
    procedure btnConfCodigosClick(Sender: TObject);
    procedure cdsIteForAfterInsert(DataSet: TDataSet);
    procedure pgcInformacoesChange(Sender: TObject);
    procedure dbgIteForEnter(Sender: TObject);
    procedure btnCadastroDeProdutoClick(Sender: TObject);
    procedure btnCadFornecedorClick(Sender: TObject);
    procedure fraPathXmledtDirectoryExit(Sender: TObject);
    procedure fraPathXmledtDirectoryChange(Sender: TObject);
    procedure edtChaveAcessoKeyPress(Sender: TObject; var Key: Char);
    procedure btnMarcaDesmarcaTodosClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnDownloadFilesClick(Sender: TObject);
  private
    { Private declarations }
    objDigitacao: TStringList;
    strPatFit,
    strPatArq: String;
    blnSimPau: Boolean;
    blnValidaXMLSefaz: Boolean;
    cdsXML,
    cdsDadosFornec: TZClient;

    frmGravandoNotas: TfrmGravando;

    blnShowMessage,
    blnMarcaTodos,
    blnReprocessa,
    blnDivergenciaCapa,
    blnExiApl : Boolean;

    strNotasNaoMarcadas: string;

    cdsDiverg: TZClient;
    FCdsFornNaoEncontrado: TUniClientDataSet;
    stlNotaImportadas: TStringList;
    blnExibirCriticasEFcidivergenteAoConfirmarImportacao: boolean;

    intOpcAtivosAnt: Integer;
    blnIItFor : Boolean;
    cdsClaIpiDivergente : TZClient;

    blnDirAcessCadFornecedor,
    blnDirAcessCadItem: Boolean;

    finalidadeXML : tpeFinalidadeXML;
    strCodCli: String;
    recNotEle: TRecInfoNotaEletronica;
    blnFecharAoImportar : Boolean;

    fLocalizarItemRetornoSimbolico: TFunctionLocalizarItemRetornoSimbolico;

    objLiberacao : TLiberacao;
    objLock: TLock;
    blnAuditoria: Boolean;
    blnTabPrf: Boolean;
    blnRenomearXMLCancelado: Boolean;

    procedure pExcluiDesmarcados;
    procedure pCancela(blnFechar: Boolean = False);
    procedure pCarregaArquivos;

    Function fCarregaArquivosPrg(cxgProgresso: TcxProgressBar): Boolean;

    procedure pExibirDadosAposImportacao;
    function fImportaArquivo(strArquivo, strNomeArquivo: string): boolean;
    function fProcessar: Boolean;
    function fFornecedorAncora(strCodFor: string): Boolean;
    function fItemComTabelaAtiva(strCodIte,strCodFor: String; out strOutCodFabrica: String; out strOutCodFabricaAtual: String; out strOutCodAutIncITEFOR: String ): boolean;

    procedure pLogErro(strNumDoc, strSerie, strNomArq, strMensagem: String);
    procedure pMostraErros;
    function  fRetDivCST: Boolean;
    procedure pLimpaListaNotasImportadas;
    procedure pInsereArquivosLista(strPath: String);
    procedure pLimparDados;
    procedure pItemNaoEncontrado(strNumDoc,
                                 strCodFor,
                                 strCodIteF,
                                 strDesIteF,
                                 strEanPro,
                                 strUnidade,
                                 strCLAIPI,
                                 strClaFis,
                                 strCodCST,
                                 strCdCEST,
                                 strNUMFCI,
                                 strEAN,
                                 strEANTrib: String;
                                 fltUnidadeFATUTR,
                                 fltPRECOM,
                                 fltFREENT,
                                 fltPER_CI,
                                 fltPerIPI,
                                 fltPerICM,
                                 fltSubist: Double;
                                 strUf_For:  String);

    procedure pGravacao(strInformacao: String; intPosicao, intMaximo: Integer);
    procedure pAlteraClaIPI(strCodIte, strCodFab, strClaIpiXml, strNFCIXML: String; fltPerCiXML: Double);

    function fGetChaveLockDocumento: String;
    function fValidaVinculo(strCodIte: String; Var strAutoincrem : String; blnDialog : Boolean = True): Boolean;
    function fGetSqlClaIpiDivergente(strCodIte : String = ''): String;

    procedure pAtualizaCODFAB_CADITE(strCodIte, strCodFab: String; blnAtualizaCODFOR: Boolean = False);
    function fTemDuplicidadeIteFor(strCodIte, strCodFab,  strCodFor: String): boolean;
    function fVerificaForConsumo(strCodFor: String): boolean;
    function fVerificaProConsumo(strCodIte: String): boolean;
    procedure pInsereCdsFornNaoEncontrado(strCNPJ, strCPF, strXNOME, strXFANT, strXLGR,  strNRO,
          strXCPL, strXBAIRRO, strCMUN, strXMUN, strUF, strCEP,  strCPAIS, strXPAIS, strFONE, strIE, strIEST, strIM, strCNAE: String);
    function fValidaDivergenciaEntreValorContabileDuplicatas(objEntNfeXml: TNFeXml): Boolean;
    procedure pInicializarRecNotEle(objNfe: TNFeXml);
    procedure ProcessarRetornoB2W;
    function fTemDuplicidadeIteForDigitacao(strCodIte: String; var strCodItf: String): Boolean;
    procedure pAtualizarDigitacao(varValorNovo, varValorAntigo: Variant;
      strCodItf: String);
    function fAbrirTelaDivergenciasNfe: Boolean;
    function fCarregaTipoFornecedor(strCodFor: String): string;

    procedure pBaixarArquivosPendentes;
    function fBaixarArquivo(const AURL, ACodEmp : String): Boolean;
    function fBaixarArquivosPendentes(pgbStatus: TcxProgressBar = Nil): Boolean;
    function fTemArquivosPendentes(var AQtdFiles : Integer): Boolean; overload;
    function fTemArquivosPendentes: Boolean; overload;
  public
    cxgProgresso_Ext: TcxProgressBar;

    class function fImportar(finalidadeXMLP : tpeFinalidadeXML;
                             strCodCliP : String = '';
                             blnFecharAoImportarP : Boolean = False;
                             strpathXML: string = '';
                             AcdsXML: TZClient = nil;
                             AcxgProgresso: TcxProgressBar = nil;
                             fLocalizarItemRetornoSimbolicoParam: TFunctionLocalizarItemRetornoSimbolico = nil): TRecInfoNotaEletronica;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    function fAbreConsulta(blnLike: Boolean): Boolean; override;
    procedure pAddListaQuery;OVerride;
  end;


implementation

uses untPai, untCfgRel, untConsultas,
  untTabelaPreco, untConstantes, untEntNFEDivergencias, untIteBar, untListaProdutosFCIDivergenteNFE,
  untFuncoes, untFornecedorNaoImportado, untCadProdutos, untCadFornecedores,
  untLibNfe, untFuncFat, untTValidaNFeCapa, untMensagemExplicativa,
  Contabilidade.Funcoes, Contabilidade.Consultas, untCadClientes,
  untCadTransportadoras, untNFEXMLAuditoria, untBucketCitel;

{$R *.dfm}

function TfrmEntImportacaoNotaEletronica.fProcessar: Boolean;
begin
  Result :=  blnReprocessa;
  If finalidadeXML = xmlRetornoSimbolico Then
    Exit(True);
  If blnAuditoria Then
    Exit(True);

  If Not Result Then
    Result := (fMensagem('','Confirma importação dos arquivos selecionados?', ['','']) = 1);
end;


procedure TfrmEntImportacaoNotaEletronica.fraPathXmledtDirectoryChange(
  Sender: TObject);
begin
  inherited;
  cklArqXML.Clear;
  If DirectoryExists(Trim(fraPathXml.edtDirectory.Text)) Then
  Begin
    pInsereArquivosLista(Trim(fraPathXml.edtDirectory.Text));

  End;
end;

procedure TfrmEntImportacaoNotaEletronica.fraPathXmledtDirectoryExit(
  Sender: TObject);
begin
  inherited;
  If RightStr(fraPathXml.edtDirectory.Text, 1) <> '\' Then
    fraPathXml.edtDirectory.Text := fraPathXml.edtDirectory.Text + '\';

  edtChaveAcesso.Enabled := Not fEmptyStr(fraPathXml.edtDirectory.Text);
end;

function TfrmEntImportacaoNotaEletronica.fRetDivCST: Boolean;
  var
    i: integer;
begin
  Result := False;
  cdsConsulta.DisableControls;
  Try
    for I := 0 to stlListSelecao.Count -1 do
    Begin
      If cdsConsulta.Locate('NOMARQ', stlListSelecao[i], []) Then
        Result := cdsConsulta.FieldByName('DIV_CST').AsBoolean;
      If Result Then
        Exit;
    End;
  Finally
    cdsConsulta.EnableControls;
  End;

end;


function TfrmEntImportacaoNotaEletronica.fValidaCampos(Sender: TWinControl;
         blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = fraPathXml.edtDirectory) Then
    Begin
      fraPathXml.edtDirectory.Text := Trim(fraPathXml.edtDirectory.Text);

      fraPathXmledtDirectoryExit(Sender);
      blnExibirCriticasEFcidivergenteAoConfirmarImportacao := False;
      frmListaProdutosFCIDivergenteNFE.cdsConsulta.EmptyDataSet;

      If fEmptyStr(fraPathXml.edtDirectory.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe o pasta de importação de arquivos!', ['&Ok']);
        Result := FALSE;
      End

      Else If Not DirectoryExists(fraPathXml.edtDirectory.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Pasta não econtrada!', ['&Ok']);
        Result := FALSE;
      End

      Else If blnBuscaPorChave Then
      Begin
        pCarregaArquivos;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmEntImportacaoNotaEletronica.fGetChaveLockDocumento: String;
begin
  Result := cdsConsulta.FieldByName('B08_NNF').AsString   + '-' +
            cdsConsulta.FieldByName('B07_SERIE').AsString + '-' +
            cdsConsulta.FieldByName('B09_DEMI').AsString;
end;

procedure TfrmEntImportacaoNotaEletronica.pAddListaQuery;
  var intIndex: integer;
begin
  With cdsConsulta Do
  Begin
    If stlListSelecao.IndexOf(FieldByName(strCampoLista).AsString) = -1 Then
    Begin
      intIndex := stlNotaImportadas.IndexOf(cdsConsulta.FieldByName('NOMARQ').AsString);
      If (Not( finalidadeXML = xmlRetornoSimbolico))And
         (Assigned(objValidaNFeCapa)) And (objValidaNFeCapa.blnTemDivergencia) And
         objValidaNFeCapa.fNotaComDivergencia(cdsConsulta.FieldByName('B08_NNF').AsString,
                                              cdsConsulta.FieldByName('B07_SERIE').AsString,
                                              cdsConsulta.FieldByName('B09_DEMI').AsString)  Then
      Begin

        If blnShowMessage And
        (fMensagem('ATENÇÃO!', 'Este documento está com divergência entre os totais e os itens. Deseja ajustar?', ['&Sim', '&Não'], 1) = 1) Then
        Begin
          objValidaNFeCapa.pAjustaDivergencias;
          Exit;
        End
        Else
        Begin
          If Not blnShowmessage Then
            blnDivergenciaCapa := True;
          Exit;
        End;
      End;

      {Quando o valor contabil do documento diferente do valor das duplicatas pede senha de liberacao para marcar o iten}
      If (Not blnShowmessage) And (cdsConsulta.FieldByName('VRDUPDIVCON').AsBoolean) Then
         strNotasNaoMarcadas := strNotasNaoMarcadas + #$A#$D + string(TNFeXml(stlNotaImportadas.Objects[intIndex]).recDadosNota.B08_NNF) + ' valor contabil do documento diferente do valor das duplicatas';

      If Not ((intIndex >= 0) And (fValidaDivergenciaEntreValorContabileDuplicatas(TNFeXml(stlNotaImportadas.Objects[intIndex])))) Then
        Exit;


      If Not fEmptyStr(fGetHostLock(fGetChaveLockDocumento)) Then
      Begin
        If  finalidadeXML = xmlRetornoSimbolico Then
        Begin
          If cdsXML.Locate('ARQUIVO', cdsConsulta.FieldByName('NOMARQ').AsString, []) Then
          Begin
            cdsXML.Edit;
            cdsXML.FieldByName('STATUS_XML').AsString := 'Houve um problema ao importar.';
            cdsXML.FieldByName('STATUS_ENT').AsString := '';
            cdsXML.FieldByName('ERRO_STATUS_XML').AsString := 'Este documento está sendo utilizado por outra estação: ' + fGetHostLock(fGetChaveLockDocumento);
            cdsXML.Post;
          End;

        End
        Else If blnShowMessage Then
          fMensagem('ATENÇÃO!', 'Este documento está sendo utilizado por outra estação: ' + fGetHostLock(fGetChaveLockDocumento), ['&Ok'])
        Else If (Not blnShowmessage) Then
          strNotasNaoMarcadas := strNotasNaoMarcadas + #$A#$D + string(TNFeXml(stlNotaImportadas.Objects[intIndex]).recDadosNota.B08_NNF) + ' Este documento está sendo utilizado por outra estação: ' + fGetHostLock(fGetChaveLockDocumento);

        Exit;
      End;
      If (Not blnAuditoria) Then
      begin

        If (Not objLock.fLock_Unlock(fGetChaveLockDocumento, True, False)) Then
        Begin
          If  finalidadeXML = xmlRetornoSimbolico Then
          Begin
            If cdsXML.Locate('ARQUIVO', cdsConsulta.FieldByName('NOMARQ').AsString, []) Then
            Begin
              cdsXML.Edit;
              cdsXML.FieldByName('STATUS_XML').AsString := 'Houve um problema ao importar.';
              cdsXML.FieldByName('STATUS_ENT').AsString := '';
              cdsXML.FieldByName('ERRO_STATUS_XML').AsString := 'Este documento está sendo utilizado por outra estação: ' + fGetHostLock(fGetChaveLockDocumento);
              cdsXML.Post;
            End;

          End
          Else If blnShowMessage Then
            fMensagem('ATENÇÃO!', 'Este documento está sendo utilizado por outra estação: ' + fGetHostLock(fGetChaveLockDocumento), ['&Ok'])
          Else If (Not blnShowmessage) Then
            strNotasNaoMarcadas := strNotasNaoMarcadas + #$A#$D + string(TNFeXml(stlNotaImportadas.Objects[intIndex]).recDadosNota.B08_NNF) + ' Este documento está sendo utilizado por outra estação: ' + fGetHostLock(fGetChaveLockDocumento);
          Exit;
        End;
      End;
    End
    Else If (Not blnAuditoria) Then
      objLock.fLock_Unlock(fGetChaveLockDocumento, False);

    inherited pAddListaQuery;
  End;
end;

procedure TfrmEntImportacaoNotaEletronica.pAlteraClaIPI(strCodIte, strCodFab, strClaIpiXml, strNFCIXML: String; fltPerCiXML: Double);
  Var
    qryDados : TUniQuery;
    intIndex : Integer;
begin
  Try
    qryDados := fCriaQuery(Self);
    With qryDados, SQL Do
    Begin
      Add( fGetSqlClaIpiDivergente(strCodIte) );
      Open;

      cdsClaIpiDivergente.Append;

      For intIndex := 0 to Fields.Count -1 Do
        cdsClaIpiDivergente.FieldByName( Fields[intIndex].FieldName ).AsVariant := Fields[intIndex].AsVariant;

      cdsClaIpiDivergente.FieldByName('ITE_CODFAB').AsString := strCodFab;
      cdsClaIpiDivergente.FieldByName('ITE_NEWIPI').AsString := strClaIpiXml;

      cdsClaIpiDivergente.FieldByName('ITE_NEWFCI').AsString := strNFCIXML;
      cdsClaIpiDivergente.FieldByName('ITE_NEWPER').AsFloat  := fltPerCiXML;

      cdsClaIpiDivergente.Post;
    End;

  Finally
    FreeAndNil(qryDados);
  End;

end;

procedure TfrmEntImportacaoNotaEletronica.pAtualizaCODFAB_CADITE(strCodIte, strCodFab: String; blnAtualizaCODFOR: Boolean = False);
  var qryConsulta: TUniQuery;
begin
 If fEmptyStr(strCodFab) Then
    Exit;

  qryConsulta := fCriaQuery;
  Try
    Try
      qryConsulta.SQL.Add('UPDATE CADITE');
      qryConsulta.SQL.Add('   SET ITE_CODFAB = :CODFAB');
      qryConsulta.SQL.Add(' WHERE ITE_CODITE = :CODITE');

      If Not blnAtualizaCODFOR Then
        qryConsulta.SQL.Add('   AND COALESCE(ITE_CODFAB, "") = ""');

      qryConsulta.ParamByName('CODFAB').AsString := strCodFab;
      qryConsulta.ParamByName('CODITE').AsString := strCodIte;
      qryConsulta.ExecSQL;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TfrmEntImportacaoNotaEletronica.pAtualizaCODFAB_CADITE]');
    End;
  Finally
    FreeAndNil(qryConsulta);
  End
end;
function TfrmEntImportacaoNotaEletronica.fBaixarArquivo(const AURL,
  ACodEmp: String): Boolean;
var
  LFile     : TBytesStream;
  LFileName : String;
begin
  Result := False;
  LFile  := nil;
  try
    LFile := TBucketCitel.Instance.fGetFile(AURL, ACodEmp);

    if not Assigned(LFile) then
      Exit;

    if not DirectoryExists(Trim(fraPathXml.edtDirectory.Text)) then
      raise Exception.Create('Diretório de destino não encontrado: ' + fraPathXml.edtDirectory.Text);

    LFileName := IncludeTrailingPathDelimiter(Trim(fraPathXml.edtDirectory.Text)) +
                 ReplaceStr(AURL, 'https://bucket.citelsoftware.com.br/', '');

    if FileExists(LFileName) then
    begin
      if not DeleteFile(LFileName) then
        raise Exception.CreateFmt('Não foi possível excluir o arquivo existente: %s', [LFileName]);
    end;

    LFile.SaveToFile(LFileName);

  finally
    Result := FileExists(LFileName);
    FreeAndNil(LFile);
  end;
end;

procedure TfrmEntImportacaoNotaEletronica.pBaixarArquivosPendentes;
Var
  frmAguarde: TfrmGravando;
begin
  Try
    pCriarFormularios(TfrmGravando, frmAguarde);
    frmAguarde.fExecutarAcao := fBaixarArquivosPendentes;
    frmAguarde.ShowModal;

    pFreeAndNil(frmAguarde);
  Except
    On E: Exception Do
    Begin
      pFreeAndNil(frmAguarde);
      pMensagensErro(E.Message, '');
    End;
  End;
end;

function TfrmEntImportacaoNotaEletronica.fBaixarArquivosPendentes(pgbStatus: TcxProgressBar = Nil): Boolean;
var
  qryDados: TUniQuery;
  LURL, LAcesso, LCodEmp: String;
begin
  Result := False;

  pgbStatus.Position := 0;
  pInfoStatusGravacao(pgbStatus, 'Baixando arquivos pendentes');

  qryDados := fCriaQuery(Self);
  try
    qryDados.SQL.Text :=
      ' SELECT DFE_ACESSO, DFE_URLBKT, DFE_CODEMP ' +
      ' FROM DFETER ' +
      ' WHERE DFE_BAIXAD = "N" ' +
      '   AND IFNULL(DFE_URLBKT,"") <> "" ' +
      ' ORDER BY DFE_DTADOC';
    qryDados.Open;

    pgbStatus.Properties.Max := qryDados.RecordCount;

    qryDados.First;
    while not qryDados.Eof do
    begin
      pInfoStatusGravacao(pgbStatus, 'Baixando arquivos ('+qryDados.RecNo.ToString+'/'+qryDados.RecordCount.ToString+')', qryDados.RecordCount);
      pgbStatus.Position := qryDados.RecNo;
      Application.ProcessMessages;

      LURL    := qryDados.FieldByName('DFE_URLBKT').AsString;
      LAcesso := qryDados.FieldByName('DFE_ACESSO').AsString;
      LCodEmp := qryDados.FieldByName('DFE_CODEMP').AsString;

      try
        If fBaixarArquivo(LURL, LCodEmp) Then
        begin
          fExecutaSQL(
            ' UPDATE DFETER ' +
            ' SET    DFE_BAIXAD = "S" ' +
            ' WHERE  DFE_ACESSO = ' + QuotedStr(LAcesso),
            True);
        end;

      except
        on E: Exception do
        begin
          pMensagensErro(Format('Erro ao processar arquivo [%s] (Acesso=%s): %s', [LURL, LAcesso, E.Message]),
                         '[TfrmEntImportacaoNotaEletronica.pBaixarArquivosPendentes]');
          Exit;
        end;
      end;

      qryDados.Next;
    end;

  finally
    Result := True;
    FreeAndNil(qryDados);
  end;
end;

procedure TfrmEntImportacaoNotaEletronica.pCancela(blnFechar: Boolean = False);
Begin
  If (fraPathXml.edtDirectory.Focused) Or blnFechar Then
    Close
  Else
  Begin
    objLock.pDestravarTodos;
    pLimpaPesquisa;
    pLimparDados;
    pgcInformacoes.ActivePage := tbsErrItens;
    pSetFocus(fraPathXml.edtDirectory);
  End;
End;

procedure TfrmEntImportacaoNotaEletronica.pLimparDados;
begin
  cdsConsulta.EmptyDataSet;
  cdsErros.EmptyDataSet;
  cdsIteFor.EmptyDataSet;
  pLimpaListaNotasImportadas;
  If Not blnReprocessa Then
  Begin
    blnMarcaTodos := False;
    stlListSelecao.Clear;
    objValidaNFeCapa.pReset;
  End;

end;

procedure TfrmEntImportacaoNotaEletronica.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  Case finalidadeXML of
    xmlEntradaMercadoria           : fAtuCfgSis('XMLPAT', fraPathXml.edtDirectory.Text);
    xmlConsertoEquipamento         : fAtuCfgSis('XMLPTE', fraPathXml.edtDirectory.Text);
    xmlGarantiaRecCliente          : fAtuCfgSis('XMLGRC', fraPathXml.edtDirectory.Text);
    xmlCFG_IMPXGRGarantiaRetFornecedor,
    xmlGarantiaRetFornecedor       : fAtuCfgSis('XMLGRF', fraPathXml.edtDirectory.Text);
    xmlConsignacaoDevolucaoCliente : fAtuCfgSis('PATDVC', fraPathXml.edtDirectory.Text);
    xmlRetornoLocacao              : fAtuCfgSis('XMLRLC', fraPathXml.edtDirectory.Text);
    xmlDevolucaoEntradaEmitidaFornecedor: fAtuCfgSis('XMLDEF', fraPathXml.edtDirectory.Text);
  End;

  FreeAndNil(objValidaNFeCapa);
  pLimpaListaNotasImportadas;
  blnMarcaTodos := False;

  If Assigned(stlNotaImportadas) Then
    FreeAndNil(stlNotaImportadas);

  FreeAndNil(FCdsFornNaoEncontrado);

  FreeAndNil(frmListaProdutosFCIDivergenteNFE);
  FreeAndNil(frmLogImportacaoNotaEletronica);

  If Assigned(cdsDiverg) Then
    FreeAndNil(cdsDiverg);
end;

procedure TfrmEntImportacaoNotaEletronica.pLimpaListaNotasImportadas;
  var
    intContador: Integer;
begin

  For intContador := 0 To stlNotaImportadas.Count -1 Do
  Begin
    If Assigned(stlNotaImportadas.Objects[intContador]) Then
      TNFeXml(stlNotaImportadas.Objects[intContador]).Destroy;
  End;
  stlNotaImportadas.Clear;
end;

procedure TfrmEntImportacaoNotaEletronica.FormCreate(Sender: TObject);
  Var
    strDireitos: String;
begin
  inherited;
  objDigitacao := TStringList.Create;
  fraPathXml.OnAccept := OnAcept;
  blnAuditoria := False;

  strPatArq := '';
  blnSimPau := fCfgSis('SIMPAU', varBoolean);
  blnValidaXMLSefaz := fCfgSis('VALXML', varBoolean);

  cdsDadosFornec := TZClient.Create(Self, TNFeXml.fSQLDadosFornec);
  cdsDadosFornec.fLeDados('TfrmEntImportacaoNotaEletronica.FormCreate');
  cdsDadosFornec.IndexFieldNames := 'CODFOR';

  blnShowMessage := True;
  strCampoLista := 'NOMARQ';
  cdsConsulta.CreateDataSet;
  objValidaNFeCapa := TValidaNFeCapa.Create();

  objLiberacao := TLiberacao.Create;
  objLock := TLock.Create;

  pSetaCodIte(cdsIteForITE_CODITE);

  cdsIteFor.CreateDataSet;
  cdsErros.CreateDataSet;
  blnExibirCriticasEFcidivergenteAoConfirmarImportacao := False;

  pCriarFormularios(TfrmListaProdutosFCIDivergenteNFE, frmListaProdutosFCIDivergenteNFE);
  pCriarFormularios(TfrmLogImportacaoNotaEletronica, frmLogImportacaoNotaEletronica);

  (cdsIteFor.FieldByName('ITE_UNITAR') As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', VarInteger));

  intOpcAtivosAnt := 0;

  stlNotaImportadas := TStringList.Create;

  cdsDiverg := Nil;
  blnIItFor := fCfgSis('IITFOR', varBoolean);
  blnTabPrf := fCfgSis('TABPRF', varBoolean);

  cdsClaIpiDivergente := TZClient.Create(Self, fGetSqlClaIpiDivergente);
  cdsClaIpiDivergente.fAbreClient(True, 'TfrmEntImportacaoNotaEletronica.FormCreate' );

  blnDirAcessCadFornecedor := fEhAdministrador(strLoginUsuarioLogado);
  blnDirAcessCadItem       := fEhAdministrador(strLoginUsuarioLogado);

  If Not fEhAdministrador(strLoginUsuarioLogado) Then
  Begin
    blnDirAcessCadFornecedor := fValidarDirEspecificos(strDireitos, strLoginUsuarioLogado, 'frmCadFornecedores') And (Pos('I', strDireitos) > 0);
    blnDirAcessCadItem       := fValidarDirEspecificos(strDireitos, strLoginUsuarioLogado, 'frmCadProdutos')     And (Pos('I', strDireitos) > 0);
  End;

  btnCadFornecedor.Visible := blnDirAcessCadFornecedor;
  btnCadastroDeProduto.Visible := blnDirAcessCadItem;
  FCdsFornNaoEncontrado := TfrmFornecedorNaoImportado.fGetClientDataSetEstrutura;

  strCodCli := '';

  blnExiApl := fCfgSis('EXIAPL', varBoolean);

  If blnExiApl Then
  Begin
    pnlAplicacao.Visible := True;
    mmoAplica.DataSource := dtsIteFor;
  End;

  btnDownloadFiles.Visible := False;
end;

procedure TfrmEntImportacaoNotaEletronica.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(objDigitacao);
  if Assigned(objLiberacao) then
    FreeAndNil(objLiberacao);
  FreeAndNil(objLock);
end;

function TfrmEntImportacaoNotaEletronica.fGetSqlClaIpiDivergente(strCodIte : String = ''): String;
begin
  Result := '';
  Result := Result + ' SELECT SQL_NO_CACHE               ';
  Result := Result + '        ITE_CODITE,                ';
  Result := Result + '        ITE_DESITE,                ';
  Result := Result + '        ITE_REFERE,                ';
  Result := Result + '        UNI_SIGUNI AS ITE_SIGUNI,  ';
  Result := Result + '        ITE_CODBAR,                ';
  Result := Result + '        ITE_CODFAB,                ';
  Result := Result + '        ITE_CODFAB,                ';

  Result := Result + '        ITE_CLAIPI,                ';
  Result := Result + '        ITE_CLAIPI AS ITE_NEWIPI,  ';

  Result := Result + '        ITE_NUMFCI,               ';
  Result := Result + '        ITE_NUMFCI AS ITE_NEWFCI, ';

  Result := Result + '        ITE_PER_CI,               ';
  Result := Result + '        ITE_PER_CI AS ITE_NEWPER  ';

  Result := Result + ' FROM CADITE                       ';
  Result := Result + '   LEFT  JOIN CADUNI ON            ';
  Result := Result + '   UNI_CODUNI = ITE_CODUNI         ';
  if fEmptyStr(strCodIte) Then
    Result := Result + ' WHERE FALSE                     '
  Else
    Result := Result + ' WHERE ITE_CODITE = ' + QuotedStr(strCodIte);

end;


procedure TfrmEntImportacaoNotaEletronica.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin

  Case Key Of
    VK_F2    : btnRelErr.Click;

    VK_F3    : If ssAlt in Shift Then
               Begin
                 If btnDownloadFiles.Visible Then
                   btnDownloadFiles.Click;
               End
               Else
                 inherited;

    VK_F9    : If pgcInformacoes.ActivePage = tbsErrItens Then
               Begin
                 btnConfCodigos.Click;
               End;

    VK_F6    : btnCadastroDeProduto.Click;
    VK_F7    : btnCadFornecedor.Click;
    VK_F8    : btnMarcaDesmarcaTodos.Click;

    VK_F10   : btnImporta.Click;

    VK_DELETE: Begin
                 If dbgConsulta.Focused Then
                   Key := 0;
               End;

    VK_ESCAPE: Begin
                 If pnlPesquisa.Visible Then
                   inherited
                 Else
                    pCancela(True);
               end;

    Else inherited;
  End;

end;

procedure TfrmEntImportacaoNotaEletronica.FormShow(Sender: TObject);
Var
  LQtdFiles : Integer;
begin
  inherited;

  blnSempreRelerBanco := FALSE;
  blnQuoteLista       := False;

  lflLastField.intIndCol := 0;
  lflLastField.strNomCam := dbgConsulta.Columns[0].FieldName;
  lflLastField.strNomCol := dbgConsulta.Columns[0].Title.Caption;
  lflLastField.ftyTipCam := ftString;

  pSetFocus(fraPathXml.edtDirectory);

  Case finalidadeXML Of
    xmlEntradaMercadoria           : fraPathXml.edtDirectory.Text := fCfgSisL('XMLPAT');
    xmlConsertoEquipamento         : fraPathXml.edtDirectory.Text := fCfgSisL('XMLPTE');
    xmlGarantiaRecCliente          : fraPathXml.edtDirectory.Text := fCfgSisL('XMLGRC');
    xmlCFG_IMPXGRGarantiaRetFornecedor,
    xmlGarantiaRetFornecedor       : fraPathXml.edtDirectory.Text := fCfgSisL('XMLGRF');
    xmlConsignacaoDevolucaoCliente : fraPathXml.edtDirectory.Text := fCfgSisL('PATDVC');
    xmlRetornoLocacao              : fraPathXml.edtDirectory.Text := fCfgSisL('XMLRLC');
    xmlDevolucaoEntradaEmitidaFornecedor: fraPathXml.edtDirectory.Text := fCfgSisL('XMLDEF');

  End;

  pgcInformacoes.ActivePage := tbsErrItens;

  If (finalidadeXML in [xmlConsertoEquipamento, xmlGarantiaRecCliente, xmlConsignacaoDevolucaoCliente, xmlRetornoLocacao]) Then
  Begin
    if finalidadeXML in [xmlGarantiaRecCliente, xmlConsignacaoDevolucaoCliente, xmlRetornoLocacao] then
    begin
      tbsErrItens.TabVisible := true;
      dbgIteFor.Columns[1].Title.Caption := 'Cod.Cli.';
      dbgIteFor.Columns[2].Title.Caption := 'Nome do Cliente';
      dbgIteFor.Columns[3].Title.Caption := 'Descrição Item Clien.';
      dbgIteFor.Columns[4].Title.Caption := 'Cód. Item Clien.';
      btnCadastroDeProduto.Visible := False;
    end
    else
      tbsErrItens.TabVisible := false;

    btnCadFornecedor.Visible := False;
  End;
  If blnAuditoria then
  Begin
    tbsErrItens.TabVisible := False;
    pgcInformacoes.ActivePage := tbsLogErr;

    btnDownloadFiles.Visible := fTemArquivosPendentes(LQtdFiles);
    btnDownloadFiles.Caption := '[Alt + F3] &Baixar ' + LQtdFiles.ToString + ' Arquivo(s) Pendente(s)';
  End;
  fraPathXml.DefaultFolder := fraPathXml.edtDirectory.Text;

  IF finalidadeXML = xmlRetornoSimbolico Then
    fValidaCampos(fraPathXml.edtDirectory);

end;

procedure TfrmEntImportacaoNotaEletronica.btnCadFornecedorClick(
  Sender: TObject);
begin
  If (Not blnDirAcessCadFornecedor) Or (Not btnCadFornecedor.Visible) Then
    Exit;

  If Not FCdsFornNaoEncontrado.IsEmpty Then
    TfrmFornecedorNaoImportado.fExibirFornecedoresNaoImportados(FCdsFornNaoEncontrado)
  Else
  Begin
    pCriarFormularios(TfrmCadFornecedores, frmCadFornecedores);

    try
      frmCadFornecedores.fSemMascaraPlaNco := fSemMascaraPlaNco;
      frmCadFornecedores.fPesqPlanoContabil := fPesqPlanoContabil;
      frmCadFornecedores.pPlanoDeContasPorEmpresa := pPlanoDeContasPorEmpresa;
      frmCadFornecedores.fCadastroRapidoCliente := TfrmCadClientes.fCadastroRapidoCliente;
      frmCadFornecedores.fCadastroRapidoTransportadora := TfrmCadTransportadoras.fCadastroRapidoTransportadora;
      frmCadFornecedores.fVerificarPlanoDeContasPorEmpresa := fVerificarPlanoDeContasPorEmpresa;
      frmCadFornecedores.ShowModal;
    finally
      frmCadFornecedores.fMskCon := Nil;
      frmCadFornecedores.fSemMascaraPlaNco := Nil;
      frmCadFornecedores.fPesqPlanoContabil := Nil;
      frmCadFornecedores.fCadastroRapidoCliente := Nil;
      frmCadFornecedores.fCadastroRapidoTransportadora := Nil;
      frmCadFornecedores.fVerificarPlanoDeContasPorEmpresa := Nil;
      pFreeAndNil(frmCadFornecedores);
    End;

  End;
end;

procedure TfrmEntImportacaoNotaEletronica.btnConfCodigosClick(Sender: TObject);
  Var
    strSQL    : string;
    qryGen    : TUniQuery;
    objTabPre : TTabelaPreco;
    objCodBar : TIteBar;
    strSQLUp  : string;
    strAuto   : string;
    blnPrinc  : Boolean;
    blnFornecedorAncora: Boolean;
    strEANTRIB: String;

begin
  if not btnConfCodigos.Visible then
   exit;

  inherited;

  With cdsIteFor Do
  Begin
    if finalidadeXML in [xmlGarantiaRecCliente, xmlConsignacaoDevolucaoCliente] then
    begin
      strSQL := '';
      strSQL := strSQL + ' INSERT INTO ITECLI (';
      strSQL := strSQL + '   ITE_CODITE, ';
      strSQL := strSQL + '   ITE_CODITC, ';
      strSQL := strSQL + '   ITE_CODCLI, ';
      strSQL := strSQL + '   ITE_CODEMP, ';
      strSQL := strSQL + '   AUTOINCREM) ';
      strSQL := strSQL + ' VALUES( ';
      strSQL := strSQL + '   :CODITE, ';
      strSQL := strSQL + '   :CODITC, ';
      strSQL := strSQL + '   :CODCLI, ';
      strSQL := strSQL + '   :CODEMP, ';
      strSQL := strSQL + '   :AUTINC) ';

      strSQLUp := '';
      strSQLUp := strSQLUp + ' UPDATE ITECLI              ';
      strSQLUp := strSQLUp + ' SET   ITE_CODITC = :CODITC ';
      strSQLUp := strSQLUp + ' WHERE AUTOINCREM = :AUTINC ';
    end
    Else if finalidadeXML in [xmlRetornoLocacao] then
    begin
      strSQL := '';
      strSQL := strSQL + ' INSERT INTO ITECLI (';
      strSQL := strSQL + '   ITE_CODITE, ';
      strSQL := strSQL + '   ITE_CODITC, ';
      strSQL := strSQL + '   ITE_CODCLI, ';
      strSQL := strSQL + '   ITE_CODEMP, ';
      strSQL := strSQL + '   ITE_DESCRI, ';
      strSQL := strSQL + '   AUTOINCREM) ';
      strSQL := strSQL + ' VALUES( ';
      strSQL := strSQL + '   :CODITE, ';
      strSQL := strSQL + '   :CODITC, ';
      strSQL := strSQL + '   :CODCLI, ';
      strSQL := strSQL + '   :CODEMP, ';
      strSQL := strSQL + '   :DESCRI, ';
      strSQL := strSQL + '   :AUTINC) ';

      strSQLUp := '';
      strSQLUp := strSQLUp + ' UPDATE ITECLI              ';
      strSQLUp := strSQLUp + ' SET   ITE_CODITC = :CODITC ';
      strSQLUp := strSQLUp + ' WHERE AUTOINCREM = :AUTINC ';
    end
    else
    begin
      blnFornecedorAncora := fFornecedorAncora(Fieldbyname('ITE_CODFOR').AsString);

      strSQL := '';
      strSQL := strSQL + ' INSERT INTO ITEFOR (';
      strSQL := strSQL + '   ITE_CODITE, ';
      strSQL := strSQL + '   ITE_CODFAB, ';
      strSQL := strSQL + '   ITE_CODITF, ';
      strSQL := strSQL + '   ITE_CODFOR, ';
      strSQL := strSQL + '   ITE_CODEMP, ';
      strSQL := strSQL + '   ITE_CODTAB, ';
      if blnFornecedorAncora then
      begin
        strSQL := strSQL + '   ITE_CODCNA, ';
      end;
      strSQL := strSQL + '   AUTOINCREM) ';
      strSQL := strSQL + ' VALUES( ';
      strSQL := strSQL + '   :CODITE, ';
      strSQL := strSQL + '   :CODFAB, ';
      strSQL := strSQL + '   :CODITF, ';
      strSQL := strSQL + '   :CODFOR, ';
      strSQL := strSQL + '   :CODEMP, ';
      strSQL := strSQL + '   :CODTAB, ';
      if blnFornecedorAncora then
      begin
        strSQL := strSQL + '   :CODITF, ';
      end;
      strSQL := strSQL + '   :AUTINC) ';

      strSQLUp := '';
      strSQLUp := strSQLUp + ' UPDATE ITEFOR   SET      ';
      If  blnTABPRF Then
        strSQLUp := strSQLUp + '  ITE_CODFAB = :CODITF     '
      Else
        strSQLUp := strSQLUp + '  ITE_CODITF = :CODITF     ';

      if blnFornecedorAncora then
      begin
        strSQLUp := strSQLUp + '    ,ITE_CODCNA = :CODITF  ';
      end;
      strSQLUp := strSQLUp + ' WHERE AUTOINCREM = :AUTINC ';
    end;
    First;

    qryGen := fCriaQuery;
    objCodBar := TIteBar.Create(opcOperacoes);

    While Not Eof Do
    Begin
      If Not fEmptyStr(FieldByName('ITE_CODITE').AsString) Then
      Begin
        {***********************************************************}
        {* SE NÃO TIVER CODIGO JÁ VINCULADO INSERI SE NAO ATUALIZA *}
        {********************************************************GB*}
        if fValidaVinculo(FieldByName('ITE_CODITE').AsString, strAuto, False) then
        Begin
          If not (finalidadeXML in [xmlGarantiaRecCliente, xmlConsignacaoDevolucaoCliente, xmlRetornoLocacao]) then
          begin
            if  Not fCodigoDeBarrasExiste(Fieldbyname('ITE_CODBAR').AsString, Fieldbyname('ITE_CODITE').AsString) Then
            Begin
              // Adiciona o Codigo de Barras do Produto.
              if not fEmptyStr(Fieldbyname('ITE_CODBAR').AsString) then
              Begin
                objCodBar.pCarregaDados(FieldByName('ITE_CODITE').AsString);
                //Se não tiver cod de barras cadastrado marca este como principal e atualiza a cadite
                blnPrinc := (fRetQtdIteBar(Fieldbyname('ITE_CODITE').AsString) = 0);

                strEANTRIB := 'S';
                if Trim(FieldByName('ITE_CDCEAN').AsString) = Trim(FieldByName('ITE_CDCEAT').AsString) then
                  strEANTRIB := 'N';

                objCodBar.pIncluiCodigo(Fieldbyname('ITE_CODBAR').AsString, 1, blnPrinc,
                                      Not fTemPrincipalParaCompra(FieldByName('ITE_CODITE').AsString), True, 0, '', '', '', 0,0,0,0,0,0,0,0, blnPrinc ,'', strEANTRIB);

                objCodBar.pSalvaDados(FieldByName('ITE_CODITE').AsString, True);
                objCodBar.pCarregaDados('');
              End;
            End;
          end;

          qryGen.Close;
          qryGen.SQL.Clear;
          qryGen.SQL.Add(strSQL);

          if finalidadeXML in [xmlGarantiaRecCliente, xmlConsignacaoDevolucaoCliente] then
          begin
            qryGen.ParamByName('AUTINC').AsString := fRetAutoIncrem('ITECLI',VS_strCodEmp);
            qryGen.ParamByName('CODITE').AsString := Fieldbyname('ITE_CODITE').AsString;
            qryGen.ParamByName('CODITC').AsString := Fieldbyname('ITE_CODITF').AsString;
            qryGen.ParamByName('CODCLI').AsString := Fieldbyname('ITE_CODFOR').AsString;
            qryGen.ParamByName('CODEMP').AsString := VS_strCodEmp;

            qryGen.ExecSQL;
          end
          Else If finalidadeXML in [xmlRetornoLocacao] Then
          begin
            qryGen.ParamByName('AUTINC').AsString := fRetAutoIncrem('ITECLI',VS_strCodEmp);
            qryGen.ParamByName('CODITE').AsString := Fieldbyname('ITE_CODITE').AsString;
            qryGen.ParamByName('CODITC').AsString := Fieldbyname('ITE_CODITF').AsString;
            qryGen.ParamByName('CODCLI').AsString := Fieldbyname('ITE_CODFOR').AsString;
            qryGen.ParamByName('DESCRI').AsString := Fieldbyname('ITE_DESITE').AsString;
            qryGen.ParamByName('CODEMP').AsString := VS_strCodEmp;

            qryGen.ExecSQL;
          end
          Else if (cdsIteForITE_ATUALIZATABELAITEFOR.AsInteger = 1) Then
          begin
            qryGen.Close;
            qryGen.SQL.Clear;
            qryGen.SQL.Add(strSQLUp);

            qryGen.ParamByName('CODITF').AsString := Fieldbyname('ITE_CODITF').AsString;

            qryGen.ParamByName('AUTINC').AsString := cdsIteForAutIncITEFOR.AsString ;

            qryGen.ExecSQL;

            { Atualiza o Campo Cod Fabrica da Tabela CADITe }
            pAtualizaCODFAB_CADITE(Fieldbyname('ITE_CODITE').AsString,
                                   Fieldbyname('ITE_CODITF').AsString,
                                   True);
          end
          Else
          begin
            qryGen.ParamByName('AUTINC').AsString := fRetAutoIncrem('ITEFOR',VS_strCodEmp);
            qryGen.ParamByName('CODITE').AsString := Fieldbyname('ITE_CODITE').AsString;
            qryGen.ParamByName('CODFAB').AsString := Fieldbyname('ITE_CODITF').AsString;
            qryGen.ParamByName('CODITF').AsString := Fieldbyname('ITE_CODITF').AsString;

            qryGen.ParamByName('CODFOR').AsString := Fieldbyname('ITE_CODFOR').AsString;
            qryGen.ParamByName('CODEMP').AsString := VS_strCodEmp;

            If fCfgSis('TABPRF', varBoolean) Then
              qryGen.ParamByName('CODTAB').AsString := objTabPre.fRetTabelaAtiva(Fieldbyname('ITE_CODFOR').AsString);

            qryGen.ExecSQL;

            { Atualiza o Campo Cod Fabrica da Tabela CADITe se estiver vazio}
            pAtualizaCODFAB_CADITE(Fieldbyname('ITE_CODITE').AsString,
                                   Fieldbyname('ITE_CODITF').AsString);
          end;

        End
        Else
        Begin
          qryGen.Close;
          qryGen.SQL.Clear;
          qryGen.SQL.Add(strSQLUp);

          if finalidadeXML in [xmlGarantiaRecCliente, xmlConsignacaoDevolucaoCliente, xmlRetornoLocacao] then
            qryGen.ParamByName('CODITC').AsString := Fieldbyname('ITE_CODITF').AsString
          else
            qryGen.ParamByName('CODITF').AsString := Fieldbyname('ITE_CODITF').AsString;

          qryGen.ParamByName('AUTINC').AsString := strAuto;

          qryGen.ExecSQL;

        End;

        If not (finalidadeXML in [xmlGarantiaRecCliente, xmlConsignacaoDevolucaoCliente, xmlRetornoLocacao]) then
          fAtualizaBarFabIte(FieldByName('ITE_CODITE').AsString);
      End;

      Next;
    End;

    Filter := 'ITE_CODITE <> ' + QuotedStr('');
    Filtered := True;

    While Not IsEmpty Do Delete;

    Filtered := False;

    FreeAndNil(qryGen);
    FreeAndNil(objTabPre);
    FreeAndNil(objCodBar);
  End;

  If fMensagem('','Deseja tentar importar os documentos novamente?', ['','']) = 1 Then
    fValidaCampos(fraPathXml.edtDirectory, True);
end;

procedure TfrmEntImportacaoNotaEletronica.btnDownloadFilesClick(Sender: TObject);
begin
  pBaixarArquivosPendentes;

  If Not fTemArquivosPendentes Then
  Begin
    btnDownloadFiles.Visible := False;

    cklArqXML.Clear;
    If DirectoryExists(Trim(fraPathXml.edtDirectory.Text)) Then
      pInsereArquivosLista(Trim(fraPathXml.edtDirectory.Text));
  End;

  pSetFocus(fraPathXml.edtDirectory);
end;

procedure TfrmEntImportacaoNotaEletronica.btnMarcaDesmarcaTodosClick(
  Sender: TObject);
begin
  inherited;
  If stlNotaImportadas.Count <= 0 Then
    Exit;
  blnMarcaTodos := Not blnMarcaTodos;
  blnDivergenciaCapa := False;
  cdsConsulta.First;
  blnShowMessage := False;
  strNotasNaoMarcadas := '';
  While not cdsConsulta.Eof Do
  Begin
    If (Not blnMarcaTodos) And (stlListSelecao.IndexOf(cdsConsulta.FieldByname('NOMARQ').AsString) >= 0) Then
      pAddListaQuery
    Else if blnMarcaTodos And (stlListSelecao.IndexOf(cdsConsulta.FieldByname('NOMARQ').AsString) = -1) Then
      pAddListaQuery;
    cdsConsulta.Next;
  End;
  If blnDivergenciaCapa Then
    fMensagem('ATENÇÃO!', 'Uma ou varias notas não poderam ser marcadas pois contêm divergencia entre a capa e seus itens.', ['&Ok']);
  blnShowMessage := True;
  If blnMarcaTodos And (Not fEmptyStr(strNotasNaoMarcadas)) Then
  Begin
    pCriarFormularios(TfrmMensagemExplicativa, frmMensagemExplicativa);
    Try
      frmMensagemExplicativa.mmoInstru.Lines.Add('Uma ou mais notas não poderam ser marcadas:');
      frmMensagemExplicativa.mmoInstru.Lines.Add(strNotasNaoMarcadas);
      frmMensagemExplicativa.Showmodal;
    Finally
      FreeAndNil(frmMensagemExplicativa);
    End;
  End;
end;

procedure TfrmEntImportacaoNotaEletronica.pExcluiDesmarcados;
Begin

  With cdsDiverg Do
  Begin
    cdsConsulta.DisableControls;
    cdsConsulta.First;

    While Not cdsConsulta.Eof Do
    Begin

      Filter   := 'NUMDOC = ' + QuotedStr(cdsConsulta.FieldByName('B08_NNF').AsString) + ' AND CODFOR = ' +
                                QuotedStr(cdsConsulta.FieldByName('GER_CODFOR').AsString);
      Filtered := True;
      First;

      While Not Eof Do
      Begin
        Edit;
        FieldByName('MOSTRA').AsString := IIF(fInLista, 'S', 'N');
        Post;
        Next;
      End;

      cdsConsulta.Next;
    End;

    Filtered := False;

    cdsConsulta.EnableControls;
  End;
End;

function TfrmEntImportacaoNotaEletronica.fAbrirTelaDivergenciasNfe: Boolean;
Begin
  If (finalidadeXML = xmlRetornoSimbolico) Then
    Exit(False);

  If (finalidadeXML = xmlRetornoLocacao) And fCfgSis('VALELE', varBoolean) Then
    Exit(False);

  Result := True;
End;

procedure TfrmEntImportacaoNotaEletronica.btnImportaClick(Sender: TObject);
  var
    intSelec: Integer;
    intIndex: Integer;
    blnConfirma,
    blnPreGnre,
    blnCSTCadastro: Boolean;
    blnSuspendeuGnre: Boolean;
    strOpeLib: String;
    horLib: TTime;
    blnGravouNota: Boolean;
begin
  inherited;
  Try
    strOpeLib := '';
    horLib := 0;
    blnGravouNota := True;
    If (Not blnAuditoria) And (Not blnReprocessa) And (Not (finalidadeXML = xmlRetornoSimbolico)) Then
    Begin
      If blnExibirCriticasEFcidivergenteAoConfirmarImportacao Then
      Begin
         pExibirDadosAposImportacao;
         blnExibirCriticasEFcidivergenteAoConfirmarImportacao := False;
      End;
    End;
    blnCSTCadastro := False;

    If stlListSelecao.Count = 0 Then
    Begin
      fMensagem('','Nenhum arquivo foi selecionado para importação!', ['&Ok']);
    End

    Else If (finalidadeXML = xmlConsertoEquipamento) And (stlListSelecao.Count > 1) Then
    Begin
      fMensagem('','Somente 1 arquivo por vez pode ser selecionado para importação!', ['&OK']);
      pDesmarcaTodos();
    End

    Else If fProcessar Then
    Begin
      blnPreGnre := False;

      Try
        If not blnAuditoria Then
        Begin
          blnReprocessa := False;
          blnPreGnre := False;

          If Assigned(cdsDiverg) Then
            cdsDiverg.Filtered := False;

          If Assigned(cdsDiverg) And (Not cdsDiverg.IsEmpty) Then
          Begin
            pExcluiDesmarcados;

            cdsDiverg.Filter   := 'MOSTRA = ' + QuotedStr('S');
            cdsDiverg.Filtered := True;

            If fAbrirTelaDivergenciasNfe Then
            Begin
              If (Not cdsDiverg.IsEmpty) Then
              Begin
                Try
                  pCriarFormularios(TfrmEntNFEDivergencias, frmEntNFEDivergencias);

                  frmEntNFEDivergencias.rdgCSTCad.Visible := fRetDivCST;

                  cdsDiverg.IndexFieldNames := 'FORNEC;NUMDOC;DESITE;CODITE;BASICM';

                  objValidaNFeCapa.pSetaValoresCorrigidos(TUniClientDataSet(cdsDiverg));

                  frmEntNFEDivergencias.cxgItensView.DataController.DataSource := cdsDiverg.dtsSource;

                  frmEntNFEDivergencias.blnBloqueiaNFE := frmEntNFEDivergencias.fCalculaBloqueio;

                  cdsDiverg.IndexFieldNames := 'FORNEC;NUMDOC;DESITE;CODITE;ELETRO';
                  frmEntNFEDivergencias.cxgItensView.DataController.DataSource := cdsDiverg.dtsSource;

                  if (fCfgSis('XMLVAL', varInteger) = 1) Then
                  Begin
                    If frmEntNFEDivergencias.rdgCSTCad.Visible Or
                       frmEntNFEDivergencias.blnBloqueiaNFE Or
                      (Not fCfgSis('PASAMA', VarBoolean)) Then
                    Begin
                      frmEntNFEDivergencias.ShowModal;

                      blnReprocessa := frmEntNFEDivergencias.blnReprocessar;

                      blnConfirma    := frmEntNFEDivergencias.blnConfirma;

                      blnCSTCadastro := frmEntNFEDivergencias.rdgCSTCad.ItemIndex = 1;
                      If blnConfirma And (finalidadeXML <> xmlDevolucaoEntradaEmitidaFornecedor) Then
                      Begin
                        blnPreGnre := frmEntNFEDivergencias.fPreparaGNRE(blnSuspendeuGnre);
                        blnConfirma := Not blnSuspendeuGnre;
                      End;
                      strOpeLib := frmEntNFEDivergencias.strOpeLib;
                      horLib := frmEntNFEDivergencias.HoraLiberacao;
                    End

                    Else blnConfirma := True;
                  End
                  Else
                    blnConfirma := True;

                Finally
                  FreeAndNil(frmEntNFEDivergencias);
                end;

                If blnReprocessa Then
                  Exit;

                If Not blnConfirma Then
                  Exit;
              End;
            End;
          End;
        End;

        Screen.Cursor := crHourGlass;

        For intSelec := 0 To stlListSelecao.Count -1 Do
        Begin
          intIndex := stlNotaImportadas.IndexOf(stlListSelecao[intSelec]);

          If intIndex >= 0 Then
            With TNFeXml(stlNotaImportadas.Objects[intIndex]) Do
            Begin

              {Valida somente quando o cliente for informado!}
              If Not fEmptyStr(strCodCli) Then
              Begin

                If (finalidadeXML = xmlConsertoEquipamento) And (String(recDadosNota.GER_CODCLI) <> strCodCli) Then Begin
                  fMensagem('ATENÇÃO!', 'Cliente informado na O.S. é diferente do cliente encontrado na importação do XML. Operação cancelada!', ['&OK']);
                  Exit;
                End;

                If (finalidadeXML = xmlGarantiaRecCliente)  and (String(recDadosNota.GER_CODCLI) <> strCodCli) Then Begin
                  fMensagem('ATENÇÃO!', 'Cliente informado na garantia é diferente do cliente encontrado na importação do XML. Operação cancelada!', ['&OK']);
                  Exit;
                End;

              End;

              If Assigned(cdsDiverg) and (fCfgSis('XMLVAL', varInteger) = 2) Then
              Begin
                Try

                  pCriarFormularios(TfrmEntNFEDivergencias, frmEntNFEDivergencias);

                  cdsDiverg.Filter   := 'NUMDOC = ' + QuotedStr(String(recDadosNota.B08_NNF)) + ' AND CODFOR = ' + QuotedStr(String(recDadosNota.GER_CODFOR));
                  cdsDiverg.Filtered := True;
                  cdsDiverg.First;
                  cdsDiverg.IndexFieldNames := 'FORNEC;NUMDOC;DESITE;CODITE;ELETRO';

                  objValidaNFeCapa.pSetaValoresCorrigidos(TUniClientDataSet(cdsDiverg));

                  frmEntNFEDivergencias.cxgItensView.DataController.DataSource := cdsDiverg.dtsSource;

                  frmEntNFEDivergencias.blnBloqueiaNFE := frmEntNFEDivergencias.fCalculaBloqueio;
                  strOpeLib := frmEntNFEDivergencias.strOpeLib;
                  horLib := frmEntNFEDivergencias.HoraLiberacao;

                  if frmEntNFEDivergencias.blnBloqueiaNFE Then
                  Begin
                    If fGravarXmlDivergente() Then
                      fRenomearArquivo;
                  End
                  Else
                  Begin
                    blnGravouNota := fGravarNotaFiscal(blnCSTCadastro, intIndex, blnPreGnre, cdsDiverg, strOpeLib, horLib);
                    if blnGravouNota Then
                    begin
                      fRenomearArquivo;
                    end;
                  End;

                Finally
                  cdsDiverg.Filtered := False;
                  cdsDiverg.Filter   := '';
                  cdsDiverg.First;
                  FreeAndNil(frmEntNFEDivergencias);
                End;

              End
              Else
              Begin
                blnGravouNota := fGravarNotaFiscal(blnCSTCadastro, intIndex, blnPreGnre, cdsDiverg, strOpeLib, horLib);
                If blnGravouNota Then
                Begin
                  fRenomearArquivo;
                End;
              End;
            End;
        End;

      Except
        On E: Exception Do
          pMensagensErro(E.Message, '');
      End;

      Screen.Cursor := crDefault;
      pnlInfo.Caption := '';
      pgbProgresso.Position := 0;

      fraPathXmledtDirectoryChange(nil);

      pCancela;

      If (blnFecharAoImportar) then
        Close();

      If blnGravouNota Then
        ModalResult := MrOk
      Else
        pgcInformacoes.ActivePage := tbsLogErr;

    End;
  Finally
    While blnReprocessa do
    Begin
       fValidaCampos(fraPathXml.edtDirectory, True);
       btnImportaClick(Sender);
    end;

    If finalidadeXML = xmlRetornoSimbolico Then
      Close;

  End;
end;
procedure TfrmEntImportacaoNotaEletronica.btnRelErrClick(Sender: TObject);
begin
  inherited;
  pMostraErros;
end;

procedure TfrmEntImportacaoNotaEletronica.btnSairClick(Sender: TObject);
begin
  pCancela(True);
end;

procedure TfrmEntImportacaoNotaEletronica.cdsIteForAfterInsert(
  DataSet: TDataSet);
begin
  inherited;
  If DataSet.Tag = 0 Then DataSet.Cancel;
end;

procedure TfrmEntImportacaoNotaEletronica.pAtualizarDigitacao(varValorNovo, varValorAntigo: Variant; strCodItf: String);
begin
  inherited;
  If (Not fEmptyStr(varValorAntigo)) Then
    objDigitacao.Values[varValorAntigo] := EmptyStr;
  if Not fEmptyStr(varValorNovo) Then
    objDigitacao.Values[varValorNovo] := strCodItf;
End;

procedure TfrmEntImportacaoNotaEletronica.cdsIteForBeforePost(
  DataSet: TDataSet);

  function fItemJaRelacionado: Boolean;
  begin
    With DataSet Do
      Result := fCampoTabela('COUNT(*)', 'ITEFOR',
                            ['ITE_CODITE', 'ITE_CODFOR'],
                            [FieldByName('ITE_CODITE').AsString, FieldByName('ITE_CODFOR').AsString]) > 0;
  End;
Var
  strAuto : String;
  strItem: String;
  objCodBar : TIteBar;
  strCodItf: String;
  strCodIte,
  strCodfor,
  strTabelaAtual,
  strCodFabricaAtual,
  strCodItfAtual,
  strAutIncITEFOR,
  strDesIte: String;
  blnResult: Boolean;
begin
  inherited;

  strCodItf := cdsIteForITE_CODITF.AsString;
  strCodItfAtual := cdsIteForITE_CODITF.AsString;
  strCodIte := cdsIteForITE_CODITE.AsString;
  If fTemDuplicidadeIteForDigitacao(strCodIte, strCodItf) Then
  Begin
    fMensagem('ATENÇÃO!', 'Código do produto '+ strCodIte + ' já informado no item ' + strCodItf + ' do fornecedor!', ['OK']);
    cdsIteFor.Cancel;
    Abort;
  End;

  pAtualizarDigitacao(cdsIteForITE_CODITE.AsString, cdsIteForITE_CODITEANT.AsString,
      cdsIteForITE_CODITF.AsString);

  If cdsIteForITE_CODITEANT.AsString <> cdsIteForITE_CODITE.AsString Then
    cdsIteForITE_CODITEANT.AsString := cdsIteForITE_CODITE.AsString;

  objCodBar := TIteBar.Create(opcOperacoes);

  With DataSet Do
  Begin
    If (Not fEmptyStr(FieldByName('ITE_CODITE').AsString)) Then
    Begin
      If (fEmptyStr(fRetNomProduto(FieldByName('ITE_CODITE').AsString))) Then
      Begin
        fMensagem('', 'Nenhum produto cadastrado com o código (' + FieldByName('ITE_CODITE').AsString + ')!', ['&Ok']);
        Cancel;
        Abort;
      End
      Else
      If not fValidaVinculo(FieldByName('ITE_CODITE').AsString, strAuto) Then
      Begin
        Cancel;
        Abort;
      End

      Else If Not objCodBar.fValidaCodigoBarras(FieldByName('ITE_CODBAR').AsString,
                                               FieldByName('ITE_CODITE').AsString, strItem) Then
      Begin
        Cancel;
        fMensagem('ATENÇÃO!', 'Código de Barras ' + FieldByName('ITE_CODBAR').AsString + ' já cadastrado para o item ' + strItem + '!', ['&Ok']);
        Abort;
      End

      Else
        If (fCfgSis('FLUPDC', varBoolean)) And
           (fVerificaForConsumo(cdsIteFor.FieldByName('ITE_CODFOR').AsString)) And
           (Not fVerificaProConsumo(strCodIte)) Then
      Begin
        Cancel;
        fMensagem('ATENÇÃO!', 'Permitido apenas materiais de consumo para esse fornecedor!', ['&Ok']);
        Abort;
      End


{     Else If fItemJaRelacionado Then
      Begin
        fMensagem('', 'Este produto já foi relacionado à este fornecedor!', ['&Ok']);
        Cancel;
        Abort;
      End}

      Else If (fItemComTabelaAtiva(FieldByName('ITE_CODITE').AsString,FieldByName('ITE_CODFOR').AsString, strTabelaAtual, strCodFabricaAtual, strAutIncITEFOR)) And
              (Not (finalidadeXML in [xmlGarantiaRecCliente, xmlConsignacaoDevolucaoCliente, xmlRetornoLocacao])) Then
      Begin
        strCodIte := FieldByName('ITE_CODITE').AsString;
        strCodfor := FieldByName('ITE_CODFOR').AsString;
        strDesIte := fRetNomProduto(FieldByName('ITE_CODITE').AsString);

        { incluir função para pegar o código de fábrica atual }


        blnResult := (fMensagem('', 'Esse item: ' + strCodIte +'-'+ strDesIte + #13#10 +
                                    'Consta em uma tabela ativa do fornecedor: ' +  strCodFor + #13#10 +
                                    'Tabela ativa: ' +  strTabelaAtual + #13#10 +
                                    'Com o código de fábrica: '+ strCodFabricaAtual   + #13#10 +
                                    'gostaria de atualizar para o atual códgio de fábrica: ' + strCodItfAtual
                                    ,['&Sim', '&Não'] ) = 1);
        If blnResult Then
        Begin
          cdsIteForITE_ATUALIZATABELAITEFOR.asInteger := 1;
          cdsIteForAutIncITEFOR.AsString := strAutIncITEFOR;
          FieldByName('ITE_DESITE').AsString := fRetNomProduto(FieldByName('ITE_CODITE').AsString);
          FieldByName('ITE_CODFAB').AsString := fRetCodFabrica(FieldByName('ITE_CODITE').AsString);
          If blnExiApl Then
            FieldByName('ITE_APLICA').AsString := fRetAplicaProd(FieldByName('ITE_CODITE').AsString);
        End
        Else
        Begin
          cdsIteForITE_ATUALIZATABELAITEFOR.asInteger := 0;
          cdsIteFor.Cancel;
          Abort;
        End;
      End
      Else
      Begin
          FieldByName('ITE_DESITE').AsString := fRetNomProduto(FieldByName('ITE_CODITE').AsString);
          FieldByName('ITE_CODFAB').AsString := fRetCodFabrica(FieldByName('ITE_CODITE').AsString);
          If blnExiApl Then
            FieldByName('ITE_APLICA').AsString := fRetAplicaProd(FieldByName('ITE_CODITE').AsString);
      End;
    End
    Else
    Begin
      FieldByName('ITE_DESITE').Clear;
      FieldByName('ITE_CODFAB').Clear;
      FieldByName('ITE_APLICA').Clear;
    End;
  End;
  FreeAndNil(objCodBar);
End;

procedure TfrmEntImportacaoNotaEletronica.dbgConsultaEnter(Sender: TObject);
begin
  inherited;
  pnlInfo.Caption := 'Pressione [Enter] para selecionar o documento';
end;

procedure TfrmEntImportacaoNotaEletronica.dbgConsultaExit(Sender: TObject);
begin
  inherited;
  pnlInfo.Caption := '';
end;

procedure TfrmEntImportacaoNotaEletronica.dbgIteForEnter(Sender: TObject);
begin
  inherited;
  dbgIteFor.SelectedField := cdsIteForITE_CODITE;
end;

function TfrmEntImportacaoNotaEletronica.fValidaVinculo(strCodIte: String; Var strAutoincrem : String; blnDialog : Boolean = True) : Boolean;
  Var
    qryCodFab : TUniQuery;
Begin
  try
    qryCodFab := fCriaQuery(Self);
    With qryCodFab, Sql Do
    Begin
      if finalidadeXML in [xmlGarantiaRecCliente, xmlConsignacaoDevolucaoCliente] then
      begin
        Add('SELECT SQL_NO_CACHE        ');
        Add('       ITE_CODITC,         ');
        Add('       AUTOINCREM          ');
        Add('FROM ITECLI                ');
        Add('WHERE ITE_CODCLI = :CODCLI ');
        Add('  AND ITE_CODITE = :CODITE ');

        ParamByName('CODCLI').AsString := cdsIteFor.FieldByName('ITE_CODFOR').AsString;
      end
      Else If finalidadeXML in [xmlRetornoLocacao] Then
      Begin
        qryCodFab.SQL.Add('SELECT SQL_NO_CACHE        ' +
                          '       ITE_CODITC,         ' +
                          '       AUTOINCREM          ' +
                          'FROM ITECLI                ' +
                          'WHERE ITE_CODCLI = :CODCLI ' +
                          '  AND ITE_CODITE = :CODITE ' +
                          '  AND ITE_DESCRI = :DESCRI ');

        qryCodFab.ParamByName('CODCLI').AsString := cdsIteFor.FieldByName('ITE_CODFOR').AsString;
        qryCodFab.ParamByName('DESCRI').AsString := cdsIteFor.FieldByName('ITE_DESITE').AsString;
      End
      else
      begin
        Add('SELECT SQL_NO_CACHE        ');
        Add('       ITE_CODITF,         ');
        Add('       AUTOINCREM          ');
        Add('FROM ITEFOR                ');
        Add('WHERE ITE_CODFOR = :CODFOR ');
        Add('  AND ITE_CODITE = :CODITE ');

        ParamByName('CODFOR').AsString := cdsIteFor.FieldByName('ITE_CODFOR').AsString;
      end;

      ParamByName('CODITE').AsString := strCodIte;

      If (blnIItFor Or blnTabPrf) Then
      Begin
        Result := True;
        Exit;
      End;

      Open;

      strAutoincrem := '';
      if not IsEmpty then
      Begin
        strAutoincrem := FieldByName('AUTOINCREM').AsString;

        if finalidadeXML in [xmlGarantiaRecCliente, xmlConsignacaoDevolucaoCliente, xmlRetornoLocacao] then
          Result := True
        else
        begin
          if blnDialog then
            Result := (fMensagem('', 'O Seguinte Código de Fabrica ' + FieldByName('ITE_CODITF').AsString +
                                     ', está vinculado para o Item Selecionado.' + #13#10 +
                                     'Deseja Atualizar o Código de Fábrica para: ' + cdsIteFor.FieldByName('ITE_CODITF').AsString + '?',
                                     ['&Sim', '&Não'] ) = 1)
          Else
            Result := False;
        end;

      End
      Else
        Result := True;
    End;

  Finally
    FreeAndNil(qryCodFab)
  end;

End;

function TfrmEntImportacaoNotaEletronica.fVerificaForConsumo(
  strCodFor: String): boolean;
  Var
    qryForCon: TUniQuery;
begin
  Result := False;

  Try
    qryForCon := fCriaQuery(Self);
    With qryForCon, Sql Do
    Begin
      Add('SELECT *                   ');
      Add('FROM CADFOR                ');
      Add('WHERE FOR_CODFOR = :CODFOR ');
      Add('  AND FOR_MATREV = "M"     ');

      ParamByName('CODFOR').AsString := strCodFor;

      Open;

      If (Not IsEmpty) Then
        Result := True;
    End;
  Finally
    FreeAndNil(qryForCon);
  End;
end;

function TfrmEntImportacaoNotaEletronica.fVerificaProConsumo(
  strCodIte: String): boolean;
  Var
    qryProCon: TUniQuery;
begin
  Result := False;

  Try
    qryProCon := fCriaQuery(Self);
    With qryProCon, Sql Do
    Begin
      Add('SELECT *                   ');
      Add('FROM ITEGER                ');
      Add('WHERE ITE_CODITE = :CODITE ');
      Add('  AND ITE_CODEMP = :CODEMP ');
      Add('  AND ITE_TIPPRO = "07"    '); //ITE_TIPPRO = 07 - material de consumo

      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('CODEMP').AsString := VS_strCodEmp;

      Open;

      If (Not IsEmpty) Then
        Result := True;
    End;
  Finally
    FreeAndNil(qryProCon);
  End;

end;

procedure TfrmEntImportacaoNotaEletronica.dbgIteForKeyPress(Sender: TObject;
  var Key: Char);
  Var
    qryConIte: TUniQuery;
    strNomFormAnt: String;
    arrSel : TConsultasArray;
begin
  inherited;

  If cdsIteFor.IsEmpty Then
    Exit;

  strNomFormAnt := Self.Name;

  If fEntraCons(Key) And (dbgIteFor.SelectedField = cdsIteForITE_CODITE) Then
  Begin

    Try
      qryConIte := fCriaQuery(Self);

      Self.Name := 'frmFatVendas1';

      If fPesqItem(conIteSimples, Self, nil, nil, qryConIte, Key, arrSel, True, nil, 'Consulta de Itens',
                   '1', '', 0, False, False, 0, cdrCodIte, '', False, '', '', True, False, False) then
      Begin
        If (Not (fEmptyStr(qryConIte.FieldByName('ITE_CODITE').AsString))) and
           (Not fTemDuplicidadeIteFor(qryConIte.FieldByName('ITE_CODITE').AsString,
                                 cdsIteFor.FieldByName('ITE_CODITF').AsString,
                                 cdsIteForITE_CODFOR.AsString)) Then
        Begin

          If Not (cdsIteFor.State In dsEditModes) Then
            cdsIteFor.Edit;

          cdsIteFor.FieldByName('ITE_CODITE').AsString := qryConIte.FieldByName('ITE_CODITE').AsString;

          cdsIteFor.Post;
        End;
      End;

      FreeAndNil(qryConIte);

    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[]');
    End;

    Self.Name := strNomFormAnt;
  End;

  If (Key = #13) and (cdsIteFor.State In [dsEdit, dsInsert]) Then
  Begin
    If (Not (fEmptyStr(cdsIteFor.FieldByName('ITE_CODITE').AsString))) and
       (fTemDuplicidadeIteFor(cdsIteFor.FieldByName('ITE_CODITE').AsString,
                              cdsIteFor.FieldByName('ITE_CODITF').AsString,
                              cdsIteForITE_CODFOR.AsString))  Then
       cdsIteFor.Cancel
    Else
    Begin
      cdsIteFor.Post;
      cdsIteFor.Next;
    End;
  End;
end;

function TfrmEntImportacaoNotaEletronica.fTemDuplicidadeIteForDigitacao(strCodIte: String; var strCodItf: String): Boolean;
Begin
  result :=
    (fCfgSis('TABPRF', varBoolean))
    And (Not fEmptyStr(strCodItf))
    And (Not fEmptyStr(objDigitacao.Values[strCodIte]))
    And (objDigitacao.Values[strCodIte] <> strCodItf);
  strCodItf := objDigitacao.Values[strCodIte];
End;

procedure TfrmEntImportacaoNotaEletronica.OnAcept(Sender: TObject);
begin
  inherited ;
  If fValidaCampos(fraPathXml.edtDirectory) Then
    pSetFocus(dbgConsulta);
end;

procedure TfrmEntImportacaoNotaEletronica.edtChaveAcessoKeyPress(
  Sender: TObject; var Key: Char);
  var
    strXML: TStringList;
    strChave: string;
    PosIni: integer;
    enmStatusSefaz: TStatusNFeXml;
begin
  inherited;
  If key = #13 Then
  Begin
    strChave := AnsiReplaceStr(edtChaveAcesso.Text, '-', '');
    if not fEmptyStr(strChave) Then
    Begin
      Try
        If Not(Length(Trim(strChave)) = 44) Then
        Begin
          fMensagem('Atenção!', 'O tamanho da chave de acesso informado esta errado. Tamanho esperado é de 44 caracteres', ['OK']);
          Exit;
        End;


        if cklArqXML.Items.IndexOf(strChave + '_IMPORTADO_FIT.xml') > -1 Then
        Begin
          fMensagem('Atenção!', 'O documento já foi inserido anteriormente', ['OK']);
          Exit;
        End;

        If blnValidaXMLSefaz Then
        Begin
          enmStatusSefaz := TNFeXml.fGetStatusXML(strChave, VS_strCodEmp);
          If enmStatusSefaz = stXMLCancelada Then
          Begin
            fMensagem('Atenção!', 'O documento: '+strChave+' está CANCELADO/DENEGADO/INUTILIZADO no SEFAZ!', ['OK']);
            Exit;
          End
          Else If enmStatusSefaz = stXMLIndefinido Then
          Begin
            fMensagem('Atenção!', 'Não foi possível verificar o status do documento: '+strChave+'!', ['OK']);
            Exit;
          End;
        end;

        strXML := TStringList.Create;
        strXML.Text := fXMLNFELibNfe(VS_strCodEmp, strChave);

        strXML.Text := String(AnsiString(strXML.Text));
        strXML.Text := StringReplace(strXML.Text, string('Ã‚Â '), '', [rfReplaceAll]);
        strXML.Text := StringReplace(strXML.Text, string('Â '), '', [rfReplaceAll]);
        strXML.Text := StringReplace(strXML.Text, string(' '), '', [rfReplaceAll]);

        strXML.Text :=  fTiraCaracEspeciais(strXML.Text, False, False, False, False, False, True, True, '¿');

        PosIni := Pos('<procEventoNFe', strXML.Text);
        If PosIni > 0 then
          strXML.Text := Copy(strXML.Text, 0, (PosIni-1));

        (*
        If strXML.Count > 1 Then
        Begin
          For i := strXML.Count -1 DownTo 0 Do
          Begin
            If Pos('xmlns="http://www.portalfiscal.inf.br/nfe"', strXML.Strings[i]) = 0 Then
              strXML.Delete(i);
          End;
        End;
        *)
        If Pos('xmlns="http://www.portalfiscal.inf.br/nfe"', strXML.Text) > 0 Then
        Begin

          strPatFit := fraPathXml.edtDirectory.Text;

          If Not AnsiEndsStr('\', strPatFit) Then
            strPatFit := strPatFit + '\';

          //strXML.SaveToFile(strPatFit + strChave + '_IMPORTADO_FIT.xml');
          strXML.SaveToFile(strPatFit + strChave + '_IMPORTADO_FIT.xml', TEncoding.UTF8);

          cklArqXML.Items.Add(strChave + '_IMPORTADO_FIT.xml');
          cklArqXML.Checked[cklArqXML.Items.Count - 1] := fImportaArquivo(strPatFit + strChave + '_IMPORTADO_FIT.xml', strChave + '_IMPORTADO_FIT.xml');
          pgcInformacoes.ActivePageIndex := 0;
          blnExibirCriticasEFcidivergenteAoConfirmarImportacao := True;
        End
        Else
          fMensagem('Retorno do Serviço FIT: ', strXML.Text, ['OK']);
      Finally
        edtChaveAcesso.Clear;
        FreeAndNil(strXML);
        pSetFocus(edtChaveAcesso);
      End;
    End;
  End;
end;

procedure TfrmEntImportacaoNotaEletronica.pExibirDadosAposImportacao;
begin
  If finalidadeXML = xmlRetornoSimbolico Then
    Exit;

  If cdsConsulta.IsEmpty Then
    fMensagem('ATENÇÃO!', 'Nenhum arquivo foi importado!', ['&Ok'])
  Else If not frmListaProdutosFCIDivergenteNFE.cdsConsulta.IsEmpty then
  Begin
    frmListaProdutosFCIDivergenteNFE.Showmodal;
    frmListaProdutosFCIDivergenteNFE.cdsConsulta.EmptyDataSet;
  End;

  If (blnValidaXMLSefaz) And
     ((Not frmLogImportacaoNotaEletronica.cdsCancelados.IsEmpty) Or
      (Not frmLogImportacaoNotaEletronica.cdsXMLCancelamento.IsEmpty) Or
      (Not frmLogImportacaoNotaEletronica.cdsDevolucoes.IsEmpty)) Then
  Begin
    frmLogImportacaoNotaEletronica.Showmodal;
  End;

  pMostraErros;

  TfrmFornecedorNaoImportado.fExibirFornecedoresNaoImportados(FCdsFornNaoEncontrado);
end;

function TfrmEntImportacaoNotaEletronica.fAbreConsulta(blnLike: Boolean): Boolean;
Begin
  Result := True;
End;

procedure TfrmEntImportacaoNotaEletronica.pCarregaArquivos;
Begin
  If finalidadeXML = xmlRetornoSimbolico Then
  Begin
    If Assigned(cxgProgresso_Ext) Then
      cxgProgresso_Ext.Visible := True;

    fCarregaArquivosPrg(cxgProgresso_Ext);

    If Assigned(cxgProgresso_Ext) Then
      cxgProgresso_Ext.Visible := False;
  End
  Else
    TfrmGravando.fExecuta(fCarregaArquivosPrg, frmGravandoNotas, 'Carregando notas...');
End;


Function TfrmEntImportacaoNotaEletronica.fCarregaArquivosPrg(cxgProgresso: TcxProgressBar): Boolean;
  Var
    intContador: Integer;
begin
  Result := False;
  TNFeXml.Agrupador := '';

  if cklArqXML.Count > 0 then
  begin
    If Assigned(cxgProgresso) Then
      cxgProgresso.Properties.Max := cklArqXML.Count;

    objLock.pDestravarTodos;

    pLimparDados;

    Screen.Cursor := crHourGlass;
    pnlInfo.Caption := 'Aguarde, Importando arquivos...';
    If Assigned(cdsDiverg) And (Not cdsDiverg.IsEmpty) Then
      cdsDiverg.EmptyDataSet;

    cdsClaIpiDivergente.EmptyDataSet;
    FCdsFornNaoEncontrado.EmptyDataSet;

    frmLogImportacaoNotaEletronica.cdsCancelados.EmptyDataSet;
    frmLogImportacaoNotaEletronica.cdsXMLCancelamento.EmptyDataSet;
    frmLogImportacaoNotaEletronica.cdsDevolucoes.EmptyDataSet;
    frmLogImportacaoNotaEletronica.cdsErros.EmptyDataSet;

    For intContador := 0 To cklArqXML.Count -1 Do
    Begin
      cklArqXML.Checked[intContador] := fImportaArquivo(fraPathXml.edtDirectory.Text + cklArqXML.Items[intContador], cklArqXML.Items[intContador]);
      If Assigned(cxgProgresso) Then
        cxgProgresso.Position := cxgProgresso.Position + 1;
      Application.ProcessMessages;
    End;

    If Not blnAuditoria Then
      If Not blnReprocessa Then
      begin
        objValidaNFeCapa.pValidarNotasFiscais;
        If objValidaNFeCapa.blnTemDivergencia Then
           objValidaNFeCapa.pAjustaDivergencias;
        pExibirDadosAposImportacao;
      End;
    pnlInfo.Caption := '';

    Screen.Cursor := crDefault;

    Result := True;
    If blnAuditoria Then
    Begin
      btnImporta.Click;
      TfrmNFEXMLAuditoria.pExibeAuditoria(TNFeXml.Agrupador);
    End;

    Application.ProcessMessages;
  end;
end;

function TfrmEntImportacaoNotaEletronica.fFornecedorAncora(strCodFor: string): Boolean;
var
  qryDados : TUniQuery;
begin
  Try
    qryDados := fCriaQuery(Self);
    qryDados.Sql.Text := ' SELECT FOR_ANCORA   '+
                         '   FROM CADFOR       '+
                         '  WHERE FOR_CODFOR = '  + QuotedStr(strCodFor);
    qryDados.Open;

    Result := qryDados.FieldByName('FOR_ANCORA').AsString = 'S';

  Finally
    FreeAndNil(qryDados);
  End;
end;

function TfrmEntImportacaoNotaEletronica.fImportaArquivo(strArquivo, strNomeArquivo: string): boolean;
  var
    objEntNfeXml: TNFeXml;
    index: integer;

begin
  Result := False;

  objEntNfeXml := TNFeXml.Create(Self, True, finalidadeXML);
  objEntNfeXml.blnAuditoria := blnAuditoria;
  objEntNfeXml.objValidaNFeCapa := objValidaNFeCapa;
  objEntNfeXml.onLogErro := pLogErro;
  objEntNfeXml.OnGravando := pGravacao;
  objEntNfeXml.OnNaoEncontrouItem := pItemNaoEncontrado;
  objEntNfeXml.OnAlteraClaIPI := pAlteraClaIPI;
  objEntNfeXml.fLocalizarItemRetornoSimbolico := Self.fLocalizarItemRetornoSimbolico;

  objEntNfeXml.cdsDadosFornec := cdsDadosFornec;

  objEntNfeXml.frmGravandoNotas := frmGravandoNotas;

  If blnDirAcessCadFornecedor And (finalidadeXML in [xmlEntradaMercadoria, xmlGarantiaRetFornecedor,xmlEntradaMercadoriasSistemaAnteriorDevolucao, xmlRetornoSimbolico, xmlDevolucaoEntradaEmitidaFornecedor, xmlCFG_IMPXGRGarantiaRetFornecedor]) Then
    objEntNfeXml.OnFornecedorNaoEncontrado := pInsereCdsFornNaoEncontrado;
  If finalidadeXML = xmlRetornoSimbolico Then
    objEntNfeXml.cdsXML := cdsXML;
  If objEntNfeXml.fCarregarDoArquivo(strArquivo, cdsDiverg) Then
  Begin

    index := stlNotaImportadas.AddObject(strNomeArquivo, objEntNfeXml);
    //Marca o Numero do Index do Objeto no CDS De Divergencias
    If Not blnAuditoria then
      objValidaNFeCapa.pMarcaPosicaoNotaNaLista(
                       String(objEntNfeXml.recDadosNota.B08_NNF),
                       String(objEntNfeXml.recDadosNota.B07_SERIE),
                       DateToStr(objEntNfeXml.recDadosNota.B09_DEMI),
                       index);

    blnPodeIncluir := True;

    //Regra 1 - Nota Cancelada no Sefaz
    If blnValidaXMLSefaz And objEntNfeXml.blnXMLCancelado Then
    Begin
      frmLogImportacaoNotaEletronica.cdsCancelados.Append;
      frmLogImportacaoNotaEletronica.cdsCancelados.FieldByName('B08_NNF').AsString   := String(objEntNfeXml.recDadosNota.B08_NNF);
      frmLogImportacaoNotaEletronica.cdsCancelados.FieldByName('B07_SERIE').AsString := String(objEntNfeXml.recDadosNota.B07_SERIE);
      frmLogImportacaoNotaEletronica.cdsCancelados.FieldByName('C03_XNOME').AsString := String(objEntNfeXml.recDadosNota.GER_CODFOR+'-'+objEntNfeXml.recDadosNota.C03_XNOME);
      frmLogImportacaoNotaEletronica.cdsCancelados.FieldByName('NOMARQ').AsString    := strNomeArquivo;
      frmLogImportacaoNotaEletronica.cdsCancelados.FieldByName('STATUS').AsString    := 'Cancelado/Denegado/Inutilizado Sefaz';
      frmLogImportacaoNotaEletronica.cdsCancelados.Post;

      frmLogImportacaoNotaEletronica.cdsErros.Insert;
      frmLogImportacaoNotaEletronica.cdsErros.FieldByName('NOMARQ').AsString := strNomeArquivo;
      frmLogImportacaoNotaEletronica.cdsErros.FieldByName('NUMDOC').AsString := String(objEntNfeXml.recDadosNota.B08_NNF);
      frmLogImportacaoNotaEletronica.cdsErros.FieldByName('NSERIE').AsString := String(objEntNfeXml.recDadosNota.B07_SERIE);
      frmLogImportacaoNotaEletronica.cdsErros.FieldByName('MOTIVO').AsString := 'Cancelado/Denegado/Inutilizado';
      frmLogImportacaoNotaEletronica.cdsErros.Post;

      //renomear os cancelados
      blnRenomearXMLCancelado := True;
      objEntNfeXml.fRenomearArquivo(blnRenomearXMLCancelado, strNomeArquivo);
    End
    //Regra 2 - Nota com status Indefinido no Sefaz (erro de consulta, timeout, etc.)
    Else If blnValidaXMLSefaz And objEntNfeXml.blnXMLIndefinido Then
    Begin
      frmLogImportacaoNotaEletronica.cdsCancelados.Append;
      frmLogImportacaoNotaEletronica.cdsCancelados.FieldByName('B08_NNF').AsString   := String(objEntNfeXml.recDadosNota.B08_NNF);
      frmLogImportacaoNotaEletronica.cdsCancelados.FieldByName('B07_SERIE').AsString := String(objEntNfeXml.recDadosNota.B07_SERIE);
      frmLogImportacaoNotaEletronica.cdsCancelados.FieldByName('C03_XNOME').AsString := String(objEntNfeXml.recDadosNota.GER_CODFOR+'-'+objEntNfeXml.recDadosNota.C03_XNOME);
      frmLogImportacaoNotaEletronica.cdsCancelados.FieldByName('NOMARQ').AsString    := strNomeArquivo;
      frmLogImportacaoNotaEletronica.cdsCancelados.FieldByName('STATUS').AsString    := 'Sem Retorno';
      frmLogImportacaoNotaEletronica.cdsCancelados.Post;

      frmLogImportacaoNotaEletronica.cdsErros.Insert;
      frmLogImportacaoNotaEletronica.cdsErros.FieldByName('NOMARQ').AsString := strNomeArquivo;
      frmLogImportacaoNotaEletronica.cdsErros.FieldByName('NUMDOC').AsString := String(objEntNfeXml.recDadosNota.B08_NNF);
      frmLogImportacaoNotaEletronica.cdsErros.FieldByName('NSERIE').AsString := String(objEntNfeXml.recDadosNota.B07_SERIE);
      frmLogImportacaoNotaEletronica.cdsErros.FieldByName('MOTIVO').AsString := 'Indefinido Sefaz';
      frmLogImportacaoNotaEletronica.cdsErros.Post;
    End
    //Regra 3 - XML de Cancelamento de notas já importadas
    Else If blnValidaXMLSefaz And objEntNfeXml.blnXMLCancelamento Then
    Begin
      frmLogImportacaoNotaEletronica.cdsXMLCancelamento.Append;
      frmLogImportacaoNotaEletronica.cdsXMLCancelamento.FieldByName('DOCAUT').AsString := objEntNfeXml.strDocOriginalCanceladoXML;
      frmLogImportacaoNotaEletronica.cdsXMLCancelamento.FieldByName('NOMARQ').AsString := strNomeArquivo;
      frmLogImportacaoNotaEletronica.cdsXMLCancelamento.Post;

      frmLogImportacaoNotaEletronica.cdsErros.Insert;
      frmLogImportacaoNotaEletronica.cdsErros.FieldByName('NOMARQ').AsString := strNomeArquivo;
      frmLogImportacaoNotaEletronica.cdsErros.FieldByName('NUMDOC').AsString := objEntNfeXml.strDocOriginalCanceladoXML;
      frmLogImportacaoNotaEletronica.cdsErros.FieldByName('NSERIE').AsString := '';
      frmLogImportacaoNotaEletronica.cdsErros.FieldByName('MOTIVO').AsString := 'XML Nota de Cancelamento';
      frmLogImportacaoNotaEletronica.cdsErros.Post;
    End
    //Regra 4 - XML de Devolução sem entrada original
    Else If blnValidaXMLSefaz And objEntNfeXml.blnXmlDevolucaoSemEntrada Then
    Begin
      frmLogImportacaoNotaEletronica.cdsDevolucoes.Append;
      frmLogImportacaoNotaEletronica.cdsDevolucoes.FieldByName('DOCAUT').AsString := objEntNfeXml.strDocOriginalDevolucaoXML;
      frmLogImportacaoNotaEletronica.cdsDevolucoes.FieldByName('NOMARQ').AsString := strNomeArquivo;
      frmLogImportacaoNotaEletronica.cdsDevolucoes.Post;

      frmLogImportacaoNotaEletronica.cdsErros.Insert;
      frmLogImportacaoNotaEletronica.cdsErros.FieldByName('NOMARQ').AsString := strNomeArquivo;
      frmLogImportacaoNotaEletronica.cdsErros.FieldByName('NUMDOC').AsString := String(objEntNfeXml.recDadosNota.B08_NNF);
      frmLogImportacaoNotaEletronica.cdsErros.FieldByName('NSERIE').AsString := String(objEntNfeXml.recDadosNota.B07_SERIE);
      frmLogImportacaoNotaEletronica.cdsErros.FieldByName('MOTIVO').AsString := 'Nota Devolução Sem Entrada';
      frmLogImportacaoNotaEletronica.cdsErros.Post;
    End
    Else
    Begin
      cdsConsulta.Append;
      cdsConsulta.FieldByName('NOMARQ').AsString     := strNomeArquivo;
      cdsConsulta.FieldByName('B08_NNF').AsString    := String(objEntNfeXml.recDadosNota.B08_NNF);
      cdsConsulta.FieldByName('B07_SERIE').AsString  := String(objEntNfeXml.recDadosNota.B07_SERIE);
      cdsConsulta.FieldByName('C03_XNOME').AsString  := String(objEntNfeXml.recDadosNota.C03_XNOME);
      cdsConsulta.FieldByName('B09_DEMI').AsDateTime := objEntNfeXml.recDadosNota.B09_DEMI;
      cdsConsulta.FieldByName('GER_CODFOR').AsString := String(objEntNfeXml.recDadosNota.GER_CODFOR);
      cdsConsulta.FieldByName('DIV_CST').AsBoolean   := objEntNfeXml.blnDivCST;
      cdsConsulta.FieldByName('TIPOFOR').AsString    := fCarregaTipoFornecedor(string(objEntNfeXml.recDadosNota.GER_CODFOR));
      cdsConsulta.FieldByName('C12_UF').AsString     := String(objEntNfeXml.recDadosNota.C12_UF);

      If objEntNfeXml.DuplicatasCount > 0 Then
        cdsConsulta.FieldByName('VRDUPDIVCON').AsBoolean := RoundTo(objEntNfeXml.recDadosNota.vlrTotDupl, -2)  <> RoundTo(objEntNfeXml.recDadosNota.W16_VNF, -2)
      else
        cdsConsulta.FieldByName('VRDUPDIVCON').AsBoolean := False;

      If (String(objEntNfeXml.recDadosNota.B25_FINNFE) = '6') Or
         (String(objEntNfeXml.recDadosNota.B25_FINNFE) = '5') Then
        cdsConsulta.FieldByName('TIPAJUSTE').AsString := 'Sim'
      Else
        cdsConsulta.FieldByName('TIPAJUSTE').AsString := 'Não';

      cdsConsulta.Post;
      If blnAuditoria then
        pAddListaQuery;
      If finalidadeXML = xmlRetornoSimbolico Then
      begin
        blnShowMessage := False;
        pAddListaQuery;
        If cdsXML.Locate('ARQUIVO', strNomeArquivo, []) Then
        Begin
          cdsXML.Edit;
          cdsXML.FieldByName('CHAVE').AsString := objEntNfeXml.recDadosNota.PR07_CHNFE;
          cdsXML.FieldByName('DTAEMI').AsDateTime :=  objEntNfeXml.recDadosNota.B09_DEMI;
          cdsXML.FieldByName('NUMDOC').AsString :=   String(objEntNfeXml.recDadosNota.B08_NNF);
          cdsXML.FieldByName('VALDOC').AsFloat :=  objEntNfeXml.recDadosNota.W16_VNF;
          cdsXML.FieldByName('FORNEC').AsString :=  String(objEntNfeXml.recDadosNota.GER_CODFOR) + ' - ' + fRetNomFornecedor(String(objEntNfeXml.recDadosNota.GER_CODFOR));
          cdsXML.FieldByName('MARCADO').AsInteger := 0;
          If fEmptyStr(cdsXML.FieldByName('ERRO_STATUS_XML').AsString) Then
          Begin
            cdsXML.FieldByName('STATUS_XML').AsString := 'XML Importado Com Sucesso!';
            cdsXML.FieldByName('STATUS_ENT').AsString := '';
          End;
          cdsXML.Post;
        End;


      End;

      blnPodeIncluir := False;
      pInicializarRecNotEle(objEntNfeXml);
      Result := True;
    End
  End
  Else
    FreeAndNil(objEntNfeXml);

End;

procedure TfrmEntImportacaoNotaEletronica.pgcInformacoesChange(Sender: TObject);
begin
  inherited;
  If pgcInformacoes.ActivePage = tbsErrItens Then
    pSetFocus(dbgIteFor);
end;

procedure TfrmEntImportacaoNotaEletronica.pItemNaoEncontrado(strNumDoc,
                                                             strCodFor,
                                                             strCodIteF,
                                                             strDesIteF,
                                                             strEanPro,
                                                             strUnidade,
                                                             strCLAIPI,
                                                             strClaFis,
                                                             strCodCST,
                                                             strCdCEST,
                                                             strNUMFCI,
                                                             strEAN,
                                                             strEANTrib: String;
                                                             fltUnidadeFATUTR,
                                                             fltPRECOM,
                                                             fltFREENT,
                                                             fltPER_CI,
                                                             fltPerIPI,
                                                             fltPerICM,
                                                             fltSubist: Double;
                                                             strUf_For:  String);
  Var
    strNomCliFor: String;
begin
  if finalidadeXML in [xmlGarantiaRecCliente, xmlConsignacaoDevolucaoCliente] then
    strNomCliFor := fRetNomCliente(strCodFor)
  else
    strNomCliFor := fRetNomFornecedor(strCodFor);

  If finalidadeXML in [xmlRetornoLocacao] Then
  Begin
    If (Not fEmptyStr(strNomCliFor)) And
       (Not cdsIteFor.Locate('ITE_NUMDOC;ITE_CODFOR;ITE_CODITF;ITE_DESITF', VarArrayOf([strNumDoc, strCodFor, strCodIteF, strDesIteF]), [])) Then
    Begin
      cdsIteFor.Tag := 1;

      cdsIteFor.Append;

      cdsIteFor.FieldByName('ITE_NUMDOC').AsString := strNumDoc;
      cdsIteFor.FieldByName('ITE_CODFOR').AsString := strCodFor;
      cdsIteFor.FieldByName('ITE_NOMFOR').AsString := strNomCliFor;
      cdsIteFor.FieldByName('ITE_CODITF').AsString := strCodIteF;
      cdsIteFor.FieldByName('ITE_DESITF').AsString := strDesIteF;
      cdsIteFor.FieldByName('ITE_CODBAR').AsString := strEanPro;
      cdsIteFor.FieldByName('ITE_UNIDAD').AsString := strUnidade;
      cdsIteFor.FieldByName('ITE_UNITAR').AsFloat  := fltPRECOM;
      cdsIteFor.FieldByName('ITE_CLAIPI').AsString := strCLAIPI;
      cdsIteFor.FieldByName('ITE_CODSIT').AsString := strCodCst;
      cdsIteFor.FieldByName('ITE_CLAFIS').AsString := strClaFis;
      cdsIteFor.FieldByName('ITE_CDCEST').AsString := strCdCEST;

      cdsIteFor.FieldByName('ITE_NUMFCI').AsString := strNUMFCI;
      cdsIteFor.FieldByName('ITE_FATUTR').AsFloat  := fltUnidadeFATUTR;
      cdsIteFor.FieldByName('ITE_FREENT').AsFloat  := fltFREENT;
      cdsIteFor.FieldByName('ITE_PER_CI').AsFloat  := fltPER_CI;
      cdsIteFor.FieldByName('ITE_IPIENT').AsFloat  := fltPERIPI;
      cdsIteFor.FieldByName('ITE_ICMENT').AsFloat  := fltPERICM;
      cdsIteFor.FieldByName('ITE_SUBSTI').AsFloat  := fltSubist;
      cdsIteFor.FieldByName('C12_UF').AsString     := strUF_For;

      cdsIteFor.Post;

      cdsIteFor.Tag := 0;
    End;
  End
  Else
  Begin

    If (Not fEmptyStr(strNomCliFor)) And
       (Not cdsIteFor.Locate('ITE_NUMDOC;ITE_CODFOR;ITE_CODITF', VarArrayOf([strNumDoc, strCodFor, strCodIteF]), [])) Then
    Begin
      cdsIteFor.Tag := 1;

      cdsIteFor.Append;

      cdsIteFor.FieldByName('ITE_NUMDOC').AsString := strNumDoc;
      cdsIteFor.FieldByName('ITE_CODFOR').AsString := strCodFor;
      cdsIteFor.FieldByName('ITE_NOMFOR').AsString := strNomCliFor;
      cdsIteFor.FieldByName('ITE_CODITF').AsString := strCodIteF;
      cdsIteFor.FieldByName('ITE_DESITF').AsString := strDesIteF;
      cdsIteFor.FieldByName('ITE_CODBAR').AsString := strEanPro;
      cdsIteFor.FieldByName('ITE_UNIDAD').AsString := strUnidade;
      cdsIteFor.FieldByName('ITE_UNITAR').AsFloat  := fltPRECOM;
      cdsIteFor.FieldByName('ITE_CLAIPI').AsString := strCLAIPI;
      cdsIteFor.FieldByName('ITE_CODSIT').AsString := strCodCst;
      cdsIteFor.FieldByName('ITE_CLAFIS').AsString := strClaFis;
      cdsIteFor.FieldByName('ITE_CDCEST').AsString := strCdCEST;
      cdsIteFor.FieldByName('ITE_CDCEAN').AsString := strEAN;
      cdsIteFor.FieldByName('ITE_CDCEAT').AsString := strEANTrib;

      cdsIteFor.FieldByName('ITE_NUMFCI').AsString := strNUMFCI;
      cdsIteFor.FieldByName('ITE_FATUTR').AsFloat  := fltUnidadeFATUTR;
      cdsIteFor.FieldByName('ITE_FREENT').AsFloat  := fltFREENT;
      cdsIteFor.FieldByName('ITE_PER_CI').AsFloat  := fltPER_CI;
      cdsIteFor.FieldByName('ITE_IPIENT').AsFloat  := fltPERIPI;
      cdsIteFor.FieldByName('ITE_ICMENT').AsFloat  := fltPERICM;
      cdsIteFor.FieldByName('ITE_SUBSTI').AsFloat  := fltSubist;
      cdsIteFor.FieldByName('C12_UF').AsString     := strUF_For;

      cdsIteFor.Post;

      cdsIteFor.Tag := 0;
    End;
  End;

end;

procedure TfrmEntImportacaoNotaEletronica.pGravacao(strInformacao: String; intPosicao, intMaximo: Integer);
begin
  pnlInfo.Caption := strInformacao;
  pgbProgresso.Max := intMaximo;
  pgbProgresso.Position := intPosicao;
  Application.ProcessMessages;
End;

procedure TfrmEntImportacaoNotaEletronica.pLogErro(strNumDoc, strSerie, strNomArq, strMensagem: String);
begin
  With cdsErros Do
  Begin
    Insert;
    FieldByName('NOMARQ').AsString := strNomArq;
    FieldByName('NUMDOC').AsString := strNumDoc;
    FieldByName('NSERIE').AsString := strSerie;
    FieldByName('MOTIVO').AsString := strMensagem;
    Post;
  End;

  memLogErr.Lines.Add(fReplicatorStr('-', 200));
  memLogErr.Lines.Add(FormatDateTime('hh:mm:ss', fTime()));

  memLogErr.Lines.Add('DOCUMENTO: ' + strNumDoc);
  memLogErr.Lines.Add('ARQUIVO..: ' + strNomArq);

  memLogErr.Lines.Add(strMensagem);
  memLogErr.Lines.Add(fReplicatorStr('-', 200));

  Application.ProcessMessages;
end;

procedure TfrmEntImportacaoNotaEletronica.pMostraErros;
  Var
    strNomFil,
    strTipImp : String;
    frxReport : TfrxReport;
    fmvDetalhe: TfrxMemoView;
Begin
  If Not cdsErros.Active Then
    Exit;

  If cdsErros.IsEmpty Then
    Exit;

  pCarregaConfImpr(qryCfgRel, Self.Name);
  strNomFil := qryCfgRel.FieldByName('REL_NOMFIL').AsString;
  strTipImp := qryCfgRel.FieldByName('REL_IDEIMP').AsString;

  If strTipImp = 'M' Then
    frxReport := frxReportM
  Else
  Begin
    frxReport := frxReportJ;
    frxReport.DotMatrixReport           := False;
    frxReport.PrintOptions.PrintMode    := pmScale;
    frxReport.PrintOptions.PrintOnSheet := 9;

    fmvDetalhe := TfrxMemoView(frxReportJ.FindObject('mmoDetalhe'));
    If Assigned(fmvDetalhe) Then
    Begin
      Try
        fmvDetalhe.Highlight.Color := fCfgSis('CORZEB');
      Except
        fmvDetalhe.Highlight.Color := clWindow;
      End;
    End;
  End;

  // Reset do report antes de preparar — evita reutilizar referências RTTI
  // de execuções anteriores que possam apontar para controles em estado
  // inconsistente (causa do AV em TcxCustomEdit.IsTransparentBackground
  // durante SaveToStream interno do PrepareReport).
  frxReport.EngineOptions.DestroyForms := True;

  frxReport.Script.Variables['NOMEMP'] := fRetNomeEmpresa;

  If frxReport.PrepareReport(True) Then    // True = ClearLastReport
    pPreviewReport(Self.Name, Self.Caption, frxReport);
End;

procedure TfrmEntImportacaoNotaEletronica.ProcessarRetornoB2W;
begin
  blnSempreRelerBanco := FALSE;
  blnQuoteLista       := False;

  lflLastField.intIndCol := 0;
  lflLastField.strNomCam := dbgConsulta.Columns[0].FieldName;
  lflLastField.strNomCol := dbgConsulta.Columns[0].Title.Caption;
  lflLastField.ftyTipCam := ftString;

  pSetFocus(fraPathXml.edtDirectory);

  pgcInformacoes.ActivePage := tbsErrItens;

  fraPathXml.DefaultFolder := fraPathXml.edtDirectory.Text;

  If finalidadeXML = xmlRetornoSimbolico Then
    fValidaCampos(fraPathXml.edtDirectory);

  If (cdsIteFor.IsEmpty) And (FCdsFornNaoEncontrado.IsEmpty) And (stlListSelecao.Count > 0) Then
    btnImporta.Click;
end;

class function TfrmEntImportacaoNotaEletronica.fImportar(finalidadeXMLP : tpeFinalidadeXML;
                                                         strCodCliP : String = '';
                                                         blnFecharAoImportarP : Boolean = False;
                                                         strpathXML: string = '';
                                                         AcdsXML: TZClient = nil;
                                                         AcxgProgresso: TcxProgressBar = nil;
                                                         fLocalizarItemRetornoSimbolicoParam: TFunctionLocalizarItemRetornoSimbolico = nil): TRecInfoNotaEletronica;
  Var
    frmEntImportacao: TfrmEntImportacaoNotaEletronica;
begin
  pCriarFormularios(TfrmEntImportacaoNotaEletronica, frmEntImportacao);
  frmEntImportacao.blnAuditoria := False;
  If finalidadeXMLP = xmlEntradaMercadoriaAuditoria then
  begin
    finalidadeXMLP := xmlEntradaMercadoria;
    frmEntImportacao.blnAuditoria := True;
    frmEntImportacao.tbsErrItens.TabVisible := False;
    frmEntImportacao.pgcInformacoes.ActivePageIndex := 0;
    frmEntImportacao.tbsLogErr.Show;
    frmEntImportacao.pnlBotoes.Visible := False;
  End;

  With frmEntImportacao Do
  Begin
    fLocalizarItemRetornoSimbolico := fLocalizarItemRetornoSimbolicoParam;
    cxgProgresso_Ext := AcxgProgresso;
    strCodCli := strCodCliP;
    finalidadeXML := finalidadeXMLP;
    blnFecharAoImportar := blnFecharAoImportarP;
    frmEntImportacao.cdsXML := AcdsXML;
    If strpathXML <> '' Then
      frmEntImportacao.fraPathXml.edtDirectory.Text := strpathXML;

    If (finalidadeXML = xmlRetornoSimbolico) Then
      ProcessarRetornoB2W
    Else
      frmEntImportacao.ShowModal;

    If frmEntImportacao.ModalResult = MrOk Then
    Begin
      Result := recNotEle;
      Result.strErrors := '';
    End
    Else
    Begin
      FillChar(recNotEle, SizeOf(TRecInfoNotaEletronica), #0);
      Result := recNotEle;
      Result.strErrors := memLogErr.Text;
    End;

    FreeAndNIl(frmEntImportacao);
  End;

end;

function TfrmEntImportacaoNotaEletronica.fItemComTabelaAtiva(strCodIte,
  strCodFor: String; out strOutCodFabrica: String; out strOutCodFabricaAtual: String; out strOutCodAutIncITEFOR: String ): boolean;
Var
  objTabPre : TTabelaPreco;
  qryDados : TUniQuery;
  strCodTab : String;
begin
  strCodTab := '';
  strOutCodFabrica := '';
  strOutCodFabricaAtual := '';
  strOutCodAutIncITEFOR := '';

  If (Not fCfgSis('TABPRF', varBoolean)) Then
    Exit(False);

  If fEmptyStr(strCodIte) Or fEmptyStr(strCodFor) Then
    Exit(False);

  qryDados := fCriaQuery(Self);
  objTabPre := TTabelaPreco.Create(Self);
  Try

    strCodTab := objTabPre.fRetTabelaAtiva(strCodFor);

    If fEmptyStr(strCodTab) Then
      Exit(False);

    qryDados.Sql.Add(' SELECT ITEFOR.AUTOINCREM AS AUTINC, ITEFOR.ITE_CODITE, ITEFOR.ITE_CODFOR, IFNULL(ITEFOR.ITE_CODITF, CADITE.ITE_CODFAB) AS CODFAB, COUNT(1) AS QTD    ');
    qryDados.Sql.Add(' FROM                       ');
    qryDados.Sql.Add('  ITEFOR                    ');
    qryDados.Sql.Add('  INNER JOIN CADITE         ');
    qryDados.Sql.Add('     ON CADITE.ITE_CODITE = ITEFOR.ITE_CODITE  ');
    qryDados.Sql.Add(' WHERE ITEFOR.ITE_CODITE = :CODITE ');
    qryDados.Sql.Add('   AND ITEFOR.ITE_CODFOR = :CODFOR ');
    qryDados.Sql.Add('   AND ITEFOR.ITE_CODTAB = :CODTAB ');

    qryDados.paramByName('CODITE').AsString := strCodIte;
    qryDados.paramByName('CODFOR').AsString := strCodFor;
    qryDados.paramByName('CODTAB').AsString := strCodTab;

    qryDados.Close;
    qryDados.Open;

    Result := (qryDados.FieldByName('QTD').AsString > '0');

    If Result Then
    Begin
      strOutCodFabrica := strCodTab;
      strOutCodFabricaAtual := qryDados.FieldByName('CODFAB').AsString;
      strOutCodAutIncITEFOR := qryDados.FieldByName('AUTINC').AsString;
    End;

  Finally
    FreeAndNil(qryDados);
    FreeAndNil(objTabPre);
  End;


end;

procedure TfrmEntImportacaoNotaEletronica.pInicializarRecNotEle(
  objNfe: TNFeXml);
begin
  If (not (finalidadeXML in [xmlConsertoEquipamento, xmlGarantiaRecCliente])) Then
  Begin
    recNotEle.fltValFre := 0;
    recNotEle.fltValDes := 0;
    recNotEle.fltOutras := 0;
    recNotEle.dtaDtaDoc := 0;
    recNotEle.strAutInc := '';
    recNotEle.strNumDoc := '';
    recNotEle.strSerDoc := '';
    recNotEle.strCodFor := '';
    recNotEle.str_Chave := '';
    recNotEle.strCodCli := '';
    recNotEle.strTip_FC := '';
    recNotEle.strClaBri := '';
    recNotEle.fltPesBru := 0;
    recNotEle.strCodFor := String(objNfe.recDadosNota.GER_CODFOR);
    recNotEle.strCodCli := String(objNfe.recDadosNota.GER_CODCLI);
    recNotEle.strTip_FC := String(objNfe.recDadosNota.GER_TIP_FC);
    recNotEle.finalidadeXML := xmlConsertoEquipamento;
    recNotEle.strNumDoc := String(objNfe.recDadosNota.B08_NNF);
    recNotEle.strSerDoc := String(objNfe.recDadosNota.B07_SERIE);
    recNotEle.fltValFre := objNfe.recDadosNota.W08_VFRETE;

    If fConsideraICMSDesoneradoComDesconto(fCadEmp('ESTADO')) Then
      recNotEle.fltValDes := objNfe.recDadosNota.W10_VDESC +
            IIF((objNfe.recDadosNota.W07_VPROD + objNfe.recDadosNota.W18_VSERV + objNfe.recDadosNota.W06_VST + objNfe.recDadosNota.W08_VFRETE + objNfe.recDadosNota.W09_VSEG +
                 objNfe.recDadosNota.W12_VIPI + objNfe.recDadosNota.W15_VOUTRO + objNfe.recDadosNota.W06A_VFCPST - objNfe.recDadosNota.W10_VDESC) - objNfe.recDadosNota.W16_VNF > 0.5,
                 objNfe.recDadosNota.W04A_VICMSDESON, 0) {+ objNfe.recDadosNota.W06A_VFCPST //req 303332 }

    Else
      recNotEle.fltValDes := objNfe.recDadosNota.W10_VDESC;

    recNotEle.fltOutras := objNfe.recDadosNota.W15_VOUTRO;
    recNotEle.fltValSeg := objNfe.recDadosNota.W09_VSEG;
    recNotEle.dtaDtaDoc := objNfe.recDadosNota.B09_DEMI;
    recNotEle.str_Chave := objNfe.recDadosNota.PR07_CHNFE;
  End;
end;

Procedure TfrmEntImportacaoNotaEletronica.pInsereArquivosLista(strPath: String);
  Var
    srcArquivo: TSearchRec;
    intAchou  : Integer;
Begin
  If RightStr(strPath,1) <> '\' Then
    strPath := strPath + '\';

  With cklArqXML Do
  Try
    Clear;

    intAchou := FindFirst(strPath + '*.XML', faArchive, srcArquivo);

    if intAchou = 0 then
    begin

      repeat
        If finalidadeXML = xmlRetornoSimbolico Then
        Begin
          If cdsXML.Locate('ARQUIVO', srcArquivo.Name, []) Then
            cdsXML.Delete;
          cdsXML.Append;
          cdsXML.FieldByName('NOVOREG').AsInteger := 1; //Marcar o que foi carregado na importação caso ja esteja na gerele é zero
          cdsXML.FieldByName('ARQUIVO').AsString := srcArquivo.Name;
          cdsXML.FieldByName('STATUS_XML').AsString := 'Arquivo Importado';
          cdsXML.FieldByName('MARCADO').AsInteger := 0;
          cdsXML.Post;
        End;

        Items.Add(srcArquivo.Name);

      until FindNext(srcArquivo) <> 0;

      FindClose(srcArquivo);

    end;

    FindClose(srcArquivo);

  Except
    FindClose(srcArquivo);
  End;
End;

function TfrmEntImportacaoNotaEletronica.fTemArquivosPendentes(var AQtdFiles : Integer): Boolean;
var
  qryDados: TUniQuery;
begin
  qryDados := fCriaQuery(Self);
  try
    qryDados.SQL.Text :=
      ' SELECT COUNT(*) AS QTD FROM DFETER ' +
      ' WHERE  DFE_BAIXAD = "N" ' +
      '   AND  IFNULL(DFE_URLBKT,"") <> "" ';
    qryDados.Open;

    AQtdFiles := qryDados.FieldByName('QTD').AsInteger;
    Result    := AQtdFiles > 0;
  finally
    FreeAndNil(qryDados);
  end;
end;

function TfrmEntImportacaoNotaEletronica.fTemArquivosPendentes: Boolean;
var
  LQtd: Integer;
begin
  Result := fTemArquivosPendentes(LQtd);
end;

function TfrmEntImportacaoNotaEletronica.fTemDuplicidadeIteFor(strCodIte, strCodFab,  strCodFor: String): boolean;
  var
    strItem: String;
Begin
    Result := Not fValidaCodForFab(strCodFor, strCodFab, strCodIte, strItem);
    If Result Then
      fMensagem('Atenção','O Código de Fábrica [' + strCodFab + '] já esta sendo utilizado pelo fornecedor ['+ strCodFor +'] no item [' + strItem + ']', ['&Ok']);
End;



procedure TfrmEntImportacaoNotaEletronica.pInsereCdsFornNaoEncontrado(strCNPJ,
  strCPF, strXNOME, strXFANT, strXLGR, strNRO, strXCPL, strXBAIRRO, strCMUN,
  strXMUN, strUF, strCEP, strCPAIS, strXPAIS, strFONE, strIE, strIEST, strIM,
  strCNAE: String);
begin
  FCdsFornNaoEncontrado.Insert;
  FCdsFornNaoEncontrado.FieldByName('CNPJ').AsString    := strCNPJ;
  FCdsFornNaoEncontrado.FieldByName('CPF').AsString     := strCPF;
  FCdsFornNaoEncontrado.FieldByName('xNome').AsString   := strXNOME;
  FCdsFornNaoEncontrado.FieldByName('xFant').AsString   := strXFANT;
  FCdsFornNaoEncontrado.FieldByName('xLgr').AsString    := strXLGR;
  FCdsFornNaoEncontrado.FieldByName('nro').AsString     := strNRO;
  FCdsFornNaoEncontrado.FieldByName('xCpl').AsString    := strXCPL;
  FCdsFornNaoEncontrado.FieldByName('xBairro').AsString := strXBAIRRO;
  FCdsFornNaoEncontrado.FieldByName('cMun').AsString    := strCMUN;
  FCdsFornNaoEncontrado.FieldByName('xMun').AsString    := strXMUN;
  FCdsFornNaoEncontrado.FieldByName('UF').AsString      := strUF;
  FCdsFornNaoEncontrado.FieldByName('CEP').AsString     := strCEP;
  FCdsFornNaoEncontrado.FieldByName('cPais').AsString   := strCPAIS;
  FCdsFornNaoEncontrado.FieldByName('xPais').AsString   := strXPAIS;
  FCdsFornNaoEncontrado.FieldByName('fone').AsString    := strFONE;
  FCdsFornNaoEncontrado.FieldByName('IE').AsString      := strIE;
  FCdsFornNaoEncontrado.FieldByName('IEST').AsString    := strIEST;
  FCdsFornNaoEncontrado.FieldByName('IM').AsString      := strIM;
  FCdsFornNaoEncontrado.FieldByName('CNAE').AsString    := strCNAE;
  FCdsFornNaoEncontrado.Post;
end;


function TfrmEntImportacaoNotaEletronica.fValidaDivergenciaEntreValorContabileDuplicatas(objEntNfeXml: TNFeXml): Boolean;
  var
    strLinh: string;
    intPosIni, intContador: integer;
    strLetraAlfa : String;
Begin
  // VRDUPDIVCON = True  Se o valor for divergente
  // VRDUPDIVCON = False Se o valor for igual ou não exitir duplicatas
  If (cdsConsulta.FieldByName('VRDUPDIVCON').AsBoolean) Then
  Begin
    objLiberacao.clear;
    objLiberacao.objMsgLibera.pAddTexto('Total de títulos diferente do valor total da Nota Fiscal');
    objLiberacao.objMsgLibera.pAddSeparador(92);
    objLiberacao.objMsgLibera.pAddTextoCaption('Documento'    , string(objEntNfeXml.recDadosNota.B08_NNF) + ' -NF- ' + string(objEntNfeXml.recDadosNota.GER_CODEMP) + ' Série: ' + string(objEntNfeXml.recDadosNota.B07_SERIE));
    objLiberacao.objMsgLibera.pAddTextoCaption('Fornecedor'   , string(objEntNfeXml.recDadosNota.GER_CODFOR) + '-' + fRetNomFornecedor(String(objEntNfeXml.recDadosNota.GER_CODFOR)));
    objLiberacao.objMsgLibera.pAddTextoCaption('Dt.Documento' , DateToStr(objEntNfeXml.recDadosNota.B09_DEMI));
    objLiberacao.objMsgLibera.pAddSeparador(92);
    strLinh := StringOfChar(' ', 90);
    insert('Valor Contábil:  R$ ' + FormatFloat('#,##0.00', objEntNfeXml.recDadosNota.W16_VNF), strLinh, 0);
    insert('Total das Parcelas: ' + FormatFloat('#,##0.00', objEntNfeXml.recDadosNota.vlrTotDupl), strLinh,  45);
    objLiberacao.objMsgLibera.pAddTexto(strlinh);
    objLiberacao.objMsgLibera.pAddSeparador(92);
    objLiberacao.objMsgLibera.pAddTexto('Parcelas:');
    intContador := 0;
    While intContador < objEntNfeXml.DuplicatasCount do
    Begin
      strLetraAlfa := fGetLetraAlfa(intContador + 1);
      If (intContador Mod 2) = 0 Then
      Begin
         strLinh := stringOfChar(' ', 90);
         intPosIni:= 0;
      End
      Else
        intPosIni := 45;
      Insert('(' + strLetraAlfa + ') ' + DateToStr(objEntNfeXml.Duplicatas[intContador].Y09_DtaVen) +
       ' R$ ' + FormatFloat('#,##0.00', objEntNfeXml.Duplicatas[intContador].Y10_VlrDup), strLinh, intPosIni);

      If (intPosIni > 0) Or ((intContador + 1) = objEntNfeXml.DuplicatasCount) Then
        objLiberacao.objMsgLibera.pAddTexto(Copy(strlinh, 0 , 90));

      intContador := intContador + 1;
    End;
    objLiberacao.objMsgLibera.pAddSeparador(92);

    objLiberacao.strDirAce := 'VRENDU';
    objLiberacao.strMsgSen := 'Total de títulos diferente do valor total da Nota Fiscal';
    objLiberacao.blnMosMen := True;

    Result := objLiberacao.fLibera;
  end
  Else
    Result := True;
End;

procedure TfrmEntImportacaoNotaEletronica.btnCadastroDeProdutoClick(Sender: TObject);
Var strEANTRIB: String;
begin
  If (Not blnDirAcessCadItem) or (not btnCadastroDeProduto.Visible) Then
    Exit;

  If fEmptyStr(cdsIteFor.FieldByname('ITE_CODITE').AsString) Then
  Begin
    pCriarFormularios(TfrmCadProdutos, frmCadProdutos);
    Try
      frmCadProdutos.FormShow(Self);
      frmCadProdutos.btnIncluir.OnClick(frmCadProdutos.btnIncluir);

      frmCadProdutos.dbeCodFor.Field.Value := cdsIteFor.FieldByName('ITE_CODFOR').AsString;
      frmCadProdutos.dbeCodFab.Field.Value := cdsIteFor.FieldByName('ITE_CODITF').AsString;
      frmCadProdutos.dbeDesIte.Field.Value := cdsIteFor.FieldByName('ITE_DESITF').AsString;

      frmCadProdutos.dbeCodBar.Field.Value := cdsIteFor.FieldByName('ITE_CODBAR').AsString;

      If cdsIteFor.FieldByName('ITE_CODBAR').AsString <> '' Then
      Begin
        strEANTRIB := 'S';
        if Trim(cdsIteFor.FieldByName('ITE_CDCEAN').AsString) = Trim(cdsIteFor.FieldByName('ITE_CDCEAT').AsString) then
          strEANTRIB := 'N';

        frmCadProdutos.objIteBar.pIncluiCodigo(cdsIteFor.FieldByName('ITE_CODBAR').AsString,
                                               1,
                                               True, True, True,
                                               0, '', '', '', 0,0,0,0,0,0,0,0, False, '', strEANTRIB);
        frmCadProdutos.dbeBarEmb.Field.Value := cdsIteFor.FieldByName('ITE_CODBAR').AsString;
        frmCadProdutos.dbeEmbalagem.Field.Value := 1;
      End;
      frmCadProdutos.dbeUniCom.Field.Value := fCampoTabela('UNI_CODUNI', 'CADUNI', ['UNI_SIGUNI'], [cdsIteFor.FieldByName('ITE_UNIDAD').AsString]);
      If fEmptyStr(frmCadProdutos.dbeUniCom.Field.Value) Then
        frmCadProdutos.dbeUniCom.Field.Clear;
      frmCadProdutos.dbePreCom.Field.Value := cdsIteFor.FieldByName('ITE_UNITAR').AsFloat;
      frmCadProdutos.dbeClaIPI.Field.Value := cdsIteFor.FieldByName('ITE_CLAIPI').AsString;
      frmCadProdutos.dbeCdCest.Field.Value := cdsIteFor.FieldByName('ITE_CDCEST').AsString;
      frmCadProdutos.edtCestDesc.Text := fRetDesCDCEST(frmCadProdutos.dbeCDCEST.Text, frmCadProdutos.dbeClaIpi.Text);
      if fEmptyStr(frmCadProdutos.edtCestDesc.Text) then
        frmCadProdutos.dbeCdCest.Field.Clear;

         //fCampoTabela('CES_CDCEST', 'CDCEST', ['CES_CODNCM'], [cdsIteFor.FieldByName('ITE_CLAIPI').AsString]);
      frmCadProdutos.dbeNumFCI.Field.Value := cdsIteFor.FieldByName('ITE_NUMFCI').AsString;
      If frmCadProdutos.dbeFatUTr.Visible Then
         frmCadProdutos.dbeFatUTr.Field.Value := cdsIteFor.FieldByName('ITE_FATUTR').AsFloat;
      frmCadProdutos.dbePER_CI.Field.Value := cdsIteFor.FieldByName('ITE_PER_CI').AsFloat;

      If blnSimPau then
        frmCadProdutos.dbeIcmEnt.Field.Value := 0
      Else If fCfgSis('ATUICE' , varBoolean) Then
        frmCadProdutos.dbeIcmEnt.Field.Value := cdsIteFor.FieldByName('ITE_ICMENT').AsFloat;

       If fCfgSis('ATUSUB' , varBoolean) Then
         frmCadProdutos.dbeSubsti.Field.Value := cdsIteFor.FieldByName('ITE_SUBSTI').AsFloat;

       If FCfgSis('ATUIPI' , varBoolean) Then
         frmCadProdutos.dbeIPIENT.Field.Value := cdsIteFor.FieldByName('ITE_IPIENT').AsFloat;

       If FCfgSis('ATUFRE' , varBoolean) Then
         frmCadProdutos.dbeFreEnt.Field.Value := cdsIteFor.FieldByName('ITE_FREENT').AsFloat;
      frmCadProdutos.blnChamadaExterna := True;

      frmCadProdutos.pValidarPrecos(frmCadProdutos.dbePreCom);

      frmCadProdutos.pIniciaCadastroDeProdutosExterno();

      If Not fEmptyStr(frmCadProdutos.strCodIteExterno) Then
      Begin
        cdsIteFor.Edit;
        cdsIteFor.FieldByName('ITE_CODITE').AsString := frmCadProdutos.strCodIteExterno;
        cdsItefor.Post;
      End;
    Finally
      FreeAndNil(frmCadProdutos)
    End;
  End;
end;


function TfrmEntImportacaoNotaEletronica.fCarregaTipoFornecedor(strCodFor: String): string;
  Var
    qryForCon: TUniQuery;
begin
   Result := '';

  Try
    qryForCon := fCriaQuery(Self);

    With qryForCon, Sql Do
    Begin
      Add('SELECT *                   ');
      Add('FROM CADFOR                ');
      Add('WHERE FOR_CODFOR = :CODFOR ');

      ParamByName('CODFOR').AsString := strCodFor;

      Open;

      If (Not IsEmpty) Then
      begin
        case qryForCon.FieldByName('FOR_MATREV').AsString[1] Of
           'C': Result := 'Comércio';
           'D': Result := 'Distribuidor';
           'I': Result := 'Indústria';
           'R': Result := 'Revenda';
           'M': Result := 'Material de Consumo';
           'Y': Result := 'Indústria Incentivada';
         end;
      end

    End;
  Finally
    FreeAndNil(qryForCon);
  End;
end;



End.


