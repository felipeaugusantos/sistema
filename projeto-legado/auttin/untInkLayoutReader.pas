unit untInkLayoutReader;

interface

uses Classes, SysUtils, Variants, Dialogs,
     untFuncoesSimples;


{*******************************************}
{* LÊ O LAYOUT DE TINTA DE MAQUINA DEFINIDO*}
{****************************************MV*}
Type
  TInkLayoutReader = class(TObject)
    private
      FNomArq   : String;
      FArqTxt   : TextFile;
      dicValores: TDicionario;
      lstValores: TList;
      FPosAtu   : Integer;
      FEof      : Boolean;
    protected
      function GetValor(Index: String): Variant;
      function fLeColunaLinhas(strLinha: String): TDicionario; virtual;

      procedure SetNomArq(const Value: String);
      procedure pLerNovaLinha;
    public

      procedure Next;
      procedure Prior;

      property strNomArq: String Read FNomArq Write SetNomArq;
      property Valor[Index: String]: Variant Read GetValor; default;
      property intPosAtu: Integer Read FPosAtu;
      property Eof: Boolean Read FEof;

      Constructor Create;
      Destructor Destroy; override;

    End;

Type
  TAutomotiveInkLayoutReader = class(TInkLayoutReader)
    protected
      function fLeColunaLinhas(strLinha: String): TDicionario; override;

  End;

Type
  TAutomotiveBaseInkLayoutReader = class(TInkLayoutReader)
    protected
      function fLeColunaLinhas(strLinha: String): TDicionario; override;

  End;

Type
  TBaseInkLayoutReader = class(TInkLayoutReader)
    protected
      function fLeColunaLinhas(strLinha: String): TDicionario; override;

  End;

implementation

{ TInkLayoutReader }

constructor TInkLayoutReader.Create;
begin
  lstValores := TList.Create;
  FNomArq    := '';
  FPosAtu    := -1;
  FEof       := False;
end;

destructor TInkLayoutReader.Destroy;
begin
  CloseFile(FArqTxt);
  lstValores.Destroy;
  inherited Destroy;
end;

function TInkLayoutReader.fLeColunaLinhas(strLinha: String): TDicionario;

  function c(intPos, intTam: Integer): String;
  begin
    Result := Copy(strLinha, intPos, intTam);
  end;

begin
  Result := TDicionario.Create;

  Result['CODFOR'] := Trim(c(001, 050));
  Result['CODPRO'] := Trim(c(051, 020));    
  Result['CODBAS'] := Trim(c(071, 020));
  Result['CHAVE1'] := Trim(c(091, 020));
  Result['SUBCH1'] := Trim(c(111, 020));
  Result['CHAVE2'] := Trim(c(131, 020));
  Result['UNIDAD'] := Trim(c(151, 010));
  Result['EMBALA'] := Trim(c(161, 012));
  Result['DESCRI'] := Trim(c(173, 050));
  Result['COL001'] := Trim(c(223, 010));
  Result['QTD001'] := Trim(c(233, 012));
  Result['COL002'] := Trim(c(245, 010));
  Result['QTD002'] := Trim(c(255, 012));
  Result['COL003'] := Trim(c(267, 010));
  Result['QTD003'] := Trim(c(277, 012));
  Result['COL004'] := Trim(c(289, 010));
  Result['QTD004'] := Trim(c(299, 012));
  Result['COL005'] := Trim(c(311, 010));
  Result['QTD005'] := Trim(c(321, 012));
  Result['COL006'] := Trim(c(333, 010));
  Result['QTD006'] := Trim(c(343, 012));
  Result['COL007'] := Trim(c(355, 010));
  Result['QTD007'] := Trim(c(365, 012));
  Result['COL008'] := Trim(c(377, 010));
  Result['QTD008'] := Trim(c(387, 012));
  Result['COL009'] := Trim(c(399, 010));
  Result['QTD009'] := Trim(c(409, 012));
  Result['COL010'] := Trim(c(421, 010));
  Result['QTD010'] := Trim(c(431, 012));
  Result['COL011'] := Trim(c(443, 010));
  Result['QTD011'] := Trim(c(453, 012));
  Result['COL012'] := Trim(c(465, 010));
  Result['QTD012'] := Trim(c(475, 012));
  Result['COL013'] := Trim(c(487, 010));
  Result['QTD013'] := Trim(c(487, 012));
  Result['COL014'] := Trim(c(509, 010));
  Result['QTD014'] := Trim(c(519, 012));
  Result['COL015'] := Trim(c(531, 010));
  Result['QTD015'] := Trim(c(541, 012));
  Result['COL016'] := Trim(c(553, 010));
  Result['QTD016'] := Trim(c(563, 012));
  Result['COL017'] := Trim(c(575, 010));
  Result['QTD017'] := Trim(c(585, 012));
  Result['COL018'] := Trim(c(597, 010));
  Result['QTD018'] := Trim(c(607, 012));
  Result['COL019'] := Trim(c(619, 010));
  Result['QTD019'] := Trim(c(629, 012));
  Result['COL020'] := Trim(c(631, 010));
  Result['QTD020'] := Trim(c(641, 012));
  Result['PRECUS'] := Trim(c(653, 012));
  Result['PREVEN'] := Trim(c(665, 012));

