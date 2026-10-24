unit Faturamento.Impostos.Calculos.FCP;

interface

uses
  Faturamento.Impostos.Interfaces.FCP, Faturamento.Impostos.Tipos.FCP,
  Shared.Functions.Core, Shared.Functions.Types, Shared.Functions.Constantes;

type
  TCalculoImpostosFCP = class(TInterfacedObject, ICalculoImpostosFCP)
  strict private
    FSairDoProcedimento: Boolean;
    FZerarDifal: Boolean;
    FGravarOsRegistros: Boolean;

    FRecordDifalFCP: TRecDifalFCP;

    FValorFCP: Double;
    FBaseFCP: Double;
    FBaseDestino: Double;
    FAliquotaFCP: Double;
    FAliquotaFCPST: Double;

    function CalcularFcp(const AParametros: IParametrosCalculoFCP): Boolean;
    function OutrasSaidasParaFornecedoresOuProdutoIndustrializadoDentroDoEstado(const AParametros: IParametrosCalculoFCP): Boolean;
    function ResultadoDoCalculoDoFCP: IResultadoCalculoFCP;
    function GravarOsRegistrosOperacaoPropriaESubstituicaoTributaria(const AParametros: IParametrosCalculoFCP): Boolean;
    function RegrasGravarOperacaoPropriaESubstituicaoTributaria(const AParametros: IParametrosCalculoFCP): Boolean;
    function NaoEhSubstituicaoTributariaDoItemENaoEhDocumentoDeDevolucao(const AParametros: IParametrosCalculoFCP): Boolean;
    function GravarOsRegistrosAmparaRSICMSST(const AParametros: IParametrosCalculoFCP): Boolean;
    function GravarOsRegistrosDemaisRegras(const AParametros: IParametrosCalculoFCP): Boolean;
    function GravarOsRegistrosVendaPresencialEstadosLegislacaoAmpara(const AParametros: IParametrosCalculoFCP) : Boolean;
    function RegraGravarClienteEstadoAmpara(const AParametros: IParametrosCalculoFCP): Boolean;
    function RegraGravarAmparaBaseDeCalculoDaSubstituicaoTributaria(const AParametros: IParametrosCalculoFCP): Boolean;

    procedure pIniciandoVariaveis(const AParametros: IParametrosCalculoFCP);
    function CalcularFcpOperacaoPropria_e_FcpSubstituicaoTributaria(const AParametros: IParametrosCalculoFCP): IResultadoCalculoFCP;
    procedure ZerarVariaveisFCP;
    function CalcularBeneficioReducaoBaseIcmsST(const AParametros: IParametrosCalculoFCP): IResultadoCalculoFCP;
    function CalcularFCPDemaisRegras(const AParametros: IParametrosCalculoFCP): IResultadoCalculoFCP;
    procedure IniciarAliquotaFCP(const AParametros: IParametrosCalculoFCP);
    procedure CalcularFcpOperacaoPropria_e_FcpSubstituicaoTributariaComBaseDeCalculoDaSubstituicaoTributaria(const AParametros: IParametrosCalculoFCP);
    procedure ProdutoIndustrializadoDentroDoEstadoAjustaValorFcpSubstituicaoTributacao(const AParametros: IParametrosCalculoFCP);
    procedure ProdutoRevendaDentroDoEstadoAjustaValorFcpSubstituicaoTributacao(const AParametros: IParametrosCalculoFCP);
    procedure ProdutoIndustrializadoDentroDoEstadoAjustaValorFcpSubstituicaoTributacaoSimplesNacional(const AParametros: IParametrosCalculoFCP);
    procedure ProdutoRevendaDentroDoEstadoAjustaValorFcpSubstituicaoTributacaoSimplesNacional(const AParametros: IParametrosCalculoFCP);
    function ProdutoIndustrializadoDentroDoEstadoComValorFCP(const AParametros: IParametrosCalculoFCP): Boolean;
    function ProdutoRevendaDentroDoEstadoComValorFCP(const AParametros: IParametrosCalculoFCP): Boolean;
    function ZerarFCP(const AParametros: IParametrosCalculoFCP): Boolean;
    procedure CalcularBeneficioReducaoBaseIcmsSTDiferencaEntreBaseDaSubstituicaoTributariaEBaseDeIcms(const AParametros: IParametrosCalculoFCP);
    procedure DefinirBaseDeDestino(const AParametros: IParametrosCalculoFCP);
    procedure VerificaSeDeveZerarBaseDestino(const AParametros: IParametrosCalculoFCP);
    procedure VerificaSeDeveZerarFCP(const AParametros: IParametrosCalculoFCP);
    procedure CalcularBeneficioReducaoBaseIcmsSTZerarFCP(const AParametros: IParametrosCalculoFCP);
    procedure CalcularFcpOperacaoPropria_e_FcpSubstituicaoTributariaZerarFcp(const AParametros: IParametrosCalculoFCP);
    procedure CalcularFCPComDiferencaEntreBaseDaSubstituicaoTributariaEBaseDeIcms(const AParametros: IParametrosCalculoFCP);
    function CalculaFCPComReducaoBaseIcmsST(const AParametros: IParametrosCalculoFCP): IResultadoCalculoFCP;
    function RetornaBaseDeCalculoDoIcmsDoItem(const AParametros: IParametrosCalculoFCP): Double;
    function FazParteDosEstadosAmpara(const AClienteEstado : String): Boolean;
  public
    function CalcularValorFCP(AParametros: IParametrosCalculoFCP): IResultadoCalculoFCP;
