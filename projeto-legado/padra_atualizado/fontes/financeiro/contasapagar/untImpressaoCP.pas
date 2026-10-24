unit untImpressaoCP;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, StrUtils, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, Data.DB, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGridCitel,
  cxGrid, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, cxProgressBar,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.Mask,
  MaskEditFocus, EditFocus, QColorLabel, Uni, untFuncoesSimples, untTypesSistema,
  cxContainer, Vcl.ComCtrls, dxCore, cxDateUtils, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxCalendar, untFrameCentroCustoEditFocus,
  untFramePlanoDeContasMaskEdit;

type
  TfrmImpressaoCP = class(TfrmPai)
    pnlFiltros: TPanel;
    GroupBox1: TGroupBox;
    ColorLabel17: TColorLabel;
    edtVeioNota: TEditFocus;
    gpbBoleto: TGroupBox;
    ColorLabel2: TColorLabel;
    edtBoleto: TEditFocus;
    gpbDeposito: TGroupBox;
    ColorLabel12: TColorLabel;
    edtDeposito: TEditFocus;
    gpbCheque: TGroupBox;
    ColorLabel11: TColorLabel;
    edtCheque: TEditFocus;
    gpbFornFilial: TGroupBox;
    ColorLabel3: TColorLabel;
    edtFornecFilial: TEditFocus;
    Label4: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    Label12: TLabel;
    edtCodFornecedor: TEditFocus;
    edtDesFornecedor: TEditFocus;
    Label3: TLabel;
    edtCodAtv: TEditFocus;
    edtDesAtv: TEditFocus;
    lblEmpresa: TLabel;
    edtCodEmpresa: TEditFocus;
    edtDesEmpresa: TEditFocus;
    lblPortador: TLabel;
    edtCodPor: TEditFocus;
    edtDesPortador: TEditFocus;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label13: TLabel;
    chkExiCreditos: TCheckBox;
    chkNExiCreditos: TCheckBox;
    gpbIncPrevis: TGroupBox;
    ColorLabel4: TColorLabel;
    ColorLabel5: TColorLabel;
    ColorLabel6: TColorLabel;
    edtIncPrevis: TEditFocus;
    btnImprimir: TBitBtnLocked;
    shpMultSel: TShape;
    mskDtaIniC: TcxDateEdit;
    mskDtaFinC: TcxDateEdit;
    mskDtaIniV: TcxDateEdit;
    mskDtaFinV: TcxDateEdit;
    mskCompet: TMaskEditFocus;
    fraCentroCusto: TfraCentroCustoEditFocus;
    fraPlanoDeContas: TfraPlanoDeContasMskEdit;
    chkLancDeb: TCheckBox;
    procedure chkExiCreditosClick(Sender: TObject);
    procedure chkNExiCreditosClick(Sender: TObject);
    procedure edtCodFornecedorExit(Sender: TObject);
    procedure edtCodFornecedorKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodAtvExit(Sender: TObject);
    procedure edtCodAtvKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpresaExit(Sender: TObject);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodPorExit(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure fraCentroCustoedtCodEveExit(Sender: TObject);
    procedure fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject; var Key: Char);
    procedure fraPlanoDeContasMskCodCtaExit(Sender: TObject);
  private
    { Private declarations }
    arrFornecedor  : TConsultasArray;
    arrEvento      : TConsultasArray;
    arrCentroCusto : TConsultasArray;
    arrEmpresa     : TConsultasArray;
    arrAtividade   : TConsultasArray;
    arrPortador    : TConsultasArray;

    procedure pInformacao(strInfo: String; pgbStatus: TcxProgressBar);
    procedure pProgresso(intProgresso: Integer; intMaximo: Integer; pgbStatus: TcxProgressBar);

    function fGetSQL: String;
    function fGetWhere: String;
    procedure pSetaParametros(qryDados: TUniQuery);

    function fCarregandoTitulos(pgbStatus: TcxProgressBar = Nil): Boolean;
    function fGetSQLLancLD: String;
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}

uses untFuncoesConsulta, untConsultas, untImpressaoCPList, untGravando;

{ TfrmImpressaoCP }

procedure TfrmImpressaoCP.btnImprimirClick(Sender: TObject);
  Var
    frmAguarde: TfrmGravando;
begin
  inherited;

  If (fEmptyStr(fTiraCaracEspeciais(mskDtaIniC.Text))) And
     (fEmptyStr(fTiraCaracEspeciais(mskDtaFinC.Text))) And
     (fEmptyStr(fTiraCaracEspeciais(mskDtaIniV.Text))) And
     (fEmptyStr(fTiraCaracEspeciais(mskDtaFinV.Text))) Then
  Begin
    fMensagem('', 'A data de (CADASTRO) ou (VENCIMENTO) deve ser preenchida!', ['&OK']);
    pSetFocus(mskDtaIniC);
    Exit;
  End;

  If Not fVerificaCampos Then
    Exit;

  Try
    pCriarFormularios(TfrmGravando, frmAguarde);
    frmAguarde.fExecutarAcao := fCarregandoTitulos;
    frmAguarde.ShowModal;
    pFreeAndNil(frmAguarde);

    pSetFocus(mskCompet);
  Except
    On E : Exception Do
      pMensagensErro(E.Message, '[TfrmImpressaoCP.btnImprimirClick]');
  End;
end;

procedure TfrmImpressaoCP.chkExiCreditosClick(Sender: TObject);
begin
  inherited;
  If chkExiCreditos.Checked Then
  Begin
    chkNExiCreditos.Checked := False;
    chkNExiCreditos.Enabled := False;
  End
  Else
    chkNExiCreditos.Enabled := True;
end;

procedure TfrmImpressaoCP.chkNExiCreditosClick(Sender: TObject);
begin
  inherited;
  If chkNExiCreditos.Checked Then
  Begin
    chkExiCreditos.Checked := False;
    chkExiCreditos.Enabled := False;
  End
  Else
    chkExiCreditos.Enabled := True;
end;

procedure TfrmImpressaoCP.edtCodAtvExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodAtv, edtDesAtv, arrAtividade, Nil, fRetNomAtividade, 'da atividade');
end;

procedure TfrmImpressaoCP.edtCodAtvKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqAtividade(Self, edtCodAtv, edtDesAtv, Nil, Key, arrAtividade, False) Then
  Begin
    fValidaCampos(edtCodAtv,False);
    Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmImpressaoCP.edtCodEmpresaExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodEmpresa, edtDesEmpresa, arrEmpresa, Nil, fRetNomeEmpresaSelec, 'da empresa');
end;

procedure TfrmImpressaoCP.edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpresa, edtDesEmpresa, Nil, Key, arrEmpresa, False, True) Then
  Begin
    fValidaCampos(edtCodEmpresa,False);
    self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmImpressaoCP.edtCodFornecedorExit(Sender: TObject);
begin
  pEdtCodSelectExit(edtCodFornecedor, edtDesFornecedor, arrFornecedor, fRetNomFornecedor, Nil, 'do fornecedor');
end;

procedure TfrmImpressaoCP.edtCodFornecedorKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqFornecedor(conForSimples, Self, edtCodFornecedor, edtDesFornecedor, Nil, Key, arrFornecedor, False) Then
  Begin
    fValidaCampos(edtCodFornecedor,False);
    self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmImpressaoCP.edtCodPorExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodPor, edtDesPortador, arrPortador, Nil, fRetNomPortador, 'do portador');
end;

procedure TfrmImpressaoCP.edtCodPorKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqPortador(conSimples,
                   Self,
                   edtCodPor,
                   edtDesPortador,
                   nil,
                   Key,
                   arrPortador,
                   False,
                   'Consulta de Portadores',
                   '',
                   False,
                   False,
                   edtCodEmpresa.Text) Then
  Begin
    If fValidaCampos(edtCodPor,False) Then
      self.SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmImpressaoCP.fCarregandoTitulos(pgbStatus: TcxProgressBar): Boolean;
  Var
    strSQL, strSQL_LD: String;
