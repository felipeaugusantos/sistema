unit Contabilidade.Classes.TLanConFactory;

interface

uses Contabilidade.Interfaces, cxProgressBar;

type
  TLanConFactory = Class(TInterfacedObject, ILanConFactory)
  private
  public
    constructor Create;
    destructor Destroy; override;
    class function New: ILanConFactory;
    function fLanCon(strTipLan: String; recParCon: TParametrosConsulta; pgbProgresso: TcxProgressBar): ITipLanCon;
  End;

implementation

uses Contabilidade.Classes.TLanConSAI, Contabilidade.Classes.TLanConOUE,
     Contabilidade.Classes.TLanConENT, Contabilidade.Classes.TLanConCOE,
     Contabilidade.Classes.TLanConCOS, Contabilidade.Classes.TLanConServicoEntrada,
     Contabilidade.Classes.TLanConServicoSaida, Contabilidade.Classes.TLanConCAR,
     Contabilidade.Classes.TLanConCHQ, Contabilidade.Classes.TLanConBAN,
     Contabilidade.Classes.TLanConCTR, Contabilidade.Classes.TLanConAJS,
     Contabilidade.Classes.TLanConAJE, Contabilidade.Classes.TLanConPCR,
     Contabilidade.Classes.TLanConCRC, Contabilidade.Classes.TLanConADT,
     Contabilidade.Classes.TLanConIMO, Contabilidade.Classes.TLanConCMV,
     Contabilidade.Classes.TLanConGNR, Contabilidade.Classes.TLanConComplementoSaida,
     Contabilidade.Classes.TLanConComplementoEntrada, Contabilidade.Classes.TLanConPDD,
     Contabilidade.Classes.TLanConAGR, Contabilidade.Classes.TLanConAGP,
     Contabilidade.Classes.TLanConTCC, Contabilidade.Classes.TLanConENTADT,
     Contabilidade.Classes.TLanconCPC, Contabilidade.Classes.TLanconANT,
     Contabilidade.Classes.TLanConCtrBaixaAdtTransfCC, Contabilidade.Classes.TLanConAJI;

{ TLanConFactory }

constructor TLanConFactory.Create;
begin
end;

destructor TLanConFactory.Destroy;
begin
  inherited;
end;

function TLanConFactory.fLanCon(strTipLan: String;
  recParCon: TParametrosConsulta; pgbProgresso: TcxProgressBar): ITipLanCon;
begin
  Result := Nil;
  If (strTipLan = 'SAI') Then
    Result := TLanConSAI.Create(strTipLan, pgbProgresso, recParCon)
  Else If (strTipLan = 'ENT') Then
    Result := TLanConENT.Create(strTipLan, pgbProgresso, recParCon)
  Else If (strTipLan = 'ENTADT') Then
    Result := TLanConENTADT.Create(strTipLan, pgbProgresso, recParCon)
  Else If (strTipLan = 'COE') Then
    Result := TLanConCOE.Create(strTipLan, pgbProgresso, recParCon)
  Else If (strTipLan = 'COS') Then
    Result := TLanConCOS.Create(strTipLan, pgbProgresso, recParCon)
  Else If (strTipLan = 'SEE') Then
    Result := TLanConServicoEntrada.Create(strTipLan, pgbProgresso, recParCon)
  Else If (strTipLan = 'SEEADT') Then
    Result := TLanConServicoEntradaADT.Create(strTipLan, pgbProgresso, recParCon)
  Else If (strTipLan = 'SES') Then
    Result := TLanConServicoSaida.Create(strTipLan, pgbProgresso, recParCon)
  Else If (strTipLan = 'OUE') Then
    Result := TLanConOUE.Create(strTipLan, pgbProgresso, recParCon)
  Else If (strTipLan = 'CAR') Then
    Result := TLanConCAR.Create(strTipLan, pgbProgresso, recParCon)
  Else If (strTipLan = 'CHQ') Then
    Result := TLanConCHQ.Create(strTipLan, pgbProgresso, recParCon)
  Else If (strTipLan = 'BAN') Then
    Result := TLanConBAN.Create(strTipLan, pgbProgresso, recParCon)
  Else If (strTipLan = 'CTR') Then
    Result := TLanConCTR.Create(strTipLan, pgbProgresso, recParCon)
  Else If (strTipLan = 'CRC') Then
    Result := TLanConCRC.Create(strTipLan, pgbProgresso, recParCon)
  Else If (strTipLan = 'AJS') Then
    Result := TLanConAJS.Create(strTipLan, pgbProgresso, recParCon)
  Else If (strTipLan = 'AJE') Then
    Result := TLanConAJE.Create(strTipLan, pgbProgresso, recParCon)
  Else If (strTipLan = 'PCR') Then
    Result := TLanConPCR.Create(strTipLan, pgbProgresso, recParCon)
  Else If (strTipLan = 'ADT') Then
    Result := TLanConADT.Create(strTipLan, pgbProgresso, recParCon)
  Else If (strTipLan = 'IMO') Then
    Result := TLanConIMO.Create(strTipLan, pgbProgresso, recParCon)
  Else If (strTipLan = 'CMV') Then
    Result := TLanConCMV.Create(strTipLan, pgbProgresso, recParCon)
  Else If (strTipLan = 'GNR') Then
    Result := TLanConGNR.Create(strTipLan, pgbProgresso, recParCon)
  Else If (strTipLan = 'CEN') Then
    Result := TLanConComplementoEntrada.Create(strTipLan, pgbProgresso, recParCon)
  Else If (strTipLan = 'CSA') Then
    Result := TLanConComplementoSaida.Create(strTipLan, pgbProgresso, recParCon)
  Else If (strTipLan = 'PDD') Then
    Result := TLanConPDD.Create(strTipLan, pgbProgresso, recParCon)
  Else If (strTipLan = 'AGR') Then
    Result := TLanConAGR.Create(strTipLan, pgbProgresso, recParCon)
  Else If (strTipLan = 'AGP') Then
    Result := TLanConAGP.Create(strTipLan, pgbProgresso, recParCon)
  Else If (strTipLan = 'TCC') Then
    Result := TLanConTCC.Create(strTipLan, pgbProgresso, recParCon)
  Else If (strTipLan = 'CPC') Then
    Result := TLanConCPC.Create(strTipLan, pgbProgresso, recParCon)
  Else If (strTipLan = 'ANT') Then
    Result := TLanConANT.Create(strTipLan, pgbProgresso, recParCon)
  Else If (strTipLan = 'AJI') Then
    Result := TLanConAJI.Create(strTipLan, pgbProgresso, recParCon)
  Else If (strTipLan = 'CTR_ADT_CC') Then
    Result := TLanConCtrBaixaAdtTransfCC.Create(strTipLan, pgbProgresso, recParCon);
end;

class function TLanConFactory.New: ILanConFactory;
begin
  Result := Self.Create;
end;

end.
