unit untGNREConfirmacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Data.DB, Datasnap.DBClient, UniClientDataSet, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxCurrencyEdit, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, Vcl.ComCtrls,
  Vcl.Mask, MaskEditFocus, UNI, untGNREWebService, System.StrUtils,
  untCadPag, untTCadPag, untTCadPagRepository, untLogCtp, cxCalendar, cxTextEdit,
  untTypesSistema, System.Math, System.Types;

type
  TfrmGNREConfirmacao = class(TfrmPai)
    cdsConsulta: TUniClientDataSet;
    dtsConsulta: TDataSource;
    dbgConsulta: TcxGrid;
    dbgConsultaDBView: TcxGridDBTableView;
    dbgConsultaDBViewGER_DTAENT: TcxGridDBColumn;
    dbgConsultaDBViewGER_NUMDOC: TcxGridDBColumn;
    dbgConsultaDBViewGER_ESPDOC: TcxGridDBColumn;
    dbgConsultaDBViewGER_CODEMP: TcxGridDBColumn;
    dbgConsultaDBViewGER_CODCLI: TcxGridDBColumn;
    dbgConsultaDBViewCLI_NOMCLI: TcxGridDBColumn;
    dbgConsultaDBViewGER_ESTADO: TcxGridDBColumn;
    dbgConsultaDBViewGER_VLRCON: TcxGridDBColumn;
    dbgConsultaDBViewGER_TOTRET: TcxGridDBColumn;
    dbgConsultaDBViewVAL_DIFAL: TcxGridDBColumn;
    dbgConsultaDBViewVAL_FCP: TcxGridDBColumn;
    dbgConsultalevel: TcxGridLevel;
    Panel1: TPanel;
    Label2: TLabel;
    mskDtaVen: TMaskEditFocus;
    Label3: TLabel;
    mskDtaPag: TMaskEditFocus;
    pgbProgresso: TProgressBar;
    btnConfirma: TBitBtnLocked;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxStyle2: TcxStyle;
    cxStyle3: TcxStyle;
    cxStyle4: TcxStyle;
    cxStyle5: TcxStyle;
    cxStyle6: TcxStyle;
    cxStyle7: TcxStyle;
    cxStyle8: TcxStyle;
    cxStyle9: TcxStyle;
    cxStyle10: TcxStyle;
    cxStyle11: TcxStyle;
    cxStyle12: TcxStyle;
    cxStyle13: TcxStyle;
    cxStyle14: TcxStyle;
    cxStyle16: TcxStyle;
    cxStyle17: TcxStyle;
    cxStyle18: TcxStyle;
    cxStyle19: TcxStyle;
    cxStyle20: TcxStyle;
    cxStyle21: TcxStyle;
    cxStyle22: TcxStyle;
    cxStyle23: TcxStyle;
    cxStyle15: TcxStyle;
    cxStyle24: TcxStyle;
    cxStyle25: TcxStyle;
    cxStyle26: TcxStyle;
    cxStyle27: TcxStyle;
    cxStyle28: TcxStyle;
    cxStyle29: TcxStyle;
    cxStyle30: TcxStyle;
    cxStyleSelecao: TcxStyle;
    cxStyle32: TcxStyle;
    cxStyle33: TcxStyle;
    cxStyle34: TcxStyle;
    cxStyle35: TcxStyle;
    cxStyle36: TcxStyle;
    cxStyle37: TcxStyle;
    cxStyle38: TcxStyle;
    cxStyleZebrado: TcxStyle;
    cxStyle40: TcxStyle;
    cxStyle41: TcxStyle;
    cxStyle42: TcxStyle;
    cxStyle43: TcxStyle;
    cxStyle44: TcxStyle;
    cxStyle45: TcxStyle;
    cxStyle46: TcxStyle;
    cxStyle47: TcxStyle;
    GridTableViewStyleSheetUserFormat3: TcxGridTableViewStyleSheet;
    dbgConsultaDBViewVAL_FCP_ST: TcxGridDBColumn;
    lblMensagem: TLabel;
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    FGnreSt,
    FGnreDf,
    FGnreFc,
    FDuaReceitaSt,
    FDuaReceitaDf,
    FDuaReceitaFc,
    FDareReceitaSt,
    FDareReceitaDf,
    FDareReceitaFcpOp,
    FDareReceitaFcpSt,
    FDareReceitaFcpDf,
    FGnrePagarSt,
    FGnrePagarDf,
    FGnrePagarFc,
    FGnreForSt,
    FGnreForDf,
    FGnreForFc,
    FGnrePorSt,
    FGnrePorDf,
    FGnrePorFc,
    FGnreEvento: String;
    FSemaforoConfirma: Integer;
    FToleranciaBoleto: Double;
    FImpressora: String;
    function fCarregaConfiguracoes: Boolean;
    function fGetReceita(AOpcao:Integer; AUF:String): String;
    function fGetReceitaDareFcp:String;
    function fGnreEnviar(var WSGnre: TWSGnre): Boolean;
    function fGnreGerarFinanceiro(ACodigoDaReceita, AChaveDeAcesso, AConvenio, ANumeroDeControle, ACodBarra, ALinhaDigitavel, AQrCode: String; AVlrMulta, AVlrJuros, AVlrDuplicata: Double): Boolean;
    procedure pGnreConfigurar(var WSGnre: TWSGnre);
    procedure pGnreImprimirGuias;
    procedure pGnrePreencherGuia(var WSGnre: TWSGnre);
    procedure pGnreRegistraSituacaoDaGuia(AMensagem: String);
    function fGnreValorReceita: Double;
    procedure pGerarGuias;
    procedure pGravaLogCadPag(ANumDup, AParcel: String; ASeqBai: Integer; ACodEmp, ACodFor, ASerie_: String);
    function fUFsDaReceita: String;
    function fPodeGerarGuia: Boolean;
    function fReceitaUtilizadaNaUF: Boolean;
    procedure pGnreRejeicao(AExiste: Boolean);
    procedure pReceitaNaoUtilizadaNaUF;
    function fExisteFinanceiro(ACodigoDaReceita, AChaveDeAcesso: String): Boolean;
    procedure pGnreApagaFinanceiro(AChaveDeAcesso: String);
    function fUsaExportacaoAutomaticaDeGuiasPDF: Boolean;
    function fExisteFinanceiroBaixado(ACodigoDaReceita, AChaveDeAcesso: String): Boolean;
    procedure pGnreGravaLogDeRejeicao(ATipoReceita: TTipoReceitaGnre; AVersaoGnrePE: TWebServicePernambucoVersao; AChaveDeAcesso, ACodigoDaReceita, ADescricao: String);
    procedure pCarregaDocumentosParaImpressao;
    procedure pCarregaDocumentosParaExportacaoAutomaticaDeGuiasPDF;
    procedure pGnreGeraExportacaoAutomaticaDeGuiasPDF;
    { Private declarations }
  public
    FOpcao: Integer;
    FSituacao: Integer;
    FCertificadoPFX: String;
    FCertificadoPEM: String;
    FCertificadoKEY: String;
    FCertificadoSenha: String;
    FSerialCertificado: String;

    { Public declarations }
  end;

