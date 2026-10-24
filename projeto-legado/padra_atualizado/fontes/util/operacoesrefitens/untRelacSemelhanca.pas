unit untRelacSemelhanca;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons,
  ExtCtrls, Grids, DBGridCitel, DBGrids, EditFocus, Uni, DB, UniClientDataSet,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade, untTypesSistema;

type
  TfrmRelacSemelhanca = class(TfrmPaiSimples)
    pnlCabecalho: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    edtCodIte: TEditFocus;
    edtCodFab: TEditFocus;
    pnlBotoesSim: TPanel;
    dbgItens: TDBGridCitel;
    Panel1: TPanel;
    edtCodBar: TEditFocus;
    Label3: TLabel;
    edtDesIte: TEditFocus;
    dtsGrid: TDataSource;
    btnConfirma: TBitBtnLocked;
    btnDeletar: TBitBtnLocked;
    btnConfirmar: TBitBtnLocked;
    btnCancelaItem: TBitBtnLocked;
    btnCancelarEntrada: TBitBtnLocked;
    edtCodMar: TEditFocus;
    edtDesMar: TEditFocus;
    Label4: TLabel;
    btnCadMarcas: TBitBtnLocked;
    procedure btnCancelarEntradaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodIteExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelaItemClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnDeletarClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure dbgItensKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodFabExit(Sender: TObject);
    procedure edtCodMarExit(Sender: TObject);
    procedure edtCodMarKeyPress(Sender: TObject; var Key: Char);
    procedure btnCadMarcasClick(Sender: TObject);
  private
    { Private declarations }
    qryConIte: TUniQuery;
    cdsGrid: TUniClientDataSet;

    arrMarca: TConsultasArray;

//    procedure pCarregaCadIte;
    procedure pCriaTemporaria;
    procedure pCarregaItensSemelhantes(strCodIte: String);
    function fCodBarraJaInclusoGrid(strCodBar: String): Boolean;

  protected
    procedure pEscapePressed; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;

  public
    { Public declarations }
  end;

var
  frmRelacSemelhanca: TfrmRelacSemelhanca;

implementation

uses untPai, untFuncoesSimples, untFuncoesConsulta, untCadMarcas,
     untIteBar, untObservacao, untConstantes, untConsultas;

{$R *.dfm}

procedure TfrmRelacSemelhanca.btnCancelarEntradaClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmRelacSemelhanca.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F10: btnConfirma.Click;
    VK_F7:  btnCadMarcas.Click;
  End;

end;

procedure TfrmRelacSemelhanca.pEscapePressed;
begin
  If (edtCodFab.Focused) Or (edtCodBar.Focused) Then
  Begin
    cdsGrid.EmptyDataSet;
    edtCodFab.Clear;
    edtCodBar.Clear;
    edtCodIte.Clear;
    edtDesIte.Clear;
    edtCodMar.Clear;
    edtDesMar.Clear;

    pSetFocus(edtCodIte);
    Exit;
  End;

  If (edtCodIte.Focused) Then
    btnSair.Click;
end;

procedure TfrmRelacSemelhanca.edtCodIteKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;

  If fEntraCons(Key) Then
  Begin
    if fPesqItem(conIteSimples, Self, edtCodIte, edtDesIte, qryConIte, Key, arrSel, True, nil, 'Consulta de Itens', '1') then
    Begin
       If fValidaCampos(edtCodIte) Then
         Self.SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmRelacSemelhanca.edtCodMarExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodMar, edtDesMar, arrMarca, fRetNomMarca, nil, 'da Marca');

end;

procedure TfrmRelacSemelhanca.edtCodMarKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  If fPesqMarcas(Self, edtCodMar, edtDesMar, Nil, Key, arrMarca, True) Then
  Begin
    If fValidaCampos(edtCodMar, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelacSemelhanca.edtCodIteExit(Sender: TObject);
begin
  inherited;
end;

(*
procedure TfrmRelacSemelhanca.pCarregaCadIte;
  Var
    blnBuscaCodBar: Boolean;
begin

  {****************************}
  {* CARREGA OS DADOS DO ITEM *}
  {*************************LU*}
  blnBuscaCodBar := True;

  If (Length(Trim(edtCodIte.Text)) <= 5) Then
  Begin
    edtCodIte.Text := fStrZero(edtCodIte.Text, 5);
    blnBuscaCodBar := False;
  End;

  pPesquisaCadIte(qryConIte, qryConIte, edtCodIte.Text, blnBuscaCodBar);
  With qryConIte Do
  Begin
    If blnBuscaCodBar Then
      edtCodIte.Text := qryConIte.FieldByName('ITE_CODITE').AsString;
  End;

end;
*)

procedure TfrmRelacSemelhanca.FormCreate(Sender: TObject);
begin
  inherited;
  qryConIte := fCriarQuery('SELECT * FROM CADITE WHERE FALSE', Self);
  cdsGrid   := TUniClientDataSet.Create(Self);
  pSetaCodIte(edtCodIte);
end;

procedure TfrmRelacSemelhanca.btnCadMarcasClick(Sender: TObject);
begin
  inherited;

  If fVerificaAcessoSistema('frmCadMarcas') Then
    pCriarForm(TfrmCadMarcas)
  Else
    pMensagemOk('Usuário sem direito de acesso ao Cadastro de Marcas!');
end;

procedure TfrmRelacSemelhanca.btnCancelaItemClick(Sender: TObject);
begin
  inherited;
  edtCodFab.Clear;
  edtCodBar.Clear;
  edtCodMar.Clear;
  edtDesMar.Clear;

  pSetFocus(edtCodFab);
end;

procedure TfrmRelacSemelhanca.pCriaTemporaria;
Begin

  With cdsGrid.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CODFAB';
    DataType := ftString;
    Size := TAM_CODIGO_FABRICA;
  End;

  With cdsGrid.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CODBAR';
    DataType := ftString;
    Size := 15;
  End;

  With cdsGrid.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CODMAR';
    DataType := ftString;
    Size := 06;
  End;

  With cdsGrid.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DESMAR';
    DataType := ftString;
    Size := 30;
  End;

  cdsGrid.CreateDataSet;
  cdsGrid.IndexFieldNames := 'CODFAB;CODBAR';

End;

procedure TfrmRelacSemelhanca.FormShow(Sender: TObject);
begin
  inherited;
  pCriaTemporaria;

  dtsGrid.DataSet := cdsGrid;
  dbgItens.DataSource := dtsGrid;

  pSetFocus(edtCodIte);

  pSetaCodIte(edtCodIte);


  If Not fEmptyStr(edtCodIte.Text) Then
    fValidaCampos(edtCodIte, True);

end;

function TfrmRelacSemelhanca.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtCodIte) Then
    begin

      If fEmptyStr(edtCodIte.Text) Then
      Begin
        fMensagem('AVISO', 'Informar o Produto.', ['&O K']);
        edtCodIte.Clear;
        Result := False;
      End
      Else
        edtDesIte.Text := fRetNomProduto(edtCodIte.Text);
      edtDesIte.Enabled := False;

      If fEmptyStr(edtDesIte.Text) And (Not fEmptyStr(edtCodIte.Text))  Then
      Begin
        fMensagem('AVISO', 'Código do Produto não encontrado.', ['&O K']);
        edtCodIte.Clear;
        pSetFocus(edtCodIte);
        Result := False;
      End;

      If Result Then
        pCarregaItensSemelhantes(edtCodIte.Text);

    end

    Else If (Sender = edtCodMar) Then
    begin

      If fEmptyStr(edtCodMar.Text) Then
      Begin

        edtDesMar.Clear;

      End Else
      Begin

        edtDesMar.Text := fRetNomMarca(edtCodMar.Text);

        If fEmptyStr(edtDesMar.Text) Then
        Begin
          pMensagemOk('Marca não encontrada!');
          Result := False;
        End;

      End;

    End;

  end;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmRelacSemelhanca.btnConfirmarClick(Sender: TObject);
Var
  strItem: String;
