unit untRelComissaoProfissionalCTR;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiRelatorio, frxDesgn, frxClass, frxDBSet, frxDMPExport,
  frxExportPDF, frxExportHTML, frxExportXLS, frxExportRTF, untTypesSistema,
  RLFilters, RLDraftFilter, Menus, StdCtrls, EditFocus, QColorLabel,
  ExtCtrls, Buttons, Mask, MaskEditFocus, Uni, StrUtils, AppEvnts,
  UniDataSetProvider, DB, UniClientDataSet, untRelValorRecebidoProfissional, ComboBoxFocus,
  BitBtnLockedIncrem, Datasnap.Provider, frxExportCSVTestabilidade,
  Datasnap.DBClient, Vcl.DBCtrls, DBEditFocus, untFramePlanoDeContasMaskEdit;

type
  TfrmRelComissaoProfissionalCTR = class(TfrmPaiRelatorio)
    Label1: TLabel;
    mskDtaIni: TMaskEditFocus;
    Label2: TLabel;
    mskDtaFin: TMaskEditFocus;
    Label3: TLabel;
    edtCodEmp: TEditFocus;
    edtDesEmpresa: TEditFocus;
    edtCodProfissional: TEditFocus;
    edtDesProfissional: TEditFocus;
    frxComissaoProfissionalCTR_M: TfrxReport;
    frxCabecalho: TfrxUserDataSet;
    frxComissaoProfissionalCTR_J: TfrxReport;
    rdgTipRel: TRadioGroup;
    frxComissaoProfissionalSintCTR_M: TfrxReport;
    frxComissaoProfissionalSintCTR_J: TfrxReport;
    lblProfissional: TLabel;
    rdgPerCom: TRadioGroup;
    rdgComRes: TRadioGroup;
    frxComissaoProfissionalCTRP_J: TfrxReport;
    frxComissaoProfissionalCTRP_M: TfrxReport;
    grbRecibo: TGroupBox;
    Label5: TLabel;
    edtHisRec: TEditFocus;
    Label6: TLabel;
    mskDtaRec: TMaskEditFocus;
    Label7: TLabel;
    edtQtdVia: TEditFocus;
    frxUser: TfrxUserDataSet;
    chkConJur: TCheckBox;
    cdsRelatorio: TUniClientDataSet;
    dspRelatorio: TUniDataSetProvider;
    frxResumo: TfrxDBDataset;
    chkResumo: TCheckBox;
    rdgStatus: TRadioGroup;
    rdgPosCom: TRadioGroup;
    grbGerCadPag: TGroupBox;
    chkGerCadPag: TCheckBox;
    mskDtaVen: TMaskEditFocus;
    lblDtaVen: TLabel;
    fraPlanoDeContas: TfraPlanoDeContasMskEdit;
    procedure edtCodEmpExit(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodProfissionalKeyPress(Sender: TObject; var Key: Char);
    procedure btnImprimirClick(Sender: TObject);
    procedure frxCabecalhoGetValue(const VarName: String;
      var Value: Variant);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure rdgTipRelClick(Sender: TObject);
    procedure frxUserGetValue(const VarName: String; var Value: Variant);
    procedure frxUserFirst(Sender: TObject);
    procedure frxUserNext(Sender: TObject);
    procedure frxUserCheckEOF(Sender: TObject; var Eof: Boolean);
    procedure frxUserPrior(Sender: TObject);
    function frxComissaoProfissionalCTR_MUserFunction(const MethodName: String;
      var Params: Variant): Variant;
    procedure mskDtaFinExit(Sender: TObject);
    procedure edtCodProfissionalExit(Sender: TObject);
    procedure chkGerCadPagClick(Sender: TObject);
    procedure fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject; var Key: Char);
    procedure fraPlanoDeContasMskCodCtaExit(Sender: TObject);
  private
    { Private declarations }
    frxRel: TfrxReport;
    strValRec: String;
    intQtdVia: Integer;

    qryProfissional   : TUniQuery;
    qryRelatorio  : TUniQuery;
    qryResumo     : TUniQuery;
    relRecebido   : TValorRecebidoProfissional;

    strCodPro : String;

    strPerComAna: String;
    strValComAna: String;

    strPerComDivAna: String;
    strValComDivAna: String;

    strPerComTotAna: String;
    strValComTotAna: String;

    strPerComDivSin: String;
    strValComDivSin: String;

    strPerCo2DivSin: String;
    strPerCo2TotSin: String;

    strPerComTotSin: String;
    strValComTotSin: String;

    arrEmp     : TConsultasArray;
    arrProfiss : TConsultasArray;

    strEmp     : String;

    fltPmCmCr: Double;

    cdsResumoMod : TUniClientDataSet;

    function fGetSQLTotalAberto: String;
    Procedure pSetaPeriodoRecibo;

    procedure pAjustaPercentualDeComissao;

    Procedure pSetaProfissionalSintetico;
    Procedure pSetaProfissionalAnalitico;

    Procedure pSetaPadraoSintetico;
    Procedure pSetaPadraoAnalitico;

    procedure pMontaResumoModalidades(qryAnalitico: TUniQuery);
    function  fGetPosCom: TPosicaoComissao;
    function  fPossuiProfissionalSemFornecedor(Out strProfissionais: String): Boolean;
    function  fPossuiComissao: Boolean;
    procedure pMostrarMesagemProfissionais(strProfissionais: String);
    procedure pGravarComissao(strSQLAna: String);
    procedure pSetaParametros(qryRel: TUniQuery; blnClaFis: boolean);
    function fGetClienteDuplicata(strDuplic, strTabela: String): String;
  public
    { Public declarations }
    strEmpresa,
    strProfissional,
    strPeriodo: String;

    Function fGetSqlMovDet: String;

    Function fGetSQLSintetico(strSQLAnalitico: String): String;
    Function fGetSqlSinteticoMovDet(strAnalitico: String): String;

  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  end;

implementation

uses  untFuncoesSimples, untConstantes, untObservacao, untFuncoesConsulta,
  untConsultas, untValorPorExtenso, untCfgRel, untTGravaComissaoVen;

{$R *.dfm}

var
  arrModalidade: Array[0..4] Of String[20] = ('DINHEIRO', 'CHEQUE','CARTAO', 'ORDEM', 'FINANCEIRO');

procedure TfrmRelComissaoProfissionalCTR.chkGerCadPagClick(Sender: TObject);
begin
  inherited;

  If (chkGerCadPag.Checked) Then Begin
    edtDestino.Text := 'V';
    gpbDestino.Enabled := False;

    rdgTipRel.ItemIndex := 1;
    rdgTipRel.Enabled   := False;

    rdgPosCom.ItemIndex := 1;
    rdgPosCom.Enabled   := False;

    fraPlanoDeContas.MskCodCta.Enabled := True;
    fraPlanoDeContas.edtDesCta.Enabled := True;
    mskDtaVen.Enabled := True;
  End Else Begin
    edtDestino.Text := 'V';
    gpbDestino.Enabled := True;

    rdgTipRel.ItemIndex := 0;
    rdgTipRel.Enabled   := True;

    rdgPosCom.ItemIndex := 0;
    rdgPosCom.Enabled   := True;

    fraPlanoDeContas.MskCodCta.Enabled := False;
    fraPlanoDeContas.edtDesCta.Enabled := False;
    mskDtaVen.Enabled := False;

    fraPlanoDeContas.MskCodCta.Clear();
    fraPlanoDeContas.edtDesCta.Clear();
    mskDtaVen.Clear();
  End;
end;

procedure TfrmRelComissaoProfissionalCTR.edtCodEmpExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodEmp, edtDesEmpresa, arrEmp, Nil, fRetNomeEmpresaSelec, 'da empresa');
end;