var
  frmGNREConfirmacao: TfrmGNREConfirmacao;

implementation

uses untFuncoesSimples, untGNREModulo, untGravando;

const
  UF_ST    = 'AC_AL_AM_AP_BA_CE_DF_ES_GO_MA_MG_MS_MT_PA_PB_PE_PI_PR_RJ_RN_RO_RR_RS_SC_SE_SP_TO_';
  UF_FCP   = 'AL_AM_BA_CE_DF_ES_GO_MA_MG_MS_MT_PB_PE_PI_RN_RS_SE_SP_TO_';
  UF_DIFAL = 'AC_AL_AM_AP_BA_CE_DF_ES_GO_MA_MG_MS_MT_PA_PB_PE_PI_PR_RJ_RN_RO_RR_RS_SC_SE_SP_TO_';

{$R *.dfm}

function TfrmGNREConfirmacao.fUFsDaReceita: String;
Begin
  case FOpcao of
    0: Result := UF_ST;
    1: Result := UF_FCP;
    2: Result := UF_DIFAL;
  end;
End;

function TfrmGNREConfirmacao.fCarregaConfiguracoes : Boolean;
Begin
  Result := False;

  Try
    FGnreSt := fCfgSis('GNREST');
    FGnreDf := fCfgSis('GNREDF');
    FGnreFc := fCfgSis('GNREFC');

    FDuaReceitaSt := fCfgSis('DUA_ST');
    FDuaReceitaDf := fCfgSis('DUADFL');
    FDuaReceitaFc := fCfgSis('DUAFCP');

    FDareReceitaSt := fCfgSis('DAREST');
    FDareReceitaDf := fCfgSis('DAREDF');
    FDareReceitaFcpOp := fCfgSis('DARFFC');
    FDareReceitaFcpSt := fCfgSis('DARFST');
    FDareReceitaFcpDf := fCfgSis('DARFDF');

    FGnrePagarSt := fCfgSis('CTAPST');
    FGnrePagarDf := fCfgSis('CTAPDF');
    FGnrePagarFc := fCfgSis('CTAPFC');

    FGnreForSt := fCfgSis('FORGST');
    FGnreForDf := fCfgSis('FORGDF');
    FGnreForFc := fCfgSis('FORGFC');

    FGnrePorSt := fCfgSis('GPORST');
    FGnrePorDf := fCfgSis('GPORDF');
    FGnrePorFc := fCfgSis('GPORFC');

    FGnreEvento := fCfgSis('GPGEVE');

    FToleranciaBoleto := fCfgSis('TOLGNR', varDouble);

    FImpressora := fCfgSis('GNRIMP');

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmGNREConfirmacao.fCarregaConfiguracoes]');
    End;
  End;
End;

procedure TfrmGNREConfirmacao.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  If (InterlockedIncrement(FSemaforoConfirma) = 0) Then
  Begin
    If fVerificaCampos Then
    Begin
      If TfrmGravando.fExecutarModalA(pGerarGuias, 'Gerando guias no WebService do Sefaz . . .', '') Then
        Close;
    End;
    InterlockedDecrement(FSemaforoConfirma);
  End
  Else
    InterlockedDecrement(FSemaforoConfirma);
end;

function TfrmGNREConfirmacao.fGnreValorReceita:Double;
Begin
  case FOpcao of
    0: Result := cdsConsulta.FieldByName('GER_TOTRET').AsFloat;
    1: Result := cdsConsulta.FieldByName('VAL_FCP').AsFloat + cdsConsulta.FieldByName('VAL_FCP_ST').AsFloat;
    2: Result := cdsConsulta.FieldByName('VAL_DIFAL').AsFloat;
  else
    Result := 0;
  end;
end;

procedure TfrmGNREConfirmacao.FormCreate(Sender: TObject);
begin
  inherited;
  cxStyleZebrado.Color := strToIntDef(fCfgSis('CORZEB'), clMoneyGreen);
  FSemaforoConfirma := -1;
  fCarregaConfiguracoes;
end;

procedure TfrmGNREConfirmacao.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Case Key Of
        VK_F10 : If btnConfirma.Enabled Then
                 Begin
                   Key := 0;
                   btnConfirma.Click;
                 End;
     VK_ESCAPE : If btnSair.Enabled Then btnSair.Click;
  End;
end;

procedure TfrmGNREConfirmacao.FormShow(Sender: TObject);
begin
  inherited;
  Try
    cdsConsulta.IndexFieldNames := 'GER_ESTADO;GER_NUMDOC';
    cdsConsulta.DisableControls;
    cdsConsulta.First;
    While not cdsConsulta.eof Do
    Begin
      If cdsConsulta.FieldByName('SELECIONADO').AsString = 'N' Then
        cdsConsulta.Delete
      Else
        cdsConsulta.Next;
    End;
  Finally
    cdsConsulta.First;
    cdsConsulta.EnableControls;

    pSetFocus(mskDtaVen);
  End;
end;

