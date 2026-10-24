unit untPaiCad;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPai, ComCtrls, Buttons, ExtCtrls, DB,
    Uni, DBEditFocus, DBCtrls,
  DBComboBoxFocus, EditFocus, MaskEditFocus, Menus, untfuncoesSimples, AppEvnts {Qt};

type
  TfrmPaiCad = class(TfrmPai)
    btnIncluir: TBitBtn;
    btnGravar: TBitBtn;
    btnCancela: TBitBtn;
    btnExcluir: TBitBtn;
    btnPesquisa: TBitBtn;
    btnAlterar: TBitBtn;
    pgcDados: TPageControl;
    tbsGeral: TTabSheet;
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
  private
    { Private declarations }
    strSQLCadastro: String;

    procedure pOnStateChange;

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

    function fProximoCodigo: String; virtual;

    {*******************************************}
    {* FUNÇÕES DE VALIDAÇÃO!                   *}
    {****************************************MV*}
{    function fVerificaCampos: Boolean;
    function fValidaPanel(pnlPanel: TPanel; blnBuscaPorChave: Boolean = False): Boolean;
    function fVerificaSubObjeto(objObjeto: TWinControl): Boolean;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; virtual;}

    function fBuscaPorCamposChave: Boolean;

//  procedure pOnKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState); override;
//  procedure pOnKeyDownEdits(Sender: TObject; var Key: Word; Shift: TShiftState); override;

    procedure pInicializaIndices; virtual; abstract;
    procedure pLimparCampos;
    procedure pProximaPagina;
    procedure pAtribuiTags;
    procedure pZeraCamposNumericos;
  public
    { Public declarations }
    {*****************************************}
    {* REPRESENTA O ÚLIMO REGISTRO INSERIDO  *}
    {* OU ALTERADO NA SESSÃO                 *}
    {**************************************MV*}
    strUltimoCodigo: String;
  end;

var
  frmPaiCad: TfrmPaiCad;

implementation

uses untConsulta, untConstantes, Mask;

{$R *.dfm}

procedure TfrmPaiCad.btnIncluirClick(Sender: TObject);
begin
  inherited;
  Try
    If (Not fValidaProCod(strNomeTabela)) And (strNomeTabela <> 'PROCOD') And (blnVerificaProCod) Then
    Begin
      fMensagem('', 'Inclusão não permitida!' + #13#10 +
                    'Favor configurar o arquivo ' + strNomeTabela + ' no cadastro de próximos códigos!' , ['&Ok']);
      Exit;
    End;

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
    pOnStateChange;
    blnUsaProCodigo := fUsaProCodigo(strNomeTabela);
  Except
    On E: EZDatabaseError Do
    Begin
      showMessage(IntToStr(E.ErrorCode));
    End;
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[Inserir Registro]');
    End;
  End;
end;

procedure TfrmPaiCad.FormCreate(Sender: TObject);
{  Var
    intContador: Integer;}
begin
  inherited;

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

end;

procedure TfrmPaiCad.pOnStateChange;
begin
  pSetButton(qryTabela, btnIncluir, btnGravar, btnExcluir, btnCancela, btnAlterar, btnPesquisa, btnSair);
end;

procedure TfrmPaiCad.btnGravarClick(Sender: TObject);
  Var
    strCodEmp: String;
begin
  inherited;
  Try
    pnlInfo.Caption := 'Gravando registro! Aguarde....';
    If (qryTabela.State = dsInsert) Or (qryTabela.State = dsEdit) Then
    Begin

      If (Not fVerificaCampos) Then
      Begin
        pnlInfo.Caption := '';
        Exit;
      End;

      pLimpaDatasVazias;

      If (blnUsaProCodigo) And (qryTabela.State = dsInsert) Then
      Begin
        qryTabela.FieldByName(strNomeCampo).AsString := fProximoCodigo;
      End;
      strUltimoCodigo := qryTabela.FieldByName(strNomeCampo).AsString;

      If Not fEmptyStr(strCampoEmp) Then
        If fEmptyStr(qryTabela.FieldByName(strCampoEmp).AsString) Then
          qryTabela.FieldByName(strCampoEmp).AsString := VS_strCodEmp;

      If (qryTabela.State = dsInsert)                       And
         (qryTabela.FieldDefList.Find('AUTOINCREM') <> Nil) And
         (blnVerificaProCod)                                Then
      Begin
        If fEmptyStr(strCampoEmp) Then
          strCodEmp := VS_strCodEmp
        Else
          strCodEmp := qryTabela.FieldByName(strCampoEmp).AsString;

        qryTabela.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem(strNomeTabela, VS_strCodEmp);
      End;

      qryTabela.Post;
      pOnStateChange;
      pEnabled(Self, False);
      If btnIncluir.CanFocus Then
        btnIncluir.SetFocus

      Else If btnPesquisa.CanFocus Then
        btnPesquisa.SetFocus;

      pnlInfo.Caption := '';
      blnGravou := True;
    End;
  Except
    On E: EZDatabaseError Do
    Begin
      If E.ErrorCode = ERROR_PRIMARY_KEY_INSERT Then
      Begin
        pMensagensErro('Já existe um registro com esses Dados!', '[ Gravar registro ]');
      End
      Else
      Begin
        pMensagensErro(IntToStr(E.ErrorCode) + ': ' + E.Message, '[ Gravar registro ]');
      End;
      blnGravou := False;
    End;

    On E: Exception Do
    Begin
      blnGravou := False;
      pnlInfo.Caption := '';
      pMensagensErro(E.Message, 'Gravar Registro');
    End;
  End;
end;

procedure TfrmPaiCad.btnAlterarClick(Sender: TObject);
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
    pOnStateChange;
    pEnabled(Self, True);
    SelectNext(ActiveControl, True, True);
    blnAlterou := True;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, 'Altera Registro');
    End;
  End;
end;

procedure TfrmPaiCad.btnExcluirClick(Sender: TObject);
  Var
    qryGen: TUniQuery;
    strSQL: String;
begin
  inherited;
  If qryTabela.IsEmpty Then
  Begin
    fMensagem('AVISO', 'Favor escolher um registro para essa operação!', ['&Ok']);
    Exit;
  End;

  If fMensagem('AVISO', 'Deseja realmente excluir esse registro?', ['&Sim', '&Não']) = 1 Then
  Begin
    Try
      qryGen := fCriaQuery;

      strSQL := fVerificaIntegridade(strNomeTabela, qryTabela, False);
      qryTabela.Delete;
      qryTabela.CommitUpdates;

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
        btnIncluir.SetFocus

      Else If btnPesquisa.CanFocus Then
        btnPesquisa.SetFocus;

      blnExcluiu := True;
    Except
      On E: EZDatabaseError Do
      Begin
        If E.ErrorCode = ERROR_FOREIGN_KEY_DELETE Then
        Begin
          FreeAndNil(qryGen);
          pMensagensErro('Não é possivel excluir esse registro, pois existe movimentação para o mesmo.',
            '[ Excluir Registro ]');
        End
        Else
        Begin
          FreeAndNil(qryGen);
          pMensagensErro(IntToStr(E.ErrorCode) + ': ' + E.Message, ' [ Excluir registro ] ');
        End;
      End;
      On E: Exception Do
      Begin
        FreeAndNil(qryGen);
        pMensagensErro(E.Message, 'Excluir registro');
      End;
    End;
  End;
end;

procedure TfrmPaiCad.btnCancelaClick(Sender: TObject);
begin
  inherited;
  If (qryTabela.State = dsInsert) Or (qryTabela.State = dsEdit) Then
  Begin
    Try
      qryTabela.CancelUpdates;
      pOnStateChange;
      pEnabled(Self, False);
      If btnIncluir.CanFocus Then
        btnIncluir.SetFocus

      Else If btnPesquisa.CanFocus Then
        btnPesquisa.SetFocus;
        
      pnlInfo.Caption := '';
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, 'Cancelar operação');
      End;
    End;
  End;
end;

procedure TfrmPaiCad.FormShow(Sender: TObject);
  Var
    strDireitos: String;
    strSQL: String;
begin
  inherited;

  If blnVerDirEsp Then
  Begin

    If fVerificaDirEspecificos(strDireitos, strLoginUsuarioLogado, Self.Name) Then
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

    If Self.ActiveControl = Nil Then
      Self.ActiveControl := btnPesquisa;

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
  pOnStateChange;
  strCampoEmp := fRetCampoEmpresa;
end;

procedure TfrmPaiCad.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  If (Assigned(qryTabela)) And (qryTabela.State = dsInsert) Then
  Begin
    If fMensagem('AVISO', 'Deseja cancelar a inserção desse registro?', ['&Sim', '&Não']) = 1 Then
    Begin
      Action := CaNone;
      btnCancela.Click;
      Exit;
    End;
    Action := CaNone;
  End
  Else If (Assigned(qryTabela)) And (qryTabela.State = dsEdit) Then
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

    qryTabela.Close;
    qryTabela.SQL.Clear;
    qryTabela.SQL.Add(strSQLCadastro);

    fFecharTabela(qryTabela);

    If Assigned(stlCampos) Then
      FreeAndNil(stlCampos);

    If Assigned(stlCamInd) Then
      FreeAndNil(stlCamInd);

    If Assigned(stlDesInd) Then
      FreeAndNil(stlDesInd);

    inherited;
  End;
end;

