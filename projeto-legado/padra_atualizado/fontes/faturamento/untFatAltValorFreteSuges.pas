unit untFatAltValorFreteSuges;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, ExtCtrls, StdCtrls, EditFocus, AppEvnts, Menus, Buttons,
  BitBtnLockedIncrem, untFatAltValorFreteSugestaoIntf, untFuncoesSimples,
  untTypesSistema, frxClass, frxExportCSVTestabilidade, untTLock;

Type
  TRetornoBusca = (rbDocNaoEncontrado, rbDocUsadoOutraEstacao, rbDocEncontrado);
  
type
  TfrmFatAltValorFreteSuges = class(TfrmPai)
    btnConfirma: TBitBtnLocked;
    pnlFrete: TPanel;
    lblVen: TLabel;
    edtNewTra: TEditFocus;
    edtNewDes: TEditFocus;
    pnlDados: TPanel;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label6: TLabel;
    lblCodVen: TLabel;
    lblCodRep: TLabel;
    edtCodCli: TEditFocus;
    edtDesCli: TEditFocus;
    edtDtaFat: TEditFocus;
    edtConPag: TEditFocus;
    edtCodVen: TEditFocus;
    edtDesVen: TEditFocus;
    edtCodRep: TEditFocus;
    edtDesRep: TEditFocus;
    pnlBusca: TPanel;
    GroupBox1: TGroupBox;
    Label5: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    edtNumDoc: TEditFocus;
    edtEspDoc: TEditFocus;
    edtCodEmp: TEditFocus;
    edtDesEmp: TEditFocus;
    Bevel1: TBevel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    edtNewFre: TEditFocus;
    edtBasIcm: TEditFocus;
    edtValIcm: TEditFocus;
    edtDesAce: TEditFocus;
    edtBasTri: TEditFocus;
    edtValTri: TEditFocus;
    edtValFre: TEditFocus;
    edtValPro: TEditFocus;
    edtBasIpi: TEditFocus;
    edtValIpi: TEditFocus;
    edtTotNf: TEditFocus;
    Label18: TLabel;
    edtCodTra: TEditFocus;
    edtDesTra: TEditFocus;
    Label19: TLabel;
    edtTraLot: TEditFocus;
    Label20: TLabel;
    edtNewLot: TEditFocus;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtNewTraKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure edtNewTraExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    AltValorFreteSugestao: IAltValorFreteSugestao;
    arrCodTra: TConsultasArray;
    arrEmp: TConsultasArray;

    procedure pLimpaTela;
    function fBuscaDocumento(strNumDoc, strEspDoc, strCodEmp: String): TRetornoBusca;
    function fDadosDoDocumentoPreenchidos: Boolean;
    function fDocumentoTravadoPelaBaixaEntregaFutura(strChave: String): Boolean;
  public
    { Public declarations }
    strNumDoc : String;
    strEspDoc : String;
    strCodEmp : String;
    tpOrigemAlteracaoFrete: TOrigemAlteracaoFrete;
    blnInformaFreteNaFreCot: Boolean;
    objLock: TLock;

    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
    procedure pEscapePressed; Override;
  end;

implementation

uses untFatAltValorFreteSugestaoDao, untConsultas, untConsulta,
  untFuncoesConsulta;

{$R *.dfm}

{ TfrmFatAltValorFreteSuges }

procedure TfrmFatAltValorFreteSuges.btnConfirmaClick(Sender: TObject);
  Var
    blnValidado: Boolean;
    strMsg: String;
