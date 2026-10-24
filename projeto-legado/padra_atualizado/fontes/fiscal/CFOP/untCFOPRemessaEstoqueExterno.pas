unit untCFOPRemessaEstoqueExterno;

interface

uses untTypesCFOP, Shared.Functions.Configuracoes;

type
  TCFOPRemessaEstoqueExterno = class(TAbstractClassificacao)
  private
    FConfiguracoes: IConfiguracoes;
    FInputDefine: TInputDefineClassificacaoFiscal;
    FInputOutputClassificacao : TInputOutputClassificacaoFiscal;
  public
    function GetClassificacao: TInputOutputClassificacaoFiscal; Override;
    constructor Create(const AInputDefine: TInputDefineClassificacaoFiscal; const AConfiguracoes: IConfiguracoes; const AInputOutputClassificacao: TInputOutputClassificacaoFiscal); Override;
  End;

implementation

uses System.SysUtils;

{ TCFOPRemessaEstoqueExterno }

constructor TCFOPRemessaEstoqueExterno.Create(const AInputDefine: TInputDefineClassificacaoFiscal; const AConfiguracoes: IConfiguracoes; const AInputOutputClassificacao: TInputOutputClassificacaoFiscal);
begin
  inherited;
  FInputDefine := AInputDefine;
  FInputOutputClassificacao := AInputOutputClassificacao;
  FConfiguracoes := AConfiguracoes;
end;

function TCFOPRemessaEstoqueExterno.GetClassificacao: TInputOutputClassificacaoFiscal;
begin
  Result := FInputOutputClassificacao;
  If FInputDefine.RemessaEstoqueExternoClassificacao.IsEmpty Then
    Result.Classificacao := Result.PrefixoClassificacao + '905'
  Else
    Result.Classificacao := Result.PrefixoClassificacao + FInputDefine.RemessaEstoqueExternoClassificacao;
end;

end.
