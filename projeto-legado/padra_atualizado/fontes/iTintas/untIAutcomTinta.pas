unit untIAutcomTinta;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, untGTinForTipos,
{$ELSE}
  untFuncoesSimples, UniClientDataSet, Forms, untPnlBotoesAcoesNovaConsulta,
{$ENDIF}
  untConstantes, Uni, Classes, untTipoTinta,
  untFuncEspecificas;

type
  IAutcomTinta = interface
    ['{57EEC6F8-E219-4EC8-9CDB-3309EF6647CC}']
    function fTipoTinta(): TTipoTinta; stdcall;
    function fTintaBaixaEmbalagem(strTipEmb: String; Var strCodIte: String): Boolean; stdcall;
    function fTravaQuantidadeTinta(strTipEmb: String; fltQtdEmb, fltQtdDig: Double): Boolean; stdcall;
    function fTintaGeraFormulacao(): Boolean; stdcall;
    function fRetornaTabelaColoranteTinta(): String; stdcall;
    procedure pRetItemColorante(strColTinDet: String; Var strCodIte, strCodBas: String; const strCodEmp: string); stdcall;
    procedure pRetItemEDescricaoColorante(strColTinDet: String; var strCodIte, strCodBas, strDesBas: String;
      const strCodEmp: string);
    function fFormulacaoAcumulada(): Boolean; stdcall;
    procedure pTintaRetornaTabelaPreco(dicRetorno: TDicionario; fltFatorAcerto: Double); stdcall;
    Function fGetFatorML(): Double; stdcall;
    function fRetornaPreco(Sender: TForm; qryTinta: TUniQuery;  Var dicRetorno: TDicionario;
      blnFaturamento, blnPermiteTab: Boolean; strTab: String = 'N'; strAutoTab: String = ''; sltItems: TStringList = Nil; strMD5Key: String = ''; blnSemTela: Boolean = False): Boolean; stdcall;
    function fRetornaUniTraProTinta(qryTinta: TUniQuery; fltEmbala, fltQuanti: Double; strTipPre, strIteTin, strCodBas, strTabPre,
      strCatalize: String; fltPrcTin, fltPrvTin: Double): Double;
    function fRetornaUniTraEmbTinta(strTipEmb, strTipPre: String): Double; stdcall;
    function fGTinForGeral(strIteTin, strTipPre, strLinTin, strCatalize: String; intLazQua: Integer; fltQtdEmb, fltQtdIte: Double;
      strDescri: String; qryArqFor: TUniQuery; fltVolPro: Double; var arrFormul: TForMulTinDetArray; var arrBaixaPigmentos: TBaixaPigmentosArray;
      var stlItensTraMl: TStringList; strCodDil: string; fltPorDil: Double; strDilCon: String; fltPorCat: Double; strTipCor,
      strTextBase: String; intAcao: Integer; strIteCob: String; strCodEmpPrd: string): Boolean;
    procedure pRetornaDadosTinta(strIteTin: String; dicRetorno: TDicionario); stdcall;
    function fRetornaDescricaoTinta(strDesCri: String; qryTinta: TUniQuery; strTipPre: String): String; stdcall;
    function fRetornaReferenciaTinta(qryTinta: TUniClientDataSet): String; stdcall;
    function fRetornaNomeTinta(): String; stdcall;
    function fRetornaCampoDescricaoColorante(): String;
   {$IFNDEF LINUX}
    procedure pTarefaFormulacao(Sender: TObject; frmConsulta: TfrmPnlBotoesAcoesNovaConsulta);
    procedure pTarefaPrecos(Sender: TObject; frmConsulta: TfrmPnlBotoesAcoesNovaConsulta);
    procedure pTarefaVenda(Sender: TObject; frmConsulta: TfrmPnlBotoesAcoesNovaConsulta);
    function fConsultaTintaGeral(Sender: TForm; strCodEmp: String): String; stdcall;
    function fConsultaTintaVenda(Sender: TForm; strCodEmp: String; qryTinta: TUniQuery;
      blnFaturamento, blnPermiteTab: Boolean; dicRetorno: TDicionario; sltItems: TStringList): String; stdcall;
   {$ENDIF}
  end;


implementation

end.