procedure TfrmGNREConfirmacao.pGnreConfigurar(var WSGnre: TWSGnre);
begin
  case FOpcao of
    0: WSGnre.TipoReceita := ST;
    1: WSGnre.TipoReceita := FCP;
    2: WSGnre.TipoReceita := DIFAL;
  end;

  WSGnre.Configuracoes.GnreSt                := fCfgSis('GNREST');
  WSGnre.Configuracoes.GnreDf                := fCfgSis('GNREDF');
  WSGnre.Configuracoes.GnreFc                := fCfgSis('GNREFC');
  WSGnre.Configuracoes.GnrePagarSt           := fCfgSis('CTAPST');
  WSGnre.Configuracoes.GnrePagarDf           := fCfgSis('CTAPDF');
  WSGnre.Configuracoes.GnrePagarFc           := fCfgSis('CTAPFC');
  WSGnre.Configuracoes.GnreForSt             := fCfgSis('FORGST');
  WSGnre.Configuracoes.GnreForDf             := fCfgSis('FORGDF');
  WSGnre.Configuracoes.GnreForFc             := fCfgSis('FORGFC');
  WSGnre.Configuracoes.GnrePorSt             := fCfgSis('GPORST');
  WSGnre.Configuracoes.GnrePorDf             := fCfgSis('GPORDF');
  WSGnre.Configuracoes.GnrePorFc             := fCfgSis('GPORFC');
  WSGnre.Configuracoes.DuaReceitaSt          := fCfgSis('DUA_ST');
  WSGnre.Configuracoes.DuaReceitaDf          := fCfgSis('DUADFL');
  WSGnre.Configuracoes.DuaReceitaFc          := fCfgSis('DUAFCP');
  WSGnre.Configuracoes.DareReceitaSt         := fCfgSis('DAREST');
  WSGnre.Configuracoes.DareReceitaDf         := fCfgSis('DAREDF');
  WSGnre.Configuracoes.DareReceitaFcpOp      := fCfgSis('DARFFC');
  WSGnre.Configuracoes.DareReceitaFcpSt      := fCfgSis('DARFST');
  WSGnre.Configuracoes.DareReceitaFcpDf      := fCfgSis('DARFDF');
  WSGnre.Configuracoes.DareServicoSt         := fCfgSis('DARSST');
  WSGnre.Configuracoes.DareServicoDf         := fCfgSis('DARSDF');
  WSGnre.Configuracoes.DareServicoFcpOp      := fCfgSis('DASFFC');
  WSGnre.Configuracoes.DareServicoFcpSt      := fCfgSis('DASFST');
  WSGnre.Configuracoes.DareServicoFcpDf      := fCfgSis('DASFDF');
  WSGnre.Configuracoes.DareApiKey            := fCfgSis('DARKEY');
  WSGnre.Configuracoes.UsarCapicom           := fCfgSis('CAPCOM', varBoolean);
  WSGnre.Configuracoes.UsarCapicomArquivoPFX := fCfgSis('USAPFX', varBoolean);
  WSGnre.Configuracoes.CertificadoArquivoPFX := FCertificadoPFX;
  WSGnre.Configuracoes.CertificadoArquivoPEM := FCertificadoPEM;
  WSGnre.Configuracoes.CertificadoArquivoKEY := FCertificadoKEY;
  WSGnre.Configuracoes.CertificadoSenha      := FCertificadoSenha;

  WSGnre.Configuracoes.SerialCertificado     := FSerialCertificado;
  WSGnre.Configuracoes.Homologacao           := False;
  WSGnre.Configuracoes.GnreApuracao          := False;
  WSGnre.Configuracoes.ToleranciaBoleto      := fCfgSis('TOLGNR', varDouble);
end;

procedure TfrmGNREConfirmacao.pGnrePreencherGuia(var WSGnre: TWSGnre);
begin
  WSGnre.DadosGuia.UfFavorecida                          := cdsConsulta.FieldByName('GER_ESTADO').AsString;
  WSGnre.DadosGuia.DataEmissao                           := cdsConsulta.FieldByName('GER_DTAENT').AsString;
  WSGnre.DadosGuia.DataVencimento                        := mskDtaVen.Text;
  WSGnre.DadosGuia.DataPagamento                         := mskDtaPag.Text;

  If WSGnre.DadosGuia.UfFavorecida = 'RJ' Then
  Begin
    WSGnre.DadosGuia.ValorICMS                           := AnsiReplaceStr(FormatFloat('#0.00',fGnreValorReceita),',','.');
    WSGnre.DadosGuia.ValorFECP                           := AnsiReplaceStr(FormatFloat('#0.00',cdsConsulta.FieldByName('VAL_FCP').AsFloat + cdsConsulta.FieldByName('VAL_FCP_ST').AsFloat),',','.');
    WSGnre.DadosGuia.ValorGNRE                           := AnsiReplaceStr(FormatFloat('#0.00',fGnreValorReceita + cdsConsulta.FieldByName('VAL_FCP').AsFloat + cdsConsulta.FieldByName('VAL_FCP_ST').AsFloat),',','.');
  End
  Else
    WSGnre.DadosGuia.ValorGNRE                           := AnsiReplaceStr(FormatFloat('#0.00',fGnreValorReceita),',','.');

  WSGnre.DadosGuia.ValorST                               := cdsConsulta.FieldByName('GER_TOTRET').AsFloat;
  WSGnre.DadosGuia.ValorDIFAL                            := cdsConsulta.FieldByName('VAL_DIFAL').AsFloat;

  WSGnre.DadosGuia.ChaveDeAcesso                         := cdsConsulta.FieldByName('FIS_ACESSO').AsString;
  WSGnre.DadosGuia.CodigoDaReceita                       := fGetReceita(FOpcao, cdsConsulta.FieldByName('GER_ESTADO').AsString);
  WSGnre.DadosGuia.NotaFiscal                            := cdsConsulta.FieldByName('GER_NUMDOC').AsString;
  WSGnre.DadosGuia.CadFisAutoincrem                      := cdsConsulta.FieldByName('FIS_AUTINC').AsString;

  WSGnre.DadosGuia.ContribuinteEmitenteCNPJ              := Trim(cdsConsulta.FieldByName('EMP_C_G_C_').AsString);
  WSGnre.DadosGuia.ContribuinteEmitenteRazaoSocial       := Trim(fTiraCaracEspeciais( Trim(cdsConsulta.FieldByName('EMP_NOMEMP').AsString)));
  WSGnre.DadosGuia.ContribuinteEmitenteEndereco          := Trim(cdsConsulta.FieldByName('EMP_ENDERE').AsString );
  WSGnre.DadosGuia.ContribuinteEmitenteMunicipio         := Copy(fRetornaCodIBGE(cdsConsulta.FieldByName('EMP_CODCID').AsString ),3,5);
  WSGnre.DadosGuia.ContribuinteEmitenteUf                := Trim(cdsConsulta.FieldByName('EMP_ESTADO').AsString);
  WSGnre.DadosGuia.ContribuinteEmitenteCep               := fPadR(fTiraCaracEspeciais(cdsConsulta.FieldByName('EMP_C_E_P_').AsString, True, True),8,'0');
  WSGnre.DadosGuia.ContribuinteEmitenteTelefone          := fTiraCaracEspeciais(cdsConsulta.FieldByName('EMP_FONE01').AsString, True, True);

  WSGnre.DadosGuia.ContribuinteDestinatarioTipoPessoa    := cdsConsulta.FieldByName('CLI_CGCCPF').AsString;
  WSGnre.DadosGuia.ContribuinteDestinatarioCnpj          := fTiraCaracEspeciais(cdsConsulta.FieldByName('CLI_C_G_C_').AsString,True,True,True);
  WSGnre.DadosGuia.ContribuinteDestinatarioInscrEstadual := fTiraCaracEspeciais(cdsConsulta.FieldByName('CLI_I_E_S_').AsString,True,True,True);
  WSGnre.DadosGuia.ContribuinteDestinatarioRazaoSocial   := Trim(fTiraCaracEspeciais(cdsConsulta.FieldByName('CLI_RAZSOC').AsString));
  WSGnre.DadosGuia.ContribuinteDestinatarioMunicipio     := Copy(fRetornaCodIBGE(cdsConsulta.FieldByName('MUNICIPIO_DESTINATARIO').AsString ), 3, 5);

  WSGnre.DadosGuia.Identificacao                         := cdsConsulta.FieldByName('GER_NUMDOC').AsString +'-'+
                                                            cdsConsulta.FieldByName('GER_ESPDOC').AsString +'-'+
                                                            cdsConsulta.FieldByName('GER_CODEMP').AsString ;

  WSGnre.DadosGuia.ContribuinteDestinatarioMunicipioEspiritoSanto := fRetornaCodEspiritoSanto(fRetornaCodIBGE(cdsConsulta.FieldByName('MUNICIPIO_DESTINATARIO').AsString));

  If WSGnre.DadosGuia.UfFavorecida = 'SP' Then
  Begin
    WSGnre.TipoWebService := GnreSaoPaulo
  End
  Else if WSGnre.DadosGuia.UfFavorecida = 'ES' Then
  Begin
    WSGnre.TipoWebService := GnreEspiritoSanto
  End
  Else
    WSGnre.TipoWebService := GnrePernambuco;

  If WSGnre.TipoWebService = GnrePernambuco Then
  Begin
    If Pos(WSGnre.DadosGuia.UfFavorecida, fTransform(fCfgSis('GNR200'), 2)) > 0 Then
      WSGnre.VersaoGnrePE := Versao2
    Else
      WSGnre.VersaoGnrePE := Versao1;
  End;

