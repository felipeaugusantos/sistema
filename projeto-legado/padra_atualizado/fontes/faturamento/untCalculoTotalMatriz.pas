unit untCalculoTotalMatriz;

interface

uses untFuncFat, untFuncFatTypes;

type
  TCalculoTotalMatrizInput = record
    fltPorDesSav : Double;
    fltTotSav : Double;
    strEspDocSav : String;
    fltDesSav : Double;
    fltFreSav : Double;
    fltAdtSav : Double;
    fltAceSav : Double;
    fltFreRatSav : Double;
    fltTaxEntSav : Double;
    fltTotItensNaoRateiaFreteVendaPresencial : Double;
    fltFreSugSav : Double;
    fltFreCotSav : Double;
  End;

  TCalculoTotalMatrizAcumuladores = record
    fltTotDes : Double;
    fltFreTot : Double;
    fltAdtTot : Double;
    fltAceTot : Double;
    fltFreRatTot : Double;
    fltTaxEntTot : Double;
    fltFreSugTot : Double;
    fltFreCotTot : Double;
  End;

  TCalculoTotalMatriz = class
  private
    FInput : TCalculoTotalMatrizInput;
    function VaiDesmembrar(const arrMatrizesFechamento: TMatrizesFechamento) : Boolean;
  public
    procedure CalcularMatriz(var objFatVenda : TFatVenda; const arrMatrizesFechamento: TMatrizesFechamento; const intIndice : Integer; Var recAcumuladores : TCalculoTotalMatrizAcumuladores);
    constructor Create(recInput : TCalculoTotalMatrizInput);
  End;

implementation

uses System.Math, untFuncoesSimples;

{ TCalculoTotalMatriz }

procedure TCalculoTotalMatriz.CalcularMatriz(var objFatVenda: TFatVenda;
  const arrMatrizesFechamento: TMatrizesFechamento; const intIndice: Integer;
  var recAcumuladores: TCalculoTotalMatrizAcumuladores);
  Var
    fltDesEspSomaItens : Double;
    fltDesAceSomaItens : Double;
    fltValFreSomaItens : Double;
    fltValFreRatSomaItens : Double;
    fltValFreSugSomaItens : Double;
    fltValFreCotSomaItens : Double;
    fltValTaxEntSomaItens: Double;
    intItens : Integer;
    fltTotBaseFrete : Double;