begin
  inherited;

  blnValidado := fVerificaCampos;

  If blnValidado Then
  Begin
    If fEmptyStr(edtNewTra.Text) And (fStrToFloat(edtNewFre.Text) <= 0)  And fEmptyStr(edtNewLot.Text) Then
    Begin
      blnValidado := False;
      fMensagem('', 'Defina pelo menos um parâmetro para alteração!', ['&O k']);
    End
    Else If (Not fEmptyStr(edtNewTra.Text)) Or (fStrToFloat(edtNewFre.Text) <> 0) Then
    Begin
       blnValidado := blnValidado And fValidaCampos(edtNewTra);
       blnValidado := blnValidado And fValidaCampos(edtNewFre);
    End;
  End;

  If blnValidado Then
  Begin
    strMsg := '';

    If (Not fEmptyStr(edtNewTra.Text)) And (fStrToFloat(edtNewFre.Text) > 0) Then
    Begin
      AltValorFreteSugestao.strCodTraNew := edtNewTra.Text;
      AltValorFreteSugestao.fltValFreNew := fStrToFloat(edtNewFre.Text);

      If (AltValorFreteSugestao.strCodTraNew = AltValorFreteSugestao.strCodTra) And
         (AltValorFreteSugestao.fltValFreNew = AltValorFreteSugestao.fltValFreOld) Then
      Begin
        fMensagem('', 'Defina pelo menos a transportadora ou o valor de sugestão de frete diferente do atual ou deixe em branco para continuar esse procedimento!', ['&O k']);
        Exit;
      End;

      If blnInformaFreteNaFreCot Then
      Begin
        If TAltValorFreteSugestaoDao.fUpdateByValorFreteSugestaoPelaExpedicao(AltValorFreteSugestao) then
          strMsg := strMsg + 'do "Valor de Frete Sugestão", ';
      End
      Else
      Begin
        If TAltValorFreteSugestaoDao.fUpdateByValorFreteSugestao(AltValorFreteSugestao) then
          strMsg := strMsg + 'da "Transportadora", do "Valor de Frete Sugestão", ';
      End;
    End;

    If (Not fEmptyStr(edtNewLot.Text))  Then
    Begin
      AltValorFreteSugestao.strTraLotNew := edtNewLot.Text;

      If (AltValorFreteSugestao.strTraLotNew = AltValorFreteSugestao.strTraLot) Then
      Begin
        fMensagem('', 'Defina Número Lote diferente do atual ou deixe em branco para continuar esse procedimento!', ['&O k']);
        Exit;
      End;

      If TAltValorFreteSugestaoDao.fUpdateByLoteTransportadora(AltValorFreteSugestao) then
        strMsg := strMsg + 'do "Número Lote", ';
    End;

    If (Not fEmptyStr(strMsg)) Then
    Begin
      fMensagem('', 'Alteração ' +strMsg + 'no documento ' +AltValorFreteSugestao.strNumDoc + '-' + AltValorFreteSugestao.strEspDoc + ' realizada com sucesso!', ['&O k']);

      fLock_Unlock(AltValorFreteSugestao.strNomTab +
                   AltValorFreteSugestao.strNumDoc +
                   AltValorFreteSugestao.strEspDoc +
                   AltValorFreteSugestao.strCodEmp, False, False);

     AltValorFreteSugestao := Nil;

     pLimpaTela;

     If (fDadosDoDocumentoPreenchidos) Then
     Begin
      Close;
     End;
    End;
  End;

end;

function TfrmFatAltValorFreteSuges.fDadosDoDocumentoPreenchidos: Boolean;
begin
  Result := Not (fEmptyStr(strNumDoc) And fEmptyStr(strEspDoc) And fEmptyStr(strCodEmp));
end;

function TfrmFatAltValorFreteSuges.fDocumentoTravadoPelaBaixaEntregaFutura(strChave: String): Boolean;
begin
  Result := False;

  if (tpOrigemAlteracaoFrete = oafBaixaEntregaFutura) And (objLock.fLocalizaTrava(strChave)) Then
    Result := True;
end;

procedure TfrmFatAltValorFreteSuges.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtDesEmp, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmp) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatAltValorFreteSuges.edtNewTraExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtNewTra, edtNewDes, arrCodTra, fRetNomTransportadora, nil, 'da Transportadora');
  If edtNewDes.Text = 'TODOS' Then
    edtNewDes.Text := '';
end;