procedure TfrmRelComissaoProfissionalCTR.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtDesEmpresa, Nil, Key, arrEmp, False, True) Then
  Begin
    If fValidaCampos(edtCodEmp, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmRelComissaoProfissionalCTR.fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean;
  Var
    intContador : Integer;
    intIndex : Integer;
begin

  Result := True;

  {*********************}
  {* VALIDA DATAS      *}
  {******************LU*}
  If (Sender = mskDtaIni) Or (Sender = mskDtaFin) Then
  Begin

    If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
    Begin
      fMensagem('', 'O campo Data Inicial deve ser preenchido!', ['&O k']);
      Result := False;
      If (Sender = mskDtaFin) Then
        Sender := mskDtaIni;
    End
    Else
    Begin
      If (Sender = mskDtaFin) Then
      Begin
        If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
        Begin
          fMensagem('', 'O campo Data Final deve ser preenchido!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
          Begin
            fMensagem('','A data inicial deve ser menor que a data final!',['&O K']);
            Result := False;
          End;
        End;
      End
    End;

  End
  Else If (Sender = edtCodProfissional) Then
  Begin

    If Not fEmptyStr(edtCodProfissional.Text) Then
    Begin
      If (fStrToFloat(edtCodProfissional.Text) <> 0) Then
      Begin
        strCodPro := edtCodProfissional.Text;
        edtDesProfissional.Text := fRetNomProfissional(strCodPro);
      End
      Else If Not fEmptyStr(edtCodProfissional.Text) Then
      Begin
        strCodPro := '';
        For intContador := 0 To High(arrProfiss) Do
        Begin
          If fEmptyStr(strCodPro) Then
            strCodPro := arrProfiss[intContador].strCodigo
          Else
            strCodPro := strCodPro + '_' + arrProfiss[intContador].strCodigo;
        End;
      End;

      pDesmarcaLista(edtCodProfissional, arrProfiss);
    End
    Else
    Begin
      edtDesProfissional.Text := 'TODOS';
      strCodPro := '';
    End;

    If fEmptyStr(edtDesProfissional.Text) Then
    Begin
      Result := False;
      fMensagem('','Profissional não encontrado.', ['&O K']);
    End;

  End
  Else If (Sender = edtCodEmp) Then
  Begin

    If Not fEmptyStr(edtCodEmp.Text) Then
    Begin
      If Length(arrEmp) > 0 Then
      Begin
        For intIndex := Low(arrEmp) To High(arrEmp) Do
        Begin
          If Pos(arrEmp[intIndex].strCodigo, strEmpAcessoUsuarioLogado) <= 0 Then
          Begin
            fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a Empresa ' + arrEmp[intIndex].strCodigo + '!', ['&O k']);
            Result := False;
            Break;
          End;
        End;
      End
      Else If Pos(edtCodEmp.Text, strEmpAcessoUsuarioLogado) <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
        Result := False;
      End;
    End
    Else
    Begin
      fMensagem('','O código da Empresa deve ser informado!',['&OK']);
      Result := False;
    End;

  End

  Else If (Sender = edtHisRec) And grbRecibo.Enabled Then
  Begin

    If fEmptyStr(edtHisRec.Text) Then
    Begin
      fMensagem('', 'O campo Histórico deve ser preenchido!', ['&O k']);
      Result := False;
    End;

  End

  Else If (Sender = mskDtaRec) And grbRecibo.Enabled Then
  Begin

    If fEmptyStr(fTiraCaracEspeciais(mskDtaRec.Text)) Then
    Begin
      fMensagem('', 'O campo Data do Recibo deve ser preenchido!', ['&O k']);
      Result := False;
    End

  End

  Else If (Sender = edtQtdVia) And grbRecibo.Enabled Then
  Begin

    If StrToIntDef(edtQtdVia.Text, 0) <= 0 Then
    Begin
      fMensagem('', 'A quantidade de vias deve ser maior que zero!', ['&O k']);
      Result := False;
    End

  End

  Else If (Sender = fraPlanoDeContas.MskCodCta) And (chkGerCadPag.Checked) Then Begin
    If (fraPlanoDeContas.MskCodCta.Enabled) Then Begin
      If (fEmptyStr(fTiraCaracEspeciais(fraPlanoDeContas.MskCodCta.Text))) Then
      Begin
        fMensagem('ATENÇÃO!', 'Plano de Contas deve ser preenchido!', ['&OK']);
        Result := False;
      End

      Else Begin
        fraPlanoDeContas.edtDesCta.Text := fRetNomeConta(fTiraCaracEspeciais(fraPlanoDeContas.MskCodCta.Text));

        If fEmptyStr(fraPlanoDeContas.edtDesCta.Text) Then Begin
          fMensagem('ATENÇÃO!', 'Plano de Contas não encontrado!', ['&OK']);
          Result := False;
        End;
      End;
    End;
  End

  Else If (Sender = mskDtaVen) And (chkGerCadPag.Checked) Then Begin
    If (fEmptyStr(Trim(fTiraCaracEspeciais(mskDtaVen.Text)))) Then Begin
      fMensagem('', 'Informe uma Data de Vencimento válida!', ['&OK']);
      Result := False;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmRelComissaoProfissionalCTR.edtCodProfissionalExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodProfissional, edtDesProfissional, arrProfiss, fRetNomDiversos, nil, 'do Profissional');
end;

procedure TfrmRelComissaoProfissionalCTR.edtCodProfissionalKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  if fPesqDiversos(Self, edtCodProfissional, edtDesProfissional, qryProfissional, Key, arrProfiss, False) then
  Begin
    If fValidaCampos(edtCodProfissional, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

Function TfrmRelComissaoProfissionalCTR.fGetSQLSintetico(strSQLAnalitico: String): String;
Begin
  Result :=          ' SELECT SQL_NO_CACHE                       ';
  Result := Result + '   CTR_CODDIV,                             ';
  Result := Result + '   DIV_NOMDIV,                             ';
  Result := Result + '   IFNULL(DIV_PERCOM,0) AS DIV_PERCOM,     ';
  Result := Result + '   0 AS CTR_VALFAT,                        ';
  Result := Result + '   PROFISSIONAL,                           ';
  Result := Result + '   0               AS CTR_ABERTO,          ';
  Result := Result + '   SUM(CTR_VALORI) AS CTR_VALORI,          ';
  Result := Result + '   SUM(CTR_VALJUR) AS CTR_VALJUR,          ';
  Result := Result + '   SUM(CTR_JURVIS) AS CTR_JURVIS,          ';
  Result := Result + '   SUM(CTR_JURPRA) AS CTR_JURPRA,          ';
  Result := Result + '   SUM(CTR_VALDES) AS CTR_VALDES,          ';
  Result := Result + '   SUM(CTR_VALREC) AS CTR_VALREC,          ';
  Result := Result + '   SUM(CTR_RECCOM) AS CTR_RECCOM,          ';
  Result := Result + '   SUM(CTR_RECIPI) AS CTR_RECIPI,          ';
  Result := Result + '   SUM(VLCOM_OPEAVI)   AS VLCOM_OPEAVI,    ';
  Result := Result + '   SUM(VLCOM_OPEAPR)   AS VLCOM_OPEAPR,    ';
  Result := Result + '   SUM(VALOR_COMISSAO) AS VALOR_COMISSAO,  ';
  Result := Result + '   SUM(CTR_AVISTA) AS CTR_AVISTA,          ';
  Result := Result + '   SUM(CTR_APRAZO) AS CTR_APRAZO           ';
  Result := Result + ' FROM  (' + strSQLAnalitico + ') AS TABELA ';
  Result := Result + ' GROUP BY CTR_CODDIV ';
End;

Function TfrmRelComissaoProfissionalCTR.fGetSqlTotalAberto: String;
  Var
    strSQL,
    strSum: String;
Begin
  strSQL := '';
  {***************************************************}
  {* CADREC DIRETA - SEM AGRUPAMENTO NEM CONFIRMAÇÃO *}
  {************************************************AC*}
  strSQL := strSQL + relRecebido.fGetSqlSemAgrupamentoNemConfirmacaoAberto('CADREC');
  strSQL := strSQL + '   UNION ALL  ';

  {***************************************************}
  {* CADREC PROVENIENTE DE CONFIRMAÇÃO DOCUMENTO     *}
  {************************************************AC*}
  strSQL := strSQL +  relRecebido.fGetSqlComConfirmacaoAberto('CADREC', 'CTRCNF');
  strSQL := strSQL + '   UNION ALL  ';

  {***************************************************}
  {* CADREC AGRUPAMENTO DIRETO                       *}
  {************************************************AC*}
  strSQL := strSQL +  relRecebido.fGetSqlComAgrupamentoDiretoAberto('CADREC', 'DUPAGR');
  strSQL := strSQL + '   UNION ALL  ';

  {***************************************************}
  {* CADREC AGRUPAMENTO CONFIRMAÇÃO                  *}
  {************************************************AC*}
  strSQL := strSQL +  relRecebido.fGetSqlAgrupamentoConfirmacaoAberto('CADREC',  'DUPAGR',  'CTRCNF');

  strSum := '';
  strSum := strSum + ' SELECT SQL_NO_CACHE              ';
  strSum := strSum + '   CTR_CODDIV,                    ';
  strSum := strSum + '   DIV_NOMDIV,                    ';
  strSum := strSum + '   DIV_PERCOM,                    ';
  strSum := strSum + '   0 AS CTR_VALFAT,               ';
  strSum := strSum + '   Profissional,                  ';
  strSum := strSum + '   SUM(CTR_ABERTO) AS CTR_ABERTO, ';
  strSum := strSum + '   0 AS CTR_VALORI,               ';
  strSum := strSum + '   0 AS CTR_VALJUR,               ';
  strSum := strSum + '   0 AS CTR_JURVIS,               ';
  strSum := strSum + '   0 AS CTR_JURPRA,               ';
  strSum := strSum + '   0 AS CTR_VALDES,               ';
  strSum := strSum + '   0 AS CTR_VALREC,               ';
  strSum := strSum + '   0 AS CTR_RECCOM,               ';
  strSum := strSum + '   0 AS CTR_RECIPI,               ';
  strSum := strSum + '   0 AS VLCOM_OPEAVI,             ';
  strSum := strSum + '   0 AS VLCOM_OPEAPR,             ';
  strSum := strSum + '   0 AS VALOR_COMISSAO,           ';
  strSum := strSum + '   0 AS CTR_AVISTA,               ';
  strSum := strSum + '   0 AS CTR_APRAZO                ';
  strSum := strSum + ' FROM (' + strSQL + ') AS TABABE ';
  strSum := strSum + ' GROUP BY CTR_CODDIV ';

  Result := strSum;
End;

Procedure TfrmRelComissaoProfissionalCTR.pSetaProfissionalSintetico;
Begin
  TfrxMemoView(frxRel.FindObject('rllPerComDiv')).Memo.Clear;
  TfrxMemoView(frxRel.FindObject('rllPerComDiv')).Memo.Add('[frxRelatorio."DIV_PERCOM"]');

  TfrxMemoView(frxRel.FindObject('rllPerCo2Div')).Memo.Clear;
  TfrxMemoView(frxRel.FindObject('rllPerCo2Div')).Memo.Add('[frxRelatorio."DIV_PERCOM"]');

  TfrxMemoView(frxRel.FindObject('rllValComDiv')).Memo.Clear;
  TfrxMemoView(frxRel.FindObject('rllValComDiv')).Memo.Add('[((<frxRelatorio."CTR_AVISTA"> * <frxRelatorio."DIV_PERCOM">)/100) + ((<frxRelatorio."CTR_APRAZO"> * <frxRelatorio."DIV_PERCOM">)/100)]');

  TfrxMemoView(frxRel.FindObject('rllPerComTot')).Memo.Clear;
  If relRecebido.blnConJur Then
    TfrxMemoView(frxRel.FindObject('rllPerComTot')).Memo.Add('[IIF(SUM(<frxRelatorio."CTR_AVISTA">) <> 0, (SUM(((<frxRelatorio."CTR_AVISTA"> * <frxRelatorio."DIV_PERCOM">)/100)) / SUM(<frxRelatorio."CTR_AVISTA">) ) * 100, 0)]')
  Else
    TfrxMemoView(frxRel.FindObject('rllPerComTot')).Memo.Add('[IIF(SUM(<frxRelatorio."CTR_AVISTA">) <> 0, (SUM(((<frxRelatorio."CTR_AVISTA"> * <frxRelatorio."DIV_PERCOM">)/100) - <frxRelatorio."CTR_JURVIS">) / SUM(<frxRelatorio."CTR_AVISTA">) ) * 100, 0)]');

  TfrxMemoView(frxRel.FindObject('rllPerCo2Tot')).Memo.Clear;
  If relRecebido.blnConJur Then
    TfrxMemoView(frxRel.FindObject('rllPerCo2Tot')).Memo.Add('[IIF(SUM(<frxRelatorio."CTR_APRAZO">) <> 0, (SUM(((<frxRelatorio."CTR_APRAZO"> * <frxRelatorio."DIV_PERCOM">)/100)) / SUM(<frxRelatorio."CTR_APRAZO">) ) * 100, 0)]')
  Else
    TfrxMemoView(frxRel.FindObject('rllPerCo2Tot')).Memo.Add('[IIF(SUM(<frxRelatorio."CTR_APRAZO">) <> 0, (SUM(((<frxRelatorio."CTR_APRAZO"> * <frxRelatorio."DIV_PERCOM">)/100) - <frxRelatorio."CTR_JURPRA">) / SUM(<frxRelatorio."CTR_APRAZO">) ) * 100, 0)]');

  TfrxMemoView(frxRel.FindObject('rllValComTot')).Memo.Clear;
  TfrxMemoView(frxRel.FindObject('rllValComTot')).Memo.Add('[SUM(((<frxRelatorio."CTR_AVISTA"> * <frxRelatorio."DIV_PERCOM">)/100) + ((<frxRelatorio."CTR_APRAZO"> * <frxRelatorio."DIV_PERCOM">)/100))]');
End;

Procedure TfrmRelComissaoProfissionalCTR.pSetaProfissionalAnalitico;

  function fVistaPrazo: String;
  begin
    Result := 'IIF(<frxRelatorio."CTR_FORMAPG"> = ' + #39 + 'A' + #39 + ', <frxRelatorio."DIV_PERCOM">, <frxRelatorio."DIV_PERCOM">)';
  end;

  function fFrxCom: String;
  begin
    If relRecebido.blnConJur Then
      Result := '(' + fVistaPrazo + ' * <frxRelatorio."CTR_VALREC">) / 100'
    Else
      Result := '(' + fVistaPrazo + ' * (<frxRelatorio."CTR_VALREC"> - <frxRelatorio."CTR_VALJUR">))/ 100'
  end;

Begin
  TfrxMemoView(frxRel.FindObject('rllPerComAna')).Memo.Clear;
  TfrxMemoView(frxRel.FindObject('rllPerComAna')).Memo.Add('[frxRelatorio."DIV_PERCOM"]');

  TfrxMemoView(frxRel.FindObject('rllValComAna')).Memo.Clear;
  TfrxMemoView(frxRel.FindObject('rllValComAna')).Memo.Add('[' + fFrxCom + ']');

  TfrxMemoView(frxRel.FindObject('rllPerComDiv')).Memo.Clear;

  If relRecebido.blnConJur Then
    TfrxMemoView(frxRel.FindObject('rllPerComDiv')).Memo.Add('[SUM(' + fFrxCom + ') / SUM(<frxRelatorio."CTR_VALREC">) * 100]')
  Else
    TfrxMemoView(frxRel.FindObject('rllPerComDiv')).Memo.Add('[SUM(' + fFrxCom + ') / SUM(<frxRelatorio."CTR_VALREC"> - <frxRelatorio."CTR_VALJUR">) * 100]');

  TfrxMemoView(frxRel.FindObject('rllValComDiv')).Memo.Clear;
  TfrxMemoView(frxRel.FindObject('rllValComDiv')).Memo.Add('[SUM(' + fFrxCom + ')]');

  TfrxMemoView(frxRel.FindObject('rllPerComTot')).Memo.Clear;
  If relRecebido.blnConJur Then
    TfrxMemoView(frxRel.FindObject('rllPerComTot')).Memo.Add('[SUM(' + fFrxCom + ') / SUM(<frxRelatorio."CTR_VALREC">) * 100]')
  Else
    TfrxMemoView(frxRel.FindObject('rllPerComTot')).Memo.Add('[SUM(' + fFrxCom + ') / SUM(<frxRelatorio."CTR_VALREC"> - <frxRelatorio."CTR_VALJUR">) * 100]');

  TfrxMemoView(frxRel.FindObject('rllValComTot')).Memo.Clear;
  TfrxMemoView(frxRel.FindObject('rllValComTot')).Memo.Add('[SUM(' + fFrxCom + ')]');
End;

Procedure TfrmRelComissaoProfissionalCTR.pSetaPadraoSintetico;
Begin
  TfrxMemoView(frxRel.FindObject('rllPerCo2Tit')).Visible := False;
  TfrxMemoView(frxRel.FindObject('rllPerCo2Div')).Visible := False;
  TfrxMemoView(frxRel.FindObject('rllPerCo2Tot')).Visible := False;

  TfrxMemoView(frxRel.FindObject('rllPerComDiv')).Memo.Clear;
  TfrxMemoView(frxRel.FindObject('rllPerComDiv')).Memo.Add(strPerComDivSin);

  TfrxMemoView(frxRel.FindObject('rllValComDiv')).Memo.Clear;
  TfrxMemoView(frxRel.FindObject('rllValComDiv')).Memo.Add(strValComDivSin);

  TfrxMemoView(frxRel.FindObject('rllPerComTot')).Memo.Clear;
  TfrxMemoView(frxRel.FindObject('rllPerComTot')).Memo.Add(strPerComTotSin);

  TfrxMemoView(frxRel.FindObject('rllValComTot')).Memo.Clear;
  TfrxMemoView(frxRel.FindObject('rllValComTot')).Memo.Add(strValComTotSin);
End;

Procedure TfrmRelComissaoProfissionalCTR.pSetaPadraoAnalitico;
Begin
  TfrxMemoView(frxRel.FindObject('rllPerComAna')).Memo.Clear;
  TfrxMemoView(frxRel.FindObject('rllPerComAna')).Memo.Add(strPerComAna);

  TfrxMemoView(frxRel.FindObject('rllValComAna')).Memo.Clear;
  TfrxMemoView(frxRel.FindObject('rllValComAna')).Memo.Add(strValComAna);

  TfrxMemoView(frxRel.FindObject('rllPerComDiv')).Memo.Clear;
  TfrxMemoView(frxRel.FindObject('rllPerComDiv')).Memo.Add(strPerComDivAna);

  TfrxMemoView(frxRel.FindObject('rllValComDiv')).Memo.Clear;
  TfrxMemoView(frxRel.FindObject('rllValComDiv')).Memo.Add(strValComDivAna);

  TfrxMemoView(frxRel.FindObject('rllPerComTot')).Memo.Clear;
  TfrxMemoView(frxRel.FindObject('rllPerComTot')).Memo.Add(strPerComTotAna);

  TfrxMemoView(frxRel.FindObject('rllValComTot')).Memo.Clear;
  TfrxMemoView(frxRel.FindObject('rllValComTot')).Memo.Add(strValComTotAna);
End;

procedure TfrmRelComissaoProfissionalCTR.btnImprimirClick(Sender: TObject);
  Var
    strSQL: String;
    //strNomImp: String;
    strSQLAna: String;
    blnGerCadPag: Boolean;
    strProfissionais: String;

  function fGetEmpresasSelecionadas: String;
    Var
      intContador: Integer;
  Begin
    pEdtCodSelectExit(edtCodEmp, edtDesEmpresa, arrEmp, Nil, fRetNomeEmpresaSelec, 'da empresa');

    Result := '';

    For intContador := 0 To Length(arrEmp)-1 Do
    Begin
      Result := Result + arrEmp[intContador].strCodigo + '_';
    End;
  End;
begin
  inherited;

  pnlInfo.Caption := 'Gerando Relatório...';
  pnlInfo.Repaint;

  blnGerCadPag := False;

  If blnImprime Then
  Begin
    strEmp := fGetEmpresasSelecionadas;

    relRecebido.blnConJur := chkConJur.Checked;
    relRecebido.strCodPro := strCodPro;
    relRecebido.strCodEmp := strEmp;
    relRecebido.pcPosCom  := fGetPosCom();

    Case rdgStatus.ItemIndex Of
      0: relRecebido.strStaPro := 'A';
      1: relRecebido.strStaPro := 'I';
      2: relRecebido.strStaPro := EmptyStr;
    End;

    {*******************************************}
    {* CABEÇALHO                               *}
    {****************************************AC*}
    strEmpresa := fStrTitulo(edtCodEmp.Text, edtDesEmpresa, arrEmp, strEmp, 'EMPRESA');
    
    If (Not fEmptyStr(strCodPro)) Then
    Begin
      If edtDesProfissional.Text = '+1' Then
        strProfissional := 'PROFISSIONAL' + ': ' + strCodPro
      Else
        strProfissional := 'PROFISSIONAL'  + ': ' + strCodPro + ' - ' + edtDesProfissional.Text;
    End
    Else
      strProfissional := 'PROFISSIONAL'  + ': TODOS';

    strPeriodo := 'PERIODO DE: ' + FormatDateTime('dd/mm/yyyy',StrToDate(mskDtaIni.Text)) + ' a ' + FormatDateTime('dd/mm/yyyy',StrToDate(mskDtaFin.Text));

    Try

      strSQL := '';
      {***************************************************}
      {* CADREC DIRETA - SEM AGRUPAMENTO NEM CONFIRMAÇÃO *}
      {************************************************AC*}
      strSQL := strSQL + relRecebido.fGetSqlSemAgrupamentoNemConfirmacao('CADREC');
      strSQL := strSQL + '   UNION ALL  ';

      {***************************************************}
      {* CADREC PROVENIENTE DE CONFIRMAÇÃO DOCUMENTO     *}
      {************************************************AC*}
      strSQL := strSQL +  relRecebido.fGetSqlComConfirmacao('CADREC', 'CTRCNF');
      strSQL := strSQL + '   UNION ALL  ';

      {***************************************************}
      {* CADREC AGRUPAMENTO DIRETO                       *}
      {************************************************AC*}
      strSQL := strSQL +  relRecebido.fGetSqlComAgrupamentoDireto('CADREC', 'DUPAGR');
      strSQL := strSQL + '   UNION ALL  ';

      {***************************************************}
      {* CADREC AGRUPAMENTO CONFIRMAÇÃO                  *}
      {************************************************AC*}
      strSQL := strSQL +  relRecebido.fGetSqlAgrupamentoConfirmacao('CADREC',  'DUPAGR',  'CTRCNF');

      strSQL := strSQL + ' ORDER BY  ';
      strSQL := strSQL + '   CTR_CODDIV, ';
      strSQL := strSQL + '   CTR_DTAREC, ';
      strSQL := strSQL + '   CTR_NUMDUP  ';

      strSQLAna := strSQL;

      If rdgTipRel.ItemIndex = 1 Then
        strSQL := fGetSqlSinteticoMovDet(strSQL);

      With qryRelatorio Do
      Begin

        Close;
        SQL.Clear;
        SQL.Add(strSQL);

        pSetaParametros(qryRelatorio, True);

        Open;

        cdsResumoMod.EmptyDataSet;
        frxResumo.DataSet := cdsResumoMod;        
        If (chkResumo.Checked) Then
        Begin
          If rdgTipRel.ItemIndex = 0 Then
            pMontaResumoModalidades(qryRelatorio)
          Else
          Begin
            qryResumo := fCriaQuery;

            qryResumo.Close;
            qryResumo.SQL.Clear;
            qryResumo.SQL.Add(strSQLAna);
            pSetaParametros(qryResumo, False);
            qryResumo.Open;

            pMontaResumoModalidades(qryResumo);

            FreeAndNil(qryResumo);
          End;

          frxResumo.Open;
        End;

        If Not IsEmpty Then
        Begin
//          pCarregaConfImpr(qryCfgRel, Self.Name);
//          strNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;
//          strTipImp := qryCfgRel.FieldByName('REL_IDEIMP').AsString;
//          fPreImpressao(qryCfgRel, strNomImp, strTipImp, False, edtDestino.Text);

          frxRelatorio.DataSet := qryRelatorio;

          pAjustaPercentualDeComissao;

          If rdgTipRel.ItemIndex in [0, 2] Then
          Begin

            If strTipImp = 'M' Then
            Begin
              If rdgComRes.ItemIndex = 0 Then
                frxRel := frxComissaoProfissionalCTRP_M
              Else
                frxRel := frxComissaoProfissionalCTR_M
            End Else
            Begin
              If rdgComRes.ItemIndex = 0 Then
                frxRel := frxComissaoProfissionalCTRP_J
              Else
                frxRel := frxComissaoProfissionalCTR_J;
            End;

            frxRel.AddFunction('Procedure pSetaTotalProfissional(strTotDiv: String)');

            TfrxGroupHeader(frxRel.FindObject('GHComissao')).StartNewPage     := rdgTipRel.ItemIndex = 2;
            TfrxGroupHeader(frxRel.FindObject('GHComissao')).ResetPageNumbers := rdgTipRel.ItemIndex = 2;
            TfrxChild(frxRel.FindObject('CRecibo')).Visible                   := rdgTipRel.ItemIndex = 2;
            TfrxReportSummary(frxRel.FindObject('RSComissao')).Visible        := rdgTipRel.ItemIndex <> 2;
            TfrxPageFooter(frxRel.FindObject('PFComissao')).Visible           := rdgTipRel.ItemIndex <> 2;

            If rdgPerCom.ItemIndex = 1 Then
              pSetaProfissionalAnalitico
            Else
              pSetaPadraoAnalitico;

          End
          Else
          Begin
            If strTipImp = 'M' Then
              frxRel := frxComissaoProfissionalSintCTR_M
            Else
              frxRel := frxComissaoProfissionalSintCTR_J;

            If rdgPerCom.ItemIndex = 1 Then
              pSetaProfissionalSintetico
            Else
              pSetaPadraoSintetico;

            blnGerCadPag := (chkGerCadPag.Checked);
          End;

          TfrxChild(frxRel.FindObject('CResumo')).Visible := chkResumo.Checked;
          frxRel.PrintOptions.Printer := AnsiReplaceText(strNomImp,'\\' + fRetNomeRede + '\','');

          frxRel.PrintOptions.ShowDialog := (edtDestino.Text = 'V');
          frxRel.PrintOptions.PrintMode  := pmScale;
          frxRel.Script.Variables['Profissional'] := 'PROFISSIONAL' ;
          frxRel.Script.Variables['CONJUR'] := relRecebido.blnConJur;
          frxrel.Script.Variables['STATUS'] := 'STATUS: ' + IfThen(rdgTipRel.ItemIndex = 0,'ANALÍTICO',IfThen(rdgTipRel.ItemIndex = 1,'SINTÉTICO','RECIBO'));

          If frxRel.PrepareReport Then
          Begin
            If edtDestino.Text = 'V' Then
              pPreviewReport(Self.Name, Self.Caption, frxRel)
            Else
              pPrintReport(Self.Name, Self.Caption, strNomImp, frxRel);

            If (blnGerCadPag) And (fPossuiComissao()) Then Begin
              If (fMensagem('Confirmação', 'Deseja gravar o contas a pagar da(s) comissão(ões)?', ['&Sim', '&Não'], 2) = 1) Then Begin
                //verificar se os profissionais possuem um fornecedor vinculado
                If (Not fPossuiProfissionalSemFornecedor(strProfissionais)) Then Begin
                  //gerar os registros do CADPAG
                  pGravarComissao(strSQLAna);
                End Else Begin
                  pMostrarMesagemProfissionais(strProfissionais);
                  fMensagem('Informação', 'Não foram gerados os registros de Contas a Pagar das comissões!', ['&OK']);
                End;
              End;
            End;
          End;
        End
        Else
          fMensagem('Informação', 'Não há dados para gerar o relatório!', ['&Ok']);
      End;

    Finally
    End;

    pSetFocus(mskDtaIni);

  End;

  btnImprimir.Enabled := True;
  pnlInfo.Caption     := '';
end;

function TfrmRelComissaoProfissionalCTR.fPossuiComissao: Boolean;
begin
  Result := False;

  Try
    qryRelatorio.DisableControls();
    qryRelatorio.First();

    While (not qryRelatorio.Eof) Do Begin
      If (qryRelatorio.FieldByName('VALOR_COMISSAO').AsFloat <> 0) Then Begin
        Result := True;
        Break;
      End;

      qryRelatorio.Next();
    End;
  Finally
    qryRelatorio.EnableControls();
  End;
end;

function TfrmRelComissaoProfissionalCTR.fPossuiProfissionalSemFornecedor(Out strProfissionais: String): Boolean;
  Var
    strTemp: String;
begin
  strTemp := '';
  strProfissionais := '';

  Try
    qryRelatorio.DisableControls();
    qryRelatorio.First();

    While (not qryRelatorio.Eof) Do Begin
      strTemp := fCampoTabela('DIV_CODFOR',
                              'CADDIV',
                              ['DIV_CODDIV'],
                              [qryRelatorio.FieldByName('CTR_CODDIV').AsString]);

      If (fEmptyStr(strTemp)) And (qryRelatorio.FieldByName('VALOR_COMISSAO').AsFloat <> 0) Then Begin
        strProfissionais := strProfissionais + 'Profissional: ' +
          qryRelatorio.FieldByName('CTR_CODDIV').AsString + '-' +
          qryRelatorio.FieldByName('DIV_NOMDIV').AsString + #13#10;
      End;

      qryRelatorio.Next();
    End;

    Result := (Not fEmptyStr(strProfissionais));
  Finally
    qryRelatorio.EnableControls();
  End;
end;

procedure TfrmRelComissaoProfissionalCTR.fraPlanoDeContasMskCodCtaExit(
  Sender: TObject);
  Var
    arrCentroCusto : TConsultasArray;
begin
  inherited;
  pEdtCodSelectExit(fraPlanoDeContas.MskCodCta, fraPlanoDeContas.edtDesCta, arrCentroCusto, fRetNomeConta, nil, 'do Plano de Contas');

  fraPlanoDeContas.MskCodCtaExit(Sender);
end;

procedure TfrmRelComissaoProfissionalCTR.fraPlanoDeContasMskCodCtaKeyPress(
  Sender: TObject; var Key: Char);
  Var
    arrCentroCusto : TConsultasArray;
begin
  inherited;

  If fPesqCentroCusto(Self, fraPlanoDeContas.MskCodCta, fraPlanoDeContas.edtDesCta, Nil, Key, arrCentroCusto, False) Then Begin
    Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelComissaoProfissionalCTR.frxCabecalhoGetValue(
  const VarName: String; var Value: Variant);
begin
  inherited;

  If SameText('EMPRESA',VarName) Then
    Value := strEmpresa

  Else If SameText('Profissional',VarName) Then
    Value := strProfissional

  Else If SameText('PERIODO',VarName) Then
    Value := strPeriodo;
end;

procedure TfrmRelComissaoProfissionalCTR.FormShow(Sender: TObject);
begin
  edtCodEmp.Text := VS_strCodEmp;
  edtDesEmpresa.Text := fRetNomeEmpresa;

  mskDtaIni.Text := DateToStr(VS_Date);
  mskDtaFin.Text := DateToStr(VS_Date);

  strCodPro := '';

  mskDtaRec.Text := FormatDateTime('dd/mm/yyyy',VS_Date);

  inherited;

  shpMultSel.Visible := True;

  chkGerCadPag.Checked := False;
end;

procedure TfrmRelComissaoProfissionalCTR.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_ESCAPE: Close;
    VK_RETURN: If ActiveControl Is TRadioButton Then
                 Self.SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmRelComissaoProfissionalCTR.fGetPosCom: TPosicaoComissao;
begin
  Case (rdgPosCom.ItemIndex) Of
    0: Result := tcTodas;
    1: Result := tcPendentes;
    2: Result := tcBaixadas;
    Else Result := tcNaoInformado;
  End;
end;

Function TfrmRelComissaoProfissionalCTR.fGetSqlMovDet: String;

  function fGetSql: String;
    Var
      strSQL: String;
  Begin
    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '   ' + relRecebido.fGetProDet + ', ';
    strSQL := strSQL + '   SUM(IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF), DET_TOTITE - DET_DESESP - DET_DESCFF))) AS TOTITE ';
    strSQL := strSQL + ' FROM     ';
    strSQL := strSQL + '   MOVDET ';
    strSQL := strSQL + '   INNER JOIN CADDIV ON DIV_CODDIV = ' + relRecebido.fGetProDet;
    strSQL := strSQL + ' WHERE    ';
    strSQL := strSQL + '   DET_PROEMB <> "S" AND ';
    strSQL := strSQL + '   DET_TIP_FC = "C"  AND ';
    strSQL := strSQL + '   DET_CODCLI NOT IN (' + VS_strCliFil + ') AND ';
    strSQL := strSQL + '   DET_DTAENT BETWEEN :DTAINI AND :DTAFIM   AND ';
    strSQL := strSQL + '   DET_ESPDOC NOT IN ("")                   AND ';

    strSQL := strSQL + '  ((LOCATE(DET_CLAFIS, :CLAFIS) > 0) OR (LOCATE(DET_CLAFIS, :CLADEV) > 0)';
    If fCfgSis('ENTBRF', varBoolean) Then
      strSQL := strSQL + ' OR (DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + ')) '
    Else
      strSQL := strSQL + ') ';

    If Not fEmptyStr(edtCodEmp.Text) Then
    Begin
      strSQL := strSQL + fStrLocate(edtCodEmp,  arrEmp,  'DET_CODEMP', 'CODEMP');
    End
    Else
    Begin
      strSQL := strSQL + '    AND LOCATE(DET_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';
    End;

    If (Not fEmptyStr(edtCodProfissional.Text)) Then
    Begin
      strSQL := strSQL + fStrLocate(edtCodProfissional,  arrProfiss,  'DET_CODDIV', 'CODPRO');
    End;

    strSQL := strSQL + 'GROUP BY ';
    strSQL := strSQL + '  ' + relRecebido.fGetProDet;

    Result := strSQL;
  End;

Begin
  Result := '';
  Result := Result + ' SELECT SQL_NO_CACHE         ';
  Result := Result + '   ' + relRecebido.fGetProDet + ' AS CTR_CODDIV,  ';
  Result := Result + '   DIV_NOMDIV,                           ';
  Result := Result + '   IFNULL(DIV_PERCOM, 0) AS DIV_PERCOM,  ';
  Result := Result + '   SUM(TOTITE) AS CTR_VALFAT,';
  Result := Result + '   CONCAT(' + relRecebido.fGetProDet + '," - ",DIV_NOMDIV) AS PROFISSIONAL, ';
  Result := Result + '   0 AS CTR_ABERTO,          ';
  Result := Result + '   0 AS CTR_VALORI,          ';
  Result := Result + '   0 AS CTR_VALJUR,          ';
  Result := Result + '   0 AS CTR_JURVIS,          ';
  Result := Result + '   0 AS CTR_JURPRA,          ';
  Result := Result + '   0 AS CTR_VALDES,          ';
  Result := Result + '   0 AS CTR_VALREC,          ';
  Result := Result + '   0 AS CTR_RECCOM,          ';
  Result := Result + '   0 AS CTR_RECIPI,          ';
  Result := Result + '   0 AS VLCOM_OPEAVI,        ';
  Result := Result + '   0 AS VLCOM_OPEAPR,        ';
  Result := Result + '   0 AS VALOR_COMISSAO,      ';
  Result := Result + '   0 AS CTR_AVISTA,          ';
  Result := Result + '   0 AS CTR_APRAZO           ';
  Result := Result + ' FROM ( ';
  Result := Result + fGetSql;
  Result := Result + ') AS TABDET ';
  Result := Result + ' INNER JOIN CADDIV ON DIV_CODDIV = ' + relRecebido.fGetProDet;
  Result := Result + ' GROUP BY ';
  Result := Result + relRecebido.fGetProDet;
End;

Function TfrmRelComissaoProfissionalCTR.fGetSqlSinteticoMovDet(strAnalitico: String): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE                       ';

  strSQL := strSQL + '   CTR_CODDIV,                             ';
  strSQL := strSQL + '   DIV_NOMDIV,                             ';
  strSQL := strSQL + '   DIV_PERCOM,                             ';
  strSQL := strSQL + '   SUM(CTR_VALFAT) AS CTR_VALFAT,          ';
  strSQL := strSQL + '   PROFISSIONAL,                           ';
  strSQL := strSQL + '   SUM(CTR_ABERTO) AS CTR_ABERTO,          ';
  strSQL := strSQL + '   SUM(CTR_VALORI) AS CTR_VALORI,          ';
  strSQL := strSQL + '   SUM(CTR_VALJUR) AS CTR_VALJUR,          ';
  strSQL := strSQL + '   SUM(CTR_JURVIS) AS CTR_JURVIS,          ';
  strSQL := strSQL + '   SUM(CTR_JURPRA) AS CTR_JURPRA,          ';
  strSQL := strSQL + '   SUM(CTR_VALDES) AS CTR_VALDES,          ';
  strSQL := strSQL + '   SUM(CTR_VALREC) AS CTR_VALREC,          ';
  strSQL := strSQL + '   SUM(CTR_RECCOM) AS CTR_RECCOM,          ';
  strSQL := strSQL + '   SUM(CTR_RECIPI) AS CTR_RECIPI,          ';

  If rdgPerCom.ItemIndex = 0 Then
    strSQL := strSQL + '   SUM(VALOR_COMISSAO) AS VALOR_COMISSAO, '
  Else
    strSQL := strSQL + '   SUM(VLCOM_OPEAVI+VLCOM_OPEAPR) AS VALOR_COMISSAO, ';

  strSQL := strSQL + '   SUM(VLCOM_OPEAVI) AS VLCOM_OPEAVI,  ';
  strSQL := strSQL + '   SUM(VLCOM_OPEAPR) AS VLCOM_OPEAPR,  ';
  strSQL := strSQL + '   SUM(CTR_AVISTA)   AS CTR_AVISTA,    ';
  strSQL := strSQL + '   SUM(CTR_APRAZO)   AS CTR_APRAZO     ';

  strSQL := strSQL + ' FROM ( ';

  strSQL := strSQL + fGetSQLSintetico(strAnalitico) + ' UNION ALL ' +
                     fGetSqlMovDet + ' UNION ALL ' +
                     fGetSQLTotalAberto;

  strSQL := strSQL + ' ) AS TAB_SINT ';

  strSQL := strSQL + ' GROUP BY CTR_CODDIV ';
  strSQL := strSQL + ' HAVING (CTR_VALREC <> 0.00) OR (CTR_RECIPI <> 0.00) ';  
  strSQL := strSQL + ' ORDER BY DIV_NOMDIV ';

  Result := strSQL;
End;

procedure TfrmRelComissaoProfissionalCTR.FormCreate(Sender: TObject);
begin
  inherited;
  If (Screen.Width <= 1366) Or ((Screen.Height - VS_HEIGHT_START_MENU_WINDOWS) < 768) Then
    Self.Position := poScreenCenter;

  qryRelatorio    := fCriaQuery;
  qryProfissional := fCriaQuery;
  relRecebido     := TValorRecebidoProfissional.Create;

  strPerComAna    := TfrxMemoView(frxComissaoProfissionalCTR_J.FindObject('rllPerComAna')).Memo.Text;
  strValComAna    := TfrxMemoView(frxComissaoProfissionalCTR_J.FindObject('rllValComAna')).Memo.Text;
  strPerComDivAna := TfrxMemoView(frxComissaoProfissionalCTR_J.FindObject('rllPerComDiv')).Memo.Text;
  strValComDivAna := TfrxMemoView(frxComissaoProfissionalCTR_J.FindObject('rllValComDiv')).Memo.Text;
  strPerComTotAna := TfrxMemoView(frxComissaoProfissionalCTR_J.FindObject('rllPerComTot')).Memo.Text;
  strValComTotAna := TfrxMemoView(frxComissaoProfissionalCTR_J.FindObject('rllValComTot')).Memo.Text;

  strPerComDivSin := TfrxMemoView(frxComissaoProfissionalSintCTR_J.FindObject('rllPerComDiv')).Memo.Text;
  strPerCo2DivSin := TfrxMemoView(frxComissaoProfissionalSintCTR_J.FindObject('rllPerCo2Div')).Memo.Text;
  strValComDivSin := TfrxMemoView(frxComissaoProfissionalSintCTR_J.FindObject('rllValComDiv')).Memo.Text;
  strPerComTotSin := TfrxMemoView(frxComissaoProfissionalSintCTR_J.FindObject('rllPerComTot')).Memo.Text;
  strPerCo2TotSin := TfrxMemoView(frxComissaoProfissionalSintCTR_J.FindObject('rllPerCo2Tot')).Memo.Text;
  strValComTotSin := TfrxMemoView(frxComissaoProfissionalSintCTR_J.FindObject('rllValComTot')).Memo.Text;

//  fltPmCmCr := fCfgSis('PMCMCR', varDouble);
  fltPmCmCr := 0;

  {****************************************}
  {* CRIA CLIENTDATASET USADO NO RESUMO   *}
  {*************************************MM*}
  cdsResumoMod                  := TUniClientDataSet.Create(Self);
  cdsResumoMod.AggregatesActive := True;

  With cdsResumoMod.FieldDefs.AddFieldDef Do
  Begin
    Name := 'RMO_NOMDIV';
    DataType := ftString;
    Size := 30;
  End;

  With cdsResumoMod.FieldDefs.AddFieldDef Do
  Begin
    Name := 'RMO_DESMOD';
    DataType := ftString;
    Size := 20;
  End;

  With cdsResumoMod.FieldDefs.AddFieldDef Do
  Begin
    Name := 'RMO_COMIMP';
    DataType := ftFloat;
    Required := False;
  End;

  With cdsResumoMod.FieldDefs.AddFieldDef Do
  Begin
    Name := 'RMO_SEMIMP';
    DataType := ftFloat;
    Required := False;
  End;

  With cdsResumoMod.FieldDefs.AddFieldDef Do
  Begin
    Name := 'RMO_VALCOM';
    DataType := ftFloat;
    Required := False;
  End;

  With cdsResumoMod.FieldDefs.AddFieldDef Do
  Begin
    Name := 'RMO_TOTCOM';
    DataType := ftFloat;
    Required := False;
  End;

  cdsResumoMod.CreateDataSet;
  cdsResumoMod.IndexFieldNames := 'RMO_NOMDIV';
end;

procedure TfrmRelComissaoProfissionalCTR.FormDestroy(Sender: TObject);
begin
  inherited;
  qryProfissional.Close;
  qryRelatorio.Close;
  cdsResumoMod.Close;

  FreeAndNil(qryProfissional);
  FreeAndNil(qryRelatorio);
  FreeAndNil(relRecebido);
  FreeAndNil(cdsResumoMod);
end;

procedure TfrmRelComissaoProfissionalCTR.rdgTipRelClick(Sender: TObject);
begin
  inherited;

  rdgComRes.Enabled := rdgTipRel.ItemIndex <> 1;

  If Not rdgComRes.Enabled Then
    rdgComRes.ItemIndex := 1;

  grbRecibo.Enabled := rdgTipRel.ItemIndex = 2;

  If (rdgTipRel.ItemIndex = 2) Then
  Begin
    chkResumo.Checked := False;
    chkResumo.Enabled := False;
  End
  Else
    chkResumo.Enabled := True;

  pSetaPeriodoRecibo;
end;

procedure TfrmRelComissaoProfissionalCTR.frxUserGetValue(const VarName: String;
  var Value: Variant);
begin
  inherited;

  If SameText('DTAREC', VarName) Then
    Value := fRetDataExtenso(StrToDate(mskDtaRec.Text), True)

  Else If SameText('VALREC', VarName) Then
    Value := fStrToFloat(strValRec)

  Else If SameText('NOMREC', VarName) Then
    Value := fRetNomeEmpresa

  Else If SameText('NOMASS', VarName) Then
    Value := qryRelatorio.FieldByName('DIV_NOMDIV').AsString

  Else If SameText('HISREC', VarName) Then
    Value := edtHisRec.Text

  Else If SameText('NROVIA', VarName) Then
    Value := intQtdVia

  Else If SameText('VLREXT', VarName) Then
    Value := UpperCase(fRetExtensoNumero(strValRec));
end;

procedure TfrmRelComissaoProfissionalCTR.frxUserFirst(Sender: TObject);
begin
  inherited;

  intQtdVia := 1;
end;

procedure TfrmRelComissaoProfissionalCTR.frxUserNext(Sender: TObject);
begin
  inherited;

  inc(intQtdVia);
end;

procedure TfrmRelComissaoProfissionalCTR.frxUserCheckEOF(Sender: TObject;
  var Eof: Boolean);
begin
  inherited;

  Eof := intQtdVia > StrToIntDef(edtQtdVia.Text, 0);

  If Eof Then
  Begin
    TfrxChild(frxRel.FindObject('CHeader')).Visible := True;
    TfrxPageHeader(frxRel.FindObject('PageHeader')).Visible := True;
  End;
end;

procedure TfrmRelComissaoProfissionalCTR.frxUserPrior(Sender: TObject);
begin
  inherited;

  Dec(intQtdVia);
end;

function TfrmRelComissaoProfissionalCTR.frxComissaoProfissionalCTR_MUserFunction(
  const MethodName: String; var Params: Variant): Variant;
begin
  inherited;

  If SameText(MethodName, 'pSetaTotalProfissional') Then
    strValRec := FloatToStr(fStrToFloat(Trim(Params[0])));
end;

Procedure TfrmRelComissaoProfissionalCTR.pSetaPeriodoRecibo;
Begin
  If rdgTipRel.ItemIndex = 2 Then
    edtHisRec.Text := 'A COMISSAO DO PERIODO DE ' + FormatDateTime('dd/mm/yyyy',StrToDate(mskDtaIni.Text)) + ' a ' + FormatDateTime('dd/mm/yyyy',StrToDate(mskDtaFin.Text))
  Else
    edtHisRec.Text := '';
End;

procedure TfrmRelComissaoProfissionalCTR.mskDtaFinExit(Sender: TObject);
begin
  inherited;

  pSetaPeriodoRecibo;
end;

{*****************************************}
{* AJUSTA O PERCENTUAL DE COMISSÃO PARA  *}
{* NÃO ULTRAPASSAR O VALOR CONFIGURADO.  *}
{**************************************MV*}
procedure TfrmRelComissaoProfissionalCTR.pAjustaPercentualDeComissao;
  Var
    fltPerCom: Double;
    fltNovaComissao: Double;
    intContador: Integer;
begin

  Try

    If (fltPmCmCr > 0) And (rdgPerCom.ItemIndex = 0) Then
    Begin
      qryRelatorio.Close;
      qryRelatorio.Open;

      pSetaClient(qryRelatorio);
      
      cdsRelatorio.Close;
      dspRelatorio.DataSet := qryRelatorio;
      cdsRelatorio.SetProvider(dspRelatorio);
      cdsRelatorio.Open;

      For intContador := 0 To cdsRelatorio.FieldCount -1 Do
      Begin
        cdsRelatorio.Fields[intContador].Required := False;
      End;

      cdsRelatorio.First;
      While (Not cdsRelatorio.Eof) Do
      Begin
        If (cdsRelatorio.FieldByName('CTR_RECCOM').AsFloat <> 0) Then
        Begin
          fltPerCom := cdsRelatorio.FieldByName('VALOR_COMISSAO').AsFloat /
                       cdsRelatorio.FieldByName('CTR_RECCOM').AsFloat * 100;

          fltPerCom := fFormataFloat(fltPerCom, 6);

          {*****************************************}
          {* RECALCULA O CAMPO "CTR_RECCOM", POIS  *}
          {* ASSIM NÃO PRECISA MUDAR O RESTANTE DO *}
          {* RELATÓRIO.                            *}
          {**************************************MV*}
          If (fltPerCom > fltPmCmCr) Then
          Begin
            fltPerCom := fltPmCmCr;
            fltNovaComissao := fFormataFloat(cdsRelatorio.FieldByName('CTR_VALREC').AsFloat * fltPerCom / 100, 6);

            cdsRelatorio.Edit;
            cdsRelatorio.FieldByName('VALOR_COMISSAO').AsFloat := fltNovaComissao;
            cdsRelatorio.Post;
          End;
        End;

        cdsRelatorio.Next;
      End;

      frxRelatorio.DataSet := cdsRelatorio;

    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pAjustaPercentualDeComissao]');
    End;
  End;
