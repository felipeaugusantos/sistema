unit untCtpDigData;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, Mask, MaskEditFocus,
  AppEvnts, BitBtnLockedIncrem, untFuncFat, untTypesSistema, frxClass,
  frxExportCSVTestabilidade, Data.DB, Datasnap.DBClient, UniClientDataSet,
  untLiberacao,untTLogLibRec, untMsgLiberacao, untLogLibCtp,Uni;

type
  TfrmCtpDigData = class(TfrmPai)
    Panel1: TPanel;
    mskData: TMaskEditFocus;
    lblData: TLabel;
    btnConfirmaDados: TBitBtnLocked;
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    objLiberacao : TLiberacao;
    blnLibRet : Boolean;
    strDtaAnt : String;
    FDtaData: TDateTime;
    FBloqueiaData: Boolean;
    FLiberacaoPendente : Boolean;
    function fLibBxRetroativaAcimaPermitido: Boolean;
    function LiberacaoBaixaDuplicataComLiberacaoPedente: Boolean;
    function fExisteCTRPag(strAutoIncrem: String): Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    cdsDupSel: TUniClientDataSet;
    FLogLibCtp: TLogLibCtp;
    strAutoInc: String;
    LValorInformadoParaBaixa : Double;
    property BloqueiaData: Boolean read FBloqueiaData write FBloqueiaData Default False;
    property poDtaData: TDateTime read FDtaData write FDtaData;
    property LibDtaRet: Boolean read blnLibRet;
    function Confirma: Boolean;
  end;

var
  frmCtpDigData: TfrmCtpDigData;

function ffrmDataCtp(Var dtaData: TDateTime; strCaption, strCaptionLabel: String;
  blnBloqueiaData: Boolean = False): Boolean;

implementation

uses untfuncoesSimples;

{$R *.dfm}

{ TfrmCtpDigData }

function TfrmCtpDigData.Confirma: Boolean;
begin
  Result := Self.ModalResult = MrOk;
end;

procedure TfrmCtpDigData.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(mskData);
end;

procedure TfrmCtpDigData.FormCreate(Sender: TObject);
begin
  inherited;
  objLiberacao := TLiberacao.Create;
  cdsDupSel := TUniClientDataSet.Create(Self);
  FLogLibCtp   := TLogLibCtp.Create;
end;

procedure TfrmCtpDigData.FormDestroy(Sender: TObject);
begin
  if Assigned(objLiberacao) then
    FreeAndNil(objLiberacao);

  if Assigned(FLogLibCtp) then
    FreeAndNil(FLogLibCtp);
  inherited;
end;

procedure TfrmCtpDigData.FormShow(Sender: TObject);
begin
  inherited;
  if FBloqueiaData And (FDtaData <> 0)  then
  begin
    mskData.Text := DateToStr(FDtaData);
    mskData.Enabled := False;
    pSetFocus(btnConfirmaDados);
  end;
  FLiberacaoPendente := True;
end;

function TfrmCtpDigData.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;
  If (fEmptyStr(fTiraCaracEspeciais(mskData.Text))) Then
  Begin
    fMensagem('ATENÇÃO!', 'A data deve ser preenchida!', ['&Ok']);
    Result := False;
  End
  else
  If (Not fEmptyStr(fCfgSis('BAIATP')))  And
     (fCfgSis('BAIATP', VarInteger) > 0) And
     (StrToDateDef(mskData.Text,0) < (VS_Date - fCfgSis('BAIATP', varInteger))) Then
  Begin
    If  StrToDateDef(mskData.Text,0) <> StrToDateDef(strDtaAnt,0) Then
      blnLibRet := False;

    If   (Not blnLibRet) Then
    Begin
      Result := fLibBxRetroativaAcimaPermitido;
      blnLibRet := Result;
      strDtaAnt := mskData.Text;
    End;
  End;

  If (Result) and
   (Not fEmptyStr(fCfgSis('CTPRET'))) And
   (StrToDateDef(mskData.Text,0) <> VS_Date) Then
  Begin
    If (StrToDateDef(mskData.Text,0) <> StrToDateDef(strDtaAnt,0)) Then
      blnLibRet := False; { Cancela liberação caso altere a data. }

    If Not blnLibRet Then
    Begin
      Result := (TPermissoesAcesso.GetInstance.fVerificaAcesso('CTPDTARET', strLoginUsuarioLogado)) Or
                (fLibBxRetroativaAcimaPermitido);
      blnLibRet := Result;
      strDtaAnt := mskData.Text;
    End;
  End;

  If Result And FLiberacaoPendente Then
  Begin
    Result := LiberacaoBaixaDuplicataComLiberacaoPedente;
    blnLibRet := Result;
    FLiberacaoPendente := IIF(Result,False,True);
  End;

  If (Result) And (Assigned(cdsDupSel)) Then
  Begin
    cdsDupSel.First;
    While Not cdsDupSel.Eof Do
    Begin
      If cdsDupSel.FieldByName('CTP_DTACAD').AsString.IsEmpty Then
      Begin
        cdsDupSel.Next;
        Continue;
      End;

      Result := cdsDupSel.FieldByName('CTP_DTACAD').AsDateTime <= StrToDateDef(mskData.Text,0);

      If Not Result Then
      Begin
        fMensagem('ATENÇÃO', 'A data de pagamento não pode ser menor que a data de cadastro das duplicatas filtradas.', ['&Ok']);

        Break;
      End;

      cdsDupSel.Next;
    End;

    cdsDupSel.First;
  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

