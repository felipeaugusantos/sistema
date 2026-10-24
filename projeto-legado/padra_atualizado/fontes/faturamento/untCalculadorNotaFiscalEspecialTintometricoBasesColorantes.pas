unit untCalculadorNotaFiscalEspecialTintometricoBasesColorantes;

interface

uses
  untAbstractCalculadorNotaFiscalEspecialTintometrico, Uni, untFuncoesSimples, StrUtils, SysUtils,
  untITelaGravando, UniClientDataSet, Variants,
  untFuncFat, untFuncFatTypes, ComCtrls, untTipoTinta;

type
  TCalculadorNotaFiscalEspecialTintometricoBasesColorantes = class(TAbstractCalculadorNotaFiscalEspecialTintometrico)
  private
    dicItensColorantes : TDicionario;

  private
    function GetSQL: string;
    function fGetSQLMovTin(const strTabela: String): String;
    function fProcessaMovTin(const tela: ITelaGravando; const strAutInc, strTabela: string; out fltTotSub: Double): Boolean;
    function fTemMovTin(const strCodAca, strEmpAca, strTabela: string): Boolean;
    function fExisteNFTintometricoPendenteTabela(const strTabela: String): Boolean;
    function fGetTabela(qryDestino: TUniQuery): String;
    procedure GetDadosProdutos(const strCodIte, strTabPre: string; var strDescri, strCodUni: string;
      var fltCnv_Ml, fltUnitar: Double);
    function GetItemColorante(const strIdePro, strCodBas, strCodEmp: string; var strCodIte, strDescri: string): Boolean;

    procedure pAdicionaNaTemporariaNotaEspiritoSanto(strCodIte, strDesIte: String; fltQtdIte, fltUnitar: Double; strUnidad: String);
  protected
    function GetSQLTinDet(): string; override;
    procedure ProcessarTinDet(const tela: ITelaGravando; const qryTinDet: TUniQuery; out fltTotSub: Double); override;
    procedure pCriaTabelaNfEspiritoSanto; override;

    procedure ProcessarTempNfEspiritoSanto(const tela: ITelaGravando; qryTmp: TUniQuery); override;
  public
    constructor Create(const fatVendas: TFatVenda; const dtaDtaIni, dtaDtaFin: TDateTime;
      const pAddItem: TPAdicionaItem; const pgbProgresso: TProgressBar; const pCancNFEspecial: TPCancNFEspecial); override;
    destructor Destroy; override;

    function fExisteNFTintometricoPendente: Boolean; override;
  end;

implementation

uses untClientDataSetFactory, untFuncTinta, untConstantes, Data.DB,
  Shared.Functions.Types;
{ TCalculadorNotaFiscalEspecialTintometricoBasesColorantes }

constructor TCalculadorNotaFiscalEspecialTintometricoBasesColorantes.Create(const fatVendas: TFatVenda; const dtaDtaIni,
  dtaDtaFin: TDateTime; const pAddItem: TPAdicionaItem; const pgbProgresso: TProgressBar; const pCancNFEspecial: TPCancNFEspecial);
begin
  inherited Create(fatVendas, dtaDtaIni, dtaDtaFin, pAddItem, pgbProgresso, pCancNFEspecial);
  dicItensColorantes := TDicionario.Create;
end;

destructor TCalculadorNotaFiscalEspecialTintometricoBasesColorantes.Destroy;
begin
  if Assigned(dicItensColorantes) then FreeAndNil(dicItensColorantes);
  inherited;
end;

