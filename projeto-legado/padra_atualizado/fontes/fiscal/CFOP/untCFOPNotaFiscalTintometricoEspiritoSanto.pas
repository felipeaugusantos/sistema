unit untCFOPNotaFiscalTintometricoEspiritoSanto;

interface

uses untTypesCFOP, Shared.Functions.Configuracoes;

type
  TCFOPNotaFiscalTintometricoEspiritoSanto = class(TAbstractClassificacao)
  private
    FConfiguracoes: IConfiguracoes;
    FInputDefine: TInputDefineClassificacaoFiscal;
    FInputOutputClassificacao : TInputOutputClassificacaoFiscal;
  public
    function GetClassificacao: TInputOutputClassificacaoFiscal; Override;
    constructor Create(const AInputDefine: TInputDefineClassificacaoFiscal; const AConfiguracoes: IConfiguracoes; const AInputOutputClassificacao: TInputOutputClassificacaoFiscal); Override;
  End;

implementation

uses System.StrUtils, Shared.Functions.Types;

{ TCFOPNotaFiscalTintometricoEspiritoSanto }

constructor TCFOPNotaFiscalTintometricoEspiritoSanto.Create(const AInputDefine: TInputDefineClassificacaoFiscal; const AConfiguracoes: IConfiguracoes; const AInputOutputClassificacao: TInputOutputClassificacaoFiscal);
begin
  inherited;
  FInputDefine := AInputDefine;
  FInputOutputClassificacao := AInputOutputClassificacao;
  FConfiguracoes := AConfiguracoes;
end;

function TCFOPNotaFiscalTintometricoEspiritoSanto.GetClassificacao: TInputOutputClassificacaoFiscal;
  Var
    LPreClassificacaoItem : String;
begin
  Result := FInputOutputClassificacao;

  If Result.PrefixoClassificacao = '5' Then
    LPreClassificacaoItem := '1'
  Else
    LPreClassificacaoItem := '2';

  Case FInputDefine.OpcaoItensNFespTinta Of
    opcProdutoAcabado : Result.Classificacao :=  LPreClassificacaoItem + '926';

    opcBasesColorantesSemDestaqueImpostos,
    opcBasesColorantesComDestaqueImpostos,
    opcColorantesTributados,
    opcColorantesNaoTributados : Result.Classificacao :=  Result.PrefixoClassificacao + '926';
  End;
  Result.PrefixoClassificacao := LeftStr(Result.Classificacao, 1);
end;

end.