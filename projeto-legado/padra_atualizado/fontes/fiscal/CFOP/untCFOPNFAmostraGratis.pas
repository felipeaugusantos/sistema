unit untCFOPNFAmostraGratis;

interface

uses untTypesCFOP, Shared.Functions.Configuracoes;

type
  TCFOPNFAmostraGratis = class(TAbstractClassificacao)
  private
    FConfiguracoes: IConfiguracoes;
    FInputDefine: TInputDefineClassificacaoFiscal;
    FInputOutputClassificacao : TInputOutputClassificacaoFiscal;
    function CodigoDaSituacaoTributaria: String;
  public
    function GetClassificacao: TInputOutputClassificacaoFiscal; Override;
    constructor Create(const AInputDefine: TInputDefineClassificacaoFiscal; const AConfiguracoes: IConfiguracoes; const AInputOutputClassificacao: TInputOutputClassificacaoFiscal); Override;
  End;

implementation

uses System.SysUtils, System.StrUtils;

{ TCFOPNFAmostraGratis }

function TCFOPNFAmostraGratis.CodigoDaSituacaoTributaria: String;
begin
  Result := '';
  if FInputDefine.EntradaOuSaidaDoItem = 'S' then
  begin
    if RightStr(FInputDefine.SituacaoTributaria, 2) = '00' then
      Result := LeftStr(FInputDefine.SituacaoTributaria, 1) + '41'
    else if RightStr(FInputDefine.SituacaoTributaria, 2) = '60' then
      Result := FInputDefine.SituacaoTributaria
    else // Não existia esse tratamento no requisito original
      Result := FInputDefine.SituacaoTributaria;
  end;
end;

constructor TCFOPNFAmostraGratis.Create(const AInputDefine: TInputDefineClassificacaoFiscal; const AConfiguracoes: IConfiguracoes; const AInputOutputClassificacao: TInputOutputClassificacaoFiscal);
begin
  inherited;
  FInputDefine := AInputDefine;
  FInputOutputClassificacao := AInputOutputClassificacao;
  FConfiguracoes := AConfiguracoes;
end;

function TCFOPNFAmostraGratis.GetClassificacao: TInputOutputClassificacaoFiscal;
begin
  Result := FInputOutputClassificacao;
  Result.Classificacao := EmptyStr;
  Result.ClassificacaoDeServico := EmptyStr;
  Result.SituacaoTributaria := CodigoDaSituacaoTributaria;
  if FInputDefine.EntradaOuSaidaDoItem = 'S' then
  begin
    if FInputDefine.DentroDoEstado then
      Result.Classificacao := '5911'
    else
      Result.Classificacao := '6911';
    Result.PrefixoClassificacao := LeftStr(Result.Classificacao, 1);
  end;
  If (Result.Classificacao.IsEmpty) Then
  Begin
    Result.PrefixoClassificacao := EmptyStr;
    Result.AbortarProcedimento := True;
    Result.MensagemRetorno := 'O Autcom não conseguiu encontrar as classificações fiscais dos itens da nota de Amostra Grátis. Entre em contato com a Citel!';
  End;
  If (Result.SituacaoTributaria.IsEmpty) And (Not Result.AbortarProcedimento) Then
  Begin
    Result.AbortarProcedimento := True;
    Result.MensagemRetorno := 'O Autcom não conseguiu encontrar os códigos da situação tributária dos itens da nota de Amostra Grátis. Entre em contato com a Citel!';
  End;
end;

end.
