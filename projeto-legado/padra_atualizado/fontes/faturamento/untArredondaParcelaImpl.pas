unit untArredondaParcelaImpl;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
{$ELSE }
  untFuncoesSimples,
{$ENDIF LINUX}
  System.JSON, strUtils, untTypesSistema;

Type
  TArredondaParcelaDefault = class(TInterfacedObject, IArredondaParcela)
  public
    procedure pArredondaParcela(fltValTot: Double; intQtdPar: Integer; var arrDigDuplicArray: TArrDigDuplicArray);
    class function fNew: IArredondaParcela;
  End;

Type
  TArredondaParcelaRedonda = class(TInterfacedObject, IArredondaParcela)
    procedure pArredondaParcela(fltValTot: Double; intQtdPar: Integer; var arrDigDuplicArray: TArrDigDuplicArray);
    class function fNew: IArredondaParcela;
  End;

Type
  TArredondaParcelaCielo = class(TInterfacedObject, IArredondaParcela)
    procedure pArredondaParcela(fltValTot: Double; intQtdPar: Integer; var arrDigDuplicArray: TArrDigDuplicArray);
    class function fNew: IArredondaParcela;
  End;

  TArredondaParcelaSafraPay = class(TInterfacedObject, IArredondaParcela)
    procedure pArredondaParcela(fltValTot: Double; intQtdPar: Integer; var arrDigDuplicArray: TArrDigDuplicArray);
    class function fNew: IArredondaParcela;
  End;

  TArredondaParcelaPagSeguro = class(TInterfacedObject, IArredondaParcela)
    procedure pArredondaParcela(fltValTot: Double; intQtdPar: Integer; var arrDigDuplicArray: TArrDigDuplicArray);
    class function fNew: IArredondaParcela;
  End;

  TArredondaParcelaRede = class(TInterfacedObject, IArredondaParcela)
    procedure pArredondaParcela(fltValTot: Double; intQtdPar: Integer; var arrDigDuplicArray: TArrDigDuplicArray);
    class function fNew: IArredondaParcela;
  End;

Type
  TArredondaParcelaStone = class(TInterfacedObject, IArredondaParcela)
    procedure pArredondaParcela(fltValTot: Double; intQtdPar: Integer; var arrDigDuplicArray: TArrDigDuplicArray);
    class function fNew: IArredondaParcela;
  End;

Type
  TArredondaParcelaBanriSul = class(TInterfacedObject, IArredondaParcela)
    procedure pArredondaParcela(fltValTot: Double; intQtdPar: Integer; var arrDigDuplicArray: TArrDigDuplicArray);
    class function fNew: IArredondaParcela;
  End;

Type
  TArredondaParcelaPagarMe = class(TInterfacedObject, IArredondaParcela)
    procedure pArredondaParcela(fltValTot: Double; intQtdPar: Integer; var arrDigDuplicArray: TArrDigDuplicArray);
    class function fNew: IArredondaParcela;
  End;

function fArredondamentoParcelas(strCodCar: String): IArredondaParcela;
function fCodigoAdiquirente(const ACodCartao, AOpcaoTef: string): string;

implementation

uses System.AnsiStrings, System.SysUtils, Uni;

const
  ADQ_STONE_CLISITEF = '00265' ;
  ADQ_STONE_NCR = '00135' ;
  ADQ_BANRISUL_NCR = '00099' ;
  ADQ_BANRISUL_CLISITEF = '00021' ;
  ADQ_REDE_CLISITEF = '00005' ;
  ADQ_REDE_NCR = '00103' ;
  ADQ_SAFRAPAY_CLISITEF = '00296' ;
  ADQ_SAFRAPAY_NCR = '00140' ;
  ADQ_PAGSEGURO_CLISITEF = '00302' ;
  ADQ_PAGSEGURO_NCR = '00159' ;

function fRetornaCodigoAdqTef(const AstrCodCar: String): String ;
var
  LstrCodAdq: string;
  LstrTefCit: string;
  LstrCDCRNV: string;
  LCodAdqTEF: string;
begin
  LstrTefCit := fCfgSis('TEFCIT', varString);
  LstrCDCRNV := '' ;
  {$IFDEF LINUX}
    if fCfgSisExist('CDCRNV', VS_strCodEmp) then
      LstrCDCRNV := fCfgSis('CDCRNV', varString);
  {$ELSE }
    LstrCDCRNV := fCfgSis('CDCRNV', varString);
  {$ENDIF LINUX}
  LstrCodAdq := '00000' ;

  if LstrCDCRNV = 'S' then
  begin
    LCodAdqTEF := fCodigoAdiquirente(AstrCodCar, LstrTefCit);
    if not LCodAdqTEF.IsEmpty then
      LStrCodAdq := LCodAdqTEF;
  end
  else
  begin
    if LstrTefCit = OPCAO_CLISITEF then
      LstrCodAdq := fCampoTabela('CAR_TFTRED', 'CADCAR', ['CAR_CODCAR'], [AstrCodCar])
    else if LstrTefCit = OPCAO_NCR then
      LstrCodAdq := fCampoTabela('CAR_TFRED2', 'CADCAR', ['CAR_CODCAR'], [AstrCodCar]);
  end;

  Result := LstrCodAdq ;
end;

function fCodigoAdiquirente(const ACodCartao, AOpcaoTef: string): string;
var
  LqryConsulta: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
  Result := EmptyStr;
  LqryConsulta := fCriaQuery() ;
  try
    LqryConsulta.close;
    LqryConsulta.SQL.Clear;
    LqryConsulta.SQL.Add(' SELECT CDADQC.ADQ_TFTRED, CDADQC.ADQ_TFRED2 ');
    LqryConsulta.SQL.Add(' FROM CDADQC ');
    LqryConsulta.SQL.Add('   INNER JOIN CADCAR ON ');
    LqryConsulta.SQL.Add('   ( CDADQC.ADQ_CODADQ = CADCAR.CAR_CODADQ ) ');
    LqryConsulta.SQL.Add(' WHERE ');
    LqryConsulta.SQL.Add('   CADCAR.CAR_CODCAR = :CAR_CODCAR ');

    LqryConsulta.ParamByName('CAR_CODCAR').AsString := ACodCartao;
    LqryConsulta.Open;

    if LqryConsulta.IsEmpty then
      Exit;

    if AOpcaoTef = OPCAO_CLISITEF then
      Result := LqryConsulta.FieldByName('ADQ_TFTRED').AsString
    else if AOpcaoTef = OPCAO_NCR then
      Result := LqryConsulta.FieldByName('ADQ_TFRED2').AsString;

  finally
    {$IFNDEF LINUX} FreeAndNil(LqryConsulta); {$ENDIF LINUX}
  end;
end;

function fRetornaCodigoAdqRede: String ;
var
  LstrTefCit: String ;
begin
  LstrTefCit := fCfgSis('TEFCIT', varString) ;

  Result := '' ;
  if LstrTefCit = OPCAO_CLISITEF then
    Result := ADQ_REDE_CLISITEF
  else if LstrTefCit = OPCAO_NCR then
    Result := ADQ_REDE_NCR ;
end ;

function fRetornaCodigoAdqSafraPay: String ;
var
  LstrTefCit: String ;
begin
  LstrTefCit := fCfgSis('TEFCIT', varString) ;

  Result := '' ;
  if LstrTefCit = OPCAO_CLISITEF then
    Result := ADQ_SAFRAPAY_CLISITEF
  else if LstrTefCit = OPCAO_NCR then
    Result := ADQ_SAFRAPAY_NCR ;
end ;

function fRetornaCodigoAdqPagSeguro: String ;
var
  LstrTefCit: String ;
begin
  LstrTefCit := fCfgSis('TEFCIT', varString) ;

  Result := '' ;
  if LstrTefCit = OPCAO_CLISITEF then
    Result := ADQ_PAGSEGURO_CLISITEF
  else if LstrTefCit = OPCAO_NCR then
    Result := ADQ_PAGSEGURO_NCR ;
end ;

function fRetornaCodigoAdqBanrisul: String ;
var
  LstrTefCit: String ;
begin
  LstrTefCit := fCfgSis('TEFCIT', varString) ;

  Result := '' ;
  if LstrTefCit = OPCAO_CLISITEF then
    Result := ADQ_BANRISUL_CLISITEF
  else if LstrTefCit = OPCAO_NCR then
    Result := ADQ_BANRISUL_NCR ;
end ;

function fRetornaCodigoAdqStone: String ;
var
  LstrTefCit: String ;
begin
  LstrTefCit := fCfgSis('TEFCIT', varString) ;

  Result := '' ;
  if LstrTefCit = OPCAO_CLISITEF then
    Result := ADQ_STONE_CLISITEF
  else if LstrTefCit = OPCAO_NCR then
    Result := ADQ_STONE_NCR ;
end ;

function fArredondamentoParcelas(strCodCar: String): IArredondaParcela;
  Var
    strNomCar : String;
    strCodAdq : String;
begin
  Result := Nil;
  If (Not fEmptyStr(strCodCar)) Then
  Begin
    strNomCar := fCampoTabela('CAR_DESCAR', 'CADCAR', ['CAR_CODCAR'], [strCodCar]);
    If (AnsiUpperCase(strNomCar).Contains(AnsiUpperCase('Cielo'))) Then
      Result := TArredondaParcelaCielo.fNew();

    if fCfgSis('ARRSTO', varBoolean) then
    begin
      strCodAdq := fRetornaCodigoAdqTef(strCodCar);
      if strCodAdq = fRetornaCodigoAdqStone then
      begin
        Result := TArredondaParcelaStone.fNew();
      end ;
    end ;

    strCodAdq := fRetornaCodigoAdqTef(strCodCar);
    if strCodAdq = fRetornaCodigoAdqBanrisul then
      Result := TArredondaParcelaBanriSul.fNew()
    else if strCodAdq = fRetornaCodigoAdqRede then
      Result := TArredondaParcelaRede.fNew()
    else if strCodAdq = fRetornaCodigoAdqSafraPay then
      Result := TArredondaParcelaSafraPay.fNew()
    else if strCodAdq = fRetornaCodigoAdqPagSeguro then
      Result := TArredondaParcelaPagSeguro.fNew() ;

  End;

  If (Result = Nil) Then
    Result := TArredondaParcelaDefault.fNew();