end;

procedure TfrmGNREConfirmacao.pGravaLogCadPag(ANumDup, AParcel: String; ASeqBai: Integer; ACodEmp, ACodFor, ASerie_: String);
var
  objPag: TCadPag;
  objRep: TCadPagRepository;
begin
  objRep := TCadPagRepository.Create;

  Try
    objPag := objRep.fRetDuplicata(ANumDup, AParcel, ASeqBai, ACodEmp, ACodFor, ASerie_);

    If Assigned(objPag) Then
    begin
      untLogCtp.pGravaLogCtp(objPag, 'GNRE PE - ALTERAÇÃO DO CÓDIGO DE BARRAS, LINHA DIGITÁVEL E VENCIMENTO', Self.Name);
    end;

  Finally
    FreeAndNil(objRep);
  End;
end;

function TfrmGNREConfirmacao.fExisteFinanceiro(ACodigoDaReceita, AChaveDeAcesso: String): Boolean;
var
  LQryAux: TUniQuery;
begin
  LQryAux := fCriaQuery;

  Try
    LQryAux.Close;
    LQryAux.SQL.Clear;
    LQryAux.SQL.Add('SELECT COUNT(*) AS QTDE FROM CADPAG');
    LQryAux.SQL.Add('WHERE IFNULL(CTP_GNRCTR,"") <> "" ');
    LQryAux.SQL.Add('  AND CTP_GNRACE = :ACESSO ');
    LQryAux.SQL.Add('  AND CTP_CODREC = :CODREC ');

    LQryAux.ParamByName('ACESSO').AsString := AChaveDeAcesso;
    LQryAux.ParamByName('CODREC').AsString := ACodigoDaReceita;
    LQryAux.Open;

    Result := (LQryAux.FieldByName('QTDE').AsInteger > 0);
  Finally
    FreeAndNil(LQryAux);
  End;
end;

function TfrmGNREConfirmacao.fExisteFinanceiroBaixado(ACodigoDaReceita, AChaveDeAcesso: String): Boolean;
var
  LQryAux: TUniQuery;
begin
  LQryAux := fCriaQuery;

  Try
    LQryAux.Close;
    LQryAux.SQL.Clear;
    LQryAux.SQL.Add('SELECT COUNT(*) AS QTDE FROM CADPAG');
    LQryAux.SQL.Add('WHERE IFNULL(CTP_GNRCTR,"") <> "" ');
    LQryAux.SQL.Add('  AND CTP_VALPAG > 0 ');
    LQryAux.SQL.Add('  AND CTP_GNRACE = :ACESSO ');
    LQryAux.SQL.Add('  AND CTP_CODREC = :CODREC ');

    LQryAux.ParamByName('ACESSO').AsString := AChaveDeAcesso;
    LQryAux.ParamByName('CODREC').AsString := ACodigoDaReceita;
    LQryAux.Open;

    Result := (LQryAux.FieldByName('QTDE').AsInteger > 0);
  Finally
    FreeAndNil(LQryAux);
  End;
end;

function TfrmGNREConfirmacao.fGnreGerarFinanceiro(ACodigoDaReceita, AChaveDeAcesso, AConvenio, ANumeroDeControle, ACodBarra, ALinhaDigitavel, AQrCode: String; AVlrMulta, AVlrJuros, AVlrDuplicata: Double ): Boolean;
var
 LQryUpdate  : TUniQuery;
 LSqlAux     : String;
 LCampoFlag  : String;
 LHistorico  : String;
 LPlanoContas: String;
 LFornecedor : String;
 LPortador   : String;
 LNumDoc     : String;
 LVlrOriginal: Double;
 LVlrJuros   : Double;
 LVlrMulta   : Double;

 function fRetornaHistorico: String;
 begin
   Result := 'GNRE NACIONAL GERADA AUTOMATICAMENTE ';

   If (cdsConsulta.FieldByName('GER_ESTADO').AsString = 'ES') Then
     Result := 'DUA-ES GERADA AUTOMATICAMENTE ';

   If (cdsConsulta.FieldByName('GER_ESTADO').AsString = 'SP') Then
     Result := 'DARE-SP GERADA AUTOMATICAMENTE ';
 end;

