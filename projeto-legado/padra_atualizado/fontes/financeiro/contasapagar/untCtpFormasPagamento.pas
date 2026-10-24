unit untCtpFormasPagamento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, Menus, Buttons, ExtCtrls, EditFocus,  strUtils,
  AppEvnts, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade,
  System.Generics.Collections, untTypesSistema, Data.DB, UniClientDataSet,
  untBaixaCtaPagar,untTValidaCorrespondenteContabil;

type
  TfrmCtpFormasPagamento = class(TfrmPai)
    pnlTotal: TPanel;
    lblValTot: TLabel;
    pnlValDig: TPanel;
    lblValDig: TLabel;
    pnlFundo: TPanel;
    lblDinheiro: TLabel;
    lblChqVista: TLabel;
    edtDinheiro: TEditFocus;
    edtChqVista: TEditFocus;
    btnConfirmaDados: TBitBtnLocked;
    edtRepChq: TEditFocus;
    lblRepChq: TLabel;
    edtOrdPag: TEditFocus;
    lblOrdPag: TLabel;
    lblPorBaiDin: TLabel;
    edtPorBaiDin: TEditFocus;
    edtDesPorDin: TEditFocus;
    lblPorBaiChV: TLabel;
    edtPorBaiChV: TEditFocus;
    edtDesPorChV: TEditFocus;
    edtPorBaiOrd: TEditFocus;
    edtDesPorOrd: TEditFocus;
    edtPorBaiRep: TEditFocus;
    edtDesPorRep: TEditFocus;
    lblPorBaiOrd: TLabel;
    lblPorBaiRep: TLabel;
    lblValRes: TLabel;
    btnSelChAvi: TBitBtnLocked;
    btnAltValChqEmi: TBitBtnLocked;
    btnConfereCheques: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure edtPorBaiDinKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure btnSelChAviClick(Sender: TObject);
    procedure btnAltValChqEmiClick(Sender: TObject);
    procedure btnSelChAviEnter(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnConfereChequesClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    fltValDig: Double;
    fltValRes: Double;
    cdsChqEmi: TUniClientDataset;
    frmBaixaCtaPagar: TfrmBaixaCtaPagar;
    FValidaCorrespondenteContabil: TValidaCorrespondenteContabil;
    procedure pAtualizaValDig;
    procedure pConfereCheques;

    function fEmissaoCheques(strCodPor: String): Boolean;
    function fRepasseCheques: Boolean;
    function fValidaValorMod(fltValor: Double; strModalidade: String): Boolean;
    function fComparaValoresChqEmi:Boolean;
    function fCriaCdsChqEmi(AOwner: TComponent): TUniClientDataset;
    function fChqRepasseComDivergenciaNoValor(FValRep: String) : Boolean;

    function RetornaFornecedorSelecionado: String;
    { Private declarations }
  public
    { Public declarations }
    fltValTot: Double;
    fltDinhei: Double;
    fltChqEmi: Double;
    fltOrdPag: Double;
    fltRepChq: Double;
    strTabTp2: String;
    strTabTmp: String;
    strCodCnd: String;
    strMskCnd: String;
    strForRep: String;
    strObsRep: String;
    strDtaLan: String;
    dicChqEmi: TDictionary<String,TChequeEmitido>;
    dicChqRep: TDictionary<String,TChequeRepassado>;
    cdsCloneCtaPag: TUniClientDataSet;
    lstFornecedor : TStringList;
    strCodPorFix: String;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;


implementation

uses untfuncoesSimples, untBaixaChequesRepasse, untConsultas,
  untEmissaoCheques, untConfChequesEmitidos;

{$R *.dfm}

procedure TfrmCtpFormasPagamento.FormActivate(Sender: TObject);
begin
  inherited;

  If fltValTot < 0 Then
  Begin
    edtDinheiro.Enabled       := True;
    edtChqVista.Enabled       := False;
    edtOrdPag.Enabled         := False;
    btnConfereCheques.Enabled := False;
    //edtRepChq.Enabled  := False;
    btnSelChAvi.Enabled := False;
  End;

  {*************************************}
  {* TRAVA REPASSE PARA PGTO FUTURO    *}
  {**********************************LE*}
  btnSelChAvi.Enabled := Not(StrToDate(strDtaLan) > VS_DATE);
  If Not btnSelChAvi.Enabled Then
      pnlInfo.Caption    :=  'Não é possivel utilizar repasse de cheques para pagamentos futuro.';

  if edtPorBaiDin.CanFocus Then
    pSetFocus(edtPorBaiDin)
  else
    pSetFocus(edtDinheiro);

end;

procedure TfrmCtpFormasPagamento.FormCreate(Sender: TObject);
begin
  inherited;
  lstfornecedor := TStringList.Create;
  strCodPorFix  := '';
  FValidaCorrespondenteContabil :=  TValidaCorrespondenteContabil.Create;
end;

procedure TfrmCtpFormasPagamento.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FValidaCorrespondenteContabil)
end;

procedure TfrmCtpFormasPagamento.FormShow(Sender: TObject);
begin
  inherited;

  lblValTot.Caption := 'Valor Total: ' + FloatToStrF(fltValTot,ffFixed,12,2);
  lblValRes.Caption := 'Valor Restante: ' + FloatToStrF(fltValTot,ffFixed,12,2);
  lblValDig.Caption := 'Valor Digitado: 0,00';

  edtDinheiro.Text := '0,00';
  edtChqVista.Text := '0,00';
  edtOrdPag.Text   := '0,00';
  edtRepChq.Text   := '0,00';

  edtDinheiro.SelectAll;
end;

{************************************}
{* ATUALIZA VARIAVEIS E LABEL       *}
{*********************************AF*}
procedure TfrmCtpFormasPagamento.pAtualizaValDig;

  procedure pChecaText(objT : TEditFocus);
  Begin
    If not objT.Enabled Then
      objT.Clear;

  End;

Begin
  fltDinhei := 0;
  fltChqEmi := 0;
  fltOrdPag := 0;
  fltRepChq := 0;

  If Not fEmptyStr(edtDinheiro.Text) Then
    fltDinhei := fStrToFloat(edtDinheiro.Text);

  If Not fEmptyStr(edtChqVista.Text) Then
    fltChqEmi := fStrToFloat(edtChqVista.Text);

  If (edtOrdPag.Visible)             And
     Not (fEmptyStr(edtOrdPag.Text)) Then
    fltOrdPag := fStrToFloat(edtOrdPag.Text);

  If (edtRepChq.Visible)             And
     Not (fEmptyStr(edtRepChq.Text)) Then
    fltRepChq := fStrToFloat(edtRepChq.Text);

  fltValDig := fltDinhei + fltChqEmi + fltOrdPag + fltRepChq;
  fltValRes := fltValTot - fltValDig;

  lblValDig.Caption := 'Valor Digitado: ' + FloatToStrF(fltValDig,ffFixed,12,2);
  lblValREs.Caption := 'Valor Restante: ' + FloatToStrF(fltValRes,ffFixed,12,2);

  edtDinheiro.Enabled       := (Not fEmptyStr(edtPorBaiDin.Text));
  edtChqVista.Enabled       := (Not fEmptyStr(edtPorBaiChv.Text));

  btnConfereCheques.Enabled := (Not fEmptyStr(edtPorBaiChv.Text));
  edtOrdPag.Enabled         := (Not fEmptyStr(edtPorBaiOrd.Text));

  edtDesPorDin.Enabled := (Not fEmptyStr(edtPorBaiDin.Text));
  edtDesPorChV.Enabled := (Not fEmptyStr(edtPorBaiChV.Text));
  edtDesPorOrd.Enabled := (Not fEmptyStr(edtPorBaiOrd.Text));
  edtDesPorRep.Enabled := (Not fEmptyStr(edtPorBaiRep.Text));

  pChecaText(edtDinheiro);
  pChecaText(edtDesPorDin);

  pChecaText(edtChqVista);
  pChecaText(edtDesPorChV);

  pChecaText(edtOrdPag);
  pChecaText(edtDesPorOrd);

  pChecaText(edtPorBaiRep);
  pChecaText(edtDesPorRep);

  If fEmptyStr(edtDinheiro.Text) Then
    edtDinheiro.Text := '0,00';

  If fEmptyStr(edtChqVista.Text) Then
    edtChqVista.Text := '0,00';

  If fEmptyStr(edtOrdPag.Text) Then
    edtOrdPag.Text :=  '0,00';

End;

function TfrmCtpFormasPagamento.fChqRepasseComDivergenciaNoValor(FValRep: String): Boolean;
  Var
    FChave  : String;
    AValTotalChqRep: Double;
begin
  AValTotalChqRep := 0;

  For FChave In dicChqRep.Keys Do
  Begin
    AValTotalChqRep := AValTotalChqRep + dicChqRep[FChave].fltValChq;
  End;

  Result := fFormataFloat(AValTotalChqRep,2) <> fFormataFloat(fStrToFloat(FValRep),2);

  If Result Then
  Begin
    fMensagem('ATENÇÃO','Valor total dos cheques selecionados está com divergência. Por Favor, Reinicie a operação!',['&OK']);
  End;

end;

function TfrmCtpFormasPagamento.fComparaValoresChqEmi: Boolean;
  Var
    fltTotChqEmi: Double;
    strChave    : String;
begin

  fltTotChqEmi := 0;

  For strChave In dicChqEmi.Keys Do
  Begin
    fltTotChqEmi := fltTotChqEmi + dicChqEmi[strChave].fltValChq;
  End;

  Result := fFormataFloat(fltTotChqEmi, 2) = fFormataFloat(fStrToFloat(edtChqVista.Text), 2);

end;

function TfrmCtpFormasPagamento.fEmissaoCheques(strCodPor: String): Boolean;
begin
  Try
    pCriarFormularios(TfrmEmissaoCheques, frmEmissaoCheques);
    frmEmissaoCheques.fltTotGer := fStrToFloat(edtChqVista.Text);
    frmEmissaoCheques.dicChqEmi := dicChqEmi;
    frmEmissaoCheques.pCarregaUltimoChequeEmitido(strCodPor, VS_strCodEmp);
    frmEmissaoCheques.ShowModal;
    Result := frmEmissaoCheques.blnConfirma;
  Finally
    pFreeAndNil(frmEmissaoCheques);
  End;
end;

function TfrmCtpFormasPagamento.fRepasseCheques: Boolean;
  Var
    strChave: String;
    frmBaixaChequesRepasse : TfrmBaixaChequesRepasse;
begin

  Try
    If (Assigned(dicChqRep)) And (dicChqRep.Count > 0) Then
    Begin
      For strChave In dicChqRep.Keys Do
        fLock_Unlock('CADCHQ' + dicChqRep[strChave].strAutInc, False);
      dicChqRep.Clear;
    End;

    pCriarFormularios(TfrmBaixaChequesRepasse, frmBaixaChequesRepasse);
    frmBaixaChequesRepasse.blnBaiCtp := True;
    frmBaixaChequesRepasse.strDtaLan := strDtaLan;
    frmBaixaChequesRepasse.fltTotRep := fltValTot - fltDinhei - fltChqEmi - fltOrdPag;
    frmBaixaChequesRepasse.dicRepChq := dicChqRep;
    frmBaixaChequesRepasse.cdsCloneCtaPag := cdsCloneCtaPag;
    frmBaixaChequesRepasse.pnlTitulos.Visible := True;
    frmBaixaChequesRepasse.pnlModalidades.Visible := True;
    frmBaixaChequesRepasse.edtDinheiro.Text := edtDinheiro.Text;
    frmBaixaChequesRepasse.edtChqVista.Text := edtChqVista.Text;
    frmBaixaChequesRepasse.edtOrdPag.Text := edtOrdPag.Text;
    frmBaixaChequesRepasse.bnExiRel := True;
//    frmBaixaChequesRepasse.lstFornecedor := lstFornecedor;

    frmBaixaChequesRepasse.strForRep := RetornaFornecedorSelecionado;

    frmBaixaChequesRepasse.ShowModal;

    If (frmBaixaChequesRepasse.ModalResult = mrOk) And
       Not fChqRepasseComDivergenciaNoValor(frmBaixaChequesRepasse.edtTotalSelecionado.Text) Then
    Begin
      edtRepChq.Text := frmBaixaChequesRepasse.edtTotalSelecionado.Text;
      strForRep := frmBaixaChequesRepasse.strForRep;
      strObsRep := frmBaixaChequesRepasse.strObsRep;

      Result := True;
      pSetFocus(edtPorBaiRep);
      edtPorBaiRep.ReadOnly := False;
    End
    Else
    Begin
      If (Assigned(dicChqRep)) And (dicChqRep.Count > 0) Then
      Begin
        For strChave In dicChqRep.Keys Do
          fLock_Unlock('CADCHQ' + dicChqRep[strChave].strAutInc, False);
      End;

      edtRepChq.Text := '0,00';
      dicChqRep.Clear;
      Result := False;
    End;

    pFreeAndNil(frmBaixaChequesRepasse);
  Except
    On E: Exception Do
    Begin
      If Assigned(frmBaixaChequesRepasse) Then
        pFreeAndNil(frmBaixaChequesRepasse);
      Raise Exception.Create(E.Message);
    End;
  End;

end;

procedure TfrmCtpFormasPagamento.btnConfereChequesClick(Sender: TObject);
begin
  inherited;

  pConfereCheques;

end;

procedure TfrmCtpFormasPagamento.btnAltValChqEmiClick(Sender: TObject);
begin
  inherited;
  If fMensagem('', 'Alterar registros de cheques emitidos?', ['&Sim','&Não'], 2) = 1 Then
  Begin
    edtChqVista.ReadOnly := False;
    pSetFocus(edtChqVista);
  End;
end;

procedure TfrmCtpFormasPagamento.btnConfirmaDadosClick(Sender: TObject);
begin

  If Not fVerificaCampos Then
    Exit;

  inherited;

  pAtualizaValDig;


  if strCodPorFix <> '' then
  begin
    if (not fEmptyStr(edtPorBaiDin.Text)) and (strCodPorFix <> edtPorBaiDin.Text) then
    begin
      fMensagem('','Baixa com portador fixo: ' + #13#13 + strCodPorFix + '-' + fRetNomPortador(strCodPorFix)  ,['&OK']);
      pSetFocus(edtPorBaiDin);
      Exit;
    end;

    if (not fEmptyStr(edtPorBaiChV.Text)) and (strCodPorFix <> edtPorBaiChV.Text) then
    begin
      fMensagem('','Baixa com portador fixo: ' + #13#13 + strCodPorFix + '-' + fRetNomPortador(strCodPorFix)  ,['&OK']);
      pSetFocus(edtPorBaiChV);
      Exit;
    end;

    if (not fEmptyStr(edtPorBaiOrd.Text)) and (strCodPorFix <> edtPorBaiOrd.Text) then
    begin
      fMensagem('','Baixa com portador fixo: ' + #13#13 + strCodPorFix + '-' + fRetNomPortador(strCodPorFix)  ,['&OK']);
      pSetFocus(edtPorBaiOrd);
      Exit;
    end;

    if (not fEmptyStr(edtPorBaiRep.Text)) and (strCodPorFix <> edtPorBaiRep.Text) then
    begin
      fMensagem('','Baixa com portador fixo: ' + #13#13 + strCodPorFix + '-' + fRetNomPortador(strCodPorFix)  ,['&OK']);
      pSetFocus(edtPorBaiRep);
      Exit;
    end;
  end;

  If fFormataFloat(fltValTot, 2) <> fFormataFloat(fltValDig, 2) Then
  Begin
    fMensagem('','Valor total não confere com o valor digitado!',['&OK']);
    pSetFocus(edtDinheiro);
  End
  Else
  Begin
    Close;
    ModalResult := mrOk;
  End;

end;

procedure TfrmCtpFormasPagamento.btnSairClick(Sender: TObject);
begin

  ModalResult := mrCancel;
  inherited;

end;

procedure TfrmCtpFormasPagamento.btnSelChAviClick(Sender: TObject);
begin
  inherited;

  pAtualizaValDig;

  If (Not fEmptyStr(edtPorBaiRep.Text)) Then
    fRepasseCheques;

  pAtualizaValDig;

  If (edtRepChq.Text <> '0,00') Then
  Begin
    Self.SelectNext(ActiveControl, True, True);
    Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCtpFormasPagamento.btnSelChAviEnter(Sender: TObject);
begin
  inherited;
  //Habilita/Desabilita o botão de repasse cheques
  If (fEmptyStr(edtPorBaiRep.Text)) Then
    btnSelChAvi.Enabled := False
  Else
    btnSelChAvi.Enabled := True;

end;

procedure TfrmCtpFormasPagamento.edtPorBaiDinKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;

begin
  inherited;

  If fPesqPortador(conSimples, Self, TEditFocus(Sender), TEditFocus(pnlFundo.FindChildControl('edtDesPor' + RightStr(TEditFocus(Sender).Name,3))), nil, Key, arrSel) Then
  Begin
    If (fValidaCampos(TEditFocus(Sender))) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

  //Habilita/Desabilita o botão de repasse cheques
  If (fEmptyStr(edtPorBaiRep.Text)) Then
    btnSelChAvi.Enabled := False
  Else
    btnSelChAvi.Enabled := True;


end;

function TfrmCtpFormasPagamento.fValidaValorMod(fltValor: Double; strModalidade: String): Boolean;
Begin

  Result := True;
  If fltValor > fltValTot Then
  Begin
    fMensagem('','O valor da modalidade ' + strModalidade + ' não pode ser maior que o valor total!',['&OK']);
    Result := False;
  End;

End;

function TfrmCtpFormasPagamento.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    blnShowCheque : Boolean;
begin

  Result := True;

  {************************************}
  {* VALIDA DINHEIRO                  *}
  {*********************************MV*}

  If (Sender = edtDinheiro) Then
  Begin

    If (fEmptyStr(edtDinheiro.Text)) Then
      edtDinheiro.Text := '0,00'
    Else
    If fStrToFloat(edtDinheiro.Text) <> 0 Then
      Result := fValidaValorMod(fStrToFloat(edtDinheiro.Text), 'dinheiro');

    If Not (fEmptyStr(edtPorBaiDin.Text)) And  (edtDinheiro.Text = '0,00') Then
    Begin
      fMensagem('', 'O valor do dinheiro deve ser preenchido!', ['&OK']);
      Result := False;
    End;

    If Result Then
      pAtualizaValDig;

  End

  {************************************}
  {* VALIDA CHEQUE A VISTA            *}
  {*********************************MV*}
  Else If (Sender = edtChqVista) And (edtChqVista.Enabled) Then
  Begin

    If (fEmptyStr(edtChqVista.Text)) Or (fStrToFloat(edtChqVista.Text) = 0) Then
    Begin
      edtChqVista.Text := '0,00';
      fMensagem('', 'O valor do cheque emitido deve ser preenchido!', ['&OK']);
      Result := False;
      Exit;
    End
    Else
    If fStrToFloat(edtChqVista.Text) <> 0 Then
      Result := fValidaValorMod(fStrToFloat(edtChqVista.Text), 'cheque emitido');

    if not Result Then
      Exit;
    blnShowCheque := False;
    If (Not fEmptyStr(edtPorBaiChV.Text)) And (edtChqVista.Text <> '0,00') And (dicChqEmi.Count = 0) And (Result) Then
    Begin
      Result := fEmissaoCheques(edtPorBaiChV.Text);
      blnShowCheque := True;
    End;

    If Result Then
      Result := fComparaValoresChqEmi;

    If (Not Result) Then
    Begin
      dicChqEmi.Clear;
      If Not blnShowCheque Then
        Result := fEmissaoCheques(edtPorBaiChV.Text);
    End;

    If Result Then
    Begin
      pAtualizaValDig;
//      If Not edtChqVista.Enabled Then
//      Begin
//        blnMudarFoco := False;
//        Sender := FindNextControl(edtChqVista, True, True, False);
//          pSetFocus(Sender);
//      End;

      edtChqVista.ReadOnly      := True;
      btnAltValChqEmi.Enabled   := True;
      btnConfereCheques.Enabled := True;
    End
    Else
    Begin
      fMensagem('', 'Houve uma divergência no valor de cheque emitido informado, corrija!', ['&OK']);
      Exit;
    End;
  End

  {************************************}
  {* VALIDA ORDEM DE PAGAMENTO        *}
  {*********************************JU*}
  Else If (Sender = edtOrdPag) Then
  Begin

    If (fEmptyStr(edtOrdPag.Text)) Then
      edtOrdPag.Text := '0,00'

    Else If fStrToFloat(edtOrdPag.Text) <> 0 Then
      Result := fValidaValorMod(fStrToFloat(edtOrdPag.Text), 'depósito bancário');

    If Not (fEmptyStr(edtPorBaiOrd.Text)) And (edtOrdPag.Text = '0,00') Then
    Begin
      fMensagem('', 'O valor do depósito bancário deve ser preenchido!', ['&OK']);
      Result := False;
    End;

    If Result Then
      pAtualizaValDig;

  End

  {************************************}
  {* VALIDA REPASSE DE CHEQUE         *}
  {*********************************MV*}
  Else If (Sender = edtRepChq) Then
  Begin

    If (fEmptyStr(edtRepChq.Text)) Then
      edtRepChq.Text := '0,00'

    Else If fStrToFloat(edtRepChq.Text) <> 0 Then
      Result := fValidaValorMod(fStrToFloat(edtRepChq.Text), 'cheque de terceiros');

  End

  Else
  If Sender = edtPorBaiDin Then
  Begin
    If fEmptyStr(edtPorBaiDin.Text) And (edtDinheiro.Text <> '0,00') Then
    Begin
      fMensagem('','Informe o Portador!', ['&OK']);
      Result := False;
    End
    Else If Not fEmptyStr(edtPorBaiDin.Text) Then
    Begin
      edtDesPorDin.Text := fRetNomPortador(edtPorBaiDin.Text);

      If fEmptyStr(edtDesPorDin.Text) Then
      Begin
        fMensagem('','Portador não Cadastrado!', ['&OK']);
        Result := False;
      End
      Else If Not fPortadorPermiteBaixa(edtPorBaiDin.Text) Then
      Begin
        fMensagem('', 'Esse portador não tem permissão para realizar baixa!', ['&OK']);
        Result := False;
      End

      Else If Not FValidaCorrespondenteContabil.PortadorPossuiCorrespondenteContabil(edtPorBaiDin.Text,VS_strCodEmp) Then
      Begin
        Result := False;
      End

      Else If Not fEmpresaTemAcessoPortador(edtPorBaiDin.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
        Result := False;
      End

      Else If fCfgSis('DACPOR', varBoolean) Then
      Begin
        If Pos(edtPorBaiDin.Text, strPortadoresOperador) <= 0 Then
        Begin
          fMensagem('', 'Usuário sem permissão de acesso aos lançamentos para este portador!', ['&OK']);
          Result := False;
        End;
      End;
    End;
    pAtualizaValDig;
  End

  Else
  If Sender = edtPorBaiChV Then
  Begin

    If (Not fEmptyStr(edtPorBaiChV.Text)) Then
    Begin
      cdsCloneCtaPag.First;
      While not cdsCloneCtaPag.Eof Do
      Begin
        If frmBaixaCtaPagar.fVerificaDupChqEmi(
          cdsCloneCtaPag.FieldByName('CTP_CODFOR').AsString,
          cdsCloneCtaPag.FieldByName('NRODUP').AsString,
          cdsCloneCtaPag.FieldByName('PARDUP').AsString,
          cdsCloneCtaPag.FieldByName('CTP_CODEMP').AsString,
          cdsCloneCtaPag.FieldByName('CTP_SERIE_').AsString) Then
        Begin
          edtPorBaiChV.Text := '';
          fMensagem('', 'Utilize Outra Forma de Pagamento', ['&OK']);
          Result := False;
          Exit;
        End;
        cdsCloneCtaPag.Next;
      End;
    End;

    If (Not fEmptyStr(edtPorBaiChV.Text)) Then
    Begin
      edtDesPorChV.Text := fRetNomPortador(edtPorBaiChV.Text);

      If fEmptyStr(edtDesPorChV.Text) Then
      Begin
        fMensagem('','Portador não Cadastrado!', ['&OK']);
        Result := False;
      End
      Else If Not fPortadorPermiteBaixa(edtPorBaiChV.Text) Then
      Begin
        fMensagem('', 'Esse portador não tem permissão para realizar baixa!', ['&OK']);
        Result := False;
      End

      Else If Not FValidaCorrespondenteContabil.PortadorPossuiCorrespondenteContabil(edtPorBaiChV.Text,VS_strCodEmp) Then
      Begin
        Result := False;
      End

      Else If Not fEmpresaTemAcessoPortador(edtPorBaiChV.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
        Result := False;
      End

      Else If fCfgSis('DACPOR', varBoolean) And (Pos(edtPorBaiChV.Text, strPortadoresOperador) <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso aos lançamentos para este portador!', ['&OK']);
        Result := False;
      End
      Else
        pAtualizaValDig;
    End
    Else
    Begin
      edtChqVista.Text := '0,00';
      dicChqEmi.Clear;
      edtDesPorChV.Text := '';
      pAtualizaValDig;
    End;
  End

  Else
  If Sender = edtPorBaiOrd Then
  Begin

    If fEmptyStr(edtPorBaiOrd.Text) And (edtOrdPag.Text <> '0,00') Then
    Begin
      fMensagem('','Informe o Portador!', ['&OK']);
      Result := False;
    End
    Else If Not fEmptyStr(edtPorBaiOrd.Text) Then
    Begin
      edtDesPorOrd.Text := fRetNomPortador(edtPorBaiOrd.Text);

      If fEmptyStr(edtDesPorOrd.Text) Then
      Begin
        fMensagem('','Portador não Cadastrado!', ['&OK']);
        Result := False;
      End
      Else If Not fPortadorPermiteBaixa(edtPorBaiOrd.Text) Then
      Begin
        fMensagem('', 'Esse portador não tem permissão para realizar baixa!', ['&OK']);
        Result := False;
      End

      Else If Not FValidaCorrespondenteContabil.PortadorPossuiCorrespondenteContabil(edtPorBaiOrd.Text,VS_strCodEmp) Then
      Begin
        Result := False;
      End

      Else If Not fEmpresaTemAcessoPortador(edtPorBaiOrd.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
        Result := False;
      End

      Else If fCfgSis('DACPOR', varBoolean) Then
      Begin
        If Pos(edtPorBaiOrd.Text, strPortadoresOperador) <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso aos lançamentos para este portador!', ['&OK']);
          Result := False;
        End;
      End;
    End;

    pAtualizaValDig;
  End

  Else
  If Sender = edtPorBaiRep Then
  Begin
    //Habilita/Desabilita o botão de repasse cheques
    If (fEmptyStr(edtPorBaiRep.Text)) Then
      btnSelChAvi.Enabled := False
    Else
      btnSelChAvi.Enabled := True;

    If fEmptyStr(edtPorBaiRep.Text) And (edtRepChq.Text <> '0,00')Then
    Begin
      fMensagem('','Informe o Portador!', ['&OK']);
      Result := False;
    End
    Else If Not fEmptyStr(edtPorBaiRep.Text) Then
    Begin

      edtDesPorRep.Text := fRetNomPortador(edtPorBaiRep.Text);

      If fEmptyStr(edtDesPorRep.Text) Then
      Begin
        fMensagem('','Portador não Cadastrado!', ['&OK']);
        Result := False;
      End
      Else If Not fPortadorPermiteBaixa(edtPorBaiRep.Text) Then
      Begin
        fMensagem('', 'Esse portador não tem permissão para realizar baixa!', ['&OK']);
        Result := False;
      End

      Else If Not FValidaCorrespondenteContabil.PortadorPossuiCorrespondenteContabil(edtPorBaiRep.Text,VS_strCodEmp) Then
      Begin
        Result := False;
      End

      Else If Not fEmpresaTemAcessoPortador(edtPorBaiRep.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
        Result := False;
      End

      Else If fCfgSis('DACPOR', varBoolean) Then
      Begin
        If Pos(edtPorBaiRep.Text, strPortadoresOperador) <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso aos lançamentos para este portador!', ['&OK']);
          Result := False;
        End;
      End;
    End;
     pAtualizaValDig;
  End;

  If Not Result Then
    pSetFocus(Sender);

end;

function TfrmCtpFormasPagamento.fCriaCdsChqEmi(AOwner: TComponent): TUniClientDataset;
begin
  Result := TUniClientDataSet.Create(AOwner);

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CODBCO';
    DataType := ftString;
    Size     := 3;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'NUMAGE';
    DataType := ftString;
    Size     := 5;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CONCOR';
    DataType := ftString;
    Size     := 12;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'NUMCHQ';
    DataType := ftString;
    Size     := 10;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'VALCHQ';
    DataType := ftFloat;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'DTAEMI';
    DataType := ftDate;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'BOMPAR';
    DataType := ftDate;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'FAVORE';
    DataType := ftString;
    Size     := 60;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CHQPRE';
    DataType := ftString;
    Size     := 1;
    Required := False;
  End;

  Result.CreateDataSet;
  Result.Open;
end;

procedure TfrmCtpFormasPagamento.pConfereCheques;
  Var
    objChqEmi: TChequeEmitido;

  procedure pInsereCdsChqEmi;
    Var
      strChave: String;
  Begin
    For strChave In dicChqEmi.Keys Do
    Begin
      cdsChqEmi.Append;

      cdsChqEmi.FieldByName('CODBCO').AsString  := dicChqEmi[strChave].strCodBco;
      cdsChqEmi.FieldByName('NUMAGE').AsString  := dicChqEmi[strChave].strNumAge;
      cdsChqEmi.FieldByName('CONCOR').AsString  := dicChqEmi[strChave].strConCor;
      cdsChqEmi.FieldByName('NUMCHQ').AsString  := dicChqEmi[strChave].strNumChq;
      cdsChqEmi.FieldByName('DTAEMI').AsDateTime:= StrToDate(dicChqEmi[strChave].strDtaEmi);

      If Not fEmptyStr(dicChqEmi[strChave].strDtaBom) Then
      cdsChqEmi.FieldByName('BOMPAR').AsDateTime:= StrToDate(dicChqEmi[strChave].strDtaBom);

      cdsChqEmi.FieldByName('FAVORE').AsString  := dicChqEmi[strChave].strFavore;
      cdsChqEmi.FieldByName('CHQPRE').AsString  := IIF(dicChqEmi[strChave].blnChqVis, 'N', 'S');
      cdsChqEmi.FieldByName('VALCHQ').AsFloat   := dicChqEmi[strChave].fltValChq;

      cdsChqEmi.Post;
    End;
  End;

  procedure pAjustaDicChqEmi;
  Begin

    cdsChqEmi.First;

    While Not cdsChqEmi.Eof Do
    Begin

      If cdsChqEmi.FieldByName('VALCHQ').AsFloat > 0 Then
      Begin
        objChqEmi.strCodBco := cdsChqEmi.FieldByName('CODBCO').AsString;
        objChqEmi.strNumAge := cdsChqEmi.FieldByName('NUMAGE').AsString;
        objChqEmi.strConCor := cdsChqEmi.FieldByName('CONCOR').AsString;
        objChqEmi.strNumChq := cdsChqEmi.FieldByName('NUMCHQ').AsString;
        objChqEmi.strDtaEmi := FormatDateTime('dd/mm/yyyy', cdsChqEmi.FieldByName('DTAEMI').AsDateTime);

        If Not fEmptyStr(cdsChqEmi.FieldByName('BOMPAR').AsString) Then
          objChqEmi.strDtaBom := FormatDateTime('dd/mm/yyyy', cdsChqEmi.FieldByName('BOMPAR').AsDateTime)
        Else
          objChqEmi.strDtaBom := '';

        objChqEmi.strFavore := cdsChqEmi.FieldByName('FAVORE').AsString;
        objChqEmi.fltValChq := cdsChqEmi.FieldByName('VALCHQ').AsFloat;
        objChqEmi.blnChqVis := cdsChqEmi.FieldByName('CHQPRE').AsString = 'N';

        dicChqEmi.AddOrSetValue(cdsChqEmi.FieldByName('CODBCO').AsString+
                                cdsChqEmi.FieldByName('NUMAGE').AsString+
                                cdsChqEmi.FieldByName('CONCOR').AsString+
                                cdsChqEmi.FieldByName('NUMCHQ').AsString,
                                objChqEmi);
      End;

      cdsChqEmi.Next;

    End;

  End;

begin
  Try

    cdsChqEmi := fCriaCdsChqEmi(Self);

    With cdsChqEmi Do
    Begin
      (FieldByName('VALCHQ') As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('DTAEMI') As TDateField).DisplayFormat  := 'dd/mm/yyyy';
      (FieldByName('BOMPAR') As TDateField).DisplayFormat  := 'dd/mm/yyyy';
    End;

    pInsereCdsChqEmi;

    cdsChqEmi.IndexFieldNames := 'CODBCO;NUMAGE;CONCOR;NUMCHQ';

    pCriarFormularios(TfrmConfChequesEmitidos, frmConfChequesEmitidos);
    frmConfChequesEmitidos.fltValTot := fStrToFloat(edtChqVista.Text);
    frmConfChequesEmitidos.cdsChqEmi.Data := cdsChqEmi.Data;
    frmConfChequesEmitidos.ShowModal;

    if frmConfChequesEmitidos.blConfirma Then
    Begin
      cdsChqEmi.Data := frmConfChequesEmitidos.cdsChqEmi.Data;
      pAjustaDicChqEmi;
    End;


    FreeAndNil(frmConfChequesEmitidos);

  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;

  End;
end;


function TfrmCtpFormasPagamento.RetornaFornecedorSelecionado: String;
  Var
    LFiltroAnterior: String;
begin
  Try
    LFiltroAnterior := cdsCloneCtaPag.Filter;

    cdsCloneCtaPag.Filter   := 'CTP_MARDES = '+ QuotedStr('M');
    cdsCloneCtaPag.Filtered := True;

    cdsCloneCtaPag.First;
    Result := cdsCloneCtaPag.FieldByName('CTP_CODFOR').AsString;

    While Not cdsCloneCtaPag.Eof Do
    Begin
      If Result <> cdsCloneCtaPag.FieldByName('CTP_CODFOR').AsString Then
      Begin
        Result := EmptyStr;
        Break;
      End;

      cdsCloneCtaPag.Next;
    End;
  Finally
    cdsCloneCtaPag.Filter   := LFiltroAnterior;
    cdsCloneCtaPag.Filtered := Not LFiltroAnterior.IsEmpty;
    cdsCloneCtaPag.First;
  End;
end;

end.

