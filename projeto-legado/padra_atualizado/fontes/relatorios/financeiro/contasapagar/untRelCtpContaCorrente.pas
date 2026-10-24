unit untRelCtpContaCorrente;

interface

uses
  SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiRelatorio, RLFilters, RLDraftFilter,
  EditFocus, Buttons, ExtCtrls, Mask, MaskEditFocus, StrUtils, ComObj,
  QColorLabel, Menus, frxDesgn, frxClass, frxDBSet, frxDMPExport, Uni,
  frxExportPDF, frxExportHTML, frxExportXLS, frxExportRTF,
  AppEvnts, UniDataSetProvider, UniClientDataSet, BitBtnLockedIncrem, Data.DB,
  frxExportCSVTestabilidade, untTypesSistema, untIFuncoes;

type
  TfrmRelCtpContaCorrente = class(TfrmPaiRelatorio)
    Label5: TLabel;
    mskDtaIni: TMaskEditFocus;
    lblData1: TLabel;
    mskDtaFin: TMaskEditFocus;
    Label6: TLabel;
    lblData2: TLabel;
    edtCodFornecedor: TEditFocus;
    Label12: TLabel;
    edtCodEmpresa: TEditFocus;
    lblEmpresa: TLabel;
    gpbBoleto: TGroupBox;
    edtBoleto: TEditFocus;
    gpbContas: TGroupBox;
    edtContas: TEditFocus;
    ColorLabel2: TColorLabel;
    ColorLabel3: TColorLabel;
    edtDesFornecedor: TEditFocus;
    edtDesEmpresa: TEditFocus;
    Label1: TLabel;
    edtCodEve: TEditFocus;
    edtDesEve: TEditFocus;
    gpbIncPrevis: TGroupBox;
    ColorLabel4: TColorLabel;
    edtIncPrevis: TEditFocus;
    svdExcel: TSaveDialog;
    chkAjuDta: TCheckBox;
    Label2: TLabel;
    mskCodCta: TMaskEditFocus;
    edtDesCta: TEditFocus;
    chkBaiCarCredito: TCheckBox;
    GroupBox1: TGroupBox;
    ColorLabel5: TColorLabel;
    edtOrdem: TEditFocus;
    GroupBox2: TGroupBox;
    ColorLabel6: TColorLabel;
    edtUsoCon: TEditFocus;
    dtsRelatorio: TDataSource;
    mskCompet: TMaskEditFocus;
    Label3: TLabel;
    lblPortador: TLabel;
    edtCodPorCadastro: TEditFocus;
    edtDesPorCadastro: TEditFocus;
    Label4: TLabel;
    edtCodPorBaixa: TEditFocus;
    edtDesPorBaixa: TEditFocus;
    Shape1: TShape;
    procedure FormShow(Sender: TObject);
    procedure edtCodFornecedorExit(Sender: TObject);
    procedure edtCodFornecedorKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpresaExit(Sender: TObject);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure btnImprimirClick(Sender: TObject);
    procedure edtContasExit(Sender: TObject);
    procedure edtCodEveExit(Sender: TObject);
    procedure edtCodEveKeyPress(Sender: TObject; var Key: Char);
    procedure pCarregaEventos(Var qryCadEve: TUniQuery);
    procedure edtDestinoExit(Sender: TObject);
    procedure mskCodCtaKeyPress(Sender: TObject; var Key: Char);
    procedure mskCodCtaExit(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtCodPorCadastroKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodPorBaixaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodPorCadastroExit(Sender: TObject);
    procedure edtCodPorBaixaExit(Sender: TObject);
  private
    { Private declarations }
    qryRelatorio: TUniQuery;
    arrFornec: TConsultasArray;
    arrEmp: TConsultasArray;
    arrEvento: TConsultasArray;
    arrCentroCusto : TConsultasArray;
    arrPorCadastro: TConsultasArray;
    arrPorBaixa: TConsultasArray;

    strFornecedor  : String;
    strEvento: String;
    strEmpresa: String;
    strCentroCusto: String;
    strPortadorCadastro: String;
    strPortadorBaixa: String;

    procedure pGeraExcel;
    procedure pAjustaData;

    procedure pCriaQryRelatorio;
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  public
    { Public declarations }
    dspRelatorio: TUniDataSetProvider;
    cdsRelatorio: TUniClientDataSet;
  end;

var
  frmRelCtpContaCorrente: TfrmRelCtpContaCorrente;

implementation

uses untfuncoesfactory, untQckCtpContaCorrente, untPai, untExcel;

{$R *.dfm}

procedure TfrmRelCtpContaCorrente.FormShow(Sender: TObject);
begin
  pCriaQryRelatorio;

  edtCodEmpresa.Text := VS_strCodEmp;
  edtDesEmpresa.Text := fRetNomeEmpresa;

  mskDtaIni.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
  mskDtaFin.Text := FormatDateTime('dd/mm/yyyy',VS_Date);

  pSetFocus(edtContas);
  inherited;
end;

procedure TfrmRelCtpContaCorrente.edtCodFornecedorExit(Sender: TObject);
begin
  inherited;
  If Not edtCodFornecedor.ReadOnly Then
    pEdtCodSelectExit(edtCodFornecedor, edtDesFornecedor, arrFornec, fRetNomFornecedor, Nil, 'do fornecedor');
end;

procedure TfrmRelCtpContaCorrente.edtCodFornecedorKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************RV*}
  If fPesqFornecedor(conForSimples, Self, edtCodFornecedor, edtDesFornecedor, Nil, Key, arrFornec, False) Then
  Begin
    If fValidaCampos(edtCodFornecedor, False) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelCtpContaCorrente.edtCodPorBaixaExit(Sender: TObject);
begin
  inherited;
    If Not edtCodPorBaixa.ReadOnly Then
    pEdtCodSelectExit(edtCodPorBaixa, edtDesPorBaixa, arrPorBaixa, Nil, fRetNomPortador, 'do portador');
end;

procedure TfrmRelCtpContaCorrente.edtCodPorBaixaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqPortador(conSimples, Self, edtCodPorBaixa, edtDesPorBaixa, nil, Key, arrPorBaixa, False) Then
  Begin
    If fValidaCampos(edtCodPorBaixa,False) Then
      self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelCtpContaCorrente.edtCodPorCadastroExit(Sender: TObject);
begin
  inherited;
  If Not edtCodPorCadastro.ReadOnly Then
    pEdtCodSelectExit(edtCodPorCadastro, edtDesPorCadastro, arrPorCadastro, Nil, fRetNomPortador, 'do portador');
end;

procedure TfrmRelCtpContaCorrente.edtCodPorCadastroKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqPortador(conSimples, Self, edtCodPorCadastro, edtDesPorCadastro, nil, Key, arrPorCadastro, False) Then
  Begin
    If fValidaCampos(edtCodPorCadastro,False) Then
      self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelCtpContaCorrente.edtCodEmpresaExit(Sender: TObject);
begin
  inherited;
  If Not edtCodEmpresa.ReadOnly Then
    pEdtCodSelectExit(edtCodEmpresa, edtDesEmpresa, arrEmp, Nil, fRetNomeEmpresaSelec, 'da empresa');
end;

