unit untCadTemplates;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.Mask, Vcl.DBCtrls,
  DBEditFocus, DBMemoFocus, DBComboBoxFocus, ComboBoxFocus, Data.DB,
  untInterfaceRelatorio, BCEditor.Editor.Base, BCEditor.Editor, Uni;

type
  TfrmCadTemplates = class(TfrmPaiCad)
    pnlDados: TPanel;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    dbeCodigo: TDBEditFocus;
    dbeDescri: TDBEditFocus;
    Panel2: TPanel;
    Label3: TLabel;
    dbeDesGru: TDBEditFocus;
    Label4: TLabel;
    lblSimbol: TLabel;
    dbeSIMBOL: TDBEditFocus;
    dbeTipSQL: TDBComboBoxFocus;
    dtsCadTem: TDataSource;
    Label13: TLabel;
    bceINSSQL: TBCEditor;
    btnUtiRel: TBitBtnLocked;
    dtsUtiRel: TDataSource;
    SpeedButton1: TSpeedButton;
    dtsUtiTem: TDataSource;
    dtsUtiIns: TDataSource;
    procedure dbeTipSQLClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbeSIMBOLKeyPress(Sender: TObject; var Key: Char);
    procedure dbeINSSQLKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure bceINSSQLKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnUtiRelClick(Sender: TObject);
  private
    { Private declarations }

    procedure pEditorToTabela;
    procedure pTipSQLSet;
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
  untFuncoes, untFuncoesHash,
  untFuncoesRel, untFuncoesRel2;

procedure TfrmCadTemplates.bceINSSQLKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;


  If (ssAlt In Shift) And (Key = 193) Then
  begin
    TInterfaceRelatorio.fGetTemplateSQLToMemo(Self, bceINSSQL);

    Key := 0;
  end

end;

procedure TfrmCadTemplates.btnAlterarClick(Sender: TObject);
begin
  inherited;

  pHabilitaCodigo(dbeCodigo, dbeDesGru, False);

  pCarregaDados;
  pHabilitaTela(True);

  pTipSQLSet;

end;

procedure TfrmCadTemplates.btnCancelaClick(Sender: TObject);
begin
  inherited;

  pCarregaDados;
  pHabilitaTela(False);

end;

procedure TfrmCadTemplates.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadTemplates.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

  pCarregaDados;

end;

procedure TfrmCadTemplates.pHabilitaTela(blnHabilita: Boolean);
Begin
  bceInsSQL.Enabled := blnHabilita;
End;

