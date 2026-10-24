unit Contabilidade.View.TfrmPaiCadContabilidade;

interface

uses
  Windows, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Contabilidade.View.TfrmPaiContabilidade, ComCtrls, Buttons, ExtCtrls, DB, Uni, DBEditFocus,
  DBCtrls, DBComboBoxFocus, EditFocus, MaskEditFocus, Menus,
  AppEvnts, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmPaiCadContabilidade = class(TfrmPaiContabilidade)
    pgcDados: TPageControl;
    tbsGeral: TTabSheet;
    btnIncluir: TBitBtnLocked;
    btnGravar: TBitBtnLocked;
    btnCancela: TBitBtnLocked;
    btnExcluir: TBitBtnLocked;
    btnPesquisa: TBitBtnLocked;
    btnAlterar: TBitBtnLocked;
    procedure btnIncluirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure mnuConfigurarRelClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
  private
    { Private declarations }
    strSQLCadastro: String;

    procedure pLimpaDatasVazias;
    procedure pProximoCodigoGravar(var strCodEmp:string);
    procedure pDireitos(const ADireitos: string);
    function fPodeExcluir():boolean;
    procedure pMontaWhereBuscaCodigos(var strSQL: string; dbeCampoChave: TDbEdit) ;
    procedure pDesalocaCanClose ;

    function fRetCampoEmpresa: String;
    function fProximoCodigoTplaco: String;
  protected
    intFocoBotao: Integer;
    intPaginasAtivas: Integer;
    arrCamposChave: Array Of TWinControl;

    blnUsaAutInc: Boolean;
    blnUsaProCodigo: Boolean;
    blnUsaProTpl: Boolean;
    blnVerificaProCod: Boolean;
    strNomeTabela: String;
    strNomeCampo: String;
    strCampoEmp: String;
    strCampoTplaco: String;

    {*****************************************}
    {* ESSA VARIAVEL ADICIONA MAIS UM OU     *}
    {* MAIS PARAMETROS PARA A PESQUISA       *}
    {**************************************MV*}
    strOrderOpc: String;

    blnExcluiu: Boolean;
    blnAlterou: Boolean;
    blnGravou: Boolean;
    blnStartTransactionNoPaiMasCommitRoolBackNoFilho: Boolean;
    
    {*******************************************}
    {* VARIAVEL QUE SE TRUE, FAZ A VERIFICAÇÃO *}
    {* ESPECIFICA E SE SETADA PARA FALSE NÃO   *}
    {* VERIFICA                                *}
    {****************************************AF*}
    blnVerDirEsp: Boolean;

    {*********************************************}
    {*VARIAVEL PARA QUANDO O OPERADOR NÃO POSSUIR*}
    {*NEM UM DIREITO ESPEFICICO O SISTEMA MESMO  *}
    {*ASSIM ENTRAR NA VALIDAÇAO PARA RETIRAR     *}
    {*TODOS OS ACESSO.                           *}
    {***************************REQ:195052******MT}
    FEmptyDirEsp: Boolean;

    {*************************************************}
    {* VARIAVEL QUE DEFINE SE DEVE EXIBIR A MSG DE   *}
    {* EXCLUSÃO. SE ELA FOR FALSE, NÃO IRÁ PERGUNTAR *}
    {* E IRÁ EXCLUIR DIRETO O REGISTRO               *}
    {**********************************************FC*}

    blnPerguntarParaExcluir: Boolean;
    blnUsaVerificaCamposPai: Boolean;

    strMensagemExclusao: String;

    strLocalErro: String;

    function fProximoCodigo: String; virtual;

    {*******************************************}
    {* FUNÇÕES DE VALIDAÇÃO!                   *}
    {****************************************MV*}
    function fBuscaPorCamposChave(blnEditar: Boolean = True): Boolean; virtual;

    procedure pOnStateChange;virtual;
    procedure pInicializaIndices; virtual; abstract;
    procedure pLimparCampos;
    procedure pProximaPagina;virtual;
    procedure pAtribuiTags;
    procedure pZeraCamposNumericos;

    procedure pDestravarRegistros; virtual;

    function fExecutaAntesDoDelete : Boolean; virtual;
  public
    { Public declarations }
    strNomeForm     : String;
    strNomeFormPesq : String;
    blnIncluiBuscaPorChave: Boolean;
    blnChangeEnabledButton: Boolean;
    {*************************************************}
    {* Quando esta variavel = true                   *}
    {* não carregará o campo referente ao Cod Emp    *}
    {**********************************************WG*}
    blnIgnorarCodEmp: Boolean;

    procedure pGravaRegistro;
  end;

