unit untCFOPRecebimentoGarantiaOutrasEntradas;

interface

uses untTypesCFOP, Shared.Functions.Configuracoes;

type
  TCFOPRecebimentoGarantiaOutrasEntradas = class(TAbstractClassificacao)
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

uses System.StrUtils;

{ TCFOPRecebimentoGarantiaOutrasEntradas }

constructor TCFOPRecebimentoGarantiaOutrasEntradas.Create(const AInputDefine: TInputDefineClassificacaoFiscal; const AConfiguracoes: IConfiguracoes; const AInputOutputClassificacao: TInputOutputClassificacaoFiscal);
begin
  inherited;
  FInputDefine := AInputDefine;
  FInputOutputClassificacao := AInputOutputClassificacao;
  FConfiguracoes := AConfiguracoes;
end;

function TCFOPRecebimentoGarantiaOutrasEntradas.GetClassificacao: TInputOutputClassificacaoFiscal;
begin
  Result := FInputOutputClassificacao;
  If FInputDefine.ItemSubstituido Then
    Result.Classificacao := PreClassificacaoDoItem + RightStr(FInputDefine.ClassificacaoFiscalRecebimentoGarantiaSt, 3)
  Else
    Result.Classificacao := PreClassificacaoDoItem + RightStr(FInputDefine.ClassificacaoFiscalRecebimentoGarantia, 3);
  Result.PrefixoClassificacao := LeftStr(PreClassificacaoDoItem, 1);
end;

function TCFOPRecebimentoGarantiaOutrasEntradas.PreClassificacaoDoItem: String;
begin
  Result := '2';
  If (FInputDefine.DentroDoEstadoCFOP) Then
    Result := '1';
end;

end.