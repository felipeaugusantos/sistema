unit untCalculadorNotaFiscalEspecialTintometricoProdutoAcabado;

interface

uses
  untAbstractCalculadorNotaFiscalEspecialTintometrico, StrUtils, Uni,
  untITelaGravando, SysUtils, untFuncoesSimples;

type
  TCalculadorNotaFiscalEspecialTintometricoProdutoAcabado = class(TAbstractCalculadorNotaFiscalEspecialTintometrico)
  private
    function fGetFieldQuery(const strField: String; qryQuery: TUniQuery): String;
    function GetSQL(const strTinDet, strMovDet: string): string;
    procedure pAdicionaNaTemporariaNotaEspiritoSanto(strCodIte, strDesIte: String;
      fltQtdIte, fltUnitar: Double; strUnidad: String; strCodAca: String; strEmpAca: String);
  protected
    function GetSQLTinDet(): string; override;
    procedure ProcessarTinDet(const tela: ITelaGravando; const qryTinDet: TUniQuery; out fltTotSub: Double); override;
    procedure pCriaTabelaNfEspiritoSanto; override;
    procedure ProcessarTempNfEspiritoSanto(const tela: ITelaGravando; qryTmp: TUniQuery); override;
  public
    function fExisteNFTintometricoPendente: Boolean; override;
  end;

implementation

uses Data.DB;

{ TCalculadorNotaFiscalEspecialTintometricoProdutoAcabado }

function TCalculadorNotaFiscalEspecialTintometricoProdutoAcabado.fExisteNFTintometricoPendente: Boolean;
var
  LSql   : String;
  LQuery : TUniQuery;
begin
  LQuery := fCriaQuery(nil);
  Result := False;
  try
    LSql := 'SELECT '
          + '       M.GER_CODEMP '
          + '     , I.ITE_CODITE '
          + '     , I.ITE_DESITE '
          + '     , SUM(D.DET_QTDITE) AS QTDE_VENDIDA '
          + '     , (SELECT SUM(O.DET_QTDITE) FROM NOTGER N '
          + '         INNER JOIN NOTDET O ON O.DET_SEQGER = N.AUTOINCREM '
          + '         INNER JOIN NESTIN E ON E.TIN_SEQDET = O.AUTOINCREM '
          + '         WHERE O.DET_CODITE = I.ITE_CODITE '
          + '           AND E.TIN_TIPITE = "A" '
          + '           AND E.TIN_DTAENT = M.GER_DTAENT) AS QTDE_EMITIDA '
          + '  FROM MOVGER M '
          + ' INNER JOIN MOVDET D ON D.DET_SEQGER = M.AUTOINCREM '
          + ' INNER JOIN CADITE I ON I.ITE_CODITE = D.DET_CODITE '
          + ' INNER JOIN TINDET T ON T.DET_NUMDOC = D.DET_NUMDOC '
          + '                    AND T.DET_ESPDOC = D.DET_ESPDOC '
          + '                    AND T.DET_CODITE = D.DET_CODITE '
          + ' WHERE M.GER_DTAENT = :DTAENT '
          + '   AND M.GER_CODEMP = :CODEMP '
          + '   AND D.DET_ESPDOC IN ("NF", "EL", "IF", "IV", "NV") '
          + ' GROUP BY '
          + '       M.GER_CODEMP '
          + '     , I.ITE_CODITE '
          + '     , I.ITE_DESITE '
          + '     , M.GER_DTAENT ';

    LQuery.Close;
    LQuery.SQL.Text := LSql;
    LQuery.ParamByName('DTAENT').AsDate   := dtaDtaIni;
    LQuery.ParamByName('CODEMP').AsString := VS_strCodEmp;
    LQuery.Open;

    LQuery.First;
    while not LQuery.Eof do
    begin
      if not (LQuery.FieldByName('QTDE_EMITIDA').AsFloat >=
              LQuery.FieldByName('QTDE_VENDIDA').AsFloat) then
      begin
        Exit(True);
      end;

      LQuery.Next;
    end;
  finally
    FreeAndNil(LQuery);
  end;
end;

function TCalculadorNotaFiscalEspecialTintometricoProdutoAcabado.fGetFieldQuery(
  const strField: String; qryQuery: TUniQuery): String;
begin
  Result := EmptyStr;

  If Not Assigned(qryQuery) Then
    Exit;

  If Not qryQuery.Active Then
    Exit;

  If (Not Assigned(qryQuery.FindField(strField))) Then
    Exit;

  Result := qryQuery.FieldByName(strField).AsString;
end;

function TCalculadorNotaFiscalEspecialTintometricoProdutoAcabado.GetSQL(
  const strTinDet, strMovDet: string): string;
