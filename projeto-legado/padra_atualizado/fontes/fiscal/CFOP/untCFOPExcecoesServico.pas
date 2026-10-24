unit untCFOPExcecoesServico;

interface

uses untTypesCFOP, Shared.Functions.Configuracoes;

type
  TCFOPExcecoesServico = class(TAbstractClassificacao)
  private
    const
      EXTERIOR = 'EX';
  private
    FConfiguracoes: IConfiguracoes;
    FInputDefine: TInputDefineClassificacaoFiscal;
    FInputOutputClassificacao : TInputOutputClassificacaoFiscal;
    function ClassificacaoDeServico: String;
    function ClassificacaoDeServicoAuxiliar: String;
  public
    function GetClassificacao: TInputOutputClassificacaoFiscal; Override;
    constructor Create(const AInputDefine: TInputDefineClassificacaoFiscal; const AConfiguracoes: IConfiguracoes; const AInputOutputClassificacao: TInputOutputClassificacaoFiscal); Override;
  End;

implementation

uses System.StrUtils;

{ TCFOPExcecoesServico }

constructor TCFOPExcecoesServico.Create(const AInputDefine: TInputDefineClassificacaoFiscal; const AConfiguracoes: IConfiguracoes; const AInputOutputClassificacao: TInputOutputClassificacaoFiscal);
begin
  inherited;
  FInputDefine := AInputDefine;
  FInputOutputClassificacao := AInputOutputClassificacao;
  FConfiguracoes := AConfiguracoes;
end;

function TCFOPExcecoesServico.GetClassificacao: TInputOutputClassificacaoFiscal;
begin
  Result := FInputOutputClassificacao;
  Result.Classificacao := ClassificacaoDeServicoAuxiliar;
  Result.PrefixoClassificacao := LeftStr(Result.Classificacao, 1);
  Result.ClassificacaoDeServico := ClassificacaoDeServico;
end;

function TCFOPExcecoesServico.ClassificacaoDeServico: String;
begin
  Result := ClassificacaoDeServicoAuxiliar;
  If (FInputDefine.ClienteEstado = EXTERIOR) Then
    Result := '7933';
end;

function TCFOPExcecoesServico.ClassificacaoDeServicoAuxiliar: String;
begin
  If FInputDefine.DentroDoEstadoCFOP Then
    Result := '5933'
  Else
    Result := '6933';
end;

end.