function TCalculadorNotaFiscalEspecialTintometricoBasesColorantes.fExisteNFTintometricoPendenteTabela(
  const strTabela: String): Boolean;

  function fTableMovTin: String;
  begin
    Result := IIF(strTabela = 'TINDET_NOTDET', 'MOVTIN_NOTDET', 'MOVTIN');
  end;

  function fTableMovDet: String;
  begin
    Result := IIF(strTabela = 'TINDET_NOTDET', 'NOTDET', 'MOVDET');
  end;

  function fTableMovGer: String;
  begin
    Result := IIF(strTabela = 'TINDET_NOTDET', 'NOTGER', 'MOVGER');
  end;

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
          + '     , SUM(ROUND(T.TIN_QTDITE / IF(T.TIN_PROEMB = "S" OR I.ITE_CNV_ML <= 0, 1,  I.ITE_CNV_ML), 4)) QTDE_VENDIDA '
          + '     , (SELECT SUM(O.DET_QTDITE) FROM NOTGER N '
          + '         INNER JOIN NOTDET O ON O.DET_SEQGER = N.AUTOINCREM '
          + '         INNER JOIN NESTIN E ON E.TIN_SEQDET = O.AUTOINCREM '
          + '         WHERE O.DET_CODITE = I.ITE_CODITE '
          + '           AND E.TIN_TIPITE = "B" '
          + '           AND E.TIN_DTAENT = M.GER_DTAENT) AS QTDE_EMITIDA '
          + '  FROM ' + fTableMovGer + ' M '
          + ' INNER JOIN ' + fTableMovDet + ' D ON D.DET_SEQGER = M.AUTOINCREM '
          + ' INNER JOIN ' + fTableMovTin + ' T ON T.TIN_SEQGER = D.AUTOINCREM '
          + ' INNER JOIN CADITE I ON I.ITE_CODITE = T.TIN_CODITE '
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

function TCalculadorNotaFiscalEspecialTintometricoBasesColorantes.fExisteNFTintometricoPendente: Boolean;
begin
  Result := fExisteNFTintometricoPendenteTabela('TINDET');
  If (Not Result) And (fCfgSis('NFTCNF', VarBoolean)) Then
    Result := fExisteNFTintometricoPendenteTabela('TINDET_NOTDET');
end;

function TCalculadorNotaFiscalEspecialTintometricoBasesColorantes.fGetSQLMovTin(
  const strTabela: String): String;

  function fRetQtdIte: String;
  begin
    Result := ' IF(TIN_PROEMB = "S", 1, DET_QTDITE) ';
  end;

  function fTableMovTin: String;
  begin
    Result := IIF(strTabela = 'TINDET_NOTDET', 'MOVTIN_NOTDET', 'MOVTIN');
  end;

  function fTableMovDet: String;
  begin
    Result := IIF(strTabela = 'TINDET_NOTDET', 'NOTDET', 'MOVDET');
  end;

begin
  Result := EmptyStr;
  Result := Result + ' SELECT                                                   ';
  Result := Result + '   ITE_CNV_ML                                             ';
  Result := Result + '   , TIN_PROEMB                                           ';
  Result := Result + '   , DET_IDEPRO                                           ';
  Result := Result + '   , ROUND(TIN_QTDITE, 4) TIN_QTDITE                      ';
  Result := Result + '   , UNI_CODUNI                                           ';
  Result := Result + '   , TIN_CODITE                                           ';
  Result := Result + '   , ITE_DESITE                                           ';
  Result := Result + '   , ROUND(                                               ';
  Result := Result + '       DET_TOTITE /                                       ';
  Result := Result + '       ( SELECT                                           ';
  Result := Result + '         SUM( TIN_TOTITE / TIN_QTDITE * DET_TOTITE / ( SELECT SUM(TIN_TOTITE)                          ';
  Result := Result + '                                                       FROM MOVTIN                                     ';
  Result := Result + '                                                       WHERE TIN_SEQGER = M.TIN_SEQGER) * TIN_QTDITE ) ';
  Result := Result + '         FROM MOVTIN                                                                                   ';
  Result := Result + '         WHERE TIN_SEQGER = M.TIN_SEQGER ) *                                                           ';
  Result := Result + '         (    TIN_TOTITE / TIN_QTDITE * DET_TOTITE / ( SELECT SUM(TIN_TOTITE)                          ';
  Result := Result + '                                                       FROM MOVTIN                                     ';
  Result := Result + '                                                       WHERE TIN_SEQGER = M.TIN_SEQGER )               ';
  Result := Result + '       ), 4 ) DET_UNITAR_REAL                                                                          ';
  Result := Result + '   , ROUND(                                                                                            ';
  Result := Result + '       DET_TOTCUS /                                                                                    ';
  Result := Result + '       ( SELECT                                                                                        ';
  Result := Result + '         SUM( TIN_TOTCUS / TIN_QTDITE * DET_TOTCUS / ( SELECT SUM(TIN_TOTCUS)                          ';
  Result := Result + '                                                       FROM MOVTIN                                     ';
  Result := Result + '                                                       WHERE TIN_SEQGER = M.TIN_SEQGER) * TIN_QTDITE ) ';
  Result := Result + '         FROM MOVTIN                                                                                   ';
  Result := Result + '         WHERE TIN_SEQGER = M.TIN_SEQGER ) *                                                           ';
  Result := Result + '         (    TIN_TOTCUS / TIN_QTDITE * DET_TOTCUS / ( SELECT SUM(TIN_TOTCUS)                          ';
  Result := Result + '                                                       FROM MOVTIN                                     ';
  Result := Result + '                                                       WHERE TIN_SEQGER = M.TIN_SEQGER )               ';
  Result := Result + '       ), 4 ) DET_CUSTO_REAL                                        ';
  Result := Result + ' FROM                                                               ';
  Result := Result + '   ' + fTableMovTin + ' M                                           ';
  Result := Result + '   INNER JOIN ' + fTableMovDet + ' D                                ';
  Result := Result + '     ON M.TIN_SEQGER = D.AUTOINCREM                                 ';
  Result := Result + '   LEFT JOIN CADITE I                                               ';
  Result := Result + '     ON M.TIN_CODITE = I.ITE_CODITE                                 ';
  Result := Result + '   LEFT JOIN CADUNI U                                               ';
  Result := Result + '     ON I.ITE_CODUNI = U.UNI_CODUNI                                 ';
  Result := Result + ' WHERE M.TIN_SEQGER = :TIN_SEQGER AND (TIN_CODITE IS NOT NULL)      ';
