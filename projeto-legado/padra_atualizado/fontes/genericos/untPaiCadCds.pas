unit untPaiCadCds;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPai, ComCtrls, Buttons, ExtCtrls, DB, Uni, DBEditFocus, DBCtrls,
  DBComboBoxFocus, EditFocus, MaskEditFocus, Menus, AppEvnts,
  UniDataSetProvider, UniClientDataSet, BitBtnLockedIncrem, Provider, frxClass,
  frxExportCSVTestabilidade, Datasnap.DBClient, untFuncoes;

type
  TfrmPaiCadCds = class(TfrmPai)
    pgcDados: TPageControl;
    tbsGeral: TTabSheet;
    dtsTabela: TDataSource;
    cdsTabela: TUniClientDataSet;
    dspTabela: TUniDataSetProvider;
    btnIncluir: TBitBtnLocked;
    btnGravar: TBitBtnLocked;
    btnAlterar: TBitBtnLocked;
    btnExcluir: TBitBtnLocked;
    btnCancela: TBitBtnLocked;
    btnPesquisa: TBitBtnLocked;
    procedure btnIncluirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cdsTabelaAfterPost(DataSet: TDataSet);
    procedure cdsTabelaAfterDelete(DataSet: TDataSet);
    procedure mnuConfigurarRelClick(Sender: TObject);
  private
    { Private declarations }
    strSQLCadastro: String;

    cdsBusCamChave:   TUniClientDataSet;

    procedure pLimpaDatasVazias;

    function fRetCampoEmpresa: String;
  protected
    intPaginasAtivas: Integer;
    arrCamposChave: Array Of TWinControl;

    blnUsaAutInc: Boolean;
    blnUsaProCodigo: Boolean;
    blnVerificaProCod: Boolean;
    strNomeTabela: String;
    strNomeCampo: String;
    strCampoEmp: String;

    {*****************************************}
    {* ESSA VARIAVEL ADICIONA MAIS UM OU     *}
    {* MAIS PARAMETROS PARA A PESQUISA       *}
    {**************************************MV*}
    strOrderOpc: String;

    blnExcluiu: Boolean;
    blnAlterou: Boolean;
    blnGravou: Boolean;

    {*******************************************}
    {* VARIAVEL QUE SE TRUE, FAZ A VERIFICAÇÃO *}
    {* ESPECIFICA E SE SETADA PARA FALSE NÃO   *}
    {* VERIFICA                                *}
    {****************************************AF*}
    blnVerDirEsp: Boolean;

    blnStartTransactionNoPaiMasCommitRoolBackNoFilho: Boolean;

    function fAbrirTabelaCadastro(strSql: String): Boolean;

    function fProximoCodigo: String; virtual;

    {*******************************************}
    {* FUNÇÕES DE VALIDAÇÃO!                   *}
    {****************************************MV*}
{    function fVerificaCampos: Boolean;
    function fValidaPanel(pnlPanel: TPanel; blnBuscaPorChave: Boolean = False): Boolean;
    function fVerificaSubObjeto(objObjeto: TWinControl): Boolean;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; virtual;}

    function fBuscaPorCamposChave(blnEditar: Boolean = True): Boolean;

    function fBuscaTrocChqAvisPre: Boolean;
    function fBuscaChqOutroTipo: Boolean;
//  procedure pOnKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState); override;
//  procedure pOnKeyDownEdits(Sender: TObject; var Key: Word; Shift: TShiftState); override;

    procedure pOnStateChange;
    procedure pInicializaIndices; virtual; abstract;
    procedure pLimparCampos;
    procedure pProximaPagina;
    procedure pAtribuiTags;
    procedure pZeraCamposNumericos;

    function fExecutaAntesDoDelete : Boolean; virtual;
  public
    { Public declarations }
    {*****************************************}
    {* REPRESENTA O ÚLIMO REGISTRO INSERIDO  *}
    {* OU ALTERADO NA SESSÃO                 *}
    {**************************************MV*}
    strUltimoCodigo: String;
    blnGravacaoFisica: Boolean;
    blnResCai: Boolean;
    blnCtaRec: Boolean;
    cdsTrcChqAvisPre: TUniClientDataSet;
    cdsChqOutroTip: TUniClientDataSet;
  end;

var
  frmPaiCadCds: TfrmPaiCadCds;

implementation

uses untfuncoesSimples, untConstantes, Mask, untModulo;

{$R *.dfm}

