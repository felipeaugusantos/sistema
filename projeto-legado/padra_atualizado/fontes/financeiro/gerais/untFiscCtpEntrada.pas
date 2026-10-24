unit untFiscCtpEntrada;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, EditFocus, Mask, MaskEditFocus, AppEvnts, Menus,
  Buttons, ExtCtrls, Uni, BitBtnLockedIncrem, frxClass, untTypesSistema,
  frxExportCSVTestabilidade, untPortadorFornecedor, untFrameCentroCustoEditFocus,
  untFrameCtaPagar, ContaPagar.TFrameCtaPagar, Vcl.DBCtrls, ComboBoxFocus,
  QColorLabel, System.StrUtils,UniClientDataSet,untCadPag;

type
  TfrmFiscCtpEntrada = class(TfrmPai)
    btnConfirmaDados: TBitBtnLocked;
    LabeledEdit1: TLabeledEdit;
    fraCtaPagar: TfraCtaPagar;
    pnlDetalhe: TPanel;
    lblCndPag: TLabel;
    edtCodCnd: TEditFocus;
    mskCndPag: TMaskEditFocus;
    Label31: TLabel;
    edtCodPor: TEditFocus;
    edtNomPor: TEditFocus;
    btnDesmembr: TBitBtnLocked;
    procedure edtCodCndKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure fraCtaPagaredtCodCtaKeyPress(Sender: TObject; var Key: Char);
    procedure fraCtaPagaredtCodEveKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure fraCtaPagaredtTipDocEnter(Sender: TObject);
    procedure fraCtaPagaredtTipDocExit(Sender: TObject);
    procedure btnDesmembrClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure fraCtaPagaredtDeposiExit(Sender: TObject);
    procedure fraCtaPagarcbxBcoForChange(Sender: TObject);
  private
    { Private declarations }

    qryConCnd : TUniQuery;
    qryCadCta : TUniQuery;
    FCodFor   : String;
    FCodEmp   : String;
    FDatCad   : String;
    FMemHis   : String;
    FCodCta   : String;
    FValOri   : Double;//Valor original
    FValDup   : Double;//Valor duplicata
    FlstForPix : TStringList;
    strCtaAnt : String;
    FDtaDoc   : String;

    objFrameCtaPagar: TFrameContaPagar;

    FDatasetCtpDet: TUniClientDataSet;

    procedure pCarregaCondicao;
    procedure pCarregaDadosBancariosFornecedor(strCodFor: String; ABlnIncluirChavesPix: Boolean = False);
    function fGetAutIncPix: String;
  public
    { Public declarations }
    strCndPagDig: String;
    strAutIncPix: String;

    property strCodFor: String read FCodFor write FCodFor;
    property strCodEmp: String read FCodEmp write FCodEmp;
    property strDatCad: String read FDatCad write FDatCad;
    property strMemHis: String read FMemHis write FMemHis;
    property strCodCta: String read FCodCta write FCodCta;
    property fltValOri: Double read FValOri write FValOri;
    property fltValDup: Double read FValDup write FValDup;
    property strDtaDoc: String read FDtaDoc write FDtaDoc;
    property DatasetCtpDet: TUniClientDataSet read FDatasetCtpDet write FDatasetCtpDet;

    procedure SetInclusaoManual(aValue:Boolean);

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmFiscCtpEntrada: TfrmFiscCtpEntrada;

implementation

uses untPesqAux, untFuncoes, Data.DB, untFuncoesSimples, untConsultas, untCadCta,
  untFuncoesConsulta, untDesmembrValores;

{$R *.dfm}

procedure TfrmFiscCtpEntrada.btnConfirmaDadosClick(Sender: TObject);
begin
  strCndPagDig := mskCndPag.Text;

  inherited;
end;

procedure TfrmFiscCtpEntrada.btnDesmembrClick(Sender: TObject);
  Var
    LDesmembrValores : TfrmDesmembrValores;
