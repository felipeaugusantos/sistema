unit Faturamento.Impostos.Calculos.Difal;

interface

uses Faturamento.Impostos.Interfaces.Difal, Faturamento.Impostos.Tipos.Difal,
  Shared.Functions.Core, Shared.Functions.Types, Shared.Functions.Constantes,
  System.StrUtils;

type
  TCalculoImpostosDifal = class(TInterfacedObject, ICalculoImpostosDifal)
  private
    FParametros: IParametrosCalculoDifal;
    FAliquotaEfetivaOrigem: double;
    FPercentualBaseOrigem: Double;
    FPercentualBaseDestino: Double;
    FValorTotalProduto: Double;
    FBaseDestino: Double;
    FAliquotaInternaEstadoDestino: Double;
    FAliquotaEfetivaDestino: Double;
    FAliquotaInterestadualCalc: Double;
    FCalculaIcmsDifalOrigem: Double;
    FCalculaIcmsDifalDestino: Double;
    FCalculaDifIcmsAliquota: Double;
    FValorIcmsDestino: Double;
    FValorIcmsOrigem: Double;
    FRecordDifalFCP: TRecDifalFCP;
    FBaseIcmsDoItem: Double;
    FBaseDeCalculoDoItem: Double;
    function ValidarCalculaBaseReduzidaAliquotaEfetiva: boolean;
    function ValidarCalculaBaseReduzidaAliquotaEfetivaOuProdutosImportados: boolean;
    function ValidarProdutosImportados: boolean;
    procedure CalcularValorDifalBaseReduzidaAliquotaEfetivaOuProdutosImportados;
    procedure CalcularValorDifalNormal;
    procedure SetarVariaveisIniciais;
    procedure DecidirCalculoValorDifal;
    function RetornarResultadoCalculoDoDifal: IResultadoCalculoDifal;
    procedure ValidarSeDeveZerarValoresIcmsOrigemDestino;
    function ValidarRegraCalculoDiferencaAliquotaProdutoSt: boolean;
    function ValidarRegraCalculoSimplesNacional: boolean;
    function ValidarRegrasCalculoValorIcmsSimplesNacionalDiferencaAliquotaProdutoST: boolean;
    function ValidarSeTemValorIcmsBase: boolean;
    procedure CalcularValorDifalComValorIcmsSimplesNacionalDiferencaAliquotaProdutoST;
    procedure SetarValoresRecordDifalFcp;
    function RetornarAliquotaInternaEstadoDestino: Double;
    function ValidarSimplesNacionalOuDiferencialAliquotaProdutoST: boolean;
    procedure CalcularBaseAliquotaIcmsDoItemSimplesNacionalOuDiferencialAliquotaProdutoST;
    procedure CalcularBaseDestinoBaseReduzidaAliquotaEfetivaOuProdutosImportados;
    procedure CalcularDiferencialAliquotaIcms;
    procedure CalcularDiferencialAliquotaIcmsUsandoPercentualBaseDifal;
    procedure CalcularValorIcmsDestinoBaseReduzidaAliquotaEfetivaOuProdutosImportados;
    procedure CalcularValorIcmsOrigem;
    function RetornarValorIcmsDestino: double;
    procedure CalcularAliquotaEfetivaOrigemInicial;
    procedure CalcularPercentualBaseOrigem;
    function RetornarPercentualBaseOrigem: double;
    procedure CalcularPercentualBaseDestino;
    procedure CalcularValorTotalDoProduto;
    procedure CalcularAliquotaEfetivaOrigem;
    procedure CalcularAliquotaEfetivaDestino;
    procedure CalcularIcmsDifalOrigem;
    procedure CalcularIcmsDifalDestino;
    procedure CalcularDiferencaIcmsAliquota;
    procedure CalcularBaseDestinoSimplesNacionalDiferencaAliquotaProdutoST;
    procedure CalcularValorIcmsDestinoSimplesNacionalOuDiferencialAliquotaProdutoST;
    procedure CalcularBaseIcmsDoItem;
    procedure CalcularBaseDeCalculoDoItem;
  public
    function CalcularValorDifal(AParametros: IParametrosCalculoDifal): IResultadoCalculoDifal;
    class function New(): ICalculoImpostosDifal;
  end;

implementation


function CalcularValorDifal(AParametros: IParametrosCalculoDifal): IResultadoCalculoDifal; stdcall;
begin
  Result := TCalculoImpostosDifal.New.CalcularValorDifal(AParametros);
end;

{ TCalculoImpostosDifal}