//    function CalcularValorDifalFcp(AParametros: IParametrosCalculoDifalFcp): IResultadoCalculoDifalFcp;

    class function New(): ICalculoImpostosFCP;
  end;

type
  TCalculoImpostosDifalFCP = class(TInterfacedObject, ICalculoImpostosDifalFcp)
  strict private
    FAliquotaDifalDoItem: Double;
    FIcmsOrigem: Double;
    FIcmsDestino: Double;
    FBaseFCP: Double;
    FValorFCP: Double;

    procedure IniciarVariaveis(const AParametros: IParametrosCalculoDifalFcp);
    procedure VerificarSimplesNacional(const AParametros: IParametrosCalculoDifalFcp);
    procedure DefinirBaseFcp(const AParametros: IParametrosCalculoDifalFcp);
    procedure DefinirValorFcp(const AParametros: IParametrosCalculoDifalFcp);
    procedure ZerarBaseEValorDeFcp(const AParametros: IParametrosCalculoDifalFcp);

    function ZerarFcp(const AParametros: IParametrosCalculoDifalFcp): Boolean;

    function ResultadoDifalFcp: IResultadoCalculoDifalFcp;
  public
    function CalcularValorDifalFcp(AParametros: IParametrosCalculoDifalFcp): IResultadoCalculoDifalFcp; overload;

    class function New(): ICalculoImpostosDifalFCP;
  end;

implementation

uses Shared.Functions.Configuracoes;

{ TCalculoImpostosFCP }

function TCalculoImpostosFCP.CalcularFcp(const AParametros: IParametrosCalculoFCP): Boolean;
begin
  Result := False;

  If AParametros.AtendeRegrasDIFAL Then
    Exit;

  Result := True;
end;

function TCalculoImpostosFCP.CalcularValorFCP(
  AParametros: IParametrosCalculoFCP): IResultadoCalculoFCP;
begin
  pIniciandoVariaveis(AParametros);

  If Not CalcularFcp(AParametros) Then
  Begin
    Result := ResultadoDoCalculoDoFCP;
    Exit
  End;

  If (AParametros.ProdutoEmbalagem = 'S') Then
  Begin
    Result := ResultadoDoCalculoDoFCP;
    Exit;
  End;

  IniciarAliquotaFCP(AParametros);

  If OutrasSaidasParaFornecedoresOuProdutoIndustrializadoDentroDoEstado(AParametros) Then
  Begin
    Result := CalcularFcpOperacaoPropria_e_FcpSubstituicaoTributaria(AParametros);
    Exit;
  End;

  If AParametros.ProdutoRevendaDentroDoEstado Then
  Begin
    Result := CalcularFcpOperacaoPropria_e_FcpSubstituicaoTributaria(AParametros);
    Exit;
  End;

  If AParametros.CalcularBeneficioReducaoBaseIcmsST Then
  Begin
    Result := CalcularBeneficioReducaoBaseIcmsST(AParametros);
    Exit;
  End;

  If AParametros.CalculaFCPComReducaoBaseIcmsST Then
  Begin
    Result := CalculaFCPComReducaoBaseIcmsST(AParametros);
    Exit;
  End;

  Result := CalcularFCPDemaisRegras(AParametros);
