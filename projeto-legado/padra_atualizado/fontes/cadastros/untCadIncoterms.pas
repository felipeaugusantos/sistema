unit untCadIncoterms;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, Vcl.Buttons,
  Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, Data.DB, Vcl.Mask,
  Vcl.DBCtrls, DBEditFocus, EditFocus, Uni;

type
  TfrmCadIncoterms = class(TfrmPaiCad)
    Label1: TLabel;
    dbeCodTerm: TDBEditFocus;
    Label2: TLabel;
    dbeSigla: TDBEditFocus;
    Label3: TLabel;
    dbeDescri: TDBEditFocus;
    dtsTabela: TDataSource;
    rdgTipo: TDBRadioGroup;
    rdgInvoice: TGroupBox;
    chkTarifa: TDBCheckBox;
    chkSeguro: TDBCheckBox;
    chkFrete: TDBCheckBox;
    rdgLeiaute: TGroupBox;
    Label4: TLabel;
    dbeCodLay: TDBEditFocus;
    edtNomLay: TEditFocus;
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dbeCodLayKeyPress(Sender: TObject; var Key: Char);
    procedure dtsTabelaDataChange(Sender: TObject; Field: TField);
    procedure btnGravarClick(Sender: TObject);
    procedure rdgTipoClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    qryCadIncoterms: TUniQuery;
    procedure pAfterOpen(DataSet: TDataSet);
    procedure pRefresh;
    procedure pAjustaCheckBox;
    { Private declarations }
  Protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender : TWinControl; blnBuscaPorChave : Boolean):Boolean; Override;
  public
    { Public declarations }
  end;

implementation

uses untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmCadIncoterms.pAfterOpen(DataSet: TDataSet);
begin
  pRefresh;
end;

procedure TfrmCadIncoterms.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('AUTOINCREM');
  stlCampos.Add('ICT_CODICT');
  stlCampos.Add('ICT_DESCRI');
  stlCampos.Add('ICT_SIGLA_');
  stlCampos.Add('ICT_TPTERM');
  stlCampos.Add('ICT_TARIFA');
  stlCampos.Add('ICT_SEGURO');
  stlCampos.Add('ICT_FRETE_');
  stlCampos.Add('ICT_LAYETI');

  stlCamInd.Add('ICT_CODICT');
  stlCamInd.Add('ICT_DESCRI');
  stlCamInd.Add('ICT_SIGLA_');
  stlCamInd.Add('ICT_TPTERM');
  stlCamInd.Add('ICT_TARIFA');
  stlCamInd.Add('ICT_SEGURO');
  stlCamInd.Add('ICT_FRETE_');
  stlCamInd.Add('ICT_LAYETI');

  stlDesInd.Add('Código');
  stlDesInd.Add('Descrição');
  stlDesInd.Add('Sigla');
  stlDesInd.Add('Tipo');
  stlDesInd.Add('Tarifa');
  stlDesInd.Add('Seguro');
  stlDesInd.Add('Frete');
  stlDesInd.Add('Leiaute');
end;

procedure TfrmCadIncoterms.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodTerm, dbeSigla, False);
  pAjustaCheckBox;
end;

procedure TfrmCadIncoterms.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pRefresh;
end;

procedure TfrmCadIncoterms.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  inherited;
  pRefresh;
end;

procedure TfrmCadIncoterms.btnGravarClick(Sender: TObject);
begin
  if not fVerificaCampos then
  begin
    Exit;
  end;

  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadIncoterms.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadIncoterms.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodTerm, dbeSigla, False);
  dbeCodLay.Clear;
  edtNomLay.Clear;

  qryTabela.FieldByName('ICT_TPTERM').AsString := 'M';
  qryTabela.FieldByName('ICT_TARIFA').AsString := 'N';
  qryTabela.FieldByName('ICT_SEGURO').AsString := 'N';
  qryTabela.FieldByName('ICT_FRETE_').AsString := 'N';
end;

procedure TfrmCadIncoterms.btnPesquisaClick(Sender: TObject);
Var
  arrSel: TConsultasArray;
  Key   : Char;
begin
  Key := '/';
  If fPesqIncoterms(Self, dbeCodTerm, nil, qryTabela, Key, arrSel) then
  Begin
    fValidaCampos(dbeCodLay,  False);
    pSetFocus(btnAlterar);
  End;
end;

procedure TfrmCadIncoterms.dbeCodLayKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;
  fPesqLayout(Self, dbeCodLay, edtNomLay, nil, 'J', Key, arrSel);
end;

procedure TfrmCadIncoterms.dtsTabelaDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  pAjustaCheckBox;
end;

procedure TfrmCadIncoterms.FormCreate(Sender: TObject);
var
  intIndex: Integer;
begin
  inherited;
  strNomeTabela     := 'CADICT';
  strNomeCampo      := 'ICT_CODICT';

  qryCadIncoterms   := fCriaQuery(Self);
  qryTabela         := qryCadIncoterms;
  dtsTabela.DataSet := qryTabela;

  qryTabela.AfterOpen := pAfterOpen;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodTerm;

  For intIndex := 0 To Self.ControlCount -1 Do
  Begin
    if (Self.Controls[intIndex] is TDBEditFocus) Then
      TDBEditFocus(Self.Controls[intIndex]).DataSource := dtsTabela;
  End;
end;

procedure TfrmCadIncoterms.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If Key = VK_RETURN then
  Begin
    If (ActiveControl Is TDBRadioGroup) Then
      keybd_event(Vk_Tab,0, 0, 0);

    If ActiveControl.ClassNameIs('TGroupButton') Then
      keybd_event(Vk_Tab,0, 0, 0);
  End;
end;

procedure TfrmCadIncoterms.pRefresh;
begin
  edtNomLay.Clear;

  if not fEmptyStr(dbeCodLay.Text) Then
  Begin
    edtNomLay.Text := fRetornaDescricaoLayoutEtq(dbeCodLay.Text);
  End;
end;

procedure TfrmCadIncoterms.pAjustaCheckBox;
begin
  If qryTabela.State in [dsEdit, dsInsert] Then
  Begin
    chkSeguro.Enabled := True;
    chkFrete.Enabled  := True;

    If rdgTipo.ItemIndex = 1 Then
    Begin
      chkSeguro.Checked := False;
      chkFrete.Checked  := False;
      chkSeguro.Enabled := False;
      chkFrete.Enabled  := False;
    End;
  End;
end;

procedure TfrmCadIncoterms.rdgTipoClick(Sender: TObject);
begin
  inherited;
  pAjustaCheckBox;
end;

function TfrmCadIncoterms.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := Inherited fValidaCampos(Sender, blnBuscaPorChave);
  If Result Then
  Begin

    If (Sender = dbeSigla) Then
    Begin
      if fEmptyStr(dbeSigla.Text) Then
      Begin
        fMensagem('', 'O campo "Sigla" deve ser preenchido!', ['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = dbeDescri) Then
    Begin
      if fEmptyStr(dbeDescri.Text) Then
      Begin
        fMensagem('', 'O campo "Descrição" deve ser preenchido!', ['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = dbeCodLay) Then
    Begin
      if fEmptyStr(dbeCodLay.Text) Then
      Begin
        fMensagem('', 'O campo "Leiaute" deve ser preenchido!', ['&OK']);
        Result := False;
      End
      Else
      Begin
        edtNomLay.Text := fRetornaDescricaoLayoutEtq(dbeCodLay.Text);

        if fEmptyStr(edtNomLay.Text) Then
        Begin
          fMensagem('', 'Leiaute não cadastrado!', ['&OK']);
          Result := False;
        End;
      End;
    End;

  End;

  If not Result Then
    pSetFocus(Sender);

end;

end.
