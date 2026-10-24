unit untPaiCad;

interface

uses
  Windows, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPai, ComCtrls, Buttons, ExtCtrls, DB, Uni, DBEditFocus,
  DBCtrls, DBComboBoxFocus, EditFocus, MaskEditFocus, Menus,
  AppEvnts, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmPaiCad = class(TfrmPai)
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
  private
    { Private declarations }
    strSQLCadastro: String;

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

    {*************************************************}
    {* VARIAVEL QUE DEFINE SE DEVE EXIBIR A MSG DE   *}
    {* EXCLUSÃO. SE ELA FOR FALSE, NÃO IRÁ PERGUNTAR *}
    {* E IRÁ EXCLUIR DIRETO O REGISTRO               *}
    {**********************************************FC*}
    blnPerguntarParaExcluir: Boolean;
    
    function fProximoCodigo: String; virtual;

    {*******************************************}
    {* FUNÇÕES DE VALIDAÇÃO!                   *}
    {****************************************MV*}
    function fBuscaPorCamposChave(blnEditar: Boolean = True): Boolean;

    procedure pOnStateChange;virtual;
    procedure pInicializaIndices; virtual; abstract;
    procedure pLimparCampos;
    procedure pProximaPagina;virtual;
    procedure pAtribuiTags;
    procedure pZeraCamposNumericos;
  public
    { Public declarations }
    strNomeForm: String;

    procedure pGravaRegistro;
  end;

var
  frmPaiCad: TfrmPaiCad;

implementation

uses SysUtils, untFuncoesFactory, untConstantes, Mask, untIFuncoes,
  untModulo;

{$R *.dfm}

procedure TfrmPaiCad.btnIncluirClick(Sender: TObject);
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

procedure TfrmPaiCad.FormCreate(Sender: TObject);
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

  blnPerguntarParaExcluir := True;
  
  pInicializaIndices;

end;

procedure TfrmPaiCad.pOnStateChange;
begin
  pSetButton(qryTabela, btnIncluir, btnGravar, btnExcluir, btnCancela, btnAlterar, btnPesquisa, btnSair);
end;

procedure TfrmPaiCad.btnGravarClick(Sender: TObject);
Begin
  inherited;
  pGravaRegistro;
End;

procedure TfrmPaiCad.pGravaRegistro;
  Var
    strCodEmp: String;
begin
  Try
    blnGravou := False;

    pnlInfo.Caption := 'Gravando registro! Aguarde....';
    If (qryTabela.State = dsInsert) Or (qryTabela.State = dsEdit) Then
    Begin

      If (Not fVerificaCampos) Then
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
        pSetFocus(btnIncluir)

      Else If btnPesquisa.CanFocus Then
        pSetFocus(btnPesquisa);

      pnlInfo.Caption := '';
      blnGravou := True;
    End;
  Except
    On E: EUniError Do
    Begin
      If E.ErrorCode = ERROR_PRIMARY_KEY_INSERT Then
      Begin
        pMensagensErro(E.Message,'Já existe um registro com esses Dados!', '[ Gravar registro ]');
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
    blnPodeExcluir: Boolean;
begin
  inherited;

  blnExcluiu := False;

  If qryTabela.IsEmpty Then
  Begin
    fMensagem('AVISO', 'Favor escolher um registro para essa operação!', ['&Ok']);
    Exit;
  End;

  If blnPerguntarParaExcluir Then
    blnPodeExcluir := fMensagem('AVISO', 'Deseja realmente excluir esse registro?', ['&Sim', '&Não']) = 1
  Else
    blnPodeExcluir := True;

  If blnPodeExcluir Then
  Begin
    Try
      qryGen := fCriaQuery;

      strSQL := fVerificaIntegridade(Self.Name, strNomeTabela, qryTabela, False);
      qryTabela.Delete;

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

      fCommit;
      blnExcluiu := True;
    Except
      On E: EUniError Do
      Begin
        If E.ErrorCode = ERROR_FOREIGN_KEY_DELETE Then
        Begin
          FreeAndNil(qryGen);
          fMensagem('ATENÇÃO!','Não é possivel excluir esse registro, pois existe itens relacionados !',['&O K']);
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
      qryTabela.Cancel;
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

procedure TfrmPaiCad.FormShow(Sender: TObject);
  Var
    strDireitos: String;
    strSQL: String;
begin
  inherited;

  If fEmptyStr(strNomeForm) Then
    strNomeForm := Self.Name;

  If blnVerDirEsp Then
  Begin

    If fValidarDirEspecificos(strDireitos, strLoginUsuarioLogado, strNomeForm) Then
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

    If (Self.ActiveControl) = Nil Then
      pSetFocus(btnPesquisa);

    fExecutaSQL('REPLACE INTO DIRESP (DIR_NOMFRM) VALUES ("' + strNomeForm + '")');
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
    {
    qryTabela.Close;
    qryTabela.SQL.Clear;
    qryTabela.SQL.Add(strSQLCadastro);
    }
    If Assigned(qryTabela) Then
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

procedure TfrmPaiCad.FormKeyDown(Sender: TObject; var Key: Word;
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
function TfrmPaiCad.fBuscaPorCamposChave(blnEditar: Boolean = True): Boolean;
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

        If fEmptyStr(dbeCampoChave.Text) Then
          strSQL := strSQL + ')';

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
          qryTabela.Cancel;
          qryTabela.Close;
          qryTabela.SQL.Clear;
          qryTabela.SQL.Add(strSQL);
          qryTabela.Open;
          qryTabela.Edit;
        End;
        Result := True;
      End
      Else If qryTabela.State = dsEdit Then
      Begin
        qryTabela.Cancel;
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
    If pgcDados.Pages[intContador1].TabVisible Then
    Begin
      pgcDados.Pages[intContador1].Tag := intTags;
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