begin
  Result := True;

  pInformacao('Aguarde... Carregando Títulos.', pgbStatus);
  pProgresso(0, 3, pgbStatus);
  pCriarFormularios(TfrmImpressaoCPList, frmImpressaoCPList);

  With frmImpressaoCPList.qryTitulos.qryQuery Do
  Begin
    frmImpressaoCPList.qryTitulos.Close;
    Close;

    strSQL := '';
    strSQL := strSQL + fGetSQL;
    strSQL := strSQL + fGetWhere;

    If chkLancDeb.checked Then
    Begin
       strSQL_LD := '';
       strSQL_LD := fGetSQlLancLD;
    End;

    strSQL := strSQL + IIF(chkLancDeb.checked, ' UNION ALL ' + strSQL_LD, '');

    SQL.Clear;
    SQL.Add(strSQL);

    pSetaParametros(frmImpressaoCPList.qryTitulos.qryQuery);

    frmImpressaoCPList.qryTitulos.fAbreClient(True, 'TfrmImpressaoCP.fCarregandoTitulos');
    frmImpressaoCPList.BlnVisLC := (chkLancDeb.checked);
    Open;

    pProgresso(1, 3, pgbStatus);
    pSetaClient(frmImpressaoCPList.qryTitulos);
    pProgresso(2, 3, pgbStatus);
    pSetaClient(frmImpressaoCPList.qryTitulos.qryQuery);
    pProgresso(3, 3, pgbStatus);

    If Not IsEmpty Then
      frmImpressaoCPList.ShowModal
    Else
      fMensagem('ATENÇÃO', 'Não existem dados para essa seleção!', ['&Ok']);
  End;

  pFreeAndNil(frmImpressaoCPList);
end;

// Traz os lançamentos de debitos feitos no caixa pra reimpressão
function TfrmImpressaoCP.fGetSQLLancLD: String;
begin
  Result := '';
  Result := Result + ' SELECT                         ';
  Result := Result + '   RCX_SEQCON AS SEQCON,        ';
  Result := Result + '   RCX_NUMDOC AS DUPLIC,        ';
  Result := Result + '   RCX_CODEMP AS CTP_CODEMP,    ';
  Result := Result + '   RCX_CODCLI AS NOMFOR,        ';
  Result := Result + '   RCX_CODCLI AS NOMPOR,        ';
  Result := Result + '   RCX_DTACAD AS DTACAD,        ';
  Result := Result + '   RCX_DTACAD AS CTP_DTAVEN,    ';
  Result := Result + '   RCX_CODCLI AS FOR_NOMFOR,    ';
  Result := Result + '   RCX_VALDOC * (-1) AS TOTDUP, ';
  Result := Result + '   RCX_VALDOC * (-1) AS VALORI, ';
  Result := Result + '   "D"        AS CTP_MARDES,    ';
  Result := Result + '   RCX_NUMDOC AS NRODUP,        ';
  Result := Result + '   RCX_ESPDOC AS ESPDOC,        ';
  Result := Result + '   RCX_NUMDOC AS CTP_NUMDUP,    ';
  Result := Result + '   ""         AS CTP_CODVEL,    ';
  Result := Result + '   RCX_PARCEL AS CTP_PARCEL,    ';
  Result := Result + '   RCX_CODCLI AS CTP_CODFOR,    ';
  Result := Result + '   ""         AS CTP_SERIE_,    ';
  Result := Result + '   "NÃO"      AS CTP_USACHQ,    ';
  Result := Result + '   0 AS CTP_DESSUJ,             ';
  Result := Result + '   0 AS CTP_JURSUJ,             ';
  Result := Result + '   0 AS CTP_MULSUJ,             ';
  Result := Result + '   0 AS CTP_VENDOR,             ';
  Result := Result + '   "CADPAG" AS CTP_TABELA       ';
  Result := Result + ' FROM CADRCXX                   ';
  Result := Result + '   WHERE RCX_ESPDOC = "LD"      ';

  // colocar verificação pra pegar apenas do caixa em que esta

  If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIniV.Text))) And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFinV.Text))) Then
      Result := Result + ' AND RCX_DTACAD BETWEEN :DTAINIV AND :DTAFINV '
  Else
  If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIniC.Text))) And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFinC.Text))) Then
      Result := Result + ' AND RCX_DTACAD BETWEEN :DTAINIC AND :DTAFINC '

end;

function TfrmImpressaoCP.fGetSQL: String;
begin
  Result := '';
  Result := Result + ' SELECT ';
  Result := Result + '   CTP_SEQCON AS SEQCON, ';
  Result := Result + '   CONCAT(CTP_NUMDUP, "-", CTP_PARCEL, "-", CTP_SERIE_) AS DUPLIC, ';
  Result := Result + '   CTP_CODEMP, ';
  Result := Result + '   CONCAT(CTP_CODFOR, "-", FOR_NOMFOR) AS NOMFOR, ';
  Result := Result + '   CONCAT(CTP_CODPOR, "-", POR_NOMPOR) AS NOMPOR, ';
  Result := Result + '   CTP_DTACAD DTACAD, ';
  Result := Result + '   CTP_DTAVEN, ';
  Result := Result + '   FOR_NOMFOR, ';
  Result := Result + '  (CTP_VALDUP + IFNULL(CTP_JURSUJ,0) + IFNULL(CTP_MULSUJ,0) + IFNULL(CTP_VENDOR,0)) - IFNULL(CTP_DESSUJ,0) AS TOTDUP, ';
  Result := Result + '   CTP_VALORI VALORI, ';
  Result := Result + '   "D" CTP_MARDES, ';
  Result := Result + '   CTP_NUMDUP NRODUP, ';
  Result := Result + '   "" AS ESPDOC, ';
  Result := Result + '   CTP_NUMDUP, ';
  Result := Result + '   CTP_CODVEL, ';
  Result := Result + '   CTP_PARCEL, ';
  Result := Result + '   CTP_CODFOR, ';
  Result := Result + '   CTP_SERIE_, ';
  Result := Result + '   IF(CTP_USACHQ = "S", "SIM", "NÃO") AS CTP_USACHQ, ';
  Result := Result + '   IFNULL(CTP_DESSUJ, 0) AS CTP_DESSUJ, ';
  Result := Result + '   IFNULL(CTP_JURSUJ, 0) AS CTP_JURSUJ, ';
  Result := Result + '   IFNULL(CTP_MULSUJ, 0) AS CTP_MULSUJ, ';
  Result := Result + '   IFNULL(CTP_VENDOR, 0) AS CTP_VENDOR, ';
  Result := Result + '   "CADPAG" AS CTP_TABELA ';
  Result := Result + ' FROM ';
  Result := Result + '   CADPAG ';
  Result := Result + '      JOIN CADFOR ON (CADFOR.FOR_CODFOR = CADPAG.CTP_CODFOR) ';
  Result := Result + ' LEFT JOIN CADPOR ON (CADPOR.POR_CODPOR = CADPAG.CTP_CODPOR) ';
  Result := Result + ' LEFT JOIN CADATI ON (CADATI.ATI_CODATI = CADFOR.FOR_CODATI) ';
end;

function TfrmImpressaoCP.fGetWhere: String;
  Const
    STR_USACHQ = ' IF(IF(CTP_VEIOBO = "S", "S", "N") = "S", "N", CTP_USACHQ) ';

  Const
    STR_DEPOSI = ' IF(IF(CTP_VEIOBO = "S", "S", "N") = "S", "N", IF(IF(CTP_USACHQ = "S", "S", "N") = "S", "N", IF(IF(CTP_DEPOSI = "S", "S", "N") = "S", "S", "N"))) ';