var
  strAlias: string;
  strDtaEnt: string;
  strEspDoc: string;
  blnNFTCNF: Boolean;
begin
  strAlias := IfThen(strTinDet  = 'TINDET', 'T', 'D');
  strDtaEnt := IfThen(strTinDet = 'TINDET', 'DTAENT', 'DTAFAT');
  strEspDoc := IfThen(strTinDet = 'TINDET', 'ESPDOC', 'TIPFAT');

  blnNFTCNF := fCfgSis('NFTCNF', VarBoolean);

  Result := '';

  If blnNFTCNF Then
  Begin
    Result := Result + ' SELECT  ';
    Result := Result + '   SQL_NO_CACHE DET_PROEMB,    ';
    Result := Result + '   DET_ITEEMB,                 ';
    Result := Result + '   CHAVE,                      ';
    Result := Result + '   DET_IDEPRO,                 ';
    Result := Result + '   DET_CODEMP,                 ';
    Result := Result + '   DET_CODITE,                 ';
    Result := Result + '   DET_DESCRI,                 ';

    If (blnNFTCNF) Then
    Begin
      Result := Result + ' DET_CODACA,                 ';
      Result := Result + ' DET_EMPACA,                 ';
    End;

    Result := Result + '   SUM(TOTITE) TOTITE,         ';
    Result := Result + '   SUM(TOTCUS) TOTCUS,         ';
    Result := Result + '   SUM(DET_QTDITE) DET_QTDITE, ';
    Result := Result + '   SUM(DET_UNITAR) DET_UNITAR, ';
    Result := Result + '   TABELA                      ';
    Result := Result + ' FROM (                        ';
  End;


  Result := Result + ' SELECT                                                                  ';
  Result := Result + '   SQL_NO_CACHE DET_PROEMB                                               ';
  Result := Result + '   , D.DET_ITEEMB                                                        ';
  Result := Result + '   , D.AUTOINCREM AS CHAVE                                               ';
  Result := Result + '   , T.DET_IDEPRO                                                        ';
  Result := Result + '   , T.DET_CODEMP                                                        ';
  Result := Result + '   , T.DET_CODITE                                                        ';
  Result := Result + '   , T.DET_DESCRI                                                        ';

  If (blnNFTCNF) Then
  Begin
    Result := Result + ' , T.DET_CODACA                                                        ';
    Result := Result + ' , T.DET_EMPACA                                                        ';
  End;

  Result := Result + '   , SUM(D.DET_TOTITE - D.DET_DESESP) TOTITE                             ';
  Result := Result + '   , SUM(D.DET_TOTCUS)                TOTCUS                             ';
  Result := Result + '   , SUM(T.DET_QTDITE) AS DET_QTDITE                                     ';
  Result := Result + '   , SUM(D.DET_TOTITE - D.DET_DESESP) / SUM(T.DET_QTDITE) AS DET_UNITAR  ';
  Result := Result + '   , "MOVTIN" AS TABELA                                                  ';
  Result := Result + ' FROM                                                                    ';
  Result := Result + '   ' + strTinDet + ' T                                                   ';
  Result := Result + '   INNER JOIN ' + strMovDet + ' D                                        ';
  Result := Result + '      ON D.DET_NUMDOC = T.DET_NUMDOC                                     ';
  Result := Result + '     AND D.DET_ESPDOC = T.DET_ESPDOC                                     ';
  Result := Result + '     AND D.DET_CODEMP = T.DET_CODEMP                                     ';
  Result := Result + '     AND D.DET_CODCLI = T.DET_CODCLI                                     ';
  Result := Result + '     AND D.DET_CODITE = T.DET_CODITE                                     ';
  Result := Result + '     AND D.DET_CODACA = T.DET_CODACA                                     ';
  Result := Result + '     AND D.DET_EMPACA = T.DET_EMPACA                                     ';
  Result := Result + '   INNER JOIN ITEGER G                                                   ';
  Result := Result + '      ON G.ITE_CODITE = D.DET_CODITE                                     ';
  Result := Result + '     AND G.ITE_CODEMP = D.DET_CODEMP                                     ';
  Result := Result + ' WHERE ' + strAlias + '.DET_' + strDtaEnt + ' BETWEEN :DTAINI            ';
  Result := Result + '   AND :DTAFIN                                                           ';
  Result := Result + '   AND T.DET_CODEMP = :CODEMP                                            ';
  Result := Result + '   AND LOCATE(D.DET_CLAFIS, :CLAVEN) > 0                                 ';
  Result := Result + '   AND D.DET_' + strEspDoc + ' IN ("NF","EL","IF","IV","NV")             ';
  Result := Result + '   AND D.DET_PROEMB <> "S"                                               ';
  Result := Result + ' GROUP BY T.DET_IDEPRO, T.DET_CODEMP, T.DET_DESCRI                       ';

  If (blnNFTCNF) Then
    Result := Result + ' , T.DET_CODACA, T.DET_EMPACA ';


  If blnNFTCNF Then
  Begin
    Result := Result + ' UNION ALL                                                               ';
    Result := Result + ' SELECT                                                                  ';
    Result := Result + '   SQL_NO_CACHE DET_PROEMB                                               ';
    Result := Result + '   , D.DET_ITEEMB                                                        ';
    Result := Result + '   , D.AUTOINCREM AS CHAVE                                               ';
    Result := Result + '   , T.DET_IDEPRO                                                        ';
    Result := Result + '   , T.DET_CODEMP                                                        ';
    Result := Result + '   , T.DET_CODITE                                                        ';
    Result := Result + '   , T.DET_DESCRI                                                        ';

    If (blnNFTCNF) Then
    Begin
      Result := Result + ' , T.DET_CODACA                                                        ';
      Result := Result + ' , T.DET_EMPACA                                                        ';
    End;

    Result := Result + '   , SUM(D.DET_TOTITE - D.DET_DESESP) TOTITE                             ';
    Result := Result + '   , SUM(D.DET_TOTCUS)                TOTCUS                             ';
    Result := Result + '   , SUM(T.DET_QTDITE) AS DET_QTDITE                                     ';
    Result := Result + '   , SUM(D.DET_TOTITE - D.DET_DESESP) / SUM(T.DET_QTDITE) AS DET_UNITAR  ';
    Result := Result + '   , "MOVTIN" AS TABELA                                                  ';
    Result := Result + ' FROM                                                                    ';
    Result := Result + '   TINDET_NOTDET T                                                       ';
    Result := Result + '   INNER JOIN NOTDET D                                                   ';
    Result := Result + '      ON D.DET_NUMDOC = T.DET_NUMDOC                                     ';
    Result := Result + '     AND D.DET_ESPDOC = T.DET_ESPDOC                                     ';
    Result := Result + '     AND D.DET_CODEMP = T.DET_CODEMP                                     ';
    Result := Result + '     AND D.DET_CODCLI = T.DET_CODCLI                                     ';
    Result := Result + '     AND D.DET_CODITE = T.DET_CODITE                                     ';
    Result := Result + '     AND D.DET_CODACA = T.DET_CODACA                                     ';
    Result := Result + '     AND D.DET_EMPACA = T.DET_EMPACA                                     ';
    Result := Result + '   INNER JOIN ITEGER G                                                   ';
    Result := Result + '      ON G.ITE_CODITE = D.DET_CODITE                                     ';
    Result := Result + '     AND G.ITE_CODEMP = D.DET_CODEMP                                     ';
    Result := Result + ' WHERE T.DET_DTAENT BETWEEN :DTAINI AND :DTAFIN                          ';
    Result := Result + '   AND T.DET_CODEMP = :CODEMP                                            ';
    Result := Result + '   AND D.DET_IDEPRO <> "NOR"                                             ';
    Result := Result + '   AND LOCATE(D.DET_CLAFIS, :CLAVEN) > 0                                 ';
    Result := Result + '   AND D.DET_ESPDOC IN ("NF","EL","IF","IV","NV")                        ';
    Result := Result + '   AND D.DET_PROEMB <> "S"                                               ';
    Result := Result + ' GROUP BY T.DET_IDEPRO, T.DET_CODEMP, T.DET_DESCRI                       ';

    If (blnNFTCNF) Then
      Result := Result + ' , T.DET_CODACA, T.DET_EMPACA ';

    Result := Result + ') T                                                                      ';
    Result := Result + ' GROUP BY T.DET_IDEPRO, T.DET_CODEMP, T.DET_DESCRI                       ';

    If (blnNFTCNF) Then
      Result := Result + ' , T.DET_CODACA, T.DET_EMPACA ';
  End;