end;

function TInkLayoutReader.GetValor(Index: String): Variant;
  Var
    varTmp: Variant;
begin
  Index := AnsiUpperCase(Index);
  dicValores := TDicionario(lstValores.Items[FPosAtu]);
  varTmp := dicValores.Retorna(Index);
  If (varTmp = Null) Then
  Begin
    Raise Exception.CreateFmt('Chave %s não encontrada!', [Index]);
  End;

  Result := varTmp
end;

procedure TInkLayoutReader.Next;
begin

  If (FEof) Then
  Begin
    Exit;
  End;

  If (FPosAtu+1 < lstValores.Count-1) Then
  Begin
    Inc(FPosAtu);
    If (System.Eof(FArqTxt)) Then
    Begin
      If (FPosAtu = lstValores.Count-1) Then
        FEof := True;
    End;
  End
  Else
  Begin
    pLerNovaLinha;
  End;

end;

procedure TInkLayoutReader.pLerNovaLinha;
  Var
    strLinha: String;
begin

  FEof := System.Eof(FArqTxt);
  If (FEof) Then
    Exit;

  ReadLn(FArqTxt, strLinha);

  If (fEmptyStr(strLinha)) Then
    FEof := True
  Else
  Begin
    dicValores := fLeColunaLinhas(strLinha);
    lstValores.Add(dicValores);

    Inc(FPosAtu);
  End;

end;

procedure TInkLayoutReader.Prior;
begin
  If (FPosAtu-1 > -1) Then
    Dec(FPosAtu);

  FEof := False;
end;

procedure TInkLayoutReader.SetNomArq(const Value: String);
begin
  If (FNomArq = Value) Then
    Exit;

  If (Not FileExists(Value)) Then
  Begin
    Raise EInOutError.CreateFmt('Arquivo %s nao existe!', [Value]);
  End;

  If (Not fEmptyStr(FNomArq)) Then
  Begin
    CloseFile(FArqTxt);
  End;

  FNomArq := Value;
  AssignFile(FArqTxt, FNomArq);
  Reset(FArqTxt);
  FEof := System.Eof(FArqTxt);
  FPosAtu := -1;
  pLerNovaLinha;
end;

{ TBaseInkLayoutReader }

function TBaseInkLayoutReader.fLeColunaLinhas(
  strLinha: String): TDicionario;

  function c(intPos, intTam: Integer): String;
  begin
    Result := Copy(strLinha, intPos, intTam);
  end;

begin
  Result := TDicionario.Create;

  Result['CODBAS'] := Trim(c(001, 020));
  Result['CHAVE1'] := Trim(c(021, 020));
  Result['SUBCHA'] := Trim(c(041, 020));
  Result['UNIDAD'] := Trim(c(061, 010));
  Result['DESCRI'] := Trim(c(071, 050));
  Result['PRECUS'] := Trim(c(121, 012));
  Result['PREVEN'] := Trim(c(123, 012));
