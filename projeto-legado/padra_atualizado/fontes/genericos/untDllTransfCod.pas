unit untDllTransfCod;

interface

Uses Classes, Forms, SysUtils, Uni,  Windows, untFuncoesSimples, untTypesSistema;

Type
  TTransfCod = (TransfCodVendedor, TransfCodFornecedor, TransfCodCliente,
                TransfCodCidade, TransfCodCta, TransfCodUnidade, TransfCodAtividade,
                TransfCodDiverso, TransfCodPortador, TransfCodTransportadora, TransfCodCorIndustrial,
                TransfCodPlacaVeiculo, TransfCodAcessorio, TransfCodMotorista, TransfCodevento);


  TTransfModulos = Record
    Banco: TUniConnection;
  End;

  TTransfVariaveis = Record
    dtaVSDate : TDateTime;
    strLogUsu : String[3];
    strDesUsu : String[30];
    strEmpUsu : String[200];
    strEmpEst : String[200];
    strEmpCod : String[3];
    utcRegist : TUltConsultas;
    objTraceViewer: ITraceViewer;
    blnModoClassico: Boolean;
  End;

  TparamTransfCod = class(TObject)
    public
      intDebugH : Byte;
      frmTiptra : TTransfCod;
      modRecMod : TTransfModulos;
      varRecVar : TTransfVariaveis;
      FuncExternaprcRetCfgRelacionadaArquivo: TprcRetCfgRelacionadaArquivo;
      arrCfgsPortadorIn: PChar;
  End;

  TProcedureTransferencia = procedure (prmDllTra: Pointer);

procedure pIniVariaveis(Var varRecVar: TTransfVariaveis);
procedure pIniModulos(Var modRecMod: TTransfModulos);

implementation

uses untModulo;


procedure pIniModulos(Var modRecMod: TTransfModulos);
Begin
  With modRecMod Do
    Banco := frmModulo.GetCurrentConnection;
End;

procedure pIniVariaveis(Var varRecVar: TTransfVariaveis);
Begin
  With varRecVar Do
  Begin
    dtaVSDate := VS_Date;
    strLogUsu := ShortString(strLoginUsuarioLogado);
    strDesUsu := ShortString(strDescriUsuarioLogado);
    strEmpUsu := ShortString(strEmpAcessoUsuarioLogado);
    strEmpEst := ShortString(strEmpEstUsuarioLogado);
    strEmpCod := ShortString(String(VS_strCodEmp));
    utcRegist := utcRegistros;
    objTraceViewer := VS_objTraceViewer;
    blnModoClassico := blnUsuarioLogadoUtilizaModoClassico;
  End;
End;

end.