begin
  Result := '';
  Result := Result + ' WHERE ';
  Result := Result + '   CTP_DTAPAG IS NULL ';

  If Not fEmptyStr(fTiraCaracEspeciais(mskCompet.Text)) Then
    Result := Result + '  AND CTP_COMPET = :COMPET ';

  If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIniC.Text))) And
     (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFinC.Text))) Then
    Result := Result + ' AND CTP_DTACAD BETWEEN :DTAINIC AND :DTAFINC ';

  If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIniV.Text))) And
     (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFinV.Text))) Then
    Result := Result + ' AND CTP_DTAVEN BETWEEN :DTAINIV AND :DTAFINV ';

  If Not MatchStr(edtDesFornecedor.Text, ['', 'TODOS'])  Then
    Result := Result + ' AND CTP_CODFOR IN (' + fRetArrToSQLIn(arrFornecedor, edtCodFornecedor.Text) + ') ';

  If (chkExiCreditos.Checked) Then
    Result := Result + '  AND (CTP_VALDUP - IFNULL(CTP_DESSUJ, 0) + IFNULL(CTP_JURSUJ, 0) + IFNULL(CTP_MULSUJ, 0) + IFNULL(CTP_VENDOR, 0)) < 0.0 ';

  If (chkNExiCreditos.Checked) Then
    Result := Result + '  AND (CTP_VALDUP - IFNULL(CTP_DESSUJ, 0) + IFNULL(CTP_JURSUJ, 0) + IFNULL(CTP_MULSUJ, 0) + IFNULL(CTP_VENDOR, 0)) > 0.0 ';

  If Not MatchStr(edtDesAtv.Text, ['', 'TODOS']) Then
    Result := Result +  ' AND ATI_CODATI IN (' + fRetArrToSQLIn(arrAtividade, edtCodAtv.Text);

  If Not MatchStr(edtDesEmpresa.Text, ['', 'TODOS']) Then
    Result := Result + ' AND CTP_CODEMP IN (' + fRetArrToSQLIn(arrEmpresa, edtCodEmpresa.Text) + ') ';

  If Not MatchStr(fraCentroCusto.edtDesEve.Text, ['', 'TODOS']) Then
    Result := Result + ' AND CTP_CODEVE IN (' + fRetArrToSQLIn(arrEvento, fraCentroCusto.edtCodEve.Text) + ') ';

  If Not MatchStr(fraPlanoDeContas.edtDesCta.Text, ['', 'TODOS']) Then
    Result := Result + 'AND CTP_CODCTA IN (' + fRetArrToSQLIn(arrCentroCusto, fraPlanoDeContas.MskCodCta.Text) + ') ';

  If Not fEmptyStr(edtCodPor.Text) Then
    Result := Result + ' AND CTP_CODPOR IN (' + fRetArrToSQLIn(arrPortador, edtCodPor.Text) + ') '
  Else If fCfgSis('DACPOR', varBoolean) Then
  Begin
    Result := Result + ' AND (CTP_CODPOR IS NULL ';
    Result := Result + '   OR CTP_CODPOR IN (' + fRetStrToSQLIn(strPortadoresOperador) + ')) ';
  End;

  If edtVeioNota.Text <> 'T' Then
    Result := Result  + ' AND COALESCE(CTP_VEIONF, "N") = ' + QuotedStr(edtVeioNota.Text);

  If edtBoleto.Text <> 'T' Then
    Result := Result + '  AND COALESCE(CTP_VEIOBO, "N") = ' + QuotedStr(edtBoleto.Text);

  If edtDeposito.Text <> 'T' Then
    Result := Result + '  AND COALESCE(' + STR_DEPOSI + ', "N") = ' + QuotedStr(edtDeposito.Text);

  If edtCheque.Text <> 'T' Then
    Result := Result  + ' AND IF(' + STR_USACHQ + ' = "" OR ' + STR_USACHQ + ' IS NULL, "N", ' + STR_USACHQ + ') = ' + QuotedStr(edtCheque.Text);

  If edtFornecFilial.Text <> 'T' Then
    Result := Result + '  AND (LOCATE(CTP_CODFOR, :FORFIL) ' + IfThen(edtFornecFilial.Text = 'S', '>', '<') + ' 0) ';

  If (edtIncPrevis.Text = 'S') Then
    Result := Result + '  AND (CTP_PREVIS IS NULL OR CTP_PREVIS <> "S") '
  Else If (edtIncPrevis.Text = 'P') Then
    Result := Result + '  AND CTP_PREVIS = "S"  ';