end;

function TCalculadorNotaFiscalEspecialTintometricoBasesColorantes.fGetTabela(
  qryDestino: TUniQuery): String;
begin
  Result := 'NOTDET';

  If (Not fCfgSis('NFTCNF', VarBoolean)) Then
    Exit;

  If Not Assigned(qryDestino) Then
    Exit;

  If Not qryDestino.Active Then
    Exit;

  If (Not Assigned(qryDestino.FindField('TABELA'))) Then
    Exit;

  If fEmptyStr(qryDestino.FieldByName('TABELA').AsString) Then
    Exit;

  Result := qryDestino.FieldByName('TABELA').AsString;
end;

function TCalculadorNotaFiscalEspecialTintometricoBasesColorantes.fProcessaMovTin(const tela: ITelaGravando; const strAutInc, strTabela: string; out fltTotSub: Double): Boolean;
var
  qryGen: TUniQuery;
  fltUnitar: Double;
  fltCnv_Ml: Double;
  strUnidade: string;
  fltQtdIte: Double;
  intDecUni: Integer;
begin
  Result := False;
  qryGen := nil;
  fltTotSub := 0;
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text := fGetSQLMovTin(strTabela);
      qryGen.ParamByName('TIN_SEQGER').AsString := strAutInc;
      qryGen.Open;

      if qryGen.IsEmpty then
        Exit;

      intDecUni := fCfgSis('DECUNI', varInteger);

      qryGen.First;
      while not qryGen.Eof do
      begin
        Try
          Try
            fltCnv_Ml := qryGen.FieldByName('ITE_CNV_ML').AsFloat;
            if (fltCnv_Ml <= 0) or (qryGen.FieldByName('TIN_PROEMB').AsString = 'S') then
              fltCnv_Ml := 1;

            fltQtdIte := qryGen.FieldByName('TIN_QTDITE').AsFloat;

            If fCfgSis('TINESP') = 'PREÇO DE VENDA' Then
              fltUnitar := fFormataFloat(qryGen.FieldByName('DET_UNITAR_REAL').AsFloat, intDecUni)
            Else
              fltUnitar := fFormataFloat(qryGen.FieldByName('DET_CUSTO_REAL').AsFloat, intDecUni);

            If fltUnitar <= 0 Then
              fltUnitar := 0.01;

            If fTipoTinta(qryGen.FieldByName('DET_IDEPRO').AsString) = ttImobiliaria Then
            Begin
              If (qryGen.FieldByName('TIN_PROEMB').AsString = 'S') Then
                strUnidade := qryGen.FieldByName('UNI_CODUNI').AsString
              Else
                strUnidade := fCfgSis('TINESI')
            End
            Else If fTipoTinta(qryGen.FieldByName('DET_IDEPRO').AsString) = ttAutomotiva Then
            Begin
              strUnidade := fCfgSis('TINESA')
            End
            Else If fTipoTinta(qryGen.FieldByName('DET_IDEPRO').AsString) = ttIndustrial Then
            Begin
              strUnidade := fCfgSis('TINESD');
            End;

            If fCfgSis('NFTIES') = '2' Then
            Begin
              fltUnitar := fltUnitar * fltCnv_Ml;
              fltQtdIte := fltQtdIte / fltCnv_Ml;
              strUnidade := qryGen.FieldByName('UNI_CODUNI').AsString;
            End;

            If (fEmptyStr(fRetNomUnidade(strUnidade))) Then
            Begin
              pCancNFEspecial('Essa unidade ' + strUnidade + ' não está cadastrada!');
              blnCancelar := True;
              Result := True;
              Exit;
            End;

            If (fatVendas.opcItensNFespTinta In [opcColorantesTributados, opcColorantesNaoTributados]) Then
            Begin
              If Assigned(fTipoTinta) And
                ((fTipoTinta(qryGen.FieldByName('DET_IDEPRO').AsString) = ttAutomotiva) or
                 (qryGen.FieldByName('TIN_PROEMB').AsString = 'S')) Then
              Begin
                fltTotSub := fltTotSub + (fltQtdIte * fltUnitar);

                // O next está dentro do Finally
                Continue;
              end;
            end;

            tela.Texto := Format('Inserindo o produto %s - %s',
              [qryGen.FieldByName('TIN_CODITE').AsString, qryGen.FieldByName('ITE_DESITE').AsString]);

            pAdicionaNaTemporariaNotaEspiritoSanto(qryGen.FieldByName('TIN_CODITE').AsString,
              qryGen.FieldByName('ITE_DESITE').AsString,
              fltQtdIte,
              fltUnitar,
              strUnidade);