Begin
  Result := True;

  Try

    LVlrOriginal := 0;

    Case FOpcao of
      0:Begin
          LFornecedor  := FGnreForSt;
          LPlanoContas := FGnrePagarSt;
          LPortador    := FGnrePorSt;
          LVlrOriginal := cdsConsulta.FieldByName('GER_TOTRET').AsFloat;
          LCampoFlag   := 'AUX_GNEAUT';
        End;
      1:Begin
          LFornecedor  := FGnreForFc;
          LPlanoContas := FGnrePagarFc;
          LPortador    := FGnrePorFc;
          LVlrOriginal := (cdsConsulta.FieldByName('VAL_FCP').AsFloat + cdsConsulta.FieldByName('VAL_FCP_ST').AsFloat);
          LCampoFlag   := 'AUX_GNEFCP';
        End;
      2:Begin
          LFornecedor  := FGnreForDf;
          LPlanoContas := FGnrePagarDf;
          LPortador    := FGnrePorDf;
          LVlrOriginal := cdsConsulta.FieldByName('VAL_DIFAL').AsFloat;
          LCampoFlag   := 'AUX_GNEDFL';
        End;
    End;

    If cdsConsulta.FieldByName('GER_ESTADO').AsString = 'RJ' Then
    Begin
      Case FOpcao of
        0: LVlrOriginal := (cdsConsulta.FieldByName('GER_TOTRET').AsFloat + cdsConsulta.FieldByName('VAL_FCP').AsFloat + cdsConsulta.FieldByName('VAL_FCP_ST').AsFloat);
        2: LVlrOriginal := (cdsConsulta.FieldByName('VAL_DIFAL').AsFloat  + cdsConsulta.FieldByName('VAL_FCP').AsFloat + cdsConsulta.FieldByName('VAL_FCP_ST').AsFloat);
      End;
    End;

    LVlrJuros := AVlrDuplicata - LVlrOriginal;
    LVlrMulta := 0;

    If (LVlrJuros > 0) And (AVlrMulta > 0) And (AVlrJuros > 0) And (CompareValue(LVlrJuros, (AVlrMulta + AVlrJuros), 0.01) = EqualsValue) Then
    Begin
      LVlrJuros := AVlrJuros;
      LVlrMulta := AVlrMulta;
    End;

    If not fExisteFinanceiro(ACodigoDaReceita, AChaveDeAcesso) Then
    Begin
      LNumDoc := fRetSequencialCadPag;

      LHistorico := fRetornaHistorico;

      Case FOpcao of
        0: LHistorico := LHistorico + 'SUBSTITUIÇÃO TRIBUTÁRIA ';
        1: LHistorico := LHistorico + 'FUNDO DE COMBATE A POBREZA ';
        2: LHistorico := LHistorico + 'DIFAL ';
      End;

      LHistorico := LHistorico + 'REFERENTE ' + cdsConsulta.FieldByName('GER_ESPDOC').AsString +': '+
                                                cdsConsulta.FieldByName('GER_NUMDOC').AsString ;

      Result := fGravaCadPag(Self.Name,                                       // Nome Form LOGCTP
                     'GNRE NACIONAL - EXPORTAÇÃO DE SAÍDA',                   // Descrição LOGCTP
                     LFornecedor,                                             // Fornecedor
                     fStrZero(LNumDoc, 12),                                   // Numero da Duplicata
                     'A',                                                     // Parcela
                     VS_strCodEmp,                                            // Empresa
                     LPlanoContas,                                            // Centro de Custo
                     '001',                                                   // Serie do Documento
                     0,                                                       // Sequencial de Baixa
                     VS_Date,                                                 // Data do lançamento
                     StrToDate(mskDtaVen.Text),                               // Data de Vencimento
                     LVlrOriginal,                                            // Valor da Duplicata
                     LVlrOriginal,                                            // Valor Original
                     'N',                                                     // Previsão?
                     'N',                                                     // Veio Boleto
                     'N',                                                     // Deposito
                     LHistorico,                                              // Histórico 1
                     '',                                                      // Histórico 2
                     '',                                                      // Histórico da Baixa
                     '',                                                      // Portador da Baixa
                     '',                                                      // Centro de Custo da Baixa
                     '',                                                      // Documento da Baixa
                     '',                                                      // Operador da Baixa
                     0,                                                       // Data do Pagamento
                     0,                                                       // Valor Pago
                     0,                                                       // Valor de Juros após pagamento
                     0,                                                       // Valor Desconto
                     VS_strCodEmp,                                            // Empresa
                     FGnreEvento,                                             // Código do Evento
                     'N',                                                     // Usa Cheque
                     LPortador,                                               // Codigo do Portador
                     '',                                                      // Numero do Documento
                     LVlrJuros,                                               // Valor de Juros antes do pagamento
                     0.0,
                     0,
                     False,
                     0,
                     '2',
                     0,
                     'S',
                     '',
                     '',
                     '',
                     '',
                     '',
                     '',
                     '',
                     '',
                     'N',
                     FormatDateTime('mm/yyyy', VS_Date),
                     '',
                     '',
                     '',
                     '',
                     0,
                     0,
                     0,
                     0,
                     '',
                     0,
                     0,
                     ALinhaDigitavel,
                     ACodBarra,
                     '',
                     '',
                     '',
                     '7',
                     ACodigoDaReceita,
                     '',
                     '',
                     '',
                     'N',
                     '',
                     cdsConsulta.FieldByName('GER_NUMDOC').AsString,
                     AChaveDeAcesso,
                     ANumeroDeControle,
                     StrToDate(mskDtaPag.Text),
                     AConvenio,
                     LVlrMulta,
                     '',
                     0,
                     0,
                     0,
                     '',
                     '',
                     '',
                     AQrCode
                     );

    End
    Else
    Begin
      LQryUpdate := fCriaQuery;

      Try
        LQryUpdate.Close;
        LQryUpdate.SQL.Clear;
        LQryUpdate.SQL.Add('UPDATE CADPAG SET CTP_DTAVEN = :DTAVEN, ');
        LQryUpdate.SQL.Add('                  CTP_VALDUP = :VALDUP, ');
        LQryUpdate.SQL.Add('                  CTP_JURSUJ = :JURSUJ, ');
        LQryUpdate.SQL.Add('                  CTP_MULSUJ = :MULSUJ, ');
        LQryUpdate.SQL.Add('                  CTP_GNRDPG = :GNRDPG, ');
        LQryUpdate.SQL.Add('                  CTP_GNRCTR = :GNRCTR, ');
        LQryUpdate.SQL.Add('                  CTP_QRCODE = :QRCODE, ');
        LQryUpdate.SQL.Add('                  CTP_CODBAR = :CODBAR, ');
        LQryUpdate.SQL.Add('                  CTP_LINDIG = :LINDIG  ');
        LQryUpdate.SQL.Add('WHERE CTP_VALPAG = 0 ');
        LQryUpdate.SQL.Add('  AND CTP_GNRACE = :ACESSO ');
        LQryUpdate.SQL.Add('  AND CTP_CODREC = :CODREC ');

        LQryUpdate.ParamByName('ACESSO').AsString := AChaveDeAcesso;
        LQryUpdate.ParamByName('CODREC').AsString := ACodigoDaReceita;
        LQryUpdate.ParamByName('DTAVEN').AsDate   := StrToDate(mskDtaVen.Text);
        LQryUpdate.ParamByName('GNRDPG').AsDate   := StrToDate(mskDtaPag.Text);
        LQryUpdate.ParamByName('GNRCTR').AsString := ANumeroDeControle;
        LQryUpdate.ParamByName('QRCODE').AsString := AQrCode;
        LQryUpdate.ParamByName('CODBAR').AsString := ACodBarra;
        LQryUpdate.ParamByName('LINDIG').AsString := ALinhaDigitavel;
        LQryUpdate.ParamByName('VALDUP').AsFloat  := LVlrOriginal;
        LQryUpdate.ParamByName('JURSUJ').AsFloat  := LVlrJuros;
        LQryUpdate.ParamByName('MULSUJ').AsFloat  := LVlrMulta;

        LQryUpdate.ExecSQL;

        LQryUpdate.Close;
        LQryUpdate.SQL.Clear;
        LQryUpdate.SQL.Add('SELECT AUTOINCREM, CTP_NUMDUP, CTP_PARCEL, CTP_SEQBAI, CTP_CODEMP, CTP_CODFOR, CTP_SERIE_, CTP_VALPAG FROM CADPAG');
        LQryUpdate.SQL.Add('WHERE CTP_GNRACE = :ACESSO ');
        LQryUpdate.SQL.Add('  AND CTP_CODREC = :CODREC ');

        LQryUpdate.ParamByName('ACESSO').AsString := AChaveDeAcesso;
        LQryUpdate.ParamByName('CODREC').AsString := ACodigoDaReceita;
        LQryUpdate.Open;

        If LQryUpdate.FieldByName('CTP_VALPAG').AsFloat = 0 Then
        Begin
          pGravaLogCadPag(LQryUpdate.FieldByName('CTP_NUMDUP').AsString,
                          LQryUpdate.FieldByName('CTP_PARCEL').AsString,
                          LQryUpdate.FieldByName('CTP_SEQBAI').AsInteger,
                          LQryUpdate.FieldByName('CTP_CODEMP').AsString,
                          LQryUpdate.FieldByName('CTP_CODFOR').AsString,
                          LQryUpdate.FieldByName('CTP_SERIE_').AsString);
        End;

      Finally
        FreeAndNil(LQryUpdate);
      End;
    End;

    If Result Then
    Begin
      LSqlAux := '';

      If cdsConsulta.FieldByName('GER_ESTADO').AsString = 'RJ' Then
      Begin
        LSqlAux := LSqlAux + 'UPDATE  ';
        LSqlAux := LSqlAux +     cdsConsulta.FieldByName('TABAUX').AsString;
        LSqlAux := LSqlAux + ' SET AUX_GNEFCP = "S", '+LCampoFlag+' = "S", ';
        LSqlAux := LSqlAux + '     AUX_DTAGNR = '+QuotedStr(FormatDateTime('yyyy-mm-dd', VS_Date))+', AUX_HORGNR = '+QuotedStr(FormatDateTime('hh:mm:ss', fNow))+' WHERE AUX_SEQGER = ';
        LSqlAux := LSqlAux +     QuotedStr(AnsiReplaceStr(cdsConsulta.FieldByName('AUTOINCREM').AsString, cdsConsulta.FieldByName('TABELA').AsString,''));
      End
      Else
      Begin
        LSqlAux := LSqlAux + 'UPDATE  ';
        LSqlAux := LSqlAux +     cdsConsulta.FieldByName('TABAUX').AsString;
        LSqlAux := LSqlAux + ' SET '+LCampoFlag+' = "S", ';
        LSqlAux := LSqlAux + '     AUX_DTAGNR = '+QuotedStr(FormatDateTime('yyyy-mm-dd', VS_Date))+', AUX_HORGNR = '+QuotedStr(FormatDateTime('hh:mm:ss', fNow))+' WHERE AUX_SEQGER = ';
        LSqlAux := LSqlAux +     QuotedStr(AnsiReplaceStr(cdsConsulta.FieldByName('AUTOINCREM').AsString, cdsConsulta.FieldByName('TABELA').AsString,''));
      End;

      fExecutaSQL(LSqlAux);
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;

      pMensagensErro(E.Message,'[TfrmGNREConfirmacao.fExportaGNRE]');
    End;
  End;

end;

function TfrmGNREConfirmacao.fGetReceitaDareFcp:String;
begin
  Result := FDareReceitaFcpOp;

  If cdsConsulta.FieldByName('GER_TOTRET').AsFloat > 0 Then
    Result := FDareReceitaFcpSt;

  If cdsConsulta.FieldByName('VAL_DIFAL').AsFloat > 0 Then
    Result := FDareReceitaFcpDf;
end;

function TfrmGNREConfirmacao.fGetReceita(AOpcao:Integer; AUF:String):String;
Begin

  If AUF = 'ES' Then
  Begin
    case AOpcao of
      0: Result := FDuaReceitaSt;
      1: Result := FDuaReceitaFc;
      2: Result := FDuaReceitaDf;
    end;
  End
  Else If AUF = 'SP' Then
  Begin
    case AOpcao of
      0: Result := FDareReceitaSt;
      1: Result := fGetReceitaDareFcp;
      2: Result := FDareReceitaDf;
    end;
  End
  Else
  Begin
    case AOpcao of
      0: Result := fStrZero(FGnreSt, 06);
      1: Result := fStrZero(FGnreFc, 06);
      2: Result := fStrZero(FGnreDf, 06);
    end;
  End;
end;

procedure TfrmGNREConfirmacao.pCarregaDocumentosParaImpressao;
var
  LContador: Integer;
begin

  Try
    cdsConsulta.DisableControls;
    cdsConsulta.First;
    While not cdsConsulta.eof Do
    Begin
      For LContador := 0 To 2 Do
      Begin
        GNREModulo.pPreparaBoleto(False, False, fGetReceita(LContador, cdsConsulta.FieldByName('GER_ESTADO').AsString), cdsConsulta.FieldByName('FIS_ACESSO').AsString, fRetornaTipoReceitaGNRE(LContador));
      End;

      cdsConsulta.Next;
    End;
  Finally
    cdsConsulta.EnableControls;
  End;

end;

procedure TfrmGNREConfirmacao.pGnreImprimirGuias;
begin

  Try
    pCriarFormularios(TGNREModulo, GNREModulo);

    TfrmGravando.fExecutarModalA(pCarregaDocumentosParaImpressao, 'Carregando documentos para impressão . . .', '');

    GNREModulo.pImprimir(Self.Name, FImpressora);

  Finally
    pFreeAndNil(GNREModulo);
  End;

