unit untRelCtpIncDiarias;

interface

uses
  SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms, 
  Dialogs, StdCtrls, untPaiRelatorio, RLFilters, RLDraftFilter,
  EditFocus, Buttons, ExtCtrls, Mask, MaskEditFocus, StrUtils,
  QColorLabel, Menus, frxDesgn, frxClass, frxDBSet, frxDMPExport, Uni,
  frxExportPDF, frxExportHTML, frxExportXLS, frxExportRTF, untTypesSistema,
  AppEvnts, ComObj, DB, BitBtnLockedIncrem, frxExportCSVTestabilidade,
  untIFuncoes;

type
  TfrmRelCtpIncDiarias = class(TfrmPaiRelatorio)
    Label9: TLabel;
    Label10: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    edtCodFornecedor: TEditFocus;
    lblEmpresa: TLabel;
    edtCodEmpresa: TEditFocus;
    edtDesFornecedor: TEditFocus;
    edtDesEmpresa: TEditFocus;
    Label1: TLabel;
    edtCodEve: TEditFocus;
    edtDesEve: TEditFocus;
    Label2: TLabel;
    mskDtaIniVen: TMaskEditFocus;
    Label3: TLabel;
    mskDtaFinVen: TMaskEditFocus;
    Label4: TLabel;
    Label5: TLabel;
    svdExcel: TSaveDialog;
    gpbBoleto: TGroupBox;
    edtBoleto: TEditFocus;
    gpbIncPrevis: TGroupBox;
    edtIncPrevis: TEditFocus;
    Label6: TLabel;
    mskCodCta: TMaskEditFocus;
    edtDesCta: TEditFocus;
    ckbExiCenCust: TCheckBox;
    gpbTipRel: TGroupBox;
    lbl1: TColorLabel;
    lbl2: TColorLabel;
    edtTipRel: TEditFocus;
    GroupBox1: TGroupBox;
    edtUsoCon: TEditFocus;
    mskCompet: TMaskEditFocus;
    Label7: TLabel;
    gpbContas: TGroupBox;
    ColorLabel3: TColorLabel;
    edtContas: TEditFocus;
    ColorLabel2: TColorLabel;
    ColorLabel4: TColorLabel;
    ColorLabel5: TColorLabel;
    ColorLabel6: TColorLabel;
    ColorLabel7: TColorLabel;
    ColorLabel8: TColorLabel;
    ColorLabel9: TColorLabel;
    ColorLabel10: TColorLabel;
    ColorLabel11: TColorLabel;
    rdgTipVal: TRadioGroup;
    procedure FormShow(Sender: TObject);
    procedure edtCodFornecedorExit(Sender: TObject);
    procedure edtCodFornecedorKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpresaExit(Sender: TObject);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure btnImprimirClick(Sender: TObject);
    procedure edtCodEveExit(Sender: TObject);
    procedure edtCodEveKeyPress(Sender: TObject; var Key: Char);
    procedure pCarregaEventos(Var qryCadEve: TUniQuery);
    procedure edtDestinoExit(Sender: TObject);
    procedure mskCodCtaExit(Sender: TObject);
    procedure mskCodCtaKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    qryRelatorio: TUniQuery;

    procedure pGeraExcel;

    procedure pCriaQryRelatorio;
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  public
    { Public declarations }
  end;

var
  frmRelCtpIncDiarias: TfrmRelCtpIncDiarias;

implementation

uses untQckCtpIncDiarias, untfuncoesFactory, untExcel;

{$R *.dfm}

procedure TfrmRelCtpIncDiarias.FormShow(Sender: TObject);
begin
  pCriaQryRelatorio;

  edtCodEmpresa.Text := VS_strCodEmp;
  edtDesEmpresa.Text := fRetNomeEmpresa;

  mskDtaIni.Text := FormatDateTime('dd/mm/yyyy', VS_Date);
  mskDtaFin.Text := FormatDateTime('dd/mm/yyyy', VS_Date);

  pSetFocus(edtContas);
  inherited;
end;

procedure TfrmRelCtpIncDiarias.edtCodFornecedorExit(Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtCodFornecedor.Text) Then
    edtDesFornecedor.Text := 'TODOS'
  Else
    edtDesFornecedor.Text := fRetNomFornecedor(edtCodFornecedor.Text);

  If fEmptyStr(edtDesFornecedor.Text) And (Not fEmptyStr(edtCodFornecedor.Text))  Then
  Begin
    fMensagem('AVISO','Código do cliente não encontrado.', ['&O K']);
    edtCodFornecedor.Clear;
    pSetFocus(edtCodFornecedor);
  End;
end;

