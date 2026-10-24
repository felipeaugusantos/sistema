unit untCnfNotaFiscalEletronica;

interface

uses
  Windows, Classes, Controls, untPaiSimples, AppEvnts, Menus, ComCtrls, StdCtrls,
  Buttons, ExtCtrls, DBEditFocus, Grids, DBGridCitel, DBGrids, Uni, DB, DBMemoFocus,
  BitBtnLockedIncrem, DBCtrls, Mask, QColorLabel, frxClass, strUtils, untFuncFat,
  frxExportCSVTestabilidade, BCEditor.Editor.Base, BCEditor.Editor, BCEditor.Types,
  cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, cxButtons, untFuncMacro,
  UniClientDataSet, untFuncoesSimples;

type
  TfrmCnfNotaFiscalEletronica = class(TfrmPaiSimples)
    Panel1: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    PopupMenu1: TPopupMenu;
    MenuItem1: TMenuItem;
    dbgConfigs: TDBGridCitel;
    pnlBotoesCnf: TPanel;
    pnlDados: TPanel;
    Label2: TLabel;
    Label8: TLabel;
    dbeIdenti: TDBEditFocus;
    pnlCabecalho: TPanel;
    lblTitulo: TLabel;
    popConfig: TPopupMenu;
    mnuIncluir: TMenuItem;
    N2: TMenuItem;
    mnuEditaReg: TMenuItem;
    N1: TMenuItem;
    mnuDeletaReg: TMenuItem;
    memDesCam: TBCEditor;
    lblSetor: TLabel;
    dbeSetor: TDBEditFocus;
    BitBtn1: TBitBtnLocked;
    btnIrGrid: TBitBtnLocked;
    btnConfirma: TBitBtnLocked;
    btnNovaConf: TBitBtnLocked;
    lblTipMsgDes: TColorLabel;
    lblTipMsg: TLabel;
    dbeTipMsg: TDBEditFocus;
    lblCarDis: TLabel;
    btnPesqVar: TcxButton;
    procedure FormCreate(Sender: TObject);
    procedure pHabilitaEdits(blnHabilita: Boolean);
    procedure btnNovaConfClick(Sender: TObject);
    procedure dbgConfigsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnIrGridClick(Sender: TObject);
    procedure memDesCamKeyPress(ASender: TObject; var AKey: Char);
    procedure memDesCamChange(Sender: TObject);
    procedure btnPesqVarClick(Sender: TObject);
    procedure dbgConfigsDblClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    qryCnf_Nfe: TUniQuery;
    dtsCnf_Nfe: TDataSource;
    strTabela : String;
    qryGenEmp : TUniQuery;
    cdsItens  : TUniClientDataSet;
    cpuCampos : TCamposUso;
    procedure pAfterScroll(Dataset: TDataset);
    procedure pCriaDataSets();
    procedure pLigaDataSets();
    procedure pIncluirRegistro;
    procedure pDeletaRegistro;
    procedure pEditaRegistro;
    function fRetProximoCodSeq(): Integer;
    { Private declarations }
  protected
    Procedure pAjustaCampoExpressaoSQL;
    function fValidaExpressao: Boolean;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    objVenda: TFatVenda;
  end;

var
  frmCnfNotaFiscalEletronica: TfrmCnfNotaFiscalEletronica;

implementation

uses SysUtils, Forms, untPai, untCnfNotaFiscal, untFatSelVar;

{$R *.dfm}

{ TfrmCnfNotaFiscalEletronica }

