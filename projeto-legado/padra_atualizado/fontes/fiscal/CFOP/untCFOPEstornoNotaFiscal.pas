unit untCFOPEstornoNotaFiscal;

interface

uses untTypesCFOP, Shared.Functions.Configuracoes;

type
  TCFOPEstornoNotaFiscal = class(TAbstractClassificacao)
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

uses Shared.Functions.Funcoes.Faturamento;

{ TCFOPEstornoNotaFiscal }

constructor TCFOPEstornoNotaFiscal.Create(const AInputDefine: TInputDefineClassificacaoFiscal; const AConfiguracoes: IConfiguracoes; const AInputOutputClassificacao: TInputOutputClassificacaoFiscal);
begin
  inherited;
  FInputDefine := AInputDefine;
  FInputOutputClassificacao := AInputOutputClassificacao;
  FConfiguracoes := AConfiguracoes;
end;

function TCFOPEstornoNotaFiscal.GetClassificacao: TInputOutputClassificacaoFiscal;
begin
  Result := FInputOutputClassificacao;
  Result.Classificacao := PreClassificacaoDoItem + '949';
end;

function TCFOPEstornoNotaFiscal.PreClassificacaoDoItem: String;
begin
  If (FInputDefine.EstornoNotaFiscalEntregaFutura) Then
  Begin
    Result := '2';
    If (FInputDefine.DentroDoEstadoCFOP) Or (FInputDefine.DentroDoEstado) Then
      Result := '1';
    FInputOutputClassificacao.PrefixoClassificacao := Result;
  End
  Else
    Result := FInputOutputClassificacao.PrefixoClassificacao;
end;

end.