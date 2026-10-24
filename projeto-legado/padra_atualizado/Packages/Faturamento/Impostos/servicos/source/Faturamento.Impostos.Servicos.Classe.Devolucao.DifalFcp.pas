unit Faturamento.Impostos.Servicos.Classe.Devolucao.DifalFcp;

interface

uses Faturamento.Impostos.Interfaces.Servicos.Classe.Devolucao.DifalFcp,
  Faturamento.Impostos.Tipos.Servicos.Classe.Devolucao.DifalFcp,
  Shared.Functions.DataSet, Shared.Functions.Core, System.StrUtils,
  Shared.Functions.Types, System.SysUtils, Shared.Functions.Configuracoes;

type
  TServicoClasseDevolucaoDifalFcp = class(TInterfacedObject, IServicoClasseDevolucaoDifalFcp)
  private
    FParametros: IParametrosClasseDevolucaoDifalFcp;

    FDocumento: IMyCampoTabela;

    FBaseIcmsItem,
    FBaseDestino,
    FAliquotaFCP,
    FAliquotaInternaEstadoDestino,
    FPercentualProvisorioPartilha,
    FValorFCP,
    FAliquotaInterestadualCalculada,
    FIcmsDestino,
    FIcmsOrigem,
    FBaseFCP: Double;

    function RetornarSQL: String;
    function RetornarQuantidadeDoItem: Double;
  public
    function CarregarDocumentoDevolvido: IServicoClasseDevolucaoDifalFcp;
    function DocumentoExiste: Boolean;
    function CalcularProporcional: IServicoClasseDevolucaoDifalFcp;
    function RetornarResultado: IResultadoClasseDevolucaoDifalFcp;

    constructor Create(const AParametros: IParametrosClasseDevolucaoDifalFcp); overload;

    class function New(const AParametros: IParametrosClasseDevolucaoDifalFcp): IServicoClasseDevolucaoDifalFcp;
  end;


implementation

{ TServicoClasseDevolucaoDifalFcp }

function TServicoClasseDevolucaoDifalFcp.CalcularProporcional: IServicoClasseDevolucaoDifalFcp;
var
  LCalculaDifIcmsAliquota: Double;
  LDifAliquota: Double;
begin
  Result := Self;

  FBaseDestino                    := FDocumento.FieldByName('ICD_BCUFDE').AsFloat;
  FAliquotaFCP                    := FDocumento.FieldByName('ICD_PERFCP').AsFloat;
  FAliquotaInternaEstadoDestino   := FDocumento.FieldByName('ICD_ALQUFD').AsFloat;
  FPercentualProvisorioPartilha   := FDocumento.FieldByName('ICD_PERPAR').AsFloat;
  FValorFCP                       := FDocumento.FieldByName('ICD_VALFCP').AsFloat;
  FAliquotaInterestadualCalculada := FDocumento.FieldByName('ICD_ALQINE').AsFloat;
  FIcmsDestino                    := FDocumento.FieldByName('ICD_VALDES').AsFloat;
  FIcmsOrigem                     := FDocumento.FieldByName('ICD_VALORI').AsFloat;
  FBaseFCP                        := FDocumento.FieldByName('ICD_BASFCP').AsFloat;
  FBaseIcmsItem                   := FDocumento.FieldByName('DET_BASICM').AsFloat;

  FBaseFCP  := (FBaseFCP / RetornarQuantidadeDoItem);
  FBaseFCP  := (FBaseFCP * FParametros.QuantidadeDoItem);
  FValorFCP := (FBaseFCP * FAliquotaFCP) / 100;

  FBaseDestino := (FBaseDestino / RetornarQuantidadeDoItem);
  FBaseDestino := (FBaseDestino * FParametros.QuantidadeDoItem);

  FBaseIcmsItem := (FBaseIcmsItem / RetornarQuantidadeDoItem);
  FBaseIcmsItem := (FBaseIcmsItem * FParametros.QuantidadeDoItem);

  // Trecho provisório feito para atender a necessidades dos clientes até o início da NT 2020.005
  If objConfiguracoes.fGetValorConfiguracao(CFG_HABILITAR_PERCENTUAL_BASE_DIFAL, VarBoolean) And FParametros.HabilitarNovoCalculoDifalComPercentualBase Then
  Begin
    LCalculaDifIcmsAliquota := objCore.fFormataFloat(((FBaseDestino * FAliquotaInternaEstadoDestino) / 100) - ((FBaseIcmsItem * FAliquotaInterestadualCalculada) / 100), 2);
    FIcmsDestino := objCore.fFormataFloat(LCalculaDifIcmsAliquota * FPercentualProvisorioPartilha / 100, 4);
    FIcmsOrigem  := (LCalculaDifIcmsAliquota - FIcmsDestino);
  End
  Else
  Begin
    If FParametros.ProdutoST Then
    Begin
      LCalculaDifIcmsAliquota := objCore.fFormataFloat(FBaseDestino * (FAliquotaInternaEstadoDestino - FAliquotaInterestadualCalculada) / 100, 2)
    End
    Else
    Begin
      LDifAliquota := objCore.fFormataFloat(FAliquotaInternaEstadoDestino - FAliquotaInterestadualCalculada, 2);
      LCalculaDifIcmsAliquota := objCore.fFormataFloat(FBaseDestino * LDifAliquota / 100,4);
    End;

    FIcmsDestino := objCore.fFormataFloat(LCalculaDifIcmsAliquota * FPercentualProvisorioPartilha / 100, 4);
    FIcmsOrigem  := (LCalculaDifIcmsAliquota - FIcmsDestino);
  End;
