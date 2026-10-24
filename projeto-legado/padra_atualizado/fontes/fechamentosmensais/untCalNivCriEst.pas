unit untCalNivCriEst;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, CheckLst, ComCtrls, EditFocus, AppEvnts, Menus,
  Buttons, ExtCtrls, CurrencyEditFocus, untTypesSistema, QColorLabel, Mask,
  MaskEditFocus, Uni, untFuncoesSimples, StrUtils, DB, UniClientDataSet,
  UniDataSetProvider, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxTextEdit, cxCurrencyEdit, cxProgressBar;

type
  TfrmCalNivCriEst = class(TfrmPai)
    pnlFundo: TPanel;
    Label1: TLabel;
    edtFornecedor: TEditFocus;
    edtDesFornecedor: TEditFocus;
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
    procedure pCarregaGrupo;
    procedure pCarregaFornecedor;
    procedure pCarregaMarca;
    procedure pCarregaEmpresa(qryCadEmp: TUniQuery);
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
  private
    { Private declarations }
    arrLinhaGrupo: TConsultasArray;
    arrFornecedor: TConsultasArray;
    arrMarca     : TConsultasArray;
    fltSomaGeral : Double;

    strLinGru: String;
    strLinFor: String;
    strLinMar: String;

    blnSemDados,
    FGeral: Boolean;

    Procedure pIniciaNivelGiro(blnGeral: Boolean);

    Function fCalculaNivelGiro(blnGeral: Boolean): Boolean;

    Function fCalculaNivelGiroPrg(prgProgresso: TcxProgressBar): Boolean;

  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  end;

implementation

uses  untConsultas, untFuncoesConsulta, untConstantes, untGravando;

{$R *.dfm}

