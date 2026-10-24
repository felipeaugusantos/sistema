unit untTotalDesejadoDoItem;

interface

uses untFuncFatTypes;

type
  TFncCalcularImpostosItemSelecionado = reference to function (const ACalculaImpostoItemSelecionado : TCalculaImpostoItemSelecionado) : TMatrizFechamento;

  TTotalDesejadoDoItem = class
  private
    FValorSemImpostoMaisProximoDoEscolhido: Double;
    FValorSTPrecoMaisProximoDoEscolhido: Double;
    FValorIPIPrecoMaisProximoDoEscolhido: Double;
    FValorFCPSTPrecoMaisProximoDoEscolhido: Double;
    FValorCBSPrecoMaisProximoDoEscolhido: Double;
    FValorIBSPrecoMaisProximoDoEscolhido: Double;
    FValorISPrecoMaisProximoDoEscolhido: Double;
    FCalcularImpostosItemSelecionado: TFncCalcularImpostosItemSelecionado;
    FMatrizFechamento: TMatrizFechamento;
    function CalcularValorMaisProximoDoEscolhido(const ATotalSemImpostosCalculado : Double; const AValorFinalDesejado : Double; const ACasasDecimais : Integer) : Double;
  public
    constructor Create(const ACalcularImpostosItemSelecionado : TFncCalcularImpostosItemSelecionado);
    function ValorDesejadoConsiderandoImpostos(const AValorFinalDesejado : Double; const ACasasDecimais : Integer = 2) : Double;
    function CalcularValorFinalDoItem(const ATotalSemImpostos : Double) : Double;
    class function ImpostosQueSomamAoValorFinal(const AItem : TDadosFechamento) : Double;
  public
    property valorST: Double read FValorSTPrecoMaisProximoDoEscolhido;
    property valorIPI: Double read FValorIPIPrecoMaisProximoDoEscolhido;
    property valorFCPST: Double read FValorFCPSTPrecoMaisProximoDoEscolhido;
    property valorCBS: Double read FValorCBSPrecoMaisProximoDoEscolhido;
    property valorIBS: Double read FValorIBSPrecoMaisProximoDoEscolhido;
    property valorIS: Double read FValorISPrecoMaisProximoDoEscolhido;
  end;

implementation

uses System.Math, System.Types, untFuncoesSimples;

{ TTotalDoItemDesejado }

constructor TTotalDesejadoDoItem.Create(const ACalcularImpostosItemSelecionado: TFncCalcularImpostosItemSelecionado);
begin
  FCalcularImpostosItemSelecionado := ACalcularImpostosItemSelecionado;
end;

function TTotalDesejadoDoItem.CalcularValorMaisProximoDoEscolhido(const ATotalSemImpostosCalculado : Double; const AValorFinalDesejado : Double; const ACasasDecimais : Integer) : Double;
  Const
    TENTATIVAS : Integer = 8;
  Var
    LMenorDiferenca : Double;
    LPasso : Double;
    LCount : Integer;

  procedure pGuardarTentativa(const ATentativa : Double; const ADiferenca : Double);
  begin
    LMenorDiferenca := ADiferenca;
    FValorSemImpostoMaisProximoDoEscolhido := ATentativa;

    FValorSTPrecoMaisProximoDoEscolhido := 0;
    FValorIPIPrecoMaisProximoDoEscolhido := 0;
    FValorFCPSTPrecoMaisProximoDoEscolhido := 0;
    FValorCBSPrecoMaisProximoDoEscolhido := 0;
    FValorIBSPrecoMaisProximoDoEscolhido := 0;
    FValorISPrecoMaisProximoDoEscolhido := 0;

    if Length(FMatrizFechamento) > 0 then
    begin
      FValorSTPrecoMaisProximoDoEscolhido  := FMatrizFechamento[0].fltValRet;
      FValorIPIPrecoMaisProximoDoEscolhido := FMatrizFechamento[0].fltValipi;
      If (FMatrizFechamento[0].fltValRet > 0) Then
        FValorFCPSTPrecoMaisProximoDoEscolhido := FMatrizFechamento[0].recDifalFCP.fltValFcp;
      FValorCBSPrecoMaisProximoDoEscolhido := FMatrizFechamento[0].fltValCBS;
      FValorIBSPrecoMaisProximoDoEscolhido := FMatrizFechamento[0].fltValIBS;
      FValorISPrecoMaisProximoDoEscolhido := FMatrizFechamento[0].fltVal_IS;
    end;
  end;

  function fDiferencaDaTentativa(const ATentativa : Double) : Double;
  begin
    Result := Abs(fFormataFloat(AValorFinalDesejado, 2) - fFormataFloat(CalcularValorFinalDoItem(ATentativa), 2));
  end;

  procedure pAvaliarTentativa(const ATentativa : Double);
    Var
      LTentativa : Double;
      LDiferenca : Double;
  begin
    LTentativa := fFormataFloat(ATentativa, ACasasDecimais);
    If (LTentativa <= 0) Then
      Exit;
    LDiferenca := fDiferencaDaTentativa(LTentativa);
    If (fFormataFloat(LDiferenca, 2) < fFormataFloat(LMenorDiferenca, 2)) Then
      pGuardarTentativa(LTentativa, LDiferenca);
  end;