function TCalculoImpostosDifal.ValidarCalculaBaseReduzidaAliquotaEfetiva: boolean;
begin
  Result := False;

  If (not FParametros.CalculaBaseReduzidaAliquotaEfetiva) then
    Exit;

  If (not FParametros.SituacaoReducaoBaseCalculo) then
    Exit;

  Result := True;
end;

function TCalculoImpostosDifal.ValidarProdutosImportados: boolean;
begin
  Result := False;

  If (not FParametros.ConsiderarAliquotaEfetivaProdutosImportados) then
    Exit;

  If (not FParametros.ProdutoDeOrigemEstrangeira) Then
    Exit;

  Result := True;
end;

function TCalculoImpostosDifal.ValidarCalculaBaseReduzidaAliquotaEfetivaOuProdutosImportados: boolean;
begin
  result := True;

  If (ValidarCalculaBaseReduzidaAliquotaEfetiva) then
    Exit;

  If (ValidarProdutosImportados) then
    Exit;

  Result := False;
end;

procedure TCalculoImpostosDifal.CalcularBaseDeCalculoDoItem;
begin
  FBaseDeCalculoDoItem := (FParametros.TotalDoItem -
                           FParametros.DescontoEspecialDoItem +
                           FParametros.ValorFreteDoItem +
                           FParametros.DespesaAcessoriaDoItem);

  If FParametros.EntraIPInaBaseIcms Then
    FBaseDeCalculoDoItem := FBaseDeCalculoDoItem + FParametros.ValorIpiDoItem;
end;

procedure TCalculoImpostosDifal.SetarValoresRecordDifalFcp;
begin
  If FValorIcmsDestino <= 0 Then
    Exit;

  FRecordDifalFCP.fltAlDifa := objCore.fFormataFloat((FValorIcmsDestino / FBaseDeCalculoDoItem) * 100, 2);
  FRecordDifalFCP.fltDifDes := FValorIcmsDestino;
  FRecordDifalFCP.fltDifOri := FValorIcmsOrigem;
  FRecordDifalFCP.fltAlqIne := FAliquotaInterestadualCalc;
  FRecordDifalFCP.fltAlqUfd := FAliquotaInternaEstadoDestino;
  FRecordDifalFCP.fltBcuFde := FBaseDestino;
  FRecordDifalFCP.fltPerPar := FParametros.PercentualProvisorioPartilha;
end;

procedure TCalculoImpostosDifal.CalcularAliquotaEfetivaOrigemInicial;
begin
  If not FParametros.AbreviacaoIcmsProduto  Then
    Exit;

  FAliquotaEfetivaOrigem := FParametros.CalculaAliquotaEfetivaOrigem;
end;

function TCalculoImpostosDifal.RetornarPercentualBaseOrigem: double;
begin
  Result := FParametros.PercentualBaseOrigem;

  If (FParametros.PercentualBaseOrigem <> 0) then
    Exit;

  If (not FParametros.CalculaTipoDeAbreviacaoFiscal) Then
    Exit;

  If (not FParametros.CalculaDiferencialAliquotaProdutosSt) Then
    Exit;

  Result := 100;
end;

procedure TCalculoImpostosDifal.CalcularPercentualBaseOrigem;
begin
  // Trecho provisório feito para atender a necessidades dos clientes até o início da NT 2020.005
  If FParametros.HabilitarPercentualBase And (not FParametros.HabilitarNovoCalculoDifalComPercentualBase) Then
  begin
    FPercentualBaseOrigem := FParametros.PercentualBaseDifalOrigem;
    Exit;
  end;

  If not FParametros.AbreviacaoIcmsProdutoUfEmpresa Then
    Exit;

  FPercentualBaseOrigem := RetornarPercentualBaseOrigem;
end;

procedure TCalculoImpostosDifal.CalcularPercentualBaseDestino;
begin
  FPercentualBaseDestino := FParametros.PercentualBaseDestino;

  If not FParametros.HabilitarPercentualBase Then
    Exit;

  FPercentualBaseDestino := FParametros.PercentualBaseDifalDestino;
end;

procedure TCalculoImpostosDifal.CalcularValorTotalDoProduto;
begin
  //Total do produto é a base de tudo
  FValorTotalProduto := (FParametros.TotalDoItem -
                         FParametros.DescontoEspecialDoItem +
                         FParametros.ValorFreteDoItem +
                         FParametros.DespesaAcessoriaDoItem);

  If FParametros.EntraIPInaBaseIcms Then
    FValorTotalProduto := FValorTotalProduto + FParametros.ValorIpiDoItem;
end;

procedure TCalculoImpostosDifal.CalcularBaseDestinoBaseReduzidaAliquotaEfetivaOuProdutosImportados;
begin
  FBaseDestino := (FValorTotalProduto * FPercentualBaseDestino) / 100;
end;

procedure TCalculoImpostosDifal.CalcularAliquotaEfetivaOrigem;
begin
  If (objCore.fFormataFloat(FAliquotaEfetivaOrigem, 2) <> 0.00) Then
    Exit;

  FAliquotaEfetivaOrigem := objCore.fFormataFloat(FPercentualBaseOrigem * FAliquotaInternaEstadoDestino / 100,2);
end;

procedure TCalculoImpostosDifal.CalcularAliquotaEfetivaDestino;
begin
  FAliquotaEfetivaDestino := objCore.fFormataFloat(FPercentualBaseDestino * FAliquotaInterestadualCalc / 100,2);
end;

procedure TCalculoImpostosDifal.CalcularIcmsDifalOrigem;
begin
  FCalculaIcmsDifalOrigem  := objCore.fFormataFloat(FValorTotalProduto * FAliquotaEfetivaOrigem  / 100,2);
end;

procedure TCalculoImpostosDifal.CalcularIcmsDifalDestino;
begin
  FCalculaIcmsDifalDestino := objCore.fFormataFloat(FValorTotalProduto * FAliquotaEfetivaDestino / 100,2);
end;

procedure TCalculoImpostosDifal.CalcularDiferencaIcmsAliquota;
begin
  FCalculaDifIcmsAliquota := (FCalculaIcmsDifalOrigem - FCalculaIcmsDifalDestino);
end;

procedure TCalculoImpostosDifal.CalcularValorIcmsDestinoBaseReduzidaAliquotaEfetivaOuProdutosImportados;
begin
  FValorIcmsDestino := objCore.fFormataFloat( FCalculaDifIcmsAliquota * FParametros.PercentualProvisorioPartilha / 100,2);
end;

procedure TCalculoImpostosDifal.CalcularValorIcmsOrigem;
begin
  FValorIcmsOrigem := (FCalculaDifIcmsAliquota - FValorIcmsDestino);
end;

procedure TCalculoImpostosDifal.CalcularValorDifalBaseReduzidaAliquotaEfetivaOuProdutosImportados;
begin
  CalcularAliquotaEfetivaOrigemInicial;
  CalcularPercentualBaseOrigem;
  CalcularPercentualBaseDestino;
  CalcularValorTotalDoProduto;
  CalcularBaseDestinoBaseReduzidaAliquotaEfetivaOuProdutosImportados;
  CalcularAliquotaEfetivaOrigem;
  CalcularAliquotaEfetivaDestino;
  CalcularIcmsDifalOrigem;
  CalcularIcmsDifalDestino;
  CalcularDiferencaIcmsAliquota;
  CalcularValorIcmsDestinoBaseReduzidaAliquotaEfetivaOuProdutosImportados;
  CalcularBaseDeCalculoDoItem;
  SetarValoresRecordDifalFcp;
end;

function TCalculoImpostosDifal.ValidarSeTemValorIcmsBase: boolean;
begin
  Result := True;

  If FParametros.CalculaDifalParaCombustiveis_e_LubrificantesNaoTributados Then
    Exit;

  If (FParametros.ValorIcmsBase > 0) Then
    Exit;

  Result := False;
end;

function TCalculoImpostosDifal.ValidarRegraCalculoSimplesNacional: boolean;
begin
  Result := False;

  If (Not FParametros.SimplesNacional) Then
    Exit;

  If (Pos(FParametros.CodigoSituacaoTributaria, SITUACOES_PERMITIDAS_NO_SIMPLES) <= 0) Then
    Exit;

  If (AnsiRightStr(FParametros.ClassificacaoFiscalDoItem, 3) = '922') Then
    Exit;

  Result := True;
end;

function TCalculoImpostosDifal.ValidarRegraCalculoDiferencaAliquotaProdutoSt: boolean;
begin
  Result := False;

  If (not FParametros.CalculaDiferencialAliquotaProdutosSt) Then
    Exit;

  If (not FParametros.ProdutoSt) Then
    Exit;

  If (AnsiRightStr(FParametros.ClassificacaoFiscalDoItem, 3) = '922') Then
    Exit;

  Result := True;
end;

function TCalculoImpostosDifal.ValidarRegrasCalculoValorIcmsSimplesNacionalDiferencaAliquotaProdutoST: boolean;
begin
  Result := True;

  If ValidarSeTemValorIcmsBase Then
    Exit;

  If ValidarRegraCalculoSimplesNacional then
    Exit;

  if ValidarRegraCalculoDiferencaAliquotaProdutoSt then
    Exit;

  Result := False;
