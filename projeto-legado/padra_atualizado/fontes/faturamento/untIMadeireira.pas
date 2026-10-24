unit untIMadeireira;

interface

uses Db, UniClientDataSet;

Type
  IMadeireira = interface
  ['{3B6B4CE3-8B54-41AB-9728-10573415CE97}']
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

end.