{            pAddItem(qryGen.FieldByName('TIN_CODITE').AsString,
              qryGen.FieldByName('ITE_DESITE').AsString,
              fltQtdIte,
              fltUnitar,
              strUnidade);}

          Except
            on E: Exception do
            begin
              raise;
            end;
          End;
        Finally
          qryGen.Next;
        End;
      end;
      Result := True;

    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryGen) then FreeAndNil(qryGen);
  End;
end;

function TCalculadorNotaFiscalEspecialTintometricoBasesColorantes.fTemMovTin(const strCodAca, strEmpAca, strTabela: string): Boolean;

  function fTableMovTin: String;
  begin
    Result := IIF(strTabela = 'TINDET_NOTDET', 'MOVTIN_NOTDET', 'MOVTIN');
  end;

  function fTableMovDet: String;
  begin
    Result := IIF(strTabela = 'TINDET_NOTDET', 'NOTDET', 'MOVDET');
  end;

var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Result := False;
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Clear;
      qryGen.SQL.Add(' SELECT                               ');
      qryGen.SQL.Add('   COUNT(0) AS QTD                    ');
      qryGen.SQL.Add(' FROM                                 ');
      qryGen.SQL.Add('   ' + fTableMovDet + ' D             ');
      qryGen.SQL.Add('   INNER JOIN ' + fTableMovTin + ' M  ');
      qryGen.SQL.Add('     ON D.AUTOINCREM = M.TIN_SEQGER   ');
      qryGen.SQL.Add(' WHERE D.DET_CODACA = :CODACA AND D.DET_EMPACA = :EMPACA ');
      qryGen.ParamByName('CODACA').AsString := strCodAca;
      qryGen.ParamByName('EMPACA').AsString := strEmpAca;
      qryGen.Open;

      Result := qryGen.FieldByName('QTD').AsInteger > 0;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryGen) then FreeAndNil(qryGen);
  End;
end;

