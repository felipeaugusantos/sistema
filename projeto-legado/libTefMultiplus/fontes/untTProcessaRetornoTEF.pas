unit untTProcessaRetornoTEF;

interface

uses untInterfacesMultiplus, Classes;

type
  TProcessaRetornoTefTcp = Class(TInterfacedObject, IProcessaRetornoTEF)
  private
    FResposta : IRetornoTEF;
    FNsuHost : string;
    const REGISTRO_S : String = 'S';
    const REGISTRO_C : String = 'C';
    const REGISTRO_I : String = 'I';
  public
    constructor Create(ARetorno : IRetornoTEF; ANsuHost: string='');
    procedure Processar(ALinha: String);
  End;

implementation

uses SysUtils, StrUtils;

{ TProcessaRetorno }

constructor TProcessaRetornoTefTcp.Create(ARetorno : IRetornoTEF; ANsuHost: string);
begin
  FResposta := ARetorno;
  FNsuHost  := ANsuHost;
end;

procedure TProcessaRetornoTefTcp.Processar(ALinha: String);
  Var
    stlStatus : TStringList;
    //strLinSav : String;
begin
  If (ALinha.Contains('INICIOS;')) Then // Verificar essa questão com a Multiplus
  Begin
    ALinha := AnsiReplaceStr(ALinha, 'INICIOS;', 'S;');
    ALinha := AnsireplaceStr(ALinha, ';;', '; ;');
    ALinha := TrimRight(ALinha);

    If (AnsiEndsText('I;', ALinha)) Then
      ALinha := Copy(ALinha, 1, Length(ALinha)-2)
    Else If (AnsiEndsText('I', ALinha)) Then
      ALinha := Copy(ALinha, 1, Length(ALinha)-1);

    stlStatus := TStringList.Create;
    Try
      ExtractStrings([';'], [], PWideChar(ALinha), stlStatus);

      FResposta.StatusTEF.strStatus               := stlStatus[POS_STATUS];
      FResposta.StatusTEF.strMensagem             := stlStatus[POS_MENSAGEM];
      FResposta.DadosCartao.strCupom              := stlStatus[POS_CUPOM];
      FResposta.DadosCartao.strValor              := stlStatus[POS_VALOR];
      FResposta.DadosCartao.strBandeira           := stlStatus[POS_BANDEIRA];
      FResposta.DadosCartao.strNomeRede           := stlStatus[POS_NOME_REDE];
      FResposta.DadosCartao.strAutorizacao        := stlStatus[POS_AUTORIZACAO];

      if Pos(AnsiUpperCase(FResposta.DadosCartao.strNomeRede), FNsuHost) > 0 then
        FResposta.DadosCartao.strNSU                := stlStatus[POS_NSU_HOST]
      else
        FResposta.DadosCartao.strNSU                := stlStatus[POS_NSU];

      FResposta.DadosCartao.strTipoTransacao      := stlStatus[POS_TIPO_TRANSACAO];
      FResposta.DadosCartao.strQuantidadeParcelas := stlStatus[POS_QUANTIDADE_PARCELAS];
      FResposta.DadosCartao.strNumeroControle     := stlStatus[POS_NUMERO_CONTROLE];
    Finally
      FreeAndNil(stlStatus);
    End;
  End
  Else If (LeftStr(ALinha, 1) = REGISTRO_I) Then
  Begin
    FResposta.Cupom.Add(Copy(ALinha, 3, Length(ALinha)));
  End;
end;

end.
