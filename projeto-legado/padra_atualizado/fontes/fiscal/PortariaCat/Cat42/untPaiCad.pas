unit untPaiCad;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.AppEvnts, Vcl.StdCtrls, Data.DB,
  Vcl.Buttons, Vcl.ExtCtrls, Vcl.Mask, Vcl.DBCtrls, untModulo;

type
  TfrmPaiCad = class(TfrmPai)
    btnPesquisar: TBitBtn;
    btnCancela: TBitBtn;
    btnExcluir: TBitBtn;
    btnAlterar: TBitBtn;
    btnGravar: TBitBtn;
    btnIncluir: TBitBtn;
    procedure btnIncluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
  private
    strSQLCadastro: String;

    procedure pLimpaDatasVazias;
    function fRetCampoEmpresa: String;
  protected
    intPaginasAtivas: Integer;
    arrCamposChave: Array Of TWinControl;
    strCampoEmp: String;
    strOrderOpc: String;
    strNomeCampo: String;
    strNomeTabela: String;
    blnGravou: Boolean;
    blnExcluiu: Boolean;
    blnAlterou: Boolean;
    blnVerDirEsp: Boolean;
    blnUsaAutInc: Boolean;
    blnUsaProCodigo: Boolean;
    blnVerificaProCod: Boolean;
    blnUsaVerificaCamposPai: Boolean;
    blnPerguntarParaExcluir: Boolean;

    procedure pOnStateChange; virtual;
    procedure pInicializaIndices; virtual; abstract;
    function fProximoCodigo: String; virtual;
    function fBuscaPorCamposChave(blnEditar: Boolean = True): Boolean;
  public
    strNomeForm: String;
    strNomeFormPesq: String;
    blnIgnorarCodEmp: Boolean;
    blnIncluiBuscaPorChave: Boolean;

    procedure pGravaRegistro;
  end;

var
  frmPaiCad: TfrmPaiCad;

implementation

uses untFuncoes, untConstantes, Uni;

{$R *.dfm}

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
    SelectNext((ActiveControl), True, True);
    blnAlterou := True;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, 'Altera Registro');
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

      Else If btnPesquisar.CanFocus Then
        pSetFocus(btnPesquisar);

      pnlInfo.Caption := '';
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, 'Cancelar operação');
      End;
    End;
  End;
end;

procedure TfrmPaiCad.btnExcluirClick(Sender: TObject);
  Var
    qryGen: TUniQuery;
    strSQL: String;
    blnPodeExcluir: Boolean;
    blnTransacaoExterna: Boolean;
begin
  blnExcluiu := False;

  inherited;
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
      blnTransacaoExterna := frmModulo.Database.InTransaction;

      If Not blnTransacaoExterna Then
        fStartTransaction;

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

      Else If btnPesquisar.CanFocus Then
        pSetFocus(btnPesquisar);

      If Not blnTransacaoExterna Then
        fCommit;

      blnExcluiu := True;
    Except
      On E: EUniError Do
      Begin
        If E.ErrorCode = ERROR_FOREIGN_KEY_DELETE Then
        Begin
          fRollBack;
          FreeAndNil(qryGen);
          fMensagem('ATENÇÃO!','Não é possível excluir esse registro, pois existe itens relacionados !',['&O K']);
        End
        Else
        Begin
          FreeAndNil(qryGen);
          pMensagensErro(IntToStr(E.ErrorCode) + ': ' + E.Message, ' [ Excluir registro ] ');
        End;
      End;

      On E: Exception Do
      Begin
        fRollBack;
        FreeAndNil(qryGen);
        pMensagensErro(E.Message, 'Excluir registro');
      End;
    End;
  End;
end;

procedure TfrmPaiCad.btnGravarClick(Sender: TObject);
begin
  inherited;
  pGravaRegistro;
end;

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

function TfrmPaiCad.fBuscaPorCamposChave(blnEditar: Boolean): Boolean;
  Var
    strSQL: String;
    intContador: Integer;
    dbeCampoChave: TDBEdit;
    arrCodAnt: Array Of String;
    qryGenTab: TUniQuery;
begin
  qryGenTab := fCriaQuery(Self);
  Try
    Result := False;
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
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
    End;
  Finally
    FreeAndNil(qryGenTab);
  End;
end;

procedure TfrmPaiCad.FormActivate(Sender: TObject);
begin
  //

  inherited;

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

procedure TfrmPaiCad.FormCreate(Sender: TObject);
begin
  inherited;

  blnVerDirEsp      := True;
  blnGravou         := False;
  blnAlterou        := False;
  blnExcluiu        := False;
  blnUsaAutInc      := True;
  blnVerificaProCod := True;
  blnIgnorarCodEmp  := False;
  strNomeTabela     := '';
  strUltimoCodigo   := '';
  strOrderOpc       := '';

  blnPerguntarParaExcluir := True;
  blnUsaVerificaCamposPai := True;

  blnIncluiBuscaPorChave := True;

  pInicializaIndices;
end;

procedure TfrmPaiCad.FormShow(Sender: TObject);
  Var
    strSQL: String;
begin
  inherited;

  If fEmptyStr(strNomeForm) Then
    strNomeForm := Self.Name;

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

  If not blnIgnorarCodEmp Then
    strCampoEmp := fRetCampoEmpresa;
end;

function TfrmPaiCad.fProximoCodigo: String;
  Var
    intTamCam: Integer;
begin
  intTamCam := fRetTamCampo(strNomeTabela);
  Result := fPadL(fAtualizaProCod(strNomeTabela), intTamCam, '0');
end;

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

procedure TfrmPaiCad.pGravaRegistro;
  Var
    strCodEmp: String;
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
         (blnVerificaProCod) Then
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

      Else If btnPesquisar.CanFocus Then
        pSetFocus(btnPesquisar);

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

procedure TfrmPaiCad.pOnStateChange;
begin
  pSetButton(qryTabela, btnIncluir, btnGravar, btnExcluir, btnCancela, btnAlterar, btnPesquisar, btnSair);
end;

end.
