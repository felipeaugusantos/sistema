unit untRegraCalculoIva; // procurar por obj

interface

uses Faturamento.Impostos.Interfaces.Iva, untTypesST,
  Faturamento.Impostos.Interfaces.Model, Shared.Functions.Core;

type
  TRegraCalculoIva = class abstract(TInterfacedObject, IAbstractRegraTributacaoIva, IResultadoTributacaoIva)
  private
    FCore: IFunctionsCore;
    FModelClienteFornecedor: IResultadoFaturamentoImpostosModelClienteFornecedor;
    FModelProduto: IResultadoFaturamentoImpostosModelProduto;
    FModelEmpresa: IResultadoFaturamentoImpostosModelEmpresa;
    FParametros: TParametrosCalculoIva;

    FValorDoIva: Double;
    FValorDoIvaMatriz: Double;
    FValorDoIvaSTMatriz: Double;

    FClienteIVAEspMT: Double;
    FClienteIVANacMT: Double;
    FClienteIVASimMT: Double;

    procedure CalcularValorDoIvaCNAESimplificadoForaDoEstado;

    procedure CalcularValorDoIvaCNAESimplificadoMatriz;

    function ValorDoIvaMatrizCNAESimplificado: Double;
    function ValorDoIvaSTMatrizCNAESimplificado: Double;

    function ClienteIVAEspMT: Double;
    function ClienteIVANacMT: Double;
    function ClienteIVASimMT: Double;

    function ClienteIVAEspecialMT: Boolean;

    function CstImportacaoClienteIVAEspMT: Boolean;
    function CstImportacaoClienteIVANacMT: Boolean;

    function ValorDoIvaMatrizInicial: Double;
    function ValorDoIvaSTMatrizInicial: Double;

    function ValorDoIvaMatrizInicialDentroDoEstado: Double;
    function ValorDoIvaMatrizInicialForaDoEstado: Double;

    function ValorDoIvaSTMatrizInicialDentroDoEstado: Double;
    function ValorDoIvaSTMatrizInicialForaDoEstado: Double;

    function CalculaSTClienteConsumidorFinalNCOEspiritoSanto: Boolean;
    function SubstituicaoTributariaDoItem: Boolean;

    function SimplesNacionalSubstituicaoTributaria: Boolean;
    function ResultadoDoCalculoDoIva: IResultadoCalculoIva; overload; virtual;
  public
    procedure IniciarIvaCliente; virtual;
    procedure IniciarIvaAliquota; virtual;
    procedure CalcularValorDoIvaEspMTOuNacMT; virtual;
    procedure AdicionarValorDoIvaAosCamposParaMatriz; virtual;
    procedure CalcularValorDoIvaCNAESimplificado; virtual;

    function ResultadoDoCalculoDoIva(const NullParameter: String): TResultadoCalculoIva; overload; virtual;

    function GetParametros: TParametrosCalculoIva;
    procedure CalcularValorDoIvaCNAESimplificadoDentroDoEstado;
    constructor Create(AParametros: TParametrosCalculoIva;
      AModelClienteFornecedor: IResultadoFaturamentoImpostosModelClienteFornecedor;
      AModelProduto: IResultadoFaturamentoImpostosModelProduto;
      AModelEmpresa: IResultadoFaturamentoImpostosModelEmpresa;
      ACore: IFunctionsCore); virtual;
  end;

implementation

uses Shared.Functions.Funcoes.Faturamento, System.StrUtils,
     Shared.Functions.Constantes, System.SysUtils;

{ TRegraCalculoIva }

function TRegraCalculoIva.CalculaSTClienteConsumidorFinalNCOEspiritoSanto: Boolean;
begin
  Result :=
    TFunctionFuncoesFaturamento.
      CalcSTCliConNCOEspSto(FModelEmpresa.EmpresaEstado,
                            FParametros.TipoDaAbreviacaoFiscal,
                            FModelClienteFornecedor.ConsumidorFinal,
                            FParametros.DentroDoEstado,
                            FModelProduto.ImportacaoDireta = 'S',
                            FParametros.CodigoDaSubstituicaoTributaria);
