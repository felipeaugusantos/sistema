unit untLuksColord;

interface

uses SysUtils, Uni, Variants, Forms;

Type

  TColLkd = Record
    strCodCol: String;
    fltQtdCol: Double;

  End;

Type
  TColLkdArray = Array Of TColLkd;

  procedure pGerarBases(strNomArq: String);

  function fGravaCadLkd(qryCadBas, qryCadLkd, qryCadCol: TUniQuery;
    arrColorantes: TColLkdArray; strKey2, strCodBas,
    strProKey, strSubKey, strUnidad: String; fltEmbala: Double;
    strDesBas, strCodCor: String; blnDelExi: Boolean;
    Var intCodSeq: Integer): Boolean;
    
  function fGravaNovasFormulas(qryCadNfm: TUniQuery): Boolean;
  function fRetProxCodSeq: Integer;

implementation

uses untFuncoes, DB, untInkLayoutReader,
  untModuloTinta, untFuncoesSimples;

function fGravaCadLkd(qryCadBas, qryCadLkd, qryCadCol: TUniQuery;
  arrColorantes: TColLkdArray; strKey2, strCodBas,
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
    strSQL := strSQL + 'DELETE FROM LKD_CADLKD WHERE ';
    strSQL := strSQL + 'LKD_CODIGO = :CODPRO ';
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

  qryCadLkd.Append;
  qryCadLkd.FieldByName('LKD_CODSEQ').AsString := fStrZero(fRetProxCodSeq, 6);

  qryCadLkd.FieldByName('LKD_DESCRI').AsString := strDesBas;
  qryCadLkd.FieldByName('LKD_CODIGO').AsString := strCodCor;
  qryCadLkd.FieldByName('LKD_CODIG2').AsString := strKey2;
  qryCadLkd.FieldByName('LKD_UNIDAD').AsString := strUnidad;
  qryCadLkd.FieldByName('LKD_PRECUS').AsFloat  := fltCusCol + qryCadBas.FieldByName('ITE_PRECUS').AsFloat;
  qryCadLkd.FieldByName('LKD_PREVEN').AsFloat  := fltVenCol + qryCadBas.FieldByName('ITE_PREVEN').AsFloat;
  qryCadLkd.FieldByName('LKD_COLCUS').AsFloat  := fltCusCol;
  qryCadLkd.FieldByName('LKD_COLVEN').AsFloat  := fltVenCol;
  qryCadLkd.FieldByName('LKD_CODITE').AsString := qryCadBas.FieldByName('BAS_CODITE').AsString;
  qryCadLkd.FieldByName('LKD_CODEMP').AsString := VS_strCodEmp;
  qryCadLkd.FieldByName('LKD_BASE__').AsString := strCodBas;
  qryCadLkd.FieldByName('LKD_PROKEY').AsString := strProKey;
  qryCadLkd.FieldByName('LKD_SUBKEY').AsString := strSubKey;

  For intContador := Low(arrColorantes) To High(arrColorantes) Do
  Begin
    If fEmptyStr(arrColorantes[intContador].strCodCol) Then
      Break;

    qryCadLkd.FieldByName('LKD_FORM' + fStrZero(intContador + 1, 2)).AsString := arrColorantes[intContador].strCodCol;
    qryCadLkd.FieldByName('LKD_QTDB' + fStrZero(intContador + 1, 2)).AsFloat := arrColorantes[intContador].fltQtdCol;
  End;

  qryCadLkd.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('LKD_CADLKD', VS_strCodEmp);
  qryCadLkd.Post;
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

  pZapTable('LKD_CADBAS');

  qryCadBas := fCriaQuery;
  qryCadBas.SQL.Add('SELECT * FROM LKD_CADBAS');
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
    arrColorantes: TColLkdArray;
    intContador: Integer;
    strCodCol: String;
    fltQtdCol: Double;
    intCodSeq: Integer;
    qryCadBas: TUniQuery;
    qryCadCol: TUniQuery;
    qryCadLkd: TUniQuery;
begin

  qryCadBas := fCriaQuery;
  qryCadCol := fCriaQuery;
  qryCadLkd := fCriaQuery;

  With qryCadBas Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT ');
    SQL.Add('  LKD_CADBAS.*, ');

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
    SQL.Add('  LKD_CADBAS ');
    SQL.Add('LEFT JOIN ITEGER ON ITE_CODITE = BAS_CODITE ');
    SQL.Add('            AND ITE_CODEMP = ' + QuotedStr(VS_strCodEmp));
    Open;
  End;

  With qryCadCol Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT ');
    SQL.Add('  LKD_CADCOL.*, ');
    SQL.Add('  COL_PRELIT AS ITE_PRECUS, ');
    SQL.Add('  COL_PREVEN AS ITE_PREVEN ');
    SQL.Add('FROM ');
    SQL.Add('  LKD_CADCOL');
    Open;
  End;

  With qryCadLkd Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM LKD_CADLKD WHERE AUTOINCREM = -1 LIMIT 1');
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

  fGravaCadLkd(qryCadBas, qryCadLkd, qryCadCol, arrColorantes, '',
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
  FreeAndNil(qryCadLkd);

  Result := True;

end;

function fRetProxCodSeq: Integer;
  Var
    qryGen : TUniQuery;
begin
  qryGen := fCriaQuery;
  qryGen.SQL.Text := 'SELECT LKD_CODSEQ FROM LKD_CADLKD ORDER BY LKD_CODSEQ DESC LIMIT 1;';
  qryGen.Open;
  If qryGen.IsEmpty Then
    Result := 1
  Else
    Result := qryGen.FieldByName('LKD_CODSEQ').AsInteger + 1;
  FreeAndNil(qryGen);
end;


end.

