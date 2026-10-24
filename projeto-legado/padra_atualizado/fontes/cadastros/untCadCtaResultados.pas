{******************************}
{* qryConCta -> CADCTA        *}
{***************************JB*}

unit untCadCtaResultados;

interface

uses
  Windows, Classes, Controls, untTLock ,Forms, StdCtrls, untPaiCad, ComCtrls, Buttons,
  ExtCtrls, Mask, DBCtrls, DBEditFocus, MaskEditFocus, Grids, DBGridCitel, DBGrids, Menus, Uni,
  AppEvnts, DB, UniClientDataSet, UniDataSetProvider, untModulo, BitBtnLockedIncrem, MemDS,
  DBAccess, Provider, Datasnap.DBClient, frxClass, frxExportCSVTestabilidade,
  untFramePlanoDeContasMaskEdit;

type
  TfrmCadCtaResultados = class(TfrmPaiCad)
    Label1: TLabel;
    Label2: TLabel;
    dbeCodCre: TDBEditFocus;
    dbeDesCre: TDBEditFocus;
    pnlGrid: TPanel;
    dbgDesCta: TDBGridCitel;
    pnlFundo: TPanel;
    qryConsulta: TUniQuery;
    dspConsulta: TUniDataSetProvider;
    cdsConsulta: TUniClientDataSet;
    dtsConsulta: TDataSource;
    dtsCtaRes: TDataSource;
    fraPlanoDeContas: TfraPlanoDeContasMskEdit;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure dbgDesCtaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
    procedure dbeCodCreExit(Sender: TObject);
  private
    { Private declarations }
    qryConCta: TUniQuery;
    qryCtaRes: TUniQuery;

    FobjLock: TLock;

    procedure pDeletaTemporaria;
    procedure pCriaTemporaria(strCodCre: string);
    procedure pConfirmaDados;
    procedure pAdicionaDadosTemporaria(strCodCta: String);
    procedure pDeletaDadosTemporaria;

    procedure pCarregaCentroDeCusto;

    function fExisteCtaRes(strCtaRes: String): Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
  public
    { Public declarations }
  end;

implementation

uses SysUtils, StrUtils, untfuncoesSimples, untPai, untTypesSistema,
  untPesqAux, untConsultas;

{$R *.dfm}

{ TfrmCadCtaResultados }

procedure TfrmCadCtaResultados.pCriaTemporaria(strCodCre: string);
  Var
    strSQL: String;
begin
  {**************************************}
  {* LEGENDA DOS STATUS DA TABELA TEMP. *}
  {* N -> NORMAL                        *}
  {* I -> INSERIDO                      *}
  {* A -> ALTERADO                      *}
  {* E -> EXCLUIDO                      *}
  {***********************************JB*}

  pDeletaTemporaria;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  CTA_CODCTA, ';
  strSQL := strSQL + '  CTA_DESCTA, ';
  strSQL := strSQL + '  "N" AS STATUS  ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADCTA C, ';
  strSQL := strSQL + '  CTARES R ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  R.CRE_CODCTA = C.CTA_CODCTA AND ';
  strSQL := strSQL + '  R.CRE_CODCRE = :CODCRE ';

  With qryConsulta Do
  Begin
    Close;
    cdsConsulta.Close;

    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODCRE').AsString := strCodCre;
    Open;
    pSetaClient(qryConsulta);

    cdsConsulta.Open;
    pSetaClient(cdsConsulta);

    cdsConsulta.Filter   := 'STATUS <> ' + QuotedStr('E');
    cdsConsulta.Filtered := True;
  End;
end;

procedure TfrmCadCtaResultados.pDeletaTemporaria;
begin
  If cdsConsulta.Active Then
    cdsConsulta.EmptyDataSet;
end;

procedure TfrmCadCtaResultados.FormCreate(Sender: TObject);
  var
    strSQL: String;
begin
  inherited;
  strNomeTabela     := 'CTAGER';
  strNomeCampo      := 'CRE_CODCRE';

  strSQL            := 'SELECT * FROM CTAGER';
  qryTabela         := fCriarQuery(strSQL, Self);
  dtsCtaRes.DataSet := qryTabela;

  strSQL            := 'SELECT * FROM CTARES ';
  strSQL            := strSQL + 'WHERE CRE_CODCRE = :CODCRE';
  qryCtaRes         := fCriarQuery(strSQL, Self);

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodCre;
  FobjLock := TLock.Create;
end;

procedure TfrmCadCtaResultados.FormDestroy(Sender: TObject);
begin
  inherited;
  FobjLock.pDestravarTodos;
  FreeAndNil(FobjLock);
end;

procedure TfrmCadCtaResultados.fraPlanoDeContasMskCodCtaKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  fraPlanoDeContas.MskCodCtaKeyPress(Sender, Key);
end;