end;

procedure TfrmRelComissaoProfissionalCTR.pGravarComissao(strSQLAna: String);
  Var
    qryCom: TUniQuery;
    strClient : String;
    objGravaComissao: TGravaComissaoVen;
begin
  Try
    qryCom := fCriaQuery;
    objGravaComissao := TGravaComissaoVen.Create;
    objGravaComissao.blnComProf := True;

    objGravaComissao.pSetDtaVen(StrToDateDef(mskDtaVen.Text, 0));
    objGravaComissao.pSetCodCta(fTiraCaracEspeciais(fraPlanoDeContas.MskCodCta.Text));

    qryCom.SQL.Text := 'SELECT * FROM ('+ strSQLAna + ') TAB WHERE ROUND(VALOR_COMISSAO, 2) <> 0';
    pSetaParametros(qryCom, False);
    qryCom.Open;
    qryCom.First();

    While (not qryCom.Eof) Do Begin
      strClient := Copy(qryCom.FieldByName('CLIENTE').AsString, 1, 8);

      If (qryCom.FindField('MODALIDADE') <> Nil) And
         (SameText(qryCom.FieldByName('MODALIDADE').AsString, relRecebido.strModConfirmacaoDocumento)) Then
      Begin
        strClient := fGetClienteDuplicata(qryCom.FieldByName('CTR_NUMDUP').AsString, 'CADREC');

        If fEmptyStr(strClient) Then
          strClient := qryCom.FieldByName('CTR_CODCLI').AsString;
      End;

      objGravaComissao.pAddDup(qryCom.FieldByName('CTR_NUMDUP').AsString,
                               IIF(qryCom.FindField('DOCUME') <> Nil, qryCom.FieldByName('DOCUME').AsString, ''),
                               strClient,
                               qryCom.FieldByName('CTR_CODDIV').AsString,
                               'CADREC',
                               '',
                               qryCom.FieldByName('VALOR_COMISSAO').AsFloat);

      qryCom.Next();
    End;

    If objGravaComissao.fGravaComissao Then
      fMensagem('INFORMAÇÃO', 'Contas a pagar geradas com sucesso!', ['&OK']);
  Finally
    FreeAndNil(qryCom);
    FreeAndNil(objGravaComissao);
  End;