end;

function TCalculoImpostosDifal.ValidarSimplesNacionalOuDiferencialAliquotaProdutoST: boolean;
begin
  Result := True;

  If (FParametros.SimplesNacional) Then
    Exit;

  If (ValidarRegraCalculoDiferencaAliquotaProdutoSt) Then
    Exit;

  Result := False;
end;

procedure TCalculoImpostosDifal.CalcularBaseAliquotaIcmsDoItemSimplesNacionalOuDiferencialAliquotaProdutoST;
begin
  if (not ValidarSimplesNacionalOuDiferencialAliquotaProdutoST) then
    Exit;

  FBaseIcmsDoItem := (FParametros.TotalDoItem -
                      FParametros.DescontoEspecialDoItem +
                      FParametros.ValorFreteDoItem +
                      FParametros.DespesaAcessoriaDoItem);

  If FParametros.EntraIPInaBaseIcms Then
    FBaseIcmsDoItem := FBaseIcmsDoItem + FParametros.ValorIpiDoItem;

  FAliquotaInterestadualCalc := FParametros.CalculaAliquotaInterestadual;
end;

procedure TCalculoImpostosDifal.CalcularBaseDestinoSimplesNacionalDiferencaAliquotaProdutoST;
begin
  FBaseDestino := FBaseIcmsDoItem;

  If (not FParametros.HabilitarPercentualBase) Then
    Exit;

  FBaseDestino := (FParametros.TotalDoItem -
                   FParametros.DescontoEspecialDoItem +
                   FParametros.ValorFreteDoItem +
                   FParametros.DespesaAcessoriaDoItem);

  If FParametros.EntraIPInaBaseIcms Then
    FBaseDestino := FBaseDestino + FParametros.ValorIpiDoItem;

  FBaseDestino := objCore.fFormataFloat(FBaseDestino * FParametros.PercentualBaseDifalDestino / 100,2);
end;

procedure TCalculoImpostosDifal.CalcularDiferencialAliquotaIcms;
var
  LDifAliquota: Double;
begin
  if (ValidarRegraCalculoDiferencaAliquotaProdutoSt) then
  begin
    FCalculaDifIcmsAliquota := objCore.fFormataFloat(FBaseDestino * (FAliquotaInternaEstadoDestino - FAliquotaInterestadualCalc ) / 100 ,2);
    Exit;
  End;

  LDifAliquota := objCore.fFormataFloat(FAliquotaInternaEstadoDestino - FAliquotaInterestadualCalc,2);
  FCalculaDifIcmsAliquota := objCore.fFormataFloat(FBaseIcmsDoItem * LDifAliquota / 100,4);
end;

// Procedure provisório feita para atender a necessidades dos clientes até o início da NT 2020.005
procedure TCalculoImpostosDifal.CalcularBaseIcmsDoItem;
begin
  If FParametros.HabilitarNovoCalculoDifalComPercentualBase Then
    Exit;

  If (not FParametros.HabilitarPercentualBase) Then
    Exit;

  FBaseIcmsDoItem := (FParametros.TotalDoItem -
                      FParametros.DescontoEspecialDoItem +
                      FParametros.ValorFreteDoItem +
                      FParametros.DespesaAcessoriaDoItem);

  If FParametros.EntraIPInaBaseIcms Then
    FBaseIcmsDoItem := FBaseIcmsDoItem + FParametros.ValorIpiDoItem;

  FBaseIcmsDoItem := objCore.fFormataFloat(FBaseIcmsDoItem * FParametros.PercentualBaseDifalOrigem / 100,2);

end;

procedure TCalculoImpostosDifal.CalcularDiferencialAliquotaIcmsUsandoPercentualBaseDifal;
var
  LCalculaIcmsDifalOrigem: Double;
  LCalculaIcmsDifalDestino: Double;
begin
  If not FParametros.HabilitarPercentualBase Then
    Exit;
  // Trecho provisório feito para atender a necessidades dos clientes até o início da NT 2020.005
  If not FParametros.HabilitarNovoCalculoDifalComPercentualBase Then
    Exit;

  LCalculaIcmsDifalOrigem  := objCore.fFormataFloat(((FBaseIcmsDoItem * FAliquotaInterestadualCalc) / 100), 2);
  LCalculaIcmsDifalDestino := objCore.fFormataFloat(((FBaseDestino * FAliquotaInternaEstadoDestino) / 100), 2);
  FCalculaDifIcmsAliquota  := objCore.fFormataFloat((LCalculaIcmsDifalDestino - LCalculaIcmsDifalOrigem), 4);