function TCalculadorNotaFiscalEspecialTintometricoBasesColorantes.GetSQL: string;

  function fGetSQL(strAlias, strDtaEnt, strEspDoc: string): String;
  var
    blnNFTCNF: Boolean;
  begin
    blnNFTCNF := fCfgSis('NFTCNF', VarBoolean);

    Result := '';
    Result := Result + ' SELECT                                                                   ';
    Result := Result + '   SQL_NO_CACHE DET_PROEMB                                                ';
    Result := Result + '   , D.DET_ITEEMB                                                         ';
    Result := Result + '   , D.AUTOINCREM AS CHAVE                                                ';
    Result := Result + '   , T.*                                                                  ';
    Result := Result + '   , U.UNI_SIGUNI                                                         ';
    Result := Result + '   , D.DET_TABPRE                                                         ';
    Result := Result + '   , U.UNI_CODUNI                                                         ';
    Result := Result + '   , D.DET_TOTITE - D.DET_DESESP TOTITE                                   ';
    Result := Result + '   , D.DET_TOTCUS                TOTCUS                                   ';
    Result := Result + '   , D.DET_CODACA                                                         ';
    Result := Result + '   , D.DET_EMPACA                                                         ';
    Result := Result + '   , "TINDET" AS TABELA                                                   ';
    Result := Result + ' FROM                                                                     ';
    Result := Result + '   TINDET T                                                               ';
    Result := Result + '   INNER JOIN MOVDET D                                                    ';
    Result := Result + '     ON D.DET_NUMDOC = T.DET_NUMDOC                                       ';
    Result := Result + '     AND D.DET_ESPDOC = T.DET_ESPDOC                                      ';
    Result := Result + '     AND D.DET_CODEMP = T.DET_CODEMP                                      ';
    Result := Result + '     AND D.DET_CODCLI = T.DET_CODCLI                                      ';
    Result := Result + '     AND D.DET_CODACA = T.DET_CODACA                                      ';
    Result := Result + '     AND D.DET_EMPACA = T.DET_EMPACA                                      ';
    Result := Result + '   INNER JOIN ITEGER G                                                    ';
    Result := Result + '     ON G.ITE_CODITE = D.DET_CODITE                                       ';
    Result := Result + '     AND G.ITE_CODEMP = D.DET_CODEMP                                      ';
    Result := Result + '   JOIN CADITE I                                                          ';
    Result := Result + '     ON I.ITE_CODITE = G.ITE_CODITE                                       ';
    Result := Result + '   LEFT JOIN CADUNI U                                                     ';
    Result := Result + '     ON U.UNI_CODUNI = I.ITE_CODUNI                                       ';
    Result := Result + ' WHERE ' + strAlias + '.DET_' + strDtaEnt + ' BETWEEN :DTAINI AND :DTAFIN ';
    Result := Result + '   AND T.DET_CODEMP = :CODEMP                                             ';
    Result := Result + '   AND LOCATE(D.DET_CLAFIS, :CLAVEN) > 0                                  ';
    Result := Result + '   AND D.DET_' + strEspDoc + ' IN ("NF","EL","IF","IV","NV")              ';

    If blnNFTCNF Then
    Begin
      Result := Result + ' UNION ALL                                        ';
      Result := Result + ' SELECT                                           ';
      Result := Result + '   SQL_NO_CACHE DET_PROEMB                        ';
      Result := Result + '   , D.DET_ITEEMB                                 ';
      Result := Result + '   , D.AUTOINCREM AS CHAVE                        ';
      Result := Result + '   , T.*                                          ';
      Result := Result + '   , U.UNI_SIGUNI                                 ';
      Result := Result + '   , D.DET_TABPRE                                 ';
      Result := Result + '   , U.UNI_CODUNI                                 ';
      Result := Result + '   , D.DET_TOTITE - D.DET_DESESP TOTITE           ';
      Result := Result + '   , D.DET_TOTCUS                TOTCUS           ';
      Result := Result + '   , D.DET_CODACA                                 ';
      Result := Result + '   , D.DET_EMPACA                                 ';
      Result := Result + '   , "TINDET_NOTDET" AS TABELA                    ';
      Result := Result + ' FROM                                             ';
      Result := Result + '   TINDET_NOTDET T                                ';
      Result := Result + '   INNER JOIN NOTDET D                            ';
      Result := Result + '     ON D.DET_NUMDOC = T.DET_NUMDOC               ';
      Result := Result + '     AND D.DET_ESPDOC = T.DET_ESPDOC              ';
      Result := Result + '     AND D.DET_CODEMP = T.DET_CODEMP              ';
      Result := Result + '     AND D.DET_CODCLI = T.DET_CODCLI              ';
      Result := Result + '     AND D.DET_CODACA = T.DET_CODACA              ';
      Result := Result + '     AND D.DET_EMPACA = T.DET_EMPACA              ';
      Result := Result + '   INNER JOIN ITEGER G                            ';
      Result := Result + '     ON G.ITE_CODITE = D.DET_CODITE               ';
      Result := Result + '     AND G.ITE_CODEMP = D.DET_CODEMP              ';
      Result := Result + '   JOIN CADITE I                                  ';
      Result := Result + '     ON I.ITE_CODITE = G.ITE_CODITE               ';
      Result := Result + '   LEFT JOIN CADUNI U                             ';
      Result := Result + '     ON U.UNI_CODUNI = I.ITE_CODUNI               ';
      Result := Result + ' WHERE T.DET_DTAENT BETWEEN :DTAINI AND :DTAFIN   ';
      Result := Result + '   AND D.DET_IDEPRO <> "NOR"                      ';
      Result := Result + '   AND D.DET_PROEMB <> "S"                        ';
      Result := Result + '   AND T.DET_CODEMP = :CODEMP                     ';
      Result := Result + '   AND LOCATE(D.DET_CLAFIS, :CLAVEN) > 0          ';
      Result := Result + '   AND D.DET_ESPDOC IN ("NF","EL","IF","IV","NV") ';
    End;
  end;