procedure TfrmCadTemplates.pCarregaDados;
Begin
  bceInsSQL.Text := AnsiReplaceStr(qryTabela.FieldByName('TEM_INSSQL').AsString, '<<csq>>', #13#10);
End;

procedure TfrmCadTemplates.pEditorToTabela;
Begin
  With qryTabela Do
  If State In dsEditModes Then
  Begin
    FieldByName('TEM_INSSQL').AsString := AnsiReplaceStr(bceInsSQL.Text, #13#10, '<<csq>>');
  End;
End;

procedure TfrmCadTemplates.btnGravarClick(Sender: TObject);
begin

  pEditorToTabela;

  qryTabela.FieldByName('TEM_MD5NEW').AsString :=
      fRetHashString(qryTabela.FieldByName('TEM_CODIGO').AsString +
                     qryTabela.FieldByName('TEM_DESCRI').AsString +
                     qryTabela.FieldByName('TEM_DESGRU').AsString +
                     qryTabela.FieldByName('TEM_TIPSQL').AsString +
                     qryTabela.FieldByName('TEM_SIMBOL').AsString +
                     qryTabela.FieldByName('TEM_INSSQL').AsString);


  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadTemplates.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;

  pHabilitaTela(False);

end;

procedure TfrmCadTemplates.dbeINSSQLKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If (ssAlt In Shift) And (Key = 193) Then
  begin
    TInterfaceRelatorio.fGetTemplateSQLToMemo(Self, bceINSSQL);

    Key := 0;
  end

end;

procedure TfrmCadTemplates.dbeSIMBOLKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  If Not CharInSet(Key, ['A'..'Z', 'a'..'z', '_', '-', #8]) Then
    Key := #0;
end;

procedure TfrmCadTemplates.dbeTipSQLClick(Sender: TObject);
begin
  inherited;

  pTipSQLSet;

  If (Not dbeSIMBOL.Enabled) And (qryTabela.State In dsEditModes) Then
    dbeSIMBOL.Clear;

end;

procedure TfrmCadTemplates.pTipSQLSet;
begin
  dbeSIMBOL.Enabled := dbeTipSQL.ItemIndex <> 1;
  lblSIMBOL.Enabled := dbeTipSQL.ItemIndex <> 1;
End;

procedure TfrmCadTemplates.btnIncluirClick(Sender: TObject);
begin
  inherited;

  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodigo, dbeDesGru, False)
  Else
    pHabilitaCodigo(dbeCodigo, dbeCodigo, True);

  pTipSQLSet;

  pCarregaDados;
  pHabilitaTela(True);

end;

procedure TfrmCadTemplates.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrRelatorios: TConsultasArray;
begin
  inherited;

  chrKey := '/';

  If fPesqTemplateSQL(Self, Nil, Nil, qryTabela, chrKey, arrRelatorios) Then
  Begin
    pCarregaDados;
    pSetFocus(btnAlterar);
  End;

end;

procedure TfrmCadTemplates.btnUtiRelClick(Sender: TObject);
var
  strSIMBOL: String;
begin

  inherited;

  strSIMBOL := 'TP_' + dbeSIMBOL.Text;

  If Not(fEmptyStr(dbeSIMBOL.Text)) Then
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
     fMensagem('ATENÇÃO!', 'Carregue um Template para visualizar os Relatórios, Templates e/ou as Instruções em que este é utilizado!', ['&Ok']);
     pSetFocus(btnPesquisa);
  End;

end;

procedure TfrmCadTemplates.FormCreate(Sender: TObject);
begin
  inherited;

  strNomeTabela         := 'CADTEM';
  strNomeCampo          := 'TEM_CODIGO';

  qryTabela             := fCriaQuery(Self);
  dtsCadTem.DataSet     := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0]     := dbeCodigo;

  TInterfaceRelatorio.pAjustaEditorSQL(bceInsSQL);
end;

procedure TfrmCadTemplates.FormShow(Sender: TObject);
begin
  inherited;

  If Not fEmptyStr(strCodigo) Then
  Begin
    qryTabela.SQL.Text := 'SELECT * FROM CADTEM WHERE TEM_CODIGO = ' + QuotedStr(strCodigo);
    qryTabela.Open;

    pCarregaDados;

    pSetFocus(btnAlterar);
  End Else
  Begin

    If btnIncluir.Enabled Then
      pSetFocus(btnIncluir);

  End;

end;

procedure TfrmCadTemplates.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;
end;

function TfrmCadTemplates.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender)) Then
  Begin

    If (Sender = dbeCodigo) Then
    Begin
      If (fEmptyStr(dbeCodigo.Text)) And (dbeCodigo.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (blnBuscaPorChave) Then
      Begin
        If Not fBuscaPorCamposChave Then
          pLimparCampos;
      End;
    End

    Else If (Sender = dbeDesGru) Then
    Begin

    End

    Else If (Sender = dbeDescri) Then
    Begin
      If fEmptyStr(dbeDescri.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Descrição deve ser preenchida!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = dbeTipSQL)  Then
    Begin

      If fEmptyStr(dbeTipSQL.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Tipo deve ser preenchido!', ['&Ok']);
        Result := False;
      End

      Else If TInterfaceRelatorio.fExisteSimboloTemplate(dbeCodigo.Text, dbeSimbol.Text) Then
      Begin

        fMensagem('ATENÇÃO!', 'Já foi cadastrado um símbolo com esse nome!', ['&Ok']);
        Result := False;

      End;

    End

    Else If (Sender = dbeSIMBOL)  Then
    Begin

      If dbeSIMBOL.Enabled Then
      Begin

        If fEmptyStr(dbeSIMBOL.Text) Then
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
