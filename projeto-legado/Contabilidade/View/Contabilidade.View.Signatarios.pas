unit Contabilidade.View.Signatarios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Contabilidade.View.TfrmPaiCadContabilidade, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.Mask, Vcl.DBCtrls,
  DBEditFocus, QColorLabel, Data.DB, ComboBoxFocus, EditFocus;

type
  TfrmCadCse = class(TfrmPaiCadContabilidade)
    pnlGeral: TPanel;
    lblDtaCer: TLabel;
    dbeDtaCer: TDBEditFocus;
    lblNomSig: TLabel;
    dbeNomSig: TDBEditFocus;
    lblQuaAss: TLabel;
    lblDocSig: TLabel;
    rdbCpf: TRadioButton;
    rdbCnpj: TRadioButton;
    dbeDocSig: TDBEditFocus;
    lblNumCrc: TLabel;
    dbeNumCrc: TDBEditFocus;
    lblEmaSig: TLabel;
    dbeEmaSig: TDBEditFocus;
    lblTelSig: TLabel;
    dbeTelSig: TDBEditFocus;
    lblUfExCr: TLabel;
    dbeUfExCr: TDBEditFocus;
    lblNumCer: TLabel;
    dbeNumCer: TDBEditFocus;
    lblAguardandoSN: TColorLabel;
    lblSigRes: TLabel;
    dbeSigRes: TDBEditFocus;
    dtsCadSig: TDataSource;
    cbbQuaAss: TComboBoxFocus;
    lblFormato: TLabel;
    edtNomEmp: TEditFocus;
    dbeCodEmp: TDBEditFocus;
    Label15: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure cbbQuaAssChange(Sender: TObject);
    procedure rdbCpfClick(Sender: TObject);
    procedure dbeCodEmpKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    procedure pSetaQualificacaoAssinante;
    procedure pCarregaDescricaoCampos;
  protected
    procedure pInicializaIndices; override;
    function  fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmCadCse: TfrmCadCse;

implementation

uses
  untFuncoesSimples, Contabilidade.Funcoes, Contabilidade.Consultas,
  untTypesSistema, StrUtils, untFuncoesGenerica, untConsultas;

{$R *.dfm}

procedure TfrmCadCse.btnAlterarClick(Sender: TObject);
begin
  inherited;
  cbbQuaAss.Enabled := True;
end;

procedure TfrmCadCse.btnCancelaClick(Sender: TObject);
begin
  inherited;
  if fEmptyStr(qryTabela.FieldByName('CSE_CODQUA').AsString) then
  begin
    cbbQuaAss.ItemIndex := -1;
  end
  else
    pSetaQualificacaoAssinante;

  pCarregaDescricaoCampos;
end;

procedure TfrmCadCse.btnExcluirClick(Sender: TObject);
begin
  inherited;
  if blnExcluiu then
  begin
    cbbQuaAss.ItemIndex := -1;
    cbbQuaAss.Enabled := False;
    fMensagem('','Registro excluído com sucesso!', ['&Ok']);
  end;
end;

procedure TfrmCadCse.btnGravarClick(Sender: TObject);
begin
  qryTabela.FieldByName('CSE_CODQUA').AsString := Copy(cbbQuaAss.Text,1,3);
  qryTabela.FieldByName('CSE_DESQUA').AsString := Copy(cbbQuaAss.Text,5,Length(cbbQuaAss.Text));

  if qryTabela.FieldByName('CSE_CODEMP').AsString.Trim.IsEmpty then
    qryTabela.FieldByName('CSE_CODEMP').Clear;

  inherited;

  if blnGravou then
  begin
    cbbQuaAss.Enabled := False;
    fMensagem('','Registro gravado com sucesso!', ['&Ok']);
  end;
end;

procedure TfrmCadCse.btnIncluirClick(Sender: TObject);
begin
  inherited;
  rdbCpf.Checked := True;
  cbbQuaAss.ItemIndex := -1;
  cbbQuaAss.Enabled := True;
  pCarregaDescricaoCampos;
  pSetFocus(dbeNomSig);
end;

procedure TfrmCadCse.btnPesquisaClick(Sender: TObject);
Var
  chrKey: Char;
  arrSigna: TConsultasArray;
begin
  inherited;
  chrKey := '/';
  if fPesqSignatarios(Self, Nil, Nil, qryTabela, chrKey, arrSigna) then
  begin
    pSetaQualificacaoAssinante;

    if Length(qryTabela.FieldByName('CSE_DOCSIG').AsString) = 11 then
    begin
      rdbCpf.Checked := True;
    end
    else
    begin
      rdbCnpj.Checked := True;
    end;

    rdbCpfClick(rdbCpf);

    qryTabela.FieldByName('CSE_DTACER').EditMask := '99/99/9999;1;';
    qryTabela.FieldByName('CSE_TELSIG').EditMask := '(99)99999-9999;0;';

    pCarregaDescricaoCampos;
    pSetFocus(btnAlterar);
  end;
end;

procedure TfrmCadCse.cbbQuaAssChange(Sender: TObject);
begin
  inherited;
  if Copy(cbbQuaAss.Text,1,3) = '001' then
  begin
    dbeNumCrc.Clear;
    dbeUfExCr.Clear;
    dbeNumCer.Clear;
    dbeDtaCer.Clear;

    qryTabela.FieldByName('CSE_DTACER').EditMask := '99/99/9999;1;';

    dbeNumCrc.Enabled := False;
    dbeUfExCr.Enabled := False;
    dbeNumCer.Enabled := False;
    dbeDtaCer.Enabled := False;
  end
  else
  begin
    dbeNumCrc.Enabled := True;
    dbeUfExCr.Enabled := True;
    dbeNumCer.Enabled := True;
    dbeDtaCer.Enabled := True;
  end;
end;

procedure TfrmCadCse.dbeCodEmpKeyPress(Sender: TObject; var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  If fPesqEmpresa(conEmpSimples, Self, dbeCodEmp, edtNomEmp, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(dbeCodEmp, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;


procedure TfrmCadCse.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela := 'CADCSE';
  strNomeCampo  := 'AUTOINCREM';
  qryTabela := fCriarQuery('SELECT * FROM CADCSE', Self);
  dtsCadSig.DataSet := qryTabela;

  qryTabela.FieldByName('CSE_DOCSIG').EditMask := '999.999.999-99;0;';
  qryTabela.FieldByName('CSE_DTACER').EditMask := '99/99/9999;1;';
  qryTabela.FieldByName('CSE_TELSIG').EditMask := '(99)99999-9999;0;';

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeDocSig;
  blnIgnorarCodEmp := True;
end;

procedure TfrmCadCse.FormShow(Sender: TObject);
begin
  inherited;
  cbbQuaAss.ItemIndex := -1;
  pSetFocus(dbeNomSig);
end;

function TfrmCadCse.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender)) Then
  Begin
    if (Sender = dbeNomSig) then
    begin
      if fEmptyStr(dbeNomSig.Text) then
      begin
         fMensagem('','Informe o nome do signatário!', ['&Ok']);
         Result := False;
      end;
    end
    else
    if (Sender = dbeDocSig) then
    begin
      if not fValidaCnpjCpf(dbeDocSig.Text, True) then
      begin
        Result := False;
      end;
    end
    else
    if (Sender = cbbQuaAss) then
    begin
      if cbbQuaAss.ItemIndex = -1 then
      begin
        fMensagem('','Informe a qualificação do assinante!', ['&Ok']);
        Result := False;
      end;
    end
    else
    if (Sender = dbeSigRes) then
    begin
      if fEmptyStr(dbeSigRes.Text) then
      begin
        fMensagem('','Informe se o o signatário é responsável ou não pela assinatura!', ['&Ok']);
        Result := False;
      end
      else
      if (Copy(cbbQuaAss.Text, 1, 3) = '900') and (Pos(dbeSigRes.Text, 'N_') <= 0) then
      begin
        fMensagem('','Quando a qualificação for "900 Contador/Contabilista" o responsável pela assinatura deve ser não!', ['&Ok']);
        Result := False;
      end
      else
      if Pos(dbeSigRes.Text, 'S_N_') <= 0 then
      begin
        fMensagem('','O valor do responsável de assinatura deve ser somente S ou N!', ['&Ok']);
        Result := False;
      end;
    end
    else
    if (Sender = dbeNumCrc) then
    begin
      if (Copy(cbbQuaAss.Text, 1, 3) = '900') and (fEmptyStr(dbeNumCrc.Text)) then
      begin
        fMensagem('', 'Quando a qualificação for "900 Contador/Contabilista" o número do CRC não pode ser vazio!', ['&Ok']);
        Result := False;
      end;
    end
    else
    if (Sender = dbeEmaSig) then
    begin
      if (Copy(cbbQuaAss.Text, 1, 3) = '900') and (fEmptyStr(dbeEmaSig.Text)) then
      begin
        fMensagem('', 'Quando a qualificação for "900 Contador/Contabilista" o e-mail não pode ser vazio!', ['&Ok']);
        Result := False;
      end
      else
      if (not fEmptyStr(dbeEmaSig.Text)) and (not fEmailValido(dbeEmaSig.Text, False)) then
      begin
        fMensagem('', 'Informe um e-mail válido!', ['&Ok']);
        Result := False;
      end;
    end
    else
    if (Sender = dbeTelSig) then
    begin
      if (Copy(cbbQuaAss.Text, 1, 3) = '900') and (fEmptyStr(dbeTelSig.Text)) then
      begin
        fMensagem('', 'Quando a qualificação for "900 Contador/Contabilista" o telefone não pode ser vazio!', ['&Ok']);
        Result := False;
      end;
    end
    else
    if (Sender = dbeUfExCr) then
    begin
      if (Copy(cbbQuaAss.Text, 1, 3) = '900') and (fEmptyStr(dbeUfExCr.Text)) then
      begin
        fMensagem('', 'Quando a qualificação for "900 Contador/Contabilista" o estado não pode ser vazio!', ['&Ok']);
        Result := False;
      end
      else
      if (not fEmptyStr(dbeUfExCr.Text)) and (not fValidaEstado(dbeUfExCr.Text)) then
      begin
        fMensagem('', 'Estado inválido!', ['&Ok']);
        Result := False;
      end;
    end
    else
    if (Sender = dbeNumCer) then
    begin
      if (not fEmptyStr(dbeNumCer.Text)) and (not fValidaNumeroCertidaoContador(dbeNumCer.Text)) then
      begin
        fMensagem('','Número de certidão inválida!', ['&Ok']);
        Result := False;
      end;
    end
    else
    if (Sender = dbeDtaCer) then
    begin
      if (not fEmptyStr(fTiraCaracEspeciais(dbeDtaCer.Text))) and (not fValidaDataStr(dbeDtaCer.Text)) then
      begin
        fMensagem('', 'Data inválida!', ['&Ok']);
        Result := False;
      end;
    end
    Else If (Sender = dbeCodEmp) Then
    Begin
      If fEmptyStr(dbeCodEmp.Text) Then
      Begin
        edtNomEmp.Clear;
      End
      Else
      Begin
        edtNomEmp.Text := fCampoTabela('EMP_NOMEMP', 'CADEMP', ['EMP_CODEMP'], [dbeCodEmp.Text]);
        If (fEmptyStr(edtNomEmp.Text)) Then
        Begin
          fMensagem('ATENÇÃO!','A empresa não está cadastrada!',['&OK']);
          Result := False;
        End;
      End;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadCse.pCarregaDescricaoCampos;
begin
  if Trim(dbeCodEmp.Text).IsEmpty then
    edtNomEmp.Text := ''
  else
    edtNomEmp.Text := fCampoTabela('EMP_NOMEMP', 'CADEMP', ['EMP_CODEMP'], [dbeCodEmp.Text], False);
end;

procedure TfrmCadCse.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('CSE_CODEMP');
  stlCampos.Add('CSE_NOMSIG');
  stlCampos.Add('CSE_DOCSIG');
  stlCampos.Add('CSE_DESQUA');
  stlCampos.Add('CSE_CODQUA');
  stlCampos.Add('CSE_NUMCRC');
  stlCampos.Add('CSE_EMASIG');
  stlCampos.Add('CSE_TELSIG');
  stlCampos.Add('CSE_UFEXCR');
  stlCampos.Add('CSE_NUMCER');
  stlCampos.Add('CSE_DTACER');
  stlCampos.Add('CSE_SIGRES');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('CSE_CODEMP');
  stlCamInd.Add('CSE_NOMSIG');
  stlCamInd.Add('CSE_DOCSIG');
  stlCamInd.Add('CSE_DESQUA');
  stlCamInd.Add('CSE_CODQUA');
  stlCamInd.Add('CSE_NUMCRC');
  stlCamInd.Add('CSE_EMASIG');
  stlCamInd.Add('CSE_TELSIG');
  stlCamInd.Add('CSE_UFEXCR');
  stlCamInd.Add('CSE_NUMCER');
  stlCamInd.Add('CSE_DTACER');
  stlCamInd.Add('CSE_SIGRES');

  stlDesInd.Add('Código Empresa');
  stlDesInd.Add('Nome Signatário');
  stlDesInd.Add('Documento Signatário');
  stlDesInd.Add('Qualificação do Assinante');
  stlDesInd.Add('Código Qualificação');
  stlDesInd.Add('Número CRC');
  stlDesInd.Add('E-mail Signatário');
  stlDesInd.Add('Telefone Signatario');
  stlDesInd.Add('UF de Expedição');
  stlDesInd.Add('Número da Certidão');
  stlDesInd.Add('Data de Validade da Certidão');
  stlDesInd.Add('Signatário Responsável');
end;


procedure TfrmCadCse.pSetaQualificacaoAssinante;
  var
    intCnt : Integer;
begin
  intCnt := cbbQuaAss.Items.IndexOf(qryTabela.FieldByName('CSE_CODQUA').AsString + ' ' + qryTabela.FieldByName('CSE_DESQUA').AsString);
  if (intCnt >= 0) then
    cbbQuaAss.ItemIndex := intCnt
  else
  begin
    for intCnt := 0 to Pred(cbbQuaAss.Items.Count) do
    begin
      if LeftStr(cbbQuaAss.Items.Strings[intCnt], 3) = qryTabela.FieldByName('CSE_CODQUA').AsString then
      begin
        cbbQuaAss.ItemIndex := intCnt;
        Break;
      end;
    end;
  end;
end;

procedure TfrmCadCse.rdbCpfClick(Sender: TObject);
begin
  inherited;
  if rdbCpf.Checked then
  begin
    qryTabela.FieldByName('CSE_DOCSIG').EditMask := '999.999.999-99;0;';
  end
  else
  begin
    qryTabela.FieldByName('CSE_DOCSIG').EditMask := fRetMascaraC_G_C_(fSetaPais, C_G_C_);
  end;
end;

end.