begin
  LPasso := Power(10, -ACasasDecimais);

  pGuardarTentativa(ATotalSemImpostosCalculado, fDiferencaDaTentativa(ATotalSemImpostosCalculado));

  For LCount := 1 To TENTATIVAS Do
  Begin
    If (LMenorDiferenca < 0.005) Then
      Break;
    pAvaliarTentativa(ATotalSemImpostosCalculado + (LCount * LPasso));
    If (LMenorDiferenca < 0.005) Then
      Break;
    pAvaliarTentativa(ATotalSemImpostosCalculado - (LCount * LPasso));
  End;

  Result := FValorSemImpostoMaisProximoDoEscolhido;
end;

function TTotalDesejadoDoItem.ValorDesejadoConsiderandoImpostos(const AValorFinalDesejado : Double; const ACasasDecimais : Integer = 2) : Double;
  Var
    LCalculaImpostoItemSelecionado : TCalculaImpostoItemSelecionado;
    LFator : Double;
    LValorDesejadoSemImpostos : Double;
    LMatrizFechamento : TMatrizFechamento;
begin
  Result := AValorFinalDesejado;
  FillChar(LCalculaImpostoItemSelecionado, SizeOf(LCalculaImpostoItemSelecionado), #0);
  LCalculaImpostoItemSelecionado.Unitario := 100;
  LCalculaImpostoItemSelecionado.UnitarioLiquido := 100;
  LCalculaImpostoItemSelecionado.Quantidade := 1;
  LCalculaImpostoItemSelecionado.PercentualDesconto := 0;
  LCalculaImpostoItemSelecionado.TotalDoItem := 100;
  LMatrizFechamento := FCalcularImpostosItemSelecionado(LCalculaImpostoItemSelecionado);
  If Length(LMatrizFechamento) = 0 Then
    Exit;
  LFator := LMatrizFechamento[0].fltValipi + LMatrizFechamento[0].fltValRet + LMatrizFechamento[0].fltValCbs + LMatrizFechamento[0].fltValIBS + LMatrizFechamento[0].fltVal_IS;
  If (LMatrizFechamento[0].fltValRet > 0) Then
    LFator := LFator + LMatrizFechamento[0].recDifalFCP.fltValFcp;
  If (fFormataFloat(LFator, 4) <= 0) Then
    Exit;
  LValorDesejadoSemImpostos := fFormataFloat(AValorFinalDesejado / ( 1 + ( LFator / 100 ) ), ACasasDecimais);
  Result := CalcularValorMaisProximoDoEscolhido(LValorDesejadoSemImpostos, AValorFinalDesejado, ACasasDecimais);
end;

function TTotalDesejadoDoItem.CalcularValorFinalDoItem(const ATotalSemImpostos : Double) : Double;
Var
  LCalculaImpostoItemSelecionado : TCalculaImpostoItemSelecionado;
begin
  Result := ATotalSemImpostos;
  FillChar(LCalculaImpostoItemSelecionado, SizeOf(LCalculaImpostoItemSelecionado), #0);
  LCalculaImpostoItemSelecionado.Unitario := ATotalSemImpostos;
  LCalculaImpostoItemSelecionado.UnitarioLiquido := ATotalSemImpostos;
  LCalculaImpostoItemSelecionado.Quantidade := 1;
  LCalculaImpostoItemSelecionado.PercentualDesconto := 0;
  LCalculaImpostoItemSelecionado.TotalDoItem := ATotalSemImpostos;
  FMatrizFechamento := FCalcularImpostosItemSelecionado(LCalculaImpostoItemSelecionado);
  If Length(FMatrizFechamento) = 0 Then
    Exit;
  Result := FMatrizFechamento[0].fltTotIte + ImpostosQueSomamAoValorFinal(FMatrizFechamento[0]);
end;

class function TTotalDesejadoDoItem.ImpostosQueSomamAoValorFinal(const AItem: TDadosFechamento): Double;
begin
  Result := AItem.fltValRet + AItem.fltValipi + AItem.fltValCBS + AItem.fltValIBS + AItem.fltVal_IS;
  If (AItem.fltValRet > 0) Then
    Result := Result + AItem.recDifalFCP.fltValFcp;
end;

end.