end;

function TRegraCalculoIva.ClienteIVAEspecialMT: Boolean;
begin
  Result :=
    TFunctionFuncoesFaturamento.
      ClienteIVAEspecialMT(FModelClienteFornecedor.ClienteEstado,
                           FModelEmpresa.EmpresaEstado,
                           FClienteIVAEspMT);
end;

function TRegraCalculoIva.ClienteIVAEspMT: Double;
begin
  Result :=
    TFunctionFuncoesFaturamento.
      GetCliIVAEspMT(FParametros.DocumentoParaFornecedor,
                     FModelClienteFornecedor.ClienteInscricaoEstadual,
                     FModelClienteFornecedor.ClienteEstado,
                     FModelClienteFornecedor.ValorIVAEspecialClienteMT,
                     FParametros.ExisteNaTabelaCEDEM,
                     FModelClienteFornecedor.ValorIVAEspecialClienteMTCedem);
end;

function TRegraCalculoIva.ClienteIVASimMT: Double;
begin
  Result :=
    TFunctionFuncoesFaturamento.
      GetCliIVASimMT(FParametros.DocumentoParaFornecedor,
                     FModelClienteFornecedor.ClienteInscricaoEstadual,
                     FModelClienteFornecedor.ClienteEstado,
                     FModelClienteFornecedor.ValorIVASimClienteMT,
                     FParametros.ExisteNaTabelaCEDEM,
                     FModelClienteFornecedor.ValorIVASimClienteMTCedem);
end;

constructor TRegraCalculoIva.Create(AParametros: TParametrosCalculoIva;
      AModelClienteFornecedor: IResultadoFaturamentoImpostosModelClienteFornecedor;
      AModelProduto: IResultadoFaturamentoImpostosModelProduto;
      AModelEmpresa: IResultadoFaturamentoImpostosModelEmpresa;
      ACore: IFunctionsCore);
begin
  FParametros := AParametros;
  FModelClienteFornecedor := AModelClienteFornecedor;
  FModelProduto := AModelProduto;
  FModelEmpresa := AModelEmpresa;
  FCore := ACore;
end;

function TRegraCalculoIva.ClienteIVANacMT: Double;
begin
  Result :=
    TFunctionFuncoesFaturamento.
      GetCliIVANacMT(FParametros.DocumentoParaFornecedor,
                     FModelClienteFornecedor.ClienteInscricaoEstadual,
                     FModelClienteFornecedor.ClienteEstado,
                     FModelClienteFornecedor.ValorIVANacClienteMT,
                     FParametros.ExisteNaTabelaCEDEM,
                     FModelClienteFornecedor.ValorIVANacClienteMTCedem);
end;

function TRegraCalculoIva.CstImportacaoClienteIVAEspMT: Boolean;
begin
  Result := False;

  If (Not MatchStr(Copy(FParametros.CodigoDaSituacaoTributaria, 1, 1), ArrIvaCstImportacao)) Then
    Exit;

  If (FClienteIVAEspMT <= 0) Then
    Exit;

  Result := True;
end;

function TRegraCalculoIva.CstImportacaoClienteIVANacMT: Boolean;
begin
  Result := False;

  If (MatchStr(Copy(FParametros.CodigoDaSituacaoTributaria, 1, 1), ArrIvaCstImportacao)) Then
    Exit;

  If (FClienteIVANacMT <= 0) Then
    Exit;

  Result := True;
end;

function TRegraCalculoIva.GetParametros: TParametrosCalculoIva;
begin
  Result := FParametros;
end;

procedure TRegraCalculoIva.CalcularValorDoIvaEspMTOuNacMT;
begin
  If CstImportacaoClienteIVAEspMT Then
  Begin
    FValorDoIva := FClienteIVAEspMT;
    Exit;
  End;

  If CstImportacaoClienteIVANacMT Then
  Begin
    FValorDoIva := FClienteIVANacMT;
    Exit;
  End;
end;

