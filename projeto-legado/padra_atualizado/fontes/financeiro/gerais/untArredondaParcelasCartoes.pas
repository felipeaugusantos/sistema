unit untArredondaParcelasCartoes;

interface
  uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
{$ELSE }
  untFuncoesSimples,
{$ENDIF LINUX}
  System.JSON, strUtils, untTypesSistema, Classes;

Type
  TArredondaParCartaoPos = Class(TCollection)
    Private
    Protected

    Public
    class function fArredondamentoParcelas(strCodCar: String): IArredondaParcela;
  End;


Type
  TArredondaParcelaDefault = class(TInterfacedObject, IArredondaParcela)
  public
    procedure pArredondaParcela(fltValTot: Double; intQtdPar: Integer; var arrDigDuplicArray: TArrDigDuplicArray);
    class function fNew: IArredondaParcela;
  End;

Type
  TArredondaParcelaCielo = class(TInterfacedObject, IArredondaParcela)
    procedure pArredondaParcela(fltValTot: Double; intQtdPar: Integer; var arrDigDuplicArray: TArrDigDuplicArray);
    class function fNew: IArredondaParcela;
  End;

Type
  TArrendondaPrimeiraParcela = class(TInterfacedObject, IArredondaParcela)
    procedure pArredondaParcela(fltValTot: Double; intQtdPar: Integer; var arrDigDuplicArray: TArrDigDuplicArray);
    class function fNew: IArredondaParcela;
  End;

Type
  TArrendondaUltimaParcela = class(TInterfacedObject, IArredondaParcela)
    procedure pArredondaParcela(fltValTot: Double; intQtdPar: Integer; var arrDigDuplicArray: TArrDigDuplicArray);
    class function fNew: IArredondaParcela;
  End;

implementation

uses System.AnsiStrings, System.SysUtils;

{ TArredondaParcelaDefault }

class function TArredondaParcelaDefault.fNew: IArredondaParcela;
begin
  Result := TArredondaParcelaDefault.Create;
end;

procedure TArredondaParcelaDefault.pArredondaParcela(fltValTot: Double;
  intQtdPar: Integer; var arrDigDuplicArray: TArrDigDuplicArray);
begin
  pArredondaParcelaDefault(fltValTot, intQtdPar, arrDigDuplicArray);
end;

{ TArredondaParcelaCielo }

class function TArredondaParcelaCielo.fNew: IArredondaParcela;
begin
  Result := TArredondaParcelaCielo.Create;
end;

procedure TArredondaParcelaCielo.pArredondaParcela(fltValTot: Double;
  intQtdPar: Integer; var arrDigDuplicArray: TArrDigDuplicArray);
  Var
    fltValPar : Double;
    intIndice : Integer;
begin
  fltValPar := fTruncaFloat(fltValTot / intQtdPar, 2);

  arrDigDuplicArray[0].curValor := fltValPar;

  If (fltValPar * intQtdPar <> fltValTot) Then
    arrDigDuplicArray[0].curValor := fltValPar + (fltValTot - (fltValPar * intQtdPar));

  For intIndice := 1 To intQtdPar -1 Do
    arrDigDuplicArray[intIndice].curValor := fltValPar;
end;



{ TArrendondaPrimeiraParcela }

class function TArrendondaPrimeiraParcela.fNew: IArredondaParcela;
begin
  Result := TArrendondaPrimeiraParcela.Create;
end;

procedure TArrendondaPrimeiraParcela.pArredondaParcela(fltValTot: Double;
  intQtdPar: Integer; var arrDigDuplicArray: TArrDigDuplicArray);
  Var
    LSobraDizimas: Real;

    LValorParcela: Double;

    LIndice : Integer;
begin
  LSobraDizimas := (fltValTot / intQtdPar) -
                   fFormataFloat(Trunc(fltValTot / intQtdPar * 100) / 100, 2);

  LValorParcela := fFormataFloat(Trunc(fltValTot / intQtdPar * 100) / 100, 2);
  arrDigDuplicArray[0].curValor := fFormataFloat(LValorParcela + (LSobraDizimas * intQtdPar), 2);

  If (fFormataFloat(arrDigDuplicArray[0].curValor + (LValorParcela * (intQtdPar - 1)), 2) <> fltValTot) Then
    arrDigDuplicArray[0].curValor := LValorParcela + (fltValTot - (arrDigDuplicArray[0].curValor + (LValorParcela * intQtdPar - 1)));

  For LIndice := 1 To intQtdPar -1 Do
    arrDigDuplicArray[LIndice].curValor := LValorParcela;
end;

{ TArrendondaUltimaParcela }

class function TArrendondaUltimaParcela.fNew: IArredondaParcela;
begin
  Result := TArrendondaUltimaParcela.Create;
end;

procedure TArrendondaUltimaParcela.pArredondaParcela(fltValTot: Double;
  intQtdPar: Integer; var arrDigDuplicArray: TArrDigDuplicArray);
  Var
    LSobraDizimas: Real;

    LValorParcela: Double;

    LIndice : Integer;
begin
  LSobraDizimas := (fltValTot / intQtdPar) -
                   fFormataFloat(Trunc(fltValTot / intQtdPar * 100) / 100, 2);

  LValorParcela := fFormataFloat(Trunc(fltValTot / intQtdPar * 100) / 100, 2);
  arrDigDuplicArray[intQtdPar - 1].curValor := fFormataFloat(LValorParcela + (LSobraDizimas * intQtdPar), 2);

  If (fFormataFloat(arrDigDuplicArray[intQtdPar - 1].curValor + (LValorParcela * (intQtdPar - 1)), 2) <> fltValTot) Then
    arrDigDuplicArray[intQtdPar - 1].curValor := LValorParcela + (fltValTot - (arrDigDuplicArray[intQtdPar - 1].curValor + (LValorParcela * intQtdPar - 1)));

  For LIndice := 0 To intQtdPar -2 Do
    arrDigDuplicArray[LIndice].curValor := LValorParcela;
end;

{ TArredondaParCartaoPos }

class function TArredondaParCartaoPos.fArredondamentoParcelas(
  strCodCar: String): IArredondaParcela;
Var
  LNomCar,
  LArrPar: String;
begin
  Result := Nil;

  If (Not fEmptyStr(strCodCar)) Then
  Begin
    LNomCar := fCampoTabela('CAR_DESCAR', 'CADCAR', ['CAR_CODCAR'], [strCodCar]);

    If (AnsiUpperCase(LNomCar).Contains(AnsiUpperCase('Cielo'))) Then
      Result := TArredondaParcelaCielo.fNew();
  End;

  LArrPar := fCampoTabela('CAR_ARRPAR', 'CADCAR', ['CAR_CODCAR'], [strCodCar]);

  If LArrPar = 'P' Then
    Result := TArrendondaPrimeiraParcela.fNew();

  If LArrPar = 'U' Then
    Result := TArrendondaUltimaParcela.fNew();

  If (Result = Nil) Then
    Result := TArredondaParcelaDefault.fNew();
end;

end.

