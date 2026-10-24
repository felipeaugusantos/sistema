unit untIMetAno;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
{$ELSE}
  UniClientDataSet,
{$ENDIF}
  untTypesSistema;

Type
  IMetAno = interface
  ['{E46ED68C-8A84-4BBD-A9B1-F61ACE0D1D22}']
    procedure pSetMes(intMes: Integer);
    procedure pCarregar(strAno: String; fltMeta, fltMarMes: Double; strCodEmp: String;
                        blnGravarMeta: Boolean; CdsView: TUniClientDataSet = Nil;
                        blnCarregarMeta : Boolean = False;
                        intMesIni: Integer = 1; intMesFim: Integer = 12;
                        blnRecalculaMetaProjetada: Boolean = True;
                        fltLitragem : Double = 0);

    procedure pSetaEmpOrigemCusto(blnEmpOrigem: Boolean; strComCus: String);

    procedure First;
    procedure Next;

    function fGetMesAtual: TRecMes;
    function fGetMes(intMes: Integer): TRecMes;
    function fGetDiasCorridos: Double;
    function fGetFimDosMeses: Boolean;
    function fGetFMargemMensal: Double;
    function fGetMetaAno: Double;

    function fCalculaMargem(fltCusto, fltVenda: Double): Double;

    procedure pCalculaTotal(CdsView: TUniClientDataSet);
    procedure pAtualizaResult(CdsView: TUniClientDataSet);
    function fCarregouMetaEmpresa: Boolean;
    procedure pAtualizaVariaveis(CdsView: TUniClientDataSet);
    procedure pGravarMetaEmpresa;
    procedure pAtualizaMetaRealizada;

    property MesAtual: TRecMes read fGetMesAtual;
    property MetaAno: Double read fGetMetaAno;
    property MargemMensal: Double read fGetFMargemMensal;
    property Eof: Boolean read fGetFimDosMeses;
  End;

implementation

end.
