unit untSherwinWhilliams;

interface

uses SysUtils, Uni, Variants, Forms;

Type

  TColShe = Record
    strCodCol: String;
    fltQtdCol: Double;

  End;

Type
  TColSheArray = Array Of TColShe;



  procedure pGerarBases(strNomArq: String);

  function fGravaCadShe(qryCadBas, qryCadShe, qryCadCol: TUniQuery;
    arrColorantes: TColSheArray; strKey2, strCodBas,
    strProKey, strSubKey, strUnidad: String; fltEmbala: Double;
    strDesBas, strCodCor: String; blnDelExi: Boolean;
    Var intCodSeq: Integer): Boolean;

  function fGravaNovasFormulas(qryCadNfm: TUniQuery): Boolean;
  function fRetProxCodSeq: Integer;

implementation

uses untFuncoes, DB, untInkLayoutReader,
  untModuloTinta, untFuncoesSimples;

function fGravaCadShe(qryCadBas, qryCadShe, qryCadCol: TUniQuery;
  arrColorantes: TColSheArray; strKey2, strCodBas,
  strProKey, strSubKey, strUnidad: String; fltEmbala: Double;
  strDesBas, strCodCor: String; blnDelExi: Boolean;
  Var intCodSeq: Integer): Boolean;
  Var
    fltCusCol: Double;
    fltVenCol: Double;
    intContador: Integer;
    strSQL: String;

begin

  fltCusCol := 0.0;
  fltVenCol := 0.0;

  Result := True;

  qryCadBas.First;
  If (Not qryCadBas.Locate('BAS_BASE__;BAS_PROKEY;BAS_SUBKEY;BAS_UNIDAD',
                           VarArrayOf([strCodBas, strProKey, strSubKey, strUnidad]), [])) Then
  Begin
    Result := False;
    Exit;
  End;

  If (blnDelExi) Then
  Begin
    strSQL := '';
    strSQL := strSQL + 'DELETE FROM SHE_CADSHE WHERE ';
    strSQL := strSQL + 'SHE_CODIGO = :CODPRO ';
    With frmModuloTinta.qryGen001 Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODPRO').AsString := strCodCor;
      ExecSQL;
      Close;
    End;

  End;


    For intContador := Low(arrColorantes) To High(arrColorantes) Do
    Begin
      qryCadCol.First;
      qryCadCol.Locate('COL_CODCOL', arrColorantes[intContador].strCodCol, []);
      fltCusCol := fltCusCol + (arrColorantes[intContador].fltQtdCol * 0.924) * (qryCadCol.FieldByName('ITE_PRECUS').AsFloat / 1000);
      fltVenCol := fltVenCol + (arrColorantes[intContador].fltQtdCol * 0.924) * (qryCadCol.FieldByName('ITE_PREVEN').AsFloat / 1000);
    End;

    qryCadShe.Append;
    qryCadShe.FieldByName('SHE_CODSEQ').AsString := fStrZero(fRetProxCodSeq, 6);
    qryCadShe.FieldByName('SHE_DESCRI').AsString := strDesBas;
    qryCadShe.FieldByName('SHE_CODIGO').AsString := strCodCor;
    qryCadShe.FieldByName('SHE_CODIG2').AsString := strKey2;
    qryCadShe.FieldByName('SHE_UNIDAD').AsString := strUnidad;
    qryCadShe.FieldByName('SHE_PRECUS').AsFloat  := fltCusCol + qryCadBas.FieldByName('ITE_PRECUS').AsFloat;
    qryCadShe.FieldByName('SHE_PREVEN').AsFloat  := fltVenCol + qryCadBas.FieldByName('ITE_PREVEN').AsFloat;
    qryCadShe.FieldByName('SHE_COLCUS').AsFloat  := fltCusCol;
    qryCadShe.FieldByName('SHE_COLVEN').AsFloat  := fltVenCol;
    qryCadShe.FieldByName('SHE_CODITE').AsString := qryCadBas.FieldByName('BAS_CODITE').AsString;
    qryCadShe.FieldByName('SHE_CODEMP').AsString := VS_strCodEmp;
    qryCadShe.FieldByName('SHE_BASE__').AsString := strCodBas;
    qryCadShe.FieldByName('SHE_PROKEY').AsString := strProKey;
    qryCadShe.FieldByName('SHE_SUBKEY').AsString := strSubKey;

    For intContador := Low(arrColorantes) To High(arrColorantes) Do
    Begin
      If fEmptyStr(arrColorantes[intContador].strCodCol) Then
        Break;

      qryCadShe.FieldByName('SHE_FORM' + fStrZero(intContador + 1, 2)).AsString := arrColorantes[intContador].strCodCol;
      qryCadShe.FieldByName('SHE_QTDB' + fStrZero(intContador + 1, 2)).AsFloat := arrColorantes[intContador].fltQtdCol;
    End;

    qryCadShe.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('SHE_CADSHE', VS_strCodEmp);

    qryCadShe.Post;

    Inc(intCodSeq);

end;



procedure pGerarBases(strNomArq: String);
  Var
    ilrBases: TBaseInkLayoutReader;
    qryCadBas: TUniQuery;
    intCodSeq: Integer;
