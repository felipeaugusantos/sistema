{*****************************}
{* qryConCid -> CADCID       *}
{**************************JB*}
{*****************************}
{* qryCadEmi -> CADEMI       *}
{* qryCadCid -> CADCID       *}
{**************************RV*}
unit untCadEmiCheques;

interface

uses
  Windows, Classes, Controls, Forms, untPaiCad, Menus, ComCtrls, StdCtrls, Buttons,
  ExtCtrls, Uni, EditFocus, Mask, DBCtrls, DBEditFocus, DB, AppEvnts, untFuncoesGenerica,
  untLabelRg, untLabelCgcCpf, untDBETipoCgcCpf, untDBECgcCpf, BitBtnLockedIncrem,
  frxClass, frxExportCSVTestabilidade;

type
  TfrmCadEmiCheques = class(TfrmPaiCad)
    pnlCentral: TPanel;
    dbeTelEmi: TDBEditFocus;
    Label8: TLabel;
    dbeEndere: TDBEditFocus;
    dbeNomEmi: TDBEditFocus;
    Label6: TLabel;
    Label7: TLabel;
    Label1: TLabel;
    dbeBairro: TDBEditFocus;
    Label2: TLabel;
    dbeCodCid: TDBEditFocus;
    edtNomCid: TEditFocus;
    Label10: TLabel;
    dbeNumIes: TDBEditFocus;
    dbeNumR_G: TDBEditFocus;
    Label4: TLabel;
    dbeNumCep: TDBEditFocus;
    dbeBloque: TDBCheckBox;
    dtsCadEmi: TDataSource;
    LabelCgcCpf1: TLabelCgcCpf;
    LabelRg1: TLabelRg;
    Panel1: TPanel;
    dbeCgcCpf: TDBEditTipoCgcCpf;
    dbeNumCgc: TDBEditCgcCpf;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure dbeCodCidKeyPress(Sender: TObject; var Key: Char);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure dbeCgcCpfExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnGravarClick(Sender: TObject);
  private
    qryConCid: TUniQuery;
    qryCadEmi: TUniQuery;
    qryCadCid: TUniQuery;

    FPais: TPais;

    { Private declarations }
    procedure pCarregaCidade;
    procedure pAfterScroll(DataSet: TDataSet);
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;


implementation

uses SysUtils, StrUtils, untPai, untFuncoesSimples, untPesqAux, untConsultas,
  untTypesSistema;

{$R *.dfm}

procedure TfrmCadEmiCheques.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If (Action <> caNone) Then
  Begin
    FreeAndNil(qryCadCid);
  End;
end;

procedure TfrmCadEmiCheques.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela         := 'CADEMI';
  strNomeCampo          := 'EMI_C_G_C_';

  qryCadEmi             := fCriaQuery(Self);
  qryTabela             := qryCadEmi;
  dtsCadEmi.DataSet     := qryTabela;

  qryTabela.AfterScroll := pAfterScroll;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0]     := dbeNumCgc;

  qryCadCid             := fCriaQuery(Self);
  qryConCid             := qryCadCid;

  dbeNumCgc.Tag := 99;

  FPais := fSetaPais;
end;

procedure TfrmCadEmiCheques.pAfterScroll(DataSet: TDataSet);
Begin
  If (dbeCgcCpf.Text = '1') Then
    qryTabela.FieldByName('EMI_C_G_C_').EditMask := fRetMascaraC_G_C_(FPais, C_G_C_);

  If (dbeCgcCpf.Text = '2') Then
    qryTabela.FieldByName('EMI_C_G_C_').EditMask := fRetMascaraC_G_C_(FPais, C_P_F_);
End;