begin
  inherited;

  If (Not btnDesmembr.Enabled) Or (Not btnDesmembr.Visible) Then
  Begin
    Exit;
  End;

  {*****************************************************************************}
  {* SÓ PERMITI ENTRAR NA TELA DE DESMEMBRAMENTO SE O VALOR FOR MAIOR QUE ZERO *}
  {**************************************************************************LU*}
  {***************************************************************************}
  {* SOLICITAÇÃO DA MACHADO PARA LIBERAR DESMEMBRAMENTO DE VALORES NEGATIVOS *}
  {************************************************************09/01/2012**JU*}
  If (FValDup = 0)  Then
  Begin
    fMensagem('ATENÇÃO!', 'O valor da duplicata deve ser diferente de zero!', ['&Ok']);
    Exit;
  End;

  If (fEmptyStr(fCfgSis('CTAPRI')) Or fEmptyStr(fCfgSis('EVEPRI'))) Then
  Begin
    fMensagem('ATENÇÃO!', 'As configurações: "Plano de Contas principal para rateio de duplicatas" e "Evento principal para rateio de duplicatas" devem estar preenchidas nas configurações do sistema!', ['&Ok']);
    Exit;
  End;

  Try
    {*****************************************}
    {* CHAMA O FORM DE DESMEMBRAMENTO        *}
    {**************************************MV*}
    pCriarFormularios(TfrmDesmembrValores, LDesmembrValores);
    LDesmembrValores.DatasetCtpDet  := FDatasetCtpDet;
    LDesmembrValores.strNumDup  := '';
    LDesmembrValores.strParcel  := '';
    LDesmembrValores.strSerie   := '';
    LDesmembrValores.strCodEmp  := FCodEmp;
    LDesmembrValores.strCodFor  := FCodFor;
    LDesmembrValores.blnBaixada := False;
    LDesmembrValores.fltValTot  := FValDup;

    LDesmembrValores.showModal;

    If Not FDatasetCtpDet.IsEmpty Then
    Begin
      fraCtaPagar.edtCodCta.Enabled := False;
      fraCtaPagar.edtCodCta.Text    := IIF((LDesmembrValores.strCodCta = ''), fCfgSis('CTAPRI'), LDesmembrValores.strCodCta);
      fraCtaPagar.objFrameCtaPagar.pCarregaCentroCusto;

      If fVerificaEvenRat(FDatasetCtpDet) Then
      Begin
        fraCtaPagar.edtCodEve.Text  := fCfgSis('EVEPRI');
        fraCtaPagar.edtCodEve.Enabled := False;
        fraCtaPagar.objFrameCtaPagar.pCarregaEvento;
      End
      Else
      Begin
        fraCtaPagar.edtCodEve.Enabled := True;
        fraCtaPagar.objFrameCtaPagar.pCarregaEvento;
      End;
    End
    Else
    Begin
      fraCtaPagar.edtCodCta.Enabled := True;
      fraCtaPagar.edtCodEve.Enabled := True;
      fraCtaPagar.edtCodCta.Clear;
      fraCtaPagar.edtNomCta.Clear;
      fraCtaPagar.edtCodEve.Clear;
      fraCtaPagar.edtDesEve.Clear;
      pSetFocus(fraCtaPagar.edtCodCta);
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmFiscCtpEntrada.pDesmembraValores]');
    End;
  End;
  pFreeAndNil(LDesmembrValores);
end;

procedure TfrmFiscCtpEntrada.btnSairClick(Sender: TObject);
begin
  If fMensagem('', 'Caso a tela de informações do contas a pagar for fechada, o mesmo não será gravado. Deseja continuar?', ['&Sim', '&Não']) = 1 Then
  inherited;
end;

procedure TfrmFiscCtpEntrada.edtCodCndKeyPress(Sender: TObject; var Key: Char);
  Var
    arrCnd : TConsultasArray;

begin
  inherited;
  If edtCodCnd.Enabled And (Not edtCodCnd.ReadOnly) Then
  Begin
    If fEntraCons(Key) Then
    Begin
      If fPesqCondicoesPgto(Self, edtCodCnd, nil, nil, Key, arrCnd) Then
      Begin
        pCarregaCondicao;
        if fValidaCampos(edtCodCnd, True) then
          SelectNext(ActiveControl, True, True);
      End;
    End;
  End;

  If Key = #13 Then
  Begin
    If fraCtaPagar.edtTipDoc.Enabled Then
      pSetFocus(fraCtaPagar.edtTipDoc)
    Else
      pSetFocus(fraCtaPagar.edtVeiobo);
  End;
end;

procedure TfrmFiscCtpEntrada.edtCodPorKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) And
     fPesqPortador(conSimples, Self, edtCodPor, edtNomPor, Nil, Key, arrSel) then
   Self.SelectNext(ActiveControl, True, True);
end;

procedure TfrmFiscCtpEntrada.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If ModalResult = mrOk Then
  Begin
    If Not fraCtaPagar.fValidaCampos(Nil, False, True) Then
    Begin
      Action := caNone;
      Exit;
    End;

    If Not fVerificaCampos Then
      Action := caNone;
  End;
  If Assigned(qryConCnd) Then
    FreeAndNil(qryConCnd);

  If Assigned(qryCadCta) Then
    FreeAndNil(qryCadCta);

  If FMemHis <> fraCtaPagar.MemHisto.Text then
    FMemHis := fraCtaPagar.MemHisto.Text;

  {*****************************************************}
  {** HIDE HINT TIPO DOCUMENTO QUANDO TELA FOR FECHADA *}
  (**** E O CAMPO TIPO DOCUMENTO ESTIVER COM FOCUS *****)
  {*18/08/2020***************************************GR*}
  if fraCtaPagar.edtTipDoc.Focused then
    fraCtaPagar.HintControler.HideHint;

end;

procedure TfrmFiscCtpEntrada.FormCreate(Sender: TObject);
begin
  inherited;
  objFrameCtaPagar:= TFrameContaPagar.Create;
  FDatCad:= '';
  FMemHis:= '';
  FValOri:= 0;
  FValDup:= 0;

  FlstForPix := TStringList.Create;

  strCndPagDig := '';
  strCtaAnt := '';
  
  pCriaClientTemporariaCtpDet('', '','', '', '', FDatasetCtpDet);
end;

procedure TfrmFiscCtpEntrada.FormDestroy(Sender: TObject);
begin
  inherited;
  FlstForPix.Free;
  FreeAndNil(FDatasetCtpDet);
end;

procedure TfrmFiscCtpEntrada.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
 If Key = VK_F8 Then
  Begin
    btnDesmembr.Click;
  End;
end;

procedure TfrmFiscCtpEntrada.FormShow(Sender: TObject);
begin
  inherited;
  If ( fCfgSis('USACND', varBoolean) ) Then
  Begin

    edtCodCnd.Visible     := True;
    mskCndPag.Enabled     := False;
    mskCndPag.Color       := fraCtaPagar.edtNomCta.Color;
    mskCndPag.NormalColor := fraCtaPagar.edtNomCta.NormalColor;

  End
  Else
  Begin

    edtCodCnd.Visible     := False;
    mskCndPag.Enabled     := True;
    mskCndPag.Color       := clWhite;
    mskCndPag.NormalColor := clWhite;
    mskCndPag.Top         := edtCodCnd.Top;
    mskCndPag.Left        := edtCodCnd.Left;
    mskCndPag.Width       := 538;

  End;

  fraCtaPagar.objFrameCtaPagar := objFrameCtaPagar;
  fraCtaPagar.objForm          := frmFiscCtpEntrada;
  fraCtaPagar.strCodFor        := FCodFor;
  fraCtaPagar.strDataDocumento := strDtaDoc;
  fraCtaPagar.InicializaObjetoFrameContaPagar(True);

  fraCtaPagar.objFrameCtaPagar.objCodigo_Conta.Text := strCodCta;
  fraCtaPagar.objFrameCtaPagar.pCarregaCentroCusto;
  if fEmptyStr(fraCtaPagar.objFrameCtaPagar.objNome_Conta.Text) then
    fraCtaPagar.objFrameCtaPagar.objCodigo_Conta.Clear;


  If Not fEmptyStr(edtCodPor.Text) Then
    fValidaCampos(edtCodPor);

  If Not fEmptyStr(edtCodCnd.Text) Then
    fValidaCampos(edtCodCnd);

  fraCtaPagar.MemHisto.Lines.Add(FMemHis);
  pSetFocus(edtCodPor);

end;

procedure TfrmFiscCtpEntrada.fraCtaPagarcbxBcoForChange(Sender: TObject);
begin
  strAutIncPix := '';
  If Pos('PIX', fraCtaPagar.cbxBcoFor.Text) > 0 Then
    strAutIncPix := fGetAutIncPix
  Else
    inherited;
end;

function TfrmFiscCtpEntrada.fGetAutIncPix: String;
begin
 If fraCtaPagar.cbxBcoFor.ItemIndex > -1 Then
    Result := FlstForPix[fraCtaPagar.cbxBcoFor.ItemIndex]
  Else
    Result := '';
end;

procedure TfrmFiscCtpEntrada.fraCtaPagaredtCodCtaKeyPress(Sender: TObject;
  var Key: Char);
begin
  fraCtaPagar.edtCodCtaKeyPress(Sender, Key);
  If Not fEmptyStr(fraCtaPagar.edtNomCta.Text) Then
    inherited;
end;

procedure TfrmFiscCtpEntrada.fraCtaPagaredtCodEveKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  fraCtaPagar.edtCodEveKeyPress(Sender, Key);

end;

procedure TfrmFiscCtpEntrada.fraCtaPagaredtDeposiExit(Sender: TObject);
begin
  inherited;
  If fraCtaPagar.edtDeposi.Text = 'S' Then
    pCarregaDadosBancariosFornecedor(FCodFor, True);
end;

procedure TfrmFiscCtpEntrada.pCarregaDadosBancariosFornecedor(strCodFor: String; ABlnIncluirChavesPix: Boolean = False);
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery;
  FlstForPix.Clear;
  Try
    fraCtaPagar.cbxBcoFor.Clear;
    With qryGen, SQL Do
    Begin
      Clear;
      Add(getSQLDadosBancariosFornecedor(ABlnIncluirChavesPix));
      ParamByName('CODFOR').AsString := strCodFor;
      Open;

      While Not Eof Do
      Begin
        fraCtaPagar.cbxBcoFor.Items.Add(Trim(FieldByName('DESC_CONTA').AsString));
        FlstForPix.Add(FieldByName('AUTOINCREM').AsString);
        Next;
      End;

      Close;
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TfrmFiscCtpEntrada.SetInclusaoManual(aValue: Boolean);
begin
  objFrameCtaPagar.InclusaoManual := aValue;
end;

procedure TfrmFiscCtpEntrada.fraCtaPagaredtTipDocEnter(Sender: TObject);
begin
  inherited;
  fraCtaPagar.edtTipDocEnter(Sender);

end;

procedure TfrmFiscCtpEntrada.fraCtaPagaredtTipDocExit(Sender: TObject);
begin
  inherited;
  fraCtaPagar.edtTipDocExit(Sender);

end;

function TfrmFiscCtpEntrada.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
Var
  oParametros: TParametrosDesmembraValoresCtaDet;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtCodCnd) And (edtCodCnd.Visible) Then
    Begin

      If fEmptyStr(edtCodCnd.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A condição deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        pCarregaCondicao;
        If qryConCnd.FieldByName('CND_CODIGO').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa condição não está cadastrada!', ['&O k']);
          mskCndPag.Text:= '';
          Result := False;
        End
        Else If (Not fEmpresaTemAcessoCondicaoPagto(qryConCnd.FieldByName('CND_CODIGO').AsString)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar esta condição. Verifique o Cadastro de Condições de Pagamento - Aba "Empresas Acesso".' , ['&O k']);
          mskCndPag.Text:= '';
          Result := False;
        End;

        If Result And (Not fValidaCndPag(mskCndPag.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa condição de pagamento não é valida!', ['&O k']);
          mskCndPag.Text:= '';
          Result := False;
        End;
      End;

    End

    Else If (Sender = mskCndPag) And (mskCndPag.Visible) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskCndPag.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A condição de pagamento deve ser preenchida!', ['&O k']);
        mskCndPag.Text:= '';
        Result := False;
      End
      Else If StrToIntDef(Copy(mskCndPag.Text, 1, 2),0) > 24 Then
      Begin
        fMensagem('', 'Não é permitido mais que 24 parcelas!', ['&O k']);
        mskCndPag.Text:= '';
        Result := False;
      End
      Else If Not fValidaCndPag(mskCndPag.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Essa condição de pagamento não é valida!', ['&O k']);
        mskCndPag.Text:= '';
        Result := False;
      End;

    End

    Else If (Sender = edtCodPor) Then
    Begin

      If not fEmptyStr(edtCodPor.Text) Then
      Begin
        edtNomPor.Text := fRetNomPortador(edtCodPor.Text);
        If fEmptyStr(edtNomPor.Text) Then
        Begin
          pMensagemOk('Portador não econtrado!');
          Result := False;
        End;
      End;

    End

    Else If (Sender = fraCtaPagar.edtCodCta) And (strCtaAnt <> fraCtaPagar.edtCodCta.Text) Then
    Begin
      oParametros := TParametrosDesmembraValoresCtaDet.Create;
      try
        oParametros.strNumCta := fraCtaPagar.edtCodCta.Text;
        oParametros.strCodEve := fraCtaPagar.edtCodEve.Text;
        oParametros.frmCadPag := Self;
        oParametros.fltValDup := FValDup;
        oParametros.strCodEmp := FCodEmp;
        oParametros.blnDireto := False;

        If fDesmembraValoresCtaDet(oParametros) then
        Begin
          fraCtaPagar.edtCodCta.Enabled := False;

          If fEmptyStr(oParametros.strCodCta) Then
            fraCtaPagar.edtCodCta.Text := fCfgSis('CTAPRI')
          Else
            fraCtaPagar.edtCodCta.Text := oParametros.strCodCta;

          FDatasetCtpDet.Data := oParametros.cdsTemp.Data;

         { fraCtaPagar.edtCodEve.Text := fCfgSis('EVEPRI');
          pCarregaEventos;
          pCarregaCentroCusto;
          pSetFocus(Self);
          If fraCentroCusto.dbeCodEve.CanFocus Then
            pSetFocus(fraCentroCusto.dbeCodEve)
          Else
            pSetFocus(dbeCodPor);}
        End
        Else
          fraCtaPagar.edtCodCta.Enabled := True;
        
      finally
        oParametros.Free;
        strCtaAnt := fraCtaPagar.edtCodCta.Text;
      end;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmFiscCtpEntrada.pCarregaCondicao;
begin

  If Not Assigned(qryConCnd) Then
    qryConCnd := fCriaQuery(Self);

  pPesquisaCadCnd(qryConCnd, qryConCnd, edtCodCnd.Text);

  If ( Not qryConCnd.IsEmpty ) Then Begin
    With qryConCnd Do Begin

      mskCndPag.Enabled     := (fCfgSis('USACND', varBoolean)) And (qryConCnd.FieldByName('CND_TIPFOR').AsString = 'OUTROS');
      mskCndPag.Color       := $00FFDFB8;
      mskCndPag.NormalColor := $00FFDFB8;
      mskCndPag.Text        := fRetCondicao('', 0, FieldByName('CND_TIPFOR').AsString, FieldByName('CND_CNDPAG').AsString, FieldByName('CND_CNDPAG').AsString);

    End;

  End;
  
end;

end.

