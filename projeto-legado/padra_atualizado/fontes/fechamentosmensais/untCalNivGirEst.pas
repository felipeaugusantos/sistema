unit untCalNivGirEst;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, CheckLst, ComCtrls, EditFocus, AppEvnts, Menus,
  Buttons, ExtCtrls, CurrencyEditFocus, untTypesSistema, QColorLabel, Mask,
  MaskEditFocus, Uni, untFuncoesSimples, StrUtils, DB, UniClientDataSet,
  UniDataSetProvider, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxTextEdit, cxCurrencyEdit;

type
  TfrmCalNivGirEst = class(TfrmPai)
    pnlFundo: TPanel;
    Label1: TLabel;
    edtFornecedor: TEditFocus;
    edtDesFornecedor: TEditFocus;
    pgbStatus: TProgressBar;
    Label5: TLabel;
    mskDtaIni: TMaskEditFocus;
    Label6: TLabel;
    mskDtaFin: TMaskEditFocus;
    Label9: TLabel;
    mskLinhaGrupo: TMaskEditFocus;
    edtDesGrupo: TEditFocus;
    Label11: TLabel;
    edtMarca: TEditFocus;
    edtDesMarca: TEditFocus;
    edtDesEmpresa: TEditFocus;
    edtCodEmpresa: TEditFocus;
    lblEmpresa: TLabel;
    GroupBox1: TGroupBox;
    lblOrdemQtdValor: TColorLabel;
    edtOrdem: TEditFocus;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    ceValNiA: TCurrencyEditFocus;
    Label3: TLabel;
    Label4: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    ceValNB1: TCurrencyEditFocus;
    Label10: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    ceValNiC: TCurrencyEditFocus;
    Label14: TLabel;
    ceValNB2: TCurrencyEditFocus;
    Label15: TLabel;
    shpMultSel: TShape;
    btnGerar: TBitBtnLocked;
    lblPrdGru: TLabel;
    edtPrdGru: TEditFocus;
    edtDesPrdPro: TEditFocus;
    procedure mskLinhaGrupoKeyPress(Sender: TObject; var Key: Char);
    procedure mskLinhaGrupoExit(Sender: TObject);
    procedure edtFornecedorKeyPress(Sender: TObject; var Key: Char);
    procedure edtFornecedorExit(Sender: TObject);
    procedure edtMarcaKeyPress(Sender: TObject; var Key: Char);
    procedure edtMarcaExit(Sender: TObject);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure btnGerarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ceValNiAEnter(Sender: TObject);
    procedure edtCodEmpresaExit(Sender: TObject);
    procedure edtPrdGruExit(Sender: TObject);
    procedure edtPrdGruKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    arrLinhaGrupo: TConsultasArray;
    arrFornecedor: TConsultasArray;
    arrMarca     : TConsultasArray;
    arrEmp       : TConsultasArray;
    arrGrupoPro  : TConsultasArray;
    fltSomaGeral : Double;

    blnSemDados: Boolean;

    strLinGru: String;
    strLinFor: String;
    strLinMar: String;
    strPrdGru: String;
    strCodEmp: String;

    Function fRetCampoCalc: String;

    Procedure pIniciaNivelGiro(blnGeral: Boolean);
    Function fCalculaNivelGiro(blnGeral: Boolean): Boolean;

  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  end;

implementation

uses  untConsultas, untFuncoesConsulta, untConstantes;

{$R *.dfm}

