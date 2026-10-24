{********************************************************************************}
{*  Classe responsável por encapsular o fatvendas, que implementa a interface   *}
{*  ICalculadorFatVendas, assim, o fatvendas não é liberado quando a interface  *}
{*  deixa de ser referenciada, ocasionando erros.                               *}
{****************************************************************************PP**}

unit untFatVendasCalculadorWrapper;

interface

uses
  Faturamento.Classes.TFatVendaBase,
  untICalculadorFatVendas, untFuncFatTypes,
  untInterfacedObjectNoCount, DB, Uni, untICalculadorFatVendasLibTintas;

type
  TFatVendasCalculadorWrapper = class(TInterfacedObjectNoCount, ICalculadorFatVendas, ICalculadorFatVendasLibTintas)
  private
    fatVendas: TFatVendaBase;
  public
    constructor Create(const fatVendas: TFatVendaBase);
    destructor Destroy; override;
    function fCalculaAliquota(strCodIte, strImpDir: String): Double; overload;
    function fCalculaAliquota(strCodIte, strEmpIte, strImpDir: String): Double; overload;
    function fPegaPrecoVenda(qryCadIte: TDataset; strEntSai: String; fltMargem: Double; blnItemEspecial : Boolean = False; strIdePro: String = 'NOR'; strTabPreItem: String = ''):Double; overload;
    function fPegaPrecoVenda(qryCadIte: TDataset; strEmpIte, strEntSai: String; fltMargem: Double; blnItemEspecial : Boolean = False; strIdePro: String = 'NOR'; strTabPreItem: String = ''):Double; overload;
    function GetQryConIte: TUniQuery;
    function fPegaPrecoCusto(qryCadIte: TDataset): Double;
    function GetStrClaFis: string;
    function GetStrOpcDoc: string;
    function GetStrCodCnd: string;
    function GetStrCodCli: string;
    function GetIntPrzMed: Integer;
  end;


implementation

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
{$ELSE}
  untFuncoesSimples,
{$ENDIF}
  untCadPro;

{ TFatVendasCalculadorWrapper }

constructor TFatVendasCalculadorWrapper.Create(const fatVendas: TFatVendaBase);
begin
  inherited Create();
  Self.fatVendas := fatVendas;
end;

destructor TFatVendasCalculadorWrapper.Destroy;
begin
  inherited Destroy;
end;

function TFatVendasCalculadorWrapper.fCalculaAliquota(strCodIte, strImpDir: String): Double;
begin
  Result := fatVendas.fCalculaAliquota(strCodIte, strImpDir);
end;

function TFatVendasCalculadorWrapper.fCalculaAliquota(strCodIte, strEmpIte, strImpDir: String): Double;
begin
  Result := fatVendas.fCalculaAliquota(strCodIte, strEmpIte, strImpDir);
end;

function TFatVendasCalculadorWrapper.fPegaPrecoCusto(qryCadIte: TDataset): Double;
var
  blnParticiona: Boolean;
  blnPromo: Boolean;
  fltQtdDis: Double;
  blnPrecoPromocao: Boolean;
begin
  blnParticiona := False;
  fatVendas.strPromoc := 'N';
  blnPrecoPromocao := False;  
  blnPromo := False;
  fltQtdDis := 0;
  
  Result := qryCadIte.FieldByName('ITE_PRECUS').AsFloat;

  If (fatVendas.fItemPassivelDeVerificacaoPromo(qryCadIte.FieldByName('ITE_CODITE').AsString, VS_strCodEmp)) Then
  Begin
    blnPrecoPromocao := fRetornaPrecosPromocao(qryCadIte.FieldByName('ITE_CODITE').AsString,
                                 fatVendas.strCodCli,
                                 VS_Date,
                                 1,
                                 0,
                                 0,
                                 fatVendas.intPrzMed,
                                 fatVendas.fltProPreCus,
                                 fatVendas.fltProPreVen,
                                 fatVendas.fltProComVar,
                                 fatVendas.fltProComAta,
                                 fatVendas.fltProComDis,
                                 fltQtdDis,
                                 fatVendas.fltProDesF07,
                                 fatVendas.strComPro,
                                 fatVendas.strCodPro,
                                 blnParticiona,
                                 blnPromo,
                                 fatVendas.strTabPre,
                                 fatVendas.strCodCnd);
  End;

  If (Not fatVendas.blnCliFil) Then
  Begin
    If (blnPrecoPromocao) Then
    Begin
      If Not blnParticiona Then
      begin
        fatVendas.strPromoc := 'S';

        If (fatVendas.strPromoc = 'S') And
           (fatVendas.fltProPreCus > 0) and
           (fatVendas.fRegraPrecoSugestaoAtiva = TRegraPrecoSugestao.PrecoDePromocao) Then
        begin
          Result := fatVendas.fltProPreCus
        end
        Else
          Result := qryCadIte.FieldByName('ITE_PRECUS').AsFloat;

      end;
    End;
  End;
end;

function TFatVendasCalculadorWrapper.fPegaPrecoVenda(qryCadIte: TDataset; strEntSai: String; fltMargem: Double; blnItemEspecial : Boolean = False; strIdePro: String = 'NOR'; strTabPreItem: String = ''):Double;
begin
  Result := fPegaPrecoVenda(qryCadIte, '', strEntSai, fltMargem, blnItemEspecial, strIdePro, strTabPreItem);
end;

function TFatVendasCalculadorWrapper.fPegaPrecoVenda(qryCadIte: TDataset; strEmpIte, strEntSai: String; fltMargem: Double; blnItemEspecial: Boolean;
  strIdePro, strTabPreItem: String): Double;
var
  blnParticiona: Boolean;
  blnPromo: Boolean;
  fltQtdDis: Double;
  fltTaxJur: Double;
  fltUniVis: Double;
begin
  blnParticiona := False;
  fatVendas.strPromoc := 'N';
  blnPromo := False;
  fltQtdDis := 0;

  If (Not fatVendas.blnCliFil) And
     (fatVendas.fItemPassivelDeVerificacaoPromo(qryCadIte.FieldByName('ITE_CODITE').AsString, VS_strCodEmp)) Then
  Begin
    If (fRetornaPrecosPromocao(qryCadIte.FieldByName('ITE_CODITE').AsString,
                               fatVendas.strCodCli,
                               VS_Date,
                               1,
                               0,
                               0,
                               fatVendas.intPrzMed,
                               fatVendas.fltProPreCus,
                               fatVendas.fltProPreVen,
                               fatVendas.fltProComVar,
                               fatVendas.fltProComAta,
                               fatVendas.fltProComDis,
                               fltQtdDis,
                               fatVendas.fltProDesF07,
                               fatVendas.strComPro,
                               fatVendas.strCodPro,
                               blnParticiona,
                               blnPromo,
                               strTabPreItem,
                               fatVendas.strCodCnd)) Then
    Begin
      If Not blnParticiona Then
        fatVendas.strPromoc := 'S';
    End;
  End;

  Result := fatVendas.fPegaPrecoVenda(qryCadIte, strEmpIte, strEntSai, fltMargem, blnItemEspecial, strIdePro, strTabPreItem, False, fltTaxJur, fltUniVis);

end;

function TFatVendasCalculadorWrapper.GetIntPrzMed: Integer;
begin
  Result := fatVendas.GetIntPrzMed;
end;

function TFatVendasCalculadorWrapper.GetQryConIte: TUniQuery;
begin
  Result := fatVendas.GetQryConIte;
end;

function TFatVendasCalculadorWrapper.GetStrClaFis: string;
begin
  Result := fatVendas.GetStrClaFis;
end;

function TFatVendasCalculadorWrapper.GetStrCodCli: string;
begin
  Result := fatVendas.GetStrCodCli;
end;

function TFatVendasCalculadorWrapper.GetStrCodCnd: string;
begin
  Result := fatVendas.GetStrCodCnd;
end;

function TFatVendasCalculadorWrapper.GetStrOpcDoc: string;
begin
  Result := fatVendas.GetStrOpcDoc;
end;

end.