function TfrmCadCtaResultados.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    LChaveLckatc: String;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    {*****************************************}
    {* VALIDA O CÓDIGO DA CONTA DE RESULTADO *}
    {**************************************MV*}
    If (Sender = dbeCodCre) Then
    Begin
      If (fEmptyStr(dbeCodCre.Text)) And (dbeCodCre.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If blnBuscaPorChave Then
      Begin
        pDeletaTemporaria;
        If Not fBuscaPorCamposChave Then
        Begin
          pLimparCampos;
        End
        Else
        Begin
          pCriaTemporaria(dbeCodCre.Text);
        End;
      End
    End

    {*****************************************}
    {* VALIDA A DESCRIÇÃO DA CONTA DE RESUL- *}
    {* TADO                                  *}
    {**************************************MV*}
    Else If (Sender = dbeDesCre) Then
    Begin
      If fEmptyStr(dbeDesCre.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Descrição deve ser preenchida!', ['&Ok']);
        Result := False;
      End
    End

    {*****************************************}
    {* VALIDA O CENTRO DE CUSTO              *}
    {**************************************MV*}
    Else If (Sender = fraPlanoDeContas.MskCodCta) Then
    Begin

      If RightStr(fraPlanoDeContas.MskCodCta.Text, 3) = '000' Then
      Begin
        fMensagem('ATENÇÃO!', fraPlanoDeContas.MskCodCta.Text + ' não é um Plano de Contas válido!', ['&Ok']);
        fraPlanoDeContas.MskCodCta.Clear;
        Result := False;
      End

      Else If fExisteCtaRes(fraPlanoDeContas.MskCodCta.Text) Then
      Begin
        fMensagem('ATENÇÃO!', fraPlanoDeContas.MskCodCta.Text + ' já está cadastrado!', ['&Ok']);
        fraPlanoDeContas.MskCodCta.Clear;
        Result := False;
      End

      {*****************************************}
      {* CASO PASSA EM BRANCO, VAI PARA O GRID *}
      {**************************************MV*}
      Else If Not fEmptyStr(fraPlanoDeContas.MskCodCta.Text) Then
      Begin

        pCarregaCentroDeCusto;
        If qryConCta.FieldByName('CTA_CODCTA').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          LChaveLckatc := 'CADCTA_' + qryConCta.FieldByName('CTA_CODCTA').AsString;

          If (fCfgSis('DESPRE', varBoolean) And Not (qryConCta.FieldByName('CTA_TIPCTA').AsInteger in [3,4,6])) Then
          Begin
            fMensagem('ATENÇÃO!', 'Não pode ser inserido um Plano de Contas diferente do tipo (3-Despesas, 4-Despesas financeiras e 6-Despesas Variáveis)!', ['&Ok']);
            Result := False;
          End
          Else If (Not fCfgSis('DESPRE', varBoolean) And Not (qryConCta.FieldByName('CTA_TIPCTA').AsInteger in [3,6])) Then
          Begin
            fMensagem('ATENÇÃO!', 'Não pode ser inserido um Plano de Contas diferente do tipo (3-Despesas e 6-Despesas Variáveis)!', ['&Ok']);
            Result := False;
          End
          Else If Not FobjLock.fLock_Unlock(LChaveLckatc, True, False) Then
          Begin
            fMensagem('ATENÇÃO!', 'Este plano de contas está sendo editado por outra estação: ' + fGetHostLock(LChaveLckatc), ['&OK']);
            Result := False;
          End
          Else
          Begin
            if PlanoDeContasAtivo(fraPlanoDeContas.MskCodCta.Text,True) = False then
              Result := False
            else
            Begin
              pAdicionaDadosTemporaria(fraPlanoDeContas.MskCodCta.Text);
              fraPlanoDeContas.MskCodCta.Clear;
              pSetFocus(dbeDesCre); //Marvin - voltar aqui
            End;
          End;
        End;

      End

      {*****************************************}
      {* 'blnBuscaPorChave': É FALSA QUANDO O  *}
      {* BOTÃO SALVAR É ACIONADO               *}
      {**************************************MV*}
      Else If (cdsConsulta.IsEmpty) And (blnBuscaPorChave) Then
      Begin
        Result := False
      End
    End;
  End;
end;

procedure TfrmCadCtaResultados.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('CRE_DESCRE');
  stlCampos.Add('CRE_CODCRE');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('CRE_DESCRE');
  stlCamInd.Add('CRE_CODCRE');

  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código');

  qryConCta := fCriarQuery('SELECT * FROM CADCTA WHERE FALSE', Self);
end;

procedure TfrmCadCtaResultados.pAdicionaDadosTemporaria(strCodCta: String);
begin

  With cdsConsulta Do
  Begin
    Insert;
    FieldByName('STATUS').AsString     := 'I';
    FieldByName('CTA_CODCTA').AsString := fraPlanoDeContas.MskCodCta.Text;
    FieldByName('CTA_DESCTA').AsString := qryConCta.FieldByName('CTA_DESCTA').AsString;
    Post;
  End;

end;

procedure TfrmCadCtaResultados.pCarregaCentroDeCusto;
begin
  pPesquisaCadCta(qryConCta, qryConCta, fraPlanoDeContas.MskCodCta.Text);
end;

procedure TfrmCadCtaResultados.btnIncluirClick(Sender: TObject);
begin
  inherited;
  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodCre, dbeDesCre, False)
  Else
    pHabilitaCodigo(dbeCodCre, dbeCodCre, True);

  pDeletaTemporaria;

  pCriaTemporaria('');
  dbgDesCta.Enabled := True;
end;

procedure TfrmCadCtaResultados.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodCre, dbeDesCre, False);
  dbgDesCta.Enabled := True;
  pnlInfo.Caption := 'Para Excluir o Plano de Contas individual use o DEL.';
