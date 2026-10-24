unit untCadDespFin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, Vcl.AppEvnts, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, Vcl.Mask, MaskEditFocus, Data.DB, MemDS, DBAccess,
  Uni, Vcl.DBCtrls, DBEditFocus, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, System.StrUtils,
  cxTextEdit, cxMaskEdit, cxDBEdit, EditFocus, dxBarBuiltInMenu, cxPC, frxClass,
  frxExportCSVTestabilidade, Vcl.Menus, BitBtnLockedIncrem, Vcl.ComCtrls,
  untTypesSistema;

type
  TfrmCadDespFin = class(TfrmPaiCad)
    dtsTabela: TDataSource;
    pnlDados: TPanel;
    Label2: TLabel;
    Label5: TLabel;
    Label3: TLabel;
    lblCliFor: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label18: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    edtCodIte: TDBEditFocus;
    edtValOpe: TDBEditFocus;
    gpbDadosPis: TGroupBox;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    edtCstPis: TDBEditFocus;
    edtBasPis: TDBEditFocus;
    edtAlqPis: TDBEditFocus;
    edtValPis: TDBEditFocus;
    edtCodigoParticipante: TDBEditFocus;
    gpbDadosCofins: TGroupBox;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    edtCstCof: TDBEditFocus;
    edtBasCof: TDBEditFocus;
    edtAlqCof: TDBEditFocus;
    edtValCof: TDBEditFocus;
    edtCodContAna: TDBEditFocus;
    edtCodCC: TDBEditFocus;
    edtDesDocOpe: TDBEditFocus;
    rgIndicadorOrigemCredito: TRadioGroup;
    edtCodBasCalcCredito: TDBEditFocus;
    edtNomeParticipante: TEditFocus;
    edtDesIte: TEditFocus;
    edtDesCC: TEditFocus;
    edtTipFc: TDBEditFocus;
    tsDocumento: TTabSheet;
    rgIndOrigem: TRadioGroup;
    GroupBox1: TGroupBox;
    Label17: TLabel;
    Label20: TLabel;
    edtCstPisD: TEditFocus;
    edtAlqPisD: TEditFocus;
    GroupBox2: TGroupBox;
    Label22: TLabel;
    Label24: TLabel;
    edtAlqCofD: TEditFocus;
    edtCstCofD: TEditFocus;
    rgTipoOperacao: TRadioGroup;
    btnGravarDocumentos: TBitBtnLocked;
    edtDtaOpe: TDBEditFocus;
    GroupBox3: TGroupBox;
    Label1: TLabel;
    Label19: TLabel;
    mskDtaIni: TcxMaskEdit;
    mskDtaFin: TcxMaskEdit;
    GroupBox4: TGroupBox;
    Label21: TLabel;
    edtCodCca: TEditFocus;
    btnExcluirDoc: TBitBtnLocked;
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure dtsTabelaStateChange(Sender: TObject);
    procedure edtCodigoParticipanteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodigoParticipanteExit(Sender: TObject);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCCKeyPress(Sender: TObject; var Key: Char);
    procedure edtCstPisKeyPress(Sender: TObject; var Key: Char);
    procedure edtCstCofKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodContAnaKeyPress(Sender: TObject; var Key: Char);
    procedure btnGravarDocumentosClick(Sender: TObject);
    procedure pgcDadosChange(Sender: TObject);
    procedure btnExcluirDocClick(Sender: TObject);
    procedure mskDtaIniKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure mskDtaFinKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodCcaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodIteExit(Sender: TObject);
    procedure edtCodCCExit(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure edtCodBasCalcCreditoKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    qryCadDef: TUniQuery;
    blnUsaPlanco: Boolean;

    function fRetornaPlanoContabil(strPlaCon: string): string;
    function fRetornaBasCalcCredito(strCodigo: string): string;
    procedure pLimpaDadosDocumento;
    procedure pAtivaDadosDocumento(blnHabilita: Boolean);
    procedure pFormataCampos;

    procedure pValidaClienteSelecionado;
    procedure pValidaFornecedorSelecionado;

    function  fDocumentoSQL: String;
    function  fCarregaDocumentos: Boolean;
    procedure pDateTimeFieldSetText(Field: TField; const Text: string);
    function fValidaDadosDocumento(blnGravacao: Boolean): Boolean;
  protected
    procedure pInicializaIndices; override;
  public
    { Public declarations }
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmCadDespFin: TfrmCadDespFin;

implementation

uses untFuncoesSimples, untConsultas, untFuncoes, untFuncoesConsulta,
  Contabilidade.Funcoes, untFechamentoEstoque, untFechamentoFiscal;

{$R *.dfm}

function TfrmCadDespFin.fRetornaPlanoContabil(strPlaCon: string): string;
begin
  if blnUsaPlanco then
    Result := fCampoTabela('NCO_DESCRI', 'PLANCO', ['REPLACE(REPLACE(REPLACE(REPLACE(NCO_CODCON, " ", ""), ".", ""), ":", ""), "\t", "")'], [fSemMascaraPlaNco(strPlaCon)], False)
  else
    Result := fCampoTabela('CON_CODCTA', 'PLACON', ['REPLACE(REPLACE(REPLACE(REPLACE(CON_CODCTA, " ", ""), ".", ""), ":", ""), "\t", "")'], [fSemMascaraPlaNco(strPlaCon)], False);
end;

function TfrmCadDespFin.fRetornaBasCalcCredito(strCodigo: string): string;
begin
  Result := fCampoTabela('FIN_DESCRI', 'CBCFIN', ['FIN_CODIGO'], [strCodigo], False);
end;

procedure TfrmCadDespFin.btnCancelaClick(Sender: TObject);
begin
  inherited;
  edtCodigoParticipanteExit(Sender);
  edtCodIteExit(Sender);
  edtCodCCExit(Sender);
end;

procedure TfrmCadDespFin.btnExcluirClick(Sender: TObject);
begin

  If Not fEmptyStr(fTiraCaracEspeciais(edtDtaOpe.Text)) Then
  Begin
    If Not TFechamentoEstoque.fDataDeEntradaPermitida(StrToDate(edtDtaOpe.Text)) Then
      Exit;

    If Not TFechamentoFiscal.fDataFiscalPermitida(StrToDate(edtDtaOpe.Text)) Then
      Exit;
  End;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadFornecedores.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
  Begin
    fCommit;
    edtCodigoParticipanteExit(Sender);
    edtCodIteExit(Sender);
    edtCodCCExit(Sender);
  End
  Else
    fRollBack;
end;

procedure TfrmCadDespFin.btnExcluirDocClick(Sender: TObject);
  var
    qryAux: TUniquery;
    blnEncontrou: Boolean;
begin

  blnEncontrou := True;

  If fValidaDadosDocumento(False) Then
  Begin
    If fMensagem('CONFIRMAÇÃO','Confirma exclusão das despesas financeiras no período de "'+
                                formatDateTime('dd-mm-yyyy', strToDate(mskDtaIni.text))+'" até "'+
                                formatDateTime('dd-mm-yyyy', strToDate(mskDtaFin.text))+
                                '" e conta analítica "'+edtCodCca.Text+'" ?'
                               ,['&Sim','&Não'],1) = 1 Then
    Begin

      If Not TFechamentoEstoque.fDataDeEntradaPermitida(StrToDate(mskDtaIni.Text)) Then
        Exit;

      If Not TFechamentoFiscal.fDataFiscalPermitida(StrToDate(mskDtaIni.Text)) Then
        Exit;

      try
        qryAux := fCriaQuery;
        try
          qryAux.SQL.Text := 'SELECT * FROM CADDEF WHERE DEF_CODCCA = :CODCCA AND DEF_DTAOPE BETWEEN :DTAINI AND :DTAFIN';
          qryAux.ParamByName('CODCCA').AsString := edtCodCca.Text;
          qryAux.ParamByName('DTAINI').AsString := FormatDateTime('yyyy-mm-dd', strtodate(mskDtaIni.Text));
          qryAux.ParamByName('DTAFIN').AsString := FormatDateTime('yyyy-mm-dd', strtodate(mskDtaFin.Text));
          qryAux.Open;
          If Not qryAux.IsEmpty Then
          Begin
            qryAux.SQL.Text := 'DELETE FROM CADDEF WHERE DEF_CODCCA = :CODCCA AND DEF_DTAOPE BETWEEN :DTAINI AND :DTAFIN';
            qryAux.ParamByName('CODCCA').AsString := edtCodCca.Text;
            qryAux.ParamByName('DTAINI').AsString := FormatDateTime('yyyy-mm-dd', strtodate(mskDtaIni.Text));
            qryAux.ParamByName('DTAFIN').AsString := FormatDateTime('yyyy-mm-dd', strtodate(mskDtaFin.Text));
            qryAux.ExecSQL;
          End
          Else
            blnEncontrou := False;
        finally
          qryAux.Free;
          qryTabela.Refresh;
          If blnEncontrou Then
            pMensagemOk('Despesas Financeiras excluídas com sucesso!')
          Else
            pMensagemOk('Nenhuma Despesa Financeira foi encontrada com essas informações!');
        end;
      except
        On E: Exception Do
        Begin
          Raise Exception.Create('Erro ao excluir os dados da CADDEF. ' + E.Message);
        End;
      end;
    End;
  End
  Else
  Begin
    pMensagemOk('Favor preencher "Data Inicial", "Data Final" e "Cód. Cont. Analítica" corretamente!');
  End;
end;

procedure TfrmCadDespFin.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pSetFocus(edtDtaOpe);
end;

procedure TfrmCadDespFin.btnGravarClick(Sender: TObject);
begin

  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  If Not fEmptyStr(fTiraCaracEspeciais(edtDtaOpe.Text)) Then
  Begin
    If Not TFechamentoEstoque.fDataDeEntradaPermitida(StrToDate(edtDtaOpe.text)) Then
      Exit;

    If Not TFechamentoFiscal.fDataFiscalPermitida(StrToDate(edtDtaOpe.text)) Then
      Exit;
  End;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    qryTabela.FieldByName('DEF_CODEMP').AsString := VS_strCodEmp;
    qryTabela.FieldByName('DEF_INDORI').AsInteger := rgIndicadorOrigemCredito.ItemIndex;
    If (fEmptyStr(edtDtaOpe.Text)) Then
      qryTabela.FieldByName('DEF_DTAOPE').AsVariant := Null;
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadDespFin.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;

end;

function TfrmCadDespFin.fValidaDadosDocumento(blnGravacao: Boolean): Boolean;
var
  blnRetorno : Boolean;
begin

  blnRetorno := True;

  If blnGravacao Then
  Begin
    if fEmptyStr(edtCstPisD.Text) then
      blnRetorno := False;
    if fEmptyStr(edtCstCofD.Text) then
      blnRetorno := False;
    if StrToFloatDef(edtAlqPisD.Text, 0) <= 0 then
      blnRetorno := False;
    if StrToFloatDef(edtAlqCofD.Text, 0) <= 0 then
      blnRetorno := False;
  End;

  if fEmptyStr(edtCodCca.Text) then
    blnRetorno := False;
  Try
    StrToDate(mskDtaIni.Text);
  Except
    blnRetorno := False;
  End;
  Try
    StrToDate(mskDtaFin.Text);
  Except
    blnRetorno := False;
  End;

  Result := blnRetorno;
end;

procedure TfrmCadDespFin.btnGravarDocumentosClick(Sender: TObject);
begin
  try
    if fValidaDadosDocumento(True) then
    Begin
      If Not TFechamentoEstoque.fDataDeEntradaPermitida(StrToDate(mskDtaIni.Text)) Then
        Exit;

      If Not TFechamentoFiscal.fDataFiscalPermitida(StrToDate(mskDtaIni.Text)) Then
        Exit;

      If fCarregaDocumentos Then
      Begin
        pLimpaDadosDocumento;
        pMensagemOk('Registros gravados!');
      End
      Else
      Begin
        pMensagemOk('Dados não encontrados! Gravação não efetuada!');
      End;
    End
    Else
    Begin
      pMensagemOk('Favor preencher todas as informações corretamente!');
    End;
  Except
    On E: Exception Do
    Begin
      Raise Exception.Create('Erro ao processar os dados. ' + E.Message);
    End;
  End;
end;

procedure TfrmCadDespFin.btnIncluirClick(Sender: TObject);
begin
  inherited;
  edtCodigoParticipanteExit(Sender);
  edtCodIteExit(Sender);
  edtCodCCExit(Sender);
  pSetFocus(edtDtaOpe);
end;

procedure TfrmCadDespFin.btnPesquisaClick(Sender: TObject);
  var
    chrKey: Char;
    arrConsulta: TConsultasArray;
begin
  chrKey := '/';
  If fPesqDespesaFinanceira(Self, qryTabela, chrKey, arrConsulta) Then
  Begin
    rgIndicadorOrigemCredito.ItemIndex := qryTabela.FieldByName('DEF_INDORI').AsInteger;
    edtCodigoParticipanteExit(Sender);
    edtCodIteExit(Sender);
    edtCodCCExit(Sender);
    pFormataCampos;
    pSetFocus(btnAlterar);
  End;
end;

procedure TfrmCadDespFin.pgcDadosChange(Sender: TObject);
var
  blnDocumento: Boolean;
begin
  If pgcDados.Pages[tsDocumento.PageIndex].Showing Then
  Begin
    blnDocumento := Not(qryTabela.State in [dsInsert, dsEdit]);

    if Not blnDocumento then
    Begin
      If fMensagem('CONFIRMAÇÃO','A aba "Documentos" permite inserir e excluir Despesas Financeiras em massa. '+
                                  'Caso você deseje entrar nessa rotina, sua operação atual será cancelada. '+
                                  'Deseja continuar ?'
                                 ,['&Sim','&Não'],1) = 1 Then
        blnDocumento := True;
    End;

    If blnDocumento Then
    Begin
      btnCancela.Click;
      pAtivaDadosDocumento(True);
      pnlBotoes.Enabled := False;
    End
    Else
      pgcDados.ActivePage:= tbsGeral;
  End
  Else If pgcDados.Pages[tbsGeral.PageIndex].Showing Then
  Begin
    pLimpaDadosDocumento;
    pAtivaDadosDocumento(False);
    pnlBotoes.Enabled := True;
  End;
end;

procedure TfrmCadDespFin.dtsTabelaStateChange(Sender: TObject);
begin
  inherited;

  rgIndicadorOrigemCredito.Enabled := qryTabela.State in [dsInsert, dsEdit];
end;

procedure TfrmCadDespFin.edtCodCCExit(Sender: TObject);
  Var
    arrCentroCusto: TConsultasArray;
begin
  inherited;
  pEdtCodSelectExit(edtCodCC,edtDesCC,arrCentroCusto,fRetDescCentroCusto,nil,'do Centro de Custo');
end;

procedure TfrmCadDespFin.edtCodCCKeyPress(Sender: TObject; var Key: Char);
  Var
    arrCentroCusto: TConsultasArray;
begin
  inherited;
  if fPesqCentroCusto(Self, edtCodCC, edtDesCC, nil, Key, arrCentroCusto) then
  Begin
    If fValidaCampos(edtCodCC, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadDespFin.edtCodContAnaKeyPress(Sender: TObject; var Key: Char);
var
  arrPlaCon: TConsultasArray;
  qryConsulta: TUniQuery;
begin
  inherited;
  if fEntraCons(Key) then
  begin
    try
      qryConsulta := fCriaQuery;
      try
        if blnUsaPlanco then
        begin
          if fPesqPlanoContabil(Self, edtCodContAna, nil, nil, Key, arrPlaCon) then
          begin
            If fValidaCampos(edtCodContAna, True) Then
              SelectNext(ActiveControl, True, True);
            Key := Char(0);
          end;
        end
        else
        begin
          if fPesqPlanoContasContabil(Self, nil, nil, qryConsulta, Key, arrPlaCon) then
          begin
            edtCodContAna.Text := qryConsulta.FieldByName('CON_CODCTA').AsString;
            if fValidaCampos(edtCodContAna, True) then
              SelectNext(ActiveControl, True, True);
            Key := Char(0);
          end;
        end;
      except
        on E: Exception do
          pMensagensErro(E.Message,'');
      end;
    finally
      FreeAndNil(qryConsulta);
    end;
  end;
end;

procedure TfrmCadDespFin.edtCodBasCalcCreditoKeyPress(Sender: TObject;
  var Key: Char);
var
  arrBaseCalcCred: TConsultasArray;
  qryConsulta: TUniQuery;
begin
  inherited;
  if fEntraCons(Key) then
  begin
    try
      qryConsulta := fCriaQuery;
      if fPesqBaseCalculoCredito(Self, qryConsulta, Key, arrBaseCalcCred) then
      begin
        edtCodBasCalcCredito.Text := qryConsulta.FieldByName('FIN_CODIGO').AsString;
        if fValidaCampos(edtCodBasCalcCredito, True) then
          SelectNext(ActiveControl, True, True);
        Key := Char(0);
      end;
    finally
      FreeAndNil(qryConsulta);
    end;
  end;
end;

procedure TfrmCadDespFin.edtCodCcaKeyPress(Sender: TObject; var Key: Char);
var
  arrPlaCon: TConsultasArray;
  qryConsulta: TUniQuery;
begin
  inherited;
  if fEntraCons(Key) then
  begin
    try
      qryConsulta := fCriaQuery;
      try
        if blnUsaPlanco then
        begin
          if fPesqPlanoContabil(Self, edtCodCca, nil, nil, Key, arrPlaCon) then
          begin
            If fValidaCampos(edtCodCca, True) Then
              SelectNext(ActiveControl, True, True);
            Key := Char(0);
          end;
        end
        else
        begin
          if fPesqPlanoContasContabil(Self, nil, nil, qryConsulta, Key, arrPlaCon) then
          begin
            edtCodCca.Text := qryConsulta.FieldByName('CON_CODCTA').AsString;
            if fValidaCampos(edtCodCca, True) then
              SelectNext(ActiveControl, True, True);
            Key := Char(0);
          end;
        end;
      except
        on E: Exception do
          pMensagensErro(E.Message,'');
      end;
    finally
      FreeAndNil(qryConsulta);
    end;
  end;
end;

procedure TfrmCadDespFin.edtCodigoParticipanteExit(Sender: TObject);
begin
  inherited;
  If edtTipFc.Text = 'C' Then
    pValidaClienteSelecionado
  Else
    pValidaFornecedorSelecionado;
end;

procedure TfrmCadDespFin.edtCodigoParticipanteKeyPress(Sender: TObject; var Key: Char);
  Var
    arrCliFor: TConsultasArray;
begin
  inherited;

  If edtTipFc.Text = 'C' Then
  Begin
    if fPesqCliente(conCliSimples, Self, edtCodigoParticipante, edtNomeParticipante, nil, Key, arrCliFor) then
    Begin
      If fValidaCampos(edtCodigoParticipante, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  End
  Else
  Begin
    if fPesqFornecedor(conForSimples, Self, edtCodigoParticipante, edtNomeParticipante, nil, Key, arrCliFor) then
    Begin
      If fValidaCampos(edtCodigoParticipante, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmCadDespFin.edtCodIteExit(Sender: TObject);
  Var
    arrItem: TConsultasArray;
begin
  inherited;
  pEdtCodSelectExit(edtCodIte,edtDesIte,arrItem,nil,fRetNomProduto,'do Produto');
end;

procedure TfrmCadDespFin.edtCodIteKeyPress(Sender: TObject; var Key: Char);
  Var
    arrItem: TConsultasArray;
begin
  inherited;
  if fPesqItem(conIteSimples, Self, edtCodIte, edtDesIte, nil, Key, arrItem) then
  Begin
    If fValidaCampos(edtCodIte, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadDespFin.edtCstCofKeyPress(Sender: TObject; var Key: Char);
  Var
    arrCstCof: TConsultasArray;
begin
  inherited;
  if fPesqCSTCof(Self, edtCstCof, nil, nil, Key, arrCstCof) then
  Begin
    If fValidaCampos(edtCstCof, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadDespFin.edtCstPisKeyPress(Sender: TObject; var Key: Char);
  Var
    arrCstPis: TConsultasArray;
begin
  inherited;
  if fPesqCSTPIS(Self, edtCstPis, nil, nil, Key, arrCstPis) then
  Begin
    If fValidaCampos(edtCstPis, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmCadDespFin.fDocumentoSQL: String;
  var
    strSQL:          String;
    strSQLDescontos: String;
    strSQLJuros:     String;
    strTipoOperacao: String;
    strIndOrig:      String;
    strCstPis:       String;
    strCstCof:       String;
    strAlqPis:       String;
    strAlqCof:       String;
    strCodCca:       String;
    strDtaIni:       String;
    strDtaFin:       String;
begin

  strTipoOperacao := intToStr(rgTipoOperacao.ItemIndex);
  strIndOrig      := intToStr(rgIndOrigem.IteMIndex);
  strCstPis := edtCstPisD.Text;
  strCstCof := edtCstCofD.Text;
  strAlqPis := fFloatToStrPonto(strToFloat(edtAlqPisD.Text), 12, 2);
  strAlqCof := fFloatToStrPonto(strToFloat(edtAlqCofD.Text), 12, 2);
  strCodCca := edtCodCca.Text;
  strDtaIni := FormatDateTime('yyyy-mm-dd',strToDate(mskDtaIni.Text));
  strDtaFin := FormatDateTime('yyyy-mm-dd',strToDate(mskDtaFin.Text));

  strSQL :=

//======================================================================================================================================================================
// DESCONTOS OBTIDOS:
//======================================================================================================================================================================
  ' SET @TIPO_OPERACAO = "'+ strTipoOperacao +'"; '+ //NÃO PRECISA, POIS VALIDA NO JAVA.
  ' SET @IND_ORIG = "'+ strIndOrig +'"; '+
  ' SET @CSTPIS = "'+strCstPis+'"; '+
  ' SET @CSTCOF = "'+strCstCof+'"; '+
  ' SET @ALQPIS = '+strAlqPis+'; '+
  ' SET @ALQCOF = '+strAlqCof+'; '+
  ' SET @CODCCA = "'+strCodCca+'"; '+
  ' SET @DTAINI = "'+strDtaIni+'"; '+
  ' SET @DTAFIN = "'+strDtaFin+'"; ';

  strSQLDescontos :=

  ' SELECT DISTINCT '+
  ' "F100",'+
  ' CTP_CODEMP AS CODEMP, '+
  ' CON_TIPLAN, '+
  ' CON_DESVAL, '+
  ' @TIPO_OPERACAO AS TIPO_OPERACAO, '+ //'TIPO DA OPERAÇÃO', # o cliente deverá optar entre as opções 0, 1 e 2.
  ' CTP_CODFOR AS CODFOR, ' + //CODIGO DO PARTICIPANTE'
  //'ITEM', #não enviar, por ser por documento.
  ' CTP_DTAPAG AS DATA,   '+
  ' CTP_VALDES AS VALOR,  '+
  ' @CSTPIS as CSTPIS,    '+ //# o cliente deverá informar a CST para o PIS.
  ' CTP_VALDES AS BC_PIS, '+
  ' @ALQPIS AS ALQPIS,    '+// # o cliente deverá informar a aliquota para o PIS
  ' (IFNULL(CTP_VALDES, 0) * @ALQPIS) AS VLR_PIS, '+// # valor da base do PIS multiplicado pela aliquota do PIS
  ' @CSTCOF AS CSTCOF,    '+// #o cliente deverá informar a CST para a COIFNS
  ' CTP_VALDES AS BC_COFINS, '+
  ' @ALQCOF AS ALQCOF,    '+// # o cliente deverá informar a aliquoota para a COFINS
  ' (IFNULL(CTP_VALDES, 0) * @ALQCOF) AS VLR_COFINS, '+// ## valor da base do PIS multiplicado pela aliquota da COFINS
  //'NATREC', #não enviar
  ' @IND_ORIG AS IND_ORIG, '+// # o cliente deverá optar entre 0 e 1
  ' @CODCCA AS CODCCA,     '+// # SELECT CON_CONCRE FROM LANCON WHERE CON_TIPLAN = 'CTP' AND CON_DESVAL = 'Vr.Descontos' AND CON_CONCRE = '331010004' 'CONTA SELECIONADA PELO CLIENTE'
  //'COD_CUS', #não enviar
  ' CON_HISTOR AS DESC_DOC_OPE '+ //# SELECT CON_HISTOR,CON_CONCRE, CON_INCDOC FROM LANCON WHERE CON_TIPLAN = 'CTP' AND CON_DESVAL = 'Vr.Descontos' AND CON_CONCRE = 'CONTA SELECIONADA PELO CLIENTE'
  ' FROM '+
  ' CADPAG '+
  ' JOIN LANCON ON CON_INCDOC = CADPAG.AUTOINCREM '+
  ' WHERE '+
  ' CTP_DTAPAG BETWEEN @DTAINI AND @DTAFIN '+
  ' AND CTP_VALDES > 0 '+
  ' AND CON_TIPLAN = "CTP" '+
  ' AND CON_DESVAL = "Vr.Descontos" ';
  //' AND CON_CONCRE = @CODCCA ';

  strSQLJuros := AnsiReplaceText(strSQLDescontos, 'CADPAG', 'CADREC');
  strSQLJuros := AnsiReplaceText(strSQLJuros, '"CTP"', '"CTR"');
  strSQLjuros := AnsiReplaceText(strSQLJuros, '"Vr.Descontos"', '"Vr.Juros"');
  strSQLjuros := AnsiReplaceText(strSQLJuros, 'CTP_CODFOR', 'CTR_CODCLI');
  strSQLjuros := AnsiReplaceText(strSQLJuros, 'CTP_DTAPAG', 'CTR_DTAREC');
  strSQLjuros := AnsiReplaceText(strSQLJuros, 'CTP_VALDES', 'CTR_VALJUR');
  strSQLjuros := AnsiReplaceText(strSQLJuros, 'CTP_CODEMP', 'CTR_CODEMP');

  Result := strSQL + strSQLDescontos + ' UNION ALL ' + strSQLJuros;

end;

procedure TfrmCadDespFin.FormCreate(Sender: TObject);
var
  strSQL: String;
begin
  inherited;
  strNomeTabela := 'CADDEF';
  strNomeCampo  := 'AUTOINCREM';

  strSQL            := 'SELECT * FROM CADDEF';
  qryCadDef         := fCriarQuery(strSQL, Self);
  qryTabela         := qryCadDef;
  dtsTabela.DataSet := qryTabela;

  blnUsaPlanco := fCfgSpd('USAR_ABREVIACAO_CONTABIL_REG_0500') = 'S';
end;

procedure TfrmCadDespFin.FormShow(Sender: TObject);
begin
  inherited;

  pFormataCampos;
end;

function TfrmCadDespFin.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender)) Then
  Begin
    If (Sender = edtCodContAna) Then
    Begin
      If fEmptyStr(edtCodContAna.Text) Then
      Begin
        edtCodContAna.Clear;
      End
      Else
      Begin
        If fEmptyStr(fRetornaPlanoContabil(edtCodContAna.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Plano ' + IIF(blnUsaPlanco, '', 'de contas ') + 'contábil inexistente!', ['&OK']);
          Result := False;
        End;
      End;
    End
    Else If (Sender = edtCodCca) Then
    Begin
      If fEmptyStr(edtCodCca.Text) Then
      Begin
        edtCodCca.Clear;
      End
      Else
      Begin
        If fEmptyStr(fRetornaPlanoContabil(edtCodCca.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Plano ' + IIF(blnUsaPlanco, '', 'de contas ') + 'contábil inexistente!', ['&OK']);
          Result := False;
        End;
      End;
    End
    Else If Sender = edtDtaOpe Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(edtDtaOpe.Text)) Then
      Begin
        fMensagem('', 'O campo Data Inicial deve ser preenchido!', ['&O k']);
        Result := False;
      End;
    End
    Else If Sender = edtCodBasCalcCredito Then
    Begin
      If Not fEmptyStr(edtCodBasCalcCredito.Text) Then
      Begin
        If fEmptyStr(fRetornaBasCalcCredito(edtCodBasCalcCredito.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Código da Base de Cálculo dos Créditos inexistente!', ['&OK']);
          Result := False;
        End;
      End;
    End
    Else If (Sender = edtTipFc) Then
    Begin
      If (not fEmptyStr(edtTipFc.Text)) and (Pos(edtTipFc.Text, 'C_F_') <= 0) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'Informe (F) para Fornecedor ou (C) para Cliente!', ['&O k']);
      End;

      If (not fEmptyStr(edtTipFC.Text)) And Result Then
      Begin
        Case edtTipFC.Text[1] Of
          'C' : lblCliFor.Caption := 'Cliente';
          'F' : lblCliFor.Caption := 'Fornecedor';
        End;
      End;

      edtCodigoParticipante.Enabled := Result And (Not fEmptyStr(edtTipFC.Text));
    End
    Else If Sender = edtCstPis Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(edtCstPis.Text)) Then
      Begin
        fMensagem('', 'O campo CST de Pis deve ser preenchido!', ['&O k']);
        Result := False;
      End;
    End
    Else If Sender = edtCstCof Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(edtCstCof.Text)) Then
      Begin
        fMensagem('', 'O campo CST de Cofins deve ser preenchido!', ['&O k']);
        Result := False;
      End;
    End
    Else if ((Sender = edtBasPis) or (Sender = edtAlqPis)) Then
    Begin
      edtValPis.Field.Text := FloatToStr(StrToFloatDef(ReplaceStr(edtBasPis.Text, '.', ''), 0) / 100 * StrToFloatDef(ReplaceStr(edtAlqPis.Text, '.', ''), 0));
    End
    Else if ((Sender = edtBasCof) or (Sender = edtAlqCof)) Then
    Begin
      edtValCof.Field.Text := FloatToStr(StrToFloatDef(ReplaceStr(edtBasCof.Text, '.', ''), 0) / 100 * StrToFloatDef(ReplaceStr(edtAlqCof.Text, '.', ''), 0));
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCadDespFin.mskDtaFinKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If key = vk_return then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadDespFin.mskDtaIniKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If key = vk_return then
    SelectNext(ActiveControl, True, True);
end;

function TfrmCadDespFin.fCarregaDocumentos: Boolean;
  var
    qryAux: TUniquery;
begin
  qryAux := fCriaQuery;
  try
    qryAux.SQL.text := fDocumentoSQL;
    qryAux.Open;
    Result := Not qryAux.IsEmpty;

    qryAux.First;
    while not qryAux.eof do
    Begin
      qryTabela.Append;
      qryTabela.FieldByName('AUTOINCREM').AsString   := fRetAutoIncrem('CADDEF', VS_strCodEmp);
      qryTabela.FieldByName('DEF_CODPAR').AsString   := qryAux.FieldByName('CODFOR').AsString;
      qryTabela.FieldByName('DEF_DTAOPE').AsDateTime := qryAux.FieldByName('DATA').AsDateTime;
      qryTabela.FieldByName('DEF_VALOPE').AsFloat    := qryAux.FieldByName('VALOR').AsFloat;
      qryTabela.FieldByName('DEF_CSTPIS').AsString   := qryAux.FieldByName('CSTPIS').AsString;
      qryTabela.FieldByName('DEF_BASPIS').AsFloat    := qryAux.FieldByName('BC_PIS').AsFloat;
      qryTabela.FieldByName('DEF_ALQPIS').AsFloat    := qryAux.FieldByName('ALQPIS').AsFloat;
      qryTabela.FieldByName('DEF_VALPIS').AsFloat    := qryAux.FieldByName('VLR_PIS').AsFloat/100;
      qryTabela.FieldByName('DEF_CSTCOF').AsString   := qryAux.FieldByName('CSTCOF').AsString;
      qryTabela.FieldByName('DEF_BASCOF').AsFloat    := qryAux.FieldByName('BC_COFINS').AsFloat;
      qryTabela.FieldByName('DEF_ALQCOF').AsFloat    := qryAux.FieldByName('ALQCOF').AsFloat;
      qryTabela.FieldByName('DEF_VALCOF').AsFloat    := qryAux.FieldByName('VLR_COFINS').AsFloat/100;
      qryTabela.FieldByName('DEF_INDORI').AsString   := qryAux.FieldByName('IND_ORIG').AsString;
      qryTabela.FieldByName('DEF_CODCCA').AsString   := qryAux.FieldByName('CODCCA').AsString;
      qryTabela.FieldByName('DEF_OBSDOP').AsString   := qryAux.FieldByName('DESC_DOC_OPE').AsString;
      qryTabela.FieldByName('DEF_CODEMP').AsString   := qryAux.FieldByName('CODEMP').AsString;
      qryTabela.Post;
      qryAux.Next;
    End;

  finally
    freeAndNil(qryAux);
  end;
end;

procedure TfrmCadDespFin.pDateTimeFieldSetText(Field: TField; const Text: string);
begin
  if Text = '  /  /    ' then
    Field.AsString := ''
  else
    Field.AsString := Text;
end;

procedure TfrmCadDespFin.pFormataCampos;
begin
  TFloatField(qryTabela.FieldByName('DEF_VALOPE')).EditFormat := '#,##0.00';
  TFloatField(qryTabela.FieldByName('DEF_VALOPE')).DisplayFormat := '#,##0.00';

  TFloatField(qryTabela.FieldByName('DEF_BASPIS')).EditFormat := '#,##0.00';
  TFloatField(qryTabela.FieldByName('DEF_BASPIS')).DisplayFormat := '#,##0.00';

  TFloatField(qryTabela.FieldByName('DEF_ALQPIS')).EditFormat := '#,##0.00';
  TFloatField(qryTabela.FieldByName('DEF_ALQPIS')).DisplayFormat := '#,##0.00';

  TFloatField(qryTabela.FieldByName('DEF_VALPIS')).EditFormat := '#,##0.00';
  TFloatField(qryTabela.FieldByName('DEF_VALPIS')).DisplayFormat := '#,##0.00';

  TFloatField(qryTabela.FieldByName('DEF_BASCOF')).EditFormat := '#,##0.00';
  TFloatField(qryTabela.FieldByName('DEF_BASCOF')).DisplayFormat := '#,##0.00';

  TFloatField(qryTabela.FieldByName('DEF_ALQCOF')).EditFormat := '#,##0.00';
  TFloatField(qryTabela.FieldByName('DEF_ALQCOF')).DisplayFormat := '#,##0.00';

  TFloatField(qryTabela.FieldByName('DEF_VALCOF')).EditFormat := '#,##0.00';
  TFloatField(qryTabela.FieldByName('DEF_VALCOF')).DisplayFormat := '#,##0.00';

  TDateTimeField(qryTabela.FieldByName('DEF_DTAOPE')).EditMask := '!99/99/9999;1;';
  TDateTimeField(qryTabela.FieldByName('DEF_DTAOPE')).OnSetText := pDateTimeFieldSetText;
end;

procedure TfrmCadDespFin.pLimpaDadosDocumento;
  Var
    intContador: Integer;
begin
  For intContador := 0 To Self.ComponentCount -1 Do
  Begin
    If Self.Components[intContador] Is TcxMaskEdit Then
      (Self.Components[intContador] As TcxMaskEdit).Clear
    Else If Self.Components[intContador] Is TEditFocus Then
      (Self.Components[intContador] As TEditFocus).Clear
    Else If Self.Components[intContador] Is TRadioGroup Then
      (Self.Components[intContador] As TRadioGroup).itemIndex := 0;
  End;
end;

procedure TfrmCadDespFin.pAtivaDadosDocumento(blnHabilita: Boolean);
  Var
    intContador: Integer;
begin
  For intContador := 0 To Self.ComponentCount -1 Do
  Begin
    If Self.Components[intContador] Is TcxMaskEdit Then
      (Self.Components[intContador] As TcxMaskEdit).Enabled := blnHabilita
    Else If Self.Components[intContador] Is TEditFocus Then
      (Self.Components[intContador] As TEditFocus).Enabled := blnHabilita
    Else If Self.Components[intContador] Is TRadioGroup Then
      (Self.Components[intContador] As TRadioGroup).Enabled := blnHabilita;
  End;
end;

procedure TfrmCadDespFin.pValidaClienteSelecionado;
  Var
    strSql: String;
    qryAux: TUniQuery;
begin
  If Not fEmptyStr(edtCodigoParticipante.Text) Then
  Begin
    qryAux := fCriaQuery;
    Try
      strSql := 'SELECT CLI_CODCLI, CLI_NOMCLI FROM CADCLI WHERE CLI_CODCLI = :CODCLI';

      qryAux.SQL.Text := strSql;
      qryAux.ParamByName('CODCLI').AsString := edtCodigoParticipante.Text;
      qryAux.Open;

      edtCodigoParticipante.Text := qryAux.FieldByName('CLI_CODCLI').AsString;
      edtNomeParticipante.Text := qryAux.FieldByName('CLI_NOMCLI').AsString;

      If fEmptyStr(edtCodigoParticipante.Text) Then
      Begin
        fMensagem('Atenção', 'Cliente inválido.', ['OK']);
        pSetFocus(edtCodigoParticipante);
      End;
    Finally
      qryAux.Free;
    End;
  End
  Else
    edtNomeParticipante.Clear;
end;

procedure TfrmCadDespFin.pValidaFornecedorSelecionado;
  Var
    strSql: String;
    qryAux: TUniQuery;
begin
  If Not fEmptyStr(edtCodigoParticipante.Text) Then
  Begin
    qryAux := fCriaQuery;
    Try
      strSql := 'SELECT FOR_CODFOR, FOR_NOMFOR FROM CADFOR WHERE FOR_CODFOR = :CODFOR';

      qryAux.SQL.Text := strSql;
      qryAux.ParamByName('CODFOR').AsString := edtCodigoParticipante.Text;
      qryAux.Open;

      edtCodigoParticipante.Text := qryAux.FieldByName('FOR_CODFOR').AsString;
      edtNomeParticipante.Text := qryAux.FieldByName('FOR_NOMFOR').AsString;

      If fEmptyStr(edtCodigoParticipante.Text) Then
      Begin
        fMensagem('Atenção', 'Fornecedor inválido.', ['OK']);
        pSetFocus(edtCodigoParticipante);
      End;
    Finally
      qryAux.Free;
    End;
  End
  Else
    edtNomeParticipante.Clear;
end;

procedure TfrmCadDespFin.pInicializaIndices;
begin
  inherited;

  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;

  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('DEF_CODCCA');
  stlCamInd.Add('DEF_CODCTA');
  stlCamInd.Add('DEF_CODEMP');
end;

end.
