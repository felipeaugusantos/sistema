unit untCadPadraQualidadeInd;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, frxClass, Data.DB,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Uni,
  Vcl.ComCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.Grids,
  Vcl.DBGrids, DBGridCitel, EditFocus, Vcl.Mask, Vcl.DBCtrls, DBEditFocus, UniClientDataSet ;

type
  TfrmCadPadraQualidade = class(TfrmPaiCad)
    Label1: TLabel;
    edtProdutos: TEditFocus;
    edtDesProduto: TEditFocus;
    dbgDados: TDBGridCitel;
    edtEspeci: TEditFocus;
    edtParame: TEditFocus;
    Label2: TLabel;
    Label3: TLabel;
    Bevel1: TBevel;
    dbeAutoincrem: TDBEditFocus;
    procedure edtProdutosKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure dbgDadosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnExcluirClick(Sender: TObject);
    procedure dbgDadosDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    blnEditar : Boolean;
    dtsTabela : TDataSource;
    cdsCloneTabela : TUniClientDataset;

    procedure pCarregaGrid;
    procedure pLimparCampos;
    procedure pGravarItens;
    procedure pCriaCdsItens;
    procedure pAlimentaCdsItens;
  public
    { Public declarations }
  protected
    Function fValidaCampos(Sender : TWinControl; blnBuscaPorChave : Boolean) : Boolean;Override;
    procedure pInicializaIndices; override;
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples, untTypesSistema, untConsultas;

procedure TfrmCadPadraQualidade.btnAlterarClick(Sender: TObject);
begin
  Try
    If fEmptyStr(edtProdutos.Text) Then
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

    pSetFocus(edtProdutos);
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, 'Altera Registro');
    End;
  End;
  //inherited;
end;

procedure TfrmCadPadraQualidade.btnCancelaClick(Sender: TObject);
begin
  qryTabela.Edit;
  inherited;
  pCarregaGrid;
  if cdsCloneTabela.IsEmpty then
    pLimparCampos;
  pSetFocus(edtProdutos);
end;

procedure TfrmCadPadraQualidade.btnExcluirClick(Sender: TObject);
  Var
    qryDel : TUniQuery;
begin
  If fEmptyStr(edtProdutos.Text) Then
  Begin
    fMensagem('AVISO', 'Favor escolher um registro para essa operação!', ['&Ok']);
    Exit;
  End;

  Try
    qryDel := fCriaQuery(Self);
    With qryDel, SQL Do
    Begin
      Close;
      Clear;
      Add(' DELETE FROM GEIQUA WHERE GMT_CODPAG = :CODPAG ');

      ParamByName('CODPAG').AsString := edtProdutos.Text;

      ExecSQL;

    End;
  Finally
    FreeAndNil(qryDel);
  End;

  btnCancelaClick(Nil);
  edtProdutos.Clear;
  edtDesProduto.Clear;

//  inherited;
  pSetFocus(edtProdutos);
end;

procedure TfrmCadPadraQualidade.btnGravarClick(Sender: TObject);
begin
  If cdsCloneTabela.IsEmpty Then
  Begin
    fMensagem('', 'Não existem Especificação/Parâmetro informados!', ['&OK']);
    Exit;
  End;

  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    pGravarItens;
    qryTabela.Edit;
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadPadraQualidade.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;

  blnEditar := False;
  pCarregaGrid;
end;

procedure TfrmCadPadraQualidade.btnIncluirClick(Sender: TObject);
begin
  qryTabela.Close;
  qryTabela.SQL.Clear;
  qryTabela.SQL.Add('SELECT * FROM GEIQUA WHERE FALSE ');
  qryTabela.Open;
  pAlimentaCdsItens;


  edtProdutos.Clear;
  edtDesProduto.Clear;


  inherited;
  pSetFocus(edtProdutos);
  qryTabela.Cancel;

end;

procedure TfrmCadPadraQualidade.edtProdutosKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;
  if fPesqItem(conIteSimples, Self, edtProdutos, edtDesProduto, Nil, Key, arrSel,
               True, nil, 'Consulta de Itens', '1', '', 0,
               False, False, 0, cdrCodIte, '', False, '', '',True, False, False, '',
               False, False, False, True) then
  Begin
    If fValidaCampos(edtProdutos, True) Then
      SelectNext(ActiveControl, True, True);
  End;


end;

procedure TfrmCadPadraQualidade.btnPesquisaClick(Sender: TObject);
  Var
    arrSel : TConsultasArray;
    Key    : Char;