end;

{ TAutomotiveInkLayoutReader }

function TAutomotiveInkLayoutReader.fLeColunaLinhas(
  strLinha: String): TDicionario;

  function c(intPos, intTam: Integer): String;
  begin
    Result := Copy(strLinha, intPos, intTam);
  end;

begin

  Result := TDicionario.Create;

  Result['CHAVE1'] := AnsiUpperCase(Trim(c(001, 050)));
  Result['SUBCHA'] := AnsiUpperCase(Trim(c(051, 050)));
  Result['LINHA_'] := AnsiUpperCase(Trim(c(101, 010)));
  Result['INFCHA'] := AnsiUpperCase(Trim(c(111, 010)));
  Result['DESCRI'] := AnsiUpperCase(Trim(c(121, 050)));
  Result['REFERE'] := AnsiUpperCase(Trim(c(171, 025)));
  Result['UNIDAD'] := AnsiUpperCase(Trim(c(196, 010)));
  Result['CODEMB'] := AnsiUpperCase(Trim(c(206, 010)));
  Result['EMBALA'] := AnsiUpperCase(Trim(c(216, 012)));
  Result['MONTAD'] := AnsiUpperCase(Trim(c(228, 030)));
  Result['ANOINI'] := AnsiUpperCase(Trim(c(258, 004)));
  Result['ANOFIN'] := AnsiUpperCase(Trim(c(262, 004)));
  Result['CONCUS'] := AnsiUpperCase(Trim(c(266, 012)));
  Result['CONVEN'] := AnsiUpperCase(Trim(c(278, 012)));
  Result['DILCUS'] := AnsiUpperCase(Trim(c(290, 012)));
  Result['DILVEN'] := AnsiUpperCase(Trim(c(302, 012)));
  Result['4P1CUS'] := AnsiUpperCase(Trim(c(314, 012)));
  Result['4P1VEN'] := AnsiUpperCase(Trim(c(326, 012)));

  Result['LIN001'] := AnsiUpperCase(Trim(c(338,  010)));
  Result['COL001'] := AnsiUpperCase(Trim(c(348,  010)));
  Result['QCON01'] := AnsiUpperCase(Trim(c(358,  012)));
  Result['QD2101'] := AnsiUpperCase(Trim(c(370,  012)));
  Result['QD4101'] := AnsiUpperCase(Trim(c(382,  012)));

  Result['LIN002'] := AnsiUpperCase(Trim(c(394,  010)));
  Result['COL002'] := AnsiUpperCase(Trim(c(404,  010)));
  Result['QCON02'] := AnsiUpperCase(Trim(c(414,  012)));
  Result['QD2102'] := AnsiUpperCase(Trim(c(426,  012)));
  Result['QD4102'] := AnsiUpperCase(Trim(c(438,  012)));

  Result['LIN003'] := AnsiUpperCase(Trim(c(450,  010)));
  Result['COL003'] := AnsiUpperCase(Trim(c(460,  010)));
  Result['QCON03'] := AnsiUpperCase(Trim(c(470,  012)));
  Result['QD2103'] := AnsiUpperCase(Trim(c(482,  012)));
  Result['QD4103'] := AnsiUpperCase(Trim(c(494,  012)));

  Result['LIN004'] := AnsiUpperCase(Trim(c(506,  010)));
  Result['COL004'] := AnsiUpperCase(Trim(c(516,  010)));
  Result['QCON04'] := AnsiUpperCase(Trim(c(526,  012)));
  Result['QD2104'] := AnsiUpperCase(Trim(c(538,  012)));
  Result['QD4104'] := AnsiUpperCase(Trim(c(550,  012)));

  Result['LIN005'] := AnsiUpperCase(Trim(c(562,  010)));
  Result['COL005'] := AnsiUpperCase(Trim(c(572,  010)));
  Result['QCON05'] := AnsiUpperCase(Trim(c(582,  012)));
  Result['QD2105'] := AnsiUpperCase(Trim(c(594,  012)));
  Result['QD4105'] := AnsiUpperCase(Trim(c(606,  012)));

  Result['LIN006'] := AnsiUpperCase(Trim(c(618,  010)));
  Result['COL006'] := AnsiUpperCase(Trim(c(628,  010)));
  Result['QCON06'] := AnsiUpperCase(Trim(c(638,  012)));
  Result['QD2106'] := AnsiUpperCase(Trim(c(650,  012)));
  Result['QD4106'] := AnsiUpperCase(Trim(c(662,  012)));

  Result['LIN007'] := AnsiUpperCase(Trim(c(674,  010)));
  Result['COL007'] := AnsiUpperCase(Trim(c(684,  010)));
  Result['QCON07'] := AnsiUpperCase(Trim(c(694,  012)));
  Result['QD2107'] := AnsiUpperCase(Trim(c(706,  012)));
  Result['QD4107'] := AnsiUpperCase(Trim(c(718,  012)));

  Result['LIN008'] := AnsiUpperCase(Trim(c(730,  010)));
  Result['COL008'] := AnsiUpperCase(Trim(c(740,  010)));
  Result['QCON08'] := AnsiUpperCase(Trim(c(750,  012)));
  Result['QD2108'] := AnsiUpperCase(Trim(c(762,  012)));
  Result['QD4108'] := AnsiUpperCase(Trim(c(774,  012)));

  Result['LIN009'] := AnsiUpperCase(Trim(c(786,  010)));
  Result['COL009'] := AnsiUpperCase(Trim(c(796,  010)));
  Result['QCON09'] := AnsiUpperCase(Trim(c(806,  012)));
  Result['QD2109'] := AnsiUpperCase(Trim(c(818,  012)));
  Result['QD4109'] := AnsiUpperCase(Trim(c(830,  012)));

  Result['LIN010'] := AnsiUpperCase(Trim(c(842,  010)));
  Result['COL010'] := AnsiUpperCase(Trim(c(852,  010)));
  Result['QCON10'] := AnsiUpperCase(Trim(c(862,  012)));
  Result['QD2110'] := AnsiUpperCase(Trim(c(874,  012)));
  Result['QD4110'] := AnsiUpperCase(Trim(c(886,  012)));

  Result['LIN011'] := AnsiUpperCase(Trim(c(898,  010)));
  Result['COL011'] := AnsiUpperCase(Trim(c(908,  010)));
  Result['QCON11'] := AnsiUpperCase(Trim(c(918,  012)));
  Result['QD2111'] := AnsiUpperCase(Trim(c(930,  012)));
  Result['QD4111'] := AnsiUpperCase(Trim(c(942,  012)));

  Result['LIN012'] := AnsiUpperCase(Trim(c(954,  010)));
  Result['COL012'] := AnsiUpperCase(Trim(c(964,  010)));
  Result['QCON12'] := AnsiUpperCase(Trim(c(974,  012)));
  Result['QD2112'] := AnsiUpperCase(Trim(c(986,  012)));
  Result['QD4112'] := AnsiUpperCase(Trim(c(998,  012)));

  Result['LIN013'] := AnsiUpperCase(Trim(c(1010, 010)));
  Result['COL013'] := AnsiUpperCase(Trim(c(1020, 010)));
  Result['QCON13'] := AnsiUpperCase(Trim(c(1030, 012)));
  Result['QD2113'] := AnsiUpperCase(Trim(c(1042, 012)));
  Result['QD4113'] := AnsiUpperCase(Trim(c(1054, 012)));

  Result['LIN014'] := AnsiUpperCase(Trim(c(1066, 010)));
  Result['COL014'] := AnsiUpperCase(Trim(c(1076, 010)));
  Result['QCON14'] := AnsiUpperCase(Trim(c(1086, 012)));
  Result['QD2114'] := AnsiUpperCase(Trim(c(1098, 012)));
  Result['QD4114'] := AnsiUpperCase(Trim(c(1110, 012)));

  Result['LIN015'] := AnsiUpperCase(Trim(c(1122, 010)));
  Result['COL015'] := AnsiUpperCase(Trim(c(1132, 010)));
  Result['QCON15'] := AnsiUpperCase(Trim(c(1142, 012)));
  Result['QD2115'] := AnsiUpperCase(Trim(c(1154, 012)));
  Result['QD4115'] := AnsiUpperCase(Trim(c(1166, 012)));

  Result['LIN016'] := AnsiUpperCase(Trim(c(1178, 010)));
  Result['COL016'] := AnsiUpperCase(Trim(c(1188, 010)));
  Result['QCON16'] := AnsiUpperCase(Trim(c(1198, 012)));
  Result['QD2116'] := AnsiUpperCase(Trim(c(1210, 012)));
  Result['QD4116'] := AnsiUpperCase(Trim(c(1222, 012)));

  Result['LIN017'] := AnsiUpperCase(Trim(c(1234, 010)));
  Result['COL017'] := AnsiUpperCase(Trim(c(1244, 010)));
  Result['QCON17'] := AnsiUpperCase(Trim(c(1254, 012)));
  Result['QD2117'] := AnsiUpperCase(Trim(c(1266, 012)));
  Result['QD4117'] := AnsiUpperCase(Trim(c(1278, 012)));

  Result['LIN018'] := AnsiUpperCase(Trim(c(1290, 010)));
  Result['COL018'] := AnsiUpperCase(Trim(c(1300, 010)));
  Result['QCON18'] := AnsiUpperCase(Trim(c(1310, 012)));
  Result['QD2118'] := AnsiUpperCase(Trim(c(1322, 012)));
  Result['QD4118'] := AnsiUpperCase(Trim(c(1334, 012)));

  Result['LIN019'] := AnsiUpperCase(Trim(c(1346, 010)));
  Result['COL019'] := AnsiUpperCase(Trim(c(1356, 010)));
  Result['QCON19'] := AnsiUpperCase(Trim(c(1366, 012)));
  Result['QD2119'] := AnsiUpperCase(Trim(c(1378, 012)));
  Result['QD4119'] := AnsiUpperCase(Trim(c(1390, 012)));

  Result['LIN020'] := AnsiUpperCase(Trim(c(1402, 010)));
  Result['COL020'] := AnsiUpperCase(Trim(c(1412, 010)));
  Result['QCON20'] := AnsiUpperCase(Trim(c(1422, 012)));
  Result['QD2120'] := AnsiUpperCase(Trim(c(1434, 012)));
  Result['QD4120'] := AnsiUpperCase(Trim(c(1446, 012)));


