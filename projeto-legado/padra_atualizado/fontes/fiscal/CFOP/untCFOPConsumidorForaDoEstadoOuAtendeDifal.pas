unit untCFOPConsumidorForaDoEstadoOuAtendeDifal;

interface

uses untTypesCFOP, Shared.Functions.Configuracoes;

type
  TCFOPConsumidorForaDoEstadoOuAtendeDifal = class(TAbstractClassificacao)
  private
    Const
      REVENDA = 'R';
  private
    FConfiguracoes: IConfiguracoes;
    FInputDefine: TInputDefineClassificacaoFiscal;
    FInputOutputClassificacao : TInputOutputClassificacaoFiscal;
    function RetornarClassificacaoFiscalContribuinteDeIpi: string;
    function RetornarClassificacaoFiscalClientesForaDoEstadoSemInscricaoEstadual: string;
    function ItemSubstituido: Boolean;
  public
    function GetClassificacao: TInputOutputClassificacaoFiscal; Override;
    constructor Create(const AInputDefine: TInputDefineClassificacaoFiscal; const AConfiguracoes: IConfiguracoes; const AInputOutputClassificacao: TInputOutputClassificacaoFiscal); Override;
  End;

implementation

uses Shared.Functions.Constantes, System.StrUtils;

{ TCFOPConsumidorForaDoEstadoOuAtendeDifal }

constructor TCFOPConsumidorForaDoEstadoOuAtendeDifal.Create(const AInputDefine: TInputDefineClassificacaoFiscal; const AConfiguracoes: IConfiguracoes; const AInputOutputClassificacao: TInputOutputClassificacaoFiscal);
begin
  inherited;
  FInputDefine := AInputDefine;
  FInputOutputClassificacao := AInputOutputClassificacao;
  FConfiguracoes := AConfiguracoes;
end;

function TCFOPConsumidorForaDoEstadoOuAtendeDifal.GetClassificacao: TInputOutputClassificacaoFiscal;
begin
  Result := FInputOutputClassificacao;

  If (FConfiguracoes.fGetValorConfiguracao(CFG_CONTRIBUINTE_IPI, varString) = 'S') Then
  Begin
    Result.Classificacao := RetornarClassificacaoFiscalContribuinteDeIpi;
    Result.PrefixoClassificacao := LeftStr(Result.Classificacao, 1);
    Exit;
  End;

  Result.Classificacao := RetornarClassificacaoFiscalClientesForaDoEstadoSemInscricaoEstadual;
  Result.PrefixoClassificacao := LeftStr(Result.Classificacao, 1);
end;

function TCFOPConsumidorForaDoEstadoOuAtendeDifal.ItemSubstituido: Boolean;
begin
  Result := (Pos(FInputDefine.SituacaoTributaria, objConstantes.fGetCstSubstituicao) > 0);
end;

function TCFOPConsumidorForaDoEstadoOuAtendeDifal.RetornarClassificacaoFiscalContribuinteDeIpi: string;
begin
  If FInputDefine.IndustrializacaoOuRevenda = REVENDA Then
  Begin
    Result := '6108';
    Exit;
  End;

  Result := '6107'
end;

function TCFOPConsumidorForaDoEstadoOuAtendeDifal.RetornarClassificacaoFiscalClientesForaDoEstadoSemInscricaoEstadual: string;
begin

  If FInputDefine.MicroEmpreendedorIndividual Then
  Begin
    Result := '6102';
    Exit;
  End;

  If (FConfiguracoes.fGetValorConfiguracao(CFG_CFOP_VENDA_CLIENTES_FORAESTADO_SEM_INSCRICAO_INSCRICAO_ESTADUAL_6XXX) = '108') Then
  begin
    Result := '6108';
    Exit;
  end;

  If (FConfiguracoes.fGetValorConfiguracao(CFG_CFOP_VENDA_CLIENTES_FORAESTADO_SEM_INSCRICAO_INSCRICAO_ESTADUAL_6XXX) <> '404') Then
    Exit;

  If (ItemSubstituido) Then
  begin
    Result := '6404';
    Exit;
  end;

  Result := '6108';
end;

end.