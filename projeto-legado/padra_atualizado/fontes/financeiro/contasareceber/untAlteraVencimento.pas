unit untAlteraVencimento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, EditFocus, Vcl.Mask, MaskEditFocus, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  Vcl.ComCtrls, dxCore, cxDateUtils, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar,
  untLiberacao;

type
  TfrmAlteraVencimento = class(TfrmPai)
    lbl1: TLabel;
    Label6: TLabel;
    edtPerJur: TEditFocus;
    lblJuroam: TLabel;
    Label1: TLabel;
    edtPerMul: TEditFocus;
    btnConfirma: TBitBtnLocked;
    Label2: TLabel;
    lblValCorrigido: TLabel;
    mskDtaVenc: TcxDateEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure mskDtaVencExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    objLiberacao : TLiberacao;
    strSenhaDtaVenOld: String;
    function fCalculaValorCorrigido(dteDataVenc: TDate; fltTaxaJuros, fltTaxaMulta: Double): Double;
    function fLiberaAlteraJuros(): Boolean;
    function fLiberaAlteraVenc(): Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    blnConfirma: Boolean;
    dteDataVenc: TDate;
    fltTaxaJuros,
    fltTaxaMulta,
    fltValDup,
    fltDesSuj,
    fltJurSuj,
    fltDesCob: Double;
    strAutoincrem: String;
    strBcoBol: String;
    blnBoletoIndiv : Boolean;
  end;


implementation

{$R *.dfm}

uses untFuncoesSimples, untTypesSistema, untFuncFat, untTCadRec,
  untTCadRecRepository, untConstantes, untMsgLiberacao;

{ TfrmAlteraVencimento }

procedure TfrmAlteraVencimento.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If (Not fVerificaCampos) Then
    Exit;

  If (fFormataFloat(fltTaxaJuros, 2) <> fFormataFloat(fStrToFloat(edtPerJur.Text), 2)) Or
     (fFormataFloat(fltTaxaMulta, 2) <> fFormataFloat(fStrToFloat(edtPerMul.Text), 2)) Then
  Begin
    If Not blnBoletoIndiv and Not fLiberaAlteraJuros Then
    Begin
      edtPerJur.Text := FormatFloat('0.00', fltTaxaJuros);
      edtPerMul.Text := FormatFloat('0.00', fltTaxaMulta);
      lblValCorrigido.Caption := FormatFloat('0.00', fCalculaValorCorrigido(StrToDate(mskDtaVenc.Text),
                                                                            fStrToFloat(edtPerJur.Text),
                                                                            fStrToFloat(edtPerMul.Text)));
      Exit;
    End;
  End;

  dteDataVenc  := StrToDate(mskDtaVenc.Text);
  fltTaxaJuros := fStrToFloat(edtPerJur.Text);
  fltTaxaMulta := fStrToFloat(edtPerMul.Text);

  blnConfirma := True;
  Close;
end;

procedure TfrmAlteraVencimento.btnSairClick(Sender: TObject);
begin
  inherited;
  Close;
end;

function TfrmAlteraVencimento.fLiberaAlteraJuros: Boolean;
var
  objCadRecRepository: TCadRecRepository;
  objCadRec: TCadRec;
