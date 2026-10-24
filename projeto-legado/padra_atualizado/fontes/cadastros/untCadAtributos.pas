unit untCadAtributos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.Mask, Vcl.DBCtrls,
  DBEditFocus, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, untTypesSistema,
  untZClient, cxTextEdit, EditFocus;

type
  TListaOpcAtributos = Class(TZClient)
  Private

    Function fSQLOpcAtributos: String;

  Public

    constructor Create(Owner: TComponent); Reintroduce;

    Procedure pCarregaDados(strLista: String);

    Function fRetornaDados: String;

    Function fExcluiDescricao: Boolean;
  End;

  TfrmCadAtributos = class(TfrmPaiCad)
    pnlDados: TPanel;
    Label1: TLabel;
    dbeCodigo: TDBEditFocus;
    Label2: TLabel;
    dbeDescri: TDBEditFocus;
    dbeTipAtr: TDBRadioGroup;
    grbListaOpcoes: TGroupBox;
    cxvOpcoes: TcxGridDBTableView;
    cxgOpcoesLevel1: TcxGridLevel;
    cxgOpcoes: TcxGrid;
    cxvOpcoesDescricao: TcxGridDBColumn;
    btnDelOpcao: TBitBtnLocked;
    dtsCadAtr: TDataSource;
    lblNroDec: TLabel;
    dbeNroDec: TDBEditFocus;
    Label3: TLabel;
    dbeCodGru: TDBEditFocus;
    edtDesGru: TEditFocus;
    procedure dbeTipAtrChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnDelOpcaoClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure dbeCodGruKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodGruEnter(Sender: TObject);
    procedure dbeCodGruExit(Sender: TObject);
    function dbeCodGruChamaCadastro(Key: Word): string;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }

    objOpcoes: TListaOpcAtributos;

    procedure pCarregaDadosAdicionais(blnHabilita: Boolean);

  public
    { Public declarations }
  protected
    procedure pOnStateChange; override;
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

function fChamaCadAtr(Key: Word): String;

var
  frmCadAtributos: TfrmCadAtributos;

implementation

{$R *.dfm}

Uses
  untFuncIns2,
  untFuncoesConsulta,
  untCadGrupoAtributo,
  untConsultas,
  untFuncoesSimples,
  untAtributosProduto;

constructor TListaOpcAtributos.Create(Owner: TComponent);
Begin

  Inherited Create(Owner, fSQLOpcAtributos);

  fLeDados('TListaOpcAtributos');
  EmptyDataSet;

End;

Function TListaOpcAtributos.fSQLOpcAtributos: String;
Var
  strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   CAST("" AS CHAR(255)) AS DESCRI ';
  Result := strSQL;
End;

Procedure TListaOpcAtributos.pCarregaDados(strLista: String);
Var
  stlLista: TStringList;
  intContador: Integer;
Begin
  EmptyDataSet;

  stlLista := TStringList.Create;
  stlLista.Text := strLista;

  For intContador := 0 To stlLista.Count - 1 Do
  Begin
    Append;
    FieldByName('DESCRI').AsString := stlLista[intContador];
    Post;
  End;

  FreeAndNil(stlLista);
End;

Function TListaOpcAtributos.fRetornaDados: String;
Var
  stlLista: TStringList;
Begin
  stlLista := TStringList.Create;
  First;
  While Not Eof Do
  Begin
    stlLista.Add(FieldByName('DESCRI').AsString);
    Next;
  End;

  Result := stlLista.Text;
  FreeAndNil(stlLista);
End;

Function TListaOpcAtributos.fExcluiDescricao: Boolean;
Begin
  Result := False;

  If IsEmpty Then
    Exit;

  Delete;
  Result := True;
End;

procedure TfrmCadAtributos.btnAlterarClick(Sender: TObject);
begin
  inherited;

  pHabilitaCodigo(dbeCodigo, dbeDescri, False);

  pCarregaDadosAdicionais(True);
end;

procedure TfrmCadAtributos.btnCancelaClick(Sender: TObject);
begin
  inherited;

  pCarregaDadosAdicionais(False);
end;

procedure TfrmCadAtributos.btnDelOpcaoClick(Sender: TObject);
begin
  inherited;

  objOpcoes.fExcluiDescricao;
end;

procedure TfrmCadAtributos.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadAtributos.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

  pCarregaDadosAdicionais(False);
end;

procedure TfrmCadAtributos.btnGravarClick(Sender: TObject);
begin
  If qryTabela.FieldByName('ATR_TIPATR').AsInteger = TIPO_ATR_LISTA Then
    qryTabela.FieldByName('ATR_LISATR').AsString := objOpcoes.fRetornaDados
  Else
    qryTabela.FieldByName('ATR_LISATR').Clear;

  If Not(qryTabela.FieldByName('ATR_TIPATR').AsInteger In [TIPO_ATR_DECIMAL, TIPO_ATR_INTEVALO_DECIMAL]) Then
    qryTabela.FieldByName('ATR_NRODEC').Clear;

  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadAtributos.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadAtributos.btnIncluirClick(Sender: TObject);