procedure TfrmFatAltValorFreteSuges.edtNewTraKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqTransportadora(conTraCompleta, Self, edtNewTra, edtNewDes, Nil, Key, arrCodTra, True) Then
  Begin
    If fValidaCampos(edtNewTra, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmFatAltValorFreteSuges.fBuscaDocumento(strNumDoc, strEspDoc,
  strCodEmp: String): TRetornoBusca;
begin
  Result := rbDocNaoEncontrado;

  AltValorFreteSugestao := TAltValorFreteSugestaoDao.fFindByDocumento(strNumDoc, strEspDoc, strCodEmp, blnInformaFreteNaFreCot);

  If AltValorFreteSugestao <> Nil Then
  Begin
    If (Not fDocumentoTravadoPelaBaixaEntregaFutura(AltValorFreteSugestao.strNomTab + edtNumDoc.Text + edtEspDoc.Text + edtCodEmp.Text)) And (Not fLock_Unlock(AltValorFreteSugestao.strNomTab + edtNumDoc.Text + edtEspDoc.Text + edtCodEmp.Text, True, False)) Then
    Begin
      Result := rbDocUsadoOutraEstacao;
      Exit;
    End;

    edtCodCli.Text := AltValorFreteSugestao.strCodCli;
    edtDesCli.Text := AltValorFreteSugestao.strNomCli;
    edtDtaFat.Text := FormatDateTime('dd/mm/yyyy', AltValorFreteSugestao.dtaDtEmis);
    edtConPag.Text := fFormataCondPag(AltValorFreteSugestao.strCndPgt);
    edtCodVen.Text := AltValorFreteSugestao.strCodVen;
    edtDesVen.Text := AltValorFreteSugestao.strNomVen;
    edtCodRep.Text := AltValorFreteSugestao.strCodRep;
    edtDesRep.Text := AltValorFreteSugestao.strNomRep;
    edtCodTra.Text := AltValorFreteSugestao.strCodTra;
    edtDesTra.Text := AltValorFreteSugestao.strNomTra;
    edtTraLot.Text := AltValorFreteSugestao.strTraLot;
    edtValPro.Text := FormatFloat('#,##0.00', AltValorFreteSugestao.fltValPro);
    edtBasIcm.Text := FormatFloat('#,##0.00', AltValorFreteSugestao.fltBasIcm);
    edtValIcm.Text := FormatFloat('#,##0.00', AltValorFreteSugestao.fltValIcm);
    edtDesAce.Text := FormatFloat('#,##0.00', AltValorFreteSugestao.fltDesAce);
    edtBasTri.Text := FormatFloat('#,##0.00', AltValorFreteSugestao.fltBasTri);
    edtValTri.Text := FormatFloat('#,##0.00', AltValorFreteSugestao.fltValTri);
    edtValFre.Text := FormatFloat('#,##0.00', AltValorFreteSugestao.fltValFre);
    edtBasIpi.Text := FormatFloat('#,##0.00', AltValorFreteSugestao.fltBasIpi);
    edtValIpi.Text := FormatFloat('#,##0.00', AltValorFreteSugestao.fltValIpi);
    edtTotNf.Text  := FormatFloat('#,##0.00', AltValorFreteSugestao.fltTotNf);

    edtNewFre.Text := FormatFloat('#,##0.00', AltValorFreteSugestao.fltValFreOld);
    edtNewTra.Text := AltValorFreteSugestao.strCodTra;
    edtNewDes.Text := AltValorFreteSugestao.strNomTra;
    edtNewLot.Text := AltValorFreteSugestao.strTraLot;

    btnConfirma.Enabled := True;
    pnlBusca.Enabled    := False;
    pnlFrete.Enabled    := True;

    Result := rbDocEncontrado;
  End;
end;

procedure TfrmFatAltValorFreteSuges.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(edtNumDoc);
  edtNewFre.EditFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));

  If (fDadosDoDocumentoPreenchidos) Then
  Begin
    edtNumDoc.Text := strNumDoc;
    edtEspDoc.Text := strEspDoc;
    edtCodEmp.Text := strCodEmp;

    pSetFocus(edtCodEmp);
    Keybd_event(VK_RETURN, 0, 0, 0);
  End;
end;

procedure TfrmFatAltValorFreteSuges.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If AltValorFreteSugestao <> Nil Then
  Begin
    fLock_Unlock(AltValorFreteSugestao.strNomTab + AltValorFreteSugestao.strNumDoc + AltValorFreteSugestao.strEspDoc +
                 AltValorFreteSugestao.strCodEmp, False, False);
    AltValorFreteSugestao := Nil;
  End;
end;

