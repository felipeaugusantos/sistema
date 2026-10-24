unit untIFinanceira;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
{$ELSE}
  UniClientDataset,
{$ENDIF}
  untTypesSistema, Uni;

Type
  IFinanceira = interface
  ['{E74BC4AD-C24B-4353-9939-1EAB23B81700}']
    function fRetValFin: Double;
    function fRetTotalOperacao: Double;
    function fRetTotalFinanciado: Double;
    function fRetDespesasAcessorias: Double;
    function fRetCartaoFinanceira(strCodFin: String; intQtdPar: Integer): String;
    function fValidaCartoes(arrDesCar: TCartoesFinanceira; cdsSelFin: TUniClientDataSet): Boolean;
    function fRetArrCartoes(strCodFin: String; Var arrCarFin: TCartoesFinanceira): TCartoesResumoCaixaArray;
    function fRetArrCartaoFinanc(strCodFin: String): TCartoesResumoCaixaArray;
    function fRecalculaFinanceira(fltTotFin: Double): Boolean;
    function fValorRestante(cdsSelFin: TUniClientDataSet; fltTotFin: Double): Double;
    function fRetIndiceFin(strCodFin: String; intQtdPar: Integer): Double;
    function fValorParcela(fltTotFin, fltTaxRet, fltTaxCad, fltIndFin, fltTaxBol: Double; intQtdParc: Integer): Double;
    function fValorOperacao(fltParFin: Double; intQtdPar: Integer): Double;
    function fParcelasFinanc(qryCadFin: TUniQuery; strCodFin: String): String;
    function fRetTaxasFin(strCodFin: String; intQtdFin: Integer;
               Var fltTaxRet, fltTaxCad, fltIndFin, fltTaxBol: Double;
               Var strCliFin, strCodCar, strTipRet, strDesAce: String; Var intDiaFin: Integer): Boolean;
    function fGravaFinanciamento(strNomTab, strAutInc: String): Boolean;
    function fValidaCartao(fltValFin: Double; arrCartao: TCartoesResumoCaixaArray): Boolean;

    procedure pCarregaFinanciamento(strNomTab, strSeqGer: String);
    procedure pAtualizaClient(fltFator: Double = 1);

    procedure pCarregaDados(Var arrDesCar: TCartoesFinanceira; cdsSelFin: TUniClientDataSet);
    procedure pSalvaDados(arrDesCar: TCartoesFinanceira; cdsSelFin: TUniClientDataSet);

    procedure pRegistraItem(cdsSelFin: TUniClientDataSet;
                            strCodFin,
                            strCodCar,
                            strTipRet,
                            strDesAce: String;
                            fltValFin: Double;
                            intQtdPar: Integer;
                            fltValOpe,
                            fltValPar: Double;
                            strCliFin: String;
                            intDiaFin: Integer;
                            fltValAdt: Double);

    procedure pCopiaArrCartoesDig(strCodFin: String;
                                  arrCarOri: TCartoesResumoCaixaArray;
                                  Var arrDesCar: TCartoesFinanceira);

    Procedure pDeleteCartoesNaoEncontrados(Var arrDesCar: TCartoesFinanceira; cdsSelFin: TUniClientDataSet);

    procedure pCopiaSeguranca;
    procedure pRestaurarCopiaSeguranca;

    procedure pSalvaCartoes(var arrCartoes: TCartoesResumoCaixaArray);

    procedure pLimpaDados;

    function GetFMovFin: TUniClientDataSet;
    procedure SetFMovFin(Value: TUniClientDataSet);

    property cdsMovFin: TUniClientDataSet Read GetFMovFin Write SetFMovFin;
  End;

implementation

end.