end;

procedure TfrmRelComissaoProfissionalCTR.pMontaResumoModalidades(
  qryAnalitico: TUniQuery);
  Var
    intContador : Integer;
    fltComImp,
    fltSemImp,
    fltFator,
    fltFatorCom,
    fltTotRec: Double;
    strModalidade: String;
begin
  {*******************************************}
  {* MONTA RESUMOS POR Profissional E MODALIDADE *}
  {****************************************MM*}

  With qryAnalitico Do
  begin
    First;

    While Not EOF Do
    Begin

      fltTotRec := 0;
      fltFator  := (FieldByName('CTR_RECIPI').AsFloat * 100) / FieldByName('CTR_VALREC').AsFloat;

      For intContador := 0 To High(arrModalidade) Do
      Begin
        strModalidade := String(arrModalidade[intContador]);

        If cdsResumoMod.Locate('RMO_NOMDIV;RMO_DESMOD;',
                               VarArrayOf([FieldByName('DIV_NOMDIV').AsString,strModalidade]),[]) Then
          cdsResumoMod.Edit
        Else
          cdsResumoMod.Append;

        fltComImp   := 0;
        fltSemImp   := 0;

        cdsResumoMod.FieldByName('RMO_NOMDIV').AsString := FieldByName('DIV_NOMDIV').AsString;
        cdsResumoMod.FieldByName('RMO_DESMOD').AsString := strModalidade;

        If (strModalidade = 'DINHEIRO') Then
        Begin
          fltComImp := FieldByName('DINHEI').AsFloat;
          fltSemImp := FieldByName('DINHEI').AsFloat * (fltFator / 100);
        End
        Else If (strModalidade = 'CHEQUE') Then
        Begin
          fltComImp := FieldByName('CHQAVI').AsFloat + FieldByName('CHQPRE').AsFloat;
          fltSemImp := (FieldByName('CHQAVI').AsFloat + FieldByName('CHQPRE').AsFloat) * (fltFator / 100);
        End
        Else If (strModalidade = 'CARTAO') Then
        Begin
          fltComImp := FieldByName('CARTAO').AsFloat;
          fltSemImp := FieldByName('CARTAO').AsFloat * (fltFator / 100);
        End
        Else If (strModalidade = 'ORDEM') Then
        Begin
          fltComImp := FieldByName('ORDPAG').AsFloat;
          fltSemImp := FieldByName('ORDPAG').AsFloat * (fltFator / 100);
        End
        Else If (strModalidade = 'FINANCEIRO') Then
        Begin
          fltComImp := FieldByName('VALFIN').AsFloat;
          fltSemImp := FieldByName('VALFIN').AsFloat * (fltFator / 100);
        End;

        fltTotRec := fltTotRec + fltComImp;

        fltFatorCom := (fltComImp /  FieldByName('CTR_VALREC').AsFloat);

        cdsResumoMod.FieldByName('RMO_COMIMP').AsFloat  := cdsResumoMod.FieldByName('RMO_COMIMP').AsFloat + fltComImp;
        cdsResumoMod.FieldByName('RMO_SEMIMP').AsFloat  := cdsResumoMod.FieldByName('RMO_SEMIMP').AsFloat + fltSemImp;
        cdsResumoMod.FieldByName('RMO_VALCOM').AsFloat  := cdsResumoMod.FieldByName('RMO_VALCOM').AsFloat + (FieldByName('VALOR_COMISSAO').AsFloat * fltFatorCom);
        cdsResumoMod.FieldByName('RMO_TOTCOM').AsFloat  := cdsResumoMod.FieldByName('RMO_TOTCOM').AsFloat + FieldByName('VALOR_COMISSAO').AsFloat;

        cdsResumoMod.Post;

        If (strModalidade = 'FINANCEIRO') And
           (fFormataFloat(fltTotRec, 4) <> fFormataFloat(FieldByName('CTR_VALREC').AsFloat, 4)) Then
        Begin
          If cdsResumoMod.Locate('RMO_NOMDIV;RMO_DESMOD;',
                                 VarArrayOf([FieldByName('DIV_NOMDIV').AsString,'DINHEIRO']),[]) Then
            cdsResumoMod.Edit
          Else
            cdsResumoMod.Append;

          cdsResumoMod.Edit;
          cdsResumoMod.FieldByName('RMO_NOMDIV').AsString := FieldByName('DIV_NOMDIV').AsString;
          cdsResumoMod.FieldByName('RMO_DESMOD').AsString := 'DINHEIRO';
          cdsResumoMod.FieldByName('RMO_COMIMP').AsFloat  := cdsResumoMod.FieldByName('RMO_COMIMP').AsFloat + FieldByName('CTR_VALREC').AsFloat;
          cdsResumoMod.FieldByName('RMO_SEMIMP').AsFloat  := cdsResumoMod.FieldByName('RMO_SEMIMP').AsFloat + FieldByName('CTR_RECIPI').AsFloat;          
          cdsResumoMod.Post;
        End;
      End;

      Next;
    End;
    First;
  End;
