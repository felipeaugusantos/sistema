unit untRecalculadorTintadeMaquina;

interface

uses
  untITintaDeMaquina, SysUtils, Math;

type
  TRecalculadorTintadeMaquina = class(TInterfacedObject)
  public
    procedure Recalcular(const tinta: ITintaDeMaquina; const fltPreVenAtual, fltPreCusAtual: Double);
  end;

  procedure RecalcularTintadeMaquina(const tinta: ITintaDeMaquina; const fltPreVenAtual, fltPreCusAtual: Double); stdcall;

implementation

{ TRecalculadorTintadeMaquina }

procedure TRecalculadorTintadeMaquina.Recalcular(const tinta: ITintaDeMaquina; const fltPreVenAtual, fltPreCusAtual: Double);
const
  intCasas: Integer = -5;
var
  intCont: Integer;
  fltTaxa: Double;
  fltTaxaCustoReal: Double;
  fltDifCustoReal: Double;
  fltTotImpostos: Double;
begin
  while (RoundTo(fltPreVenAtual / tinta.PrecoVenda, intCasas) <> 1)
    or (RoundTo(fltPreCusAtual / tinta.PrecoCustoReal, intCasas) <> 1) do
  begin
    fltTaxa := fltPreVenAtual / tinta.PrecoVenda;
    fltTaxaCustoReal := fltPreCusAtual / tinta.PrecoCustoReal;

    for intCont := 0 to tinta.Count - 1 do
    begin
      With tinta.TintaDeMaquinaComponente[intCont] Do
      Begin
        PrecoVenda := fltTaxa * PrecoVenda;

        PrecoCustoReal := fltTaxaCustoReal * PrecoCustoReal;

        fltTotImpostos := DespesasOperacionais + IcmsSaida + ImpostosFederais;        

        fltDifCustoReal := (PrecoCusto + OutrosValores + fltTotImpostos) - PrecoCustoReal;

        If fltTotImpostos > 0 Then
        Begin
          IcmsSaida := IcmsSaida * (1 - fltDifCustoReal / fltTotImpostos);
          ImpostosFederais := ImpostosFederais * (1 - fltDifCustoReal / fltTotImpostos);
          DespesasOperacionais := DespesasOperacionais * (1 - fltDifCustoReal / fltTotImpostos);
        End;
      End;
    end;
  end;

end;

procedure RecalcularTintadeMaquina(const tinta: ITintaDeMaquina; const fltPreVenAtual, fltPreCusAtual: Double); stdcall;
var
  recalculador: TRecalculadorTintadeMaquina;
begin
  recalculador := nil;
  Try
    Try
      if not Assigned(tinta) then
        Exit;

      recalculador := TRecalculadorTintadeMaquina.Create();
      recalculador.Recalcular(tinta, fltPreVenAtual, fltPreCusAtual);
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(recalculador) then FreeAndNil(recalculador);
  End;
end;  

end.