procedure TfrmRelCtpIncDiarias.edtCodFornecedorKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrFornec: TConsultasArray;
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************RV*}
  If fPesqFornecedor(conForSimples, Self, edtCodFornecedor, edtDesFornecedor, Nil, Key, arrFornec) Then
  Begin
    If fValidaCampos(edtCodFornecedor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelCtpIncDiarias.edtCodEmpresaExit(Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtCodEmpresa.Text) Then
    edtDesEmpresa.Text := 'TODOS'
  Else
    edtDesEmpresa.Text := fRetNomeEmpresaSelec(edtCodEmpresa.Text);

  If fEmptyStr(edtDesEmpresa.Text) And (Not fEmptyStr(edtCodEmpresa.Text))  Then
  Begin
    fMensagem('AVISO','Código da empresa não encontrado.', ['&O K']);
    edtCodEmpresa.Clear;
    pSetFocus(edtCodEmpresa);
  End;
end;

procedure TfrmRelCtpIncDiarias.edtCodEmpresaKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpresa, edtDesEmpresa, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmpresa, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;


function TfrmRelCtpIncDiarias.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin
    {************************}
    {* VALIDA DATA CADASTRO *}
    {*********************MO*}
    If (Sender = mskDtaFin) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
      Begin
        fMensagem('', 'O campo Data Final de Cadastro deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) And fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
        Begin
          fMensagem('', 'O campo Data Inicial de Cadastro deve ser preenchido!', ['&Ok']);
          Sender := mskDtaIni;
          Result := False;
        End
        Else
        Begin
          If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) And (StrToDateDef(mskDtaFin.Text, 0) <= 0) Then
          Begin
            fMensagem('', 'A Data Final de Cadastro informada é inválida! Necessário correção.', ['&O k']);
            Result := False;
          End
          Else
          If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
          Begin
            If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
            Begin
              fMensagem('','A Data Inicial de Cadastro deve ser menor que a Data Final de Cadastro!',['&O K']);
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
        fMensagem('', 'A Data Inicial de Cadastro informada é inválida! Necessário correção.', ['&O k']);
        Result := False;
        Sender := mskDtaIni;
      End;
    End;

    {**************************}
    {* VALIDA DATA VENCIMENTO *}
    {***********************MO*}
    If (Sender = mskDtaFinVen) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaFinVen.Text)) And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIniVen.Text))) Then
      Begin
        fMensagem('', 'O campo Data Final de Vencimento deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFinVen.Text))) And fEmptyStr(fTiraCaracEspeciais(mskDtaIniVen.Text)) Then
        Begin
          fMensagem('', 'O campo Data Inicial de Vencimento deve ser preenchido!', ['&Ok']);
          Sender := mskDtaIniVen;
          Result := False;
        End
        Else
        Begin
          If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFinVen.Text))) And (StrToDateDef(mskDtaFinVen.Text, 0) <= 0) Then
          Begin
            fMensagem('', 'A Data Final de Vencimento informada é inválida! Necessário correção.', ['&O k']);
            Result := False;
          End
          Else
          If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFinVen.Text))) And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIniVen.Text))) Then
          Begin
            If StrToDate(mskDtaIniVen.Text) > StrToDate(mskDtaFinVen.Text) Then
            Begin
              fMensagem('','A Data Inicial de Vencimento deve ser menor que a Data Final de Vencimento!',['&O K']);
              Sender := mskDtaIniVen;
              Result := False;
            End;
          End;
        End;
      End;
    End
    Else
    If (Sender = mskDtaIniVen) Then
    Begin
      If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIniVen.Text))) and (StrToDateDef(mskDtaIniVen.Text, 0) <= 0) Then
      Begin
        fMensagem('', 'A Data Inicial de Vencimento informada é inválida! Necessário correção.', ['&O k']);
        Result := False;
        Sender := mskDtaIniVen;
      End;
    End;

    {*************************}
    {* VERIFICA CAMPO CONTAS *}
    {**********************MO*}
    If (Sender = edtContas) Then
    Begin
      If (edtContas.Text <> 'T') And
         (edtContas.Text <> 'Q') And
         (edtContas.Text <> 'A') Then
      Begin
        fMensagem('ATENÇÃO!','O campo Contas deve ser T, A ou Q.',['&O K']);
        Result := False;
      End;
    End;

    If (Sender = edtBoleto) Then
    Begin

    {****************************}
    {* VERIFICA CAMPO DO BOLETO *}
    {*************************AF*}
      If (edtBoleto.Text <> 'T') And (edtBoleto.Text <> 'N') And (edtBoleto.Text <> 'S') Then
      Begin
        fMensagem('ATENÇÃO!','O campo Boleto deve ser T,N ou S.',['&O K']);
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
        fMensagem('ATENÇÃO!','O campo Uso/Consumo deve ser T,N ou S.',['&O K']);
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
      Else If (Pos(edtDestino.Text, 'VIE') <= 0) Then
      Begin
        fMensagem('ATENÇÃO', 'O Destino do Relatório deve ser V, I ou E!', ['&Ok']);
        Result := False;
      End;

    End
    Else
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

    End
    Else If (Sender = edtTipRel) Then
    Begin

      If fEmptyStr(edtTipRel.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'O Tipo do Relatório deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (Pos(edtTipRel.Text, 'SA') <= 0) Then
      Begin
        fMensagem('ATENÇÃO', 'O Tipo do Relatório deve ser S ou A!', ['&Ok']);
        Result := False;
      End;

    End
    Else If (Sender = edtIncPrevis) Then
    Begin

      If fEmptyStr(edtIncPrevis.Text) Then
      Begin
        fMensagem('ATEÇÃO','O Campo Gerar deve ser preenchido!',['&OK']);
        Result := False;
      End
      Else
      If Pos(edtIncPrevis.Text,'T_S_P_') <= 0 Then
      Begin
        fMensagem('ATENÇÃO','O Campo Gerar deve conter somente T, S ou P!',['&OK']);
        Result := False;
      End;

    End
    Else If (Sender = edtCodEmpresa) Then
    Begin
      If Not fEmptyStr(edtCodEmpresa.Text) Then
      Begin
        If Pos(edtCodEmpresa.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
          Result := False;
        End;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmRelCtpIncDiarias.btnImprimirClick(Sender: TObject);
  Var
    strSQL: String;
begin
  {********************************}
  {* VERIFICACAO DAS DATAS, PELO  *}
  {* MENOS UMA DEVE SER ESCOLHIDA *}
  {*****************************MO*}
  If (fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) And fEmptyStr(fTiraCaracEspeciais(mskDtaIniVen.Text))) Or
     (fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) And fEmptyStr(fTiraCaracEspeciais(mskDtaFinVen.Text))) Then
  Begin
    fMensagem('', 'Uma data deve ser selecionada!', ['&OK']);
    pSetFocus(mskDtaIni);
    Exit;
  End;

  pnlInfo.Caption := 'Gerando Relatório...';
  pnlInfo.Repaint;
  If SameText(edtDestino.Text, 'E') Then
  Begin
    btnImprimir.Enabled := False;
    blnImprime := fVerificaCampos;
  End
  Else
    inherited;

  If blnImprime Then
  Begin

    {*******************************************}
    {* INCLUIU VISUALIZACAO DO CENTRO DE CUSTO *}
    {* INCLUIU LEFT OUTER JOIN COM CADCTA      *}
    {****************************************DP*}
    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  P.*,              ';

    If edtTipRel.Text = 'A' Then
    Begin
      strSQL := strSQL + '  D.CTP_CODCTA AS CTP_CTADET, ';
      strSQL := strSQL + '  T.CTA_DESCTA AS CTP_DESCTD, ';
      strSQL := strSQL + '  D.CTP_FATCAL, ';
    End;

    strSQL := strSQL + '  F.FOR_NOMFOR, ';
    strSQL := strSQL + '  P.CTP_CODOPE, ';
    strSQL := strSQL + '  REPLACE(CONCAT(IFNULL(P.CTP_HIST01, ""), " ", IFNULL(P.CTP_HIST02, "")), "<<csq>>", " ") AS CTP_HISCOM, ';
    strSQL := strSQL + '  C.CTA_DESCTA,  ';

    if rdgTipVal.ItemIndex = 0 then
      strSQL := strSQL + '  IF (P.CTP_DTAPAG IS NULL, (P.CTP_VALDUP + IFNULL(P.CTP_JURSUJ, 0) - IFNULL(P.CTP_DESSUJ, 0)), P.CTP_VALPAG) AS VALORI '
    else
      strSQL := strSQL + '  IF (P.CTP_DTAPAG IS NULL, (P.CTP_VALDUP + IFNULL(P.CTP_JURSUJ, 0) - IFNULL(P.CTP_DESSUJ, 0)), P.CTP_VALPAG - IFNULL(CTP_VALJUR,0) + IFNULL(CTP_VALDES,0)) AS VALORI ';

    {// TODOS
    If (edtContas.Text = 'T') Then
    Begin
      strSQL := strSQL + '  IF (P.CTP_DTAPAG IS NULL, (P.CTP_VALDUP + IFNULL(P.CTP_JURSUJ, 0) - IFNULL(P.CTP_DESSUJ, 0)), ';
      strSQL := strSQL + '      P.CTP_VALPAG) AS VALORI ';
    End
    Else
    // QUITADOS
    if  (edtContas.Text = 'Q') Then
    Begin
      strSQL := strSQL + '  (P.CTP_VALPAG) AS VALORI ';
    End
    Else
    Begin
      // ABERTOS
      strSQL := strSQL + ' (P.CTP_VALDUP + (P.CTP_VALDUP - (P.CTP_VALDUP - IFNULL(P.CTP_JURSUJ, 0) + IFNULL(P.CTP_DESSUJ, 0)))) AS VALORI ';
    End;}

    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADPAG P ';
    strSQL := strSQL + '  JOIN CADFOR F ON P.CTP_CODFOR = FOR_CODFOR ';
    strSQL := strSQL + '  LEFT JOIN CADCTA C ON P.CTP_CODCTA = C.CTA_CODCTA ';

    If edtTipRel.Text = 'A' Then
    Begin
      strSQL := strSQL + '  LEFT JOIN CTPDET D ON D.CTP_CODFOR = P.CTP_CODFOR AND D.CTP_NUMDUP = P.CTP_NUMDUP       ';
      strSQL := strSQL + '                    AND D.CTP_PARCEL = P.CTP_PARCEL AND D.CTP_EMPORI = P.CTP_CODEMP       ';
      strSQL := strSQL + '                    AND IF(IFNULL(D.CTP_SERIE_,"")="", TRUE, D.CTP_SERIE_ = P.CTP_SERIE_) ';
      strSQL := strSQL + '  LEFT JOIN CADCTA T ON D.CTP_CODCTA = T.CTA_CODCTA ';
    End;

    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + 'TRUE  ';

    If edtContas.Text = 'A' Then
      strSQL := strSQL + '  AND CTP_DTAPAG IS NULL '
    Else
    If edtContas.Text = 'Q' Then
      strSQL := strSQL + '  AND CTP_DTAPAG IS NOT NULL ';

    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      strSQL := strSQL + '  AND P.CTP_DTACAD BETWEEN :DTAINI AND :DTAFIN ';

    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIniVen.Text)) Then
      strSQL := strSQL + '  AND P.CTP_DTAVEN BETWEEN :DTAINIV AND :DTAFINV ';

    If Not fEmptyStr(edtCodFornecedor.Text) Then
      strSQL := strSQL + '  AND P.CTP_CODFOR = :CODFOR ';

    If Not fEmptyStr(edtCodEmpresa.Text) Then
      strSQL := strSQL + '  AND P.CTP_CODEMP = :CODEMP '
    Else
      strSQL := strSQL + '  AND LOCATE(P.CTP_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';

    If Not fEmptyStr(edtCodEve.Text) Then
      strSQL := strSQL + '  AND P.CTP_CODEVE = :CODEVE ';

    {**************************}
    {* FILTRO POR COMPETÊNCIA *}
    {************************BB}
    if not fEmptyStr(fTiraCaracEspeciais(mskCompet.Text)) then
      strSQL := strSQL + '  AND CTP_COMPET = :COMPET ';

    {******************************}
    {* FILTRO POR CENTRO DE CUSTO *}
    {***************************AA*}
    If (Not fEmptyStr(mskCodCta.Text)) Then
    Begin

      If (RightStr(mskCodCta.Text, 5) = '00000') Then
        strSQL := strSQL + '  AND LEFT(P.CTP_CODCTA, 2) = LEFT(:CODCTA, 2) '
      Else If (RightStr(mskCodCta.Text, 3) = '000') Then
        strSQL := strSQL + '  AND LEFT(P.CTP_CODCTA, 4) = LEFT(:CODCTA, 4) '
      Else
        strSQL := strSQL + '  AND P.CTP_CODCTA = :CODCTA '

    End;

    If (edtBoleto.Text = 'S') Then
      strSQL := strSQL + '  AND P.CTP_VEIOBO = ' + QuotedStr('S')
    Else If (edtBoleto.Text = 'N') Then
      strSQL := strSQL + '  AND P.CTP_VEIOBO = ' + QuotedStr('N');

    If (edtUsoCon.Text <> 'T') Then
      strSQL := strSQL + ' AND CTP_USOCON = ' + QuotedStr(edtUsoCon.Text);

    If (edtIncPrevis.Text = 'S') Then
      strSQL := strSQL + '  AND P.CTP_PREVIS <> "S" '
    Else If (edtIncPrevis.Text = 'P') Then
        strSQL := strSQL + '  AND P.CTP_PREVIS = "S"  ';

    strSQL := strSQL + ' ORDER BY ';
    strSQL := strSQL + '  CTP_DTACAD, CTP_NUMDUP, ';
    strSQL := strSQL + '  CTP_PARCEL, CTP_CODEMP, CTP_SEQCON  ';

    With qryRelatorio Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
        ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);
      End;

      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIniVen.Text)) Then
      Begin
        ParamByName('DTAINIV').AsDate := StrToDate(mskDtaIniVen.Text);
        ParamByName('DTAFINV').AsDate := StrToDate(mskDtaFinVen.Text);
      End;

      If Not fEmptyStr(edtCodFornecedor.Text) Then
        ParamByName('CODFOR').AsString := edtCodFornecedor.Text;

      If Not fEmptyStr(edtCodEmpresa.Text) Then
        ParamByName('CODEMP').AsString := edtCodEmpresa.Text;

      If Not fEmptyStr(edtCodEve.Text) Then
        ParamByName('CODEVE').AsString := edtCodEve.Text;

      If Not fEmptyStr(fTiraCaracEspeciais(mskCompet.Text)) then
        ParamByName('COMPET').AsString := mskCompet.Text;

      If (Not fEmptyStr(mskCodCta.Text)) Then
        ParamByName('CODCTA').AsString := mskCodCta.Text;

      Open;

      {**********************************}
      {* APLICA A MASCARA NO CTP_CODCTA *}
      {*******************************DP*}
      TStringField(FieldByName('CTP_CODCTA')).EditMask := '99.99.999;0;_';

      If edtTipRel.Text = 'A' Then
        TStringField(FieldByName('CTP_CTADET')).EditMask := '99.99.999;0;_';
    End;

    If Not qryRelatorio.IsEmpty Then
    Begin

      If edtDestino.Text = 'E' Then
        pGeraExcel
      Else
      Begin

        Try
          pCriarFormularios(TfrmQckCtpIncDiarias,frmQckCtpIncDiarias);
          frmQckCtpIncDiarias.dtsRelatorio.DataSet := qryRelatorio;

          If edtTipRel.Text = 'A' Then
          Begin
            If (edtContas.Text = 'T') Then
            Begin
              If strTipImp = 'M' then
                frmQckCtpIncDiarias.rllNomeRelatorio.Caption := 'RELATORIO DE INCLUSOES DIARIAS DE CONTAS A PAGAR - ANALITICO - TODOS'
              Else
                frmQckCtpIncDiarias.rllNomeRelatorio.Caption := 'RELATÓRIO DE INCLUSÕES DIÁRIAS DE CONTAS A PAGAR - ANALÍTICO - TODOS';
            End
            Else
            if  (edtContas.Text = 'Q') Then
            Begin
              frmQckCtpIncDiarias.RLLValor.Caption := 'VAL. PAGO';
              If strTipImp = 'M' then
                frmQckCtpIncDiarias.rllNomeRelatorio.Caption := 'RELATORIO DE INCLUSOES DIARIAS DE CONTAS A PAGAR - ANALITICO - QUITADOS'
              Else
                frmQckCtpIncDiarias.rllNomeRelatorio.Caption := 'RELATÓRIO DE INCLUSÕES DIÁRIAS DE CONTAS A PAGAR - ANALÍTICO - QUITADOS';
            End
            Else
            Begin
              If strTipImp = 'M' then
                frmQckCtpIncDiarias.rllNomeRelatorio.Caption := 'RELATORIO DE INCLUSOES DIARIAS DE CONTAS A PAGAR - ANALITICO - ABERTOS'
              Else
                frmQckCtpIncDiarias.rllNomeRelatorio.Caption := 'RELATÓRIO DE INCLUSÕES DIÁRIAS DE CONTAS A PAGAR - ANALÍTICO - ABERTOS';
            End;
          End
          Else
          Begin
            If (edtContas.Text = 'T') Then
            Begin
              if strTipImp = 'M' then
                frmQckCtpIncDiarias.rllNomeRelatorio.Caption := 'RELATORIO DE INCLUSOES DIARIAS DE CONTAS A PAGAR - SINTETICO - TODOS '
              Else
                frmQckCtpIncDiarias.rllNomeRelatorio.Caption := 'RELATÓRIO DE INCLUSÕES DIÁRIAS DE CONTAS A PAGAR - SINTÉTICO - TODOS ';
            End
            Else
            if  (edtContas.Text = 'Q') Then
            Begin
              frmQckCtpIncDiarias.RLLValor.Caption := 'VAL. PAGO';
              if strTipImp = 'M' then
                frmQckCtpIncDiarias.rllNomeRelatorio.Caption := 'RELATORIO DE INCLUSOES DIARIAS DE CONTAS A PAGAR - SINTETICO - QUITADOS '
              Else
                frmQckCtpIncDiarias.rllNomeRelatorio.Caption := 'RELATÓRIO DE INCLUSÕES DIÁRIAS DE CONTAS A PAGAR - SINTÉTICO - QUITADOS ';
            End
            Else
            Begin
              if strTipImp = 'M' then
                frmQckCtpIncDiarias.rllNomeRelatorio.Caption := 'RELATORIO DE INCLUSOES DIARIAS DE CONTAS A PAGAR - SINTETICO - ABERTOS '
              Else
                frmQckCtpIncDiarias.rllNomeRelatorio.Caption := 'RELATÓRIO DE INCLUSÕES DIÁRIAS DE CONTAS A PAGAR - SINTÉTICO - ABERTOS ';
            End;
          End;

          If strTipImp = 'M' Then
            frmQckCtpIncDiarias.qckPagina.DefaultFilter := rldFiltro
          Else
            frmQckCtpIncDiarias.qckPagina.DefaultFilter := Nil;

          If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
          Begin
            if strTipImp = 'M' then
              frmQckCtpIncDiarias.strOrdem := 'REFERENTE AO PERIODO DE ' + FormatDateTime('dd/MM/yyyy', StrToDate(mskDtaIni.Text))  + ' A ' + FormatDateTime('dd/MM/yyyy', StrToDate(mskDtaFin.Text))
            Else
              frmQckCtpIncDiarias.strOrdem := 'REFERENTE AO PERÍODO DE ' + FormatDateTime('dd/MM/yyyy', StrToDate(mskDtaIni.Text))  + ' A ' + FormatDateTime('dd/MM/yyyy', StrToDate(mskDtaFin.Text));
          End
          Else
          Begin
            if strTipImp = 'M' then
              frmQckCtpIncDiarias.strOrdem := 'REFERENTE AO PERIODO GERAL'
            Else
              frmQckCtpIncDiarias.strOrdem := 'REFERENTE AO PERÍODO GERAL';
          End;

          If edtCodFornecedor.Text = '' Then
            frmQckCtpIncDiarias.rllFornecedor.Caption := 'FORNECEDOR: TODOS'
          Else
            frmQckCtpIncDiarias.rllFornecedor.Caption := 'FORNECEDOR: ' + edtCodFornecedor.Text + '-' + edtDesFornecedor.Text;

          If edtCodEmpresa.Text = '' Then
            frmQckCtpIncDiarias.rllEmpresa.Caption := 'EMPRESA: TODAS'
          Else
            frmQckCtpIncDiarias.rllEmpresa.Caption := 'EMPRESA: ' + edtCodEmpresa.Text + '-' + edtDesEmpresa.Text;

          If edtCodEve.Text = '' Then
            frmQckCtpIncDiarias.rllEventos.Caption := 'CENTRO DE CUSTOS: TODOS'
          Else
            frmQckCtpIncDiarias.rllEventos.Caption := 'CENTRO DE CUSTOS: ' + edtCodEve.Text + ' - ' + edtDesEve.Text;

          If (fEmptyStr(mskCodCta.Text)) Then
            frmQckCtpIncDiarias.rllCodCta.Caption := 'PLANO DE CONTAS: TODOS '
          Else
            frmQckCtpIncDiarias.rllCodCta.Caption := 'PLANO DE CONTAS: ' + mskCodCta.Text + ' - ' + edtDesCta.Text;

          If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIniVen.Text)) Then
            frmQckCtpIncDiarias.rllVencimento.Caption := 'VENCIMENTO: ' + FormatDateTime('dd/MM/yyyy', StrToDate(mskDtaIniVen.Text))  + ' A ' + FormatDateTime('dd/MM/yyyy', StrToDate(mskDtaFinVen.Text))
          Else
            frmQckCtpIncDiarias.rllVencimento.Caption := '';

          If edtTipRel.Text = 'A' Then
          Begin
            If strTipImp = 'M' then
              frmQckCtpIncDiarias.rllTipRelatorio.Caption := 'TIPO: ANALITICO (COM REGISTROS DE DESMEMBRAMENTO)'
            Else
              frmQckCtpIncDiarias.rllTipRelatorio.Caption := 'TIPO: ANALÍTICO (COM REGISTROS DE DESMEMBRAMENTO)';
          End
          Else
          Begin
            If strTipImp = 'M' then
              frmQckCtpIncDiarias.rllTipRelatorio.Caption := 'TIPO: SINTETICO (SOMENTE REGISTRO DO CONTAS A PAGAR)'
            Else
              frmQckCtpIncDiarias.rllTipRelatorio.Caption := 'TIPO: SINTÉTICO (SOMENTE REGISTRO DO CONTAS A PAGAR)';
          End;

          If (edtIncPrevis.Text = 'S') Then
          Begin
            If strTipImp = 'M' then
              frmQckCtpIncDiarias.rllIncPrevis.Caption := 'INCLUIDO PREVISAO: NAO'
            Else
              frmQckCtpIncDiarias.rllIncPrevis.Caption := 'INCLUÍDO PREVISÃO: NÃO';
          End
          Else
          If (edtIncPrevis.Text = 'P') Then
          Begin
            If strTipImp = 'M' then
              frmQckCtpIncDiarias.rllIncPrevis.Caption := 'APENAS PREVISAO'
            Else
              frmQckCtpIncDiarias.rllIncPrevis.Caption := 'APENAS PREVISÃO';
          End
          Else
          If (edtIncPrevis.Text = 'T') Then
          Begin
            If strTipImp = 'M' then
              frmQckCtpIncDiarias.rllIncPrevis.Caption := 'INCLUIDO PREVISAO: SIM'
            Else
              frmQckCtpIncDiarias.rllIncPrevis.Caption := 'INCLUÍDO PREVISÃO: SIM';
          End;

          If edtBoleto.Text = 'S' Then
            frmQckCtpIncDiarias.rllBoleto.Caption := 'VEIO BOLETO?: SIM'
          Else
          If edtBoleto.Text = 'N' Then
          Begin
            If strTipImp = 'M' then
              frmQckCtpIncDiarias.rllBoleto.Caption := 'VEIO BOLETO?: NAO'
            Else
              frmQckCtpIncDiarias.rllBoleto.Caption := 'VEIO BOLETO?: NÃO';
          End
          Else
            frmQckCtpIncDiarias.rllBoleto.Caption := 'VEIO BOLETO?: TODOS';

          If edtUsoCon.Text <> 'T' Then
          Begin
            If strTipImp = 'M' then
              frmQckCtpIncDiarias.rllUsoCon.Caption := 'USO/CONSUMO?: ' + ifthen(edtUsoCon.Text = 'S', 'SIM', 'NAO')
            Else
              frmQckCtpIncDiarias.rllUsoCon.Caption := 'USO/CONSUMO?: ' + ifthen(edtUsoCon.Text = 'S', 'SIM', 'NÃO');
          End
          Else
            frmQckCtpIncDiarias.rllUsoCon.Caption := 'USO/CONSUMO?: TODOS';

          if strTipImp = 'M' then
            frmQckCtpIncDiarias.RllTitHistorico.Caption := 'HISTORICO'
          Else
            frmQckCtpIncDiarias.RllTitHistorico.Caption := 'HISTÓRICO';


          frmQckCtpIncDiarias.rlbGrupo.DataFields      := 'CTP_DTACAD';
          frmQckCtpIncDiarias.rlbGrupoDet.DataFields   := 'CTP_CODFOR;CTP_NUMDUP;CTP_PARCEL;CTP_SERIE_;CTP_SEQCON';

          {*************}
          {* SINTÉTICO *}
          {**********MO*}
          If edtTipRel.Text = 'S' Then
          Begin
            frmQckCtpIncDiarias.rlbGrupo.Visible     := True;
            frmQckCtpIncDiarias.rlbGrupoDet.Visible  := False;
            frmQckCtpIncDiarias.rlbTituloDet.Visible := False;

            {*******************************}
            {* EXIBICAO DO CENTRO DE CUSTO *}
            {*  DE ACORDO COM O CHECKBOX   *}
            {****************************MO*}
            If ckbExiCenCust.Checked Then
            Begin
              frmQckCtpIncDiarias.RlbDesCta.Visible    := True;
              frmQckCtpIncDiarias.RlbDesCta.Left       := 217;
              frmQckCtpIncDiarias.rlbDesCta.Width      := 98;
              frmQckCtpIncDiarias.RLTitFornecedor.Left := 320;
              frmQckCtpIncDiarias.RLbCodFor.Left       := 320;
              frmQckCtpIncDiarias.RLbCodFor.Width      := 130;
            End
            Else
            Begin
              frmQckCtpIncDiarias.rlbDesCta.Visible    := False;
              frmQckCtpIncDiarias.RLTitFornecedor.Left := 217;
              frmQckCtpIncDiarias.RLbCodFor.Left       := 217;
              frmQckCtpIncDiarias.RLbCodFor.Width      := 230;
            End;
          End
          Else
          Begin

            {*************}
            {* ANALÍTICO *}
            {**********MO*}
            frmQckCtpIncDiarias.rlbGrupo.Visible     := False;
            frmQckCtpIncDiarias.rlbGrupoDet.Visible  := True;
            frmQckCtpIncDiarias.rlbTituloDet.Visible := True;

            {*******************************}
            {* EXIBICAO DO CENTRO DE CUSTO *}
            {*  DE ACORDO COM O CHECKBOX   *}
            {****************************MO*}
            If ckbExiCenCust.Checked Then
            Begin
              frmQckCtpIncDiarias.RlbDesCtaDetalhe.Visible := True;
              frmQckCtpIncDiarias.RlbDesCtaDetalhe.Left    := 217;
              frmQckCtpIncDiarias.rlbDesCtaDetalhe.Width   := 98;
              frmQckCtpIncDiarias.RLTitFornecedor.Left     := 320;
              frmQckCtpIncDiarias.RLbCodForDet.Left        := 320;
              frmQckCtpIncDiarias.RLbCodForDet.Width       := 130;
            End
            Else
            Begin
              frmQckCtpIncDiarias.RlbDesCtaDetalhe.Visible := False;
              frmQckCtpIncDiarias.rlbDesDet.Visible        := False;
              frmQckCtpIncDiarias.RLTitFornecedor.Left     := 217;
              frmQckCtpIncDiarias.RLbCodForDet.Left        := 217;
              frmQckCtpIncDiarias.RLbCodForDet.Width       := 230;
            End;
          End;

          If edtDestino.Text = 'V' Then
            frmQckCtpIncDiarias.qckPagina.PreviewModal
          Else
            frmQckCtpIncDiarias.qckPagina.Print;
        Except
          On E: Exception Do
          Begin
            pMensagensErro(E.Message, '['+Self.Name+' -> (Ocorreu um erro durante a Impressão)]');
          End;
        End;
        pFreeAndNil(frmQckCtpIncDiarias);
      End;
    End
    Else
    Begin
      pTabelaVazia;
    End;
  End;

  btnImprimir.Enabled := True;
  pnlInfo.Caption := '';