begin
  //inherited;
  Key := '/';
  if fPesqItem(conIteSimples, Self, edtProdutos, edtDesProduto, Nil, Key, arrSel,
               True, nil, 'Consulta de Itens', '1', '', 0,
               False, False, 0, cdrCodIte, '', False, '', '',True, False, False, '',
               False, False, False, True) then
  Begin
    If fValidaCampos(edtProdutos, True) Then
      pSetFocus(edtProdutos);
  End;

end;

procedure TfrmCadPadraQualidade.dbgDadosDblClick(Sender: TObject);
begin
  inherited;
  If btnGravar.Enabled Then
  Begin
    blnEditar := True;
    edtEspeci.Text := cdsCloneTabela.FieldByName('GMT_ESPECI').AsString;
    edtParame.Text := cdsCloneTabela.FieldByName('GMT_PARAME').AsString;
    pSetFocus(edtEspeci);
  End;
end;

procedure TfrmCadPadraQualidade.dbgDadosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = VK_DELETE Then
  Begin
    If btnGravar.Enabled Then
    begin
      cdsCloneTabela.Edit;
      cdsCloneTabela.FieldByName('GMT_CODQUA').AsString := '-1'; {SINALIZANDO EXCLUSÃO}
      cdsCloneTabela.Post;
    end;
  End;
end;

procedure TfrmCadPadraQualidade.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela     := 'GEIQUA';
  strNomeCampo      := 'AUTOINCREM';
  qryTabela := fCriaQuery(Self);
  cdsCloneTabela := TUniClientDataSet.Create(Self);
  dtsTabela := fCriaDataSource(cdsCloneTabela);
  dbgDados.DataSource := dtsTabela;

  qryTabela.Close;
  qryTabela.SQL.Clear;
  qryTabela.SQL.Add('SELECT * FROM GEIQUA WHERE FALSE ');
  qryTabela.Open;
  pCriaCdsItens;


  blnEditar := False;
  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeAutoincrem;

end;

procedure TfrmCadPadraQualidade.FormDestroy(Sender: TObject);
begin
  FreeAndNil(dtsTabela);
  FreeAndNil(qryTabela);

  FreeAndNil(stlCampos);
  FreeAndNil(stlCamInd);
  FreeAndNil(stlDesInd);
  inherited;

end;


procedure TfrmCadPadraQualidade.FormShow(Sender: TObject);
begin
  inherited;

  pSetaCodIte( edtProdutos );
  pSetFocus(btnIncluir);

end;

function TfrmCadPadraQualidade.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If Inherited fValidaCampos(Sender, blnBuscaPorChave) Then
  Begin

    If (Sender = edtProdutos) Then
    Begin
      If fEmptyStr(edtProdutos.Text) Then
      Begin
        Result := False;
        fMensagem('', 'Informe o codigo da estrutura!', ['&OK']);
      End
      Else
      Begin
        edtDesProduto.Text := fRetNomProduto( edtProdutos.Text );
        If fEmptyStr(edtDesProduto.Text) Then
        Begin
          fMensagem('', 'O código da estrutura informado não esta cadastrado!', ['&OK']);
          Result := False;
        End
        Else
        Begin
          If not fItemEstruturaIndustrial(edtProdutos.Text) Then
          Begin
            fMensagem('', 'O código informado não é uma estrutura!', ['&OK']);
            Result := False;
          End;
        End;
      End;

      If blnBuscaPorChave Then
      Begin
        If Result Then
          pCarregaGrid;
      End;

    End

    Else  If(Sender = edtEspeci) then
    Begin
      If blnBuscaPorChave Then
      begin
        If fEmptyStr(edtEspeci.Text) Then
        Begin
          Result := False;
          fMensagem('', 'Informe a especificação!', ['&OK']);
        End;
      End;
    End
    Else
    If (Sender = edtParame) Then
    Begin
      If blnBuscaPorChave Then
      Begin
        If fEmptyStr(edtParame.Text) then
        Begin
          Result := False;
          fMensagem('', 'Informe o parâmetro!', ['&OK']);
        End;

        If Result Then
        Begin
          if (fEmptyStr(edtParame.Text) = False) then
          begin
            if Not blnEditar Then
            Begin
              cdsCloneTabela.Append;
              cdsCloneTabela.FieldByName('AUTOINCREM').AsString := '0';
              cdsCloneTabela.FieldByName('GMT_CODQUA').AsString := '0';
              cdsCloneTabela.FieldByName('GMT_CODPAG').AsString := edtProdutos.Text;
            End
            Else
              cdsCloneTabela.Edit;

            cdsCloneTabela.FieldByName('GMT_ESPECI').AsString := edtEspeci.Text;
            cdsCloneTabela.FieldByName('GMT_PARAME').AsString := edtParame.Text;
            cdsCloneTabela.Post;

            blnEditar := False;

            edtEspeci.Clear;
            edtParame.Clear;

            pSetFocus(edtEspeci);
          end;
        End;
      End;
    End;



  End;

  If Not Result Then
    pSetFocus(Sender);