end;

function TCalculadorNotaFiscalEspecialTintometricoProdutoAcabado.GetSQLTinDet: string;
begin
  Result := GetSQL('TINDET', 'MOVDET');
end;

procedure TCalculadorNotaFiscalEspecialTintometricoProdutoAcabado.pAdicionaNaTemporariaNotaEspiritoSanto(
  strCodIte, strDesIte: String; fltQtdIte, fltUnitar: Double;
  strUnidad: String; strCodAca: String; strEmpAca: String);
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Try
    qryGen := fCriaQuery();
    qryGen.SQL.Clear;
    qryGen.SQL.Add(' SELECT * ');
    qryGen.SQL.Add('   FROM TMP_NFESPIRITOSANTO ');
    qryGen.SQL.Add('  WHERE CODITE = :CODITE    ');
    qryGen.SQL.Add('    AND DESITE = :DESITE    ');
    qryGen.SQL.Add('    AND UNITAR = :UNITAR    ');

    If fCfgSis('NFTCNF', VarBoolean) Then
    Begin
      qryGen.SQL.Add('  AND CODACA = :CODACA    ');
      qryGen.SQL.Add('  AND EMPACA = :EMPACA    ');
    End;

    qryGen.ParamByName('CODITE').AsString := strCodIte;
    qryGen.ParamByName('DESITE').AsString := strDesIte;
    qryGen.ParamByName('UNITAR').AsFloat  := fltUnitar;

    If fCfgSis('NFTCNF', VarBoolean) Then
    Begin
      qryGen.ParamByName('CODACA').AsString := strCodAca;
      qryGen.ParamByName('EMPACA').AsString := strEmpAca;
    End;

    qryGen.Open;

    If qryGen.IsEmpty Then
    Begin
      qryGen.Insert;

      qryGen.FieldByName('CODITE').AsString := strCodIte;
      qryGen.FieldByName('DESITE').AsString := strDesIte;
      qryGen.FieldByName('QTDITE').AsFloat  := fltQtdIte;
      qryGen.FieldByName('UNITAR').AsFloat  := fltUnitar;
      qryGen.FieldByName('UNIDAD').AsString := strUnidad;

      If fCfgSis('NFTCNF', VarBoolean) Then
      Begin
        qryGen.FieldByName('CODACA').AsString := strCodAca;
        qryGen.FieldByName('EMPACA').AsString := strEmpAca;
      End;
    End
    Else
    Begin
      qryGen.Edit;

      qryGen.FieldByName('QTDITE').AsFloat  := qryGen.FieldByName('QTDITE').AsFloat + fltQtdIte;
    End;

    qryGen.Post;
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TCalculadorNotaFiscalEspecialTintometricoProdutoAcabado.pCriaTabelaNfEspiritoSanto;
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Try
    qryGen := fCriaQuery();
    qryGen.SQL.Clear;
    qryGen.SQL.Text := ' CREATE TABLE TMP_NFESPIRITOSANTO ( ' +
                       ' CODITE VARCHAR('+IntToStr(fTamCodIte)+'),' +
                       ' DESITE VARCHAR(70),   ' +
                       ' QTDITE DECIMAL(12,4), ' +
                       ' UNITAR DECIMAL(12,4), ' +
                       ' UNIDAD CHAR(3),       ' +
                       ' CODACA VARCHAR(6),    ' +
                       ' EMPACA CHAR(3)        ' +
                       ' ); ';
    qryGen.ExecSql;
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TCalculadorNotaFiscalEspecialTintometricoProdutoAcabado.ProcessarTempNfEspiritoSanto(
  const tela: ITelaGravando; qryTmp: TUniQuery);
