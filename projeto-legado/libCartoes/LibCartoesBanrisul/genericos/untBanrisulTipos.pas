unit untBanrisulTipos;

interface

uses System.Generics.Collections, SysUtils;

Const
  NOME_CONCILIACAO = 'BANRISUL';
  AUTCOM_STYLE_NAME = 'Sapphire Kamri';

Type
  TBanrisulVendas = class
    private
    public
      strCodEst,
      strCNPJEst,
      strRedeID,
      strID_Arq,
      strNumNsu,
      strNumPar,
      strTotPar,
      strNSUOri,
      strCodMsg,
      strCodPrc,
      strServic,
      strSituac,
      strPrazo_,
      strPraUlt,
      strID_ped,
      strCPFCli,
      strBandei,
      strIniCar,
      strFinCar,
      strNomArq,
      dtaDtaVen,
      dtaDtaOri,
      dtaDtaCre,
      dtaDtaCnf,
      dtaDtaArq : String;
      fltValVen,
      fltValPar,
      fltPerTax,
      fltTarifa,
      fltLiqPar: Double;
  end;

  TBanrisulCreditoDetalhe = class;

  TBanrisulCredito = class
    private
    public
      strCodEst,
      strCodRed,
      strTipReg,
      strCNPJEst,
      strID_Arq,
      strCodMsg,
      strCodAge,
      strCodCta,
      strNomArq,
      strCodLan,
      strSeqLan,
      dtaDtaArq,
      dtaDtaLan : String;
      ListaCreditoDetalhes : TList<TBanrisulCreditoDetalhe>;
      constructor create;
      destructor Destroy; override;
    end;

  TBanrisulCreditoDetalhe = class
    private
    public
      strTipReg,
      strCodRed,
      strCodEst,
      strNumNsu,
      strNumPar,
      strNomSol,
      strCodSol,
      strCodLan,
      strSeqLan,
      strCNPJEst,
      dtaDtaLan,
      dtaDtaVen,
      strNomArq,
      strDescri : String;
      fltValPar,
      fltValLiq,
      fltValCan,
      fltTarFix,
      fltTarAdm,
      fltTarCom: Double;
    end;

  TBanrisulCreditoList = class(TObjectList<TBanrisulCredito>)
    private
      FSelecionado : TBanrisulCredito;
    public
      property Selecionado : TBanrisulCredito read FSelecionado write FSelecionado;
      function fGetRegistroCredito(AIdentificadorArquivo : String;
        ARegistroCreditoDetalhe : TBanrisulCreditoDetalhe) : TBanrisulCredito;
    end;

  TBanrisulPagamento = class
    private
    public
      strCNPJEst,
      strCNPJCon,
      strStatus,
      strBandei,
      strCodMod,
      strTipMov,
      strNomArq,
      dtaDtaLan,
      dtaDtaRef,
      dtaDtaArq: String;
      fltValLan : Double;
  end;

  TBanrisulAntecipacao = class
    private
    public
      strCNPJEst,
      strCNPJCon,
      strNumCon,
      strBandei,
      strCanal_,
      strCodBco,
      strCodAge,
      strCodCta,
      strCodOpe,
      strNumNSU,
      strNumPar,
      strTotPar,
      strNomArq,
      dtaDtaPag,
      dtaDtaCon,
      dtaDtaVen,
      dtaDtaTra,
      dtaVenPar,
      dtaDtaArq: String;
      fltValAnt,
      fltPerTax,
      fltValTax,
      fltValReg,
      fltValLiq,
      fltValBru,
      fltValTra,
      fltValPar: Double;
  end;

  TEstruturaBanrisulPgto = Record
    strDescri: String;
    strTipCmp: String;
  End;

  TArrEstruturaBanrisulPgto  = Array Of TEstruturaBanrisulPgto;

implementation

{ TBanrisulCredito }

constructor TBanrisulCredito.create;
begin
  ListaCreditoDetalhes := TList<TBanrisulCreditoDetalhe>.Create;
end;

destructor TBanrisulCredito.Destroy;
  Var
    LContador: Integer;
begin
  If Assigned(ListaCreditoDetalhes) Then
  Begin
    For LContador := 0 To ListaCreditoDetalhes.Count - 1 Do
    Begin
      If ListaCreditoDetalhes[LContador] <> Nil Then
        ListaCreditoDetalhes[LContador].Destroy;
    End;

    ListaCreditoDetalhes.Clear;
    FreeAndNil(ListaCreditoDetalhes);
  End;
  inherited;
end;

{ TBanrisulCreditoList }

function TBanrisulCreditoList.fGetRegistroCredito(AIdentificadorArquivo : String;
  ARegistroCreditoDetalhe : TBanrisulCreditoDetalhe): TBanrisulCredito;
var SObjetoCredito : TBanrisulCredito;
begin
  Result := Nil;

  for SObjetoCredito in Self do
  begin
    if AIdentificadorArquivo = 'BJRVCC1' then
    begin
      if (SObjetoCredito.strCodRed = ARegistroCreditoDetalhe.strCodRed) and
         (SObjetoCredito.strCodEst = ARegistroCreditoDetalhe.strCodEst) and
         (SObjetoCredito.dtaDtaLan = ARegistroCreditoDetalhe.dtaDtaLan) and
         (SObjetoCredito.strCodLan = ARegistroCreditoDetalhe.strCodLan) and
         (SObjetoCredito.strSeqLan = ARegistroCreditoDetalhe.strSeqLan) and
         (SObjetoCredito.strNomArq = ARegistroCreditoDetalhe.strNomArq) then
      Exit(SObjetoCredito);
    end
    else
    if AIdentificadorArquivo = 'BJRVCMB' then
    begin
      if (SObjetoCredito.strCNPJEst = ARegistroCreditoDetalhe.strCNPJEst) and
         (SObjetoCredito.dtaDtaLan  = ARegistroCreditoDetalhe.dtaDtaLan)  and
         (SObjetoCredito.strCodLan  = ARegistroCreditoDetalhe.strCodLan)  and
         (SObjetoCredito.strSeqLan  = ARegistroCreditoDetalhe.strSeqLan)  and
         (SObjetoCredito.strNomArq  = ARegistroCreditoDetalhe.strNomArq)  then
      Exit(SObjetoCredito);
    end;
  end;

end;

end.
