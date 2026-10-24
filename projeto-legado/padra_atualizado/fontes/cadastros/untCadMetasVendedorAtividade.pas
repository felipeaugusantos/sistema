unit untCadMetasVendedorAtividade;

interface

uses
  Windows, Classes, Controls, untPai, cxStyles, cxCustomData, cxGraphics, cxFilter,
  cxData, cxDataStorage, cxEdit, DB, cxDBData, cxDBLookupComboBox, Mask,
  MaskEditFocus, StdCtrls, EditFocus, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxControls, cxGridCustomView,
  cxGrid, AppEvnts, Menus, Buttons, BitBtnLockedIncrem, ExtCtrls, UniClientDataSet, Uni,
  cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, frxClass,
  frxExportCSVTestabilidade,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmCadMetasVendedorAtividade = class(TfrmPai)
    pnlAtividade: TPanel;
    Panel2: TPanel;
    cxgAtividades: TcxGrid;
    cxgAtividadesDBTableView1: TcxGridDBTableView;
    cxgAtividadesDBTableView1Column1: TcxGridDBColumn;
    cxgAtividadesDBTableView1Column3: TcxGridDBColumn;
    cxgAtividadesLevel1: TcxGridLevel;
    pnlCadAti: TPanel;
    Label1: TLabel;
    Label6: TLabel;
    edtPraMed: TEditFocus;
    edtCodAti: TEditFocus;
    edtDesAti: TEditFocus;
    pnlPeriodo: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    mskPeriodo: TMaskEditFocus;
    edtCodVen: TEditFocus;
    edtNomVen: TEditFocus;
    btnConfirmar: TBitBtnLocked;
    btnHeranca: TBitBtnLocked;
    Label4: TLabel;
    edtCodEmp: TEditFocus;
    edtDesEmp: TEditFocus;
    Label5: TLabel;
    edtFatura: TEditFocus;
    Label7: TLabel;
    edtMargem: TEditFocus;
    Label8: TLabel;
    cxgAtividadesDBTableView1Column4: TcxGridDBColumn;
    btnAdicionar: TBitBtnLocked;
    dtsAtividade: TDataSource;
    cxgAtividadesDBTableView1Column2: TcxGridDBColumn;
    procedure edtCodVenKeyPress(Sender: TObject; var Key: Char);
    procedure btnAdicionarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnHerancaClick(Sender: TObject);
    procedure edtCodAtiKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure mskPeriodoExit(Sender: TObject);
  private
    cdsAtividade: TUniClientDataSet;
    procedure pAtivaAtividade;
    procedure pAtivaPeriodo;
    procedure pAdicionaAtividade;
    procedure pLimpaAtividade;
    procedure pCarregaMetas;
    procedure pGravaMetas;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

implementation

uses SysUtils, Forms, untConsultas, untFuncoesSimples, untSQLRepositorio,
   untCadMetasVendedorAtividadeHeranca, untTypesSistema;

{$R *.dfm}

procedure TfrmCadMetasVendedorAtividade.btnAdicionarClick(Sender: TObject);
begin
  If fVerificaCampos Then
    pAdicionaAtividade;
end;

procedure TfrmCadMetasVendedorAtividade.btnConfirmarClick(Sender: TObject);
begin
  If Not btnConfirmar.Enabled Then
    Exit;
    
  If fMensagem('ATENÇÃO!', 'Confirma gravação das metas do vendedor?', ['&Sim', '&Não']) = 1 Then
    pGravaMetas;
end;

procedure TfrmCadMetasVendedorAtividade.btnHerancaClick(Sender: TObject);
  Var
    oleDados: OleVariant;
begin
  If Not btnHeranca.Enabled Then
    Exit;
    
  If Not cdsAtividade.IsEmpty Then
  Begin
    If fMensagem('ATENÇÃO!', 'Ao importar as metas, as existentes serão sobrescritas, continuar?', ['&Sim', '&Não']) = 2 Then
      Exit;
  End;

  If TfrmCadMetasVendedorAtividadeHeranca.fGetHeranca(oleDados) Then
  Begin
    cdsAtividade.Data := oleDados;
    TFloatField(cdsAtividade.FieldByName('PRAMED')).DisplayFormat := '#,##0.00';
    TFloatField(cdsAtividade.FieldByName('FATURA')).DisplayFormat := '#,##0.00';
    TFloatField(cdsAtividade.FieldByName('MARGEM')).DisplayFormat := '#,##0.00';
  End;
end;

procedure TfrmCadMetasVendedorAtividade.edtCodAtiKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  If fPesqAtividade(Self, edtCodAti, edtDesAti, Nil, Key, arrSel) Then
  Begin
    If fValidaCampos(edtCodAti) Then
      pSelNext;
  End;
end;

procedure TfrmCadMetasVendedorAtividade.edtCodEmpKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtDesEmp, Nil, Key, arrSel) Then
  Begin
    fValidaCampos(edtCodEmp);
  End;
end;