function TfrmCtpDigData.LiberacaoBaixaDuplicataComLiberacaoPedente: Boolean;
var
  objTabela : TRegistroMsgLiberaTabela;
  objLinha  : TLinhaMsgLibera;
  LDuplicata : String;
  LUsaLiberacao: Boolean;
  LValorPago:Double;
  LTipoBaixa: String;
begin
  FLiberacaoPendente := False;
  LTipoBaixa := 'T';

  If Not fCfgSis('CTPBDP', varBoolean) Then
    Exit(True);

  LUsaLiberacao := fCfgSis('CTPLBB', varBoolean);

  cdsDupSel.First;

  objLiberacao.Clear;
  objLiberacao.objMsgLibera.pAddQuebra;
  objLiberacao.objMsgLibera.pAddSeparador(124);
  objLiberacao.objMsgLibera.pAddTexto('BAIXA DE DUPLICATA COM LIBERAÇÃO PENDENTE', alCentro, teAmbos, '',125);

  objLinha  := TLinhaMsgLibera.Create;
  objLinha.enuTipoLinha := tlCabecalho;
  objLinha.pAddColuna(''  , 'DUPLICATA'    , 17 , alEsquerda , teAutcom);
  objLinha.pAddColuna(''  , 'FORNECEDOR'   , 27 , alEsquerda , teAutcom);
  objLinha.pAddColuna(''  , 'VR.DOCUMENTO' , 15 , alCentro  , teAutcom);
  objLinha.pAddColuna(''  , 'DESCONTOS'    , 15 , alCentro  , teAutcom);
  objLinha.pAddColuna(''  , 'DT.CAD.'      , 10 , alCentro   , teAutcom);
  objLinha.pAddColuna(''  , 'DT.VENC.'     , 10 , alCentro   , teAutcom);
  objLinha.pAddColuna(''  , 'VR. PAGO'      , 15 , alCentro  , teAutcom);

  objTabela := TRegistroMsgLiberaTabela.Create;
  objTabela.lstLinhas.Add(objLinha);

  While Not cdsDupSel.Eof Do
  Begin

    LValorPago := fFormataFloat(cdsDupSel.FieldByName('TOTDUP').AsFloat, 2);
    If LValorInformadoParaBaixa > 0 Then
    Begin

      If (LValorInformadoParaBaixa >= LValorPago) Then
      Begin
        LValorInformadoParaBaixa := fFormataFloat((LValorInformadoParaBaixa  - LValorPago), 2);
      End
      Else
      Begin
        LValorPago := LValorInformadoParaBaixa;
        LTipoBaixa := 'P';
        LValorInformadoParaBaixa := 0;
      End;

      If (LTipoBaixa = 'P') And (fExisteCTRPag(cdsDupSel.FieldByName('AUTOINCREM').AsString)) Then
        Continue;
    End;

    If (LUsaLiberacao And (cdsDupSel.FieldByName('CTP_DTALIB').IsNull)) Then
    Begin
      FLiberacaoPendente := True;
      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlValor;

      LDuplicata :=  cdsDupSel.FieldByName('CTP_NUMDUP').AsString + '-' +
                     IIF(fEmptyStr(cdsDupSel.FieldByName('CTP_SERIE_').AsString), '', cdsDupSel.FieldByName('CTP_SERIE_').AsString + '-') +
                     cdsDupSel.FieldByName('CTP_CODEMP').AsString;

      objLinha.pAddColuna('DUPLICATA'   , LDuplicata , 17, alEsquerda);
      objLinha.pAddColuna('FORNECEDOR'  , cdsDupSel.FieldByName('CTP_NOMFOR').AsString, 27 , alEsquerda);
      objLinha.pAddColuna('VR.DOCUMENTO', FloatToStrF(cdsDupSel.FieldByName('CTP_VALDUP').AsFloat, ffNumber, 9, 2), 15 , alDireita);
      objLinha.pAddColuna('DESCONTOS'   , FloatToStrF(cdsDupSel.FieldByName('CTP_DESSUJ').AsFloat, ffNumber, 12, 2), 15, alDireita);
      objLinha.pAddColuna('DT.CAD.'     , FormatDateTime('dd/mm/yyyy', cdsDupSel.FieldByName('CTP_DTACAD').AsDateTime), 10, alCentro);
      objLinha.pAddColuna('DT.VENC.', FormatDateTime('dd/mm/yyyy', cdsDupSel.FieldByName('CTP_DTAVEN').AsDateTime), 10 , alCentro);
      objLinha.pAddColuna('VR. PAGO'       , FloatToStrF(LValorPago, ffNumber, 12, 2), 15, alDireita);
      objTabela.lstLinhas.Add(objLinha);
    End;

    If LTipoBaixa.Equals('P') Then
      Break;
    cdsDupSel.Next;
  End;

  If Not FLiberacaoPendente Then
    Exit(True);

  objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

  objLiberacao.strDirAce := 'frmCtpLiberacaoBaixa';
  objLiberacao.strSenLib := fCfgSis('BAICTP');
  objLiberacao.strCodOpe := strLoginUsuarioLogado;
  objLiberacao.strCodDig := strLoginUsuarioLogado;
  objLiberacao.strMsgSen := 'BAIXA DE DUPLICATA COM LIBERAÇÃO PENDENTE';
  objLiberacao.objMsgLibera.strTitulo := 'BAIXA DE DUPLICATA COM LIBERAÇÃO PENDENTE';

  Result := objLiberacao.fLibera;

  cdsDupSel.First;

  If Result Then
    FLogLibCtp.AddLogLib(cdsDupSel.FieldByName('AUTOINCREM').AsString
                         ,cdsDupSel.FieldByName('CTP_NUMDUP').AsString
                         ,cdsDupSel.FieldByName('CTP_SERIE_').AsString
                         ,cdsDupSel.FieldByName('CTP_CODEMP').AsString
                         ,objLiberacao);

  strAutoInc := cdsDupSel.FieldByName('AUTOINCREM').AsString;