end;

procedure TfrmRelCtpIncDiarias.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(mskDtaIni);
end;

procedure TfrmRelCtpIncDiarias.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryRelatorio);
end;

procedure TfrmRelCtpIncDiarias.edtCodEveExit(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtCodEve.Text) Then
    edtDesEve.Text := 'TODOS'
  Else
    edtDesEve.Text := fRetNomEvento(edtCodEve.Text);

  If fEmptyStr(edtDesEve.Text) And (Not fEmptyStr(edtCodEve.Text)) Then
  Begin
    fMensagem('AVISO','Código do Centro de Custos não encontrado',['&O K']);
    edtCodEve.Clear;
    pSetFocus(edtCodEve);
  End;
  
end;

procedure TfrmRelCtpIncDiarias.edtCodEveKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEvento: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EVENTOS    *}
  {****************************RV*}
  If fPesqEventos(Self, edtCodEve, edtDesEve, Nil, Key, arrEvento) Then
  Begin
    If fValidaCampos(edtCodEve, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelCtpIncDiarias.pCarregaEventos(Var qryCadEve: TUniQuery);
begin

  If Not (fEmptyStr(edtCodEve.Text)) Then
     edtDesEve.Text := qryCadEve.FieldByName('EVE_DESEVE').AsString
  Else
    edtDesEve.Text := '';

end;

procedure TfrmRelCtpIncDiarias.pCriaQryRelatorio;
begin
  qryRelatorio:= fCriaQuery(Self);
  frxRelatorio.DataSet := qryRelatorio;

end;

procedure TfrmRelCtpIncDiarias.pGeraExcel;
  Var
    objExcel: TExcel;
    strDia  : String;
    strAInc : String;
    blnProx : Boolean;

    fltTotPar: Double;
    fltTotGer: Double;
    fltValAtu: Double;
begin

  blnProx := True;

  fltTotPar := 0;
  fltTotGer := 0;

  {*******************************************}
  {* CRIA UM OBJETO DO TIPO "EXCEL" E TORNA  *}
  {* A APLICAÇÃO INVISÍVEL                   *}
  {****************************************LU*}
  objExcel := TExcel.fCriarExcel(Self);

  If Not objExcel.CriarArquivo Then
  Begin
    FreeAndNil(objExcel);
    Exit;
  End;

  With objExcel Do
  Begin
    LinhaAtual := 01;

    {********************************}
    {* EMPRESA PADRAO DO SISTEMA    *}
    {*****************************LU*}
    Escrever(ProximaLInha, 01, fRetNomeEmpresaSelec(VS_strCodEmp));

    {*******************************************}
    {* TITULO DO RELATORIO                     *}
    {****************************************LU*}
    If edtTipRel.Text = 'A' Then
    Begin
      If (edtContas.Text = 'T') Then
      Begin
        Escrever(ProximaLinha, 01, 'RELATÓRIO DE INCLUSÕES DIÁRIAS DE CONTAS A PAGAR - ANALÍTICO - TODOS');
      End
      Else
      if  (edtContas.Text = 'Q') Then
      Begin
        Escrever(ProximaLinha, 01, 'RELATÓRIO DE INCLUSÕES DIÁRIAS DE CONTAS A PAGAR - ANALÍTICO - QUITADOS');
      End
      Else
      Begin
      Escrever(ProximaLinha, 01, 'RELATÓRIO DE INCLUSÕES DIÁRIAS DE CONTAS A PAGAR - ANALÍTICO - ABERTOS');
      End;
    End
    Else
    Begin
      If (edtContas.Text = 'T') Then
      Begin
        Escrever(ProximaLinha, 01, 'RELATÓRIO DE INCLUSÕES DIÁRIAS DE CONTAS A PAGAR - SINTÉTICO - TODOS');
      End
      Else
      if  (edtContas.Text = 'Q') Then
      Begin
        Escrever(ProximaLinha, 01, 'RELATÓRIO DE INCLUSÕES DIÁRIAS DE CONTAS A PAGAR - SINTÉTICO - QUITADOS');
      End
      Else
      Begin
      Escrever(ProximaLinha, 01, 'RELATÓRIO DE INCLUSÕES DIÁRIAS DE CONTAS A PAGAR - SINTÉTICO - ABERTOS');
      End;
    End;

    ProximaLinha;

    {*******************************************}
    {* OUTROS DADOS DO RELATÓRIO               *}
    {****************************************LU*}

    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Escrever(ProximaLinha, 01, 'REFERENTE AO PERÍODO DE ' + FormatDateTime('dd/MM/yyyy', StrToDate(mskDtaIni.Text))  + ' A ' + FormatDateTime('dd/MM/yyyy', StrToDate(mskDtaFin.Text)))
    Else
      Escrever(ProximaLinha, 01, 'REFERENTE AO PERÍODO GERAL');

    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIniVen.Text)) Then
      Escrever(ProximaLinha, 01, 'VENCIMENTO: ' + FormatDateTime('dd/MM/yyyy', StrToDate(mskDtaIniVen.Text))  + ' A ' + FormatDateTime('dd/MM/yyyy', StrToDate(mskDtaFinVen.Text)))
    Else
      Escrever(ProximaLinha, 01, 'VENCIMENTO GERAL');

    Escrever(ProximaLinha, 01, 'EMISSÃO: ' + FormatDateTime('dd/mm/yyyy hh:mm:ss', fNow()));

    If edtCodFornecedor.Text = '' Then
      Escrever(ProximaLinha, 01, 'FORNECEDOR: TODOS')
    Else
      Escrever(ProximaLinha, 01, 'FORNECEDOR: ' + edtCodFornecedor.Text + ' - ' + edtDesFornecedor.Text);

    If edtCodEve.Text = '' Then
      Escrever(ProximaLinha, 01, 'CENTRO DE CUSTOS: TODOS')
    Else
      Escrever(ProximaLinha, 01, 'CENTRO DE CUSTOS: ' + edtCodEve.Text + ' - ' + edtDesEve.Text);

    If (edtIncPrevis.Text = 'T') Then
      Escrever(ProximaLinha, 01, 'PREVISÃO: TODOS ')
    Else
    If (edtIncPrevis.Text = 'S') Then
      Escrever(ProximaLinha, 01, 'PREVISÃO: SEM PREVISÃO ')
    Else
      Escrever(ProximaLinha, 01, 'PREVISÃO: APENAS PREVISÕES ');

    If (fEmptyStr(mskCodCta.Text)) Then
      Escrever(ProximaLinha, 01, 'PLANO DE CONTAS: TODOS ')
    Else
      Escrever(ProximaLinha, 01, 'PLANO DE CONTAS: ' + mskCodCta.Text + ' - ' + edtDesCta.Text);

    If (edtTipRel.Text = 'S') Then
      Escrever(ProximaLinha, 01, 'TIPO: SINTÉTICO, SOMENTE REGISTRO DO CONTAS A PAGAR ')
    Else
      Escrever(ProximaLinha, 01, 'TIPO: ANALÍTICO, COM OS REGISTROS DO DESMEMBRAMENTO ');

    If edtCodEmpresa.Text = '' Then
      Escrever(ProximaLinha, 01, 'EMPRESA: TODAS')
    Else
      Escrever(ProximaLinha, 01, 'EMPRESA: ' + edtCodEmpresa.Text + ' - ' + edtDesEmpresa.Text);

    If rdgTipVal.ItemIndex = 0 Then
      Escrever(ProximaLinha, 01, 'CONSIDERAR VALOR: PAGO')
    Else
      Escrever(ProximaLinha, 01, 'CONSIDERAR VALOR: DA DUPLICATA');

    Escrever(ProximaLinha, 01, 'VEIO BOLETO?: ' + ifthen(edtBoleto.Text = 'T', 'TODOS', ifthen(edtBoleto.Text = 'S', 'SIM', 'NÃO')));
    Escrever(ProximaLinha, 01, 'USO/CONSUMO: ' + ifthen(edtUsoCon.Text = 'T', 'TODOS', ifthen(edtUsoCon.Text = 'S', 'SIM', 'NÃO')));

    Mesclar('A1','K1');
    Mesclar('A2','K2');
    Mesclar('A3','K3');
    Alinhamento('A1','K3', Centro);
    Negrito('A1','K3', True);

    Mesclar('A4','K4');
    Mesclar('A5','K5');
    Mesclar('A6','K6');
    Mesclar('A7','K7');
    Mesclar('A8','K8');
    Mesclar('A9','K9');
    Mesclar('A10','K10');
    Mesclar('A11','K11');
    Mesclar('A12','K12');
    Mesclar('A13','K13');
    Mesclar('A14','K14');
    Mesclar('A15','K15');

    Alinhamento('A4', 'K15', Centro);
    Negrito('A4', 'K15', True);

    {*************************************}
    {* COLORI O FUNDO DA CELULA P/ CINZA *}
    {**********************************LU*}
    CorFundo('A2','K2', Cinza);
    CorFundo('A3','K3', Cinza);
    CorFundo('A16','K16', Cinza);

    ProximaLinha;

    {*******************************************}
    {* COLUNAS                                 *}
    {****************************************LU*}
    Escrever(LinhaAtual, 01, 'CADASTRO');
    Escrever(LinhaAtual, 02, 'DUPLICATA');
    Escrever(LinhaAtual, 03, 'LOJA');
    Escrever(LinhaAtual, 04, 'CONTA');
    Escrever(LinhaAtual, 05, 'FORNECEDOR');
    Escrever(LinhaAtual, 06, 'BOLETO');
    Escrever(LinhaAtual, 07, 'CHEQUE');
    Escrever(LinhaAtual, 08, 'OPERADOR');
    Escrever(LinhaAtual, 09, 'HISTÓRICO');
    Escrever(LinhaAtual, 10, 'VENCIMENTO');

    If edtContas.Text = 'Q' Then
      Escrever(LinhaAtual, 11, 'VALOR PAGO')
    Else
      Escrever(LinhaAtual, 11, 'VALOR');

    {*******************************************}
    {* COLOCA NEGRITO NAS COLUNAS              *}
    {****************************************LU*}
    Negrito('A' + IntToStr(LinhaAtual), 'K' + IntToStr(LinhaAtual), True);

    {********************************}
    {* INSERE BORDAS NA CELULA      *}
    {*****************************LU*}
    Bordas('A1', 'K' + IntToStr(LinhaAtual));

    ProximaLinha;

    If edtTipRel.Text = 'A' Then
    Begin
      Mesclar('A' + IntToStr(LinhaAtual),'C' + IntToStr(LinhaAtual));
      Mesclar('D' + IntToStr(LinhaAtual),'F' + IntToStr(LinhaAtual));
      Mesclar('G' + IntToStr(LinhaAtual),'K' + IntToStr(LinhaAtual));
      Escrever(LinhaAtual, 04, 'DESMEMBRAMENTO');
      CorFundo('A' + IntToStr(LinhaAtual),'K' + IntToStr(LinhaAtual), Cinza);
      Bordas('A' + IntToStr(LinhaAtual),'K' + IntToStr(LinhaAtual));
      Negrito(LinhaAtual, 04, True);

      ProximaLinha;
    End;

    With qryRelatorio Do
    Begin
      First;

      strDia := FieldByName('CTP_DTACAD').AsString;

      While (Not Eof) Do
      Begin
        Application.ProcessMessages;

        Escrever(LinhaAtual, 01, '''' + FormatDateTime('dd/MM/yyyy', FieldByName('CTP_DTACAD').AsDateTime));
        Escrever(LinhaAtual, 02, '''' + FieldByName('CTP_NUMDUP').AsString + FieldByName('CTP_PARCEL').AsString);
        Escrever(LinhaAtual, 03, '''' + FieldByName('CTP_CODEMP').AsString);

        If ckbExiCenCust.Checked Then
          Escrever(LinhaAtual, 04, '''' + FieldByName('CTP_CODCTA').AsString + ' - ' + FieldByName('CTA_DESCTA').AsString)
        Else
          Escrever(LinhaAtual, 04, '''' + FieldByName('CTP_CODCTA').AsString);

        Escrever(LinhaAtual, 05, '''' + FieldByName('CTP_CODFOR').AsString + '-' + FieldByName('FOR_NOMFOR').AsString);
        Escrever(LinhaAtual, 06, fFrtStrExcel(ifthen(FieldByName('CTP_VEIOBO').AsString = 'S', 'SIM', 'NÃO')));
        Escrever(LinhaAtual, 07, fFrtStrExcel(ifthen(FieldByName('CTP_USACHQ').AsString = 'S', 'SIM', 'NÃO')));
        Escrever(LinhaAtual, 08, FieldByName('CTP_CODOPE').AsString);
        Escrever(LinhaAtual, 09, FieldByName('CTP_HISCOM').AsString);
        Escrever(LinhaAtual, 10, '''' + FormatDateTime('dd/MM/yyyy', FieldByName('CTP_DTAVEN').AsDateTime));
        fltValAtu := FieldByName('VALORI').AsCurrency;
        Escrever(LinhaAtual, 11, FloatToStrF(fltValAtu, ffFixed, 12, 2));

        Alinhamento(LinhaAtual, 11, Direita);
        Bordas('A'+ IntToStr(LinhaAtual) , 'K'+ IntToStr(LinhaAtual));

        fltTotPar := fltTotPar + fltValAtu;
        ProximaLinha;

        If (edtTipRel.Text = 'A') And (Not FieldByName('CTP_CTADET').IsNull) Then
        Begin
          strAInc := FieldByName('AUTOINCREM').AsString;

          While (strAInc = FieldByName('AUTOINCREM').AsString) and (Not Eof) Do
          Begin
            If ckbExiCenCust.Checked Then
              Escrever(LinhaAtual, 04, '''' + FieldByName('CTP_CTADET').AsString + ' - ' + FieldByName('CTP_DESCTD').AsString)
            Else
              Escrever(LinhaAtual, 04, '''' + FieldByName('CTP_CTADET').AsString);

            Escrever(LinhaAtual, 05, FloatToStrF(FieldByName('VALORI').AsFloat *
                                     FieldByName('CTP_FATCAL').AsFloat, ffFixed, 12, 2));
            Mesclar('A'+ IntToStr(LinhaAtual) , 'C' + IntToStr(LinhaAtual));
            Mesclar('G'+ IntToStr(LinhaAtual) , 'K' + IntToStr(LinhaAtual));
            Bordas('A'+ IntToStr(LinhaAtual) , 'K' + IntToStr(LinhaAtual));
            Alinhamento('E' + IntToStr(LinhaAtual), 'E' + IntToStr(LinhaAtual), Direita);

            ProximaLinha;
            Next;
            blnProx := False;
          End;
        End;

        If Not blnProx Then
          blnProx := True
        Else Next;

        If edtTipRel.Text = 'S' Then
        Begin

          If ((strDia <> FieldByName('CTP_DTACAD').AsString) Or (Eof)) Then
          Begin
            Escrever(LinhaAtual, 09, 'Total Parcial do Dia:');
            Escrever(LinhaAtual, 10, '''' + FormatDateTime('dd/MM/yyyy', strToDate(strDia)));
            Escrever(LinhaAtual, 11, FloatToStrF(fltTotPar, ffFixed, 12, 2));

            Mesclar('A'+ IntToStr(LinhaAtual) , 'I' + IntToStr(LinhaAtual));
            Negrito('A'+ IntToStr(LinhaAtual) , 'K' + IntToStr(LinhaAtual), True);
            Bordas('A'+ IntToStr(LinhaAtual) , 'K' + IntToStr(LinhaAtual));
            Alinhamento('A' + IntToStr(LinhaAtual), 'I' + IntToStr(LinhaAtual), Direita);
            Alinhamento('I' + IntToStr(LinhaAtual), 'K' + IntToStr(LinhaAtual), Direita);

            strDia := FieldByName('CTP_DTACAD').AsString;

            fltTotGer := fltTotGer + fltTotPar;
            fltTotPar := 0;

            ProximaLinha;
          End;
        End
        Else
          fltTotGer := fltTotPar;

      End;

      Escrever(LinhaAtual, 10, 'Total Geral:');
      Escrever(LinhaAtual, 11, FloatToStrF(fltTotGer, ffFixed, 12, 2));
      Mesclar('A'+ IntToStr(LinhaAtual) , 'J' + IntToStr(LinhaAtual));
      Bordas('A'+ IntToStr(LinhaAtual) , 'K' + IntToStr(LinhaAtual));
      Alinhamento('A'+ IntToStr(LinhaAtual) , 'K' + IntToStr(LinhaAtual), Direita);
      Negrito('A'+ IntToStr(LinhaAtual) , 'K' + IntToStr(LinhaAtual), True);

    End;

    CongelarPaines('A17');
    AutoAjuste;
    SalvarArquivo;
    FecharArquivo;
  End;
  FreeAndNil(objExcel);

  fMensagem('', 'Arquivo gerado com sucesso!', ['&Ok']);
End;

procedure TfrmRelCtpIncDiarias.edtDestinoExit(Sender: TObject);
begin
//  inherited;
end;

procedure TfrmRelCtpIncDiarias.mskCodCtaExit(Sender: TObject);
begin
  inherited;

  {******************************}
  {* FILTRO POR CENTRO DE CUSTO *}
  {***************************AA*}
  If (fEmptyStr(mskCodCta.Text)) Then
  Begin
    edtDesCta.Text := 'TODOS';
  End
  Else
  Begin
    edtDesCta.Text := fRetNomeConta(mskCodCta.Text);
    If (fEmptyStr(edtDesCta.Text)) Then
      pSetFocus(mskCodCta);
  End;
end;

procedure TfrmRelCtpIncDiarias.mskCodCtaKeyPress(Sender: TObject;
  var Key: Char);

Var
  arrCentroCusto : TConsultasArray;
begin
  inherited;
  {*****************************************}
  {* NOVA CONSULTA DE CENTRO DE CUSTO      *}
  {**************************************DP*}
  If fPesqCentroCusto(Self, mskCodCta, edtDesCta, Nil, Key, arrCentroCusto) Then
      Self.SelectNext(ActiveControl, True, True);
end;

end.