end;

//function TCalculoImpostosFCP.CalcularValorDifalFcp(
//  AParametros: IParametrosCalculoDifalFcp): IResultadoCalculoDifalFcp;
//  Var
//    LAliquotaDifalDoItem: Double;
//    LIcmsOrigem: Double;
//    LIcmsDestino: Double;
//    LBaseFCP: Double;
//    LValorFCP: Double;
//begin
//  LAliquotaDifalDoItem := AParametros.AliquotaDifalDoItem;
//  LIcmsOrigem          := AParametros.IcmsDeOrigem;
//  LIcmsDestino         := AParametros.IcmsDeDestino;
//
//  If (LAliquotaDifalDoItem < 0) Then
//    LAliquotaDifalDoItem := 0;
//
//  If AParametros.SimplesNacional Then
//  Begin
//    If (Not AParametros.EnviarIcmsDifalDoRemetenteNaPartilha) Then
//      LIcmsOrigem := 0;
//
//    If (Not AParametros.EnviarIcmsDifalDoDestinoNaPartilha) Then
//      LIcmsDestino := 0;
//  End;
//
//  If (AParametros.BaseDeCalculoDaSubstituicaoTributariaDoItem > 0) Then
//    LBaseFCP := AParametros.BaseDeCalculoDaSubstituicaoTributariaDoItem
//  Else
//    LBaseFCP := AParametros.BaseDestino;
//
//  LValorFCP := objCore.fFormataFloat(LBaseFCP * AParametros.AliquotaFCPDoItem / 100, 2);
//
//  Result :=
//    TResultadoCalculoDifalFcp.New
//      .AliquotaDifalDoItem(LAliquotaDifalDoItem)
//      .IcmsDeOrigem(LIcmsOrigem)
//      .IcmsDeDestino(LIcmsDestino)
//      .BaseFCP(LBaseFCP)
//      .ValorFCP(LValorFCP)
//end;

function TCalculoImpostosFCP.GravarOsRegistrosAmparaRSICMSST(
  const AParametros: IParametrosCalculoFCP): Boolean;
begin
  Result := True;

  If RegraGravarClienteEstadoAmpara(AParametros) Then
    Exit;

  If RegraGravarAmparaBaseDeCalculoDaSubstituicaoTributaria(AParametros) Then
    Exit;

  Result := False;
end;

function TCalculoImpostosFCP.GravarOsRegistrosOperacaoPropriaESubstituicaoTributaria(
  const AParametros: IParametrosCalculoFCP): Boolean;
begin
  Result := False;

  If (FValorFCP <= 0) Then
    Exit;

  If Not RegrasGravarOperacaoPropriaESubstituicaoTributaria(AParametros) Then
    Exit;

  Result := True;
end;

procedure TCalculoImpostosFCP.IniciarAliquotaFCP(const AParametros: IParametrosCalculoFCP);
begin
  FAliquotaFCP := AParametros.AliquotaFCPAbrevicaoIcms;
end;

function TCalculoImpostosFCP.NaoEhSubstituicaoTributariaDoItemENaoEhDocumentoDeDevolucao(
  const AParametros: IParametrosCalculoFCP): Boolean;
begin
  Result := False;

  If AParametros.SubstituicaoTributariaDoItem Then
    Exit;

  If AParametros.DocumentoDeDevolucao Then
    Exit;

  Result := True;
end;

class function TCalculoImpostosFCP.New: ICalculoImpostosFCP;
begin
  Result := Self.Create;
end;

function TCalculoImpostosFCP.OutrasSaidasParaFornecedoresOuProdutoIndustrializadoDentroDoEstado(
  const AParametros: IParametrosCalculoFCP): Boolean;
begin
  Result := True;

  If AParametros.OutrasSaidasParaFornecedores Then
    Exit;

  If AParametros.ProdutoIndustrializadoDentroDoEstado Then
    Exit;

  Result := False;
end;

