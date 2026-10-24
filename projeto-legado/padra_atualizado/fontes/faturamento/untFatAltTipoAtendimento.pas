unit untFatAltTipoAtendimento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, BitBtnLockedIncrem, StrUtils,
  ExtCtrls, EditFocus, untFuncoesSimples, untTypesSistema,
  untFatAltTipoAtendimentoIntf, frxClass, frxExportCSVTestabilidade;

type
  TfrmFatAltTipoAtendimento = class(TfrmPai)
    pnlBusca: TPanel;
    pnlDados: TPanel;
    GroupBox1: TGroupBox;
    Label5: TLabel;
    edtDocum: TEditFocus;
    Label4: TLabel;
    edtEspDoc: TEditFocus;
    Label3: TLabel;
    edtCodEmp: TEditFocus;
    edtDesEmp: TEditFocus;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    edtCodCli: TEditFocus;
    edtDesCli: TEditFocus;
    Label2: TLabel;
    Label6: TLabel;
    edtDtaFat: TEditFocus;
    edtConPag: TEditFocus;
    lblCodVen: TLabel;
    edtCodVen: TEditFocus;
    edtDesVen: TEditFocus;
    lblCodRep: TLabel;
    edtCodRep: TEditFocus;
    edtDesRep: TEditFocus;
    Label7: TLabel;
    edtValDoc: TEditFocus;
    edtDesTpa: TEditFocus;
    Label8: TLabel;
    btnConfirma: TBitBtnLocked;
    pnlVendedor: TPanel;
    lblVen: TLabel;
    edtCodNew: TEditFocus;
    edtDesNew: TEditFocus;
    edtCodTpa: TEditFocus;
    procedure edtCodNewKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    arrTpaAte: TConsultasArray;
    arrEmp: TConsultasArray;
    AltTipAtendimento: IAltTipoAtendimento;

    procedure pLimpaTela;
    function fBuscaDocumento(strNumDoc, strEspDoc, strCodEmp: String): Boolean;
  public
    { Public declarations }
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
    procedure pEscapePressed; Override;
  end;

implementation

uses untFatAltTipoAtendimentoDao, untConsultas;

{$R *.dfm}

procedure TfrmFatAltTipoAtendimento.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  If Not fVerificaCampos Then
    Exit
  Else
  Begin
    AltTipAtendimento.strTipAteNew := edtCodNew.Text;
    If TAltTipoAtendimentoDao.fUpdateByTipoAtendimento(AltTipAtendimento) then
      fMensagem('', 'Alteração do tipo de atendimento no documento ' +
                    AltTipAtendimento.strNumDoc + '-' + AltTipAtendimento.strEspDoc +  #13#10 +
                    ' realizada com sucesso!', ['&O k']);

    AltTipAtendimento := nil;

    pLimpaTela;
  End;

end;

procedure TfrmFatAltTipoAtendimento.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtDesEmp, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmp) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatAltTipoAtendimento.edtCodNewKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqTipoAtendimento(Self, edtCodNew, edtDesNew, Nil, Key, arrTpaAte) Then
  Begin
    if fValidaCampos(edtCodNew, True) then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmFatAltTipoAtendimento.fBuscaDocumento(strNumDoc, strEspDoc,
  strCodEmp: String): Boolean;
begin
  Result := False;

  AltTipAtendimento := TAltTipoAtendimentoDao.fFindByDocumento(strNumDoc, strEspDoc, strCodEmp);

  If AltTipAtendimento <> Nil then
  begin
    edtCodCli.Text := AltTipAtendimento.strCodCli;
    edtDesCli.Text := AltTipAtendimento.strNomCli;
    edtDtaFat.Text := FormatDateTime('dd/mm/yyyy', AltTipAtendimento.dtaDtEmis);
    edtConPag.Text := fFormataCondPag(AltTipAtendimento.strCndPgt);
    edtCodVen.Text := AltTipAtendimento.strCodVen;
    edtDesVen.Text := AltTipAtendimento.strNomVen;
    edtCodRep.Text := AltTipAtendimento.strCodRep;
    edtDesRep.Text := AltTipAtendimento.strNomRep;
    edtValDoc.Text := FormatFloat('#,##0.00', fFormataFloat(AltTipAtendimento.fltValDoc, 2));
    edtCodTpa.Text := AltTipAtendimento.strCodAteAtu;
    edtDesTpa.Text := AltTipAtendimento.strTipAteAtu;

    btnConfirma.Enabled := True;
    pnlBusca.Enabled    := False;
    pnlVendedor.Enabled := True;

    Result := True;
  end;
end;

procedure TfrmFatAltTipoAtendimento.FormActivate(Sender: TObject);
begin
  inherited;           

  pSetFocus(edtDocum);
end;

procedure TfrmFatAltTipoAtendimento.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If AltTipAtendimento <> Nil Then
  Begin
    fLock_Unlock('FATGOR' + AltTipAtendimento.strNumDoc + AltTipAtendimento.strEspDoc +
                 AltTipAtendimento.strCodEmp, False, False);
    AltTipAtendimento := nil;
  End;
end;

procedure TfrmFatAltTipoAtendimento.FormShow(Sender: TObject);
begin
  inherited;

  pLimpaTela;
end;

function TfrmFatAltTipoAtendimento.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtDocum) Then
    Begin
      If fEmptyStr(edtDocum.Text) Then
      Begin
        fMensagem('','Digite o número do documento !',['&O K']);
        Result := False;
      End;
    End

    Else If (Sender = edtEspDoc) Then
    Begin
      If fEmptyStr(edtEspDoc.Text) Then
      Begin
        fMensagem('','Digite a espécie do documento !',['&O K']);
        Result := False;
      End;
    End

    Else If (Sender = edtCodEmp) Then
    Begin
      If fEmptyStr(edtCodEmp.Text) Then
      Begin
        fMensagem('','Digite o código da empresa !',['&O K']);
        Result := False;
      End
      Else
      Begin
        edtDesEmp.Text := fRetNomeEmpresa(edtCodEmp.Text);
        
        If fEmptyStr(edtDesEmp.Text) Then
        Begin
          fMensagem('','Empresa digitada não foi encontrada, verifique !',['&O K']);
          Result := False;
        End

        Else If (Not pnlVendedor.Enabled) Then
        Begin

          If Not fLock_Unlock('FATGOR' + edtDocum.Text + edtEspDoc.Text + edtCodEmp.Text, True, False) Then
          Begin
            fMensagem('', 'Esse Documento está sendo utilizado em Outra Estação por ' +
                          fGetHostLock('FATGOR' + edtDocum.Text + edtEspDoc.Text + edtCodEmp.Text)  + '!', ['&Ok']);
            Result := False;
          End

          Else If (Not fBuscaDocumento(edtDocum.Text, edtEspDoc.Text, edtCodEmp.Text)) Then
          Begin
            fMensagem('','Documento digitado não foi encontrado, verifique !',['&O K']);
            Result := False;

            fLock_Unlock('FATGOR' + edtDocum.Text + edtEspDoc.Text + edtCodEmp.Text, False, False);

          End;

        End;
      End;
    End

    Else If (Sender = edtCodNew) Then
    Begin
      edtDesNew.Text := fRetNomTipoAtend(edtCodNew.Text);

      If fEmptyStr(edtCodNew.Text) Then
      Begin
        If fCfgSis('OBRTPA', VarBoolean) Then
        Begin
          fMensagem('','Digite o código do tipo de atendimento !',['&O K']);
          Result := False;
        End;
      End
      Else
      Begin
        If fEmptyStr(edtDesNew.Text) Then
        Begin
         fMensagem('','Tipo de atendimento digitado não foi encontrado, verifique !',['&O K']);
         Result := False;
        End
        Else If AnsiLeftStr(edtCodTpa.Text, 5) = edtCodNew.Text Then
        Begin
          fMensagem('','Tipo de atendimento digitado é o mesmo do documento. Escolha um diferente!',['&O K']);
          Result := False;
        End;
      End;
    end;
  end;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmFatAltTipoAtendimento.pEscapePressed;
begin
  If ((ActiveControl) = edtCodEmp) Or ((ActiveControl) = edtEspDoc) Or ((ActiveControl) = edtCodNew) Then
    pLimpaTela
  Else if (ActiveControl) = edtDocum Then
    Close
  Else
    inherited;
end;

procedure TfrmFatAltTipoAtendimento.pLimpaTela;
  Var
    intIdx: Integer;
begin
  For intIdx := 0 To Self.ComponentCount - 1 Do
  Begin
    If Self.Components[intIdx] Is TEditFocus Then
      (Self.Components[intIdx] As TEditFocus).Clear;
  End;

  edtCodNew.Text := '';
  edtDesNew.Text := '';

  edtCodEmp.Text := VS_strCodEmp;
  edtDesEmp.Text := fRetNomeEmpresa;
  edtEspDoc.Text := 'PD';
  
  btnConfirma.Enabled := False;
  pnlBusca.Enabled    := True;
  pnlVendedor.Enabled := False;

  If AltTipAtendimento <> Nil Then
  Begin
    fLock_Unlock('FATGOR' + AltTipAtendimento.strNumDoc + AltTipAtendimento.strEspDoc +
                 AltTipAtendimento.strCodEmp, False, False);
    AltTipAtendimento := nil;
  End;
    
  pSetFocus(edtDocum);
end;

end.