function TfrmCalNivCriEst.fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean;
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
    {* VALIDA EMPRESA             *}
    {***************************LU*}
    Else If (Sender = edtCodEmpresa) Then
    Begin
      If fEmptyStr(edtCodEmpresa.Text) Then
      Begin
        edtDesEmpresa.Text := 'TODAS'
      End
      Else
      Begin

        edtDesEmpresa.Text := fRetNomeEmpresaSelec(edtCodEmpresa.Text);

        If fEmptyStr(edtDesEmpresa.Text) Then
        Begin
          fMensagem('AVISO','Código da empresa não encontrado.', ['&O K']);
          Result := False;
        End
        Else If Pos(edtCodEmpresa.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
          Result := False;
        End;

      End;

    End

    {******************************}
    {* VALIDA OOS NIVEIS          *}
    {***************************LU*}
    Else If (Sender = ceValNiA) Then
    Begin
      If fEmptyStr(ceValNiA.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O percentual do nível Z deve ser preenchido!',['&O K']);
        Result := False;
      End
      Else
        ceValNB1.Text := FloatToStr(fStrToFloat(ceValNiA.Text) + 0.01);
    End
    Else If (Sender = ceValNB1) Then
    Begin
      If fEmptyStr(ceValNB1.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O percentual inicial do nível Y deve ser preenchido!',['&O K']);
        Result := False;
      End;
    End
    Else If (Sender = ceValNB2) Then
    Begin
      If fEmptyStr(ceValNB2.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O percentual final do nível X deve ser preenchido!',['&O K']);
        Result := False;
      End
      Else
      Begin
        ceValNiC.Text := FloatToStr(fStrToFloat(ceValNB2.Text));

       // ceValNB2.Enabled := False;
      End;
    End
    Else If (Sender = ceValNiC) Then
    Begin
      If fEmptyStr(ceValNiC.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O percentual do nível X deve ser preenchido!',['&O K']);
        Result := False;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmCalNivCriEst.mskLinhaGrupoKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrGrupos: TConsultasArray;
begin
  inherited;
  {********************************}
  {* NOVA CONSULTA DE LINHA/GRUPO *}
  {*****************************RV*}
  If fPesqGrupo(Self, mskLinhaGrupo, edtDesGrupo, Nil, Key, arrGrupos) Then
  Begin
    If fValidaCampos(mskLinhaGrupo, False) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCalNivCriEst.mskLinhaGrupoExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(mskLinhaGrupo,edtDesGrupo,arrLinhaGrupo,fRetNomeLinhaGrupo,Nil,'da linha/grupo',6);
end;

procedure TfrmCalNivCriEst.pCarregaGrupo;
Begin
  pCarrega(mskLinhaGrupo.Text,edtDesGrupo,arrLinhaGrupo);
End;

procedure TfrmCalNivCriEst.pCarregaEmpresa(qryCadEmp: TUniQuery);
Begin
  If Not (fEmptyStr(edtCodEmpresa.Text)) Then
    edtDesEmpresa.Text := qryCadEmp.FieldByName('EMP_NOMEMP').AsString
  Else
    edtDesEmpresa.Text := 'TODAS';
End;

procedure TfrmCalNivCriEst.pCarregaFornecedor;
Begin
  pCarrega(edtFornecedor.Text,edtDesFornecedor,arrFornecedor);
End;

procedure TfrmCalNivCriEst.pCarregaMarca;
Begin
  pCarrega(edtMarca.Text,edtDesMarca,arrMarca);
End;

procedure TfrmCalNivCriEst.edtFornecedorKeyPress(Sender: TObject;
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

procedure TfrmCalNivCriEst.edtFornecedorExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtFornecedor,edtDesFornecedor,arrFornecedor,fRetNomFornecedor,nil,'do Fornecedor');
end;

procedure TfrmCalNivCriEst.edtMarcaKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrMarca : TConsultasArray;
begin
  inherited;

  {***************************}
  {* NOVA CONSULTA DE MARCAS *}
  {************************DP*}
  If fPesqMarcas(Self, edtMarca, edtDesMarca, Nil, Key, arrMarca) Then
  Begin
    If fValidaCampos(edtMarca, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCalNivCriEst.edtMarcaExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtMarca,edtDesMarca,arrMarca,fRetNomMarca,nil,'da Marca');
end;

procedure TfrmCalNivCriEst.edtCodEmpresaKeyPress(Sender: TObject;
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

Procedure TfrmCalNivCriEst.pIniciaNivelGiro(blnGeral: Boolean);
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
      SQL.Add(' UPDATE CADITE I SET I.ITE_NVLCRI = "X"');
      SQL.Add(' WHERE TRUE ');
    End Else
    Begin
      SQL.Add(' UPDATE ITEGER G');
      SQL.Add(' INNER JOIN CADITE I ON I.ITE_CODITE = G.ITE_CODITE');
      SQL.Add(' SET G.ITE_NIVCRI = "X"');
      SQL.Add(' WHERE TRUE ');

      If (Not fEmptyStr(edtCodEmpresa.Text)) Then
        SQL.Add('  AND G.ITE_CODEMP = ' + QuotedStr(edtCodEmpresa.Text))
      Else
        SQL.Add('  AND LOCATE(G.ITE_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ');
    End;

    SQL.Add(fStrLocate(edtFornecedor, arrFornecedor, 'I.ITE_CODFOR', 'CODFOR'));

    SQL.Add(fStrLocate(edtMarca, arrMarca, 'I.ITE_CODMAR','CODMAR'));

    SQL.Add(fStrLocateLinGru(mskLinhaGrupo, arrLinhaGrupo, 'I.ITE_CODGRU','CODGRU'));

    pSetaParam(mskLinhaGrupo.Text, arrLinhaGrupo, strLinGru, 'CODGRU', qryCadIte);

    pSetaParam(edtFornecedor.Text, arrFornecedor, strLinFor, 'CODFOR', qryCadIte);

    pSetaParam(edtMarca.Text, arrMarca, strLinMar, 'CODMAR', qryCadIte);

    ExecSQL;
  End;
  FreeAndNil(qryCadIte);
End;

Function TfrmCalNivCriEst.fCalculaNivelGiro(blnGeral: Boolean): Boolean;
Begin
  Try
    FGeral := blnGeral;

    pCriarFormularios(TfrmGravando, frmGravando);

    With frmGravando Do
    Begin
      fExecutarAcao := fCalculaNivelGiroPrg;

      lblGravando.Caption := 'Calculando nível de criticidade ' + IfThen(blnGeral, 'geral', 'por empresa') + '...';

      ShowModal;

      Result := blnConfirma;
    End;

  Except

    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, 'TfrmCalNivCriEst.fCalculaNivelGiro');
    End;

  End;

  FreeAndNil(frmGravando);
End;

Function TfrmCalNivCriEst.fCalculaNivelGiroPrg(prgProgresso: TcxProgressBar): Boolean;
Var
  strSQL   : String;

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

  Procedure pProcessaItens(strCodEmp: String);
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

    prgProgresso.Position := 0;
    prgProgresso.Properties.Max := cdsItens.RecordCount;

    frmGravando.lblGravando.Caption := 'Calculando nível';

    If (Not fEmptyStr(strCodEmp)) Then
      frmGravando.lblGravando.Caption := frmGravando.lblGravando.Caption + ' da empresa ' + strCodEmp + '...'
    Else
      frmGravando.lblGravando.Caption := frmGravando.lblGravando.Caption + ' geral ...';

    Application.ProcessMessages;

    cdsItens.First;

    While Not cdsItens.Eof Do
    Begin
      Application.ProcessMessages;

      If fltSomaGeral > 0 Then
        fltRepIte := (cdsItens.fieldbyname('QTDDOC').AsInteger / fltSomaGeral) * 100
      Else
        fltRepIte := 0;

      fltTotRep := fltTotRep + fltRepIte;

      If fltTotRep <= fltNivA Then
        strNivel := 'Z'
      Else If (fltTotRep <= fltNivB2) Then
        strNivel := 'Y'
      Else If fltTotRep > fltNivC Then
        strNivel := 'X';

      With qryUpd Do
      Begin
        Close;
        SQL.Clear;

        If FGeral Then
        Begin
          SQL.Add(' UPDATE CADITE SET ITE_NVLCRI = :NVLCRI WHERE ITE_CODITE = :CODITE ')
        End Else
        Begin
          SQL.Add(' UPDATE ITEGER SET ITE_NIVCRI = :NVLCRI WHERE ITE_CODITE = :CODITE AND ITE_CODEMP = :CODEMP');

          ParamByName('CODEMP').AsString := cdsItens.fieldbyname('CODEMP').AsString;
        End;

        ParamByName('NVLCRI').AsString := strNivel;
        ParamByName('CODITE').AsString := cdsItens.fieldbyname('CODITE').AsString;
        ExecSQL;
      End;

      cdsItens.Next;

      prgProgresso.Position := prgProgresso.Position + 1;
      Application.ProcessMessages;
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

      If (Not fEmptyStr(edtCodEmpresa.Text)) Then
        SQL.Add('  AND EMP_CODEMP = ' + QuotedStr(edtCodEmpresa.Text))
      Else
        SQL.Add('  AND LOCATE(EMP_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ');

      Open;

      While Not Eof Do
      Begin
        cdsTotais.AggregatesActive := False;

        cdsItens.Filter   := 'CODEMP = ' + QuotedStr(FieldByName('EMP_CODEMP').AsString);
        cdsItens.Filtered := True;

        pProcessaItens(FieldByName('EMP_CODEMP').AsString);
        Next;
      End;
    End;

    FreeAndNil(qryCadEmp);
  End;

begin
  btnGerar.Enabled := False;
  btnSair.Enabled := False;

  qryGen := fCriaQuery(Self);
  qryUpd := fCriaQuery;

  cdsItens := TUniClientDataSet.Create(Self);
  dspItens := TUniDataSetProvider.Create(Self);
  cdsItens.DisableControls;

  cdsTotais := TUniClientDataSet.Create(Self);

  Try

    prgProgresso.Position := 0;

    frmGravando.lblGravando.Caption := 'Incializando nível de criticidade';

    If (Not fEmptyStr(edtCodEmpresa.Text)) Then
      frmGravando.lblGravando.Caption := frmGravando.lblGravando.Caption + ' da empresa ' + edtCodEmpresa.Text + '...'
    Else
      frmGravando.lblGravando.Caption := frmGravando.lblGravando.Caption + ' de todas as empresas ...';

    Application.ProcessMessages;

    pIniciaNivelGiro(FGeral);

    frmGravando.lblGravando.Caption := 'Contando tickets';

    If (Not fEmptyStr(edtCodEmpresa.Text)) Then
      frmGravando.lblGravando.Caption := frmGravando.lblGravando.Caption + ' da empresa ' + edtCodEmpresa.Text + '...'
    Else
      frmGravando.lblGravando.Caption := frmGravando.lblGravando.Caption + ' de todas as empresas ...';

    Application.ProcessMessages;

    strSQL := strSQL + '     SELECT ';

    If Not FGeral Then
      strSQL := strSQL + '       DET_CODEMP AS CODEMP, ';

    strSQL := strSQL + '       I.ITE_CODITE AS CODITE, ';
    strSQL := strSQL + '       COUNT(DISTINCT DET_SEQGER) AS QTDDOC ';

    strSQL := strSQL + '     FROM ';

    strSQL := strSQL + '       CADITE I ';
    strSQL := strSQL + '       JOIN MOVDET D ON D.DET_CODITE = I.ITE_CODITE ';

    strSQL := strSQL + '     WHERE ';
    strSQL := strSQL + '       DET_CODCLI NOT IN (' + VS_strCliFil + ') AND ';
    strSQL := strSQL + '       D.DET_TIP_FC = "C" AND ';
    strSQL := strSQL + '       D.DET_PROEMB <> "S" AND ';
    strSQL := strSQL + '       D.DET_DTAENT BETWEEN :DTAINI AND :DTAFIN AND ';
    strSQL := strSQL + '       ((LOCATE(DET_CLAFIS, :CLAFIS) > 0) ';

    If fCfgSis('ENTBRF', varBoolean) Then
      strSQL := strSQL + ' OR (DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + ')) '
    Else
      strSQL := strSQL + ') ';

    If (Not fEmptyStr(edtCodEmpresa.Text)) Then
      strSQL := strSQL + '  AND D.DET_CODEMP = :CODEMP '
    Else
      strSQL := strSQL + '  AND LOCATE(D.DET_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';

    strSQL := strSQL + fStrLocate(edtFornecedor, arrFornecedor, 'I.ITE_CODFOR', 'CODFOR');

    strSQL := strSQL + fStrLocate(edtMarca, arrMarca, 'I.ITE_CODMAR', 'CODMAR');

    strSQL := strSQL + fStrLocateLinGru(mskLinhaGrupo, arrLinhaGrupo, 'I.ITE_CODGRU', 'CODGRU');

    strSQL := strSQL + '     GROUP BY ';

    If Not FGeral Then
      strSQL := strSQL + '    DET_CODEMP, ';

    strSQL := strSQL + '       I.ITE_CODITE ';

    strSQL := strSQL + ' ORDER BY ';

    strSQL := strSQL + '  QTDDOC DESC ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('DTAINI').AsDate   := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDate   := StrToDate(mskDtaFin.Text);
      ParamByName('CLAFIS').AsString := VS_strClaVen;

      If (Not fEmptyStr(edtCodEmpresa.Text)) Then
        ParamByName('CODEMP').AsString := edtCodEmpresa.Text;

      pSetaParam(mskLinhaGrupo.Text, arrLinhaGrupo, strLinGru, 'CODGRU', qryGen);

      pSetaParam(edtFornecedor.Text, arrFornecedor, strLinFor, 'CODFOR', qryGen);

      pSetaParam(edtMarca.Text, arrMarca, strLinMar, 'CODMAR', qryGen);

      Open;
    End;

    pSetaClient(qryGen);

    dspItens.DataSet := qryGen;
    cdsItens.Close;
    cdsItens.SetProvider(dspItens);
    cdsItens.Open;

    If cdsItens.IsEmpty Then
    Begin
      blnSemDados := True;

      Result := False;

      pSetFocus(mskDtaIni);
    End Else
    Begin

      With TAggregateField.Create(Self) Do
      Begin
        Name          := 'TOTAL';
        FieldName     := 'TOTAL';
        DataSet       := cdsTotais;
        Expression    := 'SUM(QTDDOC)';
        Active        := True;
      End;

      If FGeral Then
        pProcessaItens('')
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

procedure TfrmCalNivCriEst.btnGerarClick(Sender: TObject);
  Var
    blnCalc1,
    blnCalc2: Boolean;
begin
  inherited;

  If fVerificaCampos And (fMensagem('AVISO', 'Confirma Cálculo do Nível de Criticidade de Estoque?', ['&Sim', '&Não']) = 1) Then
  Begin
    blnSemDados := False;

    blnCalc1 := fCalculaNivelGiro(True);

    blnCalc2 := fCalculaNivelGiro(False);

    If blnSemDados Then
      fMensagem('', 'Não há dados para calcular o Nível do Criticidade de Estoque.', ['&O K']);

    btnGerar.Enabled  := True;
    btnSair.Enabled   := True;

    pnlInfo.Caption   := '';

    If blnCalc1 And blnCalc2 Then
      fMensagem('','Cálculo do Nível de Criticidade de Estoque efetuado com sucesso.', ['&O K']);
  End;

  pSetFocus(mskDtaIni);
end;

procedure TfrmCalNivCriEst.FormShow(Sender: TObject);
begin
  mskDtaIni.Text := DateToStr(VS_Date);
  mskDtaFin.Text := DateToStr(VS_Date);

  edtCodEmpresa.Text := VS_strCodEmp;
  edtDesEmpresa.Text := fRetNomeEmpresa(edtCodEmpresa.Text);

  pSetFocus(mskDtaIni);
  
  inherited;
end;

procedure TfrmCalNivCriEst.ceValNiAEnter(Sender: TObject);
begin
  inherited;
  ceValNB2.Enabled := True;
end;

end.