begin
  {**********************************************************************}
  {* Antes de ser desmembrada a matriz já possuia fltDesEsp, fltDesAce  *}
  {* fltValFre, fltFreRat fltTaxEnt distríbuidas conforme as regras de  *}
  {* pRateiaValores, então aqui, eu resgato os valores e carrego as     *}
  {* respectivas globais antes da primeira chamada da pCalculaTotGer.   *}
  {**********************************************************************}
  fltDesEspSomaItens    := 0.00;
  fltDesAceSomaItens    := 0.00;
  fltValFreSomaItens    := 0.00;
  fltValFreRatSomaItens := 0.00;
  fltValFreSugSomaItens := 0.00;
  fltValFreCotSomaItens := 0.00;
  fltValTaxEntSomaItens := 0.00;

  For intItens := Low(objFatVenda.arrMatItens) To High(objFatVenda.arrMatItens) Do
  Begin
    fltDesEspSomaItens    := fltDesEspSomaItens    + objFatVenda.arrMatItens[intItens].recBackup.fltDesEsp;
    fltDesAceSomaItens    := fltDesAceSomaItens    + objFatVenda.arrMatItens[intItens].recBackup.fltDesAce;
    fltValFreSomaItens    := fltValFreSomaItens    + objFatVenda.arrMatItens[intItens].recBackup.fltValFre;
    fltValFreRatSomaItens := fltValFreRatSomaItens + objFatVenda.arrMatItens[intItens].recBackup.fltFreRat;
    fltValFreSugSomaItens := fltValFreSugSomaItens + objFatVenda.arrMatItens[intItens].recBackup.fltFreSug;
    fltValFreCotSomaItens := fltValFreCotSomaItens + objFatVenda.arrMatItens[intItens].recBackup.fltFreCot;
    fltValTaxEntSomaItens := fltValTaxEntSomaItens + objFatVenda.arrMatItens[intItens].recBackup.fltTaxEnt;
  End;

  objFatVenda.fltDesEsp := fltDesEspSomaItens;
  objFatVenda.fltDesAce := fltDesAceSomaItens;
  objFatVenda.fltValFre := fltValFreSomaItens;
  objFatVenda.fltFreRat := fltValFreRatSomaItens;
  objFatVenda.fltFreSug := fltValFreSugSomaItens;
  objFatVenda.fltFreCot := fltValFreCotSomaItens;
  objFatVenda.fltTaxEnt := fltValTaxEntSomaItens;
  {*******************************************************REQ.:280307*VA*}

  objFatVenda.pCalculaTotGer(True);
  objFatVenda.strEspDoc := FInput.strEspDocSav;

  If objFatVenda.fSomenteItensDeServico(arrMatrizesFechamento[intIndice]) Then
  Begin
    objFatVenda.fltDesEsp := 0;
    objFatVenda.fltValFre := 0;
    objFatVenda.fltDesAce := 0;
    objFatVenda.fltFreRat := 0;
    objFatVenda.fltFreSug := 0;
    objFatVenda.fltFreCot := 0;
    objFatVenda.fltTaxEnt := 0;
  End

  Else If Length(arrMatrizesFechamento) > 1 Then
  Begin
    If intIndice = Length(arrMatrizesFechamento) - 1 Then
    Begin
      objFatVenda.fltDesEsp := FInput.fltDesSav    - recAcumuladores.fltTotDes;
      objFatVenda.fltValFre := FInput.fltFreSav    - recAcumuladores.fltFreTot;
      objFatVenda.fltDesAce := FInput.fltAceSav    - recAcumuladores.fltAceTot;
      objFatVenda.fltFreRat := FInput.fltFreRatSav - recAcumuladores.fltFreRatTot;
      objFatVenda.fltFreSug := FInput.fltFreSugSav - recAcumuladores.fltFreSugTot;
      objFatVenda.fltFreCot := FInput.fltFreCotSav - recAcumuladores.fltFreCotTot;
      objFatVenda.fltTaxEnt := FInput.fltTaxEntSav - recAcumuladores.fltTaxEntTot;
    End
    Else
    Begin
      objFatVenda.fltDesEsp := fltDesEspSomaItens;
      objFatVenda.fltValFre := fltValFreSomaItens;

      if ((objFatVenda.blnVendaPresencial) and (FInput.fltTotItensNaoRateiaFreteVendaPresencial > 0)) then
      begin
        fltTotBaseFrete := objFatVenda.fBaseRateioFreteVendaPresencial(arrMatrizesFechamento[intIndice]);

        if fltTotBaseFrete = 0 then
          objFatVenda.fltValFre := 0
        else
          objFatVenda.fltValFre := RoundTo(FInput.fltFreSav * (fltTotBaseFrete / (FInput.fltTotSav - FInput.fltTotItensNaoRateiaFreteVendaPresencial)), -2);
      end;

      objFatVenda.fltFreRat := fltValFreRatSomaItens;
      objFatVenda.fltFreSug := fltValFreSugSomaItens;
      objFatVenda.fltFreCot := fltValFreCotSomaItens;
      objFatVenda.fltTaxEnt := fltValTaxEntSomaItens;
      objFatVenda.fltDesAce := fltDesAceSomaItens;
    End;
  End
  Else
  Begin
    objFatVenda.fltDesEsp := FInput.fltDesSav;
    objFatVenda.fltValFre := FInput.fltFreSav;
    objFatVenda.fltDesAce := FInput.fltAceSav;
    objFatVenda.fltFreRat := FInput.fltFreRatSav;
    objFatVenda.fltFreSug := FInput.fltFreSugSav;
    objFatVenda.fltFreCot := FInput.fltFreCotSav;
    objFatVenda.fltTaxEnt := FInput.fltTaxEntSav;
  End;

  recAcumuladores.fltTotDes    := recAcumuladores.fltTotDes    + objFatVenda.fltDesEsp;
  recAcumuladores.fltFreTot    := recAcumuladores.fltFreTot    + objFatVenda.fltValFre;
  recAcumuladores.fltAceTot    := recAcumuladores.fltAceTot    + objFatVenda.fltDesAce;
  recAcumuladores.fltFreRatTot := recAcumuladores.fltFreRatTot + objFatVenda.fltFreRat;
  recAcumuladores.fltFreSugTot := recAcumuladores.fltFreSugTot + objFatVenda.fltFreSug;
  recAcumuladores.fltFreCotTot := recAcumuladores.fltFreCotTot + objFatVenda.fltFreCot;
  recAcumuladores.fltTaxEntTot := recAcumuladores.fltTaxEntTot + objFatVenda.fltTaxEnt;

  objFatVenda.fltPorDes := FInput.fltPorDesSav;

  If (Self.VaiDesmembrar(arrMatrizesFechamento)) And (fCfgSis('CALVOL', varString) = 'S') Then
    objFatVenda.intQtdTra := Floor(objFatVenda.fRetVolumes);

  objFatVenda.pCalculaTotGer;
end;

constructor TCalculoTotalMatriz.Create(recInput: TCalculoTotalMatrizInput);
begin
  FInput := recInput;
end;

function TCalculoTotalMatriz.VaiDesmembrar(const arrMatrizesFechamento: TMatrizesFechamento) : Boolean;
begin
  Result := (Length(arrMatrizesFechamento) > 1);
end;

end.
