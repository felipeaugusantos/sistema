unit untCFOPNFComplementoFornecedorValor;

interface

uses untTypesCFOP, Shared.Functions.Configuracoes;

type
  TCFOPNFComplementoFornecedorValor = class(TAbstractClassificacao)
  private
    FConfiguracoes: IConfiguracoes;
    FInputDefine: TInputDefineClassificacaoFiscal;
    FInputOutputClassificacao : TInputOutputClassificacaoFiscal;
  public
    function GetClassificacao: TInputOutputClassificacaoFiscal; Override;
    constructor Create(const AInputDefine: TInputDefineClassificacaoFiscal; const AConfiguracoes: IConfiguracoes; const AInputOutputClassificacao: TInputOutputClassificacaoFiscal); Override;
  End;

implementation

uses System.SysUtils, Shared.Functions.Types, System.StrUtils;

{ TCFOPNFComplementoFornecedorValor }

constructor TCFOPNFComplementoFornecedorValor.Create(const AInputDefine: TInputDefineClassificacaoFiscal; const AConfiguracoes: IConfiguracoes; const AInputOutputClassificacao: TInputOutputClassificacaoFiscal);
begin
  inherited;
  FInputDefine := AInputDefine;
  FInputOutputClassificacao := AInputOutputClassificacao;
  FConfiguracoes := AConfiguracoes;
end;

function TCFOPNFComplementoFornecedorValor.GetClassificacao: TInputOutputClassificacaoFiscal;
  Var
    item: TNfeComplementoItem;
begin
  Result := FInputOutputClassificacao;
  Result.Classificacao := EmptyStr;
  Result.ClassificacaoDeServico := EmptyStr;

  if not Assigned(FInputDefine.NfeComplementoItens) then
    exit;

  if FInputDefine.IncrementoItemAComplementar.IsEmpty then
    exit;

  for item in FInputDefine.NfeComplementoItens do
  begin
    if item.strAutInc = FInputDefine.IncrementoItemAComplementar then
    begin
      Result.Classificacao := item.strClaFis;
      Result.PrefixoClassificacao := LeftStr(Result.Classificacao, 1);
      Break;
    end;
  end;

  If Result.Classificacao.IsEmpty Then
  Begin
    Result.PrefixoClassificacao := EmptyStr;
    Result.AbortarProcedimento := True;
    Result.MensagemRetorno := 'O Autcom não conseguiu encontrar as classificações fiscais dos itens a serem complementados. Entre em contato com a Citel!';
  End;
end;

end.
