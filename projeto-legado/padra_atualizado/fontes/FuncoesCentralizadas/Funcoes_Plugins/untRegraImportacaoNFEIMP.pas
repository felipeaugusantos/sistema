unit untRegraImportacaoNFEIMP;

interface

Uses
  Uni, System.SysUtils, Data.DB, System.StrUtils, System.Classes;

Type

  IRegraImportacaoNFEIMP = interface
  ['{80CD19BF-38C4-4A8D-ABA7-7A1F3B8B0196}']

    function setQryAux(AValue : TUniQuery) : IRegraImportacaoNFEIMP;

    function setNumDoc(const AValue : String) : IRegraImportacaoNFEIMP;
    function setEspDoc(const AValue : String) : IRegraImportacaoNFEIMP;
    function setCodEmp(const AValue : String) : IRegraImportacaoNFEIMP;
    function setMktPlc(const AValue : String) : IRegraImportacaoNFEIMP;
    function setClaFis(const AValue : String) : IRegraImportacaoNFEIMP;
    function setNatOpe(const AValue : String) : IRegraImportacaoNFEIMP;
    function setInfAdi(const AValue : String) : IRegraImportacaoNFEIMP;
    function setXpedCompra(const AValue : String) : IRegraImportacaoNFEIMP;

    function fRetRegraLiberaImportacaoDev : String;

  end;

 TRegraImportacaoNFEIMP = class(TInterfacedObject, IRegraImportacaoNFEIMP)
 const
   SQL_VEN = 'SELECT                  ' +
             '  GER_CLAFIS AS CLAFIS, ' +
             '  AUX_NATCFO AS NATCFO  ' +
             'FROM          ' +
             '  MOVGER      ' +
             '  INNER JOIN AUXMOV ON (AUXMOV.AUX_SEQGER = MOVGER.AUTOINCREM) ' +
             'WHERE                      ' +
             '  GER_NUMDOC = :NUMDOC AND ' +
             '  GER_ESPDOC = :ESPDOC AND ' +
             '  GER_CODEMP = :CODEMP ';

   SQL_LIB = 'SELECT                  ' +
             '  A.LIB_CLAFIS AS CLAFIS, ' +
             '  A.LIB_NATCFO AS NATCFO, ' +
             '  A.LIB_DESCRI AS DESCRI, ' +
             '  A.LIB_TIPMOV AS TIPMOV, ' +
             '  CASE                                     '+
             '     WHEN EXISTS (                         '+
             '         SELECT B.LIB_CLAFIS               '+
             '         FROM LIBDEV AS B                  '+
             '         WHERE B.LIB_CLAFIS = A.LIB_CLAFIS '+
             '           AND B.LIB_DESCRI = A.LIB_DESCRI '+
             '           AND B.LIB_INFADI = ""           '+
             '     ) THEN ""                             '+
             '     ELSE GROUP_CONCAT(LIB_INFADI SEPARATOR ",") '+
             '  END AS INFADI '+
             'FROM     ' +
             '  LIBDEV A ' +
             'WHERE    ' +
             '  A.LIB_HUBMKP = :HUBMKP AND '+
             '  A.LIB_CODEMP = :CODEMP     '+
             'GROUP BY CLAFIS, DESCRI      ';

   SQL_CFG = 'SELECT        ' +
             '  SIS_VALCFG  ' +
             'FROM          ' +
             '  FULL_CFGSIS ' +
             'WHERE         ' +
             '  SIS_CODCFG = :CODCFG AND ' +
             '  SIS_CODEMP = :CODEMP AND ' +
             '  SIS_HUBMKP = :HUBMKP     ';

 private
   FQryAux : TUniQuery;
   FNumDoc : String;
   FEspDoc : String;
   FCodEmp : String;
   FMktPlc : String;
   FClaFis : String;
   FNatOpe : String;
   FInfAdi : String;
   FXpedCompra : String;
   function fCfgSisFull(ACodCFG : String) : String;
   function fTiraCaracEspeciais(strTexto       : String;
                                blnUsaLista    : Boolean = True;
                                blnTiraEspacos : Boolean = False;
                                blnTiraPontos  : Boolean = False;
                                blnTiraDoisPts : Boolean = False;
                                blnTiraTab     : Boolean = False;
                                blnTiraVirgula : Boolean = True) : String;
    function ContemTravaInfAdi(strInfAdi, strTravas: String): Boolean;
    function ContemTravaTipMov(strTipMov, strTravas: String): Boolean;
 public

   class function New : IRegraImportacaoNFEIMP;

   constructor Create;
   destructor Destroy; Override;

   function setQryAux(AValue : TUniQuery) : IRegraImportacaoNFEIMP;

   function setNumDoc(const AValue : String) : IRegraImportacaoNFEIMP;
   function setEspDoc(const AValue : String) : IRegraImportacaoNFEIMP;
   function setCodEmp(const AValue : String) : IRegraImportacaoNFEIMP;
   function setMktPlc(const AValue : String) : IRegraImportacaoNFEIMP;
   function setClaFis(const AValue : String) : IRegraImportacaoNFEIMP;
   function setNatOpe(const AValue : String) : IRegraImportacaoNFEIMP;
   function setInfAdi(const AValue : String) : IRegraImportacaoNFEIMP;
   function setXpedCompra(const AValue : String) : IRegraImportacaoNFEIMP;

   function fRetRegraLiberaImportacaoDev : String;

 end;