procedure TfrmPaiCadCds.btnIncluirClick(Sender: TObject);
begin

  If Not blnGravacaoFisica Then
    cdsBusCamChave.Data := cdsTabela.Data;

  inherited;
  Try
    pValidaProCod(strNomeTabela);

    If (Not cdsTabela.Active) Then
    Begin
      pnlInfo.Caption := 'Aguarde, abrindo arquivo...';
      Application.ProcessMessages;
      fAbrirTabela(cdsTabela);
      pnlInfo.Caption := '';
      Application.ProcessMessages;
    End;

    pgcDados.ActivePageIndex := 0;

    cdsTabela.Insert;
    pEnabled(Self, True);
    pOnStateChange;
    blnUsaProCodigo := fUsaProCodigo(strNomeTabela);
  Except
    On E: EUniError Do
    Begin
      showMessage(IntToStr(E.ErrorCode));
    End;
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[Inserir Registro]');
    End;
  End;
end;

procedure TfrmPaiCadCds.FormCreate(Sender: TObject);
{  Var
    intContador: Integer;}
begin
  inherited;

  blnGravacaoFisica := True;
  blnResCai    := False;
  blnCtaRec         := False;
  blnVerDirEsp      := True;
  blnGravou         := False;
  blnAlterou        := False;
  blnExcluiu        := False;
  blnUsaAutInc      := True;
  blnVerificaProCod := True;
  strNomeTabela     := '';
  strUltimoCodigo   := '';
  strOrderOpc       := '';

  pInicializaIndices;

  cdsTrcChqAvisPre := fCriaCdsCheques(Self);
  cdsChqOutroTip   := FCriaCdsCheques(Self);

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := False;
end;

procedure TfrmPaiCadCds.pOnStateChange;
begin
  pSetButton(cdsTabela, btnIncluir, btnGravar, btnExcluir, btnCancela, btnAlterar, btnPesquisa, btnSair);
end;

procedure TfrmPaiCadCds.btnGravarClick(Sender: TObject);
  Var
    strCodEmp: String;
    blnTransacaoExterna : Boolean;
begin
  inherited;
  Try
    blnGravou := False;

    pnlInfo.Caption := 'Gravando registro! Aguarde....';
    If (cdsTabela.State = dsInsert) Or (cdsTabela.State = dsEdit) Then
    Begin

      If (Not fVerificaCampos) Then
      Begin
        pnlInfo.Caption := '';
        Exit;
      End;

      If (cdsTabela.State = dsInsert)  And
         (Length(arrCamposChave) > 0)  And
         (fBuscaPorCamposChave(False)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Já existe um registro com esses dados! Favor verificar.', ['&Ok']);
        Exit;
      End;

      blnTransacaoExterna := frmModulo.GetCurrentConnection.InTransaction;

      If (Not blnTransacaoExterna) Or (blnStartTransactionNoPaiMasCommitRoolBackNoFilho) Then
        fStartTransaction;

      pLimpaDatasVazias;

      If (blnUsaProCodigo) And (cdsTabela.State = dsInsert) Then
      Begin
        cdsTabela.FieldByName(strNomeCampo).AsString := fProximoCodigo;
      End;
      strUltimoCodigo := cdsTabela.FieldByName(strNomeCampo).AsString;

      If Not fEmptyStr(strCampoEmp) Then
        If fEmptyStr(cdsTabela.FieldByName(strCampoEmp).AsString) Then
          cdsTabela.FieldByName(strCampoEmp).AsString := VS_strCodEmp;

      If (cdsTabela.State = dsInsert)                       And
         (cdsTabela.FieldDefList.Find('AUTOINCREM') <> Nil) And
         (blnVerificaProCod)                                Then
      Begin
        If fEmptyStr(strCampoEmp) Then
          strCodEmp := VS_strCodEmp
        Else
          strCodEmp := cdsTabela.FieldByName(strCampoEmp).AsString;

        cdsTabela.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem(strNomeTabela, VS_strCodEmp);
      End;

      cdsTabela.Post;

      pOnStateChange;
      pEnabled(Self, False);
      If btnIncluir.CanFocus Then
        pSetFocus(btnIncluir)

      Else If btnPesquisa.CanFocus Then
        pSetFocus(btnPesquisa);

      pnlInfo.Caption := '';

      If (Not blnTransacaoExterna) And (Not blnStartTransactionNoPaiMasCommitRoolBackNoFilho) Then
        fCommit;

      blnGravou := True;
    End;
  Except
    On E: EUniError Do
    Begin
      If E.ErrorCode = ERROR_PRIMARY_KEY_INSERT Then
      Begin
        fRollBack;
        pMensagensErro(E.Message,'Já existe um registro com esses Dados!', '[ Gravar registro ]');
      End
      Else
      Begin
        fRollBack;
        pMensagensErro(IntToStr(E.ErrorCode) + ': ' + E.Message, '[ Gravar registro ]');
      End;
      blnGravou := False;
    End;

    On E: Exception Do
    Begin
      fRollBack;
      blnGravou := False;
      pnlInfo.Caption := '';
      pMensagensErro(E.Message, 'Gravar Registro');
    End;
  End;

  If Not blnGravacaoFisica Then
    cdsBusCamChave.Data := cdsTabela.Data;
end;

procedure TfrmPaiCadCds.btnAlterarClick(Sender: TObject);
begin
  If Not blnGravacaoFisica Then
    cdsBusCamChave.Data := cdsTabela.Data;

  inherited;
  Try
    If cdsTabela.IsEmpty Then
    Begin
     fMensagem('AVISO', 'Favor escolher um registro para essa operação!', ['&Ok']);
     Exit;
    End;

    blnMudarFoco := True;
    cdsTabela.Edit;
    pOnStateChange;
    pEnabled(Self, True);
    SelectNext((ActiveControl), True, True);
    blnAlterou := True;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, 'Altera Registro');
    End;
  End;
end;

procedure TfrmPaiCadCds.btnExcluirClick(Sender: TObject);
  Var
    qryGen: TUniQuery;
    strSQL: String;
    blnTransacaoExterna: Boolean;
begin
  inherited;

  blnExcluiu := False;

  If cdsTabela.IsEmpty Then
  Begin
    fMensagem('AVISO', 'Favor escolher um registro para essa operação!', ['&Ok']);
    Exit;
  End;

  If fMensagem('AVISO', 'Deseja realmente excluir esse registro?', ['&Sim', '&Não']) = 1 Then
  Begin
    Try
      blnTransacaoExterna := frmModulo.GetCurrentConnection.InTransaction;

      If (Not blnTransacaoExterna) Or (blnStartTransactionNoPaiMasCommitRoolBackNoFilho) Then
        fStartTransaction;

      if not fExecutaAntesDoDelete then
      begin
        If (Not blnTransacaoExterna) And (Not blnStartTransactionNoPaiMasCommitRoolBackNoFilho) Then
          fRollBack;
        Exit;
      end;

      If blnGravacaoFisica Then
      Begin
        qryGen := fCriaQuery;

        strSQL := fVerificaIntegridade(Self.Name, strNomeTabela, cdsTabela, False);
      End;

      cdsTabela.Delete;

      If blnGravacaoFisica Then
      Begin
        With qryGen Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(strSQL);
          ExecSQL;
          Close;
        End;

        FreeAndNil(qryGen);
        If btnIncluir.CanFocus Then
          pSetFocus(btnIncluir)

        Else If btnPesquisa.CanFocus Then
          pSetFocus(btnPesquisa);
      End;

      If (Not blnTransacaoExterna) And (Not blnStartTransactionNoPaiMasCommitRoolBackNoFilho) Then
        fCommit;

      blnExcluiu := True;
    Except
      On E: EUniError Do
      Begin
        fRollBack;
        FreeAndNil(qryGen);
        pMensagensErro(IntToStr(E.ErrorCode) + ': ' + E.Message, ' [ Excluir registro ] ');
      End;
      On E: Exception Do
      Begin
        fRollBack;
        FreeAndNil(qryGen);
        pMensagensErro(E.Message, 'Excluir registro');
      End;
    End;
  End;

  If Not blnGravacaoFisica Then
    cdsBusCamChave.Data := cdsTabela.Data;

end;

procedure TfrmPaiCadCds.btnCancelaClick(Sender: TObject);
begin
  inherited;
  If (cdsTabela.State = dsInsert) Or (cdsTabela.State = dsEdit) Then
  Begin
    Try
      cdsTabela.CancelUpdates;
      pOnStateChange;
      pEnabled(Self, False);
      If btnIncluir.CanFocus Then
        pSetFocus(btnIncluir)

      Else If btnPesquisa.CanFocus Then
        pSetFocus(btnPesquisa);
        
      pnlInfo.Caption := '';
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, 'Cancelar operação');
      End;
    End;
  End;

  If Not blnGravacaoFisica Then
    cdsBusCamChave.Data := cdsTabela.Data;

end;

procedure TfrmPaiCadCds.FormShow(Sender: TObject);
  Var
    strDireitos: String;
    intContador: Integer;
    strSQL: String;
begin
  inherited;

  dspTabela.DataSet := qryTabela;

  If blnVerDirEsp Then
  Begin

    If fValidarDirEspecificos(strDireitos, strLoginUsuarioLogado, Self.Name) Then
    Begin

      {* INSERÇÃO *}
      If Pos('I', strDireitos) > 0 Then
        btnIncluir.Visible := True
      Else
        btnIncluir.Visible := False;

      {* ALTERAÇÃO *}
      If Pos('A', strDireitos) > 0 Then
        btnAlterar.Visible := True
      Else
        btnAlterar.Visible := False;

      {* EXCLUIR *}
      If Pos('E', strDireitos) > 0 Then
        btnExcluir.Visible := True
      Else
        btnExcluir.Visible := False;

    End;

    If ((Self.ActiveControl) = Nil) Then
      pSetFocus(btnPesquisa);

  End;

  {*****************************************}
  {* SALVA O SQL ORIGINAL DA TABELA        *}
  {**************************************MV*}
  If blnGravacaoFisica Then
    strSQLCadastro := qryTabela.SQL.Text;

  {*****************************************}
  {* NECESSÁRIO PARA QUE ENTRE NAS TELAS DE*}
  {* CADASTRO COM A TABELA VAZIA           *}
  {**************************************MV*}
  If blnGravacaoFisica Then
  Begin
    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  * ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + strNomeTabela;

    If blnUsaAutInc Then
    Begin
      strSQL := strSQL + ' WHERE ';
      strSQL := strSQL + '  FALSE ';
    End;

    fAbrirTabelaCadastro(strSQL);
  End;

  pEnabled(Self, False);
  pOnStateChange;
  strCampoEmp := fRetCampoEmpresa;

  If Not blnGravacaoFisica Then
  Begin
    cdsBusCamChave := fCriaClientDatset(cdsTabela);
    For intContador := 0 To Length(arrCamposChave) -1 Do
      cdsTabela.IndexFieldNames := cdsTabela.IndexFieldNames + (arrCamposChave[intContador] As TDBEdit).Field.FieldName + ';';
  End;
end;

procedure TfrmPaiCadCds.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  If (Assigned(cdsTabela)) And (cdsTabela.State = dsInsert) Then
  Begin
    If fMensagem('AVISO', 'Deseja cancelar a inserção desse registro?', ['&Sim', '&Não']) = 1 Then
    Begin
      Action := CaNone;
      btnCancela.Click;
      Exit;
    End;
    Action := CaNone;
  End
  Else If (Assigned(cdsTabela)) And (cdsTabela.State = dsEdit) Then
  Begin
    If fMensagem('AVISO', 'Deseja cancelar a edição desse registro?', ['&Sim', '&Não']) = 1 Then
    Begin
      Action := CaNone;
      btnCancela.Click;
      Exit;
    End;
    Action := CaNone;
  End;

  If (Action <> CaNone) Then
  Begin

    If blnGravacaoFisica Then
    Begin
      qryTabela.Close;
      qryTabela.SQL.Clear;
      qryTabela.SQL.Add(strSQLCadastro);
    End;

    If Assigned(stlCampos) Then
      FreeAndNil(stlCampos);

    If Assigned(stlCamInd) Then
      FreeAndNil(stlCamInd);

    If Assigned(stlDesInd) Then
      FreeAndNil(stlDesInd);

    if Assigned(cdsBusCamChave) then
      FreeAndNil(cdsBusCamChave);

    If Assigned(cdsTrcChqAvisPre) Then
      FreeAndNil(cdsTrcChqAvisPre);

    If Assigned(cdsChqOutroTip) Then
      FreeAndNil(cdsChqOutroTip);

    inherited;
  End;
end;

{*****************************************}
{* FUNÇÃO USADA PARA VALIDAR OS CAMPOS.  *}
{* ESSA FUNÇÃO DEVE SER SOBREPOSTA NO    *}
{* QUE HERDAR DO 'frmPaiCadCds'.            *}
{**************************************MV*}
{function TfrmPaiCadCds.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
begin
  Result := False;
  If (ActiveControl) = btnCancela Then
  Begin
    Result := True;
    Exit;
  End;
end;}

{*****************************************}
{* FUNÇÃO QUE É EXECUTADA QUANDO O BOTÃO *}
{* GRAVAR É ACIONADO. VERIFICA TODOS OS  *}
{* CAMPOS E CASO OCORRA ALGUMA FALHA NA  *}
{* VERIFICAÇÃO, FOCA TAL CAMPO.          *}
{**************************************MV*}
{function TfrmPaiCadCds.fVerificaCampos: Boolean;
  Var
    intContador1: Integer;
    intContador2: Integer;
    intContador3: Integer;
    AbaAtual: TTabSheet;
    CurrPanel: TPanel;
    CurrScroll: TScrollBox;
    Contr: TWinControl;
begin
  Result := fVerificaSubObjeto(Self);
{  Contr  := Nil;
  Result := True;
  For intContador1 := 0 To pgcDados.PageCount - 1 Do
  Begin

    pgcDados.ActivePageIndex := intContador1;
    AbaAtual := pgcDados.Pages[intContador1];
    For intContador2 := 0 To AbaAtual.ControlCount -1 Do
    Begin
      Try
        If (AbaAtual.Controls[intContador2] Is TPanel) Then
        Begin
          CurrPanel := (AbaAtual.Controls[intContador2] As TPanel);
          For intContador3 := 0 To CurrPanel.ControlCount - 1 Do
          Begin
            Contr := TWinControl(CurrPanel.Controls[intContador3]);
            If Contr.Tag = 99 Then
              Result := fValidaCampos(Contr, False);

            If Not Result Then
              Break;
          End;
        End
        Else If (AbaAtual.Controls[intContador2] Is TScrollBox) Then
        Begin
          CurrScroll := (AbaAtual.Controls[intContador2] As TScrollBox);
          For intContador3 := 0 To CurrScroll.ControlCount - 1 Do
          Begin
            Contr := TWinControl(CurrScroll.Controls[intContador3]);
            If Contr.Tag = 99 Then
              Result := fValidaCampos(Contr, False);

            If Not Result Then
              Break;
          End;
        End
        Else
        Begin
          Contr := TWinControl(AbaAtual.Controls[intContador2]);
          If Contr.Tag = 99 Then
            Result := fValidaCampos(Contr, False);
        End;
      Except
        On E: Exception Do
        Begin
          fMensagem('', 'Erro durante a validação do campo: ' + Contr.Name, ['&Ok']);
        End;
      End;

      If Not Result Then
        Exit;
    End;

  End;
end;  }

procedure TfrmPaiCadCds.btnPesquisaClick(Sender: TObject);
begin
  inherited;
end;

{*****************************************}
{* FUNÇÃO QUE É ATRIBUIDA NO EVENTO      *}
{* 'OnKeyDown' DOS Edits. (continua...)  *}
{**************************************MV*}
(*ocedure TfrmPaiCadCds.pOnKeyDownEdits(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
{  If Not blnMudarFoco Then
  Begin
    blnMudarFoco := True;
    Exit;
  End;}

  If (Key = VK_Return) Then
  Begin
    pProximoControle(Sender);
  End
  Else If (Key = VK_Escape) Then
  Begin
    If (Assigned(cdsTabela)) And (cdsTabela.State = dsInsert) Then
    Begin
      If fMensagem('AVISO', 'Deseja cancelar a inserção desse registro?', ['&Sim', '&Não']) = 1 Then
      Begin
        btnCancela.Click;
      End;
    End
    Else If (Assigned(cdsTabela)) And (cdsTabela.State = dsEdit) Then
    Begin
      If fMensagem('AVISO', 'Deseja cancelar a edição desse registro?', ['&Sim', '&Não']) = 1 Then
      Begin
        btnCancela.Click;
      End;
    End
    Else
      btnSair.Click;
  End;
end;*)

procedure TfrmPaiCadCds.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
(*  If ((ActiveControl.ClassType) = TBitBtnLocked)Then
  Begin
    If (Key = VK_Escape) Then
      pOnKeyDown(Sender, Key, Shift);
  End
  {*****************************************}
  {* VER EM QUAL UNIT FICA A CLASS TGROUP -*}
  {* BUTTON, ADICIONALA E MUDAR ESSE 'IF'  *}
  {**************************************MV*}
  Else If ((ActiveControl.ClassName) = 'TGroupButton') Then
  Begin
    pOnKeyDown(Sender, Key, Shift);
  End*)
end;

(*procedure TfrmPaiCadCds.pOnKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
{  If Not blnMudarFoco Then
  Begin
    blnMudarFoco := True;
    Exit;
  End;}

  If (Key = VK_Return) Then
  Begin
    SelectNext((ActiveControl), True, True);
  End
  Else If (Key = VK_Escape) Then
  Begin
    If (cdsTabela.State = dsInsert) Then
    Begin
      If fMensagem('AVISO', 'Deseja cancelar a inserção desse registro?', ['&Sim', '&Não']) = 1 Then
      Begin
        btnCancela.Click;
      End;
    End
    Else If (cdsTabela.State = dsEdit) Then
    Begin
      If fMensagem('AVISO', 'Deseja cancelar a edição desse registro?', ['&Sim', '&Não']) = 1 Then
      Begin
        btnCancela.Click;
      End;
    End
    Else
      btnSair.Click;
  End;
end;*)

function TfrmPaiCadCds.fBuscaChqOutroTipo: Boolean;
  Var
    intContador: Integer;
    arrCodAnt: Array Of String;
begin
  Result := False;

  If cdsChqOutroTip.IsEmpty Then
    Exit;

  SetLength(arrCodAnt, Length(arrCamposChave));

  If Length(arrCamposChave) > 0 Then
    For intContador := 0 To Length(arrCamposChave) -1 Do
      arrCodAnt[intContador] := (arrCamposChave[intContador] As TDBEdit).Text;

  If (cdsChqOutroTip.Locate(cdsTabela.IndexFieldNames,arrCodAnt,[])) Then
    Result := True;
end;

{*****************************************}
{* FAZ UMA BUSCA NA TABELA ATUAL, FIL-   *}
{* TRANDO PELOS CAMPOS INDICADOS NA MA-  *}
{* TRIZ 'arrCamposChave'. CASO ENCONTRE  *}
{* UM REGISTRO, CARREGA NA TELA E PASSA  *}
{* A TABELA PARA MODO DE EDIÇÃO, SENÃO,  *}
{* LIMPA A TELA E PASSA A TABELA PARA MO-*}
{* DO DE INSERÇÃO                        *}
{**************************************MV*}
function TfrmPaiCadCds.fBuscaPorCamposChave(blnEditar: Boolean = True): Boolean;
  Var
    strSQL: String;
    intContador: Integer;
    dbeCampoChave: TDBEdit;
    arrCodAnt: Array Of String;
    qryGenTab: TUniQuery;
    dsStatus: TDataSetState;
    intRegEdit: Integer;
begin

  Result := False;
  dsStatus := dtsTabela.State;

  Try

    If blnGravacaoFisica Then
    Begin
      qryGenTab := fCriaQuery(Self);

      Result := False;
      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '  * ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + strNomeTabela;

      SetLength(arrCodAnt, Length(arrCamposChave));
      If Length(arrCamposChave) > 0 Then
      Begin
        strSQL := strSQL + ' WHERE ';
        For intContador := 0 To Length(arrCamposChave) -1 Do
        Begin
          dbeCampoChave := (arrCamposChave[intContador] As TDBEdit);

    //      strSQL := strSQL + dbeCampoChave.Field.FieldName + ' = ';
          strSQL := strSQL + dbeCampoChave.Field.FieldName;

          If (dbeCampoChave.Field.DataType = ftDate) Then
            strSQL := strSQL + ' = ' + QuotedStr(FormatDateTime('yyyy-mm-dd', StrToDate(dbeCampoChave.Text)))
          Else
          Begin
            If fEmptyStr(dbeCampoChave.Text) Then
              strSQL := strSQL + ' IS NULL '
            Else
              strSQL := strSQL + ' = ' + QuotedStr(dbeCampoChave.Text);
          End;

          arrCodAnt[intContador] := dbeCampoChave.Text;

          If (intContador < Length(arrCamposChave) -1) Then
            strSQL := strSQL + ' AND ';
        End;
      End;

      With qryGenTab Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        Open;

        If Not IsEmpty Then
        Begin
          If (blnEditar) Then
          Begin
            cdsTabela.CancelUpdates;
            fAbrirTabelaCadastro(strSQL);
            cdsTabela.Edit;
          End;
          Result := True;
        End
        Else If cdsTabela.State = dsEdit Then
        Begin
          cdsTabela.CancelUpdates;
          cdsTabela.Insert;

          For intContador := 0 To Length(arrCodAnt) -1 Do
          Begin
            (arrCamposChave[intContador] As TDBEdit).Text := arrCodAnt[intContador];
          End;
        End;
      End;

    End
    Else
    Begin
      If (dsStatus = dsEdit) And (blnResCai Or blnCtaRec) Then
      Begin
        intRegEdit := cdsTabela.RecNo;
        SetLength(arrCodAnt, Length(arrCamposChave));

        If Length(arrCamposChave) > 0 Then
          For intContador := 0 To Length(arrCamposChave) -1 Do
            arrCodAnt[intContador] := (arrCamposChave[intContador] As TDBEdit).Text;

        If (cdsBusCamChave.Locate(cdsTabela.IndexFieldNames,arrCodAnt,[])) Then
          If (intRegEdit <> cdsBusCamChave.RecNo) Then
            Result := True;
      End
      Else
      Begin
        SetLength(arrCodAnt, Length(arrCamposChave));

        If Length(arrCamposChave) > 0 Then
          For intContador := 0 To Length(arrCamposChave) -1 Do
            arrCodAnt[intContador] := (arrCamposChave[intContador] As TDBEdit).Text;

        If cdsBusCamChave.Locate(cdsTabela.IndexFieldNames,arrCodAnt,[]) Then
        Begin
          cdsTabela.Cancel;
          cdsTabela.Locate(cdsTabela.IndexFieldNames,arrCodAnt,[]);

          If (blnEditar) Then cdsTabela.Edit;
          Result := True;
        End
        Else If dsStatus In [dsEdit] Then
        Begin
          cdsTabela.Cancel;
          cdsTabela.Insert;
          For intContador := 0 To Length(arrCodAnt) -1 Do
            (arrCamposChave[intContador] As TDBEdit).Text := arrCodAnt[intContador];
        End;
      End;
    End;

  Finally
    FreeAndNil(qryGenTab);
  End;

end;

function TfrmPaiCadCds.fBuscaTrocChqAvisPre: Boolean;
  Var
    intContador: Integer;
    arrCodAnt: Array Of String;
begin
  Result := False;

  If cdsTrcChqAvisPre.IsEmpty Then
    Exit;

  SetLength(arrCodAnt, Length(arrCamposChave));

  If Length(arrCamposChave) > 0 Then
    For intContador := 0 To Length(arrCamposChave) -1 Do
      arrCodAnt[intContador] := (arrCamposChave[intContador] As TDBEdit).Text;

  If (cdsTrcChqAvisPre.Locate(cdsTabela.IndexFieldNames,arrCodAnt,[])) Then
    Result := True;
end;

function TfrmPaiCadCds.fExecutaAntesDoDelete: Boolean;
begin
  Result := True;
  {*****************************************************}
  { IMPLEMENTAR NO FORMULÁRIO FILHO PARA RODAR ROTINAS  }
  { QUE DEVAM SER EXECUTADAS ANTES QUE O FORMULARIO     }
  { PAI EFETIVAMENTE EXCLUA O REGISTRO                  }
  {**************************************************GD*}
end;

{*****************************************}
{* LIMPA TODOS OS CAMPOS, EXCETO OS QUE  *}
{* ESTÃO NA MATRIZ 'arrCamposChave'      *}
{**************************************MV*}
procedure TfrmPaiCadCds.pLimparCampos;
  Var
    intContador1: Integer;
    intContador2: Integer;
    blnLimpa: Boolean;
begin
  For intContador1 := 0 To Self.ComponentCount -1 Do
  Begin
    blnLimpa := True;

    For intContador2 := 0 To Length(arrCamposChave) -1 Do
    Begin
      If arrCamposChave[intContador2] = Self.Components[intContador1] Then
      Begin
        blnLimpa := False;
        Break;
      End;
    End;

    If blnLimpa Then
    Begin
      If (Self.Components[intContador1] Is TDBEditFocus) Then
        (Self.Components[intContador1] As TDBEditFocus).Clear

      Else If (Self.Components[intContador1] Is TEditFocus) Then
        (Self.Components[intContador1] As TEditFocus).Clear;
    End;
    
  End;
end;

{*****************************************}
{* RETORNA O CAMPO REFERENTE À EMPRESA   *}
{**************************************MV*}
function TfrmPaiCadCds.fRetCampoEmpresa: String;
  Var
    intContador: Integer;
begin

  Result := '';

  {*****************************************}
  {* CASO FOR O CADASTRO DE EMPRESA, SAI   *}
  {**************************************MV*}
  If strNomeTabela = 'CADEMP' Then
    Exit;
    
  For intContador := 0 To cdsTabela.FieldCount -1 Do
  Begin
    If Pos('CODEMP', cdsTabela.Fields[intContador].FieldName) > 0 Then
    Begin
      Result := cdsTabela.Fields[intContador].FieldName;
      Break;
    End;
  End;
end;

procedure TfrmPaiCadCds.mnuConfigurarRelClick(Sender: TObject);
begin
  inherited;
  // nao remover este comentario, pois o evento deixara de funcionar
  // esta vinculado ao direito de acesso ao frmcadconfrelatorio
  // rl
end;

procedure TfrmPaiCadCds.pProximaPagina;
begin
  If pgcDados.ActivePage.Tag < intPaginasAtivas Then
  Begin
    pgcDados.SelectNextPage(True);
    blnMudarFoco := False;
  End;
end;

procedure TfrmPaiCadCds.pAtribuiTags;
  Var
    intContador1: Integer;
    intTags: Integer;
begin
  intContador1 := 0;
  intTags      := 1;
  While intContador1 < pgcDados.PageCount Do
  Begin
    pgcDados.ActivePageIndex := intContador1;
    If pgcDados.ActivePage.TabVisible Then
    Begin
      pgcDados.ActivePage.Tag := intTags;
      Inc(intTags);
    End;
    Inc(intContador1);
  End;
end;

function TfrmPaiCadCds.fProximoCodigo: String;
begin
  Result := fAtualizaProCod(strNomeTabela, strNomeCampo);
end;

procedure TfrmPaiCadCds.pZeraCamposNumericos;
  Var
    intContador: Integer;
begin
  For intContador := 0 To cdsTabela.FieldCount -1 Do
  Begin
    If (cdsTabela.Fields[intContador].DataType = ftInteger)  Or
       (cdsTabela.Fields[intContador].DataType = ftFloat)    Or
       (cdsTabela.Fields[intContador].DataType = ftCurrency) Then
    Begin
      If cdsTabela.Fields[intContador].FieldName <> 'AUTOINCREM' Then
        cdsTabela.Fields[intContador].Value := 0;
    End;
  End;
end;

{function TfrmPaiCadCds.fValidaPanel(pnlPanel: TPanel; blnBuscaPorChave: Boolean = False): Boolean;
  Var
    intContador: Integer;
begin

  Result := True;

  For intContador := 0 To pnlPanel.ControlCount -1 Do
  Begin

    If pnlPanel.Controls[intContador].Tag = 99 Then
      Result := fValidaCampos(TWinControl(pnlPanel.Controls[intContador]), blnBuscaPorChave);

    If Not Result Then
      Break;

  End;

end; }

{*********************************}
{* VERIFICA TODOS OS COMPONENTES *}
{* DENTRO DE PANEL OU SCROLLBOX  *}
{* (RECURSIVO)                   *}
{******************************AF*}
(*function TfrmPaiCadCds.fVerificaSubObjeto(objObjeto: TWinControl): Boolean;
  Var
    intContador: Integer;
Begin
  Result := True;

  For intContador := 0 To objObjeto.ComponentCount -1 Do
  Begin
    {**********************************}
    {* SE O COMPONETE FOR UM PANEL OU *}
    {* UM SCROLLBOX                   *}
    {*******************************AF*}
    If (objObjeto.Components[intContador] Is TPanel)     Or
       (objObjeto.Components[intContador] Is TScrollBox) Or
       (objObjeto.Components[intContador] Is TTabSheet)  Then
    Begin
      Result := fVerificaSubObjeto((objObjeto.Components[intContador] As TWinControl));

      If Not Result Then
        Exit;

    End
    Else
    Begin
      {**************************************}
      {* SE A TAG DO COMPONENTES = 99 ENTÃO *}
      {***********************************AF*}
      If objObjeto.Components[intcontador].Tag = 99 Then
        Result := fValidaCampos((objObjeto.Components[intContador] As TWinControl), False);

        If Not Result Then
          Exit;
    End;

  End;

End;*)

procedure TfrmPaiCadCds.pLimpaDatasVazias;
  Var
    intContador: Integer;
begin

  For intContador := 0 To cdsTabela.FieldCount -1 Do
  Begin

    If (cdsTabela.Fields[intContador].DataType = ftDate)     Or
       (cdsTabela.Fields[intContador].DataType = ftDateTime) Or
       (cdsTabela.Fields[intContador].DataType = ftTime)     Then
    Begin
      If (fEmptyStr(cdsTabela.Fields[intContador].AsString)) Then
        cdsTabela.Fields[intContador].Value := Null;
    End;

  End;

end;

function TfrmPaiCadCds.fAbrirTabelaCadastro(strSql: String): Boolean;
begin
  Try
    With qryTabela, Sql Do
    Begin
      Close;
      cdsTabela.Close;
      If Not fEmptyStr(strSql) Then
      Begin
        Clear;
        Add(strSql);
      End;
      Open;

      If FindField('AUTOINCREM') <> Nil Then
      Begin
        dspTabela.UpdateMode := upWhereKeyOnly;
        FieldByName('AUTOINCREM').ProviderFlags := [pfInKey, pfInWhere, pfInUpdate];
      End;

      cdsTabela.Open;
      Result := True;
    End;
  Except
    On E : Exception Do
    Begin
			pMensagensErro(E.Message,'[TfrmPaiCadCds.fAbreConsulta]');
      Result := False;
    End;
  End;
end;

procedure TfrmPaiCadCds.cdsTabelaAfterPost(DataSet: TDataSet);
begin
  inherited;
  If blnGravacaoFisica Then cdsTabela.ApplyUpdates(0);
end;

procedure TfrmPaiCadCds.cdsTabelaAfterDelete(DataSet: TDataSet);
begin
  inherited;
  If blnGravacaoFisica Then cdsTabela.ApplyUpdates(0);
end;

end.

