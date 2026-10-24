unit untReciboImpFiscal;

interface

uses Classes,
     SysUtils,
     Uni,
     StrUtils,
     untImpGerencial,
     untFuncoesSimples;

type
  TReciboImpFiscal = class(TComponent)
    private
      FNumDup: String;
      FEspDoc: String;
      FCodCli: String;
      FCodEmp: String;      
      FNomCli: String;
      FTotDup: Double;
      FTotRec: Double;
      FNomVen: String;
      FDtaCom: String;
      FTemDup: Boolean;
      FDuplic: TArrDuplicatas;
      FImpGerencial: TImprimeGerencial;

      function fGetSqlDuplicatas: string;

      procedure pCarregaDadosDuplicatas;
      procedure pCarregaDuplicatas(var arrDuplic: TArrDuplicatas; qryDuplic: TUniQuery);
    public
      constructor Create(AOwner: TComponent; strNumDup, strEspDoc, strCodEmp, strCodCli: String); reintroduce;
      destructor Destroy; override;

      function fImprimirRecibo(): Boolean;

      property fltTotDup: Double Read FTotDup;
      property fltTotRec: Double Read FTotRec;            
    end;

Const
  INT_CARAC_NOR = 48;
  INT_CARAC_EXP = 24;

implementation

uses untFiscal, Data.DB;

{ TReciboImpFiscal }

constructor TReciboImpFiscal.Create(AOwner: TComponent;
  strNumDup, strEspDoc, strCodEmp, strCodCli: String);
begin
  FNumDup := strNumDup;
  FEspDoc := strEspDoc;
  FCodCli := strCodCli;
  FCodEmp := strCodEmp;

  pCarregaDadosDuplicatas;

  FImpGerencial := TImprimeGerencial.Create(Self);
end;

procedure TReciboImpFiscal.pCarregaDadosDuplicatas;
  var
    qryGen: TUniQuery;
    intAux: Integer;
begin
  qryGen := fCriaQuery(Self);

  With qryGen, SQL Do
  Begin
    Add(fGetSqlDuplicatas);
    Open;

    FTemDup := Not IsEmpty;

    If FTemDup Then
    Begin
      FCodCli := FieldByName('CODCLI').AsString;
      FNomCli := FieldByName('NOMCLI').AsString;

      FDtaCom := FormatDateTime('dd/MM/yyyy', FieldByName('DTACAD').AsDateTime);

      FNomVen := fRetNomVendRep(fRetornaInformacaoVenda(FNumDup, FEspDoc, FCodEmp, 'CODVEN'));

      FTotDup := 0;
      FTotRec := 0;

      pCarregaDuplicatas(FDuplic, qryGen);

      For intAux := 0 To Length(FDuplic) -1 Do
      Begin
        FTotDup := FTotDup + fStrToFloat(FDuplic[intAux].strValDup);
        FTotRec := FTotRec + fStrToFloat(FDuplic[intAux].strValRec);        
      End;

    End;
  End;

  FreeAndNil(qryGen);
end;

procedure TReciboImpFiscal.pCarregaDuplicatas(var arrDuplic: TArrDuplicatas; qryDuplic: TUniQuery);
begin
  With qryDuplic Do
  Begin
    First;

    SetLength(arrDuplic, RecordCount);

    While Not Eof Do
    Begin
      arrDuplic[RecNo -1].strSequen := fStrZero(IntToStr(RecNo), 3);

      arrDuplic[RecNo -1].strNumDup := FieldByName('NUMDUP').AsString;
      arrDuplic[RecNo -1].strEspDoc := FieldByName('ESPDOC').AsString;
      arrDuplic[RecNo -1].strParcel := FieldByName('PARCEL').AsString;

      arrDuplic[RecNo -1].strDtaVen := FormatDateTime('dd/MM/yy', FieldByName('DTAVEN').AsDateTime);
      arrDuplic[RecNo -1].strValDup := FloatToStrF(FieldByName('VALDUP').AsFloat, ffNumber, 12, 2);

      arrDuplic[RecNo -1].strDtaRec := '';
      arrDuplic[RecNo -1].strValRec := '';

      If Not FieldByName('DTAREC').IsNull Then
      Begin
        arrDuplic[RecNo -1].strDtaRec := FormatDateTime('dd/MM/yy', FieldByName('DTAREC').AsDateTime);
        arrDuplic[RecNo -1].strValRec := FloatToStrF(FieldByName('VALREC').AsFloat, ffNumber, 12, 2);
      End;

      Next;
    End;
  End;

