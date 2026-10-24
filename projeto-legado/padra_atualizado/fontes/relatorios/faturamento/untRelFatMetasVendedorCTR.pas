unit untRelFatMetasVendedorCTR;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiRelatorio, RLFilters, RLDraftFilter, Menus, StdCtrls,
  EditFocus, QColorLabel, Buttons, ExtCtrls, Mask, MaskEditFocus, StrUtils,
  DateUtils, frxDesgn, frxClass, frxDBSet, frxDMPExport, frxExportPDF,
  frxExportHTML, frxExportXLS, frxExportRTF, Uni, AppEvnts, BitBtnLockedIncrem,
  DB, Grids, DBGridCitel, DBGrids, ComCtrls, untGeraExcel, untExcel, frxExportCSVTestabilidade,
  untTypesSistema, untIValorRecebido;

type
  TfrmRelFatMetasVendedorCTR = class(TfrmPaiRelatorio)
    Label7: TLabel;
    Label8: TLabel;
    Label6: TLabel;
    Label5: TLabel;
    edtCodVen: TEditFocus;
    edtDesVen: TEditFocus;
    lblEmpresa: TLabel;
    edtCodEmp: TEditFocus;
    Label12: TLabel;
    edtDesEmp: TEditFocus;
    gpbQuebra: TGroupBox;
    edtQuebra: TEditFocus;
    ColorLabel6: TColorLabel;
    Label1: TLabel;
    lstClaFis: TMemo;
    mskMesAnoIni: TMaskEditFocus;
    mskMesAnoFin: TMaskEditFocus;
    pgbProgresso: TProgressBar;
    shaVen: TShape;
    procedure edtCodVenKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodVenExit(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure pAtualizaClaFis;
    procedure btnImprimirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    relRecebido: IValorRecebido;
    blnLibVendedor: Boolean;
    function fMontaTempRecebimento: String;
    procedure pMontaResumo(Excel: TExcel; Campos: TCampos; Quebra: TRecQuebras);
    procedure pSomaTotais(var Totais: TTotais; Dados: TDataSet);
    procedure pImpDetalhe(Excel: TExcel; Dados: TDataSet; Campos: TCampos; CorFundo: TCorExcel);
    procedure pImpFiltros(Excel: TExcel; Dados: TDataSet; Campos: TCampos; Filtros: Array Of String);
    procedure pImpTituloGrupo(Excel: TExcel; Dados: TDataSet; Campos: TCampos; Quebra: TRecQuebras);
    procedure pGeraExcel(qryDados: TUniQuery);
    procedure pVerdeVermelho(edtCodVen: TEditFocus; shaVen: TShape; blnLiberado: Boolean);
  public
    arrVen : TConsultasArray;
    arrEmp : TConsultasArray;

    strVen : String;
    strEmp : String;
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  end;

var
  frmRelFatMetasVendedorCTR: TfrmRelFatMetasVendedorCTR;

implementation

uses untFuncoesFactory, untIFuncoes, untQckFatMetasVendedorCTR, Math;

{$R *.dfm}

{*****************}
{* VALIDA CAMPOS *}
{**************RL*}
function TfrmRelFatMetasVendedorCTR.fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean;
var
  strCodVen : String;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin
    {*************************}
    {* VALIDA PERÍODO INICIAL }
    {**********************RL*}
    If (Sender = mskMesAnoIni) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskMesAnoIni.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Período Inicial deve ser preenchido!', ['&O k']);
        Result := False;
      End;

    End

    {*********************}
    {* VALIDA DATA FINAL *}
    {******************RL*}
    Else If (Sender = mskMesAnoFin) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskMesAnoFin.Text)) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Período Final deve ser preenchido!', ['&O k']);
        Result := False;
      End

      Else
      Try
        If StrToDate('01/' + mskMesAnoIni.Text) > StrToDate('01/' + mskMesAnoFin.Text) Then
        Begin
          fMensagem('ATENÇÃO!','O período inicial deve ser menor que o período final!',['&O K']);
          Result := False;
        End;
      Except
        fMensagem('','Mês / Ano inválido!',['&O K']);
        Result := False;
      End;
    End

    Else If (Sender = edtQuebra) Then
    Begin

      If (edtQuebra.Text <> 'V') AND (edtQuebra.Text <> 'M') Then
      Begin
        fMensagem('','O campo deve conter V ou M! ',['&O K']);
        Result := False;
      End;
    End

    Else If (Sender = edtCodVen) Then
    Begin
      pDesmarcaLista(edtCodVen, arrVen);

      If blnLibVendedor Then
        Exit;

      If Not fEmptyStr(edtCodVen.Text) Then
      Begin
        strCodVen := fRetCodVendedor(edtCodVen.Text);

        If Not fEmptyStr(strCodVen) Then
          edtDesVen.Text := fRetNomVendRep(strCodVen)
        Else
        Begin
          Result := False;
          fMensagem('','Vendedor não encontrado.', ['&OK']);
        End;
      End
      Else
      Begin
        Result := False;
        fMensagem('', 'Informe a senha para o Vendedor!', ['&OK']);
      End;
    End

    Else If (Sender = edtCodEmp) Then
    Begin
      If (Not fEmptyStr(edtCodEmp.Text)) And
         (edtCodEmp.Text <> '000') Then
      Begin
        If Pos(edtCodEmp.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&OK']);
          Result := False;
        End;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmRelFatMetasVendedorCTR.edtCodVenKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If blnLibVendedor And fPesqOperador(Self, edtCodVen, edtDesVen, Nil, Key, arrVen, not blnLibVendedor) Then
  Begin
    If fValidaCampos(edtCodVen, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFatMetasVendedorCTR.edtCodVenExit(Sender: TObject);
begin
  inherited;
  If blnLibVendedor Then
    pEdtCodSelectExit(edtCodVen, edtDesVen, arrVen, fRetNomVendRep, Nil, 'do vendedor', 3);
end;

procedure TfrmRelFatMetasVendedorCTR.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtDesEmp, Nil, Key, arrEmp, False, True) Then
  Begin
    If fValidaCampos(edtCodEmp, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFatMetasVendedorCTR.edtCodEmpExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodEmp, edtDesEmp, arrEmp, Nil, fRetNomeEmpresaSelec, 'da empresa', 3);
end;

procedure TfrmRelFatMetasVendedorCTR.pAtualizaClaFis;
  Var
    strClaFis: String;
Begin
  strClaFis := VS_strClaVen;

  While Not fEmptyStr(strClaFis) Do
  Begin
    Application.ProcessMessages;

    lstClaFis.Lines.Add(LeftStr(strClaFis,4));

    strClaFis := RightStr(strClaFis, Length(strClaFis)-5 );
  End;
End;

procedure TfrmRelFatMetasVendedorCTR.pGeraExcel(qryDados: TUniQuery);
  Var
    objGeraExcel: TGeraExcel;
begin
  objGeraExcel := TGeraExcel.Create(qryDados, pgbProgresso);

  Try
    With objGeraExcel do
    Begin
      strNomRel := 'RELATORIO DE METAS POR VENDEDOR - CONTAS A RECEBER - QUEBRA POR ' + IfThen(edtQuebra.Text = 'M', 'MES/ANO', 'VENDEDOR');

      AddFiltro('REFERENTE AO PERIODO DE ' + mskMesAnoIni.Text+ ' A ' + mskMesAnoFin.Text);
      AddFiltro( fStrTitulo(edtCodVen.Text, edtDesVen, arrVen, strVen, 'VENDEDOR') );
      If fEmptyStr(edtCodEmp.Text) Then
        AddFiltro('EMPRESAS: ' + strEmpAcessoUsuarioLogado)
      Else
        AddFiltro( fStrTitulo(edtCodEmp.Text, edtDesEmp, arrEmp, strEmp, 'EMPRESA') );

      If edtQuebra.Text = 'M' Then
        AddCampo('OPE_DESOPE', 'VENDEDOR')
      Else
        AddCampo('MET_MESANO',  'MES/ANO');

      AddCampo('MET_TOTMET',  'META');
      AddCampo('TOTAL',       'RECEBIMENTOS');
      AddCampo('METATINGIDA', '% META ATINGIDA');
      AddCampo('METCONCLUIR', 'A CONCLUIR');
      AddCampo('TOTCOM',      'COMISSÃO');

      If edtQuebra.Text = 'M' Then
        AddQuebra('MET_MESANO', 'MES/ANO: ')
      Else
        AddQuebra('OPE_DESOPE', 'VENDEDOR: ');

      AddTotais('MET_TOTMET');
      AddTotais('TOTAL');
      AddTotais('METATINGIDA');
      AddTotais('METCONCLUIR');
      AddTotais('TOTCOM');
    End;

    objGeraExcel.OnMontaResumo := pMontaResumo;
    objGeraExcel.OnSomaResumo := pSomaTotais;
    objGeraExcel.OnImpDetalhes := pImpDetalhe;
    objGeraExcel.OnImpFiltros := pImpFiltros;
    objGeraExcel.OnImpTitGrupo := pImpTituloGrupo;

    If objGeraExcel.fGerarRelatorio Then
       fMensagem('','Arquivo gerado com sucesso!',['&O k']);
  Finally
    objGeraExcel.Free;
  End;
end;

procedure TfrmRelFatMetasVendedorCTR.pImpDetalhe(Excel: TExcel; Dados: TDataSet; Campos: TCampos; CorFundo: TCorExcel);
begin
  If edtQuebra.Text = 'V' Then
     Excel.Escrever(Excel.LinhaAtual, Campos.ColunaPorNome['MET_MESANO'].Coluna, FormatFloat('00/0000', Dados.FieldByName('MET_MESANO').AsFloat));
end;

procedure TfrmRelFatMetasVendedorCTR.pImpFiltros(Excel: TExcel; Dados: TDataSet; Campos: TCampos; Filtros: array of String);
var intLinha: Integer;
begin
  For intLinha := 0 to Length(Filtros) -1 Do
     Excel.Alinhamento('A' + IntToStr(Excel.LinhaAtual -intLinha), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(Excel.LinhaAtual -intLinha), Esquerda);
end;

procedure TfrmRelFatMetasVendedorCTR.pImpTituloGrupo(Excel: TExcel;
  Dados: TDataSet; Campos: TCampos; Quebra: TRecQuebras);
var strTitGrupo: String;
begin
  If edtQuebra.Text = 'M' Then
  Begin
    strTitGrupo := 'MES/ANO: ' + FormatFloat('00/0000', Dados.FieldByName('MET_MESANO').AsFloat);
    Excel.Escrever(Excel.LinhaAtual, Excel.ColunaAtual, strTitGrupo);
  End;
end;

procedure TfrmRelFatMetasVendedorCTR.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(mskMesAnoIni);
end;

procedure TfrmRelFatMetasVendedorCTR.FormCreate(Sender: TObject);
begin
  inherited;

  blnExcel := True;

  pAtualizaClaFis;

  shpMultSel.Visible := True;

  relRecebido := fGetTValorRecebido;
end;

procedure TfrmRelFatMetasVendedorCTR.pSomaTotais(var Totais: TTotais;
  Dados: TDataSet);
begin
  Totais['MET_TOTMET']  := Totais['MET_TOTMET']  + Dados.FieldByName('MET_TOTMET').AsFloat;
  Totais['TOTAL']       := Totais['TOTAL']       + Dados.FieldByName('TOTAL').AsFloat;
  Totais['METATINGIDA'] := Totais['METATINGIDA'] + Dados.FieldByName('METATINGIDA').AsFloat;
  Totais['METCONCLUIR'] := Totais['METCONCLUIR'] + Dados.FieldByName('METCONCLUIR').AsFloat;
  Totais['TOTCOM']      := Totais['TOTCOM']      + Dados.FieldByName('TOTCOM').AsFloat;
end;

procedure TfrmRelFatMetasVendedorCTR.pMontaResumo(Excel: TExcel;
  Campos: TCampos; Quebra: TRecQuebras);
  Var
    strTitResumo, strPrimeiroCampo: String;
    blnTotalGeral: Boolean;
    fltTotMet, fltTotal, fltMetAtingida, fltTotCom, fltMetConcluir: Real;
begin
  If edtQuebra.Text = 'M' Then
  Begin
    strTitResumo := 'TOTAL DO MES/ANO: ';
    strPrimeiroCampo := 'OPE_DESOPE';
  End
  Else
  Begin
    strTitResumo := 'TOTAL DO VENDEDOR: ';
    strPrimeiroCampo := 'MET_MESANO';
  End;

  blnTotalGeral := Quebra.NomeCampo = '[GERAL]';

  With Excel Do
  Begin
    If blnTotalGeral Then
       strTitResumo := 'TOTAL GERAL: ';
    fltTotMet      := Quebra.Totais['MET_TOTMET'];
    fltTotal       := Quebra.Totais['TOTAL'];
    fltMetAtingida := Quebra.Totais['METATINGIDA'];
    fltTotCom      := Quebra.Totais['TOTCOM'];
    fltMetConcluir := IfThen(blnTotalGeral, fltTotMet - fltTotal, Quebra.Totais['METCONCLUIR']);

    If fltMetConcluir < 0 Then
       fltMetConcluir := 0;

    ProximaLinha;
    Escrever(LinhaAtual, Campos.ColunaPorNome[strPrimeiroCampo].Coluna, strTitResumo);
    Escrever(LinhaAtual, Campos.ColunaPorNome['MET_TOTMET'].Coluna,     FormatFloat('##,#0.00', fltTotMet));
    Escrever(LinhaAtual, Campos.ColunaPorNome['TOTAL'].Coluna,          FormatFloat('##,#0.00', fltTotal));
    Escrever(LinhaAtual, Campos.ColunaPorNome['METATINGIDA'].Coluna,    FormatFloat('##,#0.00', fltMetAtingida));
    Escrever(LinhaAtual, Campos.ColunaPorNome['METCONCLUIR'].Coluna,    FormatFloat('##,#0.00', fltMetConcluir));
    Escrever(LinhaAtual, Campos.ColunaPorNome['TOTCOM'].Coluna,         FormatFloat('##,#0.00', fltTotCom));

    Negrito    ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), True);
    CorFundo   ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), CinzaEscuro);
    CorFonte   ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Branco);
    Bordas     ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual));
    Alinhamento('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Direita);
    ProximaLinha;
  End;
end;

procedure TfrmRelFatMetasVendedorCTR.btnImprimirClick(Sender: TObject);
  Var
    strSQL : String;
    strSQLTemp : String;
    strSQLASTmp : String;
    ADay : Word;
    QryRelatorio: TUniQuery;
begin
  inherited;

  If fEmptyStr(edtCodVen.Text) And (Not blnLibVendedor) Then
  Begin
    pSetFocus(edtCodVen);
    Exit;
  End;

  pnlInfo.Caption := 'Gerando Relatório...'; 
  pnlInfo.Repaint;

  //***************************************//
  // MONTAR QUERY DO RELATÓRIO             //
  //************************************RL*//
  If blnImprime Then
  Begin

    strSQLASTmp := fMontaTempRecebimento;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  O.OPE_CODOPE, ';
    strSQL := strSQL + '  O.OPE_NOMOPE, ';
    strSQL := strSQL + '  M.MET_MESANO, ';
    strSQL := strSQL + '  M.MET_TOTMET, ';
    strSQL := strSQL + '  SUM(IF(CTR_ESPDOC = "BR", 0.00,  CTR_VALREC))  AS  TOTAL,  ';
    strSQL := strSQL + '  (SUM(IF(CTR_ESPDOC = "BR", 0.00, CTR_VALREC)) / M.MET_TOTMET) * 100 AS METATINGIDA  ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  ( ' + strSQLASTmp + ' ) AS R, ';
    strSQL := strSQL + '  CADOPE O, ';
    strSQL := strSQL + '  CADMTR M  ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  R.CTR_CODVEN = M.MET_CODVEN AND ';
    strSQL := strSQL + '  R.CTR_CODVEN = O.OPE_CODOPE AND ';
    strSQL := strSQL + '  O.OPE_CODOPE = M.MET_CODVEN AND ';
    strSQL := strSQL + '  M.MET_TOTMET > 0            AND ';
    strSQL := strSQL + '  M.MET_MESANO = DATE_FORMAT(R.CTR_DTAREC,"%m%Y") AND ';
    strSQL := strSQL + '  R.CTR_DTAREC BETWEEN :DTAINI AND :DTAFIN AND';
    strSQL := strSQL + '  R.CTR_CODCLI NOT IN (' + VS_strCliFil + ') ';

    If Not fCfgSis('ENTBRF', varBoolean) Then
      strSQL := strSQL + ' AND CTR_ESPDOC <> "BR" ';

    If Not fEmptyStr(edtCodVen.Text) Then
      strSQL := strSQL + fStrLocate(edtCodVen, arrVen, 'R.CTR_CODVEN', 'CODVEN');

    If Not fEmptyStr(edtCodEmp.Text) Then
      strSQL := strSQL + fStrLocate(edtCodEmp, arrEmp, 'M.MET_CODEMP', 'CODEMP');

    strSQL := strSQL + 'GROUP BY ';
    strSQL := strSQL + ' O.OPE_CODOPE, M.MET_MESANO ';

    strSQLTemp := strSQL;

    Try
      QryRelatorio := fCriaQuery(Self);

      frxRelatorio.DataSet := QryRelatorio;

      With QryRelatorio Do
      Begin
        strSQL := '';
        strSQL := strSQL + 'SELECT SQL_NO_CACHE ';

        If (edtDestino.Text = 'E') Then
           strSQL := strSQL + '  CONCAT(OPE_CODOPE, " - ", OPE_NOMOPE) AS OPE_DESOPE,';

        strSQL := strSQL + '  OPE_CODOPE, ';
        strSQL := strSQL + '  OPE_NOMOPE, ';
        strSQL := strSQL + '  MET_MESANO, ';
        strSQL := strSQL + '  MET_TOTMET, ';
        strSQL := strSQL + '  SUM(TOTAL) TOTAL, ';
        strSQL := strSQL + '  SUM(METATINGIDA) METATINGIDA, ';
        strSQL := strSQL + '  IF(MET_TOTMET < SUM(TOTAL), 0, MET_TOTMET - SUM(TOTAL)) METCONCLUIR, ';
        strSQL := strSQL + '  0.00 AS TOTCOM ';
        strSQL := strSQL + 'FROM ( ';
        strSQL := strSQL +   strSqlTemp;
        strSQL := strSQL + ') AS TAB GROUP BY ';
        strSQL := strSQL + ' OPE_CODOPE, MET_MESANO ';
        strSQL := strSQL + 'ORDER BY ';

        If edtQuebra.Text = 'V' Then
          strSQL := strSQL + '  OPE_CODOPE, MET_MESANO '
        Else
          strSQL := strSQL + '  MET_MESANO, OPE_CODOPE ';

        Close;
        SQL.Clear;
        SQL.Add(strSQL);

        ADay := DaysInMonth(StrToDate('01/' + mskMesAnoFin.text));

        ParamByName('DTACOR').AsDateTime := 0;
        ParamByName('DTAINI').AsDateTime := strToDate('01/' + mskMesAnoIni.text);
        ParamByName('DTAFIN').AsDateTime := strToDate(IntToStr(ADay) + '/' + mskMesAnoFin.text);
        ParamByName('DTAFIM').AsDateTime := strToDate(IntToStr(ADay) + '/' + mskMesAnoFin.text);

        pSetaParam(edtCodEmp.Text, arrEmp, strEmp, 'CODEMP', QryRelatorio);
        pSetaParam(edtCodVen.Text, arrVen, strVen, 'CODVEN', QryRelatorio);

        Open;

      End;

      If Not QryRelatorio.IsEmpty Then
      Begin
        Try
          If edtDestino.Text = 'E' then
              pGeraExcel(QryRelatorio)
          Else
          Begin
            pCriarFormularios(TfrmQckFatMetasVendedorCTR,frmQckFatMetasVendedorCTR);

            frmQckFatMetasVendedorCTR.rllComFai.Visible  := False;
            frmQckFatMetasVendedorCTR.rllComFai2.Visible := False;

            frmQckFatMetasVendedorCTR.rdbComFai.Visible     := False;
            frmQckFatMetasVendedorCTR.rdbComFai2.Visible    := False;
            frmQckFatMetasVendedorCTR.rdbComFaiTot.Visible  := False;
            frmQckFatMetasVendedorCTR.rdbComFaiTot2.Visible := False;
            frmQckFatMetasVendedorCTR.rdbComFaiGer.Visible  := False;

            frmQckFatMetasVendedorCTR.RLLabel5.Caption  := 'RECEBIMENTOS';
            frmQckFatMetasVendedorCTR.RLLabel15.Caption := 'RECEBIMENTOS';

            {********************}
            {* CABECALHO DO QCK *}
            {*****************RL*}
            frmQckFatMetasVendedorCTR.rllPeriodo.Caption := 'REFERENTE AO PERIODO DE ' + mskMesAnoIni.Text + ' A ' + mskMesAnoFin.Text;

            frmQckFatMetasVendedorCTR.rllNomeVen.Caption := fStrTitulo(edtCodVen.Text, edtDesVen, arrVen, strVen, 'VENDEDOR');

            If fEmptyStr(edtCodEmp.Text) Then
              frmQckFatMetasVendedorCTR.rllNomeVen.Caption := 'EMPRESAS: ' + strEmpAcessoUsuarioLogado
            Else
              frmQckFatMetasVendedorCTR.rllEmpresa.Caption := fStrTitulo(edtCodEmp.Text, edtDesEmp, arrEmp, strEmp, 'EMPRESA');

            If edtQuebra.Text = 'V' Then
            Begin
              frmQckFatMetasVendedorCTR.rllNomeRelatorio.Caption   := 'RELATORIO DE METAS POR VENDEDOR - CONTAS A RECEBER - QUEBRA POR VENDEDOR';
              frmQckFatMetasVendedorCTR.rlbTitulo.Visible          := True;
              frmQckFatMetasVendedorCTR.rlbGrupo.Visible           := True;
            End
            Else
            Begin
              frmQckFatMetasVendedorCTR.rllNomeRelatorio.Caption := 'RELATORIO DE METAS POR VENDEDOR - CONTAS A RECEBER - QUEBRA POR MES';
              frmQckFatMetasVendedorCTR.rlbTitulo2.Visible       := True;
              frmQckFatMetasVendedorCTR.rlbGrupo2.Visible        := True;
            End;

            frmQckFatMetasVendedorCTR.dtsRelatorio.DataSet := QryRelatorio;

            If edtDestino.Text = 'V' Then
              pPreviewReport(Self.Name, Self.Caption, frmQckFatMetasVendedorCTR.qckPagina, frmQckFatMetasVendedorCTR.rpsSetup)
            Else
              pPrintReport(Self.Name, Self.Caption, strNomImp, frmQckFatMetasVendedorCTR.qckPagina);
          End;
        Except
          On E: Exception Do
          Begin
            pMensagensErro(E.Message, '['+Self.Name+' -> (Ocorreu um erro durante a Impressao)]');
          End;
        End;
        pFreeAndNil(frmQckFatMetasVendedorCTR);

      End
      Else
      Begin
        pTabelaVazia;
      End;

    Finally
      If Assigned(QryRelatorio) then
        FreeAndNil(QryRelatorio);
    End;
    btnImprimir.Enabled := True;
    pnlInfo.Caption := '';
  End;

  pSetFocus(mskMesAnoIni);
end;

procedure TfrmRelFatMetasVendedorCTR.FormShow(Sender: TObject);
begin
  edtCodEmp.Text := VS_strCodEmp;
  edtDesEmp.Text := fRetNomeEmpresa;

  mskMesAnoIni.Text := FormatDateTime('mm/yyyy',VS_Date);
  mskMesAnoFin.Text := FormatDateTime('mm/yyyy',VS_Date);

  blnLibVendedor    := fVerificaAcessoSistema('METVNCTR');
  pVerdeVermelho(edtCodVen, shaVen, blnLibVendedor);

  inherited;
end;

function TfrmRelFatMetasVendedorCTR.fMontaTempRecebimento: String;
  Var
    strSQL: String;
begin
  relRecebido.strCodVen := fGetStrCodigos(edtCodVen, arrVen);
  relRecebido.strCodEmp := fGetStrCodigos(edtCodEmp, arrEmp);
  relRecebido.relRelEmp := reMovimentacao;

  {***************************************************}
  {* CADREC DIRETA - SEM AGRUPAMENTO NEM CONFIRMAÇÃO *}
  {************************************************MV*}
  strSQL := '';
  strSQL := strSQL + '  ' + relRecebido.fGetSqlSemAgrupamentoNemConfirmacao('CADREC');
  strSQL := strSQL + '  UNION ALL ';

  {***************************************************}
  {* CADREC PROVENIENTE DE CONFIRMAÇÃO DOCUMENTO     *}
  {************************************************MV*}
  strSQL := strSQL +  relRecebido.fGetSqlComConfirmacao('CADREC', 'CTRCNF');
  strSQL := strSQL + '   UNION ALL  ';

  {***************************************************}
  {* CADREC AGRUPAMENTO DIRETO                       *}
  {************************************************MV*}
  strSQL := strSQL +  relRecebido.fGetSqlComAgrupamentoDireto('CADREC', 'DUPAGR');
  strSQL := strSQL + '   UNION ALL  ';

  {***************************************************}
  {* CADREC AGRUPAMENTO CONFIRMAÇÃO                  *}
  {************************************************MV*}
  strSQL := strSQL +  relRecebido.fGetSqlAgrupamentoConfirmacao('CADREC',  'DUPAGR',  'CTRCNF');

  Result := strSQL;

  //FreeAndNil(relRecebido);
end;

procedure TfrmRelFatMetasVendedorCTR.pVerdeVermelho(edtCodVen: TEditFocus; shaVen: TShape; blnLiberado: Boolean);
Begin
  If (Not blnLiberado) Then
  Begin
    edtCodVen.MaxLength := 10;
    edtCodVen.TamCampo  := 10;
    edtCodVen.CompZeros := False;
    edtCodVen.PasswordChar := '*';
    edtCodVen.TipoTexto := ttAlfanumerico;
    shaVen.Brush.Color  := clRed;
  End
  Else
    shaVen.Brush.Color  := clGreen;
End;

end.