begin

  ilrBases := TBaseInkLayoutReader.Create;
  ilrBases.strNomArq := strNomArq;

  pZapTable('SHE_CADBAS');

  qryCadBas := fCriaQuery;
  qryCadBas.SQL.Add('SELECT * FROM SHE_CADBAS');
  qryCadBas.Open;

  intCodSeq := 1;

  While (Not ilrBases.Eof) Do
  Begin

    qryCadBas.Append;
    qryCadBas.FieldByName('BAS_BASE__').AsString := ilrBases['CODBAS'];
    qryCadBas.FieldByName('BAS_PROKEY').AsString := ilrBases['CHAVE1'];
    qryCadBas.FieldByName('BAS_SUBKEY').AsString := ilrBases['SUBCHA'];
    qryCadBas.FieldByName('BAS_UNIDAD').AsString := ilrBases['UNIDAD'];
    qryCadBas.FieldByName('BAS_DESCRI').AsString := ilrBases['DESCRI'];
    qryCadBas.FieldByName('BAS_PRECUS').AsFloat  := ilrBases['PRECUS'];
    qryCadBas.FieldByName('BAS_PREVEN').AsFloat  := ilrBases['PREVEN'];
    qryCadBas.FieldByName('BAS_MARGEM').AsFloat  := fCalculaPrecoVenda(2,
                                                                       qryCadBas.FieldByName('BAS_PRECUS').AsFloat,
                                                                       qryCadBas.FieldByName('BAS_PREVEN').AsFloat,
                                                                       0.0,
                                                                       0.0,
                                                                       0.0,
                                                                       0.0,
                                                                       0.0);
    qryCadBas.FieldByName('BAS_CODITE').Value    := Null;
    qryCadBas.FieldByName('BAS_CODEMP').AsString := VS_strCodEmp;
    qryCadBas.FieldByName('AUTOINCREM').AsString := fFormataAutInc(intCodSeq, VS_strCodEmp);
    qryCadBas.Post;

    Inc(intCodSeq);
    ilrBases.Next;
  End;

  qryCadBas.Close;

  FreeAndNil(qryCadBas);
  FreeAndNil(ilrBases);

end;

function fGravaNovasFormulas(qryCadNfm: TUniQuery): Boolean;
  Var
    arrColorantes: TColSheArray;
    intContador: Integer;
    strCodCol: String;
    fltQtdCol: Double;
    intCodSeq: Integer;
    qryCadBas: TUniQuery;
    qryCadCol: TUniQuery;
    qryCadShe: TUniQuery;
begin

  qryCadBas := fCriaQuery;
  qryCadCol := fCriaQuery;
  qryCadShe := fCriaQuery;

  With qryCadBas Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT ');
    SQL.Add('  SHE_CADBAS.*, ');

    If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') = '0') Then
    Begin
      SQL.Add('  BAS_PRECUS AS ITE_PRECUS, ');
      SQL.Add('  BAS_PREVEN AS ITE_PREVEN ');
    End
    Else
    Begin
      SQL.Add('  ITE_PRECUS, ');
      SQL.Add('  ITE_PREVE' + fArqIniTinta(0, 'GERAL', 'TABPRECO_GERACAO', '1') + ' AS ITE_PREVEN ');
    End;

    SQL.Add('FROM ');
    SQL.Add('  SHE_CADBAS ');
    SQL.Add('LEFT JOIN ITEGER ON ITE_CODITE = BAS_CODITE  ');
    SQL.Add('            AND ITE_CODEMP = ' + QuotedStr(VS_strCodEmp));
    Open;
  End;

  With qryCadCol Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT ');
    SQL.Add('  SHE_CADCOL.*, ');
    SQL.Add('  COL_PRELIT AS ITE_PRECUS, ');
    SQL.Add('  COL_PREVEN AS ITE_PREVEN ');
    SQL.Add('FROM ');
    SQL.Add('  SHE_CADCOL');
    Open;
  End;

  With qryCadShe Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM SHE_CADSHE WHERE AUTOINCREM = -1 LIMIT 1');
    Open;
  End;

  intCodSeq := -1;
  SetLength(arrColorantes, 0);
  For intContador := 1 To 10 Do
  Begin
    strCodCol := qryCadNfm.FieldByName('NFM_COL0' + fStrZero(intContador, 2)).AsString;
    fltQtdCol := qryCadNfm.FieldByName('NFM_QTD0' + fStrZero(intContador, 2)).AsFloat;

    If (fEmptyStr(strCodCol)) Then
      Break;

    SetLength(arrColorantes, Length(arrColorantes)+1);
    arrColorantes[Length(arrColorantes)-1].strCodCol := fStrZero(strCodCol, 2);
    arrColorantes[Length(arrColorantes)-1].fltQtdCol := fltQtdCol;
  End;

  fGravaCadShe(qryCadBas, qryCadShe, qryCadCol, arrColorantes, '',
    qryCadNfm.FieldByName('NFM_BASE__').AsString,
    qryCadNfm.FieldByName('NFM_PROKEY').AsString,
    qryCadNfm.FieldByName('NFM_SUBKEY').AsString,
    qryCadNfm.FieldByName('NFM_UNIDAD').AsString,
    qryCadNfm.FieldByName('NFM_EMBALA').AsFloat,
//    qryCadNfm.FieldByName('NFM_DESCRI').AsString + ' ' + qryCadNfm.FieldByName('NFM_CODPRO').AsString,
    qryCadNfm.FieldByName('NFM_DESCRI').AsString,
    qryCadNfm.FieldByName('NFM_CODPRO').AsString,
    True,
    intCodSeq);

  FreeAndNil(qryCadBas);
  FreeAndNil(qryCadCol);
  FreeAndNil(qryCadShe);

  Result := True;

end;

function fRetProxCodSeq: Integer;
  Var
    qryGen : TUniQuery;
begin
  qryGen := fCriaQuery;
  qryGen.SQL.Text := 'SELECT SHE_CODSEQ FROM SHE_CADSHE ORDER BY SHE_CODSEQ DESC LIMIT 1;';
  qryGen.Open;
  If qryGen.IsEmpty Then
    Result := 1
  Else
    Result := qryGen.FieldByName('SHE_CODSEQ').AsInteger + 1;
  FreeAndNil(qryGen);
end;

end.