{*****************************************}
{* FUNÇÃO USADA PARA VALIDAR OS CAMPOS.  *}
{* ESSA FUNÇÃO DEVE SER SOBREPOSTA NO    *}
{* QUE HERDAR DO 'frmPaiCad'.            *}
{**************************************MV*}
{function TfrmPaiCad.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
begin
  Result := False;
  If ActiveControl = btnCancela Then
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
{function TfrmPaiCad.fVerificaCampos: Boolean;
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

procedure TfrmPaiCad.btnPesquisaClick(Sender: TObject);
  Var
//    bkmRegistro: TBookMark;
    strFormTabela: String;
begin
  inherited;

  strFormTabela := Self.Name + strNomeTabela;

  Try
//    bkmRegistro := utcRegistros.fRetRegistro(strFormTabela);
    utcRegistros.fRetRegistro(strFormTabela);

    Application.CreateForm(TfrmConsulta, frmConsulta);
    frmConsulta.strOrderOpc    := strOrderOpc;
    frmConsulta.qryTabConsulta := qryTabela;
    
//    frmConsulta.bkmUltAcesso   := bkmRegistro;
    frmConsulta.strUltSelect    := utcRegistros.Select;
    frmConsulta.bkmUltAcesso    := utcRegistros.Registro;
    frmConsulta.strUltIndice1   := utcRegistros.Indice1;
    frmConsulta.strUltIndice2   := utcRegistros.Indice2;
    frmConsulta.strUltIndice3   := utcRegistros.Indice3;
    frmConsulta.intUltItemIndex := utcRegistros.ItemIndex;

    frmConsulta.strNomTabela   := strNomeTabela;
    frmConsulta.pConsulta(stlCamInd, stlDesInd, stlCampos);

//    If frmConsulta.bkmUltAcesso <> Nil Then
//    Begin
//      utcRegistros.pAdicionaTabela(Self.Name + strNomeTabela,
//        frmConsulta.bkmUltAcesso, frmConsulta.strUltOrderBy);

    {*****************************************}
    {* ATUALIZA OS DADOS DA CONSULTA         *}
    {**************************************MV*}
    utcRegistros.Novo;

    utcRegistros.Tabela    := strFormTabela;
    utcRegistros.Registro  := frmConsulta.bkmUltAcesso;
    utcRegistros.Select    := frmConsulta.strUltSelect;
    utcRegistros.Indice1   := frmConsulta.strUltIndice1;
    utcRegistros.Indice2   := frmConsulta.strUltIndice2;
    utcRegistros.Indice3   := frmConsulta.strUltIndice3;
    utcRegistros.ItemIndex := frmConsulta.intUltItemIndex;

    utcRegistros.Grava;

//    End;

    pFreeAndNil(frmConsulta);
    If (btnAlterar.Enabled) And (btnAlterar.Visible) Then
      btnAlterar.SetFocus;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, 'Pesquisa');
    End;
  End;
end;

{*****************************************}
{* FUNÇÃO QUE É ATRIBUIDA NO EVENTO      *}
{* 'OnKeyDown' DOS Edits. (continua...)  *}
{**************************************MV*}
(*ocedure TfrmPaiCad.pOnKeyDownEdits(Sender: TObject; var Key: Word;
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
    If (Assigned(qryTabela)) And (qryTabela.State = dsInsert) Then
    Begin
      If fMensagem('AVISO', 'Deseja cancelar a inserção desse registro?', ['&Sim', '&Não']) = 1 Then
      Begin
        btnCancela.Click;
      End;
    End
    Else If (Assigned(qryTabela)) And (qryTabela.State = dsEdit) Then
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

procedure TfrmPaiCad.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
(*  If (ActiveControl.ClassType = TBitBtn)Then
  Begin
    If (Key = VK_Escape) Then
      pOnKeyDown(Sender, Key, Shift);
  End
  {*****************************************}
  {* VER EM QUAL UNIT FICA A CLASS TGROUP -*}
  {* BUTTON, ADICIONALA E MUDAR ESSE 'IF'  *}
  {**************************************MV*}
  Else If (ActiveControl.ClassName = 'TGroupButton') Then
  Begin
    pOnKeyDown(Sender, Key, Shift);
  End*)
end;

(*procedure TfrmPaiCad.pOnKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
{  If Not blnMudarFoco Then
  Begin
    blnMudarFoco := True;
    Exit;
  End;}

  If (Key = VK_Return) Then
  Begin
    SelectNext(ActiveControl, True, True);
  End
  Else If (Key = VK_Escape) Then
  Begin
    If (qryTabela.State = dsInsert) Then
    Begin
      If fMensagem('AVISO', 'Deseja cancelar a inserção desse registro?', ['&Sim', '&Não']) = 1 Then
      Begin
        btnCancela.Click;
      End;
    End
    Else If (qryTabela.State = dsEdit) Then
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

{*****************************************}
{* FAZ UMA BUSCA NA TABELA ATUAL, FIL-   *}
{* TRANDO PELOS CAMPOS INDICADOS NA MA-  *}
{* TRIZ 'arrCamposChave'. CASO ENCONTRE  *}
{* UM REGISTRO, CARREGA NA TELA E PASSA  *}
{* A TABELA PARA MODO DE EDIÇÃO, SENÃO,  *}
{* LIMPA A TELA E PASSA A TABELA PARA MO-*}
{* DO DE INSERÇÃO                        *}
{**************************************MV*}
function TfrmPaiCad.fBuscaPorCamposChave: Boolean;
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
        qryTabela.CancelUpdates;
        qryTabela.Close;
        qryTabela.SQL.Clear;
        qryTabela.SQL.Add(strSQL);
        qryTabela.Open;
        qryTabela.Edit;
        Result := True;
      End
      Else If qryTabela.State = dsEdit Then
      Begin
        qryTabela.CancelUpdates;
        qryTabela.Insert;

        For intContador := 0 To Length(arrCodAnt) -1 Do
        Begin
          (arrCamposChave[intContador] As TDBEdit).Text := arrCodAnt[intContador];
        End;
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
procedure TfrmPaiCad.pLimparCampos;
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
function TfrmPaiCad.fRetCampoEmpresa: String;
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

procedure TfrmPaiCad.pProximaPagina;
begin
  If pgcDados.ActivePage.Tag < intPaginasAtivas Then
  Begin
    pgcDados.SelectNextPage(True);
    blnMudarFoco := False;
  End;
end;

procedure TfrmPaiCad.pAtribuiTags;
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

function TfrmPaiCad.fProximoCodigo: String;
  Var
    intTamCam: Integer;
begin
  intTamCam := fRetTamCampo(strNomeTabela);
  Result    := fPadL(fAtualizaProCod(strNomeTabela), intTamCam, '0');
end;

procedure TfrmPaiCad.pZeraCamposNumericos;
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

{function TfrmPaiCad.fValidaPanel(pnlPanel: TPanel; blnBuscaPorChave: Boolean = False): Boolean;
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
(*function TfrmPaiCad.fVerificaSubObjeto(objObjeto: TWinControl): Boolean;
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

procedure TfrmPaiCad.pLimpaDatasVazias;
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