end;

destructor TReciboImpFiscal.Destroy;
begin
  If Assigned(FImpGerencial) Then
    FreeAndNil(FImpGerencial);
  inherited;
end;

function TReciboImpFiscal.fGetSqlDuplicatas: string;
begin
  Result := '';
  Result := Result + ' SELECT ';
  Result := Result + '   CTR_NUMDUP AS NUMDUP, ';
  Result := Result + '   CTR_ESPDOC AS ESPDOC, ';
  Result := Result + '   CTR_PARCEL AS PARCEL, ';
  Result := Result + '   CLI_CODCLI AS CODCLI, ';
  Result := Result + '   CLI_NOMCLI AS NOMCLI, ';
  Result := Result + '   CLI_LIMCRE AS LIMCRE, ';
  Result := Result + '   CTR_DTACAD AS DTACAD, ';
  Result := Result + '   CTR_DTAVEN AS DTAVEN, ';
  Result := Result + '   IF(CTR_DTAREC IS NULL, CTR_VALDUP, CTR_VALORI) AS VALDUP, ';
  Result := Result + '   CTR_DTAREC AS DTAREC, ';
  Result := Result + '   CTR_VALREC AS VALREC  ';
  Result := Result + ' FROM ';
  Result := Result + '   CADREC ';
  Result := Result + '   INNER JOIN CADCLI ON CTR_CODCLI = CLI_CODCLI ';
  Result := Result + ' WHERE ';
  Result := Result + '   CTR_NUMDUP = ' + QuotedStr(FNumDup) + ' AND ';
  Result := Result + '   CTR_ESPDOC = ' + QuotedStr(FEspDoc) + ' AND ';
  Result := Result + '   CTR_CODCLI = ' + QuotedStr(FCodCli) + ' AND ';
  Result := Result + '   CTR_CODEMP = ' + QuotedStr(FCodEmp);

  Result := Result + ' UNION ALL ';

  Result := Result + ' SELECT ';
  Result := Result + '   ADT_NUMDOC AS NUMDUP, ';
  Result := Result + '   ADT_ESPDOC AS ESPDOC, ';
  Result := Result + '   "A"        AS PARCEL, ';
  Result := Result + '   CLI_CODCLI AS CODCLI, ';
  Result := Result + '   CLI_NOMCLI AS NOMCLI, ';
  Result := Result + '   CLI_LIMCRE AS LIMCRE, ';
  Result := Result + '   ADT_DTALAN AS DTACAD, ';
  Result := Result + '   ADT_DTALAN AS DTAVEN, ';
  Result := Result + '   ADT_VALLAN AS VALDUP, ';
  Result := Result + '   ADT_DTALAN AS DTAREC, ';
  Result := Result + '   ADT_VALLAN AS VALREC  ';
  Result := Result + ' FROM ';
  Result := Result + '   ADTCLI ';
  Result := Result + '   INNER JOIN CADCLI ON ADT_CODCLI = CLI_CODCLI ';
  Result := Result + ' WHERE ';
  Result := Result + '   ADT_NUMDOC = ' + QuotedStr(FNumDup) + ' AND ';
  Result := Result + '   ADT_ESPDOC = ' + QuotedStr(FEspDoc) + ' AND ';
  Result := Result + '   ADT_CODCLI = ' + QuotedStr(FCodCli) + ' AND ';
  Result := Result + '   ADT_CODEMP = ' + QuotedStr(FCodEmp);

  Result := Result + ' ORDER BY ';
  Result := Result + '   DTAVEN ';