end;

function TfrmGNREConfirmacao.fUsaExportacaoAutomaticaDeGuiasPDF: Boolean;
begin
  Result := False;

  If not fCfgSis('GNRPDF', varBoolean) Then
    Exit;

  If fEmptyStr(fCfgSis('GNRPAT', varString)) Then
    Exit;

  Result := True;
end;

procedure TfrmGNREConfirmacao.pCarregaDocumentosParaExportacaoAutomaticaDeGuiasPDF;
var
  LContador: Integer;
begin

  Try
    cdsConsulta.DisableControls;
    cdsConsulta.First;
    While not cdsConsulta.eof Do
    Begin
      For LContador := 0 To 2 Do
      Begin
        GNREModulo.pPreparaBoleto(False, False, fGetReceita(LContador, cdsConsulta.FieldByName('GER_ESTADO').AsString), cdsConsulta.FieldByName('FIS_ACESSO').AsString, fRetornaTipoReceitaGNRE(LContador));
      End;

      GNREModulo.pGeraExportacaoAutomaticaDeGuiasPDF;

      cdsConsulta.Next;
    End;
  Finally
    cdsConsulta.EnableControls;
  End;

end;

procedure TfrmGNREConfirmacao.pGnreGeraExportacaoAutomaticaDeGuiasPDF;
begin

  Try
    pCriarFormularios(TGNREModulo, GNREModulo);

    TfrmGravando.fExecutarModalA(pCarregaDocumentosParaExportacaoAutomaticaDeGuiasPDF, 'Carregando documentos para exportação PDF . . .', '');

  Finally
    pFreeAndNil(GNREModulo);
  End;

end;

procedure TfrmGNREConfirmacao.pGnreRegistraSituacaoDaGuia(AMensagem: String);
var
  LSQL  : String;
  LCampo: String;
begin

  Case FOpcao of
    0: LCampo := 'AUX_ST_REJ';
    1: LCampo := 'AUX_FCPREJ';
    2: LCampo := 'AUX_DFLREJ';
  End;

  LSQL :=        'UPDATE '+ cdsConsulta.FieldByName('TABAUX').AsString +' SET '+ LCampo +' = '+ QuotedStr( AMensagem );
  LSQL := LSQL + ' WHERE AUX_SEQGER = '+ QuotedStr(AnsiReplaceStr(cdsConsulta.FieldByName('AUTOINCREM').AsString, cdsConsulta.FieldByName('TABELA').AsString,''));
  fExecutaSQL(LSQL);
end;

procedure TfrmGNREConfirmacao.pGnreRejeicao(AExiste: Boolean);
var
  LSQL  : String;
begin

  // Aqui indica que todas as guias em algum momento foram geradas sem erros, faz com que esses documentos fiquem na situação de "Já Geradas" no painel principal
  If not AExiste Then
  Begin
    LSQL :=        'UPDATE '+ cdsConsulta.FieldByName('TABAUX').AsString +' SET AUX_GNREOK = "S" ';
    LSQL := LSQL + ' WHERE AUX_SEQGER = '+ QuotedStr(AnsiReplaceStr(cdsConsulta.FieldByName('AUTOINCREM').AsString, cdsConsulta.FieldByName('TABELA').AsString,''));
    fExecutaSQL(LSQL);
  End;

  LSQL :=        'UPDATE '+ cdsConsulta.FieldByName('TABAUX').AsString +' SET AUX_GNRREJ = '+ IIF(AExiste, QuotedStr('S'), QuotedStr('N'));
  LSQL := LSQL + ' WHERE AUX_SEQGER = '+ QuotedStr(AnsiReplaceStr(cdsConsulta.FieldByName('AUTOINCREM').AsString, cdsConsulta.FieldByName('TABELA').AsString,''));
  fExecutaSQL(LSQL);
end;

procedure TfrmGNREConfirmacao.pGnreGravaLogDeRejeicao(ATipoReceita: TTipoReceitaGnre; AVersaoGnrePE: TWebServicePernambucoVersao; AChaveDeAcesso, ACodigoDaReceita, ADescricao: String);
var
  LqryLogGne: TUniQuery;
  LAutInc: String;
  LTipoReceita: String;
begin
  case ATipoReceita of
       ST: LTipoReceita := 'ST';
      FCP: LTipoReceita := 'FCP';
    DIFAL: LTipoReceita := 'DIFAL';
  end;

  LqryLogGne := fCriaQuery(Nil);

  Try
    LAutInc := fRetAutoIncrem('LOGGNE', VS_strCodEmp);

    LqryLogGne.SQL.Add('SELECT * FROM LOGGNE WHERE FALSE');
    LqryLogGne.Open;

    LqryLogGne.Insert;
    LqryLogGne.FieldByName('AUTOINCREM').AsString   := LAutInc;
    LqryLogGne.FieldByName('LOG_GNRACE').AsString   := AChaveDeAcesso;
    LqryLogGne.FieldByName('LOG_CODREC').AsString   := ACodigoDaReceita;
    LqryLogGne.FieldByName('LOG_TIPGNR').AsString   := LTipoReceita;
    LqryLogGne.FieldByName('LOG_VERSAO').AsString   := IIF(AVersaoGnrePE = Versao1, '1.00', '2.00');
    LqryLogGne.FieldByName('LOG_CODEMP').AsString   := VS_strCodEmp;
    LqryLogGne.FieldByName('LOG_CODOPE').AsString   := strLoginUsuarioLogado;
    LqryLogGne.FieldByName('LOG_DTAERR').AsDateTime := VS_Date;
    LqryLogGne.FieldByName('LOG_HORERR').AsDateTime := fTime();
    LqryLogGne.FieldByName('LOG_DESCRI').AsString   := ADescricao;
    LqryLogGne.Post;
    LqryLogGne.Close;

  Finally
    FreeAndNil(LqryLogGne);
  End;
end;

procedure TfrmGNREConfirmacao.pGnreApagaFinanceiro(AChaveDeAcesso:String);
var
  LSQL     : String;
  LCampo   : String;
  LQryAux  : TUniQuery;
  LContador: Integer;
  LCodigoDaReceita: String;