end;

function TCalculoImpostosDifal.RetornarValorIcmsDestino: double;
begin
  result := objCore.fFormataFloat( FCalculaDifIcmsAliquota * FParametros.PercentualProvisorioPartilha / 100 ,4);
end;

procedure TCalculoImpostosDifal.CalcularValorIcmsDestinoSimplesNacionalOuDiferencialAliquotaProdutoST;
begin
  FValorIcmsDestino := RetornarValorIcmsDestino;
end;

procedure TCalculoImpostosDifal.CalcularValorDifalComValorIcmsSimplesNacionalDiferencaAliquotaProdutoST;
begin
  CalcularBaseAliquotaIcmsDoItemSimplesNacionalOuDiferencialAliquotaProdutoST;

  CalcularBaseIcmsDoItem; // procedure provisória feita para atender a necessidades dos clientes até o início da NT 2020.005

  CalcularBaseDestinoSimplesNacionalDiferencaAliquotaProdutoST;
  CalcularDiferencialAliquotaIcms;
  CalcularDiferencialAliquotaIcmsUsandoPercentualBaseDifal;
  CalcularValorIcmsDestinoSimplesNacionalOuDiferencialAliquotaProdutoST;
  CalcularValorIcmsOrigem;
  CalcularBaseDeCalculoDoItem;
  SetarValoresRecordDifalFcp;
end;

procedure TCalculoImpostosDifal.CalcularValorDifalNormal;
begin
  If ValidarRegrasCalculoValorIcmsSimplesNacionalDiferencaAliquotaProdutoST Then
  begin
    CalcularValorDifalComValorIcmsSimplesNacionalDiferencaAliquotaProdutoST;
    Exit;
  end;

  FAliquotaInterestadualCalc := FParametros.CalculaAliquotaInterestadual;
end;

function TCalculoImpostosDifal.RetornarAliquotaInternaEstadoDestino: Double;
begin
  result := 0;

  if (not FParametros.AbreviacaoIcmsProduto) then
    Exit;

  Result := FParametros.AliquotaInternaEstadoDestino;
end;

procedure TCalculoImpostosDifal.SetarVariaveisIniciais;
begin
  FBaseIcmsDoItem          := FParametros.ValorIcmsBase;
  FPercentualBaseOrigem    := 0;
  FAliquotaEfetivaOrigem   := 0;
  FRecordDifalFCP          := FParametros.RecordDifalFCP;
  FBaseDestino             := 0;
  FValorIcmsDestino        := 0;
  FValorIcmsOrigem         := 0;
  FBaseDeCalculoDoItem     := 0;

  FAliquotaInterestadualCalc    := FParametros.AliquotaInterestadualCalc;
  FAliquotaInternaEstadoDestino := RetornarAliquotaInternaEstadoDestino;
end;

procedure TCalculoImpostosDifal.DecidirCalculoValorDifal;
begin
  If ValidarCalculaBaseReduzidaAliquotaEfetivaOuProdutosImportados then
  begin
    CalcularValorDifalBaseReduzidaAliquotaEfetivaOuProdutosImportados;
    Exit;
  end;

  CalcularValorDifalNormal;
end;

procedure TCalculoImpostosDifal.ValidarSeDeveZerarValoresIcmsOrigemDestino;
begin
  If FValorIcmsDestino > 0 Then
    Exit;

  FValorIcmsDestino := 0;
  FValorIcmsOrigem := 0;
end;

function TCalculoImpostosDifal.RetornarResultadoCalculoDoDifal: IResultadoCalculoDifal;
begin
  result := TResultadoCalculoDifal.New
             .ValorBaseDestino(FBaseDestino)
             .ValorIcmsDestino(FValorIcmsDestino)
             .ValorIcmsOrigem(FValorIcmsOrigem)
             .AliquotaInterestadualCalc(FAliquotaInterestadualCalc)
             .RecordDifalFCP(FRecordDifalFCP);
end;

function TCalculoImpostosDifal.CalcularValorDifal(AParametros: IParametrosCalculoDifal): IResultadoCalculoDifal;
 begin
  FParametros := AParametros;
  SetarVariaveisIniciais;
  DecidirCalculoValorDifal;
  ValidarSeDeveZerarValoresIcmsOrigemDestino;
  Result := RetornarResultadoCalculoDoDifal;
end;

class function TCalculoImpostosDifal.New: ICalculoImpostosDifal;
begin
  Result := Self.Create;
end;

end.