procedure TRegraCalculoIva.CalcularValorDoIvaCNAESimplificado;
begin
  If FParametros.DentroDoEstado Then
  Begin
    CalcularValorDoIvaCNAESimplificadoDentroDoEstado;
    Exit;
  End;

  CalcularValorDoIvaCNAESimplificadoForaDoEstado;
end;

procedure TRegraCalculoIva.AdicionarValorDoIvaAosCamposParaMatriz;
begin
  FValorDoIvaMatriz   := 0.0;
  FValorDoIvaSTMatriz := 0.0;

  If FValorDoIva > 1 Then
  Begin
    FValorDoIvaMatriz   := FCore.fFormataFloat((ValorDoIvaMatrizInicial - 1) * 100, 2);
    FValorDoIvaSTMatriz := ValorDoIvaSTMatrizInicial;
  End;
end;

function TRegraCalculoIva.SimplesNacionalSubstituicaoTributaria: Boolean;
begin
  Result := False;

  If Not TFunctionFuncoesFaturamento.EmpresaOptanteSimples(TFunctionFuncoesFaturamento.OptantePorSimplesNacional) Then
    Exit;

  If Not TFunctionFuncoesFaturamento.SubstituicaoTributaria(FParametros.CodigoDaSubstituicaoTributaria) Then
    Exit;

  Result := True;
end;

function TRegraCalculoIva.SubstituicaoTributariaDoItem: Boolean;
begin
  Result := TFunctionFuncoesFaturamento.SubstituicaoTributaria(FParametros.CodigoDaSubstituicaoTributaria);
end;

procedure TRegraCalculoIva.CalcularValorDoIvaCNAESimplificadoDentroDoEstado;
var
  LImportacaoDireta: Boolean;
  LAliquotaDeIcmsDoItem: Double;
begin
  If not SubstituicaoTributariaDoItem Then
    Exit;

  LImportacaoDireta := TFunctionFuncoesFaturamento.ImportacaoDireta(FModelProduto.ImportacaoDireta);

  If not TFunctionFuncoesFaturamento.ValidarImportacaoDiretaClienteIvaSimMT(LImportacaoDireta, FClienteIVASimMT, FParametros.TotalGeralDoItem) Then
    Exit;

  LAliquotaDeIcmsDoItem :=
    TFunctionFuncoesFaturamento
      .RetornaAliquotaIcmConformeRegraMatoGrosso(FParametros.AliquotaDeIcmsDoItem,
                                                 FParametros.AliquotaDaSubstituicaoTributariaDoItem,
                                                 FParametros.DentroDoEstado,
                                                 FModelClienteFornecedor.ConsumidorFinal);

  FValorDoIva :=
    TFunctionFuncoesFaturamento.
      CalcularValorDoIVA(FParametros.TotalGeralDoItem,
                         LAliquotaDeIcmsDoItem,
                         FParametros.ValorDeIpiDoItem ,
                         FClienteIVASimMT,
                         FParametros.AliquotaDaSubstituicaoTributariaDoItem);

  CalcularValorDoIvaCNAESimplificadoMatriz;
end;

procedure TRegraCalculoIva.CalcularValorDoIvaCNAESimplificadoForaDoEstado;
begin
  If SimplesNacionalSubstituicaoTributaria Then
    Exit;

  If FClienteIVASimMT <= 0 Then
    Exit;

  If (FParametros.TotalGeralDoItem <= 0) Then
    Exit;

  FValorDoIva :=
    TFunctionFuncoesFaturamento.
      CalcularValorDoIVA(FParametros.TotalGeralDoItem,
                         FParametros.AliquotaDeIcmsDoItem,
                         FParametros.ValorDeIpiDoItem ,
                         FClienteIVASimMT,
                         FParametros.AliquotaDaSubstituicaoTributariaDoItem);

  CalcularValorDoIvaCNAESimplificadoMatriz;
end;

procedure TRegraCalculoIva.CalcularValorDoIvaCNAESimplificadoMatriz;
begin
  FValorDoIvaMatriz   := 0.0;
  FValorDoIvaSTMatriz := 0.0;

  If FValorDoIva > 1 Then
  Begin
    FValorDoIvaMatriz   := FCore.fFormataFloat((ValorDoIvaMatrizCNAESimplificado - 1) * 100, 2);
    FValorDoIvaSTMatriz := ValorDoIvaSTMatrizCNAESimplificado;
  End;
end;

function TRegraCalculoIva.ValorDoIvaMatrizCNAESimplificado: Double;
begin
  Result := FValorDoIva;

  If Not FModelClienteFornecedor.ConsumidorFinal Then
    Exit;

  Result := 1;
end;

function TRegraCalculoIva.ValorDoIvaMatrizInicial: Double;
begin
  If FParametros.DentroDoEstado Then
  Begin
    Result := ValorDoIvaMatrizInicialDentroDoEstado;
    Exit;
  End;

  Result := ValorDoIvaMatrizInicialForaDoEstado;
end;

function TRegraCalculoIva.ValorDoIvaMatrizInicialDentroDoEstado: Double;
begin
  Result := FValorDoIva;

  If Not FModelClienteFornecedor.ConsumidorFinal Then
    Exit;

  If CalculaSTClienteConsumidorFinalNCOEspiritoSanto Then
    Exit;

  Result := 1;
end;

function TRegraCalculoIva.ValorDoIvaMatrizInicialForaDoEstado: Double;
begin
  Result := FValorDoIva;

  If Not FModelClienteFornecedor.ConsumidorFinal Then
    Exit;

  If ClienteIVAEspecialMT Then
    Exit;

  Result := 1;
end;

function TRegraCalculoIva.ValorDoIvaSTMatrizCNAESimplificado: Double;
begin
  Result := FValorDoIva;

  If Not FModelClienteFornecedor.ConsumidorFinal Then
    Exit;

  Result := 0;
end;

function TRegraCalculoIva.ValorDoIvaSTMatrizInicial: Double;
begin
  If FParametros.DentroDoEstado Then
  Begin
    Result := ValorDoIvaStMatrizInicialDentroDoEstado;
    Exit;
  End;

  Result := ValorDoIvaStMatrizInicialForaDoEstado;
end;

function TRegraCalculoIva.ValorDoIvaSTMatrizInicialDentroDoEstado: Double;
begin
  Result := FValorDoIva;

  If Not FModelClienteFornecedor.ConsumidorFinal Then
    Exit;

  If CalculaSTClienteConsumidorFinalNCOEspiritoSanto Then
    Exit;

  Result := 0;
end;

function TRegraCalculoIva.ValorDoIvaSTMatrizInicialForaDoEstado: Double;
begin
  Result := FValorDoIva;

  If Not FModelClienteFornecedor.ConsumidorFinal Then
    Exit;

  If ClienteIVAEspecialMT Then
    Exit;

  Result := 0;
end;

procedure TRegraCalculoIva.IniciarIvaCliente;
begin
  FClienteIVAEspMT := ClienteIVAEspMT;
  FClienteIVANacMT := ClienteIVANacMT;
  FClienteIVASimMT := ClienteIVASimMT;
end;

function TRegraCalculoIva.ResultadoDoCalculoDoIva: IResultadoCalculoIva;
begin
  raise Exception.Create('Chamada de Método Inválido! [TRegraCalculoIva.ResultadoDoCalculoDoIva]');
end;

function TRegraCalculoIva.ResultadoDoCalculoDoIva(const NullParameter: String): TResultadoCalculoIva;
begin
  FillChar(Result, SizeOf(Result), #0);
  Result.ValorDoIva := FValorDoIva;
  Result.ValorDoIvaMatriz := FValorDoIvaMatriz;
  Result.ValorDoIvaStMatriz := FValorDoIvaStMatriz;
  Result.ClienteIVAEspMT := FClienteIVAEspMT;
end;

procedure TRegraCalculoIva.IniciarIvaAliquota;
begin
  FValorDoIva := FParametros.PercentualDoIvaAbreviacao;
end;

end.
