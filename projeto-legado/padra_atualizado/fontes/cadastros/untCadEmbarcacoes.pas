unit untCadEmbarcacoes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.Mask, Vcl.DBCtrls,
  DBEditFocus, DBComboBoxFocus, ComboBoxFocus, MaskEditFocus, EditFocus,
  DBMemoFocus, Data.DB, Uni;

type
  TfrmCadEmbarcacoes = class(TfrmPaiCad)
    lblCodEmb: TLabel;
    dbeCodEmb: TDBEditFocus;
    lblNumImo: TLabel;
    edtNumImo: TDBEditFocus;
    lblInscri: TLabel;
    dbeInscri: TDBEditFocus;
    lblNomEmb: TLabel;
    edtNomEmb: TDBEditFocus;
    lblIndEmb: TLabel;
    edtIndEmb: TDBEditFocus;
    lblPortoi: TLabel;
    edtPortoi: TDBEditFocus;
    lblLocEmb: TLabel;
    edtLocEmb: TDBEditFocus;
    lblPorte_: TLabel;
    cmbPorte_: TComboBoxFocus;
    lblCompri: TLabel;
    edtCompri: TEditFocus;
    lblArqBru: TLabel;
    edtArqBru: TEditFocus;
    mmoObserv: TDBMemoFocus;
    lblObserv: TLabel;
    dtsCadEmb: TDataSource;
    chkDraBck: TDBCheckBox;
    mmoObsDbk: TDBMemoFocus;
    Label1: TLabel;
    procedure edtCompriExit(Sender: TObject);
    procedure edtArqBruExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dtsCadEmbStateChange(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure cmbPorte_Change(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
    qryCadEmb: TUniQuery;
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples, untConsultas, untTypesSistema;

procedure TfrmCadEmbarcacoes.btnAlterarClick(Sender: TObject);
begin
  inherited;

  pHabilitaCodigo(dbeCodEmb, dbeCodEmb, False);
end;

procedure TfrmCadEmbarcacoes.btnCancelaClick(Sender: TObject);
begin
  inherited;

  If (Not fEmptyStr(qryTabela.FieldByName('EMB_PORTE_').AsString)) Then
    cmbPorte_.ItemIndex := qryTabela.FieldByName('EMB_PORTE_').AsInteger
  Else
    cmbPorte_.ItemIndex := -1;

  edtCompri.Text := qryTabela.FieldByName('EMB_COMPRI').AsString;
  edtArqBru.Text := qryTabela.FieldByName('EMB_ARQBRU').AsString;
end;

procedure TfrmCadEmbarcacoes.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadEmbarcacoes.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadEmbarcacoes.btnGravarClick(Sender: TObject);
begin
  If (Not fValidacoesBotaoGravarPai()) Then Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    qryTabela.FieldByName('EMB_PORTE_').AsInteger := cmbPorte_.ItemIndex;
    qryTabela.FieldByName('EMB_COMPRI').AsString  := edtCompri.Text;
    qryTabela.FieldByName('EMB_ARQBRU').AsString  := edtArqBru.Text;

    inherited;
    If (blnGravou) Then
      fCommit()
    Else
      fRollBack;
  Except
    On E: Exception Do Begin
      fRollBack();
      pMensagensErro(E.Message, '[TfrmCadEmbarcacoes.btnGravarClick]');
    End;
  End;
end;

procedure TfrmCadEmbarcacoes.btnIncluirClick(Sender: TObject);
begin
  inherited;

  pHabilitaCodigo(dbeCodEmb, dbeCodEmb, False);

  qryTabela.FieldByName('EMB_PORTE_').AsString := '';
  qryTabela.FieldByName('EMB_DRABCK').AsString := 'N';

  cmbPorte_.ItemIndex := -1;
  edtCompri.Text := '';
  edtArqBru.Text := '';

  pSetFocus(edtNumImo);
end;

procedure TfrmCadEmbarcacoes.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrCadEmb: TConsultasArray;
begin
  inherited;

  chrKey := '/';

  If fPesqCadastroEmbarcacoes(Self, Nil, Nil, qryTabela, chrKey, arrCadEmb) Then Begin

    If (qryTabela.Active) And (Not qryTabela.IsEmpty) Then Begin

      If (Not fEmptyStr(qryTabela.FieldByName('EMB_PORTE_').AsString)) Then
        cmbPorte_.ItemIndex := qryTabela.FieldByName('EMB_PORTE_').AsInteger
      Else
        cmbPorte_.ItemIndex := -1;

      edtCompri.Text := qryTabela.FieldByName('EMB_COMPRI').AsString;
      edtArqBru.Text := qryTabela.FieldByName('EMB_ARQBRU').AsString;
    End;

    pSetFocus(btnAlterar);
  End;
end;

procedure TfrmCadEmbarcacoes.cmbPorte_Change(Sender: TObject);
begin
  inherited;

  If (qryTabela.Active) And (Not qryTabela.IsEmpty) And
     (Not fEmptyStr(qryTabela.FieldByName('EMB_PORTE_').AsString)) Then
    qryTabela.FieldByName('EMB_PORTE_').AsInteger := cmbPorte_.ItemIndex;
end;

procedure TfrmCadEmbarcacoes.dtsCadEmbStateChange(Sender: TObject);
begin
  inherited;

  cmbPorte_.Enabled := qryTabela.State in dsEditModes;
  edtCompri.Enabled := qryTabela.State in dsEditModes;
  edtArqBru.Enabled := qryTabela.State in dsEditModes;
end;

procedure TfrmCadEmbarcacoes.edtArqBruExit(Sender: TObject);
begin
  inherited;

  If (fEmptyStr(TEditFocus(Sender).Text)) Then
    TEditFocus(Sender).Text := '0';
end;

procedure TfrmCadEmbarcacoes.edtCompriExit(Sender: TObject);
begin
  inherited;

  If (fEmptyStr(TEditFocus(Sender).Text)) Then
    TEditFocus(Sender).Text := '0,00';
end;

procedure TfrmCadEmbarcacoes.FormCreate(Sender: TObject);
  Var
    strSQL: String;
begin
  inherited;

  strNomeTabela := 'CADEMB';
  strNomeCampo  := 'EMB_CODEMB';

  strSQL        := 'SELECT * FROM CADEMB';
  qryCadEmb     := fCriarQuery(strSQL, Self);
  qryTabela     := qryCadEmb;
  dtsCadEmb.DataSet := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodEmb;
end;

procedure TfrmCadEmbarcacoes.FormShow(Sender: TObject);
begin
  inherited;

  pSetFocus(btnIncluir);
end;

function TfrmCadEmbarcacoes.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := Inherited fValidaCampos(Sender, blnBuscaPorChave);

  If Result Then Begin

    If (Sender = edtNomEmb) Then Begin
      If (fEmptyStr(edtNomEmb.Text)) Then Begin
        fMensagem('ATENÇÃO!', 'O campo Nome da Embarcação deve ser informado!', ['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtIndEmb) Then Begin
      If (fEmptyStr(edtIndEmb.Text)) Then Begin
        fMensagem('ATENÇÃO!', 'O campo Indicativo do Navio deve ser informado!', ['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = cmbPorte_) Then Begin
      If (cmbPorte_.ItemIndex = -1) Then Begin
        fMensagem('ATENÇÃO!', 'O campo Porte do Navio deve ser informado!', ['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = chkDraBck) Or (Sender = mmoObsDbk) Then Begin
      If (chkDraBck.Checked) And (fEmptyStr(mmoObsDbk.Lines.Text)) Then Begin
        fMensagem('ATENÇÃO!', 'O campo Observações Drawback deve ser informado!', ['&OK']);
        Result := False;
      End Else If (Not chkDraBck.Checked) And (Not fEmptyStr(mmoObsDbk.Lines.Text)) Then Begin
        fMensagem('ATENÇÃO!', 'O campo Incide Operação Drawback deve ser selecionado!', ['&OK']);
        Result := False;
      End;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadEmbarcacoes.pInicializaIndices;
begin
  inherited;

  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('EMB_CODEMB');
  stlCampos.Add('EMB_NUMIMO');
  stlCampos.Add('EMB_INSCRI');
  stlCampos.Add('EMB_NOMEMB');
  stlCampos.Add('EMB_INDEMB');
  stlCampos.Add('EMB_PORTOI');
  stlCampos.Add('EMB_LOCEMB');
  stlCampos.Add('EMB_PORTE_');
  stlCampos.Add('EMB_COMPRI');
  stlCampos.Add('EMB_ARQBRU');
  stlCampos.Add('EMB_OBSERV');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('EMB_NOMEMB');
  stlCamInd.Add('EMB_CODEMB');

  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código');
end;

end.