procedure TfrmCadMetasVendedorAtividade.edtCodVenKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  If fPesqOperador(Self, edtCodVen, edtNomVen, Nil, Key, arrSel) Then
  Begin
    If fValidaCampos(edtCodVen) Then
      pSelNext;
  End;
end;

procedure TfrmCadMetasVendedorAtividade.FormCreate(Sender: TObject);
begin
  inherited;
  cdsAtividade := TUniClientDataSet.Create(Nil);
  cdsAtividade.FieldDefs.Add('CODATI', ftString, 3);
  cdsAtividade.FieldDefs.Add('DESCRI', ftString, 74);
  cdsAtividade.FieldDefs.Add('PRAMED', ftFloat);
  cdsAtividade.FieldDefs.Add('FATURA', ftFloat);
  cdsAtividade.FieldDefs.Add('MARGEM', ftFloat);
  cdsAtividade.CreateDataSet;

  TFloatField(cdsAtividade.FieldByName('PRAMED')).DisplayFormat := '#,##0.00';
  TFloatField(cdsAtividade.FieldByName('FATURA')).DisplayFormat := '#,##0.00';
  TFloatField(cdsAtividade.FieldByName('MARGEM')).DisplayFormat := '#,##0.00';

  dtsAtividade.DataSet := cdsAtividade;

  blnFecharComEscape := False;
end;

procedure TfrmCadMetasVendedorAtividade.FormDestroy(Sender: TObject);
begin
  cdsAtividade.Free;
  inherited;
end;

procedure TfrmCadMetasVendedorAtividade.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  Case Key Of
    VK_ESCAPE:
      Begin
        If pnlAtividade.Enabled Then
        Begin
          If fMensagem('ATENÇÃO!', 'Deseja cancelar a edição da meta desse vendedor?', ['&Sim', '&Não']) = 1 Then
          Begin
            cdsAtividade.EmptyDataSet;
            pLimpaAtividade;
            pAtivaPeriodo;
          End;
        End
        Else
          Close;
      End;

    VK_F10:
      btnConfirmar.Click;

    VK_F5:
      btnHeranca.Click;
  Else
    inherited;
  End;
end;

function TfrmCadMetasVendedorAtividade.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
  Var
    strMsg: String;
begin
  strMsg := '';

  If Sender = edtCodVen Then
  Begin
    If fEmptyStr(edtCodVen.Text) Then
      strMsg := 'Vendedor deve ser preenchido!'
    Else
    Begin
      edtNomVen.Text := fRetNomeOperador(edtCodVen.Text);

      If fEmptyStr(edtNomVen.Text) Then
        strMsg := 'Vendedor não encontrado!';
    End;
  End

  Else If Sender = mskPeriodo Then
  Begin
    If fEmptyStr(mskPeriodo.Text, True) Then
      strMsg := 'Período deve ser preenchido!'
    Else If StrToDateDef('01/' + mskPeriodo.Text, 0) = 0 Then
      strMsg := 'Período inválido!';
  End

  Else If Sender = edtCodEmp Then
  Begin
    If fEmptyStr(edtCodEmp.Text) Then
      strMsg := 'Código da Empresa deve ser preenchido!'
    Else
    Begin
      edtDesEmp.Text := fRetNomeEmpresaSelec(edtCodEmp.Text);

      If fEmptyStr(edtDesEmp.Text) Then
        strMsg := 'Código da Empresa não encontrado!'

      Else
      Begin
        // Segue para informar atividade caso os campos estejam okay e não esteja na atividade ainda
        If Not pnlAtividade.Enabled Then
        Begin
          If fValidaCampos(edtCodVen) And fValidaCampos(mskPeriodo) Then
          Begin
            pAtivaAtividade;
            pCarregaMetas;
            blnMudarFoco := False;
          End;
        End;
      End;
    End;
  End

  Else If Sender = edtCodAti Then
  Begin
    If fEmptyStr(edtCodAti.Text) Then
      strMsg := 'Atividade deve ser preenchido!'
    Else
    Begin
      edtDesAti.Text := fRetAtividade(edtCodAti.Text);

      If fEmptyStr(edtDesAti.Text) Then
        strMsg := 'Atividade não encontrada!';
    End;
  End

  Else If (Sender = edtPraMed) Or (Sender = edtFatura) Or (Sender = edtMargem) Then
  Begin
    If fStrToFloat(TEditFocus(Sender).Text) <= 0 Then
      strMsg := TEditFocus(Sender).Hint + ' deve ser maior que zero!';
  End;

  Result := fEmptyStr(strMsg);

  If Not Result Then
  Begin
    pMensagemOk(strMsg);
    pSetFocus(Sender);
  End;
end;

procedure TfrmCadMetasVendedorAtividade.mskPeriodoExit(Sender: TObject);
begin
  inherited;
  mskPeriodo.Text := fTrataAnoDataMesAno(mskPeriodo.Text);
end;

procedure TfrmCadMetasVendedorAtividade.pAdicionaAtividade;
begin
  If cdsAtividade.Locate('CODATI', edtCodAti.Text, []) Then
  Begin
    If fMensagem('ATENÇÃO!', 'Atividade já cadastrada, deseja sobrescrever?', ['&Sim', '&Não']) = 2 Then
      Exit
    Else
      cdsAtividade.Edit;
  End
  Else
    cdsAtividade.Append;

  cdsAtividade.FieldByName('CODATI').AsString := edtCodAti.Text;
  cdsAtividade.FieldByName('DESCRI').AsString := edtCodAti.Text + '-' +edtDesAti.Text;
  cdsAtividade.FieldByName('PRAMED').AsFloat  := fStrToFloat(edtPraMed.Text);
  cdsAtividade.FieldByName('FATURA').AsFloat  := fStrToFloat(edtFatura.Text);
  cdsAtividade.FieldByName('MARGEM').AsFloat  := fStrToFloat(edtMargem.Text);
  cdsAtividade.Post;

  pLimpaAtividade;

  pSetFocus(edtCodAti);
end;

procedure TfrmCadMetasVendedorAtividade.pAtivaAtividade;
begin
  pnlPeriodo.Enabled := False;
  pnlAtividade.Enabled := True;
  btnHeranca.Enabled := True;
  btnConfirmar.Enabled := True;

  pSetFocus(edtCodAti);
end;

procedure TfrmCadMetasVendedorAtividade.pAtivaPeriodo;
begin
  pnlAtividade.Enabled := False;
  pnlPeriodo.Enabled := True;
  btnHeranca.Enabled := False;
  btnConfirmar.Enabled := False;

  pSetFocus(edtCodVen);
end;

procedure TfrmCadMetasVendedorAtividade.pCarregaMetas;
  Var
    qryMet: TUniQuery;
begin
  qryMet := fCriaQuery;
  Try
    pSQL(qryMet, repFaturamento, 'METATI_SELECT',
         [edtCodVen.Text,
          StrToDate('01/' + mskPeriodo.Text),
          edtCodEmp.Text]);
    qryMet.Open;

    If Not qryMet.IsEmpty Then
    Begin
      // Popula dataset conforme tela de metas
      qryMet.First;
      While Not qryMet.Eof Do
      Begin
        cdsAtividade.Append;
        cdsAtividade.FieldByName('CODATI').AsString := qryMet.FieldByName('MAT_CODATI').AsString;
        cdsAtividade.FieldByName('DESCRI').AsString := qryMet.FieldByName('MAT_CODATI').AsString +'-'+ fRetAtividade(qryMet.FieldByName('MAT_CODATI').AsString);
        cdsAtividade.FieldByName('PRAMED').AsFloat  := qryMet.FieldByName('MAT_PRAMED').AsFloat;
        cdsAtividade.FieldByName('FATURA').AsFloat  := qryMet.FieldByName('MAT_FATURA').AsFloat;
        cdsAtividade.FieldByName('MARGEM').AsFloat  := qryMet.FieldByName('MAT_MARGEM').AsFloat;
        cdsAtividade.Post;

        qryMet.Next;
      End;    
    End;
  Finally
    qryMet.Free;
  End;
end;

procedure TfrmCadMetasVendedorAtividade.pGravaMetas;
  Var
    qryMet: TUniQuery;
    dtaPeriodo: TDate;
    strAutInc: String;
begin
  qryMet := fCriaQuery;
  Try
    dtaPeriodo := StrToDate('01/' + mskPeriodo.Text);
    // Apaga metas desse vendedor nesse período
    pSQL(qryMet, repFaturamento, 'METATI_DELETA',
         [edtCodVen.Text,
          dtaPeriodo,
          edtCodEmp.Text]);

    cdsAtividade.DisableControls;
    cdsAtividade.First;

    While Not cdsAtividade.Eof Do
    Begin
      strAutInc := fRetAutoIncrem('METATI', edtCodEmp.TExt);

      // Insere METATI
      pSQL(qryMet, repFaturamento, 'METATI_INSERE',
           [strAutInc,                                  // [0] AUTOINCREM
            edtCodVen.Text,                             // [1] COD VENDEDOR
            dtaPeriodo,                                 // [2] MESANO
            edtCodEmp.Text,                             // [3] COD EMPRESA
            cdsAtividade.FieldByName('CODATI').AsString,// [4] COD ATIVIDADE
            cdsAtividade.FieldByName('PRAMED').AsFloat, // [5] PRAZO MEDIO
            cdsAtividade.FieldByName('FATURA').AsFloat, // [6] FATURAMENTO
            cdsAtividade.FieldByName('MARGEM').AsFloat  // [7] MARGEM
           ]);

      cdsAtividade.Next;
    End;
    cdsAtividade.EnableControls;

    pMensagemOK('Metas gravadas com sucesso!');

    pLimpaAtividade;
    cdsAtividade.EmptyDataSet;
    pAtivaPeriodo;
  Finally
    qryMet.Free;
  End;
end;

procedure TfrmCadMetasVendedorAtividade.pLimpaAtividade;
begin
  edtCodAti.Clear;
  edtDesAti.Clear;
  edtPraMed.Clear;
  edtFatura.Clear;
  edtMargem.Clear;
end;

end.