procedure TfrmCnfNotaFiscalEletronica.pAfterScroll(Dataset: TDataset);
begin
  memDesCam.Text := Dataset.FieldByName('CNF_DESCAM').AsString.Replace(#13, ' ');
  memDesCamChange(memDesCam);
end;

procedure TfrmCnfNotaFiscalEletronica.pAjustaCampoExpressaoSQL;
Var
  rscSQL: TResourceStream;
  rscCores: TResourceStream;
Begin
  rscSQL   := TResourceStream.Create(HInstance,'MySQLJson',RT_RCDATA);
  try
    memDesCam.Highlighter.LoadFromStream(rscSQL);
  finally
    FreeAndNil(rscSQL);
  end;

  rscCores := TResourceStream.Create(HInstance,'CoresJson',RT_RCDATA);
  try
    memDesCam.Highlighter.Colors.LoadFromStream(rscCores);
  finally
    FreeAndNil(rscCores);
  end;
end;

procedure TfrmCnfNotaFiscalEletronica.pCriaDataSets;
begin
  qryCnf_Nfe := fCriaQuery(Self);
  qryCnf_Nfe.SQL.Add('SELECT ');
  qryCnf_Nfe.SQL.Add('  CNF_CODSEQ, ');
  qryCnf_Nfe.SQL.Add('  CNF_IDENTI, ');
  qryCnf_Nfe.SQL.Add('  CNF_SETOR_, ');

  If SameText(strTabela, 'CNF_NFE') Then
  Begin
    qryCnf_Nfe.SQL.Add('  CNF_TIPMSG, ');
    qryCnf_Nfe.SQL.Add('  IF(CNF_TIPMSG = "C", "Comercial", "Fiscal") AS CNF_TIPTMP, ')
  End
  Else
    qryCnf_Nfe.SQL.Add('  " " AS CNF_TIPTMP, ');

  qryCnf_Nfe.SQL.Add('  CNF_DESCAM, ');
  qryCnf_Nfe.SQL.Add('  CNF_CODEMP ');
  qryCnf_Nfe.SQL.Add('FROM ' + strTabela + ' WHERE CNF_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' ORDER BY CNF_SETOR_, CNF_IDENTI ');

  dtsCnf_Nfe := fCriaDataSource(qryCnf_Nfe);

  qryCnf_Nfe.AfterScroll := pAfterScroll;

  qryCnf_Nfe.Open;

  qryCnf_Nfe.FieldByName('CNF_CODSEQ').DisplayLabel := 'Sequencial';
  qryCnf_Nfe.FieldByName('CNF_IDENTI').DisplayLabel := 'ID';
  qryCnf_Nfe.FieldByName('CNF_DESCAM').DisplayLabel := 'Descrição';
  qryCnf_Nfe.FieldByName('CNF_SETOR_').DisplayLabel := 'Setor da NF-e';
  qryCnf_Nfe.FieldByName('CNF_TIPTMP').DisplayLabel := 'Tipo da Mensagem';

  qryCnf_Nfe.FieldByName('CNF_CODSEQ').Visible := False;
  qryCnf_Nfe.FieldByName('CNF_CODEMP').Visible := False;

  If SameText(strTabela, 'CNF_NFE') Then
  Begin
    qryCnf_Nfe.FieldByName('CNF_TIPMSG').Visible := False;
    qryCnf_Nfe.Fields[4].ReadOnly := False;
  End
  Else
    qryCnf_Nfe.FieldByName('CNF_TIPTMP').Visible := False;

  qryCnf_Nfe.FieldByName('CNF_SETOR_').Visible := strTabela = 'CNF_NFE';

  qryTabela := qryCnf_Nfe;
end;

procedure TfrmCnfNotaFiscalEletronica.pLigaDataSets;
  Var
    intCont: Integer;
begin
  For intCont := 0 To ComponentCount - 1 Do
  Begin

    If (Components[intCont] is TDBEdit)  Then
    Begin
      (Components[intCont] as TDBEdit).DataSource := dtsCnf_Nfe;
    End;

    If (Components[intCont] is TDBGridCitel) Then
    Begin
      (Components[intCont] as TDBGridCitel).DataSource := dtsCnf_Nfe;
    End;

    If (Components[intCont] is TDBMemo) Then
    Begin
      (Components[intCont] as TDBMemo).DataSource := dtsCnf_Nfe;
    End;

  End;

  dbeIdenti.DataField := 'CNF_IDENTI';
  dbeSetor.DataField  := 'CNF_SETOR_';

  If SameText(strTabela, 'CNF_NFE') Then
    dbeTipMsg.DataField := 'CNF_TIPMSG';
end;

procedure TfrmCnfNotaFiscalEletronica.btnPesqVarClick(Sender: TObject);
var
  LVarSel: String;
  LPos: TBCEditorTextPosition;
begin
  inherited;
  if strTabela.Equals('CNF_NFE_ITE') then
  begin
    objVenda.pAtualizaCamposUso(cpuCampos, qryGenEmp, cdsItens);
    LVarSel := TfrmFatSelVar.SelectProperty(objVenda, objVenda.strPrefixoPropriedadesCNF_NF, cpuCampos);
  end
  else
    LVarSel := TfrmFatSelVar.SelectProperty(objVenda, objVenda.strPrefixoPropriedadesCNF_NF, nil);
  if not fEmptyStr(LVarSel) then
  begin
    LPos := memDesCam.TextCaretPosition;
    memDesCam.Lines[LPos.Line] := Copy(memDesCam.Lines[LPos.Line], 1, LPos.Char - 1) +
      LVarSel + Copy(memDesCam.Lines[LPos.Line], LPos.Char, 255);
    memDesCamChange(memDesCam);
  end;
end;

procedure TfrmCnfNotaFiscalEletronica.FormCreate(Sender: TObject);
begin
  objVenda := nil;
  qryGenEmp := fCriaQuery;
  pCarregaQueryEmpresa(qryGenEmp);
  cdsItens := fCriaClientdatset(cdsVenda);
  pAjustaCampoExpressaoSQL;

  If fGetMenu('Selecione a configuração:',
              ['Dados Adicionais da NFe',
               'Dados Adicionais dos Produtos NFe'], 1) = 1 Then
  Begin
    strTabela         := 'CNF_NFE';
    lblTitulo.caption := 'CONFIGURAÇÃO DADOS ADICIONAIS NOTA FISCAL ELETRÔNICA';
    lblSetor.Visible  := True;
    dbeSetor.Visible  := True;
    dbeTipMsg.Visible := True;
    lblTipMsg.Visible := True;
    lblTipMsgDes.Visible := True;
  End
  Else
  Begin
    strTabela         := 'CNF_NFE_ITE';
    lblTitulo.caption := 'CONFIGURAÇÃO DADOS ADICIONAIS DOS PRODUTOS NOTA FISCAL ELETRÔNICA';
    lblSetor.Visible  := False;
    dbeSetor.Visible  := False;
    dbeTipMsg.Visible := False;
    lblTipMsg.Visible := False;
    lblTipMsgDes.Visible := False;
  End;

  pCriaDataSets();
  pLigaDataSets();
  pSetFocus(dbgConfigs);

  fFindColumnByName(dbgConfigs, 'CNF_DESCAM').Width := Self.Width - 255;
end;

procedure TfrmCnfNotaFiscalEletronica.FormDestroy(Sender: TObject);
begin
  inherited;
  If Assigned(cdsItens)  Then FreeAndNil(cdsItens);
  If Assigned(qryGenEmp) Then FreeAndNil(qryGenEmp);
  If Assigned(cpuCampos) Then FreeAndNil(cpuCampos);
end;

procedure TfrmCnfNotaFiscalEletronica.pHabilitaEdits(blnHabilita: Boolean);
begin
  pnlDados.Enabled    := blnHabilita;
  btnPesqVar.Enabled  := blnHabilita;
  dbgConfigs.Enabled  := Not blnHabilita;
  btnNovaConf.Enabled := Not blnHabilita;
  btnConfirma.Enabled := blnHabilita;
end;

function TfrmCnfNotaFiscalEletronica.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = dbeIdenti) Then
    Begin
      If fEmptyStr((Sender As TDBEditFocus).Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Campo ' + (Sender As TDBEditFocus).Field.DisplayLabel +
                              ' deve ser preenchido!', ['&O k']);
        Result := False;
      End;
    End
    Else If (Sender = dbeTipMsg) And SameText(strTabela, 'CNF_NFE') Then
    Begin
      If fEmptyStr(dbeTipMsg.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo "Tipo de Mensagem" deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        If Pos(dbeTipMsg.Text, 'CF') <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Defina o "Tipo de Mensagem" como (C)ormecial ou (F)iscal!', ['&O k']);
          Result := False;
        End;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmCnfNotaFiscalEletronica.fValidaExpressao: Boolean;
begin
  if not assigned(objVenda) then
    Exit(True);
  try
    if strTabela.Equals('CNF_NFE_ITE') then
      objVenda.pAtualizaCamposUso(cpuCampos, qryGenEmp, cdsItens);
    { FUNC MACRO }
    pInicializaVariaveis;
    lstVariaveis.Clear;
    try
      if strTabela.Equals('CNF_NFE_ITE') then
        fProcessaMacro(objVenda, cpuCampos, memDesCam.Text, objVenda.strPrefixoPropriedadesCNF_NF)
      else
        fProcessaMacro(objVenda, nil, memDesCam.Text, objVenda.strPrefixoPropriedadesCNF_NF);
      Result := True;
    except
      on E: Exception do
      begin
        pMensagemOk(E.Message);
        pSetFocus(memDesCam);
        Result := False;
      end;
    end;
  finally
    lstVariaveis.Clear;
  end;
end;

procedure TfrmCnfNotaFiscalEletronica.memDesCamChange(Sender: TObject);
begin
  inherited;
  lblCarDis.Caption := (250 - Length(memDesCam.Text)).ToString + ' caracteres disponíveis';
end;

procedure TfrmCnfNotaFiscalEletronica.memDesCamKeyPress(ASender: TObject; var AKey: Char);
var
  LPos: TBCEditorTextPosition;
begin
  inherited;
  if (Length(memDesCam.Text) >= 250) Or (AKey = #13) Then
  begin
    memDesCam.Text := LeftStr(memDesCam.Text, 250).Replace(#13, ' ').Trim;

    if (AKey = #13) then
      pSetFocus(btnConfirma)
    else
    begin
      LPos.Char := Length(memDesCam.Lines[memDesCam.Lines.Count-1]) + 1;
      LPos.Line := memDesCam.Lines.Count-1;
      memDesCam.TextCaretPosition := LPos;
    end;

    AKey := #0;
  end;
  memDesCamChange(memDesCam);
end;

procedure TfrmCnfNotaFiscalEletronica.btnNovaConfClick(Sender: TObject);
begin
  inherited;
  pHabilitaEdits(True);
  pSetFocus(dbeIdenti);
  qryTabela.Insert;
  pAfterScroll(qryTabela);
  qryCnf_Nfe.FieldByName('CNF_CODEMP').AsString := VS_strCodEmp;
end;

procedure TfrmCnfNotaFiscalEletronica.dbgConfigsDblClick(Sender: TObject);
begin
  inherited;
  pEditaRegistro;
end;

procedure TfrmCnfNotaFiscalEletronica.dbgConfigsKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_Return) Then
  Begin
    pEditaRegistro;
  End
  Else If (Key = VK_Escape) Then
  Begin
    Close;
  End
  Else If (Key = VK_Delete) Then
  Begin
    pDeletaRegistro;
  End
  Else If (Key = VK_Insert) Then
  Begin
    pIncluirRegistro;
  End;
end;

procedure TfrmCnfNotaFiscalEletronica.pDeletaRegistro;
begin
  If (Not qryTabela.IsEmpty) And
     (fMensagem('', 'Confirma exclusão do registro?', ['&Não', '&Sim']) = 2) Then
  Begin
    qryTabela.Delete;
    pAfterScroll(qryTabela);
  End;
end;

procedure TfrmCnfNotaFiscalEletronica.pEditaRegistro;
begin
  qryTabela.Edit;
  pAfterScroll(qryTabela);
  pHabilitaEdits(True);

  If dbgConfigs.SelectedField.FieldName = 'CNF_IDENTI' Then
    pSetFocus(dbeIdenti)
  Else
    pSetFocus(memDesCam);
end;

procedure TfrmCnfNotaFiscalEletronica.pIncluirRegistro;
  Var
    blnCopiaDescri: Boolean;
    intRetMsg: Integer;
    tmpCnfNot: TCnfNot;
begin

  blnCopiaDescri := False;
  {*****************************************}
  {* CASO A TABELA ESTIVER VAZIA, SAI      *}
  {**************************************MV*}
  If qryTabela.IsEmpty Then
  Begin
    Exit;
  End;

  intRetMsg := fMensagem('', 'Copia Descrição?', ['&Sim', '&Não', '&Cancelar']);

  Case intRetMsg Of
    1: blnCopiaDescri := True;
    2: blnCopiaDescri := False;
    3: Exit;
  End;

  Try

    With qryTabela Do
    Begin
      tmpCnfNot.strIdenti := FieldByName('CNF_IDENTI').AsString;

      If blnCopiaDescri Then
        tmpCnfNot.strDesCam := FieldByName('CNF_DESCAM').AsString
      Else
        tmpCnfNot.strDesCam := '';

      tmpCnfNot.strChrDep := FieldByName('CNF_CHRDEP').AsString;

      Insert;
      FieldByName('CNF_IDENTI').AsString  := tmpCnfNot.strIdenti;
      FieldByName('CNF_DESCAM').AsString  := tmpCnfNot.strDesCam;
      FieldByName('CNF_CODEMP').AsString  := VS_strCodEmp;

      Post;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pIncluirRegistro]');

      qryTabela.Cancel;
      pAfterScroll(qryTabela);
    End;
  End;
end;

procedure TfrmCnfNotaFiscalEletronica.btnConfirmaClick(Sender: TObject);
  Var
    intRecNo: Integer;
begin
  Try
    intRecNo := qryTabela.RecNo;

    If Not (qryTabela.State = dsBrowse) Then
    Begin

      If Not fVerificaCampos Then
        Exit;

      If Not fValidaExpressao Then
        Exit;

      {*****************************************}
      {* GRAVA O CAMPO AUTO INCREMENTO         *}
      {**************************************MV*}
      If qryTabela.State = dsInsert Then
        If (qryTabela.FindField('AUTOINCREM') <> Nil) Then
          qryTabela.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CNFBOL', VS_strCodEmp);

      qryTabela.FieldByName('CNF_CODSEQ').AsInteger := fRetProximoCodSeq();

      qryTabela.FieldByName('CNF_DESCAM').AsString := memDesCam.Text;

      If SameText(strTabela, 'CNF_NFE') Then
        qryTabela.FieldByName('CNF_TIPTMP').AsString  := IIF(SameText(qryTabela.FieldByName('CNF_TIPMSG').AsString, 'C'), 'Comercial', 'Fiscal');

      qryTabela.Post;
      pHabilitaEdits(False);

//      fFecharTabela(qryTabela);
//      fAbrirTabela(qryTabela);

      pSetFocus(dbgConfigs);
      qryTabela.RecNo := intRecNo;

    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[ Gravação da Configuração de Boletos ]');
    End;
  End;
end;

procedure TfrmCnfNotaFiscalEletronica.btnIrGridClick(Sender: TObject);
begin
  inherited;
  If qryTabela.UpdatesPending Then
    qryTabela.CancelUpdates;

  qryTabela.Cancel;
  pAfterScroll(qryTabela);

  pHabilitaEdits(False);
  pSetFocus(dbgConfigs);
end;


function TfrmCnfNotaFiscalEletronica.fRetProximoCodSeq: Integer;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Self);
  qryGen.ParamCheck := False;

  qryGen.SQL.Text := 'SELECT MAX(CNF_CODSEQ) SEQ FROM ' + strTabela;
  qryGen.Open;

  If qryGen.FieldByName('SEQ').IsNull Then
    Result := 1
  Else
    Result := qryGen.FieldByName('SEQ').AsInteger + 1;

  FreeAndNil(qryGen);
end;

end.

