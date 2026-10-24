unit untCFOPEmprestimo;

interface

uses untTypesCFOP, Shared.Functions.Configuracoes;

type
  TCFOPEmprestimo = class(TAbstractClassificacao)
  private
    FConfiguracoes: IConfiguracoes;
    FInputDefine: TInputDefineClassificacaoFiscal;
    FInputOutputClassificacao : TInputOutputClassificacaoFiscal;
  public
    function GetClassificacao: TInputOutputClassificacaoFiscal; Override;
    constructor Create(const AInputDefine: TInputDefineClassificacaoFiscal; const AConfiguracoes: IConfiguracoes; const AInputOutputClassificacao: TInputOutputClassificacaoFiscal); Override;
  End;

implementation

uses System.StrUtils;

{ TCFOPEmprestimo }

constructor TCFOPEmprestimo.Create(const AInputDefine: TInputDefineClassificacaoFiscal; const AConfiguracoes: IConfiguracoes; const AInputOutputClassificacao: TInputOutputClassificacaoFiscal);
begin
  inherited;
  FInputDefine := AInputDefine;
  FInputOutputClassificacao := AInputOutputClassificacao;
  FConfiguracoes := AConfiguracoes;
end;

function TCFOPEmprestimo.GetClassificacao: TInputOutputClassificacaoFiscal;
begin
  Result := FInputOutputClassificacao;
  If (FInputDefine.TipoDeEmprestimo = 'E') Then
    Result.Classificacao := '1999'
  Else
    Result.Classificacao := '5999';
  Result.PrefixoClassificacao := LeftStr(Result.Classificacao, 1);
end;

end.