begin
  inherited;
  {**************************************************}
  {* VERIFICA SE UM DOS CODIGOS ESTÃO PREENCHIDOS   *}
  {***********************************************RV*}

  If Not fValidaCampos(edtCodMar, True) Then
    Exit;

  If (Not fEmptyStr(edtCodFab.Text)) Or (Not fEmptyStr(edtCodBar.Text)) Then
  Begin
    {****************************************************}
    {* VERIFICA SE O CODIGO DE BARRAS JÁ EXISTE NO GRID *}
    {*************************************************LU*}
    If fEmptyStr(edtCodBar.Text) Or (Not fCodBarraJaInclusoGrid(edtCodBar.Text)) Then
    Begin
      {************************************************************}
      {* VERIFICA SE O CODIGO DE BARRAS JÁ EXISTE EM OUTRA TABELA *}
      {*********************************************************LU*}
      If fEmptyStr(edtCodBar.Text) Or
         (( fValidaCodBarra(edtCodBar.Text, '', strItem) And
          (Not fCodBarraJaInclusoTabSem(edtCodBar.Text, strItem)) )) Then
      Begin
        cdsGrid.Insert;
        cdsGrid.FieldByName('CODFAB').AsString := edtCodFab.Text;
        cdsGrid.FieldByName('CODBAR').AsString := edtCodBar.Text;

        If Not fEmptyStr(edtCodMar.Text) Then
        Begin
          cdsGrid.FieldByName('CODMAR').AsString := edtCodMar.Text;
          cdsGrid.FieldByName('DESMAR').AsString := edtDesMar.Text;
        End;

        cdsGrid.Post;
      End
      Else
        fMensagem('AVISO', 'Item não pode ser incluso.' + #10#13 + 'Esse código de barras já está cadastrado para o item: ' + strItem, ['&O K']);
    End
    Else
      fMensagem('AVISO', 'Esse código de barras já está incluso em um item semelhante para esse item.', ['&O K']);

  End;

  edtCodFab.Clear;
  edtCodBar.Clear;
  edtCodMar.Clear;
  edtDesMar.Clear;

  pSetFocus(edtCodFab);
end;

procedure TfrmRelacSemelhanca.btnDeletarClick(Sender: TObject);
begin
  inherited;
  If cdsGrid.RecordCount > 0 Then
    cdsGrid.Delete;
end;

procedure TfrmRelacSemelhanca.btnConfirmaClick(Sender: TObject);
Var
  strSQL   : String;
  qryGen   : TUniQuery;
  strItem  : String;
  strMsg   : String;
  strAutInc: String;
begin
  inherited;

  Try

    qryGen := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + ' DELETE FROM CADSEM WHERE SEM_CODITE = :CODITE ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := edtCodIte.Text;
      ExecSQL;
    End;

    If cdsGrid.RecordCount > 0 Then
    Begin
      strSQL := '';
      strSQL := strSQL + ' INSERT INTO CADSEM (';
      strSQL := strSQL + '   SEM_CODITE, ';
      strSQL := strSQL + '   SEM_CODSEM, ';
      strSQL := strSQL + '   SEM_CODBAR, ';
      strSQL := strSQL + '   SEM_CODEMP, ';
      strSQL := strSQL + '   SEM_CODMAR, ';
      strSQL := strSQL + '   AUTOINCREM) ';
      strSQL := strSQL + ' VALUES( ';
      strSQL := strSQL + '   :CODITE, ';
      strSQL := strSQL + '   :CODSEM, ';
      strSQL := strSQL + '   :CODBAR, ';
      strSQL := strSQL + '   :CODEMP, ';
      strSQL := strSQL + '   :CODMAR, ';
      strSQL := strSQL + '   :AUTINC) ';

      strMsg := '';
      cdsGrid.First;
      While Not cdsGrid.Eof Do
      Begin
        If fEmptyStr(cdsGrid.fieldbyname('CODBAR').AsString) Or
           (fValidaCodBarra(cdsGrid.fieldbyname('CODBAR').AsString, '', strItem) And
            (Not fCodBarraJaInclusoTabSem(cdsGrid.fieldbyname('CODBAR').AsString, strItem) )) Then
        Begin
          strAutInc := fRetAutoIncrem('CADSEM',VS_strCodEmp);
          qryGen.Close;
          qryGen.SQL.Clear;
          qryGen.SQL.Add(strSQL);
          qryGen.ParamByName('CODITE').AsString := edtCodIte.Text;
          qryGen.ParamByName('CODSEM').AsString := cdsGrid.fieldbyname('CODFAB').AsString;
          qryGen.ParamByName('CODBAR').AsString := cdsGrid.fieldbyname('CODBAR').AsString;

          If fEmptyStr(cdsGrid.fieldbyname('CODMAR').AsString) Then
            qryGen.ParamByName('CODMAR').Clear
          Else
            qryGen.ParamByName('CODMAR').AsString := cdsGrid.fieldbyname('CODMAR').AsString;

          qryGen.ParamByName('CODEMP').AsString := VS_strCodEmp;
          qryGen.ParamByName('AUTINC').AsString := strAutInc;
          qryGen.ExecSQL;

          fAtualizaBarFabIte(edtCodIte.Text);
        End
        Else
          strMsg := cdsGrid.fieldbyname('CODFAB').AsString + '  -  ' + cdsGrid.fieldbyname('CODBAR').AsString + #13#10 + strMsg;

        cdsGrid.Next;
      End;

      If Not fEmptyStr(strMsg) Then
      Begin
        Try
          pCriarFormularios(TfrmObservacao, frmObservacao);
          frmObservacao.lblMensagem.Caption := 'Itens não inclusos, código de barras já cadastrado(Cód. Fábrica - Cód. Barras):';
          frmObservacao.memObs.Texto := strMsg;
          frmObservacao.ShowModal;
        Except
          On E: Exception Do
          Begin
            pMensagensErro(E.Message, '[TfrmRelacSemelhanca.Observacao]');
          End;
        End;

        pFreeAndNil(frmObservacao);
      End;

    End;

    cdsGrid.EmptyDataSet;
    fAtualizaBarFabIte(edtCodIte.Text);
    edtCodIte.Clear;
    edtDesIte.Clear;
    edtCodFab.Clear;
    edtCodBar.Clear;
    edtCodMar.Clear;
    edtDesMar.Clear;

    pSetFocus(edtCodIte);

    FreeAndNil(qryGen);
    fMensagem('AVISO', 'Gravação efetuada com sucesso!', ['&O K']);


  Except
    On E: Exception Do
    Begin
      FreeAndNil(qryGen);
      pMensagensErro(E.Message, '[TfrmRelacSemelhanca.Gravacao]');
    End;
  End;

end;

function TfrmRelacSemelhanca.fCodBarraJaInclusoGrid(strCodBar: String): Boolean;
begin
  Result := False;

  If Assigned(cdsGrid) Then
  Begin
    cdsGrid.First;
    While Not cdsGrid.Eof Do
    Begin
      If cdsGrid.FieldByName('CODBAR').AsString = strCodBar Then
      Begin
        Result := True;
        Exit;
      End
      Else
        cdsGrid.Next;
    End;
  End;

end;

procedure TfrmRelacSemelhanca.pCarregaItensSemelhantes(strCodIte: String);
Var
  strSQL: String;
  qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Self);

  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '   S.*,        ';
  strSQL := strSQL + '   MAR_DESMAR ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   CADSEM S ';
  strSQL := strSQL + ' LEFT JOIN CADMAR ON MAR_CODMAR = SEM_CODMAR ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   SEM_CODITE = :CODITE ';

  With qryGen Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODITE').AsString := strCodIte;
    Open;

    cdsGrid.EmptyDataSet;
    If Not IsEmpty Then
    Begin
      First;

      While Not Eof Do
      Begin
        cdsGrid.Insert;
        cdsGrid.FieldByName('CODFAB').AsString := fieldbyname('SEM_CODSEM').AsString;
        cdsGrid.FieldByName('CODBAR').AsString := fieldbyname('SEM_CODBAR').AsString;
        cdsGrid.FieldByName('CODMAR').AsString := fieldbyname('SEM_CODMAR').AsString;
        cdsGrid.FieldByName('DESMAR').AsString := fieldbyname('MAR_DESMAR').AsString;
        cdsGrid.Post;

        Next;
      End;

    End;

  End;

  FreeAndNil(qryGen);

End;

procedure TfrmRelacSemelhanca.dbgItensKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_DELETE) Then
    btnDeletar.Click;

  If (Key = VK_ESCAPE) And (dbgItens.Focused) Then
  Begin
    edtCodFab.Clear;
    edtCodBar.Clear;
    edtCodMar.Clear;
    edtDesMar.Clear;

    pSetFocus(edtCodFab);
    Exit;
  End;

end;

procedure TfrmRelacSemelhanca.edtCodFabExit(Sender: TObject);
begin
  inherited;
  //If fEmptyStr(edtCodFab.Text) And (Not cdsGrid.IsEmpty) Then
  //  pSetFocus(dbgItens);
end;

end.