end;

Procedure TfrmCadPadraQualidade.pCarregaGrid;
Begin
  With qryTabela, SQL Do
  Begin
    Close;
    Clear;
    Add(' SELECT * FROM GEIQUA WHERE GMT_CODPAG = :CODPAG ');
    ParamByName('CODPAG').AsString := edtProdutos.Text;
    Open;

    pAlimentaCdsItens;
  End;
End;

procedure TfrmCadPadraQualidade.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

end;

procedure TfrmCadPadraQualidade.pLimparCampos;
begin
  edtProdutos.Clear;
  edtDesProduto.Clear;
  edtEspeci.Clear;
  edtParame.Clear;
end;

procedure TfrmCadPadraQualidade.pGravarItens;
{*** ALIMENTANDO A QUERY PRINCIPAL COM OS ITENS GRAVADOS/ALTERADOS ****}
begin
  with cdsCloneTabela do
  begin
    DisableControls;
    Filtered := False;
    First;
    while not EOF do
    begin
      if FieldByName('AUTOINCREM').AsString = '0' then {ITEM NOVO}
      begin
        qryTabela.Append;
        qryTabela.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('GEIQUA', VS_strCodEmp);
        qryTabela.FieldByName('GMT_CODQUA').AsString := fProximoCodigo;
        qryTabela.FieldByName('GMT_CODPAG').AsString := edtProdutos.Text;
        qryTabela.FieldByName('GMT_ESPECI').AsString := FieldByName('GMT_ESPECI').AsString;
        qryTabela.FieldByName('GMT_PARAME').AsString := FieldByName('GMT_PARAME').AsString;
        qryTabela.Post;
      end
      else if (FieldByName('AUTOINCREM').AsString <> '0') and (FieldByName('GMT_CODQUA').AsString <> '-1') then {ITEM JÁ EXISTENTE}
      begin
        qryTabela.Locate('AUTOINCREM',FieldByName('AUTOINCREM').AsString,[]);
        qryTabela.Edit;
        qryTabela.FieldByName('GMT_ESPECI').AsString := FieldByName('GMT_ESPECI').AsString;
        qryTabela.FieldByName('GMT_PARAME').AsString := FieldByName('GMT_PARAME').AsString;
        qryTabela.Post;
      end
      else if FieldByName('GMT_CODQUA').AsString = '-1' then {ITEM EXCLUIDO}
      begin
        qryTabela.Locate('AUTOINCREM',FieldByName('AUTOINCREM').AsString,[]);
        qryTabela.Delete;
      end;
      Next;
    end;
    Filter := 'GMT_CODQUA <> -1';
    Filtered := True;
    EnableControls;
  end;
end;

procedure TfrmCadPadraQualidade.pCriaCdsItens;
Var intCont : Integer;
begin
  For intCont := 0 To qryTabela.Fields.Count -1 Do
  begin
    cdsCloneTabela.FieldDefs.Add(qryTabela.Fields[intCont].FieldName,qryTabela.Fields[intCont].DataType,qryTabela.Fields[intCont].Size,False);
  End;
  cdsCloneTabela.CreateDataSet;
  cdsCloneTabela.Open;
  cdsCloneTabela.Filter := 'GMT_CODQUA <> -1';
  cdsCloneTabela.Filtered := True;
end;

procedure TfrmCadPadraQualidade.pAlimentaCdsItens;
begin
  cdsCloneTabela.Close;
  cdsCloneTabela.CreateDataSet;
  cdsCloneTabela.Open;

  If Assigned(qryTabela) And qryTabela.Active Then
  Begin
    qryTabela.First;
    While Not qryTabela.Eof Do
    Begin
      cdsCloneTabela.Insert;
      cdsCloneTabela.FieldByName('AUTOINCREM').AsString   := qryTabela.FieldByName('AUTOINCREM').AsString;
      cdsCloneTabela.FieldByName('GMT_CODQUA').AsString   := qryTabela.FieldByName('GMT_CODQUA').AsString;
      cdsCloneTabela.FieldByName('GMT_CODPAG').AsString   := qryTabela.FieldByName('GMT_CODPAG').AsString;
      cdsCloneTabela.FieldByName('GMT_ESPECI').AsString   := qryTabela.FieldByName('GMT_ESPECI').AsString;
      cdsCloneTabela.FieldByName('GMT_PARAME').AsString   := qryTabela.FieldByName('GMT_PARAME').AsString;
      cdsCloneTabela.Post;

      qryTabela.Next;
    End;
  End;


end;


end.

