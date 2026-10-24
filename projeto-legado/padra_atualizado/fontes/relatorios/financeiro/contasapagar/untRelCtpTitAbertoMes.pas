unit untRelCtpTitAbertoMes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiRelatorio, RLFilters, RLDraftFilter, Menus, StdCtrls, Uni,
  EditFocus, QColorLabel, Buttons, ExtCtrls, Mask, MaskEditFocus, strUtils, DateUtils,
  frxDesgn, frxClass, frxDBSet, frxDMPExport, frxExportPDF, frxExportHTML,
  frxExportXLS, frxExportRTF, AppEvnts, ComObj, BitBtnLockedIncrem, untTypesSistema,
  frxExportCSVTestabilidade, untConstantes, untIFuncoes;

type
  TfrmRelCtpTitAbertoMes = class(TfrmPaiRelatorio)
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label12: TLabel;
    lblEmpresa: TLabel;
    Label1: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    edtCodFornecedor: TEditFocus;
    edtCodEmpresa: TEditFocus;
    edtDesFornecedor: TEditFocus;
    edtDesEmpresa: TEditFocus;
    edtCodEve: TEditFocus;
    edtDesEve: TEditFocus;
    gpbBoleto: TGroupBox;
    ColorLabel2: TColorLabel;
    edtBoleto: TEditFocus;
    Label2: TLabel;
    mskCodCta: TMaskEditFocus;
    edtDesCta: TEditFocus;
    svdExcel: TSaveDialog;
    mskCompet: TMaskEditFocus;
    Label3: TLabel;
    procedure FormShow(Sender: TObject);
    procedure edtCodFornecedorExit(Sender: TObject);
    procedure edtCodFornecedorKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpresaExit(Sender: TObject);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure btnImprimirClick(Sender: TObject);
    procedure edtCodEveExit(Sender: TObject);
    procedure edtCodEveKeyPress(Sender: TObject; var Key: Char);
    procedure mskCodCtaExit(Sender: TObject);
    procedure mskCodCtaKeyPress(Sender: TObject; var Key: Char);
    procedure edtDestinoExit(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    qryRelatorio: TUniQuery;

    procedure pExportaExcel;

    procedure pCriaQryRelatorio;

    { Private declarations }
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  end;

var
  frmRelCtpTitAbertoMes: TfrmRelCtpTitAbertoMes;

implementation

uses DB, untfuncoesFactory, untQckCtpTitAbertoMes, untExcel;

{$R *.dfm}

procedure TfrmRelCtpTitAbertoMes.FormShow(Sender: TObject);
begin
  pCriaQryRelatorio;

  edtCodEmpresa.Text := VS_strCodEmp;
  edtDesEmpresa.Text := fRetNomeEmpresa;

  mskDtaIni.Text := FormatDateTime('mm/yyyy',VS_Date);
  mskDtaFin.Text := FormatDateTime('mm/yyyy',VS_Date);
  inherited;
end;

procedure TfrmRelCtpTitAbertoMes.edtCodFornecedorExit(Sender: TObject);
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

procedure TfrmRelCtpTitAbertoMes.edtCodFornecedorKeyPress(Sender: TObject;
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

procedure TfrmRelCtpTitAbertoMes.edtCodEmpresaExit(Sender: TObject);
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

procedure TfrmRelCtpTitAbertoMes.edtCodEmpresaKeyPress(Sender: TObject;
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

function TfrmRelCtpTitAbertoMes.fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin
    {***********************}
    {* VALIDA DATA INICIAL *}
    {********************AF*}
    If (Sender = mskDtaIni) Then
    Begin
      If mskDtaIni.Text = '  -    ' Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Data Inicial deve ser preenchido!', ['&O k']);
        Result := False;
      End;
    End;
    {*********************}
    {* VALIDA DATA FINAL *}
    {******************AF*}
    If (Sender = mskDtaFin) Then
    Begin
      If mskDtaFin.Text = '  -    ' Then
      Begin
        fMensagem('ATENÇÃO!','O campo Data Final deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      If StrToDate('01/' + mskDtaIni.Text) > StrToDate('01/' + mskDtaFin.Text) Then
      Begin
        fMensagem('ATENÇÃO!','A data inicial deve ser menor que a data final!',['&O K']);
        Result := False;
      End;
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

    If (Sender = edtCodEmpresa) Then
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

    If (Sender = edtDestino) Then
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

procedure TfrmRelCtpTitAbertoMes.btnImprimirClick(Sender: TObject);
  Var
    strSQL: String;
    intDiaFin: Integer;
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

  If blnImprime Then
  Begin

    {**************************************}
    {* PEGA A QUANTIDADE DE DIAS NO MES   *}
    {***********************************AF*}
    intDiaFin := DaysInMonth(StrToDate('01/' + mskDtaFin.Text));

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  DATE_FORMAT(CTP_DTAVEN,"%m/%Y") AS DTAVEN, ';
    strSQL := strSQL + '  SUM(IF(CTP_PREVIS = "S", (CTP_VALDUP - IFNULL(CTP_DESSUJ,0) + IFNULL(CTP_JURSUJ,0) + IFNULL(CTP_VENDOR,0)), 0)) AS PREVIS, ';
    strSQL := strSQL + '  SUM(IF(CTP_PREVIS = "S", 0, (CTP_VALDUP - IFNULL(CTP_DESSUJ,0) + IFNULL(CTP_JURSUJ,0) + IFNULL(CTP_VENDOR,0)))) AS REALIZ, ';
    strSQL := strSQL + '  SUM((CTP_VALDUP - IFNULL(CTP_DESSUJ,0) + IFNULL(CTP_JURSUJ,0) + IFNULL(CTP_VENDOR,0))) AS TOTGER ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADPAG, ';
    strSQL := strSQL + '  CADFOR  ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CTP_CODFOR = FOR_CODFOR AND ';
    strSQL := strSQL + '  CTP_DTAPAG IS NULL AND ';
    strSQL := strSQL + '  CTP_DTAVEN BETWEEN :DTAINI AND :DTAFIN ';

    If Not fEmptyStr(edtCodFornecedor.Text) Then
      strSQL := strSQL + '  AND CTP_CODFOR = :CODFOR ';

    If Not fEmptyStr(edtCodEmpresa.Text) Then
      strSQL := strSQL + '  AND CTP_CODEMP = :CODEMP '
    Else
      strSQL := strSQL + '  AND LOCATE(CTP_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';

    If Not fEmptyStr(edtCodEve.Text) Then
      strSQL := strSQL + '  AND CTP_CODEVE = :CODEVE ';

    If (Not fEmptyStr(mskCodCta.Text)) Then
    Begin

      If (RightStr(mskCodCta.Text, 5) = '00000') Then
        strSQL := strSQL + '  AND LEFT(CTP_CODCTA, 2) = LEFT(:CODCTA, 2) '
      Else If (RightStr(mskCodCta.Text, 3) = '000') Then
        strSQL := strSQL + '  AND LEFT(CTP_CODCTA, 4) = LEFT(:CODCTA, 4) '
      Else
        strSQL := strSQL + '  AND CTP_CODCTA = :CODCTA '

    End;

    If (edtBoleto.Text = 'S') Then
      strSQL := strSQL + '  AND CTP_VEIOBO = ' + QuotedStr('S')
    Else If (edtBoleto.Text = 'N') Then
      strSQL := strSQL + '  AND CTP_VEIOBO = ' + QuotedStr('N');

   {**************************}
   {* FILTRO POR COMPETÊNCIA *}
   {************************BB}
    if not fEmptyStr(fTiraCaracEspeciais(mskCompet.Text)) then
      strSQL := strSQL + '  AND CTP_COMPET = :COMPET ';


    strSQL := strSQL + 'GROUP BY ';
    strSQL := strSQL + '  DTAVEN ';
    strSQL := strSQL + 'ORDER BY ';
    strSQL := strSQL + '  DTAVEN ';

    With qryRelatorio Do
    Begin
      {**************************************}
      {* CRIA A TABELA TEMPORARIA           *}
      {***********************************AF*}
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      ParamByName('DTAINI').AsDate := StrToDate('01/' + mskDtaIni.Text);
      ParamByName('DTAFIN').AsDate := StrToDate(IntToStr(intDiaFin) + '/' + mskDtaFin.Text);

      If Not fEmptyStr(edtCodFornecedor.Text) Then
        ParamByName('CODFOR').AsString := edtCodFornecedor.Text;

      If Not fEmptyStr(edtCodEmpresa.Text) Then
        ParamByName('CODEMP').AsString := edtCodEmpresa.Text;

      If Not fEmptyStr(edtCodEve.Text) Then
        ParamByName('CODEVE').AsString := edtCodEve.Text;

      If (Not fEmptyStr(mskCodCta.Text)) Then
        ParamByName('CODCTA').AsString := mskCodCta.Text;

      If Not fEmptyStr(fTiraCaracEspeciais(mskCompet.Text)) then
        ParamByName('COMPET').AsString := mskCompet.Text;

      Open;

    End;

    If Not qryRelatorio.IsEmpty Then
    Begin
      Try
        If Not SameText(edtDestino.Text, 'E') Then
        Begin
          pCriarFormularios(TfrmQckCtpTitAbertoMes,frmQckCtpTitAbertoMes);

          frmQckCtpTitAbertoMes.dtsRelatorio.DataSet := qryRelatorio;

          frmQckCtpTitAbertoMes.rllNomeRelatorio.Caption := 'RELATORIO DE TITULOS EM ABERTO POR MES - CONTAS A PAGAR';

          If strTipImp = 'M' Then
            frmQckCtpTitAbertoMes.qckPagina.DefaultFilter := rldFiltro
          Else
            frmQckCtpTitAbertoMes.qckPagina.DefaultFilter := Nil;

          frmQckCtpTitAbertoMes.strOrdem := 'REFERENTE AO PERIODO DE ' + mskDtaIni.Text + ' A ' + mskDtaFin.Text;

          If edtCodFornecedor.Text = '' Then
            frmQckCtpTitAbertoMes.rllFornecedor.Caption := 'FORNECEDOR: TODOS'
          Else
            frmQckCtpTitAbertoMes.rllFornecedor.Caption := 'FORNECEDOR: ' + edtCodFornecedor.Text + ' - ' + edtDesFornecedor.Text;

          If edtCodEmpresa.Text = '' Then
            frmQckCtpTitAbertoMes.rllEmpresa.Caption := 'EMPRESA: TODAS'
          Else
            frmQckCtpTitAbertoMes.rllEmpresa.Caption := 'EMPRESA: ' + edtCodEmpresa.Text + ' - ' + edtDesEmpresa.Text;

          If edtCodEve.Text = '' Then
            frmQckCtpTitAbertoMes.rllEventos.Caption := 'CENTRO DE CUSTOS: TODOS'
          Else
            frmQckCtpTitAbertoMes.rllEventos.Caption := 'CENTRO DE CUSTOS: ' + edtCodEve.Text + ' - ' + edtDesEve.Text;

          If (fEmptyStr(mskCodCta.Text)) Then
            frmQckCtpTitAbertoMes.rllCodCta.Caption := 'PLANO DE CONTAS: TODOS '
          Else
            frmQckCtpTitAbertoMes.rllCodCta.Caption := 'PLANO DE CONTAS: ' + mskCodCta.Text + ' - ' + edtDesCta.Text;

          If edtBoleto.Text = 'S' Then
            frmQckCtpTitAbertoMes.rllBoleto.Caption := 'VEIO BOL?: SIM'

          Else If edtBoleto.Text = 'N' Then
            frmQckCtpTitAbertoMes.rllBoleto.Caption := 'VEIO BOL?: NAO'

          Else
            frmQckCtpTitAbertoMes.rllBoleto.Caption := 'VEIO BOL?: TODOS';

          If edtDestino.Text = 'V' Then
            frmQckCtpTitAbertoMes.qckPagina.PreviewModal
          Else
            frmQckCtpTitAbertoMes.qckPagina.Print;

        End
        Else
        Begin
          {******************************}
          {* EXPORTA RELATÓRIO P\ EXCEL *}
          {***************************JB*}
          pExportaExcel;

        End;

      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '['+Self.Name+' -> (Ocorreu um erro durante a Impressao)]');
        End;
      End;

      pFreeAndNil(frmQckCtpTitAbertoMes);      

    End
    Else
      pTabelaVazia;

  End;

  btnImprimir.Enabled := True;
  pnlInfo.Caption := '';

end;

procedure TfrmRelCtpTitAbertoMes.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(mskCompet);
end;

procedure TfrmRelCtpTitAbertoMes.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryRelatorio);
end;

procedure TfrmRelCtpTitAbertoMes.edtCodEveExit(Sender: TObject);
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

procedure TfrmRelCtpTitAbertoMes.edtCodEveKeyPress(Sender: TObject;
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

procedure TfrmRelCtpTitAbertoMes.mskCodCtaExit(Sender: TObject);
begin
  inherited;
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

procedure TfrmRelCtpTitAbertoMes.mskCodCtaKeyPress(Sender: TObject;
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

procedure TfrmRelCtpTitAbertoMes.pCriaQryRelatorio;
begin
  qryRelatorio:= fCriaQuery(Self);
  frxRelatorio.DataSet := qryRelatorio;

end;

procedure TfrmRelCtpTitAbertoMes.pExportaExcel;
  Var
    objExcel: TExcel;

    fltTotPre: Double;
    fltTotRea: Double;
    fltTotGer: Double;

begin
  fltTotPre := 0;
  fltTotRea := 0;
  fltTotGer := 0;

  {*******************************************}
  {* CRIA UM OBJETO DO TIPO "EXCEL" E TORNA  *}
  {* A APLICAÇÃO INVISÍVEL                   *}
  {****************************************JB*}
  objExcel := TExcel.fCriarExcel(Self);

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
    LinhaAtual := 01;
    {********************************}
    {* EMPRESA PADRAO DO SISTEMA    *}
    {*****************************JB*}
    Escrever(ProximaLinha, 01, fRetNomeEmpresaSelec(VS_strCodEmp));

    {*******************************************}
    {* TITULO DO RELATORIO                     *}
    {****************************************JB*}
    Escrever(ProximaLinha, 01, 'RELATORIO DE TITULOS EM ABERTO POR MES');

    ProximaLinha;

    If edtCodFornecedor.Text = '' Then
      Escrever(ProximaLinha, 01, 'FORNECEDOR: TODOS')
    Else
      Escrever(ProximaLinha, 01, 'FORNECEDOR: ' + edtCodFornecedor.Text + ' - ' + edtDesFornecedor.Text);

    If edtCodEmpresa.Text = '' Then
      Escrever(ProximaLinha, 01, 'EMPRESA: TODAS')
    Else
      Escrever(ProximaLinha, 01, 'EMPRESA: ' + edtCodEmpresa.Text + ' - ' + edtDesEmpresa.Text);

    If edtCodEve.Text = '' Then
      Escrever(ProximaLinha, 01, 'CENTRO DE CUSTOS: TODOS')
    Else
      Escrever(ProximaLinha, 01, 'CENTRO DE CUSTOS: ' + edtCodEve.Text + ' - ' + edtDesEve.Text);

    If (fEmptyStr(mskCodCta.Text)) Then
      Escrever(ProximaLinha, 01, 'PLANO DE CONTAS: TODOS ')
    Else
      Escrever(ProximaLinha, 01, 'PLANO DE CONTAS: ' + mskCodCta.Text + ' - ' + edtDesCta.Text);

    If edtBoleto.Text = 'S' Then
      Escrever(ProximaLinha, 01, 'VEIO BOL?: SIM')
    Else If edtBoleto.Text = 'N' Then
      Escrever(ProximaLinha, 01, 'VEIO BOL?: NAO')
    Else
      Escrever(ProximaLinha, 01, 'VEIO BOL?: TODOS');

    {*******************************************}
    {* OUTROS DADOS DO RELATÓRIO               *}
    {****************************************JB*}
    Escrever(ProximaLinha, 01, 'REFERENTE AO PERIODO DE ' + mskDtaIni.Text + ' A ' + mskDtaFin.Text);

    ProximaLinha;

    {********************************}
    {* COLOCA EM NEGRITO E ALINHA   *}
    {* AO CENTRO DA CELULA          *}
    {*****************************MV*}
    Mesclar('A1','D1');
    Mesclar('A2','D2');
    Mesclar('A3','D3');
    Alinhamento('A1','D3', Centro);
    Negrito('A1','D3', True);

    Mesclar('A4','D4');
    Mesclar('A5','D5');
    Mesclar('A6','D6');
    Mesclar('A7','D7');
    Mesclar('A8','D8');
    Mesclar('A9','D9');
    Mesclar('A10','D10');
    Alinhamento('A5','D10', Centro);
    Negrito('A5','D10', True);

    {*******************************************}
    {* COLUNAS                                 *}
    {****************************************JB*}
    Escrever(LinhaAtual, 01, 'MES/ANO             ');
    Escrever(LinhaAtual, 02, 'PREVISAO            ');
    Escrever(LinhaAtual, 03, 'REALIZADO           ');
    Escrever(LinhaAtual, 04, 'TOTAL               ');

    {*******************************************}
    {* COLOCA NEGRITO NAS COLUNAS              *}
    {****************************************JB*}
    Negrito('A' + IntToStr(LinhaAtual), 'D' + IntToStr(LinhaAtual), True);

    {*************************************}
    {* COLORI O FUNDO DA CELULA P/ CINZA *}
    {**********************************JB*}
    CorFundo('A2','D2', Cinza);
    CorFundo('A3','D3', Cinza);
    CorFundo('A11','D11', Cinza);

    {********************************}
    {* INSERE BORDAS NA CELULA      *}
    {*****************************JB*}
    Bordas('A2','D2');
    Bordas('A3','D3');
    Bordas('A4','D11');

    With qryRelatorio Do
    Begin
      First;
      ProximaLinha;

      While (Not Eof) Do
      Begin

        Escrever(LinhaAtual, 01, fFrtStrExcel((String(arrMesAbr[StrToInt(LeftStr(FieldByName('DTAVEN').AsString,2))]) + ' / ' +
                                 RightStr(FieldByName('DTAVEN').AsString,4))));

        Escrever(LinhaAtual, 02, FloatToStrF(FieldByName('PREVIS').AsFloat, ffNumber, 12, 2));
        Alinhamento(LinhaAtual, 02, Direita);
        Escrever(LinhaAtual, 03, FloatToStrF(FieldByName('REALIZ').AsFloat, ffNumber, 12, 2));
        Alinhamento(LinhaAtual, 03, Direita);
        Escrever(LinhaAtual, 04, FloatToStrF(FieldByName('TOTGER').AsFloat, ffNumber, 12, 2));
        Alinhamento(LinhaAtual, 04, Direita);

        fltTotPre := fltTotPre + FieldByName('PREVIS').AsFloat;
        fltTotRea := fltTotRea + FieldByName('REALIZ').AsFloat;
        fltTotGer := fltTotGer + FieldByName('TOTGER').AsFloat;

        ProximaLinha;

        Next;
      End;

      Escrever(LinhaAtual, 01, 'TOTAL:');
      Escrever(LinhaAtual, 02, FloatToStrF(fltTotPre, ffNumber, 12, 2));
      Escrever(LinhaAtual, 03, FloatToStrF(fltTotRea, ffNumber, 12, 2));
      Escrever(LinhaAtual, 04, FloatToStrF(fltTotGer, ffNumber, 12, 2));

      Bordas('A'+ IntToStr(LinhaAtual) , 'D'+ IntToStr(LinhaAtual));
      Alinhamento('A'+ IntToStr(LinhaAtual) , 'D'+ IntToStr(LinhaAtual), Direita);

      Negrito(LinhaAtual, 01, True);

    End;

    CongelarPaines('A12');
    AutoAjuste;
    SalvarArquivo;
    FecharArquivo;

  End;

  FreeAndNil(objExcel);

  fMensagem('', 'Arquivo gerado com sucesso!', ['&Ok']);

End;

procedure TfrmRelCtpTitAbertoMes.edtDestinoExit(Sender: TObject);
begin
//  inherited;

end;

end.

