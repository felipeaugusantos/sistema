unit untICamGer;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'};
{$ELSE}
  UniClientDataSet;
{$ENDIF}

Type
  ICamGer = interface
  ['{A6D8E9D8-0592-4F0C-AB44-D65F087F74D4}']
    function fGravaCamGer(Var strAutInc: String;
                          strCodCmg,
                          strDesCmg,
                          strCodRed,
                          strCodCli,
                          strObs_01,
                          strObs_02,
                          strObs_03,
                          strCodEmp,
                          strBrinde: String;
                          dtaDtaEnt,
                          dtaDtaIni,
                          dtaDtaFin: TDateTime;
                          strAtiva: String): Boolean;
    function fRetornaNomeCampanha(strCodCmg: String): String;
    function fRetornaClientesRede(strCodRed: String): String;
    function fRetornaRedeCliente(strCodCli: String): String;
    function fVerificaClienteCampanha(strCodCli: String): Boolean;
    function fExisteCampanha(dtaDtaAtu: TDatetime): Boolean;

    procedure pLimpaDadosGer;
    procedure pAtuDadosGer;
    procedure pCarregaCamGer(strCodCmg: String);

    function getCdsCamGer: TUniClientDataSet;
    procedure setCdsCamGer(DataSet: TUniClientDataSet);

    function getDesCmg: String;
    procedure setDesCmg(Value: String);

    property cdsCamGer: TUniClientDataSet Read getCdsCamGer Write setCdsCamGer;
    property strDesCmg: String Read getDesCmg   Write setDesCmg;
  End;

implementation

end.
