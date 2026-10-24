unit untTMadeireira;

interface

uses untIMadeireira, DB, UniClientDataSet;

Type
  TMadeireira = Class(TInterfacedObject, IMadeireira)
  public
    function fCarregaItensMadeiraImpressao(qryDados: TDataSet; Var cdsDados: TUniClientDataSet;
      blnDocSep, blnQtdOri: Boolean; strEspDoc, strDestin: String): Boolean;

    function fCalculaQuantidadePecas(fltQtdTot,
                                     fltComprimento,
                                     fltLargura,
                                     fltEspessura: Double;
                                     strSiglaUni : String): Double;

    procedure pConverteMedidas(Var fltAltura : Double;
                               Var fltLargura: Double;
                               strSiglaUni   : String);
  End;

implementation

uses untMadeireira;

{ TMadeireira }

function TMadeireira.fCalculaQuantidadePecas(fltQtdTot, fltComprimento,
  fltLargura, fltEspessura: Double; strSiglaUni: String): Double;
begin
  Result := untMadeireira.fCalculaQuantidadePecas(fltQtdTot, fltComprimento,
    fltLargura, fltEspessura, strSiglaUni);
end;

function TMadeireira.fCarregaItensMadeiraImpressao(qryDados: TDataSet;
  var cdsDados: TUniClientDataSet; blnDocSep, blnQtdOri: Boolean; strEspDoc,
  strDestin: String): Boolean;
begin
  Result := untMadeireira.fCarregaItensMadeiraImpressao(qryDados, cdsDados, blnDocSep,
    blnQtdOri, strEspDoc, strDestin);
end;

procedure TMadeireira.pConverteMedidas(var fltAltura, fltLargura: Double; strSiglaUni: String);
begin
  untMadeireira.pConverteMedidas(fltAltura, fltLargura, strSiglaUni);
end;

end.