end;

{ TAutomotiveBaseInkLayoutReader }

function TAutomotiveBaseInkLayoutReader.fLeColunaLinhas(
  strLinha: String): TDicionario;

  function c(intPos, intTam: Integer): String;
  begin
    Result := Copy(strLinha, intPos, intTam);
  end;

begin
  Result := TDicionario.Create;

  Result['LINHA_'] := Trim(c(001, 010)); // LINHA COLORANTE
  Result['CODCOL'] := Trim(c(011, 010)); // CODIGO COLORANTE
  Result['DESCRI'] := Trim(c(021, 050)); // DESCRICAO COLORANTE
  Result['PESESP'] := Trim(c(071, 012)); // PESO ESPECÍFICO
  Result['PRECUS'] := Trim(c(083, 012)); // PREÇO DE CUSTO
  Result['PREVEN'] := Trim(c(095, 012)); // PREÇO DE VENDA
  Result['EMBALA'] := Trim(c(107, 012)); // EMBALAGEM
end;

end.




 

 
 
 
 
 

 
 
 
 
 

 
 
 
 
 

 
 
 
 
 

 
 
 
 
 

 
 
 
 
 

 
 
 
 
 

 
 
 
 
 

 
 
 
 
 

 
 
 
 
 

 
 
 
 
 

 
 
 
 
 

 
 
 
 
 

 
 
 
 
 

 
 
 
 
 

 
 
 
 
 

 
 
 
 
 

 
 
 
 
 

 
 
 
 
 

 
 
 
 
 