begin
  If FSituacao = 0 Then
    Exit;

  If fEmptyStr(AChaveDeAcesso) Then
    Exit;

  For LContador := 0 To 2 Do
  Begin
    LCodigoDaReceita := fGetReceita(LContador, cdsConsulta.FieldByName('GER_ESTADO').AsString);

    Case LContador of
      0: LCampo := 'AUX_GNEAUT';
      1: LCampo := 'AUX_GNEFCP';
      2: LCampo := 'AUX_GNEDFL';
    End;

    If not fExisteFinanceiroBaixado(LCodigoDaReceita, AChaveDeAcesso) Then
    begin
      LSQL :=        'UPDATE '+ cdsConsulta.FieldByName('TABAUX').AsString +' SET '+ LCampo + ' = ' + QuotedStr('N');
      LSQL := LSQL + ' WHERE AUX_SEQGER = '+ QuotedStr(AnsiReplaceStr(cdsConsulta.FieldByName('AUTOINCREM').AsString, cdsConsulta.FieldByName('TABELA').AsString,''));
      fExecutaSQL(LSQL);

      Try
        LQryAux := fCriaQuery;

        LQryAux.Close;
        LQryAux.SQL.Clear;
        LQryAux.SQL.Add('SELECT * FROM CADPAG');
        LQryAux.SQL.Add('WHERE IFNULL(CTP_GNRCTR,"") <> "" ');
        LQryAux.SQL.Add('  AND CTP_VALPAG = 0 ');
        LQryAux.SQL.Add('  AND CTP_GNRACE = :ACESSO ');
        LQryAux.SQL.Add('  AND CTP_CODREC = :CODREC ');
        LQryAux.ParamByName('ACESSO').AsString := AChaveDeAcesso;
        LQryAux.ParamByName('CODREC').AsString := LCodigoDaReceita;
        LQryAux.Open;

        While Not LQryAux.Eof Do
        Begin
          fApagaDuplicataContasPagar(LQryAux, Self.Name);
          LQryAux.Next;
        End;

      Finally
        FreeAndNil(LQryAux);
      End;
    end;
  End;

end;

function TfrmGNREConfirmacao.fGnreEnviar(var WSGnre: TWSGnre): Boolean;
begin
  Result := WSGnre.fGerarGuia;

  fStartTransaction;

  pGnreRegistraSituacaoDaGuia(WSGnre.retorno.Mensagem);

  If not Result Then
  begin
    pGnreGravaLogDeRejeicao(WSGnre.TipoReceita, WSGnre.VersaoGnrePE, WSGnre.DadosGuia.ChaveDeAcesso, WSGnre.DadosGuia.CodigoDaReceita, WSGnre.retorno.Mensagem);
    pGnreApagaFinanceiro(WSGnre.Retorno.ChaveDeAcesso);
  end;

  If fInTransaction Then
    fCommit;

  Try
    If Result Then
    Begin
      fStartTransaction;

      Result := fGnreGerarFinanceiro(WSGnre.Retorno.CodigoDaReceita,
                                     WSGnre.Retorno.ChaveDeAcesso,
                                     WSGnre.Retorno.CodigoConvenio,
                                     WSGnre.Retorno.Boleto.NumeroDeControle,
                                     WSGnre.Retorno.Boleto.CodigoDeBarras,
                                     WSGnre.Retorno.Boleto.LinhaDigitavel,
                                     WSGnre.Retorno.Boleto.QrCode,
                                     WSGnre.Retorno.Boleto.Multa,
                                     WSGnre.Retorno.Boleto.Juros,
                                     WSGnre.Retorno.Boleto.Valor);
    End;

  Finally
    If fInTransaction Then
    Begin
      If Result Then
        fCommit
      Else
        fRollBack;
    End;
  End;
end;

function TfrmGNREConfirmacao.fPodeGerarGuia: Boolean;
begin
  Result := False;

  If not (fGnreValorReceita > 0) Then
    Exit;

  If not fReceitaUtilizadaNaUF Then
    Exit;

  Result := True;
end;

function TfrmGNREConfirmacao.fReceitaUtilizadaNaUF: Boolean;
begin
  Result := (Pos(cdsConsulta.FieldByName('GER_ESTADO').AsString, fUFsDaReceita) > 0);

  If not Result Then
    pReceitaNaoUtilizadaNaUF;

end;

procedure TfrmGNREConfirmacao.pReceitaNaoUtilizadaNaUF;
var
  LSQL  : String;
  LCampo: String;
begin

  Case FOpcao of
    0: LCampo := 'AUX_GNEAUT';
    1: LCampo := 'AUX_GNEFCP';
    2: LCampo := 'AUX_GNEDFL';
  End;

  LSQL :=        'UPDATE '+ cdsConsulta.FieldByName('TABAUX').AsString +' SET '+ LCampo + ' = "S" ';
  LSQL := LSQL + ' WHERE AUX_SEQGER = '+ QuotedStr(AnsiReplaceStr(cdsConsulta.FieldByName('AUTOINCREM').AsString, cdsConsulta.FieldByName('TABELA').AsString,''));
  fExecutaSQL(LSQL);

  pGnreRegistraSituacaoDaGuia('Essa receita não é utilizada na UF Favorecida.');

end;

procedure TfrmGNREConfirmacao.pGerarGuias;
var
  WSGnre    : TWSGnre;
  LContador : Integer;
  LRejeicao : Boolean;
  LResultado: Boolean;
begin
  pgbProgresso.Max := cdsConsulta.RecordCount;
  pgbProgresso.Position := 0;

  Try
    cdsConsulta.DisableControls;
    cdsConsulta.First;

    While Not cdsConsulta.Eof Do
    Begin
      LRejeicao := False;

      For LContador := 0 To 2 Do
      Begin

        FOpcao := LContador;

        If cdsConsulta.FieldByName('GER_ESTADO').AsString = 'RJ' Then
        Begin
          Case LContador Of
            1: FOpcao := 2;
            2: Break;
          End;
        End;

        If fPodeGerarGuia Then
        Begin

          Try
            WSGnre := TWSGnre.Create(Self);

            pGnreConfigurar(WSGnre);
            pGnrePreencherGuia(WSGnre);

            LResultado := fGnreEnviar(WSGnre);

            If not LRejeicao Then
              LRejeicao := not LResultado;

            If LRejeicao Then
              Break;

          Finally
            FreeAndNil(WSGnre);
          End;

        End;
      End;

      pGnreRejeicao(LRejeicao);

      pgbProgresso.Position := cdsConsulta.Recno;

      Application.ProcessMessages;

      cdsConsulta.Next;
    End;

    cdsConsulta.DisableControls;

    If fUsaExportacaoAutomaticaDeGuiasPDF Then
      pGnreGeraExportacaoAutomaticaDeGuiasPDF
    Else
      pGnreImprimirGuias;

  Except
    On E: Exception Do
    Begin
      If fInTransaction Then
        fRollBack;

      cdsConsulta.EnableControls;
      pMensagensErro(E.Message, '[TfrmGNREConfirmacao.fGerarGuias]');
    End;
  End;

end;

end.