end;

procedure TfrmImpressaoCP.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(mskCompet);
end;

procedure TfrmImpressaoCP.FormShow(Sender: TObject);
begin
  inherited;

  edtCodEmpresa.Text := VS_strCodEmp;
  edtDesEmpresa.Text := fRetNomeEmpresa;

  mskDtaIniV.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
  mskDtaFinV.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
end;

procedure TfrmImpressaoCP.fraCentroCustoedtCodEveExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(fraCentroCusto.edtCodEve, fraCentroCusto.edtDesEve, arrEvento, fRetNomEvento, Nil, 'do Centro de Custos');
end;

procedure TfrmImpressaoCP.fraPlanoDeContasMskCodCtaExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(fraPlanoDeContas.MskCodCta, fraPlanoDeContas.edtDesCta, arrCentroCusto, fRetNomeConta, Nil, 'do plano de contas');

  fraPlanoDeContas.MskCodCtaExit(Sender);
end;

procedure TfrmImpressaoCP.fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqCentroCusto(Self, fraPlanoDeContas.MskCodCta, fraPlanoDeContas.edtDesCta, Nil, Key, arrCentroCusto, False) Then
  Begin
    fValidaCampos(fraPlanoDeContas.MskCodCta,False);
    self.SelectNext(ActiveControl, True, True);
  End;

end;