end;

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

{ TArredondaParcelaRedonda }

class function TArredondaParcelaRedonda.fNew: IArredondaParcela;
begin
  Result := TArredondaParcelaRedonda.Create;
end;

procedure TArredondaParcelaRedonda.pArredondaParcela(fltValTot: Double;
  intQtdPar: Integer; var arrDigDuplicArray: TArrDigDuplicArray);
begin
  pArredondaParcelaRedonda(fltValTot, intQtdPar, arrDigDuplicArray);
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

{ TArredondaParcelaStone }

class function TArredondaParcelaStone.fNew: IArredondaParcela;
begin
  Result := TArredondaParcelaStone.Create;
end;

procedure TArredondaParcelaStone.pArredondaParcela(fltValTot: Double;
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

{ TArredondaParcelaPagarMe }

class function TArredondaParcelaPagarMe.fNew: IArredondaParcela;
begin
  Result := TArredondaParcelaPagarMe.Create;
end;

procedure TArredondaParcelaPagarMe.pArredondaParcela(fltValTot: Double;
  intQtdPar: Integer; var arrDigDuplicArray: TArrDigDuplicArray);
Var
  fltValPar : Double;
  intIndice : Integer;
  fltUltPar : Double;
begin
  fltValPar := fTruncaFloat(fltValTot / intQtdPar, 2);

  If (fltValPar * intQtdPar <> fltValTot) Then
    fltUltPar := fltValPar + (fltValTot - (fltValPar * intQtdPar))
  Else
    fltUltPar := fltValPar;

  For intIndice := 0 To intQtdPar -1 Do
  Begin
    arrDigDuplicArray[intIndice].curValor := fltValPar;

    If intIndice = intQtdPar -1 then
      arrDigDuplicArray[intIndice].curValor := fltUltPar;
  End;
end;


{ TArredondaParcelaBanriSul }

class function TArredondaParcelaBanriSul.fNew: IArredondaParcela;
begin
  Result := TArredondaParcelaBanriSul.Create;
end;

procedure TArredondaParcelaBanriSul.pArredondaParcela(fltValTot: Double;
  intQtdPar: Integer; var arrDigDuplicArray: TArrDigDuplicArray);
Var
  LfltValPar : Double;
  LintIndice : Integer;
  LfltPriPar : Double;
begin
  LfltValPar := fTruncaFloat(fltValTot / intQtdPar, 2);

  If (LfltValPar * intQtdPar <> fltValTot) Then
    LfltPriPar := LfltValPar + (fltValTot - (LfltValPar * intQtdPar))
  Else
    LfltPriPar := LfltValPar;

  For LintIndice := 0 To intQtdPar -1 Do
  Begin
    arrDigDuplicArray[LintIndice].curValor := LfltValPar;

    If LintIndice = 0 then
      arrDigDuplicArray[LintIndice].curValor := LfltPriPar;
  End;
end;

{ TArredondaParcelaRede }

class function TArredondaParcelaRede.fNew: IArredondaParcela;
begin
  Result := TArredondaParcelaRede.Create;
end;

procedure TArredondaParcelaRede.pArredondaParcela(fltValTot: Double;
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

{ TArredondaParcelaSafraPay }

class function TArredondaParcelaSafraPay.fNew: IArredondaParcela;
begin
  Result := TArredondaParcelaSafraPay.Create;
end;

procedure TArredondaParcelaSafraPay.pArredondaParcela(fltValTot: Double;
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

{ TArredondaParcelaPagSeguro }

class function TArredondaParcelaPagSeguro.fNew: IArredondaParcela;
begin
  Result := TArredondaParcelaPagSeguro.Create;
end;

procedure TArredondaParcelaPagSeguro.pArredondaParcela(fltValTot: Double;
  intQtdPar: Integer; var arrDigDuplicArray: TArrDigDuplicArray);
Var
  fltValPar : Double;
  intIndice : Integer;
  fltUltPar : Double;
begin
  fltValPar := fTruncaFloat(fltValTot / intQtdPar, 2);

  If (fltValPar * intQtdPar <> fltValTot) Then
    fltUltPar := fltValPar + (fltValTot - (fltValPar * intQtdPar))
  Else
    fltUltPar := fltValPar;

  For intIndice := 0 To intQtdPar -1 Do
  Begin
    arrDigDuplicArray[intIndice].curValor := fltValPar;

    If intIndice = intQtdPar -1 then
      arrDigDuplicArray[intIndice].curValor := fltUltPar;
  End;
end;

end.