implementation

uses  SysUtils, StrUtils, untfuncoesSimples, untConstantes, Mask, untModulo,
      Contabilidade.Funcoes, Contabilidade.Classes.ProximoCodigoTPlaco,
      untTypesSistema, untFuncoesGenerica;

{$R *.dfm}

procedure TfrmPaiCadContabilidade.btnIncluirClick(Sender: TObject);
begin
  inherited;
  Try
    pValidaProCod(strNomeTabela);

    If (Not qryTabela.Active) Then
    Begin
      pnlInfo.Caption := 'Aguarde, abrindo arquivo...';
      Application.ProcessMessages;
      fAbrirTabela(qryTabela);
      pnlInfo.Caption := '';
      Application.ProcessMessages;
    End;

    pgcDados.ActivePageIndex := 0;

    qryTabela.Insert;
    pEnabled(Self, True);
    if blnChangeEnabledButton Then
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

procedure TfrmPaiCadContabilidade.btnPesquisaClick(Sender: TObject);
begin
  inherited;

  //
end;

procedure TfrmPaiCadContabilidade.FormCreate(Sender: TObject);
begin
  inherited;
  intFocoBotao := 1;
  blnChangeEnabledButton := True;
  strLocalErro      := '';
  blnVerDirEsp      := True;
  FEmptyDirEsp      := False;
  blnGravou         := False;
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := False;
  blnAlterou        := False;
  blnExcluiu        := False;
  blnUsaAutInc      := True;
  blnVerificaProCod := True;
  blnUsaProTpl      := False;
  blnIgnorarCodEmp  := False;
  strNomeTabela     := '';
  strUltimoCodigo   := '';
  strOrderOpc       := '';
  strMensagemExclusao := '';
  strCampoTplaco    := '';

  blnPerguntarParaExcluir := True;
  blnUsaVerificaCamposPai := True;

  blnIncluiBuscaPorChave := True;

  pInicializaIndices;

end;

procedure TfrmPaiCadContabilidade.pOnStateChange;
begin
  pSetButton(qryTabela, btnIncluir, btnGravar, btnExcluir, btnCancela, btnAlterar, btnPesquisa, btnSair);
end;

procedure TfrmPaiCadContabilidade.btnGravarClick(Sender: TObject);
Begin
  inherited;
  pGravaRegistro;
End;

procedure TfrmPaiCadContabilidade.pGravaRegistro;
  Var
    strCodEmp: String;
    blnTransacaoExterna: Boolean;
begin
  Try
    blnGravou := False;

    pnlInfo.Caption := 'Gravando registro! Aguarde....';
    If (qryTabela.State = dsInsert) Or (qryTabela.State = dsEdit) Then
    Begin

      If (blnUsaVerificaCamposPai) And (Not fVerificaCampos) Then
      Begin
        pnlInfo.Caption := '';
        Exit;
      End;

      If (qryTabela.State = dsInsert)  And
         (Length(arrCamposChave) > 0)  And
         (fBuscaPorCamposChave(False)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Já existe um registro com esses dados! Favor verificar.', ['&Ok']);
        Exit;
      End;

      blnTransacaoExterna := frmModulo.Database.InTransaction;

      If (Not blnTransacaoExterna) Or (blnStartTransactionNoPaiMasCommitRoolBackNoFilho) Then
        fStartTransaction;

      pLimpaDatasVazias;

      pProximoCodigoGravar(strCodEmp);

      qryTabela.Post;
      if blnChangeEnabledButton Then
        pOnStateChange;
      pEnabled(Self, False);
      If btnIncluir.CanFocus Then
        pSetFocus(btnIncluir)

      Else If btnPesquisa.CanFocus Then
        pSetFocus(btnPesquisa);

      pnlInfo.Caption := '';
      blnGravou := True;

      If (Not blnTransacaoExterna) And (Not blnStartTransactionNoPaiMasCommitRoolBackNoFilho) Then
        fCommit;
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
end;

procedure TfrmPaiCadContabilidade.btnAlterarClick(Sender: TObject);
begin
  inherited;
  Try
    If qryTabela.IsEmpty Then
    Begin
     fMensagem('AVISO', 'Favor escolher um registro para essa operação!', ['&Ok']);
     Exit;
    End;

    blnMudarFoco := True;
    qryTabela.Edit;
    if blnChangeEnabledButton Then
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

procedure TfrmPaiCadContabilidade.btnExcluirClick(Sender: TObject);
  Var
    qryGen: TUniQuery;
    strSQL: String;
    strInnoDB: String;
    blnPodeExcluir: Boolean;
    blnTransacaoExterna: Boolean;
begin
  blnExcluiu := False;

  inherited;
  blnPodeExcluir := fPodeExcluir;

  If blnPodeExcluir Then
  Begin
    Try
      blnTransacaoExterna := frmModulo.Database.InTransaction;

      If (Not blnTransacaoExterna) Or (blnStartTransactionNoPaiMasCommitRoolBackNoFilho) Then
        fStartTransaction;

      if not fExecutaAntesDoDelete then
      begin
        If (Not blnTransacaoExterna) And (Not blnStartTransactionNoPaiMasCommitRoolBackNoFilho) Then
          fRollBack;
        Exit;
      end;

      qryGen := fCriaQuery;

      strSQL := fVerificaIntegridade(Self.Name, strNomeTabela, qryTabela, False);
      qryTabela.Delete;

      qryGen.Close;
      qryGen.SQL.Clear;
      qryGen.SQL.Add(strSQL);
      qryGen.ExecSQL;
      qryGen.Close;

      FreeAndNil(qryGen);
      If btnIncluir.CanFocus Then
        pSetFocus(btnIncluir)

      Else If btnPesquisa.CanFocus Then
        pSetFocus(btnPesquisa);

      If (Not blnTransacaoExterna) And (Not blnStartTransactionNoPaiMasCommitRoolBackNoFilho) Then
        fCommit;

      blnExcluiu := True;
    Except
      On E: EUniError Do
      Begin
        If E.ErrorCode = ERROR_FOREIGN_KEY_DELETE Then
        Begin
          fRollBack;
          FreeAndNil(qryGen);
          pGravarErro(True, '[ERROR_FOREIGN_KEY_DELETE] - Não é possível excluir esse registro',  E.Message + sLineBreak + fRetornaInformacaoUltimoErroForeignKey(strInnoDB));
          fMensagem('ATENÇÃO!','Não é possível excluir esse registro, pois existe itens relacionados !',['&O K']);
        End
        Else
        Begin
          fRollBack;
          FreeAndNil(qryGen);
          pMensagensErro(IntToStr(E.ErrorCode) + ': ' + E.Message, IIF(strLocalErro <> '', strLocalErro, '[ Excluir registro ]'));
        End;
      End;

      On E: Exception Do
      Begin
        fRollBack;
        FreeAndNil(qryGen);
        pMensagensErro(E.Message, IIF(strLocalErro <> '', strLocalErro, 'Excluir registro'));
      End;
    End;
  End;
  strLocalErro := '';
end;

procedure TfrmPaiCadContabilidade.btnCancelaClick(Sender: TObject);
begin
  inherited;
  If (qryTabela.State = dsInsert) Or (qryTabela.State = dsEdit) Then
  Begin
    Try
      qryTabela.Cancel;
      if blnChangeEnabledButton Then
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
end;

procedure TfrmPaiCadContabilidade.FormShow(Sender: TObject);
  Var
    strDireitos: String;
    strSQL: String;
begin
  inherited;

  If fEmptyStr(strNomeForm) Then
    strNomeForm := Self.Name;

  If blnVerDirEsp Then
  Begin

    If fVerificaDirEspecificos(strDireitos, strLoginUsuarioLogado, strNomeForm) Or FEmptyDirEsp Then
    Begin

      pDireitos(strDireitos);

    End
    Else If Not fEhAdministrador(strLoginUsuarioLogado) Then
    Begin
      btnIncluir.Visible := False;
      btnAlterar.Visible := False;
      btnExcluir.Visible := False;
    End;

    If (Self.ActiveControl) = Nil Then
      pSetFocus(btnPesquisa);

    if fTabelaExiste('DIRESP') then
    begin
      fExecutaSQL('REPLACE INTO DIRESP (DIR_NOMFRM) VALUES ("' + strNomeForm + '")');
    end;
  End;

  {*****************************************}
  {* SALVA O SQL ORIGINAL DA TABELA        *}
  {**************************************MV*}
  strSQLCadastro := qryTabela.SQL.Text;

  {*****************************************}
  {* NECESSÁRIO PARA QUE ENTRE NAS TELAS DE*}
  {* CADASTRO COM A TABELA VAZIA           *}
  {**************************************MV*}
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

  qryTabela.Close;
  qryTabela.SQL.Clear;
  qryTabela.SQL.Add(strSQL);

  fAbrirTabela(qryTabela);
  pEnabled(Self, False);
  if blnChangeEnabledButton Then
    pOnStateChange;
  If not blnIgnorarCodEmp Then
    strCampoEmp := fRetCampoEmpresa;
end;

procedure TfrmPaiCadContabilidade.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  If (Assigned(qryTabela)) And (qryTabela.State = dsInsert) Then
  Begin
    If fMensagem('AVISO', 'Deseja cancelar a inserção desse registro?', ['&Sim', '&Não'], intFocoBotao) = 1 Then
    Begin
      Action := CaNone;
      btnCancela.Click;
      Exit;
    End;
    Action := CaNone;
  End
  Else If (Assigned(qryTabela)) And (qryTabela.State = dsEdit) Then
  Begin
    If fMensagem('AVISO', 'Deseja cancelar a edição desse registro?', ['&Sim', '&Não'], intFocoBotao) = 1 Then
    Begin
      Action := CaNone;
      btnCancela.Click;
      Exit;
    End;
    Action := CaNone;
  End;

  If Assigned(qryTabela) And (qryTabela.IsEmpty) Then
    if not fLock_Unlock(strNomeTabela, False, False, False, EmptyStr, False, 'CAD') then
      Action := caNone;

  If (Action <> CaNone) Then
  Begin
    pDestravarRegistros;

    pDesalocaCanClose ;

    inherited;
  End;
end;

procedure TfrmPaiCadContabilidade.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
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
function TfrmPaiCadContabilidade.fBuscaPorCamposChave(blnEditar: Boolean = True): Boolean;
  Var
    strSQL: String;
    intContador: Integer;
    dbeCampoChave: TDBEdit;
    arrCodAnt: Array Of String;
    qryGenTab: TUniQuery;
begin
  Try

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

        If fEmptyStr(dbeCampoChave.Text) Then
          strSQL := strSQL + '(';

        strSQL := strSQL + dbeCampoChave.Field.FieldName;

        pMontaWhereBuscaCodigos(strSQL, dbeCampoChave) ;

        If fEmptyStr(dbeCampoChave.Text) Then
          strSQL := strSQL + ')';

        arrCodAnt[intContador] := dbeCampoChave.Text;

        If (intContador < Length(arrCamposChave) -1) Then
          strSQL := strSQL + ' AND ';
      End;
    End;

    qryGenTab.Close;
    qryGenTab.SQL.Clear;
    qryGenTab.SQL.Add(strSQL);
    qryGenTab.Open;

    If Not qryGenTab.IsEmpty Then
    Begin
      If (blnEditar) Then
      Begin
        qryTabela.Cancel;
        qryTabela.Close;
        qryTabela.SQL.Clear;
        qryTabela.SQL.Add(strSQL);
        qryTabela.Open;
        qryTabela.Edit;
      End;
      Result := True;

      blnMudarFoco := False;
      btnCancela.Click;
      pSetFocus(btnAlterar);

    End
    Else If (qryTabela.State = dsEdit) And blnIncluiBuscaPorChave Then
    Begin
      qryTabela.Cancel;
      qryTabela.Insert;

      For intContador := 0 To Length(arrCodAnt) -1 Do
      Begin
        (arrCamposChave[intContador] As TDBEdit).Text := arrCodAnt[intContador];
      End;
    End;

  Finally
    FreeAndNil(qryGenTab);
  End;

end;

{*****************************************}
{* LIMPA TODOS OS CAMPOS, EXCETO OS QUE  *}
{* ESTÃO NA MATRIZ 'arrCamposChave'      *}
{**************************************MV*}
procedure TfrmPaiCadContabilidade.pLimparCampos;
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
function TfrmPaiCadContabilidade.fRetCampoEmpresa: String;
  Var
    intContador: Integer;
begin

  Result := '';

  {*****************************************}
  {* CASO FOR O CADASTRO DE EMPRESA, SAI   *}
  {**************************************MV*}
  If strNomeTabela = 'CADEMP' Then
    Exit;
    
  For intContador := 0 To qryTabela.FieldCount -1 Do
  Begin
    If Pos('CODEMP', qryTabela.Fields[intContador].FieldName) > 0 Then
    Begin
      Result := qryTabela.Fields[intContador].FieldName;
      Break;
    End;
  End;
end;

procedure TfrmPaiCadContabilidade.mnuConfigurarRelClick(Sender: TObject);
begin
  inherited;
  // nao remover este comentario, pois o evento deixara de funcionar
  // esta vinculado ao direito de acesso ao frmcadconfrelatorio
  // rl
end;

procedure TfrmPaiCadContabilidade.pProximaPagina;
begin
  If pgcDados.ActivePage.Tag < intPaginasAtivas Then
  Begin
    pgcDados.SelectNextPage(True);
    blnMudarFoco := False;
  End;
end;

procedure TfrmPaiCadContabilidade.pProximoCodigoGravar(var strCodEmp:string);
begin
  If (blnUsaProCodigo) And (qryTabela.State = dsInsert) Then
  Begin
    if blnUsaProTpl then
      qryTabela.FieldByName(strNomeCampo).AsString := fProximoCodigoTplaco
    else
      qryTabela.FieldByName(strNomeCampo).AsString := fProximoCodigo;
  End;
  strUltimoCodigo := qryTabela.FieldByName(strNomeCampo).AsString;

  If Not fEmptyStr(strCampoEmp) Then
    If fEmptyStr(qryTabela.FieldByName(strCampoEmp).AsString) Then
      qryTabela.FieldByName(strCampoEmp).AsString := VS_strCodEmp;

  If (qryTabela.State = dsInsert)                       And
     (qryTabela.FieldDefList.Find('AUTOINCREM') <> Nil) And
     (blnVerificaProCod) Then
  Begin
    If fEmptyStr(strCampoEmp) Then
      strCodEmp := VS_strCodEmp
    Else
      strCodEmp := qryTabela.FieldByName(strCampoEmp).AsString;

    qryTabela.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem(strNomeTabela, VS_strCodEmp);
  End;
end;

procedure TfrmPaiCadContabilidade.pAtribuiTags;
  Var
    intContador1: Integer;
    intTags: Integer;
begin
  intContador1 := 0;
  intTags      := 1;
  While intContador1 < pgcDados.PageCount Do
  Begin
    If pgcDados.Pages[intContador1].TabVisible Then
    Begin
      pgcDados.Pages[intContador1].Tag := intTags;
      Inc(intTags);
    End;
    Inc(intContador1);
  End;
end;

procedure TfrmPaiCadContabilidade.pDesalocaCanClose;
begin
  If Assigned(qryTabela) Then
    fFecharTabela(qryTabela);

  If Assigned(stlCampos) Then
    FreeAndNil(stlCampos);

  If Assigned(stlCamInd) Then
    FreeAndNil(stlCamInd);

  If Assigned(stlDesInd) Then
    FreeAndNil(stlDesInd);
end;

procedure TfrmPaiCadContabilidade.pDestravarRegistros;
begin
  {**************************************************}
  {* IMPLEMENTAR NO FORMULÁRIO FILHO PARA DESTRAVAR *}
  {* OS REGISTROS (LCK) AO FECHAR O FORM            *}
  {***********************************************AJ*}
end;

procedure TfrmPaiCadContabilidade.pDireitos(const ADireitos: string);
begin
  {* INSERÇÃO *}
  If Pos('I', ADireitos) > 0 Then
    btnIncluir.Visible := True
  Else
    btnIncluir.Visible := False;

  {* ALTERAÇÃO *}
  If Pos('A', ADireitos) > 0 Then
    btnAlterar.Visible := True
  Else
    btnAlterar.Visible := False;

  {* EXCLUIR *}
  If Pos('E', ADireitos) > 0 Then
    btnExcluir.Visible := True
  Else
    btnExcluir.Visible := False;
end;

function TfrmPaiCadContabilidade.fExecutaAntesDoDelete : Boolean;
begin
  Result := True;
  {*****************************************************}
  { IMPLEMENTAR NO FORMULÁRIO FILHO PARA RODAR ROTINAS  }
  { QUE DEVAM SER EXECUTADAS ANTES QUE O FORMULARIO     }
  { PAI EFETIVAMENTE EXCLUA O REGISTRO                  }
  {**************************************************GD*}
end;

procedure TfrmPaiCadContabilidade.pMontaWhereBuscaCodigos(var strSQL: string; dbeCampoChave: TDbEdit);
begin
  If (dbeCampoChave.Field.DataType = ftDate) Then
    strSQL := strSQL + ' = ' + QuotedStr(FormatDateTime('yyyy-mm-dd', StrToDate(dbeCampoChave.Text)))
  Else
  Begin
    If fEmptyStr(dbeCampoChave.Text) Then
    Begin
      strSQL := strSQL + ' IS NULL OR ' + dbeCampoChave.Field.FieldName + ' = "" ';
    End
    Else
      strSQL := strSQL + ' = ' + QuotedStr(dbeCampoChave.Text);
  End;
end;

function TfrmPaiCadContabilidade.fPodeExcluir: boolean;
begin
  result := False ;
  If qryTabela.IsEmpty Then
  Begin
    fMensagem('AVISO', 'Favor escolher um registro para essa operação!', ['&Ok']);
    Exit;
  End;

  If blnPerguntarParaExcluir Then
  Begin
    If fEmptyStr(strMensagemExclusao) Then
      result := fMensagem('AVISO', 'Deseja realmente excluir esse registro?', ['&Sim', '&Não']) = 1
    Else
      result := fMensagem('AVISO', strMensagemExclusao, ['&Sim', '&Não']) = 1;
  End
  Else
    result := True;
end;

function TfrmPaiCadContabilidade.fProximoCodigo: String;
begin
  Result := fAtualizaProCod(strNomeTabela, strNomeCampo);
end;

function TfrmPaiCadContabilidade.fProximoCodigoTplaco: String;
var
  LintTamCam, LintCod: Integer;
begin
  LintTamCam := fRetTamCampo(strNomeTabela);
  LintCod := TProximoCodigoTPlaco.fObterEGravar(strNomeTabela, IfThen(not strCampoTplaco.IsEmpty, qryTabela.FieldByName(strCampoTplaco).AsString));
  Result := fPadL(LintCod.ToString, LintTamCam, '0');
end;

procedure TfrmPaiCadContabilidade.pZeraCamposNumericos;
  Var
    intContador: Integer;
begin
  For intContador := 0 To qryTabela.FieldCount -1 Do
  Begin
    If (qryTabela.Fields[intContador].DataType = ftInteger)  Or
       (qryTabela.Fields[intContador].DataType = ftFloat)    Or
       (qryTabela.Fields[intContador].DataType = ftCurrency) Then
    Begin
      If qryTabela.Fields[intContador].FieldName <> 'AUTOINCREM' Then
        qryTabela.Fields[intContador].Value := 0;
    End;
  End;
end;

procedure TfrmPaiCadContabilidade.pLimpaDatasVazias;
  Var
    intContador: Integer;
begin

  For intContador := 0 To qryTabela.FieldCount -1 Do
  Begin

    If (qryTabela.Fields[intContador].DataType = ftDate)     Or
       (qryTabela.Fields[intContador].DataType = ftDateTime) Or
       (qryTabela.Fields[intContador].DataType = ftTime)     Then
    Begin
      If (fEmptyStr(qryTabela.Fields[intContador].AsString)) Then
        qryTabela.Fields[intContador].Value := Null;
    End;

  End;

end;

end.