implementation

{ TRegraImportacaoNFEIMP }

constructor TRegraImportacaoNFEIMP.Create;
begin
  FQryAux := Nil;
  FNumDoc := '';
  FEspDoc := '';
  FCodEmp := '';
  FMktPlc := '';
  FClaFis := '';
  FNatOpe := '';
  FInfAdi := '';
  FXpedCompra := '';
end;

destructor TRegraImportacaoNFEIMP.Destroy;
begin
  If Assigned(FQryAux) Then
    FreeAndNil(FQryAux);
end;

function TRegraImportacaoNFEIMP.fCfgSisFull(ACodCFG: String): String;
begin

  Result := '';

  FQryAux.Close;
  FQryAux.SQL.Clear;
  FQryAux.SQL.Add(SQL_CFG);
  FQryAux.ParamByName('CODCFG').AsString := ACodCFG;
  FQryAux.ParamByName('CODEMP').AsString := FCodEmp;
  FQryAux.ParamByName('HUBMKP').AsString := FMktPlc;
  FQryAux.Open;

  If Not FQryAux.IsEmpty Then
    Result := FQryAux.FieldByName('SIS_VALCFG').AsString;

end;

function TRegraImportacaoNFEIMP.ContemTravaInfAdi(strInfAdi: String; strTravas: String): Boolean;
  Var
    stlTravas : TStringList;
    intContador : Integer;
begin
  Result := False;

  stlTravas := TStringList.Create;
  Try
    stlTravas.Delimiter := ',';
    stlTravas.DelimitedText := strTravas;

    For intContador := 0 To Pred(stlTravas.Count) Do
    Begin
      If strInfAdi.Contains(stlTravas[intContador]) Then
      Begin
        Result := True;
        Break;
      End;
    End;
  Finally
    FreeAndNil(stlTravas);
  End;
end;

function TRegraImportacaoNFEIMP.ContemTravaTipMov(strTipMov, strTravas: String): Boolean;
  Var
    arrTipMov: TArray<String>;
    LTipMov: String;
begin
  Result := False;

  If strTipMov.IsEmpty Then
    Exit;

  arrTipMov := strTravas.Split([','], TStringSplitOptions.ExcludeEmpty);

  For LTipMov In arrTipMov Do
  Begin
    If Pos(LTipMov, strTipMov.Trim) = 1 Then
      Exit(True);
  End;
end;

function TRegraImportacaoNFEIMP.fRetRegraLiberaImportacaoDev: String;
  var
    LClaFis : String;
    LNatCfo : String;
    LLibDev : String;
    LValRet : Integer;
begin

  Result  := 'S';
  LLibDev := fCfgSisFull('CFG_LIBDEV');

  If TryStrToInt(LLibDev, LValRet) And (LValRet > 0) Then
  Begin

    LClaFis := FClaFis;
    LNatCfo := FNatOpe;

    If Not FNumDoc.IsEmpty Then
    Begin
      FQryAux.Close;
      FQryAux.SQL.Clear;
      FQryAux.SQL.Add(SQL_VEN);
      FQryAux.ParamByName('NUMDOC').AsString := FNumDoc;
      FQryAux.ParamByName('ESPDOC').AsString := FEspDoc;
      FQryAux.ParamByName('CODEMP').AsString := FCodEmp;
      FQryAux.Open;
      LClaFis := FQryAux.FieldByName('CLAFIS').AsString;
      LNatCfo := FQryAux.FieldByName('NATCFO').AsString;
    End;

    FQryAux.Close;
    FQryAux.SQL.Clear;
    FQryAux.SQL.Add(SQL_LIB);
    FQryAux.ParamByName('HUBMKP').AsString := FMktPlc;
    FQryAux.ParamByName('CODEMP').AsString := FCodEmp;
    FQryAux.Open;

    FQryAux.First;
    While Not FQryAux.Eof Do
    Begin
      If Not FNumDoc.IsEmpty Then
      Begin
        If LClaFis.Equals(FQryAux.FieldByName('CLAFIS').AsString) And
           LNatCfo.Equals(FQryAux.FieldByName('NATCFO').AsString) Then
        Begin
          Exit('N');
        End;
      End
      Else
      Begin
        If LClaFis.Equals(FQryAux.FieldByName('CLAFIS').AsString) And
           AnsiUpperCase(fTiraCaracEspeciais(LNatCfo)).Equals(AnsiUpperCase(fTiraCaracEspeciais(FQryAux.FieldByName('DESCRI').AsString))) Then
        Begin
          If (Not FQryAux.FieldByName('INFADI').AsString.IsEmpty) Then
          Begin
            If (Not ContemTravaInfAdi(AnsiUpperCase(fTiraCaracEspeciais(FInfAdi, False)),
                                      AnsiUpperCase(fTiraCaracEspeciais(FQryAux.FieldByName('INFADI').AsString, True, True, True, True, True, False)))) Then
              Exit('S');
          End;

          If (Not FQryAux.FieldByName('TIPMOV').AsString.IsEmpty) Then
          Begin
            If (Not ContemTravaTipMov(FXpedCompra, FQryAux.FieldByName('TIPMOV').AsString)) Then
              Exit('S');
          End;

          Exit('N');
        End;
      End;

      FQryAux.Next;

    End;

  End;