procedure TCalculoImpostosFCP.pIniciandoVariaveis(const AParametros: IParametrosCalculoFCP);
begin
  FSairDoProcedimento := False;
  FGravarOsRegistros  := False;
  FZerarDifal         := False;
  FBaseDestino        := 0;
  FBaseFCP            := 0;
  FValorFCP           := 0;
  FAliquotaFCPST      := AParametros.AliquotaFCPST;
  FAliquotaFCP        := 0;
  FRecordDifalFCP     := AParametros.RecordDifalFCP;
end;

procedure TCalculoImpostosFCP.ProdutoIndustrializadoDentroDoEstadoAjustaValorFcpSubstituicaoTributacao(
  const AParametros: IParametrosCalculoFCP);
begin
  If Not ProdutoIndustrializadoDentroDoEstadoComValorFCP(AParametros) Then
    Exit;

  FRecordDifalFCP.fltValFcp := objCore.fFormataFloat(FRecordDifalFCP.fltValFcp - FValorFCP, 2);

  If (objCore.fFormataFloat(FRecordDifalFCP.fltValFcp, 2) >= 0) Then
    Exit;

  FRecordDifalFCP.fltValFcp := 0;
end;

procedure TCalculoImpostosFCP.ProdutoRevendaDentroDoEstadoAjustaValorFcpSubstituicaoTributacao(
  const AParametros: IParametrosCalculoFCP);
begin
  If Not ProdutoRevendaDentroDoEstadoComValorFCP(AParametros) Then
    Exit;

  FRecordDifalFCP.fltValFcp := objCore.fFormataFloat(FRecordDifalFCP.fltValFcp - FValorFCP, 2);

  If (objCore.fFormataFloat(FRecordDifalFCP.fltValFcp, 2) >= 0) Then
    Exit;

  FRecordDifalFCP.fltValFcp := 0;
end;

procedure TCalculoImpostosFCP.ProdutoIndustrializadoDentroDoEstadoAjustaValorFcpSubstituicaoTributacaoSimplesNacional(
  const AParametros: IParametrosCalculoFCP);
begin
  If not AParametros.SimplesNacional Then
    Exit;

  FBaseFCP  := 0;
  FValorFCP := 0;
end;

procedure TCalculoImpostosFCP.ProdutoRevendaDentroDoEstadoAjustaValorFcpSubstituicaoTributacaoSimplesNacional(
  const AParametros: IParametrosCalculoFCP);
begin
  If Not ProdutoRevendaDentroDoEstadoComValorFCP(AParametros) Then
    Exit;

  If not AParametros.SimplesNacional Then
    Exit;

  FBaseFCP  := 0;
  FValorFCP := 0;
end;

function TCalculoImpostosFCP.ProdutoIndustrializadoDentroDoEstadoComValorFCP(
  const AParametros: IParametrosCalculoFCP): Boolean;
begin
  Result := False;

  If Not AParametros.ProdutoIndustrializadoDentroDoEstado Then
    Exit;

  If (objCore.fFormataFloat(FValorFCP, 2) <= 0) then
    Exit;

  Result := True;
end;

function TCalculoImpostosFCP.ProdutoRevendaDentroDoEstadoComValorFCP(
  const AParametros: IParametrosCalculoFCP): Boolean;
begin
  Result := False;

  If Not AParametros.ProdutoRevendaDentroDoEstado Then
    Exit;

  If (objCore.fFormataFloat(FValorFCP, 2) <= 0) then
    Exit;

  Result := True;
end;

function TCalculoImpostosFCP.ZerarFCP(
  const AParametros: IParametrosCalculoFCP): Boolean;
begin
  Result := False;

  If Not AParametros.ZerarFCP Then
    Exit;

  If Not FGravarOsRegistros Then
    Exit;

  Result := True;
end;

procedure TCalculoImpostosFCP.ZerarVariaveisFCP;
begin
  FBaseFCP     := 0;
  FValorFCP    := 0;
  FAliquotaFCP := 0;
  FRecordDifalFCP.fltValFcp := 0;
  FRecordDifalFCP.fltPerFcp := 0;
  FRecordDifalFCP.fltBasFcp := 0;
end;

function TCalculoImpostosFCP.CalcularFcpOperacaoPropria_e_FcpSubstituicaoTributaria(const AParametros: IParametrosCalculoFCP): IResultadoCalculoFCP;
begin
  If (FRecordDifalFCP.fltPerFcp > 0) Then
    FAliquotaFCP := FRecordDifalFCP.fltPerFcp;

  FBaseDestino := AParametros.BaseDeCalculoDoIcmsDoItem;
  FBaseFCP     := FBaseDestino;
  FValorFCP    := objCore.fFormataFloat(FBaseFCP * FAliquotaFCP / 100, 2);

  if AParametros.DevolucaoInterestadualComProdutoSt Then
  Begin
    FBaseFCP  := 0;
    FValorFCP := 0;
  End;

  FGravarOsRegistros := GravarOsRegistrosOperacaoPropriaESubstituicaoTributaria(AParametros);

  CalcularFcpOperacaoPropria_e_FcpSubstituicaoTributariaComBaseDeCalculoDaSubstituicaoTributaria(AParametros);

  FSairDoProcedimento := True;

  Result := ResultadoDoCalculoDoFCP;
end;

procedure TCalculoImpostosFCP.CalcularFcpOperacaoPropria_e_FcpSubstituicaoTributariaComBaseDeCalculoDaSubstituicaoTributaria(const AParametros: IParametrosCalculoFCP);
begin
  If (AParametros.BaseDeCalculoDaSubstituicaoTributariaDoItem <= 0) Then
    Exit;

  FAliquotaFCPST := FAliquotaFCP;

  FRecordDifalFCP.fltBasFcp := AParametros.BaseDeCalculoDaSubstituicaoTributariaDoItem;
  FRecordDifalFCP.fltValFcp := objCore.fFormataFloat(AParametros.BaseDeCalculoDaSubstituicaoTributariaDoItem * FAliquotaFCPST / 100, 2);

  ProdutoRevendaDentroDoEstadoAjustaValorFcpSubstituicaoTributacao(AParametros);

  ProdutoRevendaDentroDoEstadoAjustaValorFcpSubstituicaoTributacaoSimplesNacional(AParametros);

  ProdutoIndustrializadoDentroDoEstadoAjustaValorFcpSubstituicaoTributacao(AParametros);

  ProdutoIndustrializadoDentroDoEstadoAjustaValorFcpSubstituicaoTributacaoSimplesNacional(AParametros);

  FRecordDifalFCP.fltPerFcp := FAliquotaFCP;

  CalcularFcpOperacaoPropria_e_FcpSubstituicaoTributariaZerarFCP(AParametros);
end;

procedure TCalculoImpostosFCP.CalcularFcpOperacaoPropria_e_FcpSubstituicaoTributariaZerarFcp(
  const AParametros: IParametrosCalculoFCP);
begin
  If Not ZerarFCP(AParametros) Then
    Exit;

  FAliquotaFCPST := 0;

  ZerarVariaveisFCP;
end;

procedure TCalculoImpostosFCP.DefinirBaseDeDestino(const AParametros: IParametrosCalculoFCP);
begin
  FBaseDestino := AParametros.BaseDeCalculoDoIcmsDoItem;

  If (AParametros.BaseDeCalculoDaSubstituicaoTributariaDoItem <= 0) Then
    Exit;

  FAliquotaFCPST := FAliquotaFCP;
  FBaseDestino   := AParametros.BaseDeCalculoDaSubstituicaoTributariaDoItem;
end;

procedure TCalculoImpostosFCP.VerificaSeDeveZerarBaseDestino(
  const AParametros: IParametrosCalculoFCP);
begin
  If Not FGravarOsRegistros Then
    Exit;

  FBaseDestino := 0;
end;

procedure TCalculoImpostosFCP.VerificaSeDeveZerarFCP(
  const AParametros: IParametrosCalculoFCP);
begin
  If Not ZerarFCP(AParametros) Then
    Exit;

  ZerarVariaveisFCP;
end;

function TCalculoImpostosFCP.CalcularBeneficioReducaoBaseIcmsST(const AParametros: IParametrosCalculoFCP): IResultadoCalculoFCP;
begin
  FGravarOsRegistros := False;

  CalcularBeneficioReducaoBaseIcmsSTDiferencaEntreBaseDaSubstituicaoTributariaEBaseDeIcms(AParametros);

  FSairDoProcedimento := True;

  Result := ResultadoDoCalculoDoFCP;
end;

function TCalculoImpostosFCP.RetornaBaseDeCalculoDoIcmsDoItem(const AParametros: IParametrosCalculoFCP): Double;
begin
  Result := AParametros.BaseDeCalculoDoIcmsDoItem;

  If Not (AParametros.BaseDeCalculoDoIcmsDoItemBenST > 0) Then
    Exit;

  Result := AParametros.BaseDeCalculoDoIcmsDoItemBenST;
end;

procedure TCalculoImpostosFCP.CalcularBeneficioReducaoBaseIcmsSTDiferencaEntreBaseDaSubstituicaoTributariaEBaseDeIcms(
  const AParametros: IParametrosCalculoFCP);
Var
  LBaseParaCalculoFCP: Double;
  LBaseDeCalculoDoIcmsDoItem: Double;
begin
  LBaseDeCalculoDoIcmsDoItem := RetornaBaseDeCalculoDoIcmsDoItem(AParametros);

  FBaseDestino := LBaseDeCalculoDoIcmsDoItem;

  FBaseFCP     := FBaseDestino;
  FValorFCP    := objCore.fFormataFloat(FBaseFCP * FAliquotaFCP / 100, 2);

  FGravarOsRegistros := (FValorFCP > 0);

  FAliquotaFCPST := FAliquotaFCP;

  LBaseParaCalculoFCP := AParametros.BaseDeCalculoDaSubstituicaoTributariaDoItem - LBaseDeCalculoDoIcmsDoItem;

  if AParametros.BeneficioReducaoBaseIcmsSTBaseFcpStSemDeducaoDeBaseIcms then
    FRecordDifalFCP.fltBasFcp := AParametros.BaseDeCalculoDaSubstituicaoTributariaDoItem
  else
    FRecordDifalFCP.fltBasFcp := LBaseParaCalculoFCP;

  FRecordDifalFCP.fltValFcp := objCore.fFormataFloat(LBaseParaCalculoFCP * FAliquotaFCP / 100, 2);
  FRecordDifalFCP.fltPerFcp := FAliquotaFCP;

  If FRecordDifalFCP.fltValFcp <= 0 Then
  Begin
    FRecordDifalFCP.fltValFcp := 0;
    FRecordDifalFCP.fltPerFcp := 0;
    FRecordDifalFCP.fltBasFcp := 0;
  End;

  CalcularBeneficioReducaoBaseIcmsSTZerarFCP(AParametros);
end;

procedure TCalculoImpostosFCP.CalcularBeneficioReducaoBaseIcmsSTZerarFCP(
  const AParametros: IParametrosCalculoFCP);
begin
  If Not ZerarFCP(AParametros) Then
    Exit;

  FAliquotaFCPST := 0;

  ZerarVariaveisFCP;
end;

function TCalculoImpostosFCP.CalcularFCPDemaisRegras(const AParametros: IParametrosCalculoFCP): IResultadoCalculoFCP;
begin
  DefinirBaseDeDestino(AParametros);

  FBaseFCP  := FBaseDestino;

  FValorFCP := objCore.fFormataFloat(FBaseFCP * FAliquotaFCP / 100, 2);

  // Seta valores calculados na matriz de itens!
  FRecordDifalFCP.fltBasFcp := FBaseFCP;
  FRecordDifalFCP.fltValFcp := FValorFCP;
  FRecordDifalFCP.fltPerFcp := FAliquotaFCP;

  FZerarDifal := True;

  FGravarOsRegistros := GravarOsRegistrosDemaisRegras(AParametros);

  VerificaSeDeveZerarBaseDestino(AParametros);

  VerificaSeDeveZerarFCP(AParametros);

  FSairDoProcedimento := True;

  Result := ResultadoDoCalculoDoFCP;
end;

function TCalculoImpostosFCP.GravarOsRegistrosDemaisRegras(const AParametros: IParametrosCalculoFCP): Boolean;
begin
  Result := True;

  If Pos(AParametros.OpcaoDeDocumento, 'PD_OR_') > 0 Then
    Exit;

  If Pos(AParametros.EspecieDoDocumento, 'PD_OR_') > 0 Then
    Exit;

  If GravarOsRegistrosAmparaRSICMSST(AParametros) Then
    Exit;

  If (GravarOsRegistrosVendaPresencialEstadosLegislacaoAmpara(AParametros)) Then
    Exit;

  Result := False;
end;

function TCalculoImpostosFCP.GravarOsRegistrosVendaPresencialEstadosLegislacaoAmpara(const AParametros: IParametrosCalculoFCP) : Boolean;
begin
  Result := False;

  If (Not AParametros.VendaPresencial) Then
    Exit;

  If (AParametros.ZerarFCP) Then
    Exit;

  If (Not FazParteDosEstadosAmpara(AParametros.ClienteEstado)) Then
    Exit;

  If (objConfiguracoes.fGetValorConfiguracao(CFG_UTILIZAR_LEGISLACAO_AMPARA_VENDA_PARA_OS_ESTADOS_MG_RS, varString) = 'S') Then
    Exit;

  Result := True;
end;

function TCalculoImpostosFCP.RegraGravarAmparaBaseDeCalculoDaSubstituicaoTributaria(
  const AParametros: IParametrosCalculoFCP): Boolean;
begin
  Result := False;

  If (FValorFCP <= 0) Then
    Exit;

  If (AParametros.BaseDeCalculoDaSubstituicaoTributariaDoItem <= 0) Then
    Exit;

  Result := True;
end;

function TCalculoImpostosFCP.RegraGravarClienteEstadoAmpara(
  const AParametros: IParametrosCalculoFCP): Boolean;
begin
  Result := False;

  If (FValorFCP <= 0) Then
    Exit;

  If (FazParteDosEstadosAmpara(AParametros.ClienteEstado)) Then
    Exit;

  Result := True;
end;

function TCalculoImpostosFCP.FazParteDosEstadosAmpara(const AClienteEstado : String): Boolean;
begin
  Result := (Pos(AClienteEstado, ESTADOS_AMPARA) > 0);
end;

function TCalculoImpostosFCP.RegrasGravarOperacaoPropriaESubstituicaoTributaria(
  const AParametros: IParametrosCalculoFCP): Boolean;
begin
  Result := True;

  If NaoEhSubstituicaoTributariaDoItemENaoEhDocumentoDeDevolucao(AParametros) Then
    Exit;

  If AParametros.DiferencaFCPST Then
    Exit;

  If (AParametros.ProdutoIndustrializadoDentroDoEstado And (not AParametros.SimplesNacional)) Then
    Exit;

  If (AParametros.ProdutoRevendaDentroDoEstado And (not AParametros.SimplesNacional)) Then
    Exit;

  Result := False;
end;

function TCalculoImpostosFCP.ResultadoDoCalculoDoFCP: IResultadoCalculoFCP;
begin
  Result :=
    TResultadoCalculoFCP.New
      .ZerarDifal(FZerarDifal)
      .SairDoProcedimento(FSairDoProcedimento)
      .GravarOsRegistros(FGravarOsRegistros)
      .AliquotaDoFCPDoItem(FAliquotaFCP)
      .BaseDestino(FBaseDestino)
      .BaseFCP(FBaseFCP)
      .ValorFCP(FValorFCP)
      .AliquotaFCPST(FAliquotaFCPST)
      .RecordDifalFCP(FRecordDifalFCP);
end;

procedure TCalculoImpostosFCP.CalcularFCPComDiferencaEntreBaseDaSubstituicaoTributariaEBaseDeIcms(const AParametros: IParametrosCalculoFCP);
Var
  LBaseParaCalculoFCP: Double;
begin
  FBaseDestino := AParametros.BaseDeCalculoDoIcmsDoItem;
  FBaseFCP     := FBaseDestino;
  FValorFCP    := objCore.fFormataFloat(FBaseFCP * FAliquotaFCP / 100, 2);

  FGravarOsRegistros := (FValorFCP > 0);

  FAliquotaFCPST := FAliquotaFCP;

  LBaseParaCalculoFCP := AParametros.BaseDeCalculoDaSubstituicaoTributariaDoItem - AParametros.BaseDeCalculoDoIcmsDoItem;

  FRecordDifalFCP.fltBasFcp := LBaseParaCalculoFCP;

  FRecordDifalFCP.fltValFcp := objCore.fFormataFloat(LBaseParaCalculoFCP * FAliquotaFCP / 100, 2);
  FRecordDifalFCP.fltPerFcp := FAliquotaFCP;

  If FRecordDifalFCP.fltValFcp <= 0 Then
  Begin
    FRecordDifalFCP.fltValFcp := 0;
    FRecordDifalFCP.fltPerFcp := 0;
    FRecordDifalFCP.fltBasFcp := 0;
  End;

  CalcularBeneficioReducaoBaseIcmsSTZerarFCP(AParametros);
end;

function TCalculoImpostosFCP.CalculaFCPComReducaoBaseIcmsST(const AParametros: IParametrosCalculoFCP): IResultadoCalculoFCP;
begin
  FGravarOsRegistros := False;

  CalcularFCPComDiferencaEntreBaseDaSubstituicaoTributariaEBaseDeIcms(AParametros);

  FSairDoProcedimento := True;

  Result := ResultadoDoCalculoDoFCP;
end;

{ TCalculoImpostosDifalFCP }

function TCalculoImpostosDifalFCP.CalcularValorDifalFcp(
  AParametros: IParametrosCalculoDifalFcp): IResultadoCalculoDifalFcp;
begin
  IniciarVariaveis(AParametros);
  VerificarSimplesNacional(AParametros);
  DefinirBaseFcp(AParametros);
  DefinirValorFcp(AParametros);
  ZerarBaseEValorDeFcp(AParametros);
  Result := ResultadoDifalFcp;
end;

procedure TCalculoImpostosDifalFCP.DefinirBaseFcp(
  const AParametros: IParametrosCalculoDifalFcp);
begin
  FBaseFCP := AParametros.BaseDeCalculoDaSubstituicaoTributariaDoItem;

  If (AParametros.BaseDeCalculoDaSubstituicaoTributariaDoItem > 0) Then
    Exit;

  FBaseFCP := AParametros.BaseDestino;
end;

procedure TCalculoImpostosDifalFCP.DefinirValorFcp(
  const AParametros: IParametrosCalculoDifalFcp);
begin
  FValorFCP := objCore.fFormataFloat(FBaseFCP * AParametros.AliquotaFCPDoItem / 100, 2);
end;

procedure TCalculoImpostosDifalFCP.IniciarVariaveis(
  const AParametros: IParametrosCalculoDifalFcp);
begin
  FAliquotaDifalDoItem := AParametros.AliquotaDifalDoItem;
  FIcmsOrigem          := AParametros.IcmsDeOrigem;
  FIcmsDestino         := AParametros.IcmsDeDestino;

  If (FAliquotaDifalDoItem >= 0) Then
    Exit;

  FAliquotaDifalDoItem := 0;
end;

class function TCalculoImpostosDifalFCP.New: ICalculoImpostosDifalFCP;
begin
  Result := Self.Create;
end;

function TCalculoImpostosDifalFCP.ResultadoDifalFcp: IResultadoCalculoDifalFcp;
begin
  Result :=
    TResultadoCalculoDifalFcp.New
      .AliquotaDifalDoItem(FAliquotaDifalDoItem)
      .IcmsDeOrigem(FIcmsOrigem)
      .IcmsDeDestino(FIcmsDestino)
      .BaseFCP(FBaseFCP)
      .ValorFCP(FValorFCP);
end;

procedure TCalculoImpostosDifalFCP.VerificarSimplesNacional(
  const AParametros: IParametrosCalculoDifalFcp);
begin
  If Not AParametros.SimplesNacional Then
    Exit;

  If (Not AParametros.EnviarIcmsDifalDoRemetenteNaPartilha) Then
    FIcmsOrigem := 0;

  If (Not AParametros.EnviarIcmsDifalDoDestinoNaPartilha) Then
    FIcmsDestino := 0;
end;

procedure TCalculoImpostosDifalFCP.ZerarBaseEValorDeFcp(
  const AParametros: IParametrosCalculoDifalFcp);
begin
  If Not ZerarFcp(AParametros) Then
    Exit;

  FBaseFCP := 0;
  FValorFCP := 0;
end;

function TCalculoImpostosDifalFCP.ZerarFcp(
  const AParametros: IParametrosCalculoDifalFcp): Boolean;
begin
  Result := True;

  If AParametros.ZerarFCP Then
    Exit;

  If FValorFCP = 0 Then
    Exit;

  Result := False;
end;

end.
