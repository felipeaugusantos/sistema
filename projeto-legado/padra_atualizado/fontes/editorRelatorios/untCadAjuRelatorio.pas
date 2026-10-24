unit untCadAjuRelatorio;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.Mask, Vcl.DBCtrls,
  DBEditFocus, DBComboBoxFocus, ComboBoxFocus, Data.DB, Uni;

type
  TfrmCadAjuRelatorio = class(TfrmPaiCad)
    pnlDados: TPanel;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    dbeCodigo: TDBEditFocus;
    dbeDescri: TDBEditFocus;
    Aba: TLabel;
    dbeNumAba: TDBEditFocus;
    Label4: TLabel;
    dbeDesAba: TDBEditFocus;
    dbeTipAju: TDBComboBoxFocus;
    dtsAjuRel: TDataSource;
    dtsUtiRel: TDataSource;
    dtsUtiTem: TDataSource;
    dtsUtiIns: TDataSource;
    Label5: TLabel;
    Label3: TLabel;
    dbeTxtAju: TMemo;
    dbePreAba: TDBCheckBox;
    procedure btnAlterarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
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
  untFuncoes;

procedure TfrmCadAjuRelatorio.btnAlterarClick(Sender: TObject);
begin
  inherited;

  pHabilitaCodigo(dbeCodigo, dbeDescri, False);

  pCarregaDados;
  pHabilitaTela(True);

end;

procedure TfrmCadAjuRelatorio.btnCancelaClick(Sender: TObject);
begin
  inherited;

  pCarregaDados;
  pHabilitaTela(False);
end;

procedure TfrmCadAjuRelatorio.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadAjuRelatorio.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

  pCarregaDados;

end;

procedure TfrmCadAjuRelatorio.pHabilitaTela(blnHabilita: Boolean);
Begin
  dbeTxtAju.Enabled := blnHabilita;
End;

procedure TfrmCadAjuRelatorio.pCarregaDados;
Begin
  dbeTxtAju.Text := AnsiReplaceStr(qryTabela.FieldByName('REL_TXTAJU').AsString, '<<csq>>', #13#10);
End;

procedure TfrmCadAjuRelatorio.pEditorToTabela;
Begin
  If qryTabela.State In dsEditModes Then
  Begin
    qryTabela.FieldByName('REL_TXTAJU').AsString := AnsiReplaceStr(dbeTxtAju.Text, #13#10, '<<csq>>');
  End;
End;

procedure TfrmCadAjuRelatorio.btnGravarClick(Sender: TObject);
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
      pMensagensErro(E.Message, '[TfrmCadAjuRelatorio.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;

  pHabilitaTela(False);

end;

procedure TfrmCadAjuRelatorio.btnIncluirClick(Sender: TObject);
begin
  inherited;

  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodigo, dbeDescri, False)
  Else
    pHabilitaCodigo(dbeCodigo, dbeCodigo, True);

  pCarregaDados;
  pHabilitaTela(True);

end;

procedure TfrmCadAjuRelatorio.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrRelatorios: TConsultasArray;
begin
  inherited;

  chrKey := '/';

  If fPesqAjudaRelatorio(Self, Nil, Nil, qryTabela, chrKey, arrRelatorios) Then
  Begin
    pCarregaDados;
    pSetFocus(btnAlterar);
  End;

end;

procedure TfrmCadAjuRelatorio.FormCreate(Sender: TObject);
begin
  inherited;

  strNomeTabela         := 'AJUREL';
  strNomeCampo          := 'REL_CODAJU';

  qryTabela             := fCriaQuery(Self);
  dtsAjuRel.DataSet     := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0]     := dbeCodigo;

  pHabilitaTela(False);
end;

procedure TfrmCadAjuRelatorio.FormShow(Sender: TObject);
begin
  inherited;

  If Not fEmptyStr(strCodigo) Then
  Begin
    qryTabela.SQL.Text := 'SELECT * FROM AJUREL WHERE REL_CODAJU = ' + QuotedStr(strCodigo);
    qryTabela.Open;

    pCarregaDados;

    pSetFocus(btnAlterar);
  End Else
  Begin

    If btnIncluir.Enabled Then
      pSetFocus(btnIncluir);

  End;

end;

procedure TfrmCadAjuRelatorio.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('REL_CODAJU');
  stlCampos.Add('REL_DESCRI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('REL_DESCRI');
  stlCamInd.Add('REL_CODAJU');

  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código');
end;

function TfrmCadAjuRelatorio.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
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

    Else If (Sender = dbeDescri) Then
    Begin
      If fEmptyStr(dbeDescri.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Descrição deve ser preenchida!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = dbeTipAju)  Then
    Begin
      If fEmptyStr(dbeTipAju.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Tipo deve ser preenchido!', ['&Ok']);
        Result := False;
      End
    End

    Else If (Sender = dbeNumAba)  Then
    Begin
      If fEmptyStr(dbeNumAba.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Número da Aba deve ser preenchido!', ['&Ok']);
        Result := False;
      End
    End

    Else If (Sender = dbeDesAba)  Then
    Begin
      If fEmptyStr(dbeDesAba.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Nome da Aba deve ser preenchido!', ['&Ok']);
        Result := False;
      End
    End

    Else If (Sender = dbeTxtAju)  Then
    Begin
      If fEmptyStr(dbeTxtAju.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Conteúdo deve ser preenchido!', ['&Ok']);
        Result := False;
      End
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

end.