begin
  Result := fGetSQL('T','DTAENT','ESPDOC');
end;

function TCalculadorNotaFiscalEspecialTintometricoBasesColorantes.GetSQLTinDet: string;
begin
  Result := GetSQL;
end;

procedure TCalculadorNotaFiscalEspecialTintometricoBasesColorantes.pAdicionaNaTemporariaNotaEspiritoSanto(
  strCodIte, strDesIte: String; fltQtdIte, fltUnitar: Double;
  strUnidad: String);
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Try
    qryGen := fCriaQuery();
    qryGen.SQL.Clear;
    qryGen.SQL.Text := ' SELECT * ' +
                       '   FROM TMP_NFESPIRITOSANTO ' +
                       '  WHERE CODITE = :CODITE    ' +
                       '    AND DESITE = :DESITE    ' +
                       '    AND UNITAR = :UNITAR    ';

    qryGen.ParamByName('CODITE').AsString := strCodIte;
    qryGen.ParamByName('DESITE').AsString := strDesIte;
    qryGen.ParamByName('UNITAR').AsFloat  := fltUnitar;
    qryGen.Open;

    If qryGen.IsEmpty Then
    Begin
      qryGen.Insert;

      qryGen.FieldByName('CODITE').AsString := strCodIte;
      qryGen.FieldByName('DESITE').AsString := strDesIte;
      qryGen.FieldByName('QTDITE').AsFloat  := fltQtdIte;
      qryGen.FieldByName('UNITAR').AsFloat  := fltUnitar;
      qryGen.FieldByName('UNIDAD').AsString := strUnidad;
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

procedure TCalculadorNotaFiscalEspecialTintometricoBasesColorantes.pCriaTabelaNfEspiritoSanto;
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
                       ' UNIDAD CHAR(3));      ';
    qryGen.ExecSql;
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TCalculadorNotaFiscalEspecialTintometricoBasesColorantes.GetDadosProdutos(const strCodIte, strTabPre: string;
  var strDescri, strCodUni: string; var fltCnv_Ml, fltUnitar: Double);
var
  qryGen: TUniQuery;
  intContador: Integer;