begin
  inherited;

  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodigo, dbeDescri, False)
  Else
    pHabilitaCodigo(dbeCodigo, dbeCodigo, True);

  qryTabela.FieldByName('ATR_TIPATR').AsInteger := TIPO_ATR_ALFANUMERICOS;

  pCarregaDadosAdicionais(True);
end;

procedure TfrmCadAtributos.btnPesquisaClick(Sender: TObject);
Var
  chrKey: Char;
  arrAtiv: TConsultasArray;
begin
  chrKey := '/';

  If fPesqAtributo(Self, Nil, Nil, qryTabela, chrKey, arrAtiv) Then
    pSetFocus(btnAlterar);

  pCarregaDadosAdicionais(False);
end;

function TfrmCadAtributos.dbeCodGruChamaCadastro(Key: Word): string;
begin
  inherited;

  Result := fChamaAtrGru(Key);

end;

procedure TfrmCadAtributos.dbeCodGruEnter(Sender: TObject);
begin
  inherited;

  pnlInfo.Caption := '[Insert] para incluir um novo Grupo';
end;

procedure TfrmCadAtributos.dbeCodGruExit(Sender: TObject);
begin
  inherited;

  pnlInfo.Caption := '';
end;

procedure TfrmCadAtributos.dbeCodGruKeyPress(Sender: TObject; var Key: Char);
Var
  arrDados: TConsultasArray;
begin
  inherited;

  If fPesqGrupoAtributo(Self, dbeCodGru, edtDesGru, Nil, Key, arrDados) Then
    If fValidaCampos(dbeCodGru, True) Then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadAtributos.dbeTipAtrChange(Sender: TObject);
begin
  inherited;
  lblNroDec.Enabled := dbeTipAtr.ItemIndex In [2, 5];
  dbeNroDec.Enabled := dbeTipAtr.ItemIndex In [2, 5];

  grbListaOpcoes.Enabled := dbeTipAtr.ItemIndex = 6;
  btnDelOpcao.Enabled := dbeTipAtr.ItemIndex = 6;
end;

procedure TfrmCadAtributos.FormCreate(Sender: TObject);
begin
  inherited;

  strNomeTabela := 'CADATR';
  strNomeCampo := 'ATR_CODIGO';

  qryTabela := fCriaQuery(Self);
  dtsCadAtr.DataSet := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;

  objOpcoes := TListaOpcAtributos.Create(Self);

  cxvOpcoes.DataController.DataSource := objOpcoes.dtsSource;
end;

procedure TfrmCadAtributos.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_RETURN:
      If Assigned(ActiveControl) And ActiveControl.ClassNameIs('TGroupButton') Then
        SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadAtributos.FormShow(Sender: TObject);
begin
  inherited;

  If (Not(fCfgSis('EMPGER', varBoolean))) Then
  Begin
    btnIncluir.Enabled := False;
    btnAlterar.Enabled := False;
    btnExcluir.Enabled := False;
  End;

  If btnIncluir.Enabled Then
    pSetFocus(btnIncluir);
end;

function TfrmCadAtributos.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender)) Then
  Begin

    If (Sender = dbeCodigo) Then
    Begin
      If (fEmptyStr(dbeCodigo.Text)) And (dbeCodigo.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do Atributo deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (blnBuscaPorChave) Then
      Begin
        If Not fBuscaPorCamposChave Then
          pLimparCampos;
      End;
    End

    Else If (Sender = dbeDescri) Then
    Begin
      If fEmptyStr(dbeDescri.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Descrição do Atributo deve ser preenchida!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = dbeCodGru) Then
    Begin

      If fEmptyStr(dbeCodGru.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Grupo do Atributo deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin

        edtDesGru.Text := fRetDescricaoGrupoAtributo(dbeCodGru.Text);

        If fEmptyStr(edtDesGru.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Grupo de Atributo não encontrado!', ['&Ok']);
          Result := False;
        End;

      End;

    End

    Else If (Sender = dbeNroDec) Then
    Begin

      If dbeNroDec.Enabled Then
      Begin

        If StrToIntDef(dbeNroDec.Text, -1) <= 0 Then
        Begin
          pMensagemOk('O número de decimais deve ser maior que zero!');
          Result := False;
        End;

      End;

    End

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadAtributos.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
end;

procedure TfrmCadAtributos.pOnStateChange;
begin
  inherited;
  dbeTipAtr.Enabled := btnGravar.Enabled;
  dbeNroDec.Enabled := btnGravar.Enabled;
  grbListaOpcoes.Enabled := btnGravar.Enabled;

  If btnGravar.Enabled Then
    dbeTipAtrChange(Nil);
end;

procedure TfrmCadAtributos.pCarregaDadosAdicionais(blnHabilita: Boolean);
begin
  dbeTipAtrChange(Nil);

  If Not blnHabilita Then
  Begin
    dbeNroDec.Enabled := False;
    grbListaOpcoes.Enabled := False;
  End;

  edtDesGru.Text := fRetDescricaoGrupoAtributo(dbeCodGru.Text);

  objOpcoes.pCarregaDados(qryTabela.FieldByName('ATR_LISATR').AsString);
end;

function fChamaCadAtr(Key: Word): String;
begin
  Result := fChamaForm(Key, TfrmCadAtributos, frmCadAtributos);
end;

end.
