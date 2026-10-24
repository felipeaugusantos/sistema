{*****************************************************************************************************************}
{*  Interface resposável por alguns metodos utilizados no fatvendas, dessa maneira é possivel passar o fatvendas *}
{*  para as outras dll do sistema, sem que todas as dependencias de units sejam adicionadas ao projeto           *}
{*  Utilizada especialmente para o TAB da consulta da tinta                                                      *}
{**************************************************************************************************************AC*}

unit untICalculadorFatVendasTAB;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
  Shared.Core,
{$ELSE}
  UniClientDataSet, Controls, untFuncoesSimples, untClassPanelCx, untModulo,
{$ENDIF}
  untTypesSistema, untConstantes,
  DB, {$IF Defined(VER250) Or Defined(UNIDAC) Or Defined(VER300) Or Defined(LINUX)} Uni {$ELSE} ZDataSet {$IFEND};

type
  ICalculadorFatVendasTAB = interface
    ['{617F35C6-C379-4C6D-B638-C78A57C7A938}']
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

end.