end;

function TReciboImpFiscal.fImprimirRecibo: Boolean;
  Var
    stlImpressao: TStringList;
    intDuplicata: Integer;
    blnExpandido: Boolean;

  procedure pAddLinha(strTexto: String; blnCentralizar: Boolean = False);
  begin
    If blnExpandido Then
      stlImpressao.Add(strTexto)
    Else If blnCentralizar Then
      stlImpressao.Add(fPadC(strTexto, INT_CARAC_NOR))
    Else
      stlImpressao.Add(fPadR(strTexto, INT_CARAC_NOR));
  end;

begin
  Result := False;

  If Not FImpGerencial.blnPodeImprimir Then
    Exit;

  stlImpressao := TStringList.Create;

  With FImpGerencial Do
  Begin

    blnExpandido := Not SameText(EmptyStr, fFormatarTextoImp(EmptyStr, [fiExpandido]));

    If FTemDup Then
    Begin
      pAddLinha(fReplicatorStr('-', INT_CARAC_NOR));

      pAddLinha(fFormatarTextoImp(fPadC('DUPLICATA', INT_CARAC_EXP), [fiNegrito, fiExpandido]), True);

      pAddLinha(fReplicatorStr('-', INT_CARAC_NOR));

      pAddLinha('Documento...: ' + fFormatarTextoImp(FDuplic[0].strNumDup + '-' + FDuplic[0].strEspDoc, [fiNegrito, fiExpandido]));

      pAddLinha(fReplicatorStr('-', INT_CARAC_NOR));

      pAddLinha('Cliente.....: ' + fPadR(FCodCli + '-' + FNomCli, INT_CARAC_NOR - 14));
      pAddLinha('Vendedor....: ' + fPadR(FNomVen, INT_CARAC_NOR - 14));
      pAddLinha('Valor Compra: ' + fPadL(FloatToStrF(FTotDup, ffNumber, 12, 2), INT_CARAC_NOR - 14));
      pAddLinha('Valor Pago..: ' + fPadL(FloatToStrF(FTotRec, ffNumber, 12, 2), INT_CARAC_NOR - 14));

      pAddLinha(fReplicatorStr('-', INT_CARAC_NOR));

      pAddLinha(fFormatarTextoImp(fPadC('DEMONSTRATIVO',  INT_CARAC_EXP), [fiNegrito, fiExpandido]), True);

      pAddLinha(fReplicatorStr('-', INT_CARAC_NOR));

      pAddLinha('Par Vencimento    Parcela Dt.Pagto   Vr.Pagto');

      For intDuplicata := 0 To Length(FDuplic) -1 Do
      Begin
        pAddLinha(fPadR(FDuplic[intDuplicata].strSequen, 03) + ' ' +
                  fPadC(FDuplic[intDuplicata].strDtaVen, 10) + ' ' +
                  fPadL(FDuplic[intDuplicata].strValDup, 10) + ' ' +
                  fPadC(FDuplic[intDuplicata].strDtaRec, 08) + ' ' +
                  fPadL(FDuplic[intDuplicata].strValRec, 10));
      End;

      pAddLinha(fReplicatorStr(' ', INT_CARAC_NOR));
      pAddLinha(fReplicatorStr('-', INT_CARAC_NOR));

      If fAbreRelatorioGerencial Then
      Begin
        Result := True;

        For intDuplicata := 0 To stlImpressao.Count -1 Do
          Result := Result And fRelatorioGerencial(stlImpressao[intDuplicata]);

        fFechaRelatorioGerencial(True);
      End;

    End;
  End;

  FreeAndNil(stlImpressao);
end;

end.
