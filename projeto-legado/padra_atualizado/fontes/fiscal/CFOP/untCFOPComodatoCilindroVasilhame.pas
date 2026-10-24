unit untCFOPComodatoCilindroVasilhame;

interface

uses untTypesCFOP, Shared.Functions.Configuracoes;

type
  TCFOPComodatoCilindroVasilhame = class(TAbstractClassificacao)
  private
    FConfiguracoes: IConfiguracoes;
    FInputDefine: TInputDefineClassificacaoFiscal;
    FInputOutputClassificacao : TInputOutputClassificacaoFiscal;
  public
    function GetClassificacao: TInputOutputClassificacaoFiscal; Override;
    constructor Create(const AInputDefine: TInputDefineClassificacaoFiscal; const AConfiguracoes: IConfiguracoes; const AInputOutputClassificacao: TInputOutputClassificacaoFiscal); Override;
  End;

implementation

{ TCFOPComodatoCilindroVasilhame }

constructor TCFOPComodatoCilindroVasilhame.Create(const AInputDefine: TInputDefineClassificacaoFiscal; const AConfiguracoes: IConfiguracoes; const AInputOutputClassificacao: TInputOutputClassificacaoFiscal);
begin
  inherited;
  FInputDefine := AInputDefine;
  FInputOutputClassificacao := AInputOutputClassificacao;
  FConfiguracoes := AConfiguracoes;
end;

function TCFOPComodatoCilindroVasilhame.GetClassificacao: TInputOutputClassificacaoFiscal;
begin
  Result := FInputOutputClassificacao;
  Result.Classificacao := Result.PrefixoClassificacao + FConfiguracoes.fGetValorConfiguracao(CFG_CLASSIFICACAO_DE_COMODATO_CILINDRO_VASILHAME);
end;

end.