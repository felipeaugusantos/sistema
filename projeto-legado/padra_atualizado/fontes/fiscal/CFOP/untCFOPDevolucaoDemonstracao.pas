unit untCFOPDevolucaoDemonstracao;

interface

uses untTypesCFOP, Shared.Functions.Configuracoes;

type
  TCFOPDevolucaoDemonstracao = class(TAbstractClassificacao)
  private
    FConfiguracoes: IConfiguracoes;
    FInputDefine: TInputDefineClassificacaoFiscal;
    FInputOutputClassificacao : TInputOutputClassificacaoFiscal;
    function PreClassificacaoDoItem: String;
  public
    function GetClassificacao: TInputOutputClassificacaoFiscal; Override;
    constructor Create(const AInputDefine: TInputDefineClassificacaoFiscal; const AConfiguracoes: IConfiguracoes; const AInputOutputClassificacao: TInputOutputClassificacaoFiscal); Override;
  End;

implementation

{ TCFOPDevolucaoDemonstracao }

constructor TCFOPDevolucaoDemonstracao.Create(const AInputDefine: TInputDefineClassificacaoFiscal; const AConfiguracoes: IConfiguracoes; const AInputOutputClassificacao: TInputOutputClassificacaoFiscal);
begin
  inherited;
  FInputDefine := AInputDefine;
  FInputOutputClassificacao := AInputOutputClassificacao;
  FConfiguracoes := AConfiguracoes;
end;

function TCFOPDevolucaoDemonstracao.GetClassificacao: TInputOutputClassificacaoFiscal;
begin
  Result := FInputOutputClassificacao;
  Result.PrefixoClassificacao := PreClassificacaoDoItem;
  Result.Classificacao := Result.PrefixoClassificacao + '913';
end;

function TCFOPDevolucaoDemonstracao.PreClassificacaoDoItem: String;
begin
  Result := '2';
  If FInputDefine.DentroDoEstadoCFOP Then
    Result := '1';
end;

end.