end;

procedure TfrmCadCtaResultados.pConfirmaDados;
  Var
    prcScroll: TprcScroll;
begin

  {************************}
  {* ABRE A TABELA CTARES *}
  {*********************JB*}
  With qryCtaRes Do
  Begin
    Close;
    ParamByName('CODCRE').AsString := dbeCodCre.Text;
    Open;
  End;

  With cdsConsulta Do
  Try
    pDisableControls(cdsConsulta, prcScroll);
    {*****************************************}
    {* SELECIONA OS REGISTROS DA TEMPORARIA  *}
    {* QUE FORAM MODIFICADOS                 *}
    {**************************************JB*}
    Filter   := 'STATUS <> ' + QuotedStr('N');
    Filtered := True;

    While Not Eof Do
    Begin
      {*****************************************}
      {* LOCALIZA O REGISTRO MODIFICADO        *}
      {**************************************JB*}
      If Not SameText(FieldByName('STATUS').asString, 'I') Then
      Begin

        If Not qryCtaRes.Locate('CRE_CODCTA', FieldByName('CTA_CODCTA').AsString, []) Then
        Begin
          Next;
          Continue;
        End;

      End;

      {*******************************************************}
      {* EFETUA A OPERACAO DE ACORDO C\ STATUS DA TAB. TEMP. *}
      {****************************************************JB*}  
      If (Pos(FieldByName('STATUS').asString, 'I_A_') > 0) Then
      Begin
        {**********************}
        {* INSERIR OU ALTERAR *}
        {*******************JB*}
        If SameText(FieldByName('STATUS').asString, 'I') Then
        Begin
          qryCtaRes.Insert;
          qryCtaRes.FieldByName('AUTOINCREM').AsString  := fRetAutoIncrem('CTARES', VS_strCodEmp);
        End
        Else If SameText(FieldByName('STATUS').asString, 'A') Then
          qryCtaRes.Edit;

        qryCtaRes.FieldByName('CRE_CODCRE').AsString  := dbeCodCre.Text;
        qryCtaRes.FieldByName('CRE_CODCTA').AsString  := FieldByName('CTA_CODCTA').AsString;
        qryCtaRes.FieldByName('CRE_CODEMP').AsString  := VS_strCodEmp;
        qryCtaRes.Post;

      End
      Else If SameText(FieldByName('STATUS').asString, 'E') Then
      Begin
        {********************}
        {* EXCLUIR          *}
        {*****************JB*}
        qryCtaRes.Delete;

      End;

      Next;

    End;

  Finally
    Filter   := 'STATUS <> ' + QuotedStr('E');
    pEnableControls(cdsConsulta, prcScroll);
  End;

  pDeletaTemporaria;
  pCriaTemporaria(dbeCodCre.Text);
end;

procedure TfrmCadCtaResultados.btnGravarClick(Sender: TObject);
begin
  If (cdsConsulta.IsEmpty) Then
  Begin
    fMensagem('', 'É necessário escolher pelo menos um Plano de Contas!', ['&Ok']);
    pSetFocus(fraPlanoDeContas.MskCodCta);
    Exit;
  End;

  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
    If (blnGravou) Then
    Begin
      pConfirmaDados;
      blnGravou := False;
      fCommit;
    End
    Else
      fRollBack;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[btnGravarClick]');
    End;
  End;
end;

procedure TfrmCadCtaResultados.FormShow(Sender: TObject);
begin
  inherited;
  If (Not (fCfgSis('EMPGER', varBoolean))) Then
  Begin
    btnIncluir.Enabled := False;
    btnAlterar.Enabled := False;
    btnExcluir.Enabled := False;
  End;
end;

procedure TfrmCadCtaResultados.btnCancelaClick(Sender: TObject);
begin
  inherited;
  FobjLock.pDestravarTodos;
  pDeletaTemporaria;
  pCriaTemporaria(dbeCodCre.Text);