begin
  objCadRecRepository := TCadRecRepository.Create;
  try
    objCadRec := objCadRecRepository.fRetDuplicata(strAutoincrem);

    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('ALTERAÇÃO DE JUROS DE CONTAS A RECEBER NÃO PERMITIDO', alCentro, teAmbos, '', 93);
    objLiberacao.objMsgLibera.pAddSeparador(93);
    objLiberacao.objMsgLibera.pAddTextoCaption('Código do cliente'        , Copy(objCadRec.objCodCli.strCodCli, 1, 56)                                          , 35);
    objLiberacao.objMsgLibera.pAddTextoCaption('Nome do cliente'          , Copy(objCadRec.objCodCli.strNomCli, 1, 56)                                          , 35);
    objLiberacao.objMsgLibera.pAddSeparador(93);
    objLiberacao.objMsgLibera.pAddTextoCaption('Duplicata'                , objCadRec.CTR_NUMDUP                                                                , 35);
    objLiberacao.objMsgLibera.pAddTextoCaption('Parcela'                  , objCadRec.CTR_PARCEL                                                                , 35);
    objLiberacao.objMsgLibera.pAddTextoCaption('Espécie'                  , objCadRec.CTR_ESPDOC                                                                , 35);
    objLiberacao.objMsgLibera.pAddTextoCaption('Empresa'                  , objCadRec.CTR_CODEMP                                                                , 35);
    objLiberacao.objMsgLibera.pAddSeparador(93);
    objLiberacao.objMsgLibera.pAddTextoCaption('Valor original'           , FormatFloat('#,##0.00', objCadRec.CTR_VALORI)                                       , 35);
    objLiberacao.objMsgLibera.pAddTextoCaption('Valor duplicata'          , FormatFloat('#,##0.00', objCadRec.CTR_VALDUP)                                       , 35);
    objLiberacao.objMsgLibera.pAddTextoCaption('Vencimento original'      , DateToStr(objCadRec.CTR_DTAVEN)                                                     , 35);
    objLiberacao.objMsgLibera.pAddTextoCaption('Vencimento alterado'      , mskDtaVenc.Text                                                                     , 35);
    objLiberacao.objMsgLibera.pAddTextoCaption('Taxa juros config.'       , FormatFloat('#,##0.00', fltTaxaJuros)                                               , 35);
    objLiberacao.objMsgLibera.pAddTextoCaption('Taxa juros alterada'      , FormatFloat('#,##0.00', fStrToFloat(edtPerJur.Text))                                , 35);
    objLiberacao.objMsgLibera.pAddTextoCaption('Taxa multa config.'       , FormatFloat('#,##0.00', fltTaxaMulta)                                               , 35);
    objLiberacao.objMsgLibera.pAddTextoCaption('Taxa multa alterada'      , FormatFloat('#,##0.00', fStrToFloat(edtPerMul.Text))                                , 35);
    objLiberacao.objMsgLibera.pAddTextoCaption('Valor corrigido original' , FormatFloat('#,##0.00', fCalculaValorCorrigido(StrToDate(mskDtaVenc.Text),
                                                                                                                              fltTaxaJuros,
                                                                                                                              fltTaxaMulta))                    , 35);
    objLiberacao.objMsgLibera.pAddTextoCaption('Valor corrigido com alterações: ',    FormatFloat('#,##0.00', fCalculaValorCorrigido(StrToDate(mskDtaVenc.Text),
                                                                                                              fStrToFloat(edtPerJur.Text),
                                                                                                              fStrToFloat(edtPerMul.Text)))                     , 35);
    objLiberacao.objMsgLibera.pAddSeparador(93);

    objLiberacao.strDirAce := 'ALTJUR';
    objLiberacao.strMsgSen := 'Alteração de juros de contas a receber';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;


    Result := objLiberacao.fLibera;
  finally
    FreeAndNil(objCadRecRepository);
  end;
end;

function TfrmAlteraVencimento.fLiberaAlteraVenc: Boolean;
var
  objTabela : TRegistroMsgLiberaTabela;
	objLinha  : TLinhaMsgLibera;
  objCadRecRepository: TCadRecRepository;
  objCadRec: TCadRec;
begin
  Result := True;

  If (fCfgSis('CTRDTA', varBoolean)) And fEmptyStr(strSenhaDtaVenOld) Then
  Begin
    objCadRecRepository := TCadRecRepository.Create;
    try
      objCadRec := objCadRecRepository.fRetDuplicata(strAutoincrem);

      objLiberacao.Clear;
      objLiberacao.objMsgLibera.pAddSeparador(117);
      objLiberacao.objMsgLibera.pAddTexto('***  Alteração da data de vencimento do boleto  *** ', alCentro, teAmbos, '', 117);

      objTabela := TRegistroMsgLiberaTabela.Create;

      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlCabecalho;
      objLinha.pAddColuna(''  , 'DUPLICATA'    , 21 , alEsquerda , teAutcom);
      objLinha.pAddColuna(''  , 'DT.CAD.'      , 12 , alCentro   , teAutcom);
      objLinha.pAddColuna(''  , 'DT.VENC.'     , 12 , alCentro   , teAutcom);
      objLinha.pAddColuna(''  , 'CLIENTE'      , 38 , alEsquerda , teAutcom);
      objLinha.pAddColuna(''  , 'VR.DUPLICATA' , 23 , alDireita  , teAutcom);
      objTabela.lstLinhas.Add(objLinha);

      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlValor;
      objLinha.pAddColuna('DUPLICATA'    , objCadRec.CTR_NUMDUP + '-' + objCadRec.CTR_PARCEL + '-' + objCadRec.CTR_ESPDOC + '-' + objCadRec.CTR_CODEMP , 21 , alEsquerda );
      objLinha.pAddColuna('DT.CAD.'      , FormatDateTime('dd/MM/yyyy', objCadRec.CTR_DTACAD)                                                          , 12 , alCentro   );
      objLinha.pAddColuna('DT.VENC.'     , FormatDateTime('dd/MM/yyyy', objCadRec.CTR_DTAVEN)                                                          , 12 , alCentro   );
      objLinha.pAddColuna('CLIENTE'      , objCadRec.objCodCli.strCodCli + '-' + objCadRec.objCodCli.strNomCli                                         , 38 , alEsquerda );
      objLinha.pAddColuna('VR.DUPLICATA' , FormatFloat('#,##0.00', objCadRec.CTR_VALDUP)                                                               , 23 , alDireita  );
      objTabela.lstLinhas.Add(objLinha);

      objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

      objLiberacao.objMsgLibera.pAddSeparador(117);
      objLiberacao.objMsgLibera.pAddTextoCaption('Nova Data de Vencimento', mskDtaVenc.Text, 34);
      objLiberacao.objMsgLibera.pAddSeparador(117);

      objLiberacao.strDirAce := 'ALTBOLVENC';
      objLiberacao.strSenLib := fCfgSis('CTRSDV');
      objLiberacao.strMsgSen := 'Alteração da data de vencimento do boleto.';
      objLiberacao.strCodOpe := strLoginUsuarioLogado;
      objLiberacao.objMsgLibera.strTitulo := 'Alteração da data de vencimento do boleto.';


      Result := objLiberacao.fLibera;

      If Result Then
        strSenhaDtaVenOld := '1';
    finally
      FreeAndNil(objCadRecRepository);
    end;
  End;
end;

procedure TfrmAlteraVencimento.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(mskDtaVenc);
end;

procedure TfrmAlteraVencimento.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirma       := False;
  strSenhaDtaVenOld := '';
  objLiberacao := TLiberacao.Create;
end;

procedure TfrmAlteraVencimento.FormDestroy(Sender: TObject);
begin
  inherited;
  if assigned(objLiberacao) then
    freeandnil(objliberacao);
end;

procedure TfrmAlteraVencimento.FormShow(Sender: TObject);
begin
  inherited;
  mskDtaVenc.Text := DateToStr(dteDataVenc);

  fltTaxaJuros    := fCfgSis('JURATR', varDouble);
  edtPerJur.Text  := FloatToStrF(fltTaxaJuros, ffFixed, 12, 2);

  fltTaxaMulta    := fCfgSis('MULATR', varDouble);
  edtPerMul.Text  := FloatToStrF(fltTaxaMulta, ffFixed, 12, 2);

  lblValCorrigido.Caption := FormatFloat('0.00', fCalculaValorCorrigido(StrToDate(mskDtaVenc.Text),
                                                                        fStrToFloat(edtPerJur.Text),
                                                                        fStrToFloat(edtPerMul.Text)));
end;

function TfrmAlteraVencimento.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (Sender = edtPerJur) Then
  Begin
    If (Not fEmptyStr(edtPerJur.Text)) Then
    Begin
      If Not fValidaEscala(edtPerJur.Text, 0, 99) Then
      Begin
        edtPerJur.Text := FormatFloat('0.00', fltTaxaJuros);
        Result := False;
      End
    End;
  End
  Else
  If (Sender = edtPerMul) Then
  Begin
    If (Not fEmptyStr(edtPerMul.Text)) Then
    Begin
      If Not fValidaEscala(edtPerMul.Text, 0, 99) Then
      Begin
        edtPerMul.Text := FormatFloat('0.00', fltTaxaMulta);
        Result := False;
      End;
    End;
  End
  Else If (Sender = mskDtaVenc) Then
  begin

    If (fEmptyStr(fTiraCaracEspeciais(mskDtaVenc.Text))) Or (Not fValidaDataStr(mskDtaVenc.Text)) Then
    Begin
      fMensagem('', 'A data informada não é válida!', ['&O k']);
      pSetFocus(mskDtaVenc);
      Result := False;
    end
    Else If StrToDate(mskDtaVenc.Text) < VS_Date Then
    Begin
      pMensagemOk('A nova data de vencimento deve ser maior ou igual à data atual!');
      pSetFocus(mskDtaVenc);
      Result := False;
    End
    Else If (StrToDate(mskDtaVenc.Text) <> dteDataVenc) And Not blnBoletoIndiv  Then
      Result := fLiberaAlteraVenc;
  End;

  If Not Result Then
    lblValCorrigido.Caption := FormatFloat('0.00', fCalculaValorCorrigido(StrToDate(mskDtaVenc.Text),
                                                                          fStrToFloat(edtPerJur.Text),
                                                                          fStrToFloat(edtPerMul.Text)));
end;

procedure TfrmAlteraVencimento.mskDtaVencExit(Sender: TObject);
begin
  inherited;
  lblValCorrigido.Caption := FormatFloat('0.00', fCalculaValorCorrigido(StrToDate(mskDtaVenc.Text),
                                                                        fStrToFloat(edtPerJur.Text),
                                                                        fStrToFloat(edtPerMul.Text)));
end;

function TfrmAlteraVencimento.fCalculaValorCorrigido(dteDataVenc: TDate; fltTaxaJuros, fltTaxaMulta: Double): Double;
var
  fltValdes, fltValBase, fltValAcr, fltValCor: Double;
begin
  If (fCfgSis('UTDEFN') = '1') Or (Self.dteDataVenc >= dteDataVenc) Then
    fltValdes := fltDesSuj
  Else
    fltValdes := 0;

  fltValBase := fltValDup - fltValdes + fltJurSuj + fltDesCob;
  fltValAcr := fCalculaJurosCadCtr(Self.dteDataVenc, DateToStr(dteDataVenc), fltValBase, fltTaxaJuros, fltTaxaMulta, 9999, strBcoBol);
  fltValCor := fltValBase + fltValAcr;

  Result := fltValCor;
end;

end.