End;

procedure TfrmRelComissaoProfissionalCTR.pMostrarMesagemProfissionais(
  strProfissionais: String);
begin
  Try
    pCriarFormularios(TfrmObservacao, frmObservacao);
    frmObservacao.Caption := '** CONTAS A PAGAR NÃO FORAM GERADAS **';
    frmObservacao.lblMensagem.Caption := 'Lista de Profissionais sem um Fornecedor vinculado ao cadastro:';
    frmObservacao.memObs.Texto := strProfissionais;
    frmObservacao.ShowModal();
  Finally
    FreeAndNil(frmObservacao);
  End;
end;

procedure TfrmRelComissaoProfissionalCTR.pSetaParametros(qryRel: TUniQuery; blnClaFis: boolean);
begin
  With qryRel Do
  Begin
    ParamByName('DTAINI').AsDateTime := StrToDate(mskDtaIni.Text);
    ParamByName('DTAFIM').AsDateTime := StrToDate(mskDtaFin.Text);

    ParamByName('DTACOR').AsDateTime := fCfgSis('DTCOCR', varDate);

    pSetaParam(edtCodEmp.Text,arrEmp, strEmp,'CODEMP', qryRel);

    pSetaParam(edtCodProfissional.Text,arrProfiss,strCodPro,'CODPRO', qryRel);

    If (rdgTipRel.ItemIndex = 1) And (blnClaFis) Then
    Begin

      If Params.FindParam('CLAFIS') <> Nil Then
        ParamByName('CLAFIS').AsString := VS_strClaVen;
      If Params.FindParam('CLADEV') <> Nil Then
        ParamByName('CLADEV').AsString := VS_strClaDev;

    End;
  End;
end;

function TfrmRelComissaoProfissionalCTR.fGetClienteDuplicata(strDuplic, strTabela: String): String;
  Var
    strNumDup : String;
    strEspDoc : String;
    strParcel : String;
    strCodEmp : String;
    qryCadRec : TUniQuery;
begin
  Result := '';

  strNumDup := LeftStr(strDuplic, 12);
  strEspDoc := MidStr(strDuplic, 16, 2);
  strParcel := MidStr(strDuplic, 14, 1);
  strCodEmp := RightStr(strDuplic, 3);

  qryCadRec := fCriaQuery(Self);

  With qryCadRec Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(' SELECT CTR_CODCLI ');
    SQL.Add('   FROM ' + strTabela);
    SQL.Add('  WHERE CTR_NUMDUP = :NUMDUP ');
    SQL.Add('    AND CTR_ESPDOC = :ESPDOC ');
    SQL.Add('    AND CTR_PARCEL = :PARCEL ');
    SQL.Add('    AND CTR_CODEMP = :CODEMP ');
    ParamByName('NUMDUP').AsString := strNumDup;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('PARCEL').AsString := strParcel;
    ParamByName('CODEMP').AsString := strCodEmp;
    Open;

    If (Not IsEmpty) Then
      Result := FieldByName('CTR_CODCLI').AsString;

    Close;
  End;

  FreeAndNil(qryCadRec);
end;



End.
