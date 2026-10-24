unit untCFOPAkzoNobel;

interface

uses untTypesCFOP, Shared.Functions.Configuracoes;

type
  TCFOPAkzoNobel = class(TAbstractClassificacao)
  private
    FConfiguracoes: IConfiguracoes;
    FInputDefine: TInputDefineClassificacaoFiscal;
    FInputOutputClassificacao : TInputOutputClassificacaoFiscal;
    procedure ValidaPreenchimentoClassificacao(var Result : TInputOutputClassificacaoFiscal);
  public
    function GetClassificacao: TInputOutputClassificacaoFiscal; Override;
    constructor Create(const AInputDefine: TInputDefineClassificacaoFiscal; const AConfiguracoes: IConfiguracoes; const AInputOutputClassificacao: TInputOutputClassificacaoFiscal); Override;
  End;

implementation

uses System.SysUtils;

{ TCFOPAkzoNobel }

constructor TCFOPAkzoNobel.Create(const AInputDefine: TInputDefineClassificacaoFiscal; const AConfiguracoes: IConfiguracoes; const AInputOutputClassificacao: TInputOutputClassificacaoFiscal);
begin
  inherited;
  FInputDefine := AInputDefine;
  FInputOutputClassificacao := AInputOutputClassificacao;
  FConfiguracoes := AConfiguracoes;
end;

function TCFOPAkzoNobel.GetClassificacao: TInputOutputClassificacaoFiscal;
begin
  Result := FInputOutputClassificacao;
  Result.Classificacao := FInputOutputClassificacao.PrefixoClassificacao + FConfiguracoes.fGetValorConfiguracao(CFG_CLAFIS_EMISSAO_DOCUMENTO_VENDA_AKZONOBEL);
  ValidaPreenchimentoClassificacao(Result);
end;

procedure TCFOPAkzoNobel.ValidaPreenchimentoClassificacao(var Result : TInputOutputClassificacaoFiscal);
begin
  If (Length(Result.Classificacao) = 4) Then
    Exit;
  Result.MensagemRetorno := Format('É necessário preencher a configuração CFG_%s antes de prosseguir com essa operação ["Akzo Nobel"]', [CFG_CLAFIS_EMISSAO_DOCUMENTO_VENDA_AKZONOBEL]);
  Result.AbortarProcedimento := True;
end;

end.
