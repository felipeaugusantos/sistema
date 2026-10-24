unit untCadCentroCusto;

interface

uses
  Classes, Controls, Forms, untTLock, StdCtrls, untPaiCad, ComCtrls, Buttons, ExtCtrls,
  DBCtrls, DBEditFocus, Menus, ComboBoxFocus, Db, Uni, AppEvnts, BitBtnLockedIncrem,
  Mask, frxClass, frxExportCSVTestabilidade, EditFocus, untTypesSistema, Windows,
  Variants, QColorLabel, Datasnap.DBClient, UniClientDataSet;

type
  TfrmCadCentroCusto = class(TfrmPaiCad)
    dbeCodCta: TDBEditFocus;
    Label1: TLabel;
    Label2: TLabel;
    dbeDesCta: TDBEditFocus;
    pnlFundo: TPanel;
    Label3: TLabel;
    cbbTipCta: TComboBoxFocus;
    dtsCadCta: TDataSource;
    lblDesPlaCon: TLabel;
    dbeConCon: TDBEditFocus;
    dbchkEntRel: TDBCheckBox;
    lbl1: TLabel;
    cbbClaCta: TComboBoxFocus;
    btnRateios: TBitBtnLocked;
    dbchkDesmembr: TDBCheckBox;
    btnDesmembr: TBitBtnLocked;
    Label5: TLabel;
    edtCtaRes: TEditFocus;
    edtDesResultado: TEditFocus;
    Label6: TLabel;
    cbbEntraRelComo: TComboBoxFocus;
    dbchkExpAut: TDBCheckBox;
    dbePlaNco: TDBEditFocus;
    edtDesPlaNco: TEditFocus;
    btnPlaNco: TBitBtnLocked;
    chkProCon: TDBCheckBox;
    dbePlaRes: TDBEditFocus;
    edtDesPlaRes: TEditFocus;
    lblPlaRes: TLabel;
    dbeCodRes: TDBEditFocus;
    Label4: TLabel;
    dbeStatus: TDBEditFocus;
    ColorLabel1: TColorLabel;
    Label37: TLabel;
    rdgRegimeDRE: TDBRadioGroup;
    dbchkPerBaiCar: TDBCheckBox;
    dbchkPerBaiChe: TDBCheckBox;
    dbchkPerBaiRec: TDBCheckBox;
    dbchkPerBaiPag: TDBCheckBox;
    pnlHis: TPanel;
    lblHisCon: TLabel;
    edtDesHisCon: TEditFocus;
    dbeHisCon: TDBEditFocus;
    grbDespesasFinanceiras: TGroupBox;
    dbeChkUtlDespesasFinanceiras: TDBCheckBox;
    pnlDespesasFinanceiras: TPanel;
    lblBCCrePisCofins: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label11: TLabel;
    Label9: TLabel;
    dbeCbcCre: TDBEditFocus;
    dbeAlqPis: TDBEditFocus;
    dbeCstPis: TDBEditFocus;
    dbeAlqCof: TDBEditFocus;
    dbeCstCof: TDBEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnRateiosClick(Sender: TObject);
    procedure cbbTipCtaChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnDesmembrClick(Sender: TObject);
    procedure dbchkDesmembrClick(Sender: TObject);
    procedure dtsCadCtaStateChange(Sender: TObject);
    procedure edtCtaResKeyPress(Sender: TObject; var Key: Char);
    procedure edtCtaResExit(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtCtaResEnter(Sender: TObject);
    procedure dbePlaNcoKeyPress(Sender: TObject; var Key: Char);
    procedure btnPlaNcoClick(Sender: TObject);
    procedure chkProConClick(Sender: TObject);
    procedure dbePlaResKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
    procedure dbeHisConKeyPress(Sender: TObject; var Key: Char);
    procedure dbeChkUtlDespesasFinanceirasClick(Sender: TObject);
    procedure dbeCstPisKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCstCofKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCbcCreKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    arrSel : TConsultasArray;
    strCtaResAnt: String;
    blnUtiCon : Boolean;
    AContaResultadoInicial: String;
    FcdsNCO : TUniClientDataset;

    FobjLock: TLock;

    function fPodeExcluirLinha(strLinha: String): Boolean;
    function fPodeExcluirGrupo(strLinha: String): Boolean;
    procedure pAtuTipCta;
    function fExisteConContabil: String;
    procedure pCarregaCtaRes;
    procedure pAfterOpen(DataSet: TDataSet);
    procedure pCarregaPlanoContabil(const blnBuscaPorChave: Boolean=False);
    procedure pCarregaPlanoResultado(const blnBuscaPorChave: Boolean=False);
    procedure pCarregaHistorico;
    procedure SelecionaPlanoDeConta(const ACodCta: String);
    procedure pVisibilidadeContaResultado(blnVisible: boolean);
    procedure HabilitaDesabilitaDespesasFinanceiras(AHabilitar: Boolean);
    procedure LimparCamposDespesasFinanceiras;
    procedure FormataCamposDespesasFinanceiras;
    procedure pAfterScroll(DataSet: TDataSet);
    procedure ShowRegimeDRE;
    procedure ExcluirContaResultado;
    function PodeExcluirContaResultado:Boolean;
    procedure DestravarRegistro;
    function RegistroEmUsoPorOutraEstacao: Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
    function fExecutaAntesDoDelete: Boolean; override;
  public
    { Public declarations }
    strCodCta: String;
  end;

implementation

uses SysUtils, StrUtils, untfuncoesSimples, untPai, untCadCtaDet, untCadCta,
     untConsultas, untDesmCtaEmpCContabil, untFuncIns, Contabilidade.Consultas,
     Contabilidade.Funcoes,untFuncoes;

{$R *.dfm}

procedure TfrmCadCentroCusto.FormCreate(Sender: TObject);
begin
  inherited;
  FcdsNCO := fCriaEstruturaCdsNCO(Nil);
  strNomeTabela         := 'CADCTA';
  strNomeCampo          := 'CTA_CODCTA';
  qryTabela             := fCriaQuery(Self);
  dtsCadCta.DataSet     := qryTabela;
  qryTabela.AfterOpen   := pAfterOpen;
  qryTabela.AfterScroll := pAfterScroll;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodCta;

  blnUtiCon := fCfgSis('UTICON', varBoolean);
  FobjLock := TLock.Create;
end;

procedure TfrmCadCentroCusto.FormDestroy(Sender: TObject);
begin
  inherited;
  if Assigned(FcdsNCO) then
    FreeAndNil(FcdsNCO) ;

  FobjLock.pDestravarTodos;
  FreeAndNil(FobjLock);
end;

procedure TfrmCadCentroCusto.pAfterOpen(DataSet: TDataSet);
begin
  If DataSet.FindField('CTA_PLANCO') <> Nil Then
    TStringField(DataSet.FieldByName('CTA_PLANCO')).EditMask := fMskCon;

  If DataSet.FindField('CTA_PLARES') <> Nil Then
    TStringField(DataSet.FieldByName('CTA_PLARES')).EditMask := fMskCon;

  pVisibilidadeContaResultado(DataSet.FieldByName('CTA_PROCON').AsInteger = 1);
end;

procedure TfrmCadCentroCusto.pAfterScroll(DataSet: TDataSet);
begin
  pVisibilidadeContaResultado(DataSet.FieldByName('CTA_PROCON').AsInteger = 1);
  pAtuTipCta;
end;

procedure TfrmCadCentroCusto.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If (Key = VK_INSERT) And (ActiveControl.Name = 'edtCtaRes') Then
    TFuncIns.fChamaCadRes(Key);
end;

procedure TfrmCadCentroCusto.pAtuTipCta;
Begin
  cbbTipCta.ItemIndex := qryTabela.FieldByName('CTA_TIPCTA').AsInteger -1;
  cbbClaCta.ItemIndex := qryTabela.FieldByName('CTA_CLACTA').AsInteger -1;

  If qryTabela.FieldByName('CTA_FLXIMP').AsString = 'I' Then
    cbbEntraRelComo.ItemIndex := 0
  Else If qryTabela.FieldByName('CTA_FLXIMP').AsString = 'D' Then
    cbbEntraRelComo.ItemIndex := 1
  Else If qryTabela.FieldByName('CTA_FLXIMP').AsString = 'F' Then
    cbbEntraRelComo.ItemIndex := 2;

  cbbClaCta.Enabled := (cbbTipCta.ItemIndex in [2,3]) And (qryTabela.State In [dsEdit, dsInsert]);
End;

procedure TfrmCadCentroCusto.SelecionaPlanoDeConta(const ACodCta: String);
begin
  dbeCodCta.Text := ACodCta;
  If fValidaCampos(dbeCodCta, True) And (Not qryTabela.IsEmpty) Then
  Begin
    pCarregaCtaRes;
    AContaResultadoInicial := edtCtaRes.Text;
    pCarregaPlanoContabil;
    pCarregaPlanoResultado;
    pCarregaHistorico;
    pCarregaPlanoDeContasPorEmpresa('CTANCO', dbeCodCta.Text, FcdsNCO);
    pSetFocus(btnAlterar);
  End;
end;

procedure TfrmCadCentroCusto.ShowRegimeDRE;
begin
  rdgRegimeDRE.ItemIndex := 0;
  If Not fCfgSis('REGDRE', varBoolean) Then
  Begin
    rdgRegimeDRE.Visible := False;
    Self.Height := 345 + pnlHis.Height + grbDespesasFinanceiras.Height;
  End;
end;

procedure TfrmCadCentroCusto.pCarregaCtaRes;
  Var
   qryCtaRes: TUniQuery;
   strSQL: String;
begin
  Try
    qryCtaRes := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   * ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   CTAGER G ';
    strSQL := strSQL + ' JOIN CTARES R ON (R.CRE_CODCRE = G.CRE_CODCRE) ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   CRE_CODCTA = :CODCTA';

    With qryCtaRes Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODCTA').AsString := qryTabela.FieldByName('CTA_CODCTA').AsString;
      Open;

      If Not IsEmpty Then
      Begin
        edtCtaRes.Text       := FieldByName('CRE_CODCRE').AsString;
        edtDesResultado.Text := FieldByName('CRE_DESCRE').AsString;
        strCtaResAnt         := FieldByName('CRE_CODCRE').AsString;
      End
      Else
      Begin
        edtCtaRes.Text       := '';
        edtDesResultado.Text := '';
        strCtaResAnt         := '';
        edtDesPlaNco.Clear;
      End;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmCadCentroCusto.pCarregaCtaRes]');
      FreeAndNil(qryCtaRes);
      Exit;
    End;
  End;

  FreeAndNil(qryCtaRes);
end;

procedure TfrmCadCentroCusto.pCarregaHistorico;
begin
  edtDesHisCon.Text := '';
  if edtDesHisCon.Visible then
  begin
    edtDesHisCon.Text := fCampoTabela('PAD_DESCRI', 'HISPAD', ['PAD_CODIGO'], [dbeHisCon.Text], False);
  end;
end;

procedure TfrmCadCentroCusto.pCarregaPlanoContabil(const blnBuscaPorChave: Boolean=False);
begin
  If (edtDesPlaNco.Visible) Then
  begin
    edtDesPlaNco.Text := fCampoTabelaPlanco('NCO_DESCRI', ['NCO_CODCON'], [fSemMascaraPlaNco(dbePlaNco.Text)], False);
  end;
end;

procedure TfrmCadCentroCusto.pCarregaPlanoResultado(const blnBuscaPorChave: Boolean=False);
begin
  edtDesPlaRes.Text := '';
  if (edtDesPlaRes.Visible) then
  begin
    edtDesPlaRes.Text := fCampoTabelaPlanco('NCO_DESCRI', ['NCO_CODCON'], [fSemMascaraPlaNco(dbePlaRes.Text)], False);
  end;
end;

function TfrmCadCentroCusto.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    strContaExistente: String;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    {*****************************************}
    {* VALIDA O CODIGO DA CONTA              *}
    {**************************************MV*}
    If (Sender = dbeCodCta) Then
    Begin
      dbeCodCta.Text := AnsiReplaceText(dbeCodCta.Text, ' ', '');
      If (fEmptyStr(dbeCodCta.Text)) And (dbeCodCta.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do Plano de Contas deve ser preechido!', ['&Ok']);
        Result := False;
      End
      Else If Length(dbeCodCta.Text) <> 7 Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do Plano de Contas deve ter exatamente 7 digitos!', ['&Ok']);
        Result := False;
      End
      Else If Not fVerificaLinhaCadCta(dbeCodCta.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse Plano de Conta não existe! Verifique.', ['&Ok']);
        Result := False;
      End
      Else If Not fVerificaGrupoCadCta(dbeCodCta.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse Plano de Conta não existe! Verifique.', ['&Ok']);
        Result := False;
      End
      {*****************************************}
      {* REALIZA BUSCA PELO CODIGO             *}
      {**************************************MV*}
      Else If (blnBuscaPorChave) Then
      Begin
        If Not fBuscaPorCamposChave Then
        Begin
          pLimparCampos;
          if (qryTabela.State In [dsInsert,dsEdit]) then
            qryTabela.FieldByName('CTA_STATUS').AsString := 'A';
        End
        Else
        Begin
          pCarregaCtaRes;
          AContaResultadoInicial := edtCtaRes.Text;
          cbbTipCtaChange(cbbTipCta);
        End;
      End;

      If (Result) And (qryTabela.State In [dsEdit]) Then
        btnRateios.Enabled := True
      Else
        btnRateios.Enabled := False;

    End

    {**************************************}
    {* VALIDA TIPO DO CENTRO DE CUSTO     *}
    {***********************************AF*}
    Else If (Sender = cbbTipCta) Then
    Begin

      If fEmptyStr(cbbTipCta.Text) Then
      Begin
        fMensagem('','O tipo do Plano de Contas deve ser preeenchido!',['&OK']);
        Result := False;
      End;

    End

    {*****************************************}
    {* VALIDA A DESCRIÇÃO DA CONTA           *}
    {**************************************MV*}
    Else If (Sender = dbeDesCta) Then
    Begin

      If fEmptyStr(dbeDesCta.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Descrição do Plano de Contas deve ser preechida!', ['&Ok']);
        Result := False;
      End;

    End

    Else If (Sender = edtCtaRes) Then
    Begin
      if (qryTabela.State In [dsEdit]) and
         (Not fEmptyStr(AContaResultadoInicial)) then
      begin
        if (AContaResultadoInicial <> edtCtaRes.Text) and
           (Not AlterarContaResultado(AContaResultadoInicial)) then
        begin
          fMensagem('ATENÇÃO!', 'Não será possível desvincular a Conta Resultado desse Plano de Contas, pois, a mesma possui Previsão Mensal cadastrada!', ['&Ok']);
          edtCtaRes.Text := AContaResultadoInicial;
          cbbTipCta.ItemIndex := 2;
          Result := False;
        end;
      end;

      If Not fEmptyStr(edtCtaRes.Text) Then
      Begin
        edtDesResultado.Text := fRetContaResultado(edtCtaRes.Text);

        If fEmptyStr(edtDesResultado.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Contas de Resultado não cadastrado!', ['&Ok']);
          Result := False;
        End;
      End
      Else
        edtDesResultado.Text := '';
    End

    Else If (Sender = dbeConCon) And (dbeConCon.Visible) Then
    Begin

      strContaExistente := fExisteConContabil;
      If Not fEmptyStr(strContaExistente) Then
      Begin
        pgcdados.ActivePage := tbsGeral;
        If fMensagem('', 'Esta Conta Contábil está sendo utilizada por ( ' + strContaExistente +
                     ' ). Deseja continuar?', ['&Sim', '&Não']) = 2 Then
          Result := False;

      End;

    End

    Else If (Sender = dbePlaNco) And (dbePlaNco.Visible) Then
    Begin
      pCarregaPlanoContabil(blnBuscaPorChave);
      If (Not fEmptyStr(dbePlaNco.Text)) And (fEmptyStr(edtDesPlaNco.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Plano contábil inexistente!', ['&OK']);
        Result := False;
      End
      Else If (qryTabela.State In [dsInsert, dsEdit]) Then
      begin
        If fEmptyStr(edtDesPlaNco.Text) Then
          dbePlaNco.Field.Value := Null
        Else
          dbePlaNco.Field.AsString := fSemMascaraPlaNco(dbePlaNco.Text);
      end;
    End

    Else If (Sender = dbePlaRes) And (dbePlaRes.Visible) Then
    Begin
      pCarregaPlanoResultado(blnBuscaPorChave);
      If (Not fEmptyStr(dbePlaRes.Text)) And (fEmptyStr(edtDesPlaRes.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Plano contábil inexistente!', ['&OK']);
        Result := False;
      End
      Else If (qryTabela.State In [dsInsert, dsEdit]) Then
      begin
        If fEmptyStr(edtDesPlaRes.Text) Then
          dbePlaRes.Field.Value := Null
        Else
          dbePlaRes.Field.AsString := fSemMascaraPlaNco(dbePlaRes.Text);
      end;
    End

    Else If (Sender = dbeHisCon) And (pnlHis.Visible) Then
    Begin
      pCarregaHistorico;
      If (Not fEmptyStr(dbeHisCon.Text)) And (fEmptyStr(edtDesHisCon.Text)) Then
      Begin
        fMensagem('ATENÇÃO!','Histórico inexistente!',['&OK']);
        Result := False;
      End
      Else If (qryTabela.State In [dsInsert, dsEdit]) Then
      Begin
        If fEmptyStr(edtDesHisCon.Text) Then
          dbeHisCon.Field.Value := Null;
      End;
    End

    {*****************************************}
    {* VALIDA A SITUAÇÃO DO PLANO DE CONTAS  *}
    {**************************************KM*}
    Else If (Sender = dbeStatus) Then
    Begin
      If fEmptyStr(dbeStatus.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Situação do Plano de Contas deve ser preenchida!', ['&Ok']);
        Result := False;
      End
      Else If (dbeStatus.Text <> 'A') And (dbeStatus.Text <> 'I') Then
      Begin
        fMensagem('ATENÇÃO!', 'A Situação do Plano de Contas deve ser "A" ou "I"', ['&Ok']);
        Result := False;
      End;
    End

    Else If pnlDespesasFinanceiras.Enabled Then
    Begin
      If Sender = dbeCbcCre Then
      Begin
        If Not fEmptyStr(fTiraCaracEspeciais(dbeCbcCre.Text)) Then
        Begin
          If fEmptyStr( fCampoTabela('FIN_DESCRI', 'CBCFIN', ['FIN_CODIGO'], [dbeCbcCre.Text], False)) Then
          Begin
            fMensagem('ATENÇÃO!', 'O Código da Base de Cálculo dos Créditos preenchido não está cadastrado!', ['&OK']);
            Result := False;
          End;
        End;
      End

      Else If Sender = dbeCstPis Then
      Begin
        If fEmptyStr(fTiraCaracEspeciais(dbeCstPis.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'O campo CST de Pis deve ser preenchido!', ['&O k']);
          Result := False;
        End
        Else If fEmptyStr(fRetDesCstPis(dbeCstPis.text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'O CST de Pis preenchido não está cadastrado!', ['&O k']);
          Result := False;
        End;
      End

      Else If Sender = dbeCstCof Then
      Begin
        If fEmptyStr(fTiraCaracEspeciais(dbeCstCof.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'O campo CST de Cofins deve ser preenchido!', ['&O k']);
          Result := False;
        End
        Else If fEmptyStr(fRetDesCstCof(dbeCstCof.text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'O CST de Cofins preenchido não está cadastrado!', ['&O k']);
          Result := False;
        End;
      End

      Else If Sender = dbeAlqPis Then
      Begin
        If (StrToFloatDef(dbeAlqPis.Text,-1) <= 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Alíquota de Pis deve ser maior que 0!', ['&O k']);
          Result := False;
        End;
      End

      Else If Sender = dbeAlqCof Then
      Begin
        If (StrToFloatDef(dbeAlqCof.Text,-1) <= 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Alíquota de Cofins deve ser maior que 0!', ['&O k']);
          Result := False;
        End;
      End

    End;



    If (qryTabela.State In [dsInsert, dsEdit]) Then
    Begin
      If Not (dbePlaRes.Visible) Then
      Begin
        dbePlaRes.Field.Value := Null;
      End;

      If Not (dbePlaNco.Visible) Then
      Begin
        dbePlaNco.Field.Value := Null;
      End;
    End;




  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadCentroCusto.HabilitaDesabilitaDespesasFinanceiras(
  AHabilitar: Boolean);
begin
  pnlDespesasFinanceiras.Enabled :=  AHabilitar;

  If Not AHabilitar Then
    LimparCamposDespesasFinanceiras;
end;

procedure TfrmCadCentroCusto.LimparCamposDespesasFinanceiras;
begin
  dbeCbcCre.Clear;
  dbeCstPis.Clear;
  dbeCstCof.Clear;
  dbeAlqPis.Clear;
  dbeAlqCof.Clear;
end;

procedure TfrmCadCentroCusto.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('CTA_CODCTA');
  stlCampos.Add('CTA_DESCTA');
  stlCampos.Add('CTA_TIPCTA');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('CTA_DESCTA');
  stlCamInd.Add('CTA_CODCTA');

  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código');
end;

function TfrmCadCentroCusto.PodeExcluirContaResultado: Boolean;
begin
  Result := True;

  If Not Assigned(qryTabela) Then
    Exit(False);

  If qryTabela.IsEmpty Then
    Exit(False);

  If fEmptyStr(strCtaResAnt) Then
    Exit(False);

end;

procedure TfrmCadCentroCusto.pVisibilidadeContaResultado(blnVisible: boolean);
begin
  lblPlaRes.Visible := blnVisible and blnUtiCon;
  dbePlaRes.Visible := blnVisible and blnUtiCon;
  edtDesPlaRes.Visible := blnVisible and blnUtiCon;
end;

function TfrmCadCentroCusto.RegistroEmUsoPorOutraEstacao: Boolean;
  Var
    LChaveLckatc: String;
begin
  Result := False;

  If Not Assigned(qryTabela) Then
    Exit;

  If qryTabela.IsEmpty Then
    Exit;

  LChaveLckatc := 'CADCTA_' + qryTabela.FieldByName('CTA_CODCTA').AsString;
  If Not FobjLock.fLock_Unlock(LChaveLckatc, True, False) Then
  Begin
    fMensagem('ATENÇÃO!', 'Este plano de contas está sendo editado por outra estação: ' + fGetHostLock(LChaveLckatc), ['&OK']);
    Result := True;
    Exit;
  End;

End;

procedure TfrmCadCentroCusto.btnIncluirClick(Sender: TObject);
begin
  inherited;
  qryTabela.FieldByName('CTA_EXPAUT').AsString := 'S';
  qryTabela.FieldByName('CTA_DESMEM').AsString := 'N';
  qryTabela.FieldByName('CTA_ENTREL').AsString := 'S';
  qryTabela.FieldByName('CTA_STATUS').AsString := 'A';
  qryTabela.FieldByName('CTA_PERBCA').AsString := 'S';
  qryTabela.FieldByName('CTA_PERBCH').AsString := 'S';
  qryTabela.FieldByName('CTA_PERREC').AsString := 'S';
  qryTabela.FieldByName('CTA_PERPAG').AsString := 'S';
  qryTabela.FieldByName('CTA_USADFI').AsString := 'N';

  If dbeCodCta.Enabled Then
    pHabilitaCodigo(dbeCodCta, dbeCodCta, True);

  edtCtaRes.Text := '';
  edtDesResultado.Text := '';
  strCtaResAnt := '';
  edtDesPlaNco.Clear;

  pCarregaPlanoDeContasPorEmpresa('CTANCO', dbeCodCta.Text, FcdsNCO);
  cbbTipCtaChange(cbbTipCta);
  cbbEntraRelComo.ItemIndex := 1;
  dbeCodRes.Enabled := False;
  rdgRegimeDRE.ItemIndex := 0;
end;

procedure TfrmCadCentroCusto.btnAlterarClick(Sender: TObject);
begin

  If RegistroEmUsoPorOutraEstacao Then
  Begin
    Exit;
  End;

  AContaResultadoInicial := edtCtaRes.Text;
  inherited;
  If cbbTipCta.Enabled Then
  Begin
    dbeCodCta.Enabled := False;
    dbeCodCta.Color   := $00FFDFB8;
    pSetFocus(cbbTipCta);
  End;

  btnRateios.Enabled := True;
  cbbTipCtaChange(cbbTipCta);
  dbeCodRes.Enabled := False;
end;

function TfrmCadCentroCusto.fPodeExcluirGrupo(strLinha: String): Boolean;
  Var
    strSQL: String;
    strTmpGru: String;
    qryGenCta: TUniQuery;
begin
  Try

    qryGenCta := fCriaQuery(Self);

    Result := True;
    strTmpGru := LeftStr(strLinha, 4) + '%';

    {*****************************************}
    {* É CENTRO DE CUSTO, PODE EXCLUIR       *}
    {**************************************MV*}
    If RightStr(strLinha, 3) <> '000' Then
    Begin
      Exit;
    End;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  COUNT(*) AS QTD ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADCTA ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CTA_CODCTA LIKE :CODCTA ';

    With qryGenCta Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODCTA').AsString := strTmpGru;
      Open;
      If FieldByName('QTD').AsInteger > 1 Then
        Result := False;
      Close;
    End;

  Finally
    FreeAndNil(qryGenCta);
  End;

  FormataCamposDespesasFinanceiras;
end;

function TfrmCadCentroCusto.fPodeExcluirLinha(strLinha: String): Boolean;
  Var
    strSQL   : String;
    strTmpLin: String;
    qryGenCta: TUniQuery;

begin
  qryGenCta := fCriaQuery(Self);

  Result := True;
  strTmpLin := LeftStr(strLinha, 2) + '%';

  {*****************************************}
  {* É CENTRO DE CUSTO, PODE EXCLUIR       *}
  {**************************************MV*}
  If RightStr(strLinha, 3) <> '000' Then
  Begin
    Exit;
  End;

  {*****************************************}
  {* É UM GRUPO, IGNORA VERIFICAÇÃO        *}
  {**************************************MV*}
  If (RightStr(strLinha, 5) <> '00000') Then
  Begin
    Exit;
  End;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  COUNT(*) QTD ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADCTA ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CTA_CODCTA LIKE :CODCTA ';

  With qryGenCta Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODCTA').AsString := strTmpLin;
    Open;
      If FieldByName('QTD').AsInteger > 1 Then
        Result := False;
    Close;
  End;

  FreeAndNil(qryGenCta);

{ 01.00.000 -> LINHA
  01.01.000 -> GRUPO
  01.01.017 -> CC}
end;

procedure TfrmCadCentroCusto.btnExcluirClick(Sender: TObject);
begin

  If RegistroEmUsoPorOutraEstacao Then
  Begin
    Exit;
  End;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  If fPodeExcluirGrupo(dbeCodCta.Text) Then
  Begin
    If fPodeExcluirLinha(dbeCodCta.Text) Then
    Begin
      Try

        If Not fEmptyStr(AContaResultadoInicial) Then
        Begin
         If (Not AlterarContaResultado(AContaResultadoInicial)) then
          begin
            fMensagem('ATENÇÃO!', 'Não será possível excluir esse plano de contas pois a '+
                                  'Conta Resultado vinculada possui Previsão Mensal cadastrada!', ['&Ok']);
            Exit;
          end;
        End;

        inherited;
        pCarregaCtaRes;
        pCarregaPlanoContabil;
        pCarregaPlanoResultado;
        pCarregaHistorico;
        pCarregaPlanoDeContasPorEmpresa('CTANCO', dbeCodCta.Text, FcdsNCO);
      Except
        On E: Exception Do
        Begin
          fRollBack;
          pMensagensErro(E.Message, '[untCadCentroCusto.btnExcluirClick]');
        End;
      End;
    End
    Else
    Begin
      fMensagem('', 'Há Grupos relacionados a essa Linha! Verifique.', ['&Ok']);
    End;
  End
  Else
  Begin
    fMensagem('', 'Há um Plano de Contas relacionado a esse Grupo! Verifique.', ['&Ok']);
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadCentroCusto.FormShow(Sender: TObject);
begin
  inherited;

  If (Not (fCfgSis('EMPGER', varBoolean))) Then
  Begin
    btnIncluir.Enabled := False;
    btnAlterar.Enabled := False;
    btnExcluir.Enabled := False;
  End;

  If (blnUtiCon) Then
  Begin
    dbePlaNco.Visible := True;
    edtDesPlaNco.Visible := True;
    dbeConCon.Visible := False;
    lblDesPlaCon.Caption := 'Plano Contábil:';
    dbchkDesmembr.Visible := False;
    btnPlaNco.Visible := True;
    chkProCon.Visible := True;
  End
  Else
  Begin
    dbePlaNco.Visible := False;
    edtDesPlaNco.Visible := False;
    dbeConCon.Visible := True;
    lblDesPlaCon.Caption := 'Conta Contábil:';
    dbchkDesmembr.Visible := True;
    btnPlaNco.Visible := False;
    chkProCon.Visible := False;
  End;

  AContaResultadoInicial := '';
  ShowRegimeDRE;

  pnlHis.Visible := blnUtiCon and fCfgSis('CONHIS', varBoolean);
  if not pnlHis.Visible then
    Self.Height := Self.Height - pnlHis.Height;

  If (Not fEmptyStr(strCodCta)) Then
  begin
    try
      SelecionaPlanoDeConta(strCodCta);
    finally
      strCodCta := '';
    end;
  end;
end;

procedure TfrmCadCentroCusto.btnGravarClick(Sender: TObject);
  Var
    qryCtaRes: TUniQuery;
    strSQL: String;
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  if not fValidaPlanoDeContasObrigatoria(dbchkExpAut.Checked, fSemMascaraPlaNco(dbePlaNco.Text), FcdsNCO) then
    Exit ;

  if not fVerificarPlanoDeContasPorEmpresa(dbeCodCta.Text, 'CTANCO', dbePlaNco.Text, FcdsNCO) then
  begin
    exit ;
  end;

  If fValidacoesBotaoGravarPai Then
  Begin
    Try
      If (qryTabela.State In [dsInsert]) Then
      Begin
        qryTabela.FieldByName('CTA_CODRES').Value := fStrZero((StrToInt(fRetMax('CADCTA','CTA_CODRES')) + 1 ),5);
      End;
      qryTabela.FieldByName('CTA_TIPCTA').AsInteger := cbbTipCta.ItemIndex + 1;
      qryTabela.FieldByName('CTA_CLACTA').AsInteger := cbbClaCta.ItemIndex + 1;
      Case cbbEntraRelComo.ItemIndex Of
        0: qryTabela.FieldByName('CTA_FLXIMP').AsString := 'I';
        1: qryTabela.FieldByName('CTA_FLXIMP').AsString := 'D';
        2: qryTabela.FieldByName('CTA_FLXIMP').AsString := 'F';
      End;
      qryTabela.FieldByName('CTA_DESMEM').AsString  := IIF(dbchkDesmembr.Checked , 'S', 'N');

      If fTiraCaracEspeciais(dbePlanco.Field.AsString) = '' Then
        dbePlanco.Field.Clear;

      If fTiraCaracEspeciais(dbePlaRes.Field.AsString) = '' Then
        dbePlaRes.Field.Clear;

      inherited;

      if blnGravou then
        pSalvaPlanoDeContasPorEmpresa('CTANCO', dbeCodCta.Text, FcdsNCO) ;

      If blnGravou And (cbbTipCta.ItemIndex in [2,5]) And (Not fEmptyStr(edtCtaRes.Text)) Then
      Begin
        qryCtaRes := fCriaQuery;

        strSQL := '';
        strSQL := strSQL + ' SELECT ';
        strSQL := strSQL + '   * ';
        strSQL := strSQL + ' FROM ';
        strSQL := strSQL + '   CTARES ';
        strSQL := strSQL + ' WHERE ';
        strSQL := strSQL + '   CRE_CODCTA = :CODCTA ';

        With qryCtaRes Do
        Begin
          Close;
          SQL.Add(strSQL);
          ParamByName('CODCTA').AsString := qryTabela.FieldByName('CTA_CODCTA').AsString;
          Open;

          If qryCtaRes.IsEmpty Then
          Begin
            Insert;
            FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CTARES', VS_strCodEmp);
            FieldByName('CRE_CODCTA').AsString := qryTabela.FieldByName('CTA_CODCTA').AsString;
            FieldByName('CRE_CODEMP').AsString := VS_strCodEmp;
          End
          Else
            Edit;

          FieldByName('CRE_CODCRE').AsString := edtCtaRes.Text;
          Post;

          strCtaResAnt := edtCtaRes.Text;
        End;

        FreeAndNil(qryCtaRes);
      End
      Else If blnGravou And (Not fEmptyStr(strCtaResAnt)) Then
      Begin
        qryCtaRes := fCriaQuery;

        strSQL := '';
        strSQL := strSQL + ' DELETE ';
        strSQL := strSQL + ' FROM ';
        strSQL := strSQL + '   CTARES ';
        strSQL := strSQL + ' WHERE ';
        strSQL := strSQL + '   CRE_CODCTA = :CODCTA AND ';
        strSQL := strSQL + '   CRE_CODCRE = :CODCRE ';

        With qryCtaRes Do
        Begin
          Close;
          SQL.Add(strSQL);
          ParamByName('CODCTA').AsString := qryTabela.FieldByName('CTA_CODCTA').AsString;
          ParamByName('CODCRE').AsString := strCtaResAnt;
          ExecSQL;
        End;

        FreeAndNil(qryCtaRes);
      End;

    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[TfrmCadCentroCusto.btnGravarClick]');
      End;
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;

  btnRateios.Enabled := False;
  DestravarRegistro;
end;

procedure TfrmCadCentroCusto.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(btnIncluir);;
end;

procedure TfrmCadCentroCusto.FormataCamposDespesasFinanceiras;
begin
  TFloatField(qryTabela.FieldByName('CTA_ALQPIS')).EditFormat := '#,##0.00';
  TFloatField(qryTabela.FieldByName('CTA_ALQPIS')).DisplayFormat := '#,##0.00';

  TFloatField(qryTabela.FieldByName('CTA_ALQCOF')).EditFormat := '#,##0.00';
  TFloatField(qryTabela.FieldByName('CTA_ALQCOF')).DisplayFormat := '#,##0.00';
end;

procedure TfrmCadCentroCusto.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  qryTabela.AfterScroll := Nil;
end;

procedure TfrmCadCentroCusto.btnPesquisaClick(Sender: TObject);
Var
  chrKey         : Char;
  arrCentroCusto : TConsultasArray;
begin
  {*************************************}
  {* NOVA CONSULTA DE CENTRO DE CUSTOS *}
  {**********************************DP*}
  chrKey := '/';
  fPesqCentroCusto(Self, Nil, Nil, qryTabela, chrKey, arrCentroCusto);
  pCarregaCtaRes;
  AContaResultadoInicial := edtCtaRes.Text;
  pCarregaPlanoContabil;
  pCarregaPlanoResultado;
  HabilitaDesabilitaDespesasFinanceiras(dbeChkUtlDespesasFinanceiras.Checked);
  pCarregaHistorico;
  pCarregaPlanoDeContasPorEmpresa('CTANCO', dbeCodCta.Text, FcdsNCO);
  pSetFocus(btnAlterar);
  FormataCamposDespesasFinanceiras;
end;

procedure TfrmCadCentroCusto.btnPlaNcoClick(Sender: TObject);
begin
  inherited;
  pPlanoDeContasPorEmpresa(dbeCodCta.Text, 'CTANCO', qryTabela.FieldByName('CTA_PLANCO').AsString, qryTabela.State, FcdsNCO, True);
end;

procedure TfrmCadCentroCusto.cbbTipCtaChange(Sender: TObject);
begin
  inherited;
  cbbClaCta.Enabled := (cbbTipCta.ItemIndex in [2,3,5]) And (qryTabela.State In [dsEdit, dsInsert]);
  edtCtaRes.Enabled := (cbbTipCta.ItemIndex in [2,5]);

  If fCfgSis('DESPRE', varBoolean) Then
    edtCtaRes.Enabled := (cbbTipCta.ItemIndex in [2,3,5]);

  If Not edtCtaRes.Enabled Then
  Begin
    edtCtaRes.Text := '';
    edtDesResultado.Text := '';
  End;
end;

procedure TfrmCadCentroCusto.chkProConClick(Sender: TObject);
begin
  inherited;
  pVisibilidadeContaResultado(chkProCon.Checked);
end;

procedure TfrmCadCentroCusto.dbchkDesmembrClick(Sender: TObject);
begin
  inherited;
  If dbchkDesmembr.Checked Then
  Begin
    btnDesmembr.Visible := True;

    If (blnUtiCon) Then
    Begin
      dbePlaNco.Clear;
      dbePlaNco.Enabled := False;
    End
    Else
    Begin
      dbeConCon.Clear;
      dbeConCon.Enabled := False;
    End;
  End
  Else
  Begin
    btnDesmembr.Visible := False;

    If (qryTabela.State In [dsEdit, dsInsert]) Then
    Begin
      If (blnUtiCon) Then
        dbePlaNco.Enabled := True
      Else
        dbeConCon.Enabled := True;
    End;

  End;

end;

procedure TfrmCadCentroCusto.dbePlaNcoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    TStringField(qryTabela.FieldByName('CTA_PLANCO')).EditMask := '';
    If fPesqPlanoContabil(Self, dbePlaNco, Nil, Nil, Key, arrSel) Then
    Begin
      If fValidaCampos(dbePlaNco, False) Then
        Self.SelectNext(ActiveControl, True, True);
    End;
    TStringField(qryTabela.FieldByName('CTA_PLANCO')).EditMask := fMskCon;
  End;
end;

procedure TfrmCadCentroCusto.dbePlaResKeyPress(Sender: TObject; var Key: Char);
begin
  If fEntraCons(Key) Then
  Begin
    TStringField(qryTabela.FieldByName('CTA_PLARES')).EditMask := '';
    If fPesqPlanoContabil(Self, dbePlaRes, Nil, Nil, Key, arrSel) Then
    Begin
      If fValidaCampos(dbePlaRes, False) Then
        Self.SelectNext(ActiveControl, True, True);
    End;
    TStringField(qryTabela.FieldByName('CTA_PLARES')).EditMask := fMskCon;
  End;
end;

procedure TfrmCadCentroCusto.DestravarRegistro;
begin
  If Not Assigned(qryTabela) Then
    Exit;

  If qryTabela.IsEmpty Then
    Exit;

  FobjLock.fLock_Unlock('CADCTA_' + qryTabela.FieldByName('CTA_CODCTA').AsString , False, False);
end;

procedure TfrmCadCentroCusto.dtsCadCtaStateChange(Sender: TObject);
begin
  inherited;
  btnDesmembr.Enabled := dtsCadCta.State in [dsEdit, dsInsert];
  cbbTipCta.Enabled := dtsCadCta.DataSet.State in [dsEdit, dsInsert];
  cbbClaCta.Enabled := (cbbTipCta.ItemIndex in [2,3]) And (qryTabela.State In [dsEdit, dsInsert]);
  cbbEntraRelComo.Enabled := (qryTabela.State In [dsEdit, dsInsert]);
end;

procedure TfrmCadCentroCusto.edtCtaResEnter(Sender: TObject);
begin
  inherited;
  pnlInfo.Caption := 'INSERT para fazer um novo cadastro';
end;

procedure TfrmCadCentroCusto.edtCtaResExit(Sender: TObject);
begin
  inherited;
  edtDesResultado.Text := fRetContaResultado(edtCtaRes.Text);
  pnlInfo.Caption := '';
end;

procedure TfrmCadCentroCusto.edtCtaResKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqCtaResultado(Self, edtCtaRes, Nil, Nil, Key, arrSel) Then
  Begin
    fValidaCampos(edtCtaRes,False);
    Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadCentroCusto.dbeCbcCreKeyPress(Sender: TObject; var Key: Char);
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
        dbeCbcCre.Text := qryConsulta.FieldByName('FIN_CODIGO').AsString;
        if fValidaCampos(dbeCbcCre, True) then
          SelectNext(ActiveControl, True, True);
        Key := Char(0);
      end;
    finally
      FreeAndNil(qryConsulta);
    end;
  end;
end;
procedure TfrmCadCentroCusto.dbeChkUtlDespesasFinanceirasClick(Sender: TObject);
begin
  inherited;
  HabilitaDesabilitaDespesasFinanceiras(dbeChkUtlDespesasFinanceiras.Checked);
end;

procedure TfrmCadCentroCusto.dbeCstCofKeyPress(Sender: TObject; var Key: Char);
  Var
    arrCstCof: TConsultasArray;
begin
  inherited;
  if fPesqCSTCof(Self, dbeCstCof, nil, nil, Key, arrCstCof) then
  Begin
    If fValidaCampos(dbeCstCof, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;


procedure TfrmCadCentroCusto.dbeCstPisKeyPress(Sender: TObject; var Key: Char);
  Var
    arrCstPis: TConsultasArray;
begin
  inherited;
  if fPesqCSTPIS(Self, dbeCstPis, nil, nil, Key, arrCstPis) then
  Begin
    If fValidaCampos(dbeCstPis, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadCentroCusto.dbeHisConKeyPress(Sender: TObject; var Key: Char);
  Var
    arrHist: TConsultasArray;
begin
  If fEntraCons(Key) Then
  Begin
    If fPesqHistoricoPadrao(Self, dbeHisCon, Nil, Nil, Key, arrHist) Then
    Begin
      If fValidaCampos(dbeHisCon, False) Then
        Self.SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmCadCentroCusto.ExcluirContaResultado;
  Var
    LCtaRes : TUniQuery;
begin

  If Not PodeExcluirContaResultado Then
    Exit;

  Try

    Try
      LCtaRes := fCriaQuery;
      LCtaRes.Close;
      LCtaRes.SQL.Text :=  ' DELETE                      '+
                           ' FROM                        '+
                           '   CTARES                    '+
                           ' WHERE                       '+
                           '   CRE_CODCTA = :CODCTA AND  '+
                           '   CRE_CODCRE = :CODCRE      ';

      LCtaRes.ParamByName('CODCTA').AsString := qryTabela.FieldByName('CTA_CODCTA').AsString;
      LCtaRes.ParamByName('CODCRE').AsString := strCtaResAnt;
      LCtaRes.ExecSQL;


      LCtaRes.Close;
      LCtaRes.SQL.Text :=  ' DELETE                      '+
                           ' FROM                        '+
                           '   CADPME                    '+
                           ' WHERE                       '+
                           '   PME_CODCTA = :CODCTA AND  '+
                           '   PME_CODRES = :CODRES       ';

      LCtaRes.ParamByName('CODCTA').AsString := qryTabela.FieldByName('CTA_CODCTA').AsString;
      LCtaRes.ParamByName('CODRES').AsString := strCtaResAnt;
      LCtaRes.ExecSQL;

    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;

  Finally
    FreeAndNil(LCtaRes);
  End;

end;

function TfrmCadCentroCusto.fExecutaAntesDoDelete: Boolean;
begin
  Try
    ExcluirContaResultado;
    Result := True;
  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.message);
    End;
  End;
end;

function TfrmCadCentroCusto.fExisteConContabil: String;
  Var
    qryGenCta: TUniQuery;
begin
  Try
    If fEmptyStr(dbeConCon.Text) Then
    Begin
      Result := EmptyStr;
      Exit;
    End;

    qryGenCta := fCriaQuery;

    With qryGenCta Do
    Begin
      SQL.Add('SELECT');
      SQL.Add('  CONCAT(CTA_CODCTA, "-", CTA_DESCTA) CONTA ');
      SQL.Add('FROM');
      SQL.Add('  CADCTA');
      SQL.Add('WHERE');
      SQL.Add('  CTA_CONCON  = :CONCON AND');
      SQL.Add('  CTA_CODCTA <> :CODCTA    ');
      ParamByName('CONCON').Value := dbeConCon.Text;
      ParamByName('CODCTA').Value := dbeCodCta.Text;
      Open;

      Result := FieldByName('CONTA').AsString;
    End;
  Finally
    FreeAndNil(qryGenCta);
  End;
end;

procedure TfrmCadCentroCusto.btnCancelaClick(Sender: TObject);
begin
  inherited;
  DestravarRegistro;
  btnRateios.Enabled := False;
  pCarregaCtaRes;
  pCarregaPlanoContabil;
  pCarregaPlanoResultado;
  pCarregaHistorico;
  pCarregaPlanoDeContasPorEmpresa('CTANCO', dbeCodCta.Text, FcdsNCO);
end;

procedure TfrmCadCentroCusto.btnDesmembrClick(Sender: TObject);
begin
  inherited;
  {********************************}
  {* CHAMA TELA DE DESMEMBRAMENTO *}
  {*****************************JU*}
  pCriarFormularios(TfrmDesmCtaEmpCContabil, frmDesmCtaEmpCContabil);
  Try
    frmDesmCtaEmpCContabil.strCodCta := dbeCodCta.Text;
    frmDesmCtaEmpCContabil.ShowModal;
    Application.ProcessMessages;
  Finally
    FreeAndNil(frmDesmCtaEmpCContabil);
  End;
end;

procedure TfrmCadCentroCusto.btnRateiosClick(Sender: TObject);
var
  frmCadCtaDet: TfrmCadCtaDet;
begin
  inherited;
  If (Not qryTabela.Active) Or (qryTabela.IsEmpty) Then
    Exit;

  If (dbeCodCta.Text = fCfgSis('CTAPRI')) Then
  Begin
    fMensagem('ATENÇÃO!', 'Não é permitido informar o rateio por empresas para o Plano de Contas de rateio.', ['&Ok']);
    Exit;
  End;

  If RightStr(dbeCodCta.Text, 3) = '000' Then
  Begin
    fMensagem('ATENÇÃO!', 'Não é permitido informar o rateio para este Plano de Contas.', ['&Ok']);
    Exit;
  End;

  Try
    pCriarFormularios(TfrmCadCtaDet, frmCadCtaDet);
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmCadCentroCusto.btnEmpresasClick]');
      pFreeAndNil(frmCadCtaDet);
      Exit;
    End;
  End;
  frmCadCtaDet.strCodCta := qryTabela.FieldByName('CTA_CODCTA').AsString;
  frmCadCtaDet.ShowModal;
  pFreeAndNil(frmCadCtaDet);
end;

end.