begin
  pAddItem(qryTmp.FieldByName('CODITE').AsString,
           qryTmp.FieldByName('DESITE').AsString,
           qryTmp.FieldByName('QTDITE').AsFloat,
           qryTmp.FieldByName('UNITAR').AsFloat,
           qryTmp.FieldByName('UNIDAD').AsString,
           fGetFieldQuery('CODACA', qryTmp),
           fGetFieldQuery('EMPACA', qryTmp)
           );
end;

procedure TCalculadorNotaFiscalEspecialTintometricoProdutoAcabado.ProcessarTinDet(const tela: ITelaGravando; const qryTinDet: TUniQuery; out fltTotSub: Double);
begin
  tela.Texto := Format('Inserindo o produto %s - %s',
    [qryTinDet.FieldByName('DET_CODITE').AsString, qryTinDet.FieldByName('DET_DESCRI').AsString]);

  pAdicionaNaTemporariaNotaEspiritoSanto(qryTinDet.FieldByName('DET_CODITE').AsString,
      qryTinDet.FieldByName('DET_DESCRI').AsString,
      qryTinDet.FieldByName('DET_QTDITE').AsFloat,
      qryTinDet.FieldByName('DET_UNITAR').AsFloat,
      '',
      fGetFieldQuery('DET_CODACA', qryTinDet),
      fGetFieldQuery('DET_EMPACA', qryTinDet)
      );

{  pAddItem(qryTinDet.FieldByName('DET_CODITE').AsString,
    qryTinDet.FieldByName('DET_DESCRI').AsString,
    qryTinDet.FieldByName('DET_QTDITE').AsFloat,
    qryTinDet.FieldByName('DET_UNITAR').AsFloat);}
end;

end.
