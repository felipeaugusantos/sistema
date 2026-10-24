unit untCadInstrucoes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.Mask, Vcl.DBCtrls,
  DBEditFocus, DBMemoFocus, DBComboBoxFocus, ComboBoxFocus, Data.DB,
  untInterfaceRelatorio, BCEditor.Editor.Base, BCEditor.Editor, Uni, EditFocus;

type
  TfrmCadInstrucoes = class(TfrmPaiCad)
    pnlDados: TPanel;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    dbeDescri: TDBEditFocus;
    Panel2: TPanel;
    lblSimbol: TLabel;
    dbeSimbol: TDBEditFocus;
    dtsRelIns: TDataSource;
    bceINSSQL: TBCEditor;
    btnUtiRel: TBitBtnLocked;
    dtsUtiRel: TDataSource;
    SpeedButton1: TSpeedButton;
    dtsUtiTem: TDataSource;
    dtsUtiIns: TDataSource;
    edtDesRel: TEditFocus;
    edtCodRel: TEditFocus;
    dbeCodRel: TDBEditFocus;
    Label13: TLabel;
    procedure btnAlterarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbeSimbolKeyPress(Sender: TObject; var Key: Char);
    procedure dbeINSSQLKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure bceINSSQLKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnUtiRelClick(Sender: TObject);
    procedure edtCodRelExit(Sender: TObject);
    procedure edtCodRelKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }

    procedure pEditorToTabela;
    procedure pCarregaDados;
    procedure pHabilitaTela(blnHabilita: Boolean);

  public
    { Public declarations }
    strCodigo: String;

  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;


implementation

{$R *.dfm}

uses
  StrUtils,
  untFuncoesSimples,
  untConsultas,
  untFuncoesConsulta,
  untTypesSistema,
  untFuncoes,
  untFuncoesRel, untFuncoesRel2;

procedure TfrmCadInstrucoes.bceINSSQLKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;


  If (ssAlt In Shift) And (Key = 193) Then
  begin
    TInterfaceRelatorio.fGetInstrucaoSQLToMemo(Self, bceINSSQL);

    Key := 0;
  end

end;

procedure TfrmCadInstrucoes.btnAlterarClick(Sender: TObject);
begin
  inherited;

  pHabilitaCodigo(dbeDescri, dbeSimbol, True);

  pSetFocus(dbeDescri);

  pCarregaDados;
  pHabilitaTela(True);

end;

procedure TfrmCadInstrucoes.btnCancelaClick(Sender: TObject);
begin
  inherited;

  pCarregaDados;
  pHabilitaTela(False);

end;

procedure TfrmCadInstrucoes.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadInstrucoes.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

  pCarregaDados;

end;

procedure TfrmCadInstrucoes.pHabilitaTela(blnHabilita: Boolean);
Begin
  bceInsSQL.Enabled := blnHabilita;
  edtCodRel.Enabled := blnHabilita;
End;

procedure TfrmCadInstrucoes.pCarregaDados;
Begin
  edtCodRel.Text := qryTabela.FieldByName('INS_CODREL').AsString;
  edtDesRel.Text := fRetNomeRelatorio(edtCodRel.Text);
  bceInsSQL.Text := AnsiReplaceStr(qryTabela.FieldByName('INS_INSSQL').AsString, '<<csq>>', #13#10);
End;

procedure TfrmCadInstrucoes.pEditorToTabela;
Begin
  With qryTabela Do
  If State In dsEditModes Then
  Begin
    FieldByName('INS_CODREL').AsString := edtCodRel.Text;
    FieldByName('INS_INSSQL').AsString := AnsiReplaceStr(bceInsSQL.Text, #13#10, '<<csq>>');
  End;
End;

procedure TfrmCadInstrucoes.btnGravarClick(Sender: TObject);
begin

  pEditorToTabela;

  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadInstrucoes.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;

  pHabilitaTela(False);

end;

procedure TfrmCadInstrucoes.dbeINSSQLKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If (ssAlt In Shift) And (Key = 193) Then
  begin
    TInterfaceRelatorio.fGetInstrucaoSQLToMemo(Self, bceINSSQL);

    Key := 0;
  end

end;

procedure TfrmCadInstrucoes.dbeSimbolKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  If Not CharInSet(Key, ['A'..'Z', 'a'..'z', '_', '-', #8]) Then
    Key := #0;
end;

procedure TfrmCadInstrucoes.edtCodRelExit(Sender: TObject);
begin
  inherited;
  if fEmptyStr(edtCodRel.Text) then
  begin
    edtCodRel.Clear;
  end
  else
  begin
    edtDesRel.Text := fRetNomeRelatorio(edtCodRel.Text);

    if fEmptyStr(edtDesRel.Text) then
    begin
      pMensagemOk('Relatório ' + edtCodRel.Text + ' não encontrado!');
      edtCodRel.Clear;
      edtDesRel.Clear;
    end;
  end;
end;

procedure TfrmCadInstrucoes.edtCodRelKeyPress(Sender: TObject; var Key: Char);
var
  arrRelatorios: TConsultasArray;
begin
  inherited;
  if fPesqRelatorio(Self, edtCodRel, edtDesRel, Nil, False, '', Key, arrRelatorios) then
    pSetFocus(dbeDescri);
end;

procedure TfrmCadInstrucoes.btnIncluirClick(Sender: TObject);
begin
  inherited;

  pHabilitaCodigo(dbeDescri, dbeSimbol, True);

  pSetFocus(edtCodRel);

  pCarregaDados;
  pHabilitaTela(True);

end;

procedure TfrmCadInstrucoes.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrRelatorios: TConsultasArray;
begin
  inherited;

  chrKey := '/';

  If fPesqInstrucaoSQL(Self, Nil, Nil, qryTabela, chrKey, arrRelatorios) Then
  Begin
    pCarregaDados;
    pSetFocus(btnAlterar);
  End;

end;

procedure TfrmCadInstrucoes.btnUtiRelClick(Sender: TObject);
var
  strSIMBOL: String;
begin

  inherited;

  strSIMBOL := '/*IA_' + dbeSimbol.Text + '*/';

  If Not(fEmptyStr(dbeSimbol.Text)) Then
  Begin

      If Assigned(prcExecutaRelatorio) Then
      begin
        prcExecutaRelatorio(171, 7353, [7354,7355],
                            ['SIMBOL'],
                            [strSIMBOL],
                            Sender,
                            nil,
                            True);
      End;

      pSetFocus(btnAlterar);

  End
  Else
  Begin
     fMensagem('ATENÇÃO!', 'Carregue uma Instrução para visualizar os Relatórios, Templates e/ou as Instruções em que esta é utilizada!', ['&Ok']);
     pSetFocus(btnPesquisa);
  End;

end;

procedure TfrmCadInstrucoes.FormCreate(Sender: TObject);
begin
  inherited;

  strNomeTabela         := 'RELINS';
  strNomeCampo          := 'AUTOINCREM';

  qryTabela             := fCriaQuery(Self);
  dtsRelIns.DataSet     := qryTabela;

  SetLength(arrCamposChave, 2);
  arrCamposChave[0]     := dbeCodRel;
  arrCamposChave[1]     := dbeSimbol;

  TInterfaceRelatorio.pAjustaEditorSQL(bceInsSQL);
end;

procedure TfrmCadInstrucoes.FormShow(Sender: TObject);
begin
  inherited;

  If Not fEmptyStr(strCodigo) Then
  Begin
    qryTabela.SQL.Text := 'SELECT * FROM RELINS WHERE AUTOINCREM = ' + QuotedStr(strCodigo);
    qryTabela.Open;

    pCarregaDados;

    pSetFocus(btnAlterar);
  End Else
  Begin

    If btnIncluir.Enabled Then
      pSetFocus(btnIncluir);

  End;

end;

procedure TfrmCadInstrucoes.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;
end;

function TfrmCadInstrucoes.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender)) Then
  Begin

    If (Sender = edtCodRel) Then
    Begin
      If (fEmptyStr(edtCodRel.Text)) And (edtCodRel.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do Relatório deve ser preenchido!', ['&Ok']);
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
        fMensagem('ATENÇÃO!', 'A Descrição deve ser preenchida!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = dbeSimbol)  Then
    Begin

      If dbeSimbol.Enabled Then
      Begin

        If fEmptyStr(dbeSimbol.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'O símbolo deve ser preenchido!', ['&Ok']);
          Result := False;
        End;

      End;

    End

    Else If (Sender = bceINSSQL)  Then
    Begin

      If fEmptyStr(bceINSSQL.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A instrução SQL deve ser preenchida!', ['&Ok']);
        Result := False;
      End;

    End

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

end.