end;

procedure TfrmCadCtaResultados.btnExcluirClick(Sender: TObject);
begin
  FobjLock.pDestravarTodos;
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  If fMensagem('ATENÇÃO', 'Está Operação irá excluir por Completo a Conta de Resultado deseja contínuar? ', ['&Sim', '&Não']) = 1 Then
  Begin
    if not AlterarContaResultado(dbeCodCre.Text) then
    begin
      fMensagem('ATENÇÃO!', 'Não será possível excluir a Conta Resultado, pois, a mesma possui Previsão Mensal cadastrada!', ['&Ok']);
      Exit;
    end
    else
    begin
      inherited;

      pDeletaTemporaria;
      pCriaTemporaria(dbeCodCre.Text);
    end;

    If blnExcluiu Then
      fCommit
    Else
      fRollBack;
  End;

end;

procedure TfrmCadCtaResultados.dbeCodCreExit(Sender: TObject);
begin
  inherited;
  If Not fEmptyStr(dbeCodCre.Text) Then
    dbeCodCre.Text := fStrZero(dbeCodCre.Text,5);
end;

procedure TfrmCadCtaResultados.dbgDesCtaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Not (qryTabela.State = dsBrowse) Then
  Begin
    If Key = VK_Escape Then
    Begin
      pSetFocus(fraPlanoDeContas.MskCodCta);
    End
    Else If Key = VK_Delete Then
    Begin
      if not AlterarContaResultado(dbeCodCre.Text,cdsConsulta.FieldByName('CTA_CODCTA').AsString) then
      begin
        fMensagem('ATENÇÃO!', 'Não será possível desvincular o Plano de Contas dessa Conta Resultado, pois, existe Previsão Mensal cadastrada para a Conta Resultado!', ['&Ok']);
        Exit;
      end
      else
        pDeletaDadosTemporaria;
    End;
  End;
end;

procedure TfrmCadCtaResultados.pDeletaDadosTemporaria;
begin
  FobjLock.fLock_Unlock('CADCTA_' + cdsConsulta.FieldByName('CTA_CODCTA').AsString , False, False);

  cdsConsulta.Edit;
  cdsConsulta.FieldbyName('STATUS').AsString := 'E';
  cdsConsulta.Post;
end;

procedure TfrmCadCtaResultados.btnPesquisaClick(Sender: TObject);
  var
    chrKey: Char;
    arrSel : TConsultasArray;

begin
//  inherited;
  chrKey := '/';

  If fPesqCtaResultado(Self, dbeCodCre, nil, qryTabela, chrKey, arrSel) Then
  Begin
    pSetFocus(btnAlterar);
  End;

  pDeletaTemporaria;
  pCriaTemporaria(dbeCodCre.Text);
end;

function TfrmCadCtaResultados.fExisteCtaRes(strCtaRes: String): Boolean;
  Var
    strSQL   : String;
    qryGenRes: TUniQuery;
    prcScroll: TprcScroll;
    intRecNo : Integer;
begin

  qryGenRes := fCriaQuery(Self);

  {*****************************************}
  {* PESQUISA NO CTARES, POIS UM CENTRO DE *}
  {* CUSTO NÃO PODE PERTENCER AO MAIS DE   *}
  {* UMA CONTA DE RESULTADO                *}
  {**************************************MV*}
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  COUNT(*) AS QTD ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CTARES ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CRE_CODCTA = :CODCTA ';
  If Not fEmptyStr(dbeCodCre.Text) Then
    strSQL := strSQL + '  AND CRE_CODCRE <> :CODCRE ';

  With qryGenRes Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODCTA').AsString := strCtaRes;
    If Not fEmptyStr(dbeCodCre.Text) Then
      ParamByName('CODCRE').AsString := dbeCodCre.Text;
    Open;
    If FieldByName('QTD').AsInteger > 0 Then
    Begin
      Result := True;
      Exit;
    End;
    Close;
  End;

  {*****************************************}
  {* VERIRIFICA SE O CENTRO DE CUSTO ESTA  *}
  {* CADASTRADO NA CONTA DE RESULTADO      *}
  {* ATUAL                                 *}
  {**************************************MV*}
  With cdsConsulta Do
  Begin
    intRecNo := RecNo;
    Try
      pDisableControls(cdsConsulta, prcScroll);
      Result := Locate('CTA_CODCTA', strCtaRes, []);
    Finally
      RecNo := intRecNo;
      pEnableControls(cdsConsulta, prcScroll);
    End;
  End;


  FreeAndNil(qryGenRes);

end;

procedure TfrmCadCtaResultados.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(btnIncluir);
end;

procedure TfrmCadCtaResultados.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If (Action <> caNone) Then
  Begin
    pDeletaTemporaria;
  End;
end;



end.

