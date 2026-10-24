{**********************************************************************************}
{*  Classe responsável por encapsular o fatvendas, que implementa a interface     *}
{*  ICalculadorFatVendasTAB, assim, o fatvendas não é liberado quando a interface *}
{*  deixa de ser referenciada, ocasionando erros.                                 *}
{*  Utilizada especialmente para o TAB da consulta da tinta                       *}
{******************************************************************************AC**}

unit untFatVendasCalculadorWrapperTAB;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
{$ELSE}
  untFuncoesSimples, untFatVendas, untFatVendaItem,
  UniClientDataSet, Controls, untClassPanelCx,
  untFuncoesGen, untModulo,
{$ENDIF}
  Faturamento.Classes.TFatVendaBase, untICalculadorFatVendasTAB,
  untInterfacedObjectNoCount, DB, Uni,
  Variants, SysUtils, untFuncTinta, untTypesSistema,
  untTMatrizSaldosColorantes, untConstantes;

type
  TFatVendasCalculadorWrapperTAB = class(TInterfacedObjectNoCount, ICalculadorFatVendasTAB)
  private
    fatVendas: TFatVendaBase;
  public
    constructor Create(const fatVendas: TFatVendaBase);
    destructor Destroy; override;

    procedure pPreencheRetornoTintaDeMaquinaConsultaTAB(dicRetorno: TDicionario; qryTinta: TUniQuery);
    function fVendeItemTinta(cdsConsulta: TUniClientDataSet; DropControl: TControl): Boolean;

    {$IFNDEF LINUX}
    function fConsultaTab(arrSql,
                   arrCampos,
                   arrOrdenacao: Array Of String;
                   strCampoChave,
                   strTabela,
                   strNomForm,
                   strTitulo: String;
                   qryAux: TUniQuery;
                   objFrmPnl: TPanelCx;
                   blnSimples: Boolean;
                   Var arrSelec: TConsultasArray;
                   strCodBusca: String = 'AUTOINCREM';
                   objConsulta: Pointer = Nil;
                   blnTablet: Boolean = False;
                   blnConIte: Boolean = False;
                   strCampoChave2 : String = '';
                   pAfterAtualiza: TGenericProcedureWithClientParam = Nil;
                   blnRefresh: Boolean = True;
                   blnConfirma: boolean = True;
                   blnConCon: Boolean = True;
                   fChamaCadastro : TBooleanFunctionWithBooleanParam = Nil): Boolean;
    {$ENDIF}
  end;


implementation

uses untCadPro;

{ TFatVendasCalculadorWrapperTAB }

constructor TFatVendasCalculadorWrapperTAB.Create(const fatVendas: TFatVendaBase);
begin
  inherited Create();
  Self.fatVendas := fatVendas;
end;

destructor TFatVendasCalculadorWrapperTAB.Destroy;
begin
  inherited Destroy;
end;

{$IFNDEF LINUX}
function TFatVendasCalculadorWrapperTAB.fConsultaTab(arrSql, arrCampos,
  arrOrdenacao: array of String; strCampoChave, strTabela, strNomForm,
  strTitulo: String; qryAux: TUniQuery; objFrmPnl: TPanelCx;
  blnSimples: Boolean; var arrSelec: TConsultasArray; strCodBusca: String;
  objConsulta: Pointer; blnTablet, blnConIte: Boolean; strCampoChave2: String;
  pAfterAtualiza: TGenericProcedureWithClientParam; blnRefresh, blnConfirma,
  blnConCon: Boolean;
  fChamaCadastro: TBooleanFunctionWithBooleanParam): Boolean;
begin

  untFuncoesGen.pIniciaDllFuncoes(frmModulo.GetCurrentConnection, untFuncoesSimples.strLoginUsuarioLogado, untFuncoesSimples.VS_strCodEmp, DebugHook, TCfgSis.Create(),
                    untFuncoesSimples.VS_objTraceViewer,
                    untFuncoesSimples.VS_Date, untFuncoesSimples.VS_ComputerNetName, untFuncoesSimples.VS_UserFromWindows, untFuncoesSimples.VS_IPAddressAsString,
                    untFuncoesSimples.VS_MacAddress);

  Result := untFuncoesGen.fConsulta(arrSql,
                                     arrCampos,
                                     arrOrdenacao,
                                     strCampoChave,
                                     strTabela,
                                     strNomForm,
                                     strTitulo,
                                     qryAux,
                                     objFrmPnl,
                                     blnSimples,
                                     arrSelec,
                                     strCodBusca,
                                     objConsulta,
                                     blnTablet,
                                     blnConIte,
                                     strCampoChave2,
                                     pAfterAtualiza,
                                     blnRefresh,
                                     blnConfirma,
                                     blnConCon);
end;
{$ENDIF}

function TFatVendasCalculadorWrapperTAB.fVendeItemTinta(
  cdsConsulta: TUniClientDataSet; DropControl: TControl): Boolean;
Begin
{$IFDEF LINUX}
  raise Exception.Create('TFatVendasCalculadorWrapperTAB.fVendeItemTinta nao possui implementacao Linux');
{$ELSE}
  Result := frmFatVendas.fVendeItemTinta(cdsConsulta, DropControl);
{$ENDIF}
end;

procedure TFatVendasCalculadorWrapperTAB.pPreencheRetornoTintaDeMaquinaConsultaTAB(
  dicRetorno: TDicionario; qryTinta: TUniQuery);
{$IFDEF LINUX}
begin
  raise Exception.Create('TFatVendasCalculadorWrapperTAB.pPreencheRetornoTintaDeMaquinaConsultaTAB nao possui implementacao Linux');
end;
{$ELSE}
var
  blnUsaPreCus: Boolean;
  strIdePro: String;
  strTabPre: String;
  strUnidad: String;
  fltPreVen,
  fltDesMax: Double;
  strEmpSalRes: String;
  strOpcPre: String;
  blnProPreTin: Boolean;

begin
  fltPreVen := 0;
  fltDesMax := 0;

  blnUsaPreCus := dicRetorno['usaprecus'];
  strIdePro    := dicRetorno['idepro'];
  strTabPre    := dicRetorno['tabpre'];
  strEmpSalRes := dicRetorno['codemp'];
  strOpcPre    := fatVendas.strPreETe;
  blnProPreTin := dicRetorno['propre'];

  frmFatVendas.pExecutaRetornoPrecoTintadeMaquina(blnUsaPreCus, strIdePro, strTabPre,
    strUnidad, fltPreVen, fltDesMax, strEmpSalRes, strOpcPre, dicRetorno, qryTinta, blnProPreTin);
end;
{$ENDIF}

end.

