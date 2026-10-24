unit untCadOcoCartei;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, EditFocus, Uni, ComboBoxFocus,
  untFramePlanoDeContasMaskEdit,untCNFOCO_Class, untCNFOCO_Dao;

type
  TfrmCadOcoCartei = class(TfrmPai)
    Label7: TLabel;
    Label21: TLabel;
    edtDesPorTar: TEditFocus;
    edtPorTar: TEditFocus;
    edtDesForTar: TEditFocus;
    edtForTar: TEditFocus;
    chkGerPag: TCheckBox;
    Label1: TLabel;
    edtCodOco: TEditFocus;
    edtDesOco: TEditFocus;
    btbConFir: TBitBtnLocked;
    pnlTopo: TPanel;
    chkCusCar: TCheckBox;
    edtMotOco: TEditFocus;
    lblTipDes: TLabel;
    cmbTipDes: TComboBoxFocus;
    chkDiasCredito: TCheckBox;
    fraPlanoDeContasOco: TfraPlanoDeContasMskEdit;
    lblDescontada1: TLabel;
    lblDescontada2: TLabel;
    chkGerRec: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure edtPorTarKeyPress(Sender: TObject; var Key: Char);
    procedure edtForTarKeyPress(Sender: TObject; var Key: Char);
    procedure btbConFirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure fraPlanoDeContasOcoMskCodCtaKeyPress(Sender: TObject;
      var Key: Char);
    procedure cmbTipDesChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    qryCadPor : TUniQuery;
    qryCadCta : TUniQuery;
    qryCadFor : TUniQuery;
    FobjCnfOco: TCnfOco;

    procedure pCarregaPortador(strCodPor: String; edtLabel: TEdit);
    procedure pCarregaCentroCusto(strCtaBai: String; edtLabel: TEdit);
  public
    { Public declarations }
    strCartei      : String;
    blnEditar,
    blnAceitaOcoBai: Boolean;
    blnValidaMotOco: Boolean;//MF: 284336 - 17/05/2023
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

var
  frmCadOcoCartei: TfrmCadOcoCartei;

implementation

{$R *.dfm}

uses untFuncoesSimples, untFuncoes, untPesqAux, untTypesSistema, untConsultas;

{ TfrmCadOcoCartei }

procedure TfrmCadOcoCartei.fraPlanoDeContasOcoMskCodCtaKeyPress(Sender: TObject;
  var Key: Char);
  Var
  arrCentroCusto : TConsultasArray;
begin
  inherited;
  If fPesqCentroCusto(Self, fraPlanoDeContasOco.MskCodCta, fraPlanoDeContasOco.edtDesCta, Nil, Key, arrCentroCusto) Then
  begin
    if fValidaCampos(fraPlanoDeContasOco.MskCodCta)  then
      SelectNext(ActiveControl, True, True);
  end;
end;

function TfrmCadOcoCartei.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtPorTar) Then
    Begin
      If fEmptyStr(edtPorTar.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Portador deve ser informado!', ['&Ok']);
        fraPlanoDeContasOco.edtDesCta.Clear;
        Result := False;
      End
      Else
      Begin
        pCarregaPortador(edtPorTar.Text, edtDesPorTar);

        If qryCadPor.FieldByName('POR_CODPOR').IsNull Then
        Begin
          fMensagem('', 'Esse portador não está cadastrado!', ['&Ok']);
          fraPlanoDeContasOco.edtDesCta.Clear;
          Result := False;
        End
        {*REQ*145940**********RP*}
        Else If Not fEmpresaTemAcessoPortador(edtPorTar.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores no Autcom - Aba "Empresas Acesso".', ['&Ok']);
          Result := False;
        End
        Else If fCfgSis('DACPOR', varBoolean) Then
        Begin
          If (Pos(edtPorTar.Text, strPortadoresOperador) <= 0) Then
          Begin
            If Not fEmptyStr(edtPorTar.Text) Then
            Begin
              fMensagem('ATENÇÃO!','Usuário sem permissão de acesso a este portador!', ['&Ok']);
              fraPlanoDeContasOco.edtDesCta.Clear;
              Result := False;
            End
          End;
        End;
      End;
    End
    Else If (Sender = edtCodOco) Then
    Begin
      If fEmptyStr(edtCodOco.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código da Ocorrência deve ser informado!', ['&Ok']);
        edtCodOco.Clear;
        Result := False;
      End
      Else
      If (Pos(edtCodOco.Text, '08_06_') > 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'Não é permitido usar o Código de Ocorrência informado para tarifas bancárias!', ['&Ok']);
        edtCodOco.Clear;
        Result := False;
      End;
    End
    Else If (Sender = edtMotOco) Then
    Begin //MF: 284336 - 17/05/2023
      If (blnValidaMotOco) and (fEmptyStr(edtMotOco.Text)) and (edtMotOco.Enabled) and (edtCodOco.Text = '28') Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do Motivo da Ocorrência deve ser informado!', ['&Ok']);
        Result := False;
      End;
    End
    Else If (Sender = cmbTipDes) And (cmbTipDes.Visible) Then
    Begin
      If (cmbTipDes.ItemIndex <=0) and (edtCodOco.Text = '02') Then
      Begin
        fMensagem('ATENÇÃO!', 'O Tipo do desconto deve ser informado!', ['&Ok']);
        Result := False;
      End
    End
    Else If (Sender = edtDesOco) Then
    Begin
      If fEmptyStr(edtDesOco.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Descrição da Ocorrência deve ser preenchida!', ['&Ok']);
        edtDesOco.Clear;
        Result := False;
      End;
    End
    Else If (Sender = fraPlanoDeContasOco.MskCodCta) Then
    Begin
      If fEmptyStr(fraPlanoDeContasOco.MskCodCta.Text) Then
      begin
        fMensagem('ATENÇÃO!', 'O Plano de Contas deve ser informado!', ['&Ok']);
        fraPlanoDeContasOco.edtDesCta.Clear;
        Result := False;
      end
      Else
      Begin
        pCarregaCentroCusto(fraPlanoDeContasOco.MskCodCta.Text, fraPlanoDeContasOco.edtDesCta);
        If qryCadCta.FieldByName('CTA_CODCTA').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!', ['&Ok']);
          fraPlanoDeContasOco.edtDesCta.Text := '';
          Result := False;
        End
        else
        Begin
          Result := PlanoDeContasAtivo(fraPlanoDeContasOco.MskCodCta.Text,True);
          fraPlanoDeContasOco.edtDesCta.Text := qryCadCta.FieldByName('CTA_DESCTA').AsString;
        End;
      end;
    End
    Else If (Sender = edtForTar)  Then
    Begin
      If fEmptyStr(edtForTar.Text) Then
      begin
        fMensagem('ATENÇÃO','O Código do Fornecedor deve ser preenchido!',['&OK']);
        edtDesForTar.Text := '';
        Result := False;
      end
      else
      begin
        pPesquisaCadFor(qryCadFor, qryCadFor, edtForTar.Text);

        If qryCadFor.FieldByName('FOR_CODFOR').IsNull Then
        Begin
          fMensagem('', 'Esse fornecedor não está cadastrado!', ['&Ok']);
          edtDesForTar.Text := '';
          Result := False;
        End
        else
          edtDesForTar.Text  := qryCadFor.FieldByName('FOR_NOMFOR').AsString;
      end;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCadOcoCartei.btbConFirClick(Sender: TObject);
var
  objCnfOco: TCnfOco;
  objCnfDao: TCnfOcoDao;
  strCodBco: String;
  strTipLay: String;
  strNumPos: String;
  strEspeci: String;
  strCodEmp: String;
  intCartei: Integer;
begin
  inherited;
  If fVerificaCampos Then
  Begin
    pDesmembraCarteira(strCartei, strCodBco, strTipLay, strNumPos,
                                  strEspeci, strCodEmp, intCartei);

    objCnfDao := TCnfOcoDao.Create(strCodBco, strTipLay, strNumPos,
                                   strEspeci, strCodEmp, intCartei);

    If Not blnEditar Then
    Begin
      Try
        objCnfOco := TCnfOco.Create;
        objCnfOco.strCodBco := strCodBco;
        objCnfOco.strTipLay := strTipLay;
        objCnfOco.strNumPos := strNumPos;
        objCnfOco.strEspeci := strEspeci;
        objCnfOco.strCodEmp := strCodEmp;
        objCnfOco.intCartei := intCartei;
        objCnfOco.strCodOco := Trim(edtCodOco.Text);
        objCnfOco.strDesOco := Trim(edtDesOco.Text);
        objCnfOco.strMotOco := Trim(edtMotOco.Text);
        objCnfOco.intTipDes := IIF(cmbTipDes.ItemIndex < 0, 0 ,cmbTipDes.ItemIndex);
        objCnfOco.strCodPor := edtPorTar.Text;
        objCnfOco.strCodCta := fraPlanoDeContasOco.MskCodCta.Text;
        objCnfOco.strCodFor := edtForTar.Text;
        objCnfOco.blnGerpag := chkGerPag.Checked;
        objCnfOco.blnCusCar := chkCusCar.Checked;
        objCnfOco.blnUsaDia := chkDiasCredito.Checked;
        objCnfOco.blnGerRec := chkGerRec.Checked;

        If objCnfDao.fInserir(objCnfOco) Then
        Begin
          pMensagemOk('Registro incluído com sucesso!');
          Close;
        End;

        objCnfOco.Free;
      Except
        On E: Exception Do
        Begin
          If Pos('Duplicate', E.Message) > 0 Then
          Begin
            pMensagemOk('Ocorrência já cadastrada!');
            pSetFocus(edtCodOco);
          End
          Else
            pMensagemOk('Ocorreu o seguinte erro ao salvar o registro: '+ E.Message);
        End;
      End;

    End
    Else
    Begin

      If Assigned(FobjCnfOco) Then
      Begin
        Try
          FobjCnfOco.strCodPor := edtPorTar.Text;
          FobjCnfOco.strCodCta := fraPlanoDeContasOco.MskCodCta.Text;
          FobjCnfOco.strCodFor := edtForTar.Text;
          FobjCnfOco.blnGerpag := chkGerPag.Checked;
          FobjCnfOco.blnCusCar := chkCusCar.Checked;
          FobjCnfOco.blnUsaDia := chkDiasCredito.Checked;
          FobjCnfOco.blnGerRec := chkGerRec.Checked;

          If objCnfDao.fAtualizar(FobjCnfOco) Then
          Begin
            pMensagemOk('Registro atualizado com sucesso!');
            Close;
          End;

        Except
          On E: Exception Do
            pMensagemOk('Ocorreu o seguinte erro ao atualizar o registro: '+ E.Message);
        End;

      End;
    End;

    If Assigned(objCnfDao) Then
      objCnfDao.Free;
  End;
end;

procedure TfrmCadOcoCartei.cmbTipDesChange(Sender: TObject);
begin
  inherited;
  If Not cmbTipDes.Visible Then
    Exit;

  lblDescontada1.Visible := cmbTipDes.ItemIndex > 0;
  lblDescontada2.Visible := cmbTipDes.ItemIndex > 0;
end;

procedure TfrmCadOcoCartei.edtForTarKeyPress(Sender: TObject; var Key: Char);
  Var
    arrFornec: TConsultasArray;
begin
  inherited;
  If fPesqFornecedor(conForCompleta, Self, edtForTar, edtDesForTar, Nil, Key, arrFornec) Then
  Begin
    If fValidaCampos(edtForTar, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmCadOcoCartei.edtPorTarKeyPress(Sender: TObject; var Key: Char);
var
    ArrSel: TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    If fPesqPortador(conSimples, Self, edtPorTar, edtDesPorTar, nil, Key, arrSel) then
    Begin
      If fValidaCampos(edtPorTar) Then
        Self.SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmCadOcoCartei.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  If Assigned(FobjCnfOco) Then
    FreeAndNil(FobjCnfOco);
end;

procedure TfrmCadOcoCartei.FormCreate(Sender: TObject);
begin
  inherited;
  blnEditar       := False;
  blnAceitaOcoBai := False;
  blnValidaMotOco := True;//MF: 284336 - 17/05/2023
end;

procedure TfrmCadOcoCartei.FormShow(Sender: TObject);
var
  objCnfDao: TCnfOcoDao;
  strCodBco: String;
  strTipLay: String;
  strNumPos: String;
  strEspeci: String;
  strCodEmp: String;
  intCartei: Integer;
begin
  inherited;
  qryCadPor := fCriaQuery(Self);
  qryCadFor := fCriaQuery(Self);
  qryCadCta := fCriarQuery('SELECT * FROM CADCTA WHERE FALSE', Self);

  If Pos('CONFIG341', strCartei) <= 0 Then
    cmbTipDes.Items.Delete(4);

  If Pos('CONFIG237-', strCartei) > 0 Then
    chkGerRec.Visible := True
  Else
    chkGerRec.Visible := False;

  If blnEditar Then
  Begin
    pDesmembraCarteira(strCartei, strCodBco, strTipLay, strNumPos,
                                  strEspeci, strCodEmp, intCartei);

    objCnfDao := TCnfOcoDao.Create(strCodBco, strTipLay, strNumPos,
                                   strEspeci, strCodEmp, intCartei);

    FobjCnfOco := objCnfDao.fBuscaPorOcorrencia(edtCodOco.Text,edtMotOco.Text,fraPlanoDeContasOco.MskCodCta.Text,IIF(cmbTipDes.ItemIndex < 0, 0 ,cmbTipDes.ItemIndex));
    If Assigned(FobjCnfOco) Then
    Begin
      edtCodOco.Text      := FobjCnfOco.strCodOco;
      edtMotOco.Text      := FobjCnfOco.strMotOco;
      cmbTipDes.ItemIndex := FobjCnfOco.intTipDes;
      edtDesOco.Text      := FobjCnfOco.strDesOco;
      edtPorTar.Text      := FobjCnfOco.strCodPor;
      pCarregaPortador(FobjCnfOco.strCodPor, edtDesPorTar);

      fraPlanoDeContasOco.MskCodCta.Text := FobjCnfOco.strCodCta;
      pCarregaCentroCusto(FobjCnfOco.strCodCta, fraPlanoDeContasOco.edtDesCta);

      edtForTar.Text    := FobjCnfOco.strCodFor;
      fValidaCampos(edtForTar);

      chkGerPag.Checked := FobjCnfOco.blnGerpag;
      chkCusCar.Checked := FobjCnfOco.blnCusCar;
      chkGerRec.Checked := FobjCnfOco.blnGerRec;

      chkDiasCredito.Checked := FobjCnfOco.blnUsaDia;


      edtCodOco.Enabled := False;
      edtCodOco.Color   := $00FFDFB8;
      edtMotOco.Enabled := False;
      edtMotOco.Color   := $00FFDFB8;
      edtDesOco.Enabled := False;
      edtDesOco.Color   := $00FFDFB8;
      pSetFocus(edtPorTar);
    End
    Else
      blnEditar := False;

  End;

  cmbTipDes.OnChange(cmbTipDes);
end;

procedure TfrmCadOcoCartei.pCarregaCentroCusto(strCtaBai: String;
  edtLabel: TEdit);
begin
  pPesquisaCadCta(qryCadCta, qryCadCta, strCtaBai);
  With qryCadCta Do
  Begin
    edtLabel.Text := FieldByName('CTA_DESCTA').AsString;
  End;
end;

procedure TfrmCadOcoCartei.pCarregaPortador(strCodPor: String; edtLabel: TEdit);
begin
  pPesquisaCadPor(Nil, qryCadPor, strCodPor);
  With qryCadPor Do
  Begin
    edtLabel.Text := FieldByName('POR_NOMPOR').AsString;
  End;
end;

end.