end;

function TRegraImportacaoNFEIMP.fTiraCaracEspeciais(strTexto: String;
                                                    blnUsaLista,
                                                    blnTiraEspacos,
                                                    blnTiraPontos,
                                                    blnTiraDoisPts,
                                                    blnTiraTab,
                                                    blnTiraVirgula: Boolean): String;
  Var
    strLista     : String;
    intContador  : Integer;
    intPosicao   : Integer;
    strCaracNorm : String;
    strCaracEsp  : String;
begin

  If blnUsaLista Then
    strLista := '/\-_+#,;<>|*ªº°&"''()%$¨@!?§={}[]´`^~¹²³£¢'
  Else
    strLista := EmptyStr;

  If (blnTiraEspacos) Then
    strLista := strLista + ' ';

  If (blnTiraPontos) Then
    strLista := strLista + '.';

  If (blnTiraDoisPts) Then
    strLista := strLista + ':';

  If (blnTiraTab) Then
    strLista := strLista + #9;

  If (Not blnTiraVirgula) Then
    strLista := AnsiReplaceStr(strLista, ',', '');

  strCaracNorm := 'aeiouaeiouaeiouaoaeioucAEIOUAEIOUAEIOUAOAEIOUC';
  strCaracEsp  := 'àèìòùáéíóúâêîôûãõäëïöüçÀÈÌÒÙÁÉÍÓÚÂÊÎÔÛÃÕÄËÏÖÜÇ';

  Result := '';
  For intContador := 1 To Length(strTexto) Do
  Begin
    intPosicao := Pos(strTexto[intContador], strCaracEsp);
    If intPosicao > 0 Then
      Result := Result + strCaracNorm[intPosicao]

    Else If Pos(strTexto[intContador], strLista) <= 0 Then
      Result := Result + strTexto[intContador];

  End;

end;

class function TRegraImportacaoNFEIMP.New: IRegraImportacaoNFEIMP;
begin
  Result := TRegraImportacaoNFEIMP.Create();
end;

function TRegraImportacaoNFEIMP.setClaFis(const AValue: String): IRegraImportacaoNFEIMP;
begin
  FClaFis := AValue;
  Result := Self;
end;

function TRegraImportacaoNFEIMP.setCodEmp(const AValue: String): IRegraImportacaoNFEIMP;
begin
  FCodEmp := AValue;
  Result := Self;
end;

function TRegraImportacaoNFEIMP.setEspDoc(const AValue: String): IRegraImportacaoNFEIMP;
begin
  FEspDoc := AValue;
  Result := Self;
end;

function TRegraImportacaoNFEIMP.setMktPlc(const AValue: String): IRegraImportacaoNFEIMP;
begin
  FMktPlc := AValue;
  Result := Self;
end;

function TRegraImportacaoNFEIMP.setNatOpe(const AValue: String): IRegraImportacaoNFEIMP;
begin
  FNatOpe := AValue;
  Result := Self;
end;

function TRegraImportacaoNFEIMP.setInfAdi(const AValue: String): IRegraImportacaoNFEIMP;
begin
  FInfAdi := AValue;
  Result := Self;
end;

function TRegraImportacaoNFEIMP.setNumDoc(const AValue: String): IRegraImportacaoNFEIMP;
begin
  FNumDoc := AValue;
  Result := Self;
end;

function TRegraImportacaoNFEIMP.setQryAux(AValue: TUniQuery): IRegraImportacaoNFEIMP;
begin
  FQryAux := AValue;
  Result := Self;
end;

function TRegraImportacaoNFEIMP.setXpedCompra(const AValue: String): IRegraImportacaoNFEIMP;
begin
  FXpedCompra := AValue;
  Result := Self;
end;

end.