procedure TfrmFatAltValorFreteSuges.FormCreate(Sender: TObject);
begin
  inherited;
  strNumDoc := EmptyStr;
  strEspDoc := EmptyStr;
  strCodEmp := EmptyStr;
  blnInformaFreteNaFreCot := False;
  tpOrigemAlteracaoFrete := oafIndefinido;
  objLock := Nil;
end;

function TfrmFatAltValorFreteSuges.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    rbResultDoc: TRetornoBusca;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtNumDoc) Then
    Begin
      If fEmptyStr(edtNumDoc.Text) Then
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
      End
      Else
      Begin
        If Pos(edtEspDoc.Text, 'NF_EL_FF_') <= 0 Then
        Begin
          fMensagem('','Escolha a espécie entre NF, EL ou FF!',['&O K']);
          Result := False;
        End;
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

        Else If (Not pnlFrete.Enabled) Then
        Begin
          rbResultDoc := fBuscaDocumento(edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text);

          If rbResultDoc = rbDocNaoEncontrado Then
          Begin
            fMensagem('','Documento digitado não foi encontrado, verifique !',['&O K']);
            Result := False;
          End
          Else If rbResultDoc = rbDocUsadoOutraEstacao Then
          Begin
            fMensagem('', 'Esse Documento está sendo utilizado em Outra Estação por ' +
                          fGetHostLock(AltValorFreteSugestao.strNomTab + edtNumDoc.Text + edtEspDoc.Text + edtCodEmp.Text)  + '!', ['&Ok']);
            Result := False;
          End;
        End;
      End;
    End

    Else If (Sender = edtNewTra) Then
    Begin
      If fEmptyStr(edtNewTra.Text) Then
      Begin
        fMensagem('','Digite o código da transportadora !',['&O K']);
        Result := False;
      End
      Else
      Begin
        edtNewDes.Text := fRetNomTransportadora(edtNewTra.Text);

        If fEmptyStr(edtNewDes.Text) Then
        Begin
         fMensagem('','Transportadora digitada não foi encontrada, verifique !',['&O K']);
         Result := False;
        End;
      End;
    End

    Else If (Sender = edtNewFre) Then
    Begin
      If fEmptyStr(edtNewFre.Text) Then
      Begin
        fMensagem('','Defina um novo valor para sugestão de frete!',['&O K']);
        Result := False;
      End
      Else
      Begin
        If fStrToFloat(edtNewFre.Text) <= 0 Then
        Begin
          fMensagem('','O novo valor para sugestão de frete deve ser maior ou igual a zero!',['&O K']);
          Result := False;
        End;
      End;
    End;
  end;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmFatAltValorFreteSuges.pEscapePressed;
begin
  If ((ActiveControl) = edtCodEmp) Or
     ((ActiveControl) = edtEspDoc) Or
     ((ActiveControl) = edtNewFre) Or
     ((ActiveControl) = edtNewTra) Or
     ((ActiveControl) = edtNewLot) Then
    pLimpaTela
  Else if (ActiveControl) = edtNumDoc Then
    Close
  Else
    inherited;
end;

procedure TfrmFatAltValorFreteSuges.pLimpaTela;
  Var
    intIdx: Integer;
begin
  For intIdx := 0 To Self.ComponentCount - 1 Do
  Begin
    If Self.Components[intIdx] Is TEditFocus Then
      (Self.Components[intIdx] As TEditFocus).Clear;
  End;

  edtNewTra.Text := '';
  edtNewDes.Text := '';
  edtNewFre.Text := '';
  edtNewLot.Text := '';

  edtCodEmp.Text := VS_strCodEmp;
  edtDesEmp.Text := fRetNomeEmpresa;
  edtEspDoc.Text := '';

  btnConfirma.Enabled := False;
  pnlBusca.Enabled    := True;
  pnlFrete.Enabled := False;

  If AltValorFreteSugestao <> Nil Then
  Begin
    fLock_Unlock(AltValorFreteSugestao.strNomTab +
                 AltValorFreteSugestao.strNumDoc +
                 AltValorFreteSugestao.strEspDoc +
                 AltValorFreteSugestao.strCodEmp, False, False);
    AltValorFreteSugestao := Nil;
  End;
    
  pSetFocus(edtNumDoc);
end;

end.