function TfrmImpressaoCP.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
  Var
    intIndex: Integer;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin
    If (Sender = mskDtaFinC) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaFinC.Text)) And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIniC.Text))) Then
      Begin
        fMensagem('', 'O campo Data Final (CADASTRO) deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFinC.Text))) And fEmptyStr(fTiraCaracEspeciais(mskDtaIniC.Text)) Then
        Begin
          fMensagem('', 'O campo Data Inicial (CADASTRO) deve ser preenchido!', ['&Ok']);
          Sender := mskDtaIniC;
          Result := False;
        End
        Else
        Begin
          If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFinC.Text))) And (StrToDateDef(mskDtaFinC.Text, 0) <= 0) Then
          Begin
            fMensagem('', 'Data Final (CADASTRO) informada inválida!', ['&O k']);
            Result := False;
          End
          Else
          If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFinC.Text))) And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIniC.Text))) Then
          Begin
            If StrToDate(mskDtaIniC.Text) > StrToDate(mskDtaFinC.Text) Then
            Begin
              fMensagem('','A data inicial (CADASTRO) deve ser menor que a data final (CADASTRO)!',['&O K']);
              Sender := mskDtaIniC;
              Result := False;
            End;
          End;
        End;
      End;
    End
    Else If (Sender = mskDtaIniC) Then
    Begin
      If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIniC.Text))) and (StrToDateDef(mskDtaIniC.Text, 0) <= 0) Then
      Begin
        fMensagem('', 'Data Inicial (CADASTRO) informada inválida!', ['&O k']);
        Result := False;
        Sender := mskDtaIniC;
      End;
    End
    Else If (Sender = mskDtaFinV) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaFinV.Text)) And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIniV.Text))) Then
      Begin
        fMensagem('', 'O campo Data Final (VENCIMENTO) deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFinV.Text))) And fEmptyStr(fTiraCaracEspeciais(mskDtaIniV.Text)) Then
        Begin
          fMensagem('', 'O campo Data Inicial (VENCIMENTO) deve ser preenchido!', ['&Ok']);
          Sender := mskDtaIniV;
          Result := False;
        End
        Else
        Begin
          If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFinV.Text))) And (StrToDateDef(mskDtaFinV.Text, 0) <= 0) Then
          Begin
            fMensagem('', 'Data Final (VENCIMENTO) informada inválida!', ['&O k']);
            Result := False;
          End
          Else
          If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFinV.Text))) And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIniV.Text))) Then
          Begin
            If StrToDate(mskDtaIniV.Text) > StrToDate(mskDtaFinV.Text) Then
            Begin
              fMensagem('','A data inicial (VENCIMENTO) deve ser menor que a data final (VENCIMENTO)!',['&O K']);
              Sender := mskDtaIniV;
              Result := False;
            End;
          End;
        End;
      End;
    End
    Else If (Sender = mskDtaIniV) Then
    Begin
      If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIniV.Text))) and (StrToDateDef(mskDtaIniV.Text, 0) <= 0) Then
      Begin
        fMensagem('', 'Data Inicial (VENCIMENTO) informada inválida!', ['&O k']);
        Result := False;
        Sender := mskDtaIniV;
      End;
    End
    Else if (Sender = mskCompet) then
    Begin
      If Not fEmptyStr(fTiraCaracEspeciais(mskCompet.Text)) Then
      Begin
        If Not fValidaDataStr('01/'+ mskCompet.Text) Then
        Begin
          pMensagemOk('Data informada na Competência não é válida!');
          Result := False;
        End;
      End;
    End
    Else If (Sender = edtCodEmpresa) Then
    Begin
      pDesmarcaLista(edtCodEmpresa, arrEmpresa);

      If (Not fEmptyStr(edtCodEmpresa.Text)) And (High(arrEmpresa) < 0) Then
      Begin
        If Pos(edtCodEmpresa.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&OK']);
          Result := False;
        End;
      End
      Else If (High(arrEmpresa) >= 0) Then
      Begin
        For intIndex := 0 To High(arrEmpresa) Do
        Begin
          If Pos(arrEmpresa[intIndex].strCodigo, strEmpAcessoUsuarioLogado) <= 0 Then
          Begin
            fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa: '+ arrEmpresa[intIndex].strCodigo +'!', ['&OK']);
            Result := False;
          End;
        End;
      End
    End
    Else If Sender = edtCodFornecedor Then
    Begin
      pDesmarcaLista(edtCodFornecedor, arrFornecedor);
    End
    Else If Sender = edtCodAtv Then
    Begin
      pDesmarcaLista(edtCodAtv, arrAtividade);
    End
    Else If Sender = fraCentroCusto.edtCodEve Then
    Begin
      pDesmarcaLista(fraCentroCusto.edtCodEve, arrEvento);

      If Not fEmptyStr(fraCentroCusto.edtCodEve.Text) Then
      Begin
        fraCentroCusto.edtDesEve.Text := fRetNomEvento(fraCentroCusto.edtCodEve);

        If fEmptyStr(fraCentroCusto.edtDesEve.Text) Then Begin
          fMensagem('ATENÇÃO!', 'Esse Centro de Custos não está cadastrado!', ['&OK']);
          Result := False;
        End;
      End;
    End
    Else If Sender = fraPlanoDeContas.MskCodCta Then
    Begin
      pDesmarcaLista(fraPlanoDeContas.MskCodCta, arrCentroCusto);
    End
    Else If Sender = edtCodPor Then
    Begin
      If (High(arrEmpresa) > 0) Then
      Begin
        If Not fEmpresaTemAcessoPortador(edtCodPor.Text,arrEmpresa) Then
          Result := False;
      End
      Else If Not fEmpresaTemAcessoPortador(edtCodPor.Text, edtCodEmpresa.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
        Result := False;
      End;

      pDesmarcaLista(edtCodPor, arrPortador);
    End
    Else If (Sender = edtBoleto) Then
    Begin
      If fEmptyStr(edtBoleto.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Veio Boleto deve ser preenchido.',['&OK']);
        Result := False;
      End
      Else If Pos(edtBoleto.Text,'SNT') <= 0 Then
      Begin
        fMensagem('ATENÇÃO!','O campo Veio Boleto deve ser T, N ou S.',['&OK']);
        Result := False;
      End;
    End
    Else If (Sender = edtVeioNota) Then
    Begin
      If fEmptyStr(edtVeioNota.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Veio NF deve ser preenchido.',['&OK']);
        Result := False;
      End
      Else If Pos(edtVeioNota.Text,'SNT') <= 0 Then
      Begin
        fMensagem('ATENÇÃO!','O campo Veio NF deve ser S, N ou T.',['&OK']);
        Result := False;
      End;
    End
    Else If (Sender = edtDeposito) Then
    Begin
      If fEmptyStr(edtDeposito.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Depósito deve ser preenchido.',['&OK']);
        Result := False;
      End
      Else If Pos(edtDeposito.Text,'SNT') <= 0 Then
      Begin
        fMensagem('ATENÇÃO!','O campo Depósito deve ser T, N ou S.',['&O K']);
        Result := False;
      End;
    End
    Else If (Sender = edtIncPrevis) Then
    Begin
      If fEmptyStr(edtIncPrevis.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Gerar deve ser preenchido.',['&OK']);
        Result := False;
      End
      Else If Pos(edtIncPrevis.Text,'TSP') <= 0 Then
      Begin
        fMensagem('ATENÇÃO','O campo Gerar deve conter somente T, S ou P!',['&OK']);
        Result := False;
      End;
    End
    Else If (Sender = edtCheque) Then
    Begin
      If fEmptyStr(edtCheque.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Cheque deve ser preenchido.',['&OK']);
        Result := False;
      End
      Else If Pos(edtCheque.Text,'SNT') <= 0 Then
      Begin
        fMensagem('ATENÇÃO!','O campo Cheque deve ser T, N ou S.',['&O K']);
        Result := False;
      End;
    End
    Else If (Sender = edtFornecFilial) Then
    Begin
      If fEmptyStr(edtFornecFilial.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Fornecedor Filial deve ser preenchido.',['&OK']);
        Result := False;
      End
      Else If Pos(edtFornecFilial.Text,'SNT') <= 0 Then
      Begin
        fMensagem('ATENÇÃO!','O campo Fornecedor Filial deve ser T, N ou S.',['&O K']);
        Result := False;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmImpressaoCP.pInformacao(strInfo: String;
  pgbStatus: TcxProgressBar);
begin
  If Assigned(pgbStatus) And (GetParentForm(pgbStatus).FindComponent('lblGravando') <> Nil) Then
  Begin
    TLabel(GetParentForm(pgbStatus).FindComponent('lblGravando')).Caption := strInfo;
    Application.ProcessMessages;
  End;
end;

procedure TfrmImpressaoCP.pProgresso(intProgresso, intMaximo: Integer;
  pgbStatus: TcxProgressBar);
begin
  If Assigned(pgbStatus) Then
  Begin
    pgbStatus.Visible  := (intProgresso + intMaximo) > 0;
    pgbStatus.Position := intProgresso;
    pgbStatus.properties.Max := intMaximo;
    Application.ProcessMessages;
  End;
end;

procedure TfrmImpressaoCP.pSetaParametros(qryDados: TUniQuery);
begin
  With qryDados Do
  Begin
    If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIniC.Text))) Then
      ParamByName('DTAINIC').AsDate := StrToDate(mskDtaIniC.Text);

    If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFinC.Text))) Then
      ParamByName('DTAFINC').AsDate := StrToDate(mskDtaFinC.Text);

    If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIniV.Text))) Then
      ParamByName('DTAINIV').AsDate := StrToDate(mskDtaIniV.Text);

    If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFinV.Text))) Then
      ParamByName('DTAFINV').AsDate := StrToDate(mskDtaFinV.Text);

    If not fEmptyStr(fTiraCaracEspeciais(mskCompet.Text)) then
      ParamByName('COMPET').AsString := mskCompet.Text;

    If edtFornecFilial.Text <> 'T' Then
      ParamByName('FORFIL').AsString := fRetForFilialTodos;
  End;
end;

end.