begin
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text :=
        ' SELECT                             ' +
        '   G.ITE_CODEMP                     ' +
        '   , I.ITE_CODITE                   ' +
        '   , I.ITE_DESITE                   ' +
        '   , I.ITE_CODUNI                   ' +
        '   , I.ITE_CNV_ML                   ' +
        '   , G.ITE_PREVE' + IfThen(fEmptyStr(strTabPre), IIF(fEmptyStr(fCfgSis('TABPAD')), '1', fCfgSis('TABPAD')), strTabPre) + ' AS ITE_UNITAR     ' +
        '   , G.ITE_PREVE1                   ' +
        '   , G.ITE_PREVE2                   ' +
        '   , G.ITE_PREVE3                   ' +
        '   , G.ITE_PREVE4                   ' +
        '   , G.ITE_PREVE5                   ' +
        '   , G.ITE_PREVE6                   ' +
        '   , G.ITE_PREVE7                   ' +
        ' FROM                               ' +
        '   ITEGER G                         ' +
        '   INNER JOIN CADITE I              ' +
        '     ON G.ITE_CODITE = I.ITE_CODITE ' +
        ' WHERE G.ITE_CODEMP = :CODEMP       ' +
        '   AND I.ITE_CODITE = :CODITE       ';
      qryGen.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryGen.ParamByName('CODITE').AsString := strCodIte;
      qryGen.Open;

      strDescri := qryGen.FieldByName('ITE_DESITE').AsString;
      fltUnitar := qryGen.FieldByName('ITE_UNITAR').AsFloat;
      strCodUni := qryGen.FieldByName('ITE_CODUNI').AsString;
      fltCnv_Ml := qryGen.FieldByName('ITE_CNV_ML').AsFloat;

      If fltUnitar <= 0 Then
      Begin
        For intContador := 1 To 7 Do
        Begin
          fltUnitar := qryGen.FieldByName('ITE_PREVE' + IntToStr(intContador)).AsFloat;
          If fltUnitar > 0 Then
          Begin
            Break;
          End;
        End;
      End;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryGen) then FreeAndNil(qryGen);
  End;                              
end;

function TCalculadorNotaFiscalEspecialTintometricoBasesColorantes.GetItemColorante(const strIdePro, strCodBas, strCodEmp: string;
  var strCodIte, strDescri: string): Boolean;
var
  strCodBasRetorno: string;
  qryGen: TUniQuery;

  function GetChave: string;
  begin
    Result := GetMD5(GetMD5(strIdePro) + GetMD5(strCodBas) + GetMD5(strCodEmp));
  end;
begin
  qryGen := nil;
  Result := False;
  Try
    Try
      if dicItensColorantes[GetChave] = Null then
      begin
        pRetItemColorante(strIdePro, strCodBas, strCodIte, strCodBasRetorno, strCodEmp);
        dicItensColorantes[GetChave] := strCodIte;
      end
      else
        strCodIte := dicItensColorantes[GetChave];
        
      qryGen := fCriaQuery();
      qryGen.SQL.Text :=
        ' SELECT                     ' +
        '   ITE_DESITE               ' +
        ' FROM                       ' +
        '   CADITE                   ' +
        ' WHERE ITE_CODITE = :CODITE ';
      qryGen.ParamByName('CODITE').AsString := strCodIte;
      strDescri := TClientDataSetFactory.GetClientDataSet(qryGen).FieldByName('ITE_DESITE').AsString;

      Result := not fEmptyStr(strCodIte);
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryGen) then FreeAndNil(qryGen);
  End;

end;

procedure TCalculadorNotaFiscalEspecialTintometricoBasesColorantes.ProcessarTempNfEspiritoSanto(
  const tela: ITelaGravando; qryTmp: TUniQuery);
begin
  pAddItem(qryTmp.FieldByName('CODITE').AsString,
           qryTmp.FieldByName('DESITE').AsString,
           qryTmp.FieldByName('QTDITE').AsFloat,
           qryTmp.FieldByName('UNITAR').AsFloat,
           qryTmp.FieldByName('UNIDAD').AsString);
end;

procedure TCalculadorNotaFiscalEspecialTintometricoBasesColorantes.ProcessarTinDet(const tela: ITelaGravando; const qryTinDet: TUniQuery; out fltTotSub: Double);
var
  strCodIte: string;
  strDescri: string;
  fltUnitar: Double;
  strCodUni: string;
  fltQtdIte: Double;
  intBasCol: Integer;
  fltCnv_Ml: Double;
