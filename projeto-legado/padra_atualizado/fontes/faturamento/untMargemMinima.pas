unit untMargemMinima;

interface

uses untFuncFatTypes;

type
  TMargemMinima = class
  private
    const
      PRECO_CUSTO_PRECUS : String = '1';
      CUSTO_REAL_PRECUS : String = '2';
      PRECO_CUSTO_PREMED : String = '3';
      CUSTO_REAL_PREMED : String = '4';
  public
    class function UsaPrecoBruto : Boolean;
    class function UsaPrecoLiquido : Boolean;
    class function UsaPrecoMedio : Boolean;
    class function UsaPrecoCusto : Boolean;
    class function TotalParaTravaDePreco(const ATotMarLuc : TRecTotaisMargemLucro; const ATotalPraticado : Boolean) : Double;
    class function PorPrecoCustoPreCus: Boolean;
    class function PorCustoRealPreCus: Boolean;
    class function PorPrecoCustoPreMed: Boolean;
    class function PorCustoRealPreMed: Boolean;
  End;

implementation

uses
{$IFDEF LINUX}
  Services.Core.Utils
 {$ELSE}
  untFuncoesSimples
 {$ENDIF},
 untConstantes;

{ TMargemMinima }

class function TMargemMinima.UsaPrecoBruto: Boolean;
  Var
    LValorCfg : String;
begin
  Result := True;
  LValorCfg := fCfgSis('PRCREA', varString);
  If (LValorCfg = PRECO_CUSTO_PRECUS) Then
    Exit;
  If (LValorCfg = PRECO_CUSTO_PREMED) Then
    Exit;
  Result := False;
end;

class function TMargemMinima.UsaPrecoCusto: Boolean;
  Var
    LValorCfg : String;
begin
  Result := True;
  LValorCfg := fCfgSis('PRCREA', varString);
  If (LValorCfg = PRECO_CUSTO_PRECUS) Then
    Exit;
  If (LValorCfg = CUSTO_REAL_PRECUS) Then
    Exit;
  Result := False;
end;

class function TMargemMinima.UsaPrecoLiquido: Boolean;
  Var
    LValorCfg : String;
begin
  Result := True;
  LValorCfg := fCfgSis('PRCREA', varString);
  If (LValorCfg = CUSTO_REAL_PRECUS) Then
    Exit;
  If (LValorCfg = CUSTO_REAL_PREMED) Then
    Exit;
  Result := False;
end;

class function TMargemMinima.UsaPrecoMedio: Boolean;
  Var
    LValorCfg : String;
begin
  Result := True;
  LValorCfg := fCfgSis('PRCREA', varString);
  If (LValorCfg = PRECO_CUSTO_PREMED) Then
    Exit;
  If (LValorCfg = CUSTO_REAL_PREMED) Then
    Exit;
  Result := False;
end;

class function TMargemMinima.TotalParaTravaDePreco(const ATotMarLuc : TRecTotaisMargemLucro; const ATotalPraticado : Boolean) : Double;
  Var
    LValorCfg : String;
begin
  Result := 0;
  LValorCfg := fCfgSis('PRCREA', varString);
  If (LValorCfg = PRECO_CUSTO_PRECUS) Then
    Exit(ATotMarLuc.fltTotMarPra_CUSITE);
  If (LValorCfg = CUSTO_REAL_PRECUS) Then
  Begin
    If (ATotalPraticado) Then
      Exit(ATotMarLuc.fltTotMarPrat)
    Else
      Exit(ATotMarLuc.fltTotMarPra_PRECUS);
  End;
  If (LValorCfg = PRECO_CUSTO_PREMED) Then
  Begin
    If (fCfgSis('MARMKP') = MARGEM_SOBRE_PRECO_VENDA_LIQUIDO_RITEC) Then
      Exit(ATotMarLuc.fltTotMePrBr_PREMED)
    Else
      Exit(ATotMarLuc.fltTotMarBru_PREMED);
  End;
  If (LValorCfg = CUSTO_REAL_PREMED) Then
    Exit(ATotMarLuc.fltTotMarLiq_PREMED);
end;

class function TMargemMinima.PorPrecoCustoPreCus: Boolean;
begin
  Result := (fCfgSis('PRCREA', varString) = PRECO_CUSTO_PRECUS);
end;

class function TMargemMinima.PorCustoRealPreCus: Boolean;
begin
  Result := fCfgSis('PRCREA', varString) = CUSTO_REAL_PRECUS;
end;

class function TMargemMinima.PorPrecoCustoPreMed: Boolean;
begin
  Result := fCfgSis('PRCREA', varString) = PRECO_CUSTO_PREMED;
end;

class function TMargemMinima.PorCustoRealPreMed: Boolean;
begin
  Result := fCfgSis('PRCREA', varString) = CUSTO_REAL_PREMED;
end;

end.