end;

function TServicoClasseDevolucaoDifalFcp.CarregarDocumentoDevolvido: IServicoClasseDevolucaoDifalFcp;
var
  LParametros: ArrOfString;
  LValores: ArrOfVariant;
begin
  Result := Self;

  LParametros := ['NUMDOC', 'ESPDOC', 'CODEMP', 'CODCLI', 'CODITE'];
  LValores    := [FParametros.NumeroDoDocumentoDeDevolucao,
                  FParametros.EspecieDoDocumentoDeDevolucao,
                  FParametros.EmpresaDoDocumentoDeDevolucao,
                  FParametros.CodigoDoCliente,
                  FParametros.CodigoDoItem];

  FDocumento := objCore.fCampoTabelaDados(RetornarSQL, LParametros, LValores);
end;

constructor TServicoClasseDevolucaoDifalFcp.Create(
  const AParametros: IParametrosClasseDevolucaoDifalFcp);
begin
  FParametros := AParametros;
end;

function TServicoClasseDevolucaoDifalFcp.DocumentoExiste: Boolean;
begin
  Result := False;

  If FDocumento.FieldByName('DET_NUMDOC').AsString.IsEmpty Then
    Exit;

  Result := True;
end;

class function TServicoClasseDevolucaoDifalFcp.New(
  const AParametros: IParametrosClasseDevolucaoDifalFcp): IServicoClasseDevolucaoDifalFcp;
begin
  Result := Self.Create(AParametros);
end;

function TServicoClasseDevolucaoDifalFcp.RetornarQuantidadeDoItem: Double;
begin
  Result := FDocumento.FieldByName('DET_QTDITE').AsFloat;

  If Result > 0 Then
    Exit;

  Result := 1;
end;

function TServicoClasseDevolucaoDifalFcp.RetornarResultado: IResultadoClasseDevolucaoDifalFcp;
begin
  Result :=
    TResultadoClasseDevolucaoDifalFcp.New
      .BaseDestino(FBaseDestino)
      .AliquotaFCP(FAliquotaFCP)
      .AliquotaInternaEstadoDestino(FAliquotaInternaEstadoDestino)
      .PercentualProvisorioPartilha(FPercentualProvisorioPartilha)
      .ValorFCP(FValorFCP)
      .AliquotaInterestadualCalc(FAliquotaInterestadualCalculada)
      .IcmsDestino(FIcmsDestino)
      .IcmsOrigem(FIcmsOrigem)
      .BaseFCP(FBaseFCP)
      .BaseIcmsItemDevolucao(FBaseIcmsItem);
end;

function TServicoClasseDevolucaoDifalFcp.RetornarSQL: String;
begin
  Result := '';
  Result := Result + 'SELECT ';
  Result := Result + '  ICD_ALQINE, ';
  Result := Result + '  ICD_ALQUFD, ';
  Result := Result + '  ICD_BCUFDE, ';
  Result := Result + '  ICD_PERFCP, ';
  Result := Result + '  ICD_PERPAR, ';
  Result := Result + '  ICD_VALDES, ';
  Result := Result + '  ICD_VALFCP, ';
  Result := Result + '  ICD_VALORI, ';
  Result := Result + '  ICD_BASFCP, ';
  Result := Result + '  DET_QTDITE, ';
  Result := Result + '  DET_BASICM, ';
  Result := Result + '  DET_NUMDOC  ';
  Result := Result + 'FROM ';
  Result := Result + '  MOVDET D ';
  Result := Result + '  INNER JOIN MOVICD I ON D.AUTOINCREM = I.ICD_SEQGER ';
  Result := Result + 'WHERE D.DET_NUMDOC = :NUMDOC ';
  Result := Result + '  AND D.DET_ESPDOC = :ESPDOC ';
  Result := Result + '  AND D.DET_CODEMP = :CODEMP ';
  Result := Result + '  AND D.DET_CODCLI = :CODCLI ';
  Result := Result + '  AND D.DET_CODITE = :CODITE ';
  Result := Result + '  UNION ALL  ' + AnsiReplaceStr(AnsiReplaceStr(Result,'MOVDET','NOTDET'),'MOVICD','NOTICD');
end;

end.