procedure TfrmRelCtpContaCorrente.edtCodEmpresaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpresa, edtDesEmpresa, Nil, Key, arrEmp, False, True) Then
  Begin
    If fValidaCampos(edtCodEmpresa, False) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmRelCtpContaCorrente.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin
    {*********************}
    {* VALIDA DATAS      *}
    {******************LU*}
    If (Sender = mskDtaFin) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
      Begin
        fMensagem('', 'O campo Data Final deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) And fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
        Begin
          fMensagem('', 'O campo Data Inicial deve ser preenchido!', ['&Ok']);
          Sender := mskDtaIni;
          Result := False;
        End
        Else
        Begin
          If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) And (StrToDateDef(mskDtaFin.Text, 0) <= 0) Then
          Begin
            fMensagem('', 'Data Final informada é inválida! Necessário correção.', ['&O k']);
            Result := False;
          End
          Else
          If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
          Begin
            If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
            Begin
              fMensagem('','A data inicial deve ser menor que a data final!',['&O K']);
              Sender := mskDtaIni;
              Result := False;
            End;
          End;
        End;
      End;
    End
    Else
    If (Sender = mskDtaIni) Then
    Begin
      If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) and (StrToDateDef(mskDtaIni.Text, 0) <= 0) Then
      Begin
        fMensagem('', 'Data Inicial informada é inválida! Necessário correção.', ['&O k']);
        Result := False;
        Sender := mskDtaIni;
      End;
    End;

    if (Sender = mskCompet) then
    Begin
      if not fEmptyStr(fTiraCaracEspeciais(mskCompet.Text)) then
      begin
        If not fValidaDataStr('01/'+ mskCompet.Text) Then
        Begin
          pMensagemOk('Data informada na Competência não é válida!');
          Result := False;
        End;
      end;
    End;

    {****************************}
    {* VERIFICA CAMPO DO BOLETO *}
    {*************************AF*}
    If (Sender = edtBoleto) Then
    Begin
      If (edtBoleto.Text <> 'T') And (edtBoleto.Text <> 'N') And (edtBoleto.Text <> 'S') Then
      Begin
        fMensagem('ATENÇÃO!','O campo Boleto deve ser T,N ou S.',['&O K']);
        Result := False;
      End;
    End;
    {*************************}
    {* VERIFICA COMPO CONTAS *}
    {**********************AF*}
    If (Sender = edtContas) Then
    Begin
      If (edtContas.Text <> 'T') And (edtContas.Text <> 'Q') And (edtContas.Text <> 'A') Then
      Begin
        fMensagem('ATENÇÃO!','O campo conta deve ser T,A ou Q.',['&O K']);
        Result := False;
      End;
    End
    Else
    {***************************************************}
    {* VALIDA O CAMPO INCLUIR PREVISAO                 *}
    {************************************************LB*}
    If (Sender = edtIncPrevis) Then
    Begin
      If fEmptyStr(edtIncPrevis.Text) Then
      Begin
        fMensagem('ATEÇÃO','O Campo Previsão deve ser preenchido!',['&OK']);
        Result := False;
      End
      Else
      If (edtIncPrevis.Text <> 'S') And (edtIncPrevis.Text <> 'N') And (edtIncPrevis.Text <> 'T') Then
      Begin
        fMensagem('ATENÇÃO','O Campo Previsão deve conter somente S, N ou T!',['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtUsoCon) Then
    Begin

    {*********************************}
    {* VERIFICA CAMPO DO USO/CONSUMO *}
    {******************************TH*}
      If (edtUsoCon.Text <> 'T') And (edtUsoCon.Text <> 'N') And (edtUsoCon.Text <> 'S') Then
      Begin
        fMensagem('ATENÇÃO!','O campo Uso/Consumo deve ser T, N ou S.',['&O K']);
        Result := False;
      End;

    End

    Else If (Sender = edtCodEmpresa) Then
    Begin
      If Not fEmptyStr(edtCodEmpresa.Text) And (edtCodEmpresa.Text <> '000') Then
      Begin
        If Pos(edtCodEmpresa.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtOrdem) Then
    Begin

      If (Pos(edtOrdem.Text, 'C_N_') <= 0) Then
      Begin
        fMensagem('ATENÇÃO', 'Ordenar por deve ser C ou N!', ['&Ok']);
        Result := False;
      End;

    End

    Else If (Sender = edtDestino) Then
    Begin
      If fEmptyStr(edtDestino.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'O Destino do Relatório deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (Pos(edtDestino.Text, 'V_I_E_') <= 0) Then
      Begin
        fMensagem('ATENÇÃO', 'O Destino do Relatório deve ser V, I ou E!', ['&Ok']);
        Result := False;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmRelCtpContaCorrente.btnImprimirClick(Sender: TObject);
  Var
    strSQL: String;
begin
  pnlInfo.Caption := 'Gerando Relatório...';
  pnlInfo.Repaint;
  If SameText(edtDestino.Text, 'E') Then
  Begin
    btnImprimir.Enabled := False;
    blnImprime := fVerificaCampos;
  End
  Else
    inherited;

  Try
    If blnImprime Then
    Begin

      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '       P.CTP_SEQBAI, P.CTP_DTACAD, P.CTP_DTAVEN, ';
      strSQL := strSQL + '       P.CTP_PARCEL, P.CTP_CODEMP, P.CTP_CODCTA, ';
      strSQL := strSQL + '       P.CTP_NUMDUP, P.CTP_VEIOBO, P.CTP_USACHQ, ';
      strSQL := strSQL + '       P.CTP_PREVIS, P.CTP_DTAPAG, P.CTP_CODEVE, ';
      strSQL := strSQL + '       P.CTP_VALDUP, P.CTP_DESSUJ, P.CTP_JURSUJ, ';
      strSQL := strSQL + '       P.CTP_CODFOR, F.FOR_NOMFOR, P.CTP_VENDOR, ';
      strSQL := strSQL + '       P.CTP_HIST01, P.CTP_HIST02, P.CTP_TIPDOC, ';
      strSQL := strSQL + '       P.CTP_CODPOR, P.CTP_PORBAI, ';
      strSQL := strSQL + '       REPLACE(CONCAT(IFNULL(P.CTP_HIST01, ""), " ", IFNULL(P.CTP_HIST02, "")), "<<csq>>", " ") AS CTP_HISCOM, ';

      // Se for selecionado TODOS e algum registro estiver em ABERTO não mostrará a diferença
      If (edtContas.Text = 'T') Then
      Begin
        strSQL := strSQL + '  P.CTP_VALPAG, ';
        strSQL := strSQL + '  IF (P.CTP_DTAPAG IS NULL, (P.CTP_VALDUP + IFNULL(P.CTP_JURSUJ, 0) - IFNULL(P.CTP_DESSUJ, 0)), ';
        strSQL := strSQL + '      P.CTP_VALPAG - IFNULL(P.CTP_VALJUR, 0) - IFNULL(P.CTP_VENDOR, 0) + IFNULL(P.CTP_VALDES, 0) ';
        strSQL := strSQL + '     ) AS CTP_VALORI, ';

        strSQL := strSQL + '  IF (P.CTP_DTAPAG IS NULL, 0.00, ';
        strSQL := strSQL + '      P.CTP_VALPAG - (P.CTP_VALPAG - IFNULL(P.CTP_VALJUR, 0) - IFNULL(P.CTP_VENDOR, 0) + IFNULL(P.CTP_VALDES, 0)) ';
        strSQL := strSQL + '     ) AS VALDIF ';
      End
      Else
      // Se for QUITADOS caso tenha diferença essa será mostrada
      if  (edtContas.Text = 'Q') Then
      Begin
        strSQL := strSQL + '  P.CTP_VALPAG, ';
        strSQL := strSQL + '  (P.CTP_VALPAG - IFNULL(P.CTP_VALJUR, 0) - IFNULL(P.CTP_VENDOR, 0) + IFNULL(P.CTP_VALDES, 0)) AS CTP_VALORI, ';
        strSQL := strSQL + '  (P.CTP_VALPAG - (P.CTP_VALPAG - IFNULL(P.CTP_VALJUR, 0) - IFNULL(P.CTP_VENDOR, 0) + IFNULL(P.CTP_VALDES, 0))) AS VALDIF ';
      End
      Else
      Begin
        // Se for ABERTOS será calculado a diferença levando em conta os juros e descontos segeridos e
        // será recalculado o valor da duplicata mostrando uma coluna chamada 'Val. Corrigido'

        strSQL := strSQL + ' (P.CTP_VALDUP) AS CTP_VALORI, ';
        strSQL := strSQL + ' (P.CTP_VALDUP - (P.CTP_VALDUP - IFNULL(P.CTP_JURSUJ, 0) + IFNULL(P.CTP_DESSUJ, 0))) AS VALDIF, ';
        strSQL := strSQL + ' (P.CTP_VALDUP + (P.CTP_VALDUP - (P.CTP_VALDUP - IFNULL(P.CTP_JURSUJ, 0) + IFNULL(P.CTP_DESSUJ, 0)))) AS CTP_VALPAG ';
      End;

      strSQL := strSQL + 'FROM CADPAG P ';
      strSQL := strSQL + 'JOIN CADFOR F ON P.CTP_CODFOR = F.FOR_CODFOR ';
      strSQL := strSQL + 'WHERE ';

      If (edtIncPrevis.Text = 'N') Then
        strSQL := strSQL + '  CTP_PREVIS <> "S" AND '
      Else
      If (edtIncPrevis.Text = 'S') Then
        strSQL := strSQL + '  CTP_PREVIS = "S" AND ';

      If edtContas.Text = 'A' Then
        strSQL := strSQL + '  CTP_DTAPAG IS NULL AND '
      Else If edtContas.Text = 'Q' Then
        strSQL := strSQL + '  CTP_DTAPAG IS NOT NULL AND ';

      If edtContas.Text = 'Q' Then
      Begin

        If chkAjuDta.Checked Then
          strSQL := strSQL + '  CTP_DTAPAG BETWEEN DATE_SUB(:DTAINI, INTERVAL 7 DAY) AND :DTAFIN '
        Else
          strSQL := strSQL + '  CTP_DTAPAG BETWEEN :DTAINI AND :DTAFIN ';

      End
      Else
      Begin

        If chkAjuDta.Checked Then
          strSQL := strSQL + '  CTP_DTAVEN BETWEEN DATE_SUB(:DTAINI, INTERVAL 7 DAY) AND :DTAFIN '
        Else
          strSQL := strSQL + '  CTP_DTAVEN BETWEEN :DTAINI AND :DTAFIN ';

      End;


      if not fEmptyStr(fTiraCaracEspeciais(mskCompet.Text)) then
        strSQL := strSQL + '  AND CTP_COMPET = :COMPET ';

      If Not fEmptyStr(edtDesFornecedor.Text) Then
      Begin
        strSQL  := strSQL + fStrLocate(edtCodFornecedor,  arrFornec,  'P.CTP_CODFOR', 'CODFOR');
      End;

      If Not fEmptyStr(edtCodEmpresa.Text) Then
        strSQL  := strSQL + fStrLocate(edtCodEmpresa,  arrEmp,  'P.CTP_CODEMP', 'CODEMP')
      Else
        strSQL := strSQL + '  AND LOCATE(CTP_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';

      If Not fEmptyStr(edtCodPorCadastro.Text) Then
         strSQL  := strSQL + fStrLocate(edtCodPorCadastro,  arrPorCadastro,  'P.CTP_CODPOR', 'CODPOR')
      Else If fCfgSis('DACPOR', varBoolean) Then
      Begin
        strSQL := strSQL + ' AND (IFNULL(CTP_CODPOR, "") = "" ';
        strSQL := strSQL + ' OR LOCATE(CTP_CODPOR, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
      End;

      If Not fEmptyStr(edtCodPorBaixa.Text) Then
        strSQL  := strSQL + fStrLocate(edtCodPorBaixa,  arrPorBaixa,  'P.CTP_PORBAI', 'PORBAI')
      Else If fCfgSis('DACPOR', varBoolean) Then
      Begin
        strSQL := strSQL + ' AND (IFNULL(CTP_PORBAI, "") = "" ';
        strSQL := strSQL + ' OR LOCATE(CTP_PORBAI, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
      End;

      If (Not fEmptyStr(mskCodCta.Text)) Then
      Begin
        If (RightStr(mskCodCta.Text, 5) = '00000') Then
          strSQL := strSQL + '  AND LEFT(CTP_CODCTA, 2) = LEFT(:CODCTA, 2) '
        Else If (RightStr(mskCodCta.Text, 3) = '000') Then
          strSQL := strSQL + '  AND LEFT(CTP_CODCTA, 4) = LEFT(:CODCTA, 4) '
        Else
          strSQL := strSQL + fStrLocate(mskCodCta,  arrCentroCusto,  'P.CTP_CODCTA', 'CODCTA');
      End;

      If Not fEmptyStr(edtDesEve.Text) Then
      Begin
        strSQL  := strSQL + fStrLocate(edtCodEve,  arrEvento,  'P.CTP_CODEVE', 'CODEVE');
      End;

      If (edtBoleto.Text = 'S') Then
        strSQL := strSQL + '  AND CTP_VEIOBO = ' + QuotedStr('S')
      Else If (edtBoleto.Text = 'N') Then
        strSQL := strSQL + '  AND CTP_VEIOBO = ' + QuotedStr('N');

      If (Not chkBaiCarCredito.Checked) And (Not fEmptyStr(fCfgSis('CTACAR'))) Then
        strSQL := strSQL + '  AND CTP_CODCTA <> ' + QuotedStr(fCfgSis('CTACAR')) ;

      If (Not chkBaiCarCredito.Checked) Then
        strSQL := strSQL + '  AND CTP_SERIE_ <> ' + QuotedStr('CRT') ;

      If (edtUsoCon.Text <> 'T') Then
        strSQL := strSQL + ' AND CTP_USOCON = ' + QuotedStr(edtUsoCon.Text);

      strSQL := strSQL + ' ORDER BY ';

      If edtOrdem.Text = 'C' Then
        strSQL := strSQL + '  CTP_CODFOR, '
      Else
        strSQL := strSQL + '  FOR_NOMFOR, ';

      strSQL := strSQL + '  CTP_NUMDUP, CTP_PARCEL, CTP_SEQBAI, CTP_CODEMP ';

      With qryRelatorio Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
        ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);

        If Not fEmptyStr(edtDesFornecedor.Text) Then
          pSetaParam(edtCodFornecedor.Text, arrFornec, strFornecedor, 'CODFOR', qryRelatorio);

        If Not fEmptyStr(edtDesEve.Text) Then
          pSetaParam(edtCodEve.Text, arrEvento, strEvento, 'CODEVE', qryRelatorio);

        If Not fEmptyStr(edtDesEmpresa.Text) Then
          pSetaParam(edtCodEmpresa.Text, arrEmp, strEmpresa, 'CODEMP', qryRelatorio);

        If Not fEmptyStr(edtDesPorCadastro.Text) Then
          pSetaParam(edtCodPorCadastro.Text, arrPorCadastro, strPortadorCadastro, 'CODPOR', qryRelatorio);

        If Not fEmptyStr(edtDesPorBaixa.Text) Then
          pSetaParam(edtCodPorBaixa.Text, arrPorBaixa, strPortadorBaixa, 'PORBAI', qryRelatorio);

        If Not fEmptyStr(fTiraCaracEspeciais(mskCodCta.Text)) Then
          pSetaParam(mskCodCta.Text, arrCentroCusto, strCentroCusto, 'CODCTA', qryRelatorio);

        if not fEmptyStr(fTiraCaracEspeciais(mskCompet.Text)) then
          ParamByName('COMPET').AsString := mskCompet.Text;

        Open;
      End;

      pSetaClient(qryRelatorio);

      dspRelatorio := TUniDataSetProvider.Create(Self);
      cdsRelatorio := TUniClientDataSet.Create(Self);

      dspRelatorio.DataSet := qryRelatorio;
      cdsRelatorio.SetProvider(dspRelatorio);

      dtsRelatorio.DataSet := cdsRelatorio;

      cdsRelatorio.Open;

      cdsRelatorio.Filtered := False;
      cdsRelatorio.Filter   := '';

      If chkAjuDta.Checked Then
        pAjustaData;

      If edtContas.Text = 'Q' Then
        cdsRelatorio.Filter   := QuotedStr(FormatDateTime('dd/MM/yyyy', StrToDate(mskDtaIni.Text))) + ' <= CTP_DTAPAG AND ' + QuotedStr(FormatDateTime('dd/MM/yyyy', StrToDate(mskDtaFin.Text))) + ' >= CTP_DTAPAG'
      Else
        cdsRelatorio.Filter   := QuotedStr(FormatDateTime('dd/MM/yyyy', StrToDate(mskDtaIni.Text))) + ' <= CTP_DTAVEN AND ' + QuotedStr(FormatDateTime('dd/MM/yyyy', StrToDate(mskDtaFin.Text))) + ' >= CTP_DTAVEN';

      cdsRelatorio.Filtered := True;

      If Not cdsRelatorio.IsEmpty Then
      Begin
        Try
          pCriarFormularios(TfrmQckCtpContaCorrente,frmQckCtpContaCorrente);

          frmQckCtpContaCorrente.dtsRelatorio.DataSet := cdsRelatorio;

          frmQckCtpContaCorrente.cdsRelatorio := cdsRelatorio;

          If strTipImp = 'M' Then
            frmQckCtpContaCorrente.qckPagina.DefaultFilter := rldFiltro
          Else
            frmQckCtpContaCorrente.qckPagina.DefaultFilter := Nil;

          If edtOrdem.Text = 'C' Then
          Begin
            If strTipImp = 'M' then
              frmQckCtpContaCorrente.rllOrdenacao.Caption := 'ORDEM: CODIGO DO FORNECEDOR'
            Else
              frmQckCtpContaCorrente.rllOrdenacao.Caption := 'ORDEM: CÓDIGO DO FORNECEDOR';
          End
          Else
            frmQckCtpContaCorrente.rllOrdenacao.Caption := 'ORDEM: NOME DO FORNECEDOR';

          If strTipImp = 'M' then
            frmQckCtpContaCorrente.strOrdem := 'REFERENTE AO PERIODO DE ' + mskDtaIni.Text + ' A ' + mskDtaFin.Text
          Else
            frmQckCtpContaCorrente.strOrdem := 'REFERENTE AO PERÍODO DE ' + mskDtaIni.Text + ' A ' + mskDtaFin.Text;

          If (edtIncPrevis.Text = 'T') Then
          Begin
            If strTipImp = 'M' then
              frmQckCtpContaCorrente.rllIncPrevis.Caption := 'PREVISAO: TODOS '
            Else
              frmQckCtpContaCorrente.rllIncPrevis.Caption := 'PREVISÃO: TODOS ';
          End
          Else
          If (edtIncPrevis.Text = 'S') Then
          Begin
            If strTipImp = 'M' then
              frmQckCtpContaCorrente.rllIncPrevis.Caption := 'PREVISAO: SIM '
            Else
              frmQckCtpContaCorrente.rllIncPrevis.Caption := 'PREVISÃO: SIM ';
          End
          Else
            If strTipImp = 'M' then
              frmQckCtpContaCorrente.rllIncPrevis.Caption := 'PREVISAO: NAO '
            Else
              frmQckCtpContaCorrente.rllIncPrevis.Caption := 'PREVISÃO: NÃO ';

          If edtContas.Text = 'T' Then
          Begin
            If strTipImp = 'M' then
              frmQckCtpContaCorrente.rllNomeRelatorio.Caption := 'RELATORIO DE CONTA CORRENTE A PAGAR - TODOS '
            Else
              frmQckCtpContaCorrente.rllNomeRelatorio.Caption := 'RELATÓRIO DE CONTA CORRENTE A PAGAR - TODOS ';
          End
          Else
          If edtContas.Text = 'Q' Then
          Begin
            If strTipImp = 'M' then
              frmQckCtpContaCorrente.rllNomeRelatorio.Caption := 'RELATORIO DE CONTA CORRENTE A PAGAR - QUITADOS '
            Else
              frmQckCtpContaCorrente.rllNomeRelatorio.Caption := 'RELATÓRIO DE CONTA CORRENTE A PAGAR - QUITADOS ';
          End
          Else
          If edtContas.Text = 'A' Then
          Begin
            frmQckCtpContaCorrente.RLLTitValPago.Caption   := 'VL. CORRIGIDO';
            frmQckCtpContaCorrente.RLLTitPagamento.Caption := '';
            If strTipImp = 'M' then
              frmQckCtpContaCorrente.rllNomeRelatorio.Caption := 'RELATORIO DE CONTA CORRENTE A PAGAR - EM ABERTO '
            Else
              frmQckCtpContaCorrente.rllNomeRelatorio.Caption := 'RELATÓRIO DE CONTA CORRENTE A PAGAR - EM ABERTO ';
          End;

          If edtCodFornecedor.Text = '' Then
            frmQckCtpContaCorrente.rllFornecedor.Caption := 'FORNECEDOR: TODOS'
          Else
            frmQckCtpContaCorrente.rllFornecedor.Caption := 'FORNECEDOR: ' + edtCodFornecedor.Text + '-' + edtDesFornecedor.Text;

          If edtCodEmpresa.Text = '' Then
            frmQckCtpContaCorrente.rllEmpresa.Caption := 'EMPRESA: TODAS'
          Else
            frmQckCtpContaCorrente.rllEmpresa.Caption := 'EMPRESA: ' + edtDesEmpresa.Text;

          If edtCodPorCadastro.Text = '' Then
            frmQckCtpContaCorrente.rllPortadorCadastro.Caption := 'PORTADOR CADASTRO: TODOS'
          Else
            frmQckCtpContaCorrente.rllPortadorCadastro.Caption := 'PORTADOR CADASTRO: ' + edtDesPorCadastro.Text;

          If edtCodPorBaixa.Text = '' Then
            frmQckCtpContaCorrente.rllPortadorBaixa.Caption := 'PORTADOR BAIXA: TODOS'
          Else
            frmQckCtpContaCorrente.rllPortadorBaixa.Caption := 'PORTADOR BAIXA: ' + edtDesPorBaixa.Text;

          If edtCodEve.Text = '' Then
            frmQckCtpContaCorrente.rllEventos.Caption := 'EVENTO: TODOS'
          Else
            frmQckCtpContaCorrente.rllEventos.Caption := 'EVENTO ' + edtCodEve.Text + ' - ' + edtDesEve.Text;

          If (fEmptyStr(mskCodCta.Text)) Then
            frmQckCtpContaCorrente.rllCodCta.Caption := 'PLANO DE CONTAS: TODOS '
          Else
            frmQckCtpContaCorrente.rllCodCta.Caption := 'PLANO DE CONTAS: ' + mskCodCta.Text + ' - ' + edtDesCta.Text;

          If edtBoleto.Text = 'S' Then
            frmQckCtpContaCorrente.rllBoleto.Caption := 'VEIO BOLETO?: SIM'
          Else
          If edtBoleto.Text = 'N' Then
          Begin
            If strTipImp = 'M' then
              frmQckCtpContaCorrente.rllBoleto.Caption := 'VEIO BOLETO?: NAO'
            Else
              frmQckCtpContaCorrente.rllBoleto.Caption := 'VEIO BOLETO?: NÃO';
          End
          Else
            frmQckCtpContaCorrente.rllBoleto.Caption := 'VEIO BOLETO?: TODOS';

          If edtUsoCon.Text <> 'T' Then
          Begin
            If strTipImp = 'M' then
              frmQckCtpContaCorrente.rllUsoCon.Caption := 'USO/CONSUMO?: ' + ifthen(edtUsoCon.Text = 'S', 'SIM', 'NAO')
            Else
              frmQckCtpContaCorrente.rllUsoCon.Caption := 'USO/CONSUMO?: ' + ifthen(edtUsoCon.Text = 'S', 'SIM', 'NÃO')
          End
          Else
              frmQckCtpContaCorrente.rllUsoCon.Caption := 'USO/CONSUMO?: TODOS';

          If strTipImp = 'M' then
            frmQckCtpContaCorrente.RLLTitHistorico.Caption := 'HISTORICO'
          Else
            frmQckCtpContaCorrente.RLLTitHistorico.Caption := 'HISTÓRICO';

          If strTipImp = 'M' then
            frmQckCtpContaCorrente.RLLTitDiferenca.Caption := 'DIFERENCA'
          Else
            frmQckCtpContaCorrente.RLLTitDiferenca.Caption := 'DIFERENÇA';
          If edtDestino.Text = 'V' Then
            frmQckCtpContaCorrente.qckPagina.PreviewModal
          Else If edtDestino.Text = 'I' Then
            frmQckCtpContaCorrente.qckPagina.Print
          Else If edtDestino.Text = 'E' Then
            pGeraExcel;

        Except
          On E: Exception Do
          Begin
            pMensagensErro(E.Message, '['+Self.Name+' -> (Ocorreu um erro durante a Impressao)]');
          End;
        End;
        pFreeAndNil(frmQckCtpContaCorrente);
      End
      Else
      Begin
        pTabelaVazia;
      End;

    End;
  Except
    On E: Exception do
    Begin
      pMensagensErro('Ocorreu um erro ao gerar o relatório em Excel. Entre em contato com a Citel!' +
                    #13 + #13 + 'Erro gerado: ' + E.Message, '[frmRelCtpContaCorrente.btnImprimirClick]');
    End;
  End;

  btnImprimir.Enabled := True;
  pnlInfo.Caption := '';
end;

procedure TfrmRelCtpContaCorrente.edtContasExit(Sender: TObject);
begin
  inherited;
  If edtContas.Text = 'Q' Then
  Begin
    lblData1.Caption := '(PAGAMENTO)';
    lblData2.Caption := '(PAGAMENTO)';
  End
  Else
  Begin
    lblData1.Caption := '(VENCIMENTO)';
    lblData2.Caption := '(VENCIMENTO)';
  End;
end;

procedure TfrmRelCtpContaCorrente.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryRelatorio);
end;

procedure TfrmRelCtpContaCorrente.edtCodEveExit(Sender: TObject);
begin
  inherited;
  If Not edtCodEve.ReadOnly Then
    pEdtCodSelectExit(edtCodEve, edtDesEve, arrEvento, fRetNomEvento, Nil, 'do Centro de Custos');
end;

procedure TfrmRelCtpContaCorrente.edtCodEveKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EVENTOS    *}
  {****************************RV*}
  If fPesqEventos(Self, edtCodEve, edtDesEve, Nil, Key, arrEvento, False) Then
  Begin
    If fValidaCampos(edtCodEve, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelCtpContaCorrente.pCarregaEventos(Var qryCadEve: TUniQuery);
begin

  If Not (fEmptyStr(edtCodEve.Text)) Then
     edtDesEve.Text := qryCadEve.FieldByName('EVE_DESEVE').AsString
  Else
    edtDesEve.Text := '';

end;

procedure TfrmRelCtpContaCorrente.pCriaQryRelatorio;
begin
  qryRelatorio:= fCriaQuery(Self);
  frxRelatorio.DataSet := qryRelatorio;

end;

procedure TfrmRelCtpContaCorrente.pGeraExcel;
  Var
    objExcel : TExcel;
    strUltLet,
    strNomArq: String;

    fltToPOri: Double;
    fltToPDif: Double;
    fltToPPag: Double;
    fltToGOri: Double;
    fltToGDif: Double;
    fltToGPag: Double;
    fltToVenc: Double;
    fltToVencer: Double;
    fltToPagos: Double;

    strGruFor: String;

  function fArquivoAberto: Boolean;
  var
   stmArquiv: TStream;
  begin
    Result := False;
    Try
       Try
         If FileExists(strNomArq) Then
           stmArquiv := TFileStream.Create(strNomArq, fmOpenRead or fmShareExclusive);
       Except
         on EStreamError do
         Begin
           pMensagemOK('O arquivo ' + strNomArq + ' está sendo usado por outro processo. Operação cancelada!');
           Result := True; // EFOpenError
         End;
       End;
    Finally
      If Assigned(stmArquiv) Then
        FreeAndNil(stmArquiv);
    End;
  End;

begin
  Try

    strUltLet := 'M';

    {*******************************************}
    {* CRIA UM OBJETO DO TIPO "EXCEL" E TORNA  *}
    {* A APLICAÇÃO INVISÍVEL                   *}
    {****************************************JB*}
    objExcel := TExcel.fCriarExcel(Nil);

    {*******************************************}
    {* ADICIONA UMA PASTA DE TRABALHO          *}
    {****************************************JB*}
    If Not objExcel.CriarArquivo Then
    Begin
      FreeAndNil(objExcel);
      Exit;
    End;

    With objExcel Do
    Begin
      strNomArq := NomeArquivo;

      If fArquivoAberto Then
      Begin
        FreeAndNil(objExcel);
        Exit;
      End;

      LinhaAtual := 01;
      {********************************}
      {* EMPRESA PADRAO DO SISTEMA    *}
      {*****************************MV*}
      Escrever(ProximaLinha, 01, fRetNomeEmpresaSelec(VS_strCodEmp));

      {*******************************************}
      {* TITULO DO RELATORIO                     *}
      {****************************************JB*}
      If edtContas.Text = 'T' Then
        Escrever(ProximaLinha, 01,  'RELATÓRIO DE CONTA CORRENTE A PAGAR - TODOS ')
      Else If edtContas.Text = 'Q' Then
        Escrever(ProximaLinha, 01, 'RELATÓRIO DE CONTA CORRENTE A PAGAR - QUITADOS ')
      Else If edtContas.Text = 'A' Then
        Escrever(ProximaLinha, 01, 'RELATÓRIO DE CONTA CORRENTE A PAGAR - EM ABERTO ');

      ProximaLinha;

      {*******************************************}
      {* OUTROS DADOS DO RELATÓRIO               *}
      {****************************************JB*}
      Escrever(ProximaLinha, 01, 'REFERENTE AO PERÍODO DE ' + mskDtaIni.Text + ' A ' + mskDtaFin.Text);
      Escrever(ProximaLinha, 01, 'EMISSÃO: ' + FormatDateTime('dd/mm/yyyy hh:nn:ss', fNow()));

      If edtCodFornecedor.Text = '' Then
        Escrever(ProximaLinha, 01, 'FORNECEDOR: TODOS')
      Else
        Escrever(ProximaLinha, 01, 'FORNECEDOR: ' + edtCodFornecedor.Text + '-' + edtDesFornecedor.Text);

      If edtCodEmpresa.Text = '' Then
        Escrever(ProximaLinha, 01, 'EMPRESA: TODAS')
      Else
        Escrever(ProximaLinha, 01, 'EMPRESA: ' + edtDesEmpresa.Text);

      If edtCodEve.Text = '' Then
        Escrever(ProximaLinha, 01, 'CENTRO DE CUSTOS: TODOS')
      Else
        Escrever(ProximaLinha, 01, 'CENTRO DE CUSTOS ' + edtCodEve.Text + ' - ' + edtDesEve.Text);

      If (edtIncPrevis.Text = 'T') Then
        Escrever(ProximaLinha, 01, 'PREVISÃO: TODOS ')
      Else
      If (edtIncPrevis.Text = 'S') Then
        Escrever(ProximaLinha, 01, 'PREVISÃO: SIM ')
      Else
        Escrever(ProximaLinha, 01, 'PREVISÃO: NÃO ');

      If (fEmptyStr(mskCodCta.Text)) Then
        Escrever(ProximaLinha, 01, 'PLANO DE CONTAS: TODOS ')
      Else
        Escrever(ProximaLinha, 01, 'PLANO DE CONTAS: ' + mskCodCta.Text + ' - ' + edtDesCta.Text);

      If (fEmptyStr(edtCodPorCadastro.Text)) Then
        Escrever(ProximaLinha, 01, 'PORTADOR CADASTRO: TODOS')
      Else
        Escrever(ProximaLinha, 01, 'PORTADOR CADASTRO: ' + edtDesPorCadastro.Text);

      If (fEmptyStr(edtCodPorBaixa.Text)) Then
        Escrever(ProximaLinha, 01, 'PORTADOR BAIXA: TODOS')
      Else
        Escrever(ProximaLinha, 01, 'PORTADOR BAIXA: ' + edtDesPorBaixa.Text);

      Escrever(ProximaLinha, 01, 'ORDEM: ' + ifthen(edtOrdem.Text = 'C', 'Código', 'NOME FORNECEDOR'));
      Escrever(ProximaLinha, 01, 'USO/CONSUMO: ' + ifthen(edtUsoCon.Text = 'T', 'TODOS', ifthen(edtUsoCon.Text = 'S', 'SIM', 'NÃO')));
      Escrever(ProximaLinha, 01, 'VEIO BOLETO?: ' + ifthen(edtBoleto.Text = 'T', 'TODOS', ifthen(edtBoleto.Text = 'S', 'SIM', 'NÃO')));

      {********************************}
      {* COLOCA EM NEGRITO E ALINHA   *}
      {* AO CENTRO DA CELULA          *}
      {*****************************JB*}
      Mesclar('A1', strUltLet + '1');
      Mesclar('A2', strUltLet + '2');
      Mesclar('A3', strUltLet + '3');
      Alinhamento('A1', strUltLet + '3', Centro);
      Negrito('A1', strUltLet + '3', True);

      Mesclar('A4', strUltLet + '4');
      Mesclar('A5', strUltLet + '5');
      Mesclar('A6', strUltLet + '6');
      Mesclar('A7', strUltLet + '7');
      Mesclar('A8', strUltLet + '8');
      Mesclar('A9', strUltLet + '9');
      Mesclar('A10', strUltLet + '10');
      Mesclar('A11', strUltLet + '11');
      Mesclar('A12', strUltLet + '12');
      Mesclar('A13', strUltLet + '13');
      Mesclar('A14', strUltLet + '14');
      Mesclar('A15', strUltLet + '15');
      Mesclar('A16', strUltLet + '16');

      Alinhamento('A4', strUltLet + '16', Centro);
      Negrito('A4', strUltLet + '16', True);

      ProximaLinha;
      {*******************************************}
      {* COLUNAS                                 *}
      {****************************************JB*}
      Escrever(LinhaAtual, 01, 'DATA CADASTRO');
      Escrever(LinhaAtual, 02, 'DUPLICATA');
      Escrever(LinhaAtual, 03, 'LOJA');
      Escrever(LinhaAtual, 04, 'CONTA');
      Escrever(LinhaAtual, 05, 'BOLETO?');
      Escrever(LinhaAtual, 06, 'CHEQUE');
      Escrever(LinhaAtual, 07, 'HISTÓRICO');
      Escrever(LinhaAtual, 08, 'PREVISÃO');
      Escrever(LinhaAtual, 09, 'PAGAMENTO');
      Escrever(LinhaAtual, 10, 'VENCIMENTO');
      Escrever(LinhaAtual, 11, 'VALOR');
      Escrever(LinhaAtual, 12, 'DIFERENÇA');

      If edtContas.Text = 'A' Then
        Escrever(LinhaAtual, 13, 'VALOR CORRIGIDO')
      Else
        Escrever(LinhaAtual, 13, 'VALOR PAGO');

      {*******************************************}
      {* COLOCA NEGRITO NAS COLUNAS              *}
      {****************************************JB*}
      Negrito('A17', strUltLet + '17', True);

      {*************************************}
      {* COLORI O FUNDO DA CELULA P/ CINZA *}
      {**********************************JB*}
      CorFundo('A2',  strUltLet + '2', Cinza);
      CorFundo('A3',  strUltLet + '3', Cinza);
      CorFundo('A17', strUltLet + '17', Cinza);

      {********************************}
      {* INSERE BORDAS NA CELULA      *}
      {*****************************JB*}
      Bordas('A2', strUltLet + '3');
      Bordas('A4', strUltLet + '17');

      ProximaLinha;
      With cdsRelatorio Do
      Begin
        First;

        fltToPOri := 0;
        fltToPDif := 0;
        fltToPPag := 0;

        fltToGOri := 0;
        fltToGDif := 0;
        fltToGPag := 0;

        fltToVenc   := 0;
        fltToVencer := 0;
        fltToPagos  := 0;

        strGruFor := EmptyStr;

        While (Not Eof) Do
        Begin
          {************************************}
          {* INSERE O CABEÇALHO DO GRUPO      *}
          {*********************************JB*}
          If Not SameText(strGruFor, FieldByName('CTP_CODFOR').AsString) Then
          Begin
            strGruFor := FieldByName('CTP_CODFOR').AsString;
            Escrever(LinhaAtual, 01, fFrtStrExcel('FORNECEDOR: ' + FieldByName('CTP_CODFOR').AsString + '-' +
                                     FieldByName('FOR_NOMFOR').AsString));
            Mesclar('A' + IntToStr(LinhaAtual), strUltLet + IntToStr(LinhaAtual));
            ProximaLinha;

            Bordas('A' + IntToStr(LinhaAtual), strUltLet + IntToStr(LinhaAtual), False, False, True, False);

          End;

          Escrever(LinhaAtual, 01, fFrtStrExcel(FormatDateTime('dd/mm/yyyy', FieldByName('CTP_DTACAD').AsDateTime)));
          Escrever(LinhaAtual, 02, fFrtStrExcel(FieldByName('CTP_NUMDUP').AsString + FieldByName('CTP_PARCEL').AsString));
          Escrever(LinhaAtual, 03, fFrtStrExcel(FieldByName('CTP_CODEMP').AsString));
          Escrever(LinhaAtual, 04, fFrtStrExcel(FieldByName('CTP_CODCTA').AsString));
          Escrever(LinhaAtual, 05, fFrtStrExcel(ifthen(FieldByName('CTP_VEIOBO').AsString = 'S', 'SIM', 'NAO')));
          Escrever(LinhaAtual, 06, fFrtStrExcel(ifthen(FieldByName('CTP_USACHQ').AsString = 'S', 'SIM', 'NAO')));
          Escrever(LinhaAtual, 07, fFrtStrExcel(FieldByName('CTP_HISCOM').AsString));
          Escrever(LinhaAtual, 08, fFrtStrExcel(ifthen(FieldByName('CTP_PREVIS').AsString = 'S', 'SIM', 'NAO')));
          Escrever(LinhaAtual, 09, fFrtStrExcel(IfThen(Not fEmptyStr(FieldByName('CTP_DTAPAG').AsString), FormatDateTime('dd/mm/yyyy', FieldByName('CTP_DTAPAG').AsDateTime))));
          Escrever(LinhaAtual, 10, fFrtStrExcel(FormatDateTime('dd/mm/yyyy', FieldByName('CTP_DTAVEN').AsDateTime)));

          fltToPOri := fltToPOri + FieldByName('CTP_VALORI').AsFloat;
          Escrever(LinhaAtual, 11, FloatToStrF(FieldByName('CTP_VALORI').AsFloat, ffNumber, 15, 2));
          Alinhamento(LinhaAtual, 11, Direita);

          {*****************************************}
          {* CÁLCULO DOS TOTAIS (VENCER E VENCIDOS *}
          {*       + O TOTAL DA DIFERENÇA          *}
          {**************************************MO*}
          if (FieldByName('CTP_DTAVEN').AsDateTime < date) then
          begin
            fltToVenc := fltToVenc + FieldByName('CTP_VALORI').AsCurrency + FieldByName('VALDIF').AsCurrency;
          end
          else
          if (FieldByName('CTP_DTAVEN').AsDateTime >= date) then
          begin
            fltToVencer := fltToVencer + FieldByName('CTP_VALORI').AsCurrency + FieldByName('VALDIF').AsCurrency;
          end;

          {*******************}
          {*   TOTAL PAGOS   *}
          {****************MO*}
          if (FieldByName('CTP_DTAPAG').AsDateTime > 0) then
          begin
            fltToPagos := fltToPagos + FieldByName('CTP_VALPAG').AsCurrency;
          end;

          If FieldByName('CTP_VALPAG').AsFloat <> 0 Then
          Begin
            fltToPDif := fltToPDif + (FieldByName('CTP_VALPAG').AsFloat - FieldByName('CTP_VALORI').AsFloat);
            Escrever(LinhaAtual, 12, FloatToStrF(FieldByName('CTP_VALPAG').AsFloat - FieldByName('CTP_VALORI').AsFloat, ffNumber, 15, 2));
          End
          Else
            Escrever(LinhaAtual, 12, '0,00');
          Alinhamento(LinhaAtual, 12, Direita);

          fltToPPag := fltToPPag + FieldByName('CTP_VALPAG').AsFloat;
          Escrever(LinhaAtual, 13, FloatToStrF(FieldByName('CTP_VALPAG').AsFloat, ffNumber, 15, 2));
          Alinhamento(LinhaAtual, 13, Direita);

          ProximaLinha;
          Next;

          {************************************}
          {* INSERE O TOTAL PARCIAL           *}
          {*********************************JB*}
          If Not SameText(strGruFor, FieldByName('CTP_CODFOR').AsString) Or (Eof) Then
          Begin
            Escrever(LinhaAtual, 03, 'Total Parcial:');
            Mesclar('A' + IntToStr(LinhaAtual), 'J' + IntToStr(LinhaAtual));
            Alinhamento(LinhaAtual, 03, Direita);
            Negrito(LinhaAtual, 03, True); // Valores
            Negrito(LinhaAtual, 01, True); // Descrição

            Escrever(LinhaAtual, 11, FloatToStrF(fltToPOri, ffFixed, 12, 2));
            Alinhamento(LinhaAtual, 11, Direita);
            Negrito(LinhaAtual, 11, True);
            Escrever(LinhaAtual, 12, FloatToStrF(fltToPDif, ffFixed, 12, 2));
            Alinhamento(LinhaAtual, 12, Direita);
            Negrito(LinhaAtual, 12, True);
            Escrever(LinhaAtual, 13, FloatToStrF(fltToPPag, ffFixed, 12, 2));
            Alinhamento(LinhaAtual, 13, Direita);
            Negrito(LinhaAtual, 13, True);

            Bordas('A' + IntToStr(LinhaAtual), strUltLet + IntToStr(LinhaAtual), False, False, True, False);

            ProximaLinha;

            fltToGOri := fltToGOri + fltToPOri;
            fltToGDif := fltToGDif + fltToPDif;
            fltToGPag := fltToGPag + fltToPPag;

            fltToPOri := 0;
            fltToPDif := 0;
            fltToPPag := 0;
          End;

        End;

        Escrever(LinhaAtual, 03, 'Total Geral:');
        Mesclar('A' + IntToStr(LinhaAtual), 'J' + IntToStr(LinhaAtual));
        Alinhamento(LinhaAtual, 03, Direita);
        Negrito(LinhaAtual, 03, True); // Valores
        Negrito(LinhaAtual, 01, True); // Descrição

        Escrever(LinhaAtual, 11, FloatToStrF(fltToGOri, ffFixed, 12, 2));
        Alinhamento(LinhaAtual, 11, Direita);
        Negrito(LinhaAtual, 11, True);
        Escrever(LinhaAtual, 12, FloatToStrF(fltToGDif, ffFixed, 12, 2));
        Alinhamento(LinhaAtual, 12, Direita);
        Negrito(LinhaAtual, 12, True);
        Escrever(LinhaAtual, 13, FloatToStrF(fltToGPag, ffFixed, 12, 2));
        Alinhamento(LinhaAtual, 13, Direita);
        Negrito(LinhaAtual, 13, True);

        Bordas('A'+ IntToStr(LinhaAtual), strUltLet + IntToStr(LinhaAtual), False, False, True, False);
        Alinhamento('C'+ IntToStr(LinhaAtual), strUltLet + IntToStr(LinhaAtual), Direita);

        {*******************}
        {* LINHA EM BRANCO *}
        {****************MO*}
        ProximaLinha;
        Escrever(LinhaAtual, 03, '');
        Mesclar('A' + IntToStr(LinhaAtual), 'M' + IntToStr(LinhaAtual));

        {*******************}
        {* TOTAL VENCIDOS  *}
        {****************MO*}
        ProximaLinha;
        Escrever(LinhaAtual, 03, 'Total Vencidos:');
        Mesclar('A' + IntToStr(LinhaAtual), 'J' + IntToStr(LinhaAtual));
        Alinhamento(LinhaAtual, 03, Direita);
        Negrito(LinhaAtual, 03, True);

        Escrever(LinhaAtual, 13, FloatToStrF(fltToVenc, ffFixed, 12, 2));
        Alinhamento(LinhaAtual, 13, Direita);
        Negrito(LinhaAtual, 13, True);

        Bordas('A'+ IntToStr(LinhaAtual), strUltLet + IntToStr(LinhaAtual), False, False, True, False);
        Alinhamento('C'+ IntToStr(LinhaAtual), strUltLet + IntToStr(LinhaAtual), Direita);

        {*******************}
        {* TOTAL A VENCER  *}
        {****************MO*}
        ProximaLinha;
        Escrever(LinhaAtual, 03, 'Total a Vencer:');
        Mesclar('A' + IntToStr(LinhaAtual), 'J' + IntToStr(LinhaAtual));
        Alinhamento(LinhaAtual, 03, Direita);
        Negrito(LinhaAtual, 03, True);

        Escrever(LinhaAtual, 13, FloatToStrF(fltToVencer, ffFixed, 12, 2));
        Alinhamento(LinhaAtual, 13, Direita);
        Negrito(LinhaAtual, 13, True);

        Bordas('A'+ IntToStr(LinhaAtual), strUltLet + IntToStr(LinhaAtual), False, False, True, False);
        Alinhamento('C'+ IntToStr(LinhaAtual), strUltLet + IntToStr(LinhaAtual), Direita);

        {***************}
        {* TOTAL PAGOS *}
        {************MO*}
        ProximaLinha;
        Escrever(LinhaAtual, 03, 'Total Pagos:');
        Mesclar('A' + IntToStr(LinhaAtual), 'J' + IntToStr(LinhaAtual));
        Alinhamento(LinhaAtual, 03, Direita);
        Negrito(LinhaAtual, 03, True);

        Escrever(LinhaAtual, 13, FloatToStrF(fltToPagos, ffFixed, 12, 2));
        Alinhamento(LinhaAtual, 13, Direita);
        Negrito(LinhaAtual, 13, True);

        Bordas('A'+ IntToStr(LinhaAtual), strUltLet + IntToStr(LinhaAtual), False, False, True, False);
        Alinhamento('C'+ IntToStr(LinhaAtual), strUltLet + IntToStr(LinhaAtual), Direita);
      End;

  //    CongelarPaines('A16');
      AutoAjuste;

      If fArquivoAberto Then
      Begin
        FreeAndNil(objExcel);
        Exit;
      End;

      SalvarArquivo;
      FecharArquivo;

    End;

    FreeAndNil(objExcel);
    fMensagem('', 'Arquivo gerado com sucesso!', ['&Ok']);
  Except
    On E: Exception do
    Begin
      pMensagensErro('Ocorreu um erro ao gerar o relatório em Excel. Entre em contato com a Citel!' +
                    #13 + #13 + 'Erro gerado: ' + E.Message, '[frmRelCtpContaCorrente.pGeraExcel]');
    End;
  End;

end;

procedure TfrmRelCtpContaCorrente.edtDestinoExit(Sender: TObject);
begin
  //inherited;

end;

procedure TfrmRelCtpContaCorrente.pAjustaData;
Var
  strSQL   : String;
  dtaDtaVen: TDateTime;
  dtaDtaAnt: TDateTime;
  qryCadFer: TUniQuery;
Begin

  Try

    qryCadFer := fCriaQuery(Nil);

    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   FER_DTAFER ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   CADFER ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   FER_DTAFER = :DTAFER ';

    cdsRelatorio.First;

    While Not cdsRelatorio.Eof Do
    Begin

      dtaDtaVen := cdsRelatorio.fieldbyname('CTP_DTAVEN').AsDateTime;
      dtaDtaAnt := cdsRelatorio.fieldbyname('CTP_DTAVEN').AsDateTime;

      {*********************************************************}
      {* VERIFICA SE O VENCIMENTO EXISTE NA TABELA DE FERIADOS *}
      {******************************************************LU*}
      With qryCadFer Do
      Begin
        SQL.Clear;
        SQL.add(strSQL);
        ParamByName('DTAFER').AsDateTime := dtaDtaVen;
        Open;
      End;

      While (DayOfWeek(dtaDtaVen) In [1,7]) Or //Se é sábado ou domingo ou
            (qryCadFer.RecordCount > 0) Do //Se é feriado
      Begin

        {***********************************************}
        {* TRIBUTOS NÃO PODEM SER PAGOS APÓS O VENCTO, *}
        {* MESMO QUE CAIA EM SAB, DOM OU FERIADO       *}
        {********************************************RN*}
        If cdsRelatorio.FieldByName('CTP_TIPDOC').AsString = '2' Then
          dtaDtaVen := dtaDtaVen - 1
        Else
          dtaDtaVen := dtaDtaVen + 1;

        {*********************************************************}
        {* VERIFICA SE O VENCIMENTO EXISTE NA TABELA DE FERIADOS *}
        {******************************************************LU*}
        With qryCadFer Do
        Begin
          SQL.Clear;
          SQL.add(strSQL);
          ParamByName('DTAFER').AsDateTime := dtaDtaVen;
          Open;
        End;

      End;

      {************************************************}
      {* CASO TENHA SIDO NECESSARIA ALTERACAO NA DATA *}
      {*********************************************LU*}
      If dtaDtaVen <> dtaDtaAnt Then
      Begin
        cdsRelatorio.Edit;
        cdsRelatorio.FieldByName('CTP_DTAVEN').AsDateTime := dtaDtaVen;
        cdsRelatorio.Post;
      End;

      cdsRelatorio.Next;
    End;

    FreeAndNil(qryCadFer);

  Except
    On E : Exception Do
    Begin
      pMensagensErro(E.Message, '[pAjustaData]');
    End;
  End;


End;

procedure TfrmRelCtpContaCorrente.mskCodCtaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*****************************************}
  {* NOVA CONSULTA DE CENTRO DE CUSTO      *}
  {**************************************DP*}
  If fPesqCentroCusto(Self, mskCodCta, edtDesCta, Nil, Key, arrCentroCusto, false) Then
      Self.SelectNext(ActiveControl, True, True);
end;

procedure TfrmRelCtpContaCorrente.mskCodCtaExit(Sender: TObject);
begin
  inherited;
  If Not mskCodCta.ReadOnly Then
    pEdtCodSelectExit(mskCodCta, edtDesCta, arrCentroCusto, fRetNomeConta, Nil, 'do plano de contas');
end;

end.