function TfrmCadEmiCheques.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (Sender = dbeCgcCpf) Then
  Begin
    If (fEmptyStr(dbeCgcCpf.Text)) Or (dbeCgcCpf.Text = '0') Then
    Begin
      fMensagem('ATENÇÃO!', 'O CNPJ / CPF deve ser preenchido!', ['&O k']);
      Result := False;
    End
    Else If (dbeCgcCpf.Text <> '1') And (dbeCgcCpf.Text <> '2') Then
    Begin
      Result := False;
    End;
  End

  Else If (Sender = dbeNumCgc) Then
  Begin
    If fEmptyStr(dbeNumCgc.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'O ' + IIF(FPais = opcParaguai, 'RUC', 'CNPJ / CPF') + ' deve ser preenchido!', ['&O k']);
      Result := False;
    End
    Else If (FPais = opcBrasil) Then
    Begin
      Result := fValidaCnpjCpf(dbeCgcCpf.Text, dbeNumCgc.Text);

      If (Result) And (blnBuscaPorChave) Then
      Begin
        fBuscaPorCamposChave;
      End;
    End;
  End

  Else If (Sender = dbeNomEmi) Then
  Begin
    If fEmptyStr(dbeNomEmi.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Emitente deve ser preenchido!', ['&O k']);
      Result := False;
    End
  End

  Else If (Sender = dbeEndere) Then
  Begin

  End

  Else If (Sender = dbeBairro) Then
  Begin

  End

  Else If (Sender = dbeCodCid) Then
  Begin
    If fEmptyStr(dbeCodCid.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Código da Cidade deve ser preenchido!', ['&O k']);
      Result := False;
    End
    Else
    Begin
      pCarregaCidade;
      If qryConCid.FieldByName('CID_CODCID').IsNull Then
      Begin
        fMensagem('ATENÇÃO!', 'Essa cidade não está cadastrada!', ['&O k']);
        Result := False;
      End;
    End;
  End

  Else If (Sender = dbeNumCep) Then
  Begin

    If (Not fEmptyStr(fTiraCaracEspeciais(dbeNumCep.Text))) Then
    Begin
      If Length(Trim(fTiraCaracEspeciais(dbeNumCep.Text))) < 8 Then
      Begin
        fMensagem('ATENÇÃO!', 'O Cep deve ser vazio ou com 8 digitos.', ['&Ok']);
        Result := False;
      End;
    End;

  End

  Else If (Sender = dbeTelEmi) Then
  Begin

  End

  Else If (Sender = dbeNumR_G) Then
  Begin

  End

  Else If (Sender = dbeNumIes) Then
  Begin
    If (Not fEmptyStr(dbeNumIes.Text))                                             And
       (Not fEmptyStr(qryConCid.FieldByName('CID_ESTADO').AsString)) Then
    Begin
      dbeNumIes.Text := AnsiReplaceStr(dbeNumIes.Text, ',', '.');
      If Not fValidaIES(dbeNumIes.Text, qryConCid.FieldByName('CID_ESTADO').AsString) Then
      Begin
        fMensagem('ATENÇÃO!', dbeNumIes.Text + ' não é uma Inscrição Estadual válida!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        If qryConCid.FieldByName('CID_ESTADO').AsString = 'RS' Then
        Begin
          dbeNumIes.Text := fRetornaZerosNumIes(dbeNumIes.Text) + dbeNumIes.Text;
        End;
      End;
    End
    Else
    Begin
      dbeNumIes.Clear;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadEmiCheques.pCarregaCidade;
begin
  pPesquisaCadCid(qryConCid, qryCadCid, dbeCodCid.Text);
  With qryConCid Do
  Begin
    edtNomCid.Text := FieldByName('CID_NOMCID').AsString;
    If (fEmptyStr(fTiraCaracEspeciais(dbeNumCep.Text))) And
       (qryTabela.State In [dsInsert, dsEdit])          Then
    Begin
      dbeNumCep.Field.AsString := FieldByName('CID_C_E_P_').AsString;
    End;
  End;
end;

procedure TfrmCadEmiCheques.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('EMI_C_G_C_');
  stlCampos.Add('EMI_NOMEMI');
  stlCampos.Add('EMI_ENDERE');
  stlCampos.Add('EMI_TELE01');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('EMI_C_G_C_');
  stlCamInd.Add('EMI_NOMEMI');
  stlDesInd.Add('CNPJ-CPF');
  stlDesInd.Add('Nome');
end;

procedure TfrmCadEmiCheques.btnIncluirClick(Sender: TObject);
begin
  inherited;
  If (dbeCgcCpf.CanFocus) Then
    pSetFocus(dbeCgcCpf)
  Else
    pSetFocus(dbeNumCgc);

  edtNomCid.Clear;

  qryTabela.FieldByName('EMI_BLOQUE').AsString := 'N';
end;

procedure TfrmCadEmiCheques.btnAlterarClick(Sender: TObject);
begin
  inherited;
  If (dbeNomEmi.Enabled) Then
  Begin
    pSetFocus(dbeNomEmi);
    dbeCgcCpf.Enabled := False;
    dbeNumCgc.Enabled := False;
  End;
end;

procedure TfrmCadEmiCheques.dbeCodCidKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrCidade: TConsultasArray;
begin
  inherited;
  {****************************}
  {* NOVA CONSULTA DE CIDADES *}
  {*************************RV*}
  If fPesqCidade(Self, dbeCodCid, edtNomCid, Nil, Nil, Key, arrCidade) Then
  Begin
    If fValidaCampos(dbeCodCid, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadEmiCheques.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadEmiCheques.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

  edtNomCid.Clear;
end;

procedure TfrmCadEmiCheques.btnGravarClick(Sender: TObject);
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadEmiCheques.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadEmiCheques.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pCarregaCidade;
end;

procedure TfrmCadEmiCheques.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrEmi: TConsultasArray;
begin
  {****************************************}
  {* NOVA CONSULTA DE EMITENTE DE CHEQUES *}
  {*************************************RV*}
  chrKey := '/';
  If fPesqEmitCheques(Self, Nil, Nil, qryTabela, chrKey, arrEmi) Then
  Begin
    pCarregaCidade;
    pSetFocus(btnAlterar);
  End;
end;

procedure TfrmCadEmiCheques.dbeCgcCpfExit(Sender: TObject);
begin
  inherited;
  If (dbeCgcCpf.Text = '1') Then
    qryTabela.FieldByName('EMI_C_G_C_').EditMask := fRetMascaraC_G_C_(FPais, C_G_C_)
  Else
    qryTabela.FieldByName('EMI_C_G_C_').EditMask := fRetMascaraC_G_C_(FPais, C_P_F_);
end;

end.