function TfrmCalNivGirEst.fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin
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
    {******************************}
    {* VALIDA GRUPO               *}
    {***************************LU*}
    Else If (Sender = mskLinhaGrupo) Then
    Begin
      pDesmarcaLista(mskLinhaGrupo,arrLinhaGrupo,'',6);
    End
    {******************************}
    {* VALIDA FORNECEDOR          *}
    {***************************LU*}
    Else If (Sender = edtFornecedor) Then
    Begin
      pDesmarcaLista(edtFornecedor,arrFornecedor);
    End
    {******************************}
    {* VALIDA MARCA               *}
    {***************************LU*}
    Else If (Sender = edtMarca) Then
    Begin
      pDesmarcaLista(edtMarca,arrMarca);
    End
    {******************************}
    {* VALIDA GRUPO PRODUTO       *}
    {******************************}
    Else If (Sender = edtPrdGru) Then
    Begin
      pDesmarcaLista(edtPrdGru,arrGrupoPro);
    End
    {******************************}
    {* VALIDA EMPRESA             *}
    {***************************LU*}
    Else If (Sender = edtCodEmpresa) Then
    Begin
      pDesmarcaLista(edtCodEmpresa,arrEmp);
        If (Not fEmptyStr(edtCodEmpresa.Text)) And (Length(arrEmp) = 0)
              And (Pos(edtCodEmpresa.Text, strEmpAcessoUsuarioLogado) <= 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
          Result := False;
        End;
    End
    {******************************}
    {* VALIDA ORDEM               *}
    {***************************LU*}
    Else If (Sender = edtOrdem) Then
    Begin
      If (edtOrdem.Text <> 'Q') And (edtOrdem.Text <> 'V') And (edtOrdem.Text <> 'L') Then
      Begin
        fMensagem('ATENÇÃO!','O campo ordem (Q)uantidade / (V)alor / (L)itragem deve ser Q, V ou L!',['&O K']);
        Result := False;
      End;
    End
    {******************************}
    {* VALIDA OOS NIVEIS          *}
    {***************************LU*}
    Else If (Sender = ceValNiA) Then
    Begin
      If fEmptyStr(ceValNiA.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O percentual do nível A deve ser preenchido!',['&O K']);
        Result := False;
      End
      Else
        ceValNB1.Text := FloatToStr(fStrToFloat(ceValNiA.Text) + 0.01);
    End
    Else If (Sender = ceValNB1) Then
    Begin
      If fEmptyStr(ceValNB1.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O percentual inicial do nível B deve ser preenchido!',['&O K']);
        Result := False;
      End;
    End
    Else If (Sender = ceValNB2) Then
    Begin
      If fEmptyStr(ceValNB2.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O percentual final do nível B deve ser preenchido!',['&O K']);
        Result := False;
      End
      Else
      Begin
        ceValNiC.Text := FloatToStr(fStrToFloat(ceValNB2.Text));
        ceValNB2.Enabled := False;
      End;
    End
    Else If (Sender = ceValNiC) Then
    Begin
      If fEmptyStr(ceValNiC.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O percentual do nível C deve ser preenchido!',['&O K']);
        Result := False;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmCalNivGirEst.mskLinhaGrupoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {********************************}
  {* NOVA CONSULTA DE LINHA/GRUPO *}
  {*****************************RV*}
  If fPesqGrupo(Self, mskLinhaGrupo, edtDesGrupo, Nil, Key, arrLinhaGrupo, False) Then
  Begin
    If fValidaCampos(mskLinhaGrupo, False) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCalNivGirEst.mskLinhaGrupoExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(mskLinhaGrupo,edtDesGrupo,arrLinhaGrupo,fRetNomeLinhaGrupo,Nil,'da linha/grupo',6);
end;

procedure TfrmCalNivGirEst.edtFornecedorKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************RV*}
  If fPesqFornecedor(conForSimples, Self, edtFornecedor, edtDesFornecedor, Nil, Key, arrFornecedor, False) Then
  Begin
    fValidaCampos(edtFornecedor, False);
    Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCalNivGirEst.edtFornecedorExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtFornecedor,edtDesFornecedor,arrFornecedor,fRetNomFornecedor,nil,'do Fornecedor');
end;

procedure TfrmCalNivGirEst.edtMarcaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  {***************************}
  {* NOVA CONSULTA DE MARCAS *}
  {************************DP*}
  If fPesqMarcas(Self, edtMarca, edtDesMarca, Nil, Key, arrMarca, False) Then
  Begin
    If fValidaCampos(edtMarca, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCalNivGirEst.edtPrdGruExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtPrdGru, edtDesPrdPro, arrGrupoPro, fRetNomeGrupoProduto, nil, 'do Grupo de Produtos', edtPrdGru.MaxLength);
end;

procedure TfrmCalNivGirEst.edtPrdGruKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqGrupoProduto(Self, edtPrdGru, edtDesPrdPro, Nil, Key, arrGrupoPro, False) Then
  Begin
    If fValidaCampos(edtPrdGru, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCalNivGirEst.edtMarcaExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtMarca,edtDesMarca,arrMarca,fRetNomMarca,nil,'da Marca');
end;

procedure TfrmCalNivGirEst.edtCodEmpresaExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodEmpresa,edtDesEmpresa,arrEmp,fRetNomeEmpresa,nil,'da Empresa');
end;

procedure TfrmCalNivGirEst.edtCodEmpresaKeyPress(Sender: TObject;  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpresa, edtDesEmpresa, Nil, Key, arrEmp, False, True) Then
  Begin
    If fValidaCampos(edtCodEmpresa, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

Function TfrmCalNivGirEst.fRetCampoCalc: String;
Begin
  Case edtOrdem.Text[1] Of
    'Q': Result := 'QTDITE';
    'L': Result := 'PESLIT';
    'V': Result := 'TOTITE';
    Else Result := 'TOTITE';
  End;
End;

Procedure TfrmCalNivGirEst.pIniciaNivelGiro(blnGeral: Boolean);
  Var
    qryCadIte: TUniQuery;
Begin
  qryCadIte := fCriaQuery;
  With qryCadIte Do
  Begin
    Close;
    SQL.Clear;

    If blnGeral Then
    Begin
      SQL.Add(' UPDATE CADITE I SET I.ITE_NVLGIR = "C"');
      SQL.Add(' WHERE TRUE ');
    End Else
    Begin
      SQL.Add(' UPDATE ITEGER G ');
      SQL.Add(' INNER JOIN CADITE I ON I.ITE_CODITE = G.ITE_CODITE');
      SQL.Add(' SET G.ITE_NIVGIR = "C"');
      SQL.Add(' WHERE TRUE ');
      SQL.Add(fStrLocateEmpresa(edtCodEmpresa, arrEmp, 'G.ITE_CODEMP', 'CODEMP'));
    End;

    SQL.Add(fStrLocate(edtFornecedor,        arrFornecedor, 'I.ITE_CODFOR', 'CODFOR'));
    SQL.Add(fStrLocate(edtMarca,             arrMarca,      'I.ITE_CODMAR', 'CODMAR'));
    SQL.Add(fStrLocate(edtPrdGru,            arrGrupoPro,   'I.ITE_PRDGRU', 'PRDGRU'));
    SQL.Add(fStrLocateLinGru(mskLinhaGrupo,  arrLinhaGrupo, 'I.ITE_CODGRU', 'CODGRU'));

    If Not blnGeral Then
      pSetaParam(edtCodEmpresa.Text, arrEmp,        strCodEmp, 'CODEMP', qryCadIte);
    pSetaParam(mskLinhaGrupo.Text,   arrLinhaGrupo, strLinGru, 'CODGRU', qryCadIte);
    pSetaParam(edtFornecedor.Text,   arrFornecedor, strLinFor, 'CODFOR', qryCadIte);
    pSetaParam(edtMarca.Text,        arrMarca,      strLinMar, 'CODMAR', qryCadIte);
    pSetaParam(edtPrdGru.Text,       arrGrupoPro,   strPrdGru, 'PRDGRU', qryCadIte);

    ExecSQL;

  End;
  FreeAndNil(qryCadIte);
End;

Function TfrmCalNivGirEst.fCalculaNivelGiro(blnGeral: Boolean): Boolean;
Var
  strSQL   : String;
  strSQL1  : String;

  qryGen   : TUniQuery;
  qryUpd   : TUniQuery;

  cdsItens: TUniClientDataSet;
  dspItens: TUniDataSetProvider;
  cdsTotais: TUniClientDataSet;

  fltNivA  : Double;
  fltNivB2 : Double;
  fltNivC  : Double;
  fltRepIte: Double;
  strNivel : String;
  fltTotRep: Double;

  Procedure pProcessaItens;
  Begin

    cdsTotais.Data     := cdsItens.Data;
    cdsTotais.Filter   := cdsItens.Filter;
    cdsTotais.Filtered := cdsItens.Filtered;

    cdsTotais.AggregatesActive := True;

    fltSomaGeral   := fDoubleAggregate(cdsTotais, 'TOTAL');

    fltNivA  := ceValNiA.Value;
    fltNivB2 := ceValNB2.Value;
    fltNivC  := ceValNiC.Value;
    fltTotRep:= 0;

    cdsItens.First;

   {****************************************************************************}
   {* SERA ATUALIZADA A TABELA CADITE (ITE_NVLGIR) APARTIR DO PERCENTUAL DE    *}
   {* REPRESENT. CALCULADO E OS PERCENTUAIS INFORMADOS PARA OS NIVEIS A, B E C *}
   {*************************************************************************LU*}
    While Not cdsItens.Eof Do
    Begin
      Application.ProcessMessages;

      If fltSomaGeral > 0 Then
        fltRepIte := (cdsItens.fieldbyname(fRetCampoCalc).AsFloat / fltSomaGeral) * 100
      Else
        fltRepIte := 0;

      fltTotRep := fltTotRep + fltRepIte;

      If fltTotRep <= fltNivA Then
        strNivel := 'A'
      Else If (fltTotRep <= fltNivB2) Then
        strNivel := 'B'
      Else If fltTotRep > fltNivC Then
        strNivel := 'C';

      With qryUpd Do
      Begin
        Close;
        SQL.Clear;

        If blnGeral Then
        Begin
          SQL.Add(' UPDATE CADITE SET ITE_NVLGIR = :NVLGIR WHERE ITE_CODITE = :CODITE ')
        End Else
        Begin
          SQL.Add(' UPDATE ITEGER SET ITE_NIVGIR = :NVLGIR WHERE ITE_CODITE = :CODITE AND ITE_CODEMP = :CODEMP');

          ParamByName('CODEMP').AsString := cdsItens.fieldbyname('CODEMP').AsString;
        End;

        ParamByName('NVLGIR').AsString := strNivel;
        ParamByName('CODITE').AsString := cdsItens.fieldbyname('CODITE').AsString;
        ExecSQL;
      End;

      cdsItens.Next;
      pgbStatus.StepBy(1);
    End;
  End;

  Procedure pProcessaItensPorEmpresa;
    Var
      qryCadEmp: TUniQuery;
  Begin
    qryCadEmp := fCriaQuery;

    With qryCadEmp, SQL Do
    Begin
      Add('SELECT EMP_CODEMP FROM CADEMP WHERE TRUE');
      Add(fStrLocateEmpresa(edtCodEmpresa, arrEmp, 'EMP_CODEMP', 'CODEMP'));

      pSetaParam(edtCodEmpresa.Text, arrEmp, strCodEmp, 'CODEMP', qryCadEmp);
      Open;

      While Not Eof Do
      Begin
        cdsTotais.AggregatesActive := False;

        cdsItens.Filter   := 'CODEMP = ' + QuotedStr(FieldByName('EMP_CODEMP').AsString);
        cdsItens.Filtered := True;

        pProcessaItens;
        Next;
      End;
    End;

    FreeAndNil(qryCadEmp);
  End;

begin
  {**************************************************}
  {* O CALCULO SEMPRE SERA FEITO PARA O CAIXA 1 E 2 *}
  {***********************************************LU*}
  pnlInfo.Caption := 'Calculando nível de giro ' + IfThen(blnGeral, 'geral', 'por empresa') + '...';
  Application.ProcessMessages;

  btnGerar.Enabled := False;
  btnSair.Enabled := False;

  qryGen := fCriaQuery(Self);
  qryUpd := fCriaQuery;

  cdsItens := TUniClientDataSet.Create(Self);
  dspItens := TUniDataSetProvider.Create(Self);
  cdsItens.DisableControls;

  cdsTotais := TUniClientDataSet.Create(Self);

  Try

    pgbStatus.Position := 0;
    pgbStatus.Visible  := True;
    Application.ProcessMessages;

    pIniciaNivelGiro(blnGeral);

    strSQL := '';
    strSQL := strSQL + ' SELECT ';

    If Not blnGeral Then
      strSQL := strSQL + '   CODEMP, ';

    strSQL := strSQL + '   CODITE, ';
    strSQL := strSQL + '   DESITE, ';
    strSQL := strSQL + '   REFERE, ';
    strSQL := strSQL + '   SUM(QTDITE) AS QTDITE, ';
    strSQL := strSQL + '   VALEST, ';
    strSQL := strSQL + '   SALEST, ';
    strSQL := strSQL + '   SUM(TOTITE) AS TOTITE, ';
    strSQL := strSQL + '   SUM(TOTCUS) AS TOTCUS, ';
    strSQL := strSQL + '   (PESLIT * SUM(QTDITE)) AS PESLIT ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   ( ';
    strSQL := strSQL + '     SELECT SQL_NO_CACHE ';

    If Not blnGeral Then
      strSQL := strSQL + '       G.ITE_CODEMP AS CODEMP, ';

    strSQL := strSQL + '       I.ITE_CODITE AS CODITE, ';
    strSQL := strSQL + '       I.ITE_DESITE AS DESITE, ';
    strSQL := strSQL + '       I.ITE_REFERE AS REFERE, ';
    strSQL := strSQL + '       U.UNI_PESLIT AS PESLIT, ';
    strSQL := strSQL + '       SUM(IF(LEFT(D.DET_CLAFIS,1) < 5, -1, 1 ) * IF(DET_ESPDOC = "ML", D.DET_QTDITE / IF(IFNULL(I.ITE_CNV_ML, 0) = 0, 1,I.ITE_CNV_ML) ,D.DET_QTDITE)) AS QTDITE, ';
    strSQL := strSQL + '       SUM(IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0, IF(LEFT(D.DET_CLAFIS,1) < 5, -(D.DET_TOTITE - D.DET_DESESP - D.DET_DESCFF) , (D.DET_TOTITE - D.DET_DESESP - D.DET_DESCFF)))) AS TOTITE, ';
    strSQL := strSQL + '       SUM(ITE_PRECUS * ITE_SALDOS) AS VALEST, ';
    strSQL := strSQL + '       SUM(ITE_SALDOS) AS SALEST, ';
    strSQL := strSQL + '       SUM(IF(LEFT(D.DET_CLAFIS,1) < 5, -D.DET_TOTCUS , D.DET_TOTCUS)) AS TOTCUS ';
    strSQL := strSQL + '     FROM ';
    strSQL := strSQL + '       CADITE I ';
    strSQL := strSQL + '       JOIN MOVDET       D ON D.DET_CODITE = I.ITE_CODITE ';
    strSQL := strSQL + '       INNER JOIN CADUNI U ON I.ITE_CODUNI = U.UNI_CODUNI ';
    strSQL := strSQL + '       INNER JOIN ITEGER G ON G.ITE_CODITE = D.DET_CODITE ';
    strSQL := strSQL + '                          AND G.ITE_CODEMP = D.DET_CODEMP ';
    strSQL := strSQL + '     WHERE ';
    strSQL := strSQL + '       DET_CODCLI NOT IN (' + VS_strCliFil + ') AND ';
    strSQL := strSQL + '       D.DET_TIP_FC = "C" AND ';
    strSQL := strSQL + '       D.DET_PROEMB <> "S" AND ';
    strSQL := strSQL + '       D.DET_DTAENT BETWEEN :DTAINI AND :DTAFIN AND ';
    strSQL := strSQL + '       ((LOCATE(DET_CLAFIS, :CLAFIS) > 0) OR (LOCATE(DET_CLAFIS, :CLADEV) > 0) ';
    strSQL := strSQL + '       OR (LOCATE(DET_CLAFIS , "5999_1999") > 0 AND DET_ESPDOC = "ML" AND DET_TIPFAT IN ("NF", "NV", "IF", "IV")) ';

    If fCfgSis('ENTBRF', varBoolean) Then
      strSQL := strSQL + ' OR (DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + ')) '
    Else
      strSQL := strSQL + ') ';

    strSQL := strSQL + fStrLocate(edtCodEmpresa,        arrEmp,        'D.DET_CODEMP', 'CODEMP');
    strSQL := strSQL + fStrLocate(edtFornecedor,        arrFornecedor, 'I.ITE_CODFOR', 'CODFOR');
    strSQL := strSQL + fStrLocate(edtMarca,             arrMarca,      'I.ITE_CODMAR', 'CODMAR');
    strSQL := strSQL + fStrLocate(edtPrdGru,            arrGrupoPro,   'I.ITE_PRDGRU', 'PRDGRU');
    strSQL := strSQL + fStrLocateLinGru(mskLinhaGrupo,  arrLinhaGrupo, 'I.ITE_CODGRU', 'CODGRU');

    strSQL := strSQL + '     GROUP BY ';

    If Not blnGeral Then
      strSQL := strSQL + ' G.ITE_CODEMP, ';

    strSQL := strSQL + '     I.ITE_CODITE ';

    strSQL := strSQL + '   ) AS TAB1 ';

    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   TOTITE IS NOT NULL AND ';
    strSQL := strSQL + '   TOTCUS IS NOT NULL ';

    strSQL := strSQL + ' GROUP BY ';

    If Not blnGeral Then
      strSQL := strSQL + ' CODEMP, ';

    strSQL := strSQL + '   CODITE ';

    strSQL1 := '';
    strSQL1 := strSQL1 + 'SELECT ';

    If Not blnGeral Then
      strSQL1 := strSQL1 + '   CODEMP, ';

    strSQL1 := strSQL1 + '  CODITE, ';
    strSQL1 := strSQL1 + '  DESITE, ';
    strSQL1 := strSQL1 + '  REFERE, ';
    strSQL1 := strSQL1 + '  SUM(QTDITE) AS QTDITE, ';
    strSQL1 := strSQL1 + '  SUM(VALEST) AS VALEST, ';
    strSQL1 := strSQL1 + '  SUM(SALEST) AS SALEST, ';
    strSQL1 := strSQL1 + '  SUM(TOTITE) AS TOTITE, ';
    strSQL1 := strSQL1 + '  SUM(TOTCUS) AS TOTCUS, ';
    strSQL1 := strSQL1 + '  (PESLIT * SUM(QTDITE)) AS PESLIT ';
    strSQL1 := strSQL1 + '  FROM ';
    strSQL1 := strSQL1 + '  ( ' + strSQL + ' ) AS TABTOTAL ';

    strSQL1 := strSQL1 + ' GROUP BY ';

    If Not blnGeral Then
      strSQL1 := strSQL1 + ' CODEMP, ';

    strSQL1 := strSQL1 + '   CODITE ';
    strSQL1 := strSQL1 + ' ORDER BY ';

    If edtOrdem.Text = 'Q' Then
      strSQL1 := strSQL1 + '  QTDITE DESC, TOTITE DESC '
    Else If edtOrdem.Text = 'V' Then
      strSQL1 := strSQL1 + '  TOTITE DESC, QTDITE DESC '
    Else If edtOrdem.Text = 'L' Then
      strSQL1 := strSQL1 + '  PESLIT DESC, TOTITE DESC ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL1);
      ParamByName('DTAINI').AsDate   := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDate   := StrToDate(mskDtaFin.Text);
      ParamByName('CLAFIS').AsString := VS_strClaVen;
      ParamByName('CLADEV').AsString := VS_strClaDev;

      pSetaParam(edtCodEmpresa.Text, arrEmp,        strCodEmp, 'CODEMP', qryGen);
      pSetaParam(mskLinhaGrupo.Text, arrLinhaGrupo, strLinGru, 'CODGRU', qryGen);
      pSetaParam(edtFornecedor.Text, arrFornecedor, strLinFor, 'CODFOR', qryGen);
      pSetaParam(edtMarca.Text,      arrMarca,      strLinMar, 'CODMAR', qryGen);
      pSetaParam(edtPrdGru.Text,     arrGrupoPro,   strPrdGru, 'PRDGRU', qryGen);

      Open;
    End;

    pSetaClient(qryGen);

    dspItens.DataSet := qryGen;
    cdsItens.Close;
    cdsItens.SetProvider(dspItens);
    cdsItens.Open;

    If cdsItens.IsEmpty Then
    Begin
      pnlInfo.Caption   := '';

      blnSemDados := True;

      pSetFocus(mskDtaIni);

      Result := False;
    End
    Else
    Begin

      pgbStatus.Max := cdsItens.RecordCount;

     {**************************************************************************}
     {* SOMATORIO DO TOTITE PARA O CALCULO DO PERCENTUAL DE REPRESENTATIVIDADE *}
     {***********************************************************************LU*}
      With TAggregateField.Create(Self) Do
      Begin
        Name          := 'TOTAL';
        FieldName     := 'TOTAL';
        DataSet       := cdsTotais;
        Expression    := 'SUM(' + fRetCampoCalc + ')';
        Active        := True;
      End;

      If blnGeral Then
        pProcessaItens
      Else
        pProcessaItensPorEmpresa;

      Result := True;
    End;

  Finally
    FreeAndNil(qryGen);
    FreeAndNil(qryUpd);
    FreeAndNil(cdsItens);
    FreeAndNil(dspItens);
    FreeAndNil(cdsTotais);
  End;
end;


procedure TfrmCalNivGirEst.btnGerarClick(Sender: TObject);
  Var
    blnCalc1, blnCalc2: Boolean;
begin
  inherited;

  If fVerificaCampos And (fMensagem('AVISO', 'Confirma Cálculo do Nível de Giro de Estoque?', ['&Sim', '&Não']) = 1) Then
  Begin
    blnSemDados := False;

    blnCalc1 := fCalculaNivelGiro(True);
    blnCalc2 := fCalculaNivelGiro(False);

    If blnSemDados Then
      fMensagem('','Não há dados para calcular o Nível do Giro de Estoque.', ['&O K']);

    btnGerar.Enabled  := True;
    btnSair.Enabled   := True;
    pgbStatus.Visible := False;

    pnlInfo.Caption   := '';

    If blnCalc1 And blnCalc2 Then
      fMensagem('','Cálculo do Nível do Giro de Estoque efetuado com sucesso.', ['&O K']);
  End;

  pSetFocus(mskDtaIni);
end;

procedure TfrmCalNivGirEst.FormShow(Sender: TObject);
begin
  mskDtaIni.Text := DateToStr(VS_Date);
  mskDtaFin.Text := DateToStr(VS_Date);

  edtCodEmpresa.Text := VS_strCodEmp;
  edtDesEmpresa.Text := fRetNomeEmpresa(edtCodEmpresa.Text);

  pSetFocus(mskDtaIni);
  
  inherited;
end;

procedure TfrmCalNivGirEst.ceValNiAEnter(Sender: TObject);
begin
  inherited;
  ceValNB2.Enabled := True;
end;

end.
