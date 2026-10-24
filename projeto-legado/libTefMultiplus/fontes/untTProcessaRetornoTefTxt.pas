unit untTProcessaRetornoTefTxt;

interface

uses untInterfacesMultiplus, Classes;

type
  TProcessaRetornoTefTxt = Class(TInterfacedObject, IProcessaRetornoTEF)
  private
    FResposta : IRetornoTEF;
    FNsuHost : string;
    const REGISTRO_S : String = 'S;';
    const REGISTRO_C : String = 'C;';
    const REGISTRO_I : String = 'I;';
  public
    constructor Create(ARetorno : IRetornoTEF; ANsuHost: string='');
    procedure Processar(ALinha: String);
  End;

implementation

uses SysUtils, StrUtils, untFuncoes;

{ TProcessaRetorno }

constructor TProcessaRetornoTefTxt.Create(ARetorno : IRetornoTEF; ANsuHost: string);
begin
  FResposta := ARetorno;
  FNsuHost  := ANsuHost;
end;

procedure TProcessaRetornoTefTxt.Processar(ALinha: String);
  Var
    stlStatus : TStringList;
    intCnt : Integer;
begin
  If (LeftStr(ALinha, 2) = REGISTRO_S) Then
  Begin
    stlStatus := TStringList.Create;
    Try
      ExtractStrings([';'], [], PWideChar(ALinha+'; '), stlStatus);

      for intCnt := 0 To Pred(stlStatus.Count) do
        Log('pos = ' + IntToStr(intCnt) + ' - ' + stlStatus[intCnt]);

      FResposta.StatusTEF.strStatus := stlStatus[POS_STATUS];
      FResposta.StatusTEF.strMensagem := stlStatus[POS_MENSAGEM];
    finally
      FreeAndNil(stlStatus);
    end;
  End
  Else If (LeftStr(ALinha, 2) = REGISTRO_C) Then
  Begin
    stlStatus := TStringList.Create;
    Try
      ALinha := AnsireplaceStr(ALinha+';', ';;', '; ; ');
      ExtractStrings([';'], [], PWideChar(ALinha), stlStatus);

      for intCnt := 0 To Pred(stlStatus.Count) do
        Log('pos = ' + IntToStr(intCnt) + ' - ' + stlStatus[intCnt]);

      FResposta.DadosCartao.strCupom              := stlStatus[1];
      FResposta.DadosCartao.strValor              := stlStatus[2];
      FResposta.DadosCartao.strBandeira           := stlStatus[3];
      FResposta.DadosCartao.strNomeRede           := stlStatus[4];
      FResposta.DadosCartao.strAutorizacao        := stlStatus[5];

      if Pos(AnsiUpperCase(FResposta.DadosCartao.strNomeRede), FNsuHost) > 0 then
        FResposta.DadosCartao.strNSU              := stlStatus[10]
      else
        FResposta.DadosCartao.strNSU              := stlStatus[6];

      FResposta.DadosCartao.strTipoTransacao      := stlStatus[7];
      FResposta.DadosCartao.strQuantidadeParcelas := stlStatus[8];
      FResposta.DadosCartao.strNumeroControle     := stlStatus[9];
    Finally
      FreeAndNil(stlStatus);
    End;
  End
  Else If (LeftStr(ALinha, 2) = REGISTRO_I) Then
  Begin
    FResposta.Cupom.Add(Copy(ALinha, 3, Length(ALinha)));
  End;
end;

end.
