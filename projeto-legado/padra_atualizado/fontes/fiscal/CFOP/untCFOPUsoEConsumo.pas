unit untCFOPUsoEConsumo;

interface

uses untTypesCFOP, Shared.Functions.Configuracoes;

type
  TCFOPUsoEConsumo = class(TAbstractClassificacao)
  private
    FConfiguracoes: IConfiguracoes;
    FInputDefine: TInputDefineClassificacaoFiscal;
    FInputOutputClassificacao : TInputOutputClassificacaoFiscal;
    function fAtendeRegrasCST90UsoConsumo: Boolean;
  public
    function GetClassificacao: TInputOutputClassificacaoFiscal; Override;
    constructor Create(const AInputDefine: TInputDefineClassificacaoFiscal; const AConfiguracoes: IConfiguracoes; const AInputOutputClassificacao: TInputOutputClassificacaoFiscal); Override;
  End;

implementation

uses Shared.Functions.Constantes;

{ TCFOPUsoEConsumo }

constructor TCFOPUsoEConsumo.Create(const AInputDefine: TInputDefineClassificacaoFiscal; const AConfiguracoes: IConfiguracoes; const AInputOutputClassificacao: TInputOutputClassificacaoFiscal);
begin
  inherited;
  FInputDefine := AInputDefine;
  FInputOutputClassificacao := AInputOutputClassificacao;
  FConfiguracoes := AConfiguracoes;
end;

function TCFOPUsoEConsumo.GetClassificacao: TInputOutputClassificacaoFiscal;
begin
  Result := FInputOutputClassificacao;
  Result.Classificacao := FInputOutputClassificacao.PrefixoClassificacao + Copy(FConfiguracoes.fGetValorConfiguracao(CFG_CLAFIS_PARA_USO_E_CONSUMO), 1, 3);
  If fAtendeRegrasCST90UsoConsumo Then
    FInputOutputClassificacao.SituacaoTributaria := Copy(FInputOutputClassificacao.SituacaoTributaria, 1, 1) + '90';
end;

function TCFOPUsoEConsumo.fAtendeRegrasCST90UsoConsumo: Boolean;
begin
  Result := False;

  If FInputDefine.OpcaoDeDocumento <> USO_E_CONSUMO Then
    Exit;

  If FInputDefine.EspecieDoDocumento <> 'NF' Then
    Exit;

  If FInputDefine.ClienteConsumidorFinal Then
    Exit;

  Result := FConfiguracoes.fGetValorConfiguracao(CFG_CST90_NF_USOCONSUMO_REVENDA, varBoolean);
end;

end.
