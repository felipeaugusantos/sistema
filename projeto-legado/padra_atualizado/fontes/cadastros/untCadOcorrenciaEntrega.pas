unit untCadOcorrenciaEntrega;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, Vcl.Buttons,
  Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.Mask,
  DBEditFocus, Data.DB, ComboBoxFocus;

type
  TfrmCadOcorrenciaEntrega = class(TfrmPaiCad)
    dbeCodigo: TDBEditFocus;
    dbeDescri: TDBEditFocus;
    dtsTabela: TDataSource;
    cmbTipOcr: TComboBoxFocus;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    rdgOcoRom: TRadioGroup;
    dbeNivPri: TDBEditFocus;
    Label4: TLabel;
    chkNotCli: TDBCheckBox;
    pnlNotCli: TPanel;
    lblMsgCli: TLabel;
    mmoMsgCli: TDBMemo;
    procedure FormCreate(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure rdgOcoRomClick(Sender: TObject);

    procedure pControlaCampos;
    procedure cmbTipOcrClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure chkNotCliClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure pAjustaMsgCli;
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean; Override;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses
  untFuncoesSimples, untTypesSistema, untConsultas;

{ TfrmCadOcorrenciaEntrega }

procedure TfrmCadOcorrenciaEntrega.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodigo, dbeDescri, False);
end;

procedure TfrmCadOcorrenciaEntrega.btnCancelaClick(Sender: TObject);
begin
  inherited;
  if not fEmptyStr(qryTabela.FieldByName('AUTOINCREM').AsString) then
  begin
    cmbTipOcr.ItemIndex := IIF(qryTabela.FieldByName('OCR_TIPOCR').AsString = 'N', 0, 1);
    rdgOcoRom.ItemIndex := IIF(qryTabela.FieldByName('OCR_OCOROM').AsString = 'N', 0, 1);
    pControlaCampos;
  end;
end;

procedure TfrmCadOcorrenciaEntrega.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  inherited;

  if blnExcluiu then
    fCommit
  else
    fRollback;

  pLimparCampos;
  qryTabela.Close;
end;

procedure TfrmCadOcorrenciaEntrega.btnGravarClick(Sender: TObject);
begin
  blnGravou := False;

  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pnlInfo.Caption := '';
      pMensagensErro(E.Message, '[untCadOcorrenciaEntrega.btnGravarClick]');
    End;
  End;

  try
    if (blnGravou) then
    begin
      qryTabela.Edit;

      if cmbTipOcr.Visible then
        qryTabela.FieldByName('OCR_TIPOCR').AsString := IIF(cmbTipOcr.ItemIndex = 0, 'N', 'S')
      else
        qryTabela.FieldByName('OCR_TIPOCR').AsString := '';

      qryTabela.FieldByName('OCR_OCOROM').AsString := IIF(rdgOcoRom.ItemIndex = 0, 'N', 'S');

      qryTabela.Post;
    end;

    if blnGravou then
      fCommit
    else
      fRollBack;

  except
    on E: Exception do
    begin
      fRollBack;
      pMensagensErro(E.Message, '');
    end;
  end;

end;

procedure TfrmCadOcorrenciaEntrega.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pLimparCampos;

  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodigo, dbeDescri, False)
  Else
    pHabilitaCodigo(dbeCodigo, dbeCodigo, True);

  if dbeNivPri.Visible then
    dbeNivPri.Field.Value := 0;

  chkNotCli.Checked := False;
  pAjustaMsgCli;

  if rdgOcoRom.ItemIndex = 0 then
    pSetFocus(TRadioButton(rdgOcoRom.Controls[0]))
  else
    pSetFocus(TRadioButton(rdgOcoRom.Controls[1]));
end;

procedure TfrmCadOcorrenciaEntrega.btnPesquisaClick(Sender: TObject);
var
  chrKey: Char;
  arrOcr: TConsultasArray;
begin
  chrKey := '/';
  If fPesqOcoRom(Self, Nil, Nil, qryTabela, chrKey, arrOcr) Then
  Begin
    cmbTipOcr.ItemIndex := IIF(qryTabela.FieldByName('OCR_TIPOCR').AsString = 'N', 0, 1);
    rdgOcoRom.ItemIndex := IIF(qryTabela.FieldByName('OCR_OCOROM').AsString = 'N', 0, 1);
    pControlaCampos;
    pSetFocus(btnAlterar);
  End;
end;

procedure TfrmCadOcorrenciaEntrega.chkNotCliClick(Sender: TObject);
begin
  inherited;
  pAjustaMsgCli;
end;

procedure TfrmCadOcorrenciaEntrega.pAjustaMsgCli;
begin
  if chkNotCli.Checked then
  begin
    Self.Height := 319;
    pnlNotCli.Visible := True;
  end
  else
  begin
    mmoMsgCli.Clear;
    pnlNotCli.Visible := False;
    Self.Height := 200;
  end;
end;

procedure TfrmCadOcorrenciaEntrega.cmbTipOcrClick(Sender: TObject);
begin
  inherited;
  pControlaCampos;
end;

procedure TfrmCadOcorrenciaEntrega.pControlaCampos;
begin
  cmbTipOcr.Visible := (rdgOcoRom.ItemIndex = 0);
  Label3.Visible := (rdgOcoRom.ItemIndex = 0);

  dbeNivPri.Visible := (((cmbTipOcr.ItemIndex = 0) and (cmbTipOcr.Visible)) or (rdgOcoRom.ItemIndex = 1));
  Label4.Visible := (((cmbTipOcr.ItemIndex = 0) and (cmbTipOcr.Visible)) or (rdgOcoRom.ItemIndex = 1));
end;

procedure TfrmCadOcorrenciaEntrega.FormCreate(Sender: TObject);
begin

  qryTabela := fCriaQuery(Self);
  dtsTabela.DataSet := qryTabela;

  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  inherited;

  strNomeTabela := 'OCOROM';
  strNomeCampo  := 'OCR_CODIGO';
end;

procedure TfrmCadOcorrenciaEntrega.FormDestroy(Sender: TObject);
begin
  FreeAndNil(stlCampos);
  FreeAndNil(stlCamInd);
  FreeAndNil(stlDesInd);

  FreeAndNil(dtsTabela);
  FreeAndNil(qryTabela);

  inherited;
end;

procedure TfrmCadOcorrenciaEntrega.FormShow(Sender: TObject);
begin
  inherited;
  chkNotCli.Checked := False;
  pAjustaMsgCli;
end;

function TfrmCadOcorrenciaEntrega.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := Inherited fValidaCampos(Sender, blnBuscaPorChave);
  If Result Then
  Begin
    If Sender = dbeCodigo Then
    Begin
      If Not blnUsaProCodigo Then
      Begin
        If fEmptyStr(dbeCodigo.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Informe o Código da Ocorrência.', ['&Ok']);
          Result := False;
        End
        Else If (fEmptyStr(qryTabela.FieldByName('AUTOINCREM').AsString)) And
                (Not fCodigoOcoRomDisponivel(dbeCodigo.Text, 'N')) Then
        Begin
          fMensagem('ATENÇÃO!', 'Este código de ocorrência já está sendo utilizado em outro cadastro.', ['&Ok']);
          Result := False;
        End
        Else If Length(dbeCodigo.Text) < 5 Then
        Begin
          fMensagem('ATENÇÃO!', 'Quantidade de caracteres inválida no campo Código.', ['&Ok']);
          Result := False;
        End;

      End;

    End

    Else
    If Sender = dbeNivPri Then
    Begin
      If ((cmbTipOcr.ItemIndex = 0) and (cmbTipOcr.Visible)) Or (rdgOcoRom.ItemIndex = 1) then
      Begin
        If fEmptyStr(dbeNivPri.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Informe o Nível de Prioridade.', ['&Ok']);
          Result := False;
        End
        Else
        if (StrToInt(dbeNivPri.Text) < 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'O nível de prioridade deve ser maior ou igual a zero.', ['&Ok']);
          Result := False;
        End;
      End
      Else
        dbeNivPri.Field.Value := Null;
    End

    Else
    If (Sender = mmoMsgCli) And (chkNotCli.Checked) Then
    Begin
      If fEmptyStr(mmoMsgCli.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Preencha a mensagem que será enviada ao cliente!', ['&Ok']);
        Result := False;
      End;
    End;

  End;

  If not Result Then
    pSetFocus(Sender);

end;

procedure TfrmCadOcorrenciaEntrega.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('OCR_CODIGO');
  stlCampos.Add('OCR_DESCRI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('OCR_DESCRI');
  stlCamInd.Add('OCR_CODIGO');

  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código');
end;

procedure TfrmCadOcorrenciaEntrega.rdgOcoRomClick(Sender: TObject);
begin
  inherited;
  pControlaCampos;
end;

end.
