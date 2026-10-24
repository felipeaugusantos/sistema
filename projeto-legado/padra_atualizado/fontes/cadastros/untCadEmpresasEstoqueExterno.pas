unit untCadEmpresasEstoqueExterno;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.Mask, Vcl.DBCtrls,
  DBEditFocus, Data.DB, untDBECgcCpf, untDBETipoCgcCpf, untLabelCgcCpf, untFuncoesGenerica,
  EditFocus, QColorLabel;

type
  TfrmCadEmpresasEstoqueExterno = class(TfrmPaiCad)
    pnlFundo: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    dbeDesEst: TDBEditFocus;
    dbeCodEst: TDBEditFocus;
    dtsTabela: TDataSource;
    LabelCgcCpf1: TLabelCgcCpf;
    Panel1: TPanel;
    dbeCgcCpf: TDBEditTipoCgcCpf;
    dbeNumCgc: TDBEditCgcCpf;
    Label3: TLabel;
    lblCfop: TColorLabel;
    edtNomCli: TEditFocus;
    dbeCodCli: TDBEditFocus;
    chkPerFat: TDBCheckBox;
    chkZerImp: TDBCheckBox;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure dbeCgcCpfExit(Sender: TObject);
    procedure dbeCodCliChange(Sender: TObject);
    procedure dbeCodCliKeyPress(Sender: TObject; var Key: Char);
    function dbeCodCliChamaCadastro(Key: Word): string;
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
  private
    { Private declarations }
    procedure pAfterScroll(DataSet: TDataSet);
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
  end;

var
  frmCadEmpresasEstoqueExterno: TfrmCadEmpresasEstoqueExterno;

implementation

{$R *.dfm}

uses
  untFuncoesSimples, untConsultas, untTypesSistema, untFuncIns;

{ TfrmCadEmpresaEstoqueExterno }

procedure TfrmCadEmpresasEstoqueExterno.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodEst, dbeDesEst, False);
  dbeCodCliChange(nil);
end;

procedure TfrmCadEmpresasEstoqueExterno.btnCancelaClick(Sender: TObject);
begin
  inherited;
  dbeCodCliChange(nil);
end;

procedure TfrmCadEmpresasEstoqueExterno.btnExcluirClick(Sender: TObject);
begin
  inherited;  
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;
  dbeCodCliChange(nil);

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadEmpresasEstoqueExterno.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadEmpresasEstoqueExterno.btnGravarClick(Sender: TObject);
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;
  dbeCodCliChange(nil);

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadEmpresasEstoqueExterno.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadEmpresasEstoqueExterno.btnIncluirClick(Sender: TObject);
begin
  inherited;
  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodEst, dbeDesEst, False)
  Else
    pHabilitaCodigo(dbeCodEst, dbeCodEst, True);
  chkPerFat.Field.AsString := 'S';
  chkZerImp.Field.AsString := 'N';
  dbeCodCliChange(nil);
end;

procedure TfrmCadEmpresasEstoqueExterno.btnPesquisaClick(Sender: TObject);
Var
  arrSel: TConsultasArray;
  Key   : Char;
begin
//  inherited;
  Key := '/';
  If fPesqEmpresaEstoqueExterno(Self, dbeCodEst, nil, qryTabela, Key, arrSel) then
  Begin
    pSetFocus(btnAlterar);
    dbeCodCliChange(nil);
  End;
end;

procedure TfrmCadEmpresasEstoqueExterno.dbeCgcCpfExit(Sender: TObject);
begin
  inherited;

  if (dbeCgcCpf.Text = '1') then
    qryTabela.FieldByName('EEE_C_G_C_').EditMask := fRetMascaraC_G_C_(fSetaPais, C_G_C_)
  else
    qryTabela.FieldByName('EEE_C_G_C_').EditMask := fRetMascaraC_G_C_(fSetaPais, C_P_F_);
end;

function TfrmCadEmpresasEstoqueExterno.dbeCodCliChamaCadastro(Key: Word): string;
begin
  inherited;
  Result := fChamaCadCli(Key);
end;

procedure TfrmCadEmpresasEstoqueExterno.dbeCodCliChange(Sender: TObject);
var
  strClaEnv: String;
begin
  inherited;
  edtNomCli.Text := fRetNomCliente(dbeCodCli.Text);
  chkPerFat.Enabled := btnGravar.Enabled And (Not fEmptyStr(edtNomCli.Text));
  chkZerImp.Enabled := btnGravar.Enabled And (Not fEmptyStr(edtNomCli.Text));

  If (qryTabela.FindField('EEE_CLAENV') <> Nil) And (Not qryTabela.FindField('EEE_CLAENV').AsString.IsEmpty) Then
    strClaEnv := qryTabela.FindField('EEE_CLAENV').AsString
  Else
    strClaEnv := '905';

  lblCfop.Caption := Format('Cliente para identificar outras saídas de envio de mercadoria para o Estoque Externo (5%s, 6%s).', [strClaEnv, strClaEnv]);
end;

procedure TfrmCadEmpresasEstoqueExterno.dbeCodCliKeyPress(Sender: TObject; var Key: Char);
  Var
    arrClientes: TConsultasArray;
begin
  inherited;
  If fPesqCliente(conCliSimples, Self, dbeCodCli, edtNomCli, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(dbeCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadEmpresasEstoqueExterno.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(btnIncluir);
end;

procedure TfrmCadEmpresasEstoqueExterno.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela     := 'CADEEE';
  strNomeCampo      := 'EEE_CODEEE';
  qryTabela         := fCriaQuery(Self);
  dtsTabela.DataSet := qryTabela;
  qryTabela.AfterScroll := pAfterScroll;

  SetLength(arrCamposChave, 1 );
  arrCamposChave[0] := dbeCodEst;
end;

function TfrmCadEmpresasEstoqueExterno.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender,blnBuscaPorChave)) Then
  Begin

    {*****************************************}
    {* VALIDA CODIGO                         *}
    {**************************************WI*}
    If (Sender = dbeCodEst) Then
    Begin
      If (fEmptyStr(dbeCodEst.Text)) And (dbeCodEst.Enabled) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'O Código da Empresa de Estoque Externo deve ser preenchido!', ['&Ok']);
      End
      {*****************************************}
      {* VERIFICA SE EXISTE O CODIGO INFORMADO *}
      {* CASO EXISTA TRAZ PARA EDICAO          *}
      {**************************************WI*}
      Else If blnBuscaPorChave Then
      Begin
        If Not fBuscaPorCamposChave Then
          pLimparCampos;
      End;
    End
    {*****************************************}
    {* VALIDA DESCRICAO                      *}
    {**************************************WI*}
    Else If (Sender = dbeDesEst) Then
    Begin
      If fEmptyStr(dbeDesEst.Text) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'A Descrição da Empresa de Estoque Externo deve ser preenchida!', ['&Ok']);
      End;
    End
    {*****************************************}
    {* VALIDA CPF/CNPJ                      *}
    {**************************************WI*}
    else if (Sender = dbeCgcCpf) then
    begin
      if (not fEmptyStr(dbeCgcCpf.Text)) and (Pos(dbeCgcCpf.Text,'1_2_') <= 0) then
      begin
        Result := False;
        fMensagem('ATENÇÃO!', 'Informe 1 para CNPJ ou 2 para CPF.', ['&Ok']);
      end;
    end
    else if (Sender = dbeNumCgc) then
    begin
      if (not fEmptyStr(dbeNumCgc.Text)) and (Pos(dbeCgcCpf.Text,'1_2_') <= 0) then
      begin
        Result := False;
        fMensagem('ATENÇÃO!', 'Informe 1 para CNPJ ou 2 para CPF.', ['&Ok']);
      end;

      if Result then
        Result := fValidaCnpjCpf(dbeCgcCpf.Text, dbeNumCgc.Text, False);
    end

    {*****************************************}
    {* VALIDA O CÓDIGO DE CLIENTE            *}
    {**************************************LU*}
    Else If (Sender = dbeCodCli) Then
    Begin
      If Not fEmptyStr(dbeCodCli.Text) Then
      Begin
        edtNomCli.Text := fRetNomCliente(dbeCodCli.Text);
        If fEmptyStr(edtNomCli.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse cliente não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End
      Else
      Begin
        edtNomCli.Text := '';
        dbeCodCli.Field.Value := Null;
      End;
    End

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadEmpresasEstoqueExterno.pAfterScroll(DataSet: TDataSet);
begin
  if (dbeCgcCpf.Text = '1') then
    qryTabela.FieldByName('EEE_C_G_C_').EditMask := fRetMascaraC_G_C_(fSetaPais, C_G_C_)
  else
    qryTabela.FieldByName('EEE_C_G_C_').EditMask := fRetMascaraC_G_C_(fSetaPais, C_P_F_);
end;

procedure TfrmCadEmpresasEstoqueExterno.pInicializaIndices;
begin
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('EEE_CODEEE');
  stlCampos.Add('EEE_DESEEE');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('EEE_DESEEE');
  stlCamInd.Add('EEE_CODEEE');

  stlDesInd.Add('Código');
  stlDesInd.Add('Descricão');
end;

end.
