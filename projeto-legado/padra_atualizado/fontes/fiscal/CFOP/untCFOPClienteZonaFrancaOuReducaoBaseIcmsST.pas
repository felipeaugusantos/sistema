unit untCFOPClienteZonaFrancaOuReducaoBaseIcmsST;

interface

uses untTypesCFOP, Shared.Functions.Configuracoes;

type
  TCFOPClienteZonaFrancaOuReducaoBaseIcmsST = class(TAbstractClassificacao)
  private
    FConfiguracoes: IConfiguracoes;
    FInputDefine: TInputDefineClassificacaoFiscal;
    FInputOutputClassificacao : TInputOutputClassificacaoFiscal;
    function EhReducaoBaseIcmsST: Boolean;
  public
    function GetClassificacao: TInputOutputClassificacaoFiscal; Override;
    constructor Create(const AInputDefine: TInputDefineClassificacaoFiscal; const AConfiguracoes: IConfiguracoes; const AInputOutputClassificacao: TInputOutputClassificacaoFiscal); Override;
  End;

implementation

uses Shared.Functions.Funcoes.Faturamento;

{ TCFOPClienteZonaFrancaOuReducaoBaseIcmsST }

constructor TCFOPClienteZonaFrancaOuReducaoBaseIcmsST.Create(const AInputDefine: TInputDefineClassificacaoFiscal; const AConfiguracoes: IConfiguracoes; const AInputOutputClassificacao: TInputOutputClassificacaoFiscal);
begin
  inherited;
  FInputDefine := AInputDefine;
  FInputOutputClassificacao := AInputOutputClassificacao;
  FConfiguracoes := AConfiguracoes;
end;

function TCFOPClienteZonaFrancaOuReducaoBaseIcmsST.GetClassificacao: TInputOutputClassificacaoFiscal;
begin
  Result := FInputOutputClassificacao;
  If EhReducaoBaseIcmsST Then
  Begin
    If TFunctionFuncoesFaturamento.ItemProvenienteDeIndustrializacao(FInputDefine.IndustrializacaoOuRevenda) Then
      Result.Classificacao := Result.PrefixoClassificacao + '401'
    Else
      Result.Classificacao := Result.PrefixoClassificacao + '403';
  End
  Else
  Begin
    If TFunctionFuncoesFaturamento.ItemProvenienteDeIndustrializacao(FInputDefine.IndustrializacaoOuRevenda)  Then
      Result.Classificacao := Result.PrefixoClassificacao + '109'
    Else
      Result.Classificacao := Result.PrefixoClassificacao + '110';
  End;
end;

function TCFOPClienteZonaFrancaOuReducaoBaseIcmsST.EhReducaoBaseIcmsST: Boolean;
begin
  Result := False;

  If FInputDefine.ClienteZonaFranca Then
    Exit;

  If Not FInputDefine.ItemSubstituido Then
    Exit;

  Result := True;
end;

end.