end;

function TfrmCtpDigData.fExisteCTRPag(strAutoIncrem: String): Boolean;
Var
  qryConsul: TUniQuery;
begin
  Result := False;
  If strAutoIncrem <> '' Then
  Begin
    qryConsul := fCriaQuery();
    qryConsul.Sql.Clear;
    qryConsul.Sql.Text := 'SELECT * FROM CTRPAG WHERE PAG_AUTCTP = :AUTOINCREM';
    qryConsul.ParamByName('AUTOINCREM').AsString :=  strAutoIncrem;

    qryConsul.Open;

    If Not qryConsul.IsEmpty Then
      Result := True;

    qryConsul.Close;
    FreeAndNil(qryConsul);
  End;
end;

procedure TfrmCtpDigData.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;
  If (fVerificaCampos) Then
  Begin
    Close;
    ModalResult := mrOk;
  End;
end;

function ffrmDataCtp(Var dtaData: TDateTime; strCaption,
  strCaptionLabel: String; blnBloqueiaData: Boolean = False): Boolean;
begin

//  dtaData := 0;
  Try
    pCriarFormularios(TfrmCtpDigData, frmCtpDigData);

    if blnBloqueiaData then
    begin
      if dtaData <> 0 then
      begin
        frmCtpDigData.mskData.Text := DateToStr(dtaData);
        frmCtpDigData.mskData.Enabled := False;
        pSetFocus(frmCtpDigData.btnConfirmaDados);
      end;
    end;

    frmCtpDigData.Caption := strCaption;
    frmCtpDigData.lblData.Caption := strCaptionLabel;
    Result := (frmCtpDigData.ShowModal = mrOk);

    If (Result) Then
      dtaData := StrToDate(frmCtpDigData.mskData.Text);

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[ffrmDataCtp]');
    End;
  End;

  pFreeAndNil(frmCtpDigData);

end;

function TfrmCtpDigData.fLibBxRetroativaAcimaPermitido: Boolean;
var
  objTabela : TRegistroMsgLiberaTabela;
  objLinha  : TLinhaMsgLibera;
begin
  cdsDupSel.First;

  objLiberacao.Clear;
  objLiberacao.objMsgLibera.pAddQuebra;
  objLiberacao.objMsgLibera.pAddSeparador(143);
  objLiberacao.objMsgLibera.pAddTexto('LIBERAÇÃO DE BAIXA RETROATIVA DE DUPLICATA DO CONTAS A PAGAR', alCentro, teAmbos, '',144);

  objLinha  := TLinhaMsgLibera.Create;
  objLinha.enuTipoLinha := tlCabecalho;
  objLinha.pAddColuna(''  , 'DUPLICATA'    , 21 , alEsquerda , teAutcom);
  objLinha.pAddColuna(''  , 'FORNECEDOR'   , 27 , alEsquerda , teAutcom);
  objLinha.pAddColuna(''  , 'VR.DOCUMENTO' , 15 , alCentro  , teAutcom);
  objLinha.pAddColuna(''  , 'JUROS'        , 15 , alCentro  , teAutcom);
  objLinha.pAddColuna(''  , 'MULTA'        , 15 , alCentro  , teAutcom);
  objLinha.pAddColuna(''  , 'DESCONTOS'    , 15 , alCentro  , teAutcom);
  objLinha.pAddColuna(''  , 'DT.CAD.'      , 10 , alCentro   , teAutcom);
  objLinha.pAddColuna(''  , 'DT.VENC.'     , 10 , alCentro   , teAutcom);
  objTabela := TRegistroMsgLiberaTabela.Create;
  objTabela.lstLinhas.Add(objLinha);

  While Not cdsDupSel.Eof Do
  Begin
    objLinha  := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlValor;
    objLinha.pAddColuna('DUPLICATA'   , cdsDupSel.FieldByName('CTP_NUMDUP').AsString + '-'
                                      + cdsDupSel.FieldByName('CTP_SERIE_').AsString + '-'
                                      + cdsDupSel.FieldByName('CTP_CODEMP').AsString , 21, alEsquerda);
    objLinha.pAddColuna('FORNECEDOR'  , cdsDupSel.FieldByName('CTP_NOMFOR').AsString, 27 , alEsquerda);
    objLinha.pAddColuna('VR.DOCUMENTO', FloatToStrF(cdsDupSel.FieldByName('CTP_VALDUP').AsFloat, ffNumber, 9, 2), 15 , alDireita);
    objLinha.pAddColuna('JUROS'       , FloatToStrF(cdsDupSel.FieldByName('CTP_JURSUJ').AsFloat, ffNumber, 12, 2), 15, alDireita);
    objLinha.pAddColuna('MULTA'       , FloatToStrF(cdsDupSel.FieldByName('CTP_MULSUJ').AsFloat, ffNumber, 12, 2), 15, alDireita);
    objLinha.pAddColuna('DESCONTOS'   , FloatToStrF(cdsDupSel.FieldByName('CTP_DESSUJ').AsFloat, ffNumber, 12, 2), 15, alDireita);
    objLinha.pAddColuna('DT.CAD.'     , FormatDateTime('dd/mm/yyyy', cdsDupSel.FieldByName('CTP_DTACAD').AsDateTime), 10, alCentro);
    objLinha.pAddColuna('DT.VENC.', FormatDateTime('dd/mm/yyyy', cdsDupSel.FieldByName('CTP_DTAVEN').AsDateTime), 10 , alCentro);
    objTabela.lstLinhas.Add(objLinha);
    cdsDupSel.Next;
  End;

  objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

  objLiberacao.strDirAce := 'CTPDTARET';
  objLiberacao.strSenLib := 'CTPRET';
  objLiberacao.strCodOpe := strLoginUsuarioLogado;
  objLiberacao.strCodDig := strLoginUsuarioLogado;
  objLiberacao.objMsgLibera.strTitulo := 'LIBERAÇÃO DE BAIXA RETROATIVA DE DUPLICATA DO CONTAS A PAGAR COM JUROS';
  objLiberacao.strMsgSen := 'LIBERAÇÃO DE BAIXA RETROATIVA DE DUPLICATA DO CONTAS A PAGAR';


  Result := objLiberacao.fLibera;

  cdsDupSel.First;

  If Result Then
    FLogLibCtp.AddLogLib(cdsDupSel.FieldByName('AUTOINCREM').AsString
                         ,cdsDupSel.FieldByName('CTP_NUMDUP').AsString
                         ,cdsDupSel.FieldByName('CTP_SERIE_').AsString
                         ,cdsDupSel.FieldByName('CTP_CODEMP').AsString
                         ,objLiberacao);

  strAutoInc := cdsDupSel.FieldByName('AUTOINCREM').AsString;

end;

end.