begin
  if fProcessaMovTin(tela, qryTinDet.FieldByName('CHAVE').AsString, fGetTabela(qryTinDet), fltTotSub) then
    Exit;

  if fTemMovTin(qryTinDet.FieldByName('DET_CODACA').AsString,
                qryTinDet.FieldByName('DET_EMPACA').AsString,
                fGetTabela(qryTinDet)) then
    Exit;

  strCodIte := '';
  fltQtdIte := 0;
  fltUnitar := 0;

  If (qryTinDet.FieldByName('DET_PROEMB').AsString = 'S') Then
  Begin
    GetDadosProdutos(qryTinDet.FieldByName('DET_ITEEMB').AsString,
      qryTinDet.FieldByName('DET_TABPRE').AsString,
      strDescri,
      strCodUni,
      fltCnv_Ml,
      fltUnitar);

    strCodIte := qryTinDet.FieldByName('DET_ITEEMB').AsString;
    fltQtdIte := qryTinDet.FieldByName('DET_QTDEMB').AsFloat;
  End
  Else If( fTipoTinta(qryTinDet.FieldByName('DET_IDEPRO').AsString) in [ttImobiliaria, ttIndustrial]) Then
  Begin
    if fEmptyStr(qryTinDet.FieldByName('DET_ITEEMB').AsString) then // não tem embalagem, então movimenta a propria base
    begin
      GetDadosProdutos(qryTinDet.FieldByName('DET_CODITE').AsString,
        qryTinDet.FieldByName('DET_TABPRE').AsString,
        strDescri,
        strCodUni,
        fltCnv_Ml,
        fltUnitar);

      strCodIte := qryTinDet.FieldByName('DET_CODITE').AsString;
      fltQtdIte := qryTinDet.FieldByName('DET_QTDITE').AsFloat;
    end;
  End;

  If Not fEmptyStr(strCodIte) Then
  begin
    tela.Texto := Format('Inserindo o produto %s - %s', [strCodIte, strDescri]);

    pAdicionaNaTemporariaNotaEspiritoSanto(strCodIte, strDescri, fltQtdIte, fltUnitar, strCodUni);

//    pAddItem(strCodIte, strDescri, fltQtdIte, fltUnitar, strCodUni);
  end;

  If (qryTinDet.FieldByName('DET_PROEMB').AsString <> 'S') Then
  Begin
    For intBasCol := 1 To 15 Do
    Begin
      If fEmptyStr(qryTinDet.FieldByName('DET_FORM' + fStrZero(intBasCol, 2)).AsString) Then
      Begin
        Break;
      End;

      If fEmptyStr((AnsiReplaceStr(qryTinDet.FieldByName('DET_FORM' + fStrZero(intBasCol, 2)).AsString, '_', ''))) Then
      Begin
        Break;
      End;

      If GetItemColorante(qryTinDet.FieldByName('DET_IDEPRO').AsString,
        qryTinDet.FieldByName('DET_FORM' + fStrZero(intBasCol, 2)).AsString,
        qryTinDet.FieldByName('DET_CODEMP').AsString,
        strCodIte,
        strDescri) Then
      Begin
        GetDadosProdutos(strCodIte,
          qryTinDet.FieldByName('DET_TABPRE').AsString,
          strDescri,
          strCodUni,
          fltCnv_Ml,
          fltUnitar);

        If fFormataFloat(fltCnv_Ml, 2) <= 0 Then
        Begin
          Raise Exception.Create('Item ' + strCOdIte + '-' + strDescri + ' está com o fator tintométrico preenchido incorretamente.' + #13#10 +
            'É necessário corrigir no cadastro de produtos.');
        End;

        fltUnitar := fFormataFloat(fltUnitar / fltCnv_Ml, 4);
        fltQtdIte := qryTinDet.FieldByName('DET_QTDB' + fStrZero(intBasCol, 2)).AsFloat;

        If fCfgSis('NFTIES') = '2' Then
        Begin
          fltUnitar := fltUnitar * fltCnv_Ml;
          fltQtdIte := fltQtdIte / fltCnv_Ml;
          strCodUni := qryTinDet.FieldByName('DET_UNIDAD').AsString;
        End;

        tela.Texto := Format('Inserindo o produto %s - %s', [strCodIte, strDescri]);

        pAdicionaNaTemporariaNotaEspiritoSanto(strCodIte, strDescri, fltQtdIte, fltUnitar, strCodUni);

//        pAddItem(strCodIte, strDescri, fltQtdIte, fltUnitar, strCodUni);
      End;
    End;
  End;
end;

end.
