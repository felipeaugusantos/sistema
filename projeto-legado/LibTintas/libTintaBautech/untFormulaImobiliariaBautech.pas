{***********************************************************************}
{* Classe responsável pelas rotidas especificas de uma formula Bautech *}
{********************************************************************PH*}
unit untFormulaImobiliariaBautech;

interface

uses
  untAbstractFormulaImobiliaria, untICalculadorFormulaImobiliaria, untIDataSet, untColorante,
  SysUtils, untStrUtils;

type
  TFormulaImobiliariaBautech = class(TAbstractFormulaImobiliaria)
  private
    function fRetProdutoBautech(strProdut: String): String;
  protected
    function GetCalculadorInterno(): ICalculadorFormulaImobiliaria; override;
    function GetNomeTabelaColorantes(): String; override;
    function GetTextoInformativoCalculo(): String; override;
    procedure CarregaPrecosColorantesAdicional(const dataSetColorantes: IDataSet; const colorante: TColorante); override;
    function GetNomeCampoCustoBase: String; override;
    function GetNomeCampoVendaBase: String; override;
    function GetNomeTabelaBase: String; override;
    function GetNomeCampoBaseCodIte: String; override;
  public
    function GetPrefixoQuantidade(const strModo: String): String; override;
    function GetQuantidadeFormulacao(): Integer; override;
    function GetPrefixoFormulacao(): String; override;
    function GetDescricao(const dtsCadTin: IDataSet): String; override;
    function GetUnidade(const dtsCadTin: IDataSet): String; override;
    function GetProdutoBaseFormula(const dtsCadTin: IDataSet): String; override;
    function GetFatorEstoque(): Double; override;
    function GetIdePro: String; override;
    function GetItemBaseOriginal(const strIteTin: String): String; override;
    function GetChaveIteTin(const dtsCadTin: IDataSet): string; override;
    function GetNomeCampoColDesCol: string; override;
    procedure PreencheAcrescimoMaoObra(const dtsCadTin: IDataSet); Override;
    procedure CarregarColorantes; Override;
  end;

implementation

uses
  untAbstractCalculadorFormulaImobiliaria, untAutcomTintaFactory;

{ TFormulaImobiliariaBautech }

procedure TFormulaImobiliariaBautech.CarregaPrecosColorantesAdicional(const dataSetColorantes: IDataSet; const colorante: TColorante);
begin
  colorante.Embalagem := dataSetColorantes.FieldByName('COL_EMBALA').AsFloat;
end;

procedure TFormulaImobiliariaBautech.CarregarColorantes;
var
  strSql: String;
begin
  strSql := ' SELECT         ' +
            '     COL_CODCOL ' +
            '   , COL_CODITE ' +
            '   , COL_EMBALA ';

  if GetNomeCampoColDesCol <> '' then
    strSql := strSql + ' , ' + GetNomeCampoColDesCol
  else
    strSql := strSql + ', "" AS COL_DESCRI ';

  strSql := strSql +
    '   , IFNULL(ITE_ITEATI, "N") ITE_ITEATI      ' +
    '   , ITE_CNV_ML ' +
    '   , ITE_OUTVAL ' +
    '   , ITE_ICMSAI ' +
    '   , ITE_IMPFED ' +
    '   , ITE_DESOPE ' +
    '   , ITE_PREMED ' +
    '   , ITE_IMPULT ' +
    '   , ITE_PREULT ' +
    '   , ITE_PRECOM ' +
    '   , ITE_DESF01 ' +
    '   , ITE_DESF02 ' +
    '   , ITE_DESF03 ' +
    '   , ITE_DESF04 ' +
    '   , ITE_DESF05 ' +
    '   , ITE_DESF06 ';

  If TAutcomTintaFactory.Get.fCfgSis('IMPDIG') = '1' Then
    strSql := strSql + '   , I.ITE_IMPDIR  '
  else
    strSql := strSql + '   , G.ITE_IMPDIR  ';

  If (TAutcomTintaFactory.Get.fCfgSis('PREGER') = '0') Then
  begin
    strSql := strSql +
      '   , COL_PRECUS AS ITE_PRECUS ' +
      '   , COL_PREVEN AS ITE_PREVEN ';
  end

  Else If (TAutcomTintaFactory.Get.fCfgSis('PREGER') = '1') And (BlnCalculaUnitario) Then
  begin
    strSql := strSql +
      '   , ITE_PRECUS               ' +
      '   , ITE_PREVE'+ TAutcomTintaFactory.Get.fCfgSis('TABPRE') + ' AS ITE_PREVEN ';
  end
  else
  begin
    strSql := strSql +
      '   , ITE_PRECUS               ' +
      '   , ITE_PREVE' + Self.strTabPre + ' AS ITE_PREVEN ';
  end;

  strSql := strSql +
    ' FROM                               ' +
    '   ' +     GetNomeTabelaColorantes + ' C ' +
    '   INNER JOIN ITEGER G              ' +
    '     ON C.COL_CODITE = G.ITE_CODITE ' +
    '   INNER JOIN CADITE I              ' +
    '     ON C.COL_CODITE = I.ITE_CODITE ' +
    ' WHERE G.ITE_CODEMP = :CODEMP       ';

  GetDataSetColorantes.SQL := strSql;

  If Not (TStrUtils.fEmptyStr(Self.EmpPrd)) And (Self.OprFlj = 'S') Then
    GetDataSetColorantes.ParamByName('CODEMP').AsString := Self.EmpPrd
  Else If Not (TStrUtils.fEmptyStr(Self.EmpCd_)) And (Self.Cd_S_N = 'S') Then
    GetDataSetColorantes.ParamByName('CODEMP').AsString := Self.EmpCd_
  Else If Not (TStrUtils.fEmptyStr(Self.EmpFat)) And (Self.FatS_N = 'S') Then
    GetDataSetColorantes.ParamByName('CODEMP').AsString := Self.EmpFat
  Else
    GetDataSetCOlorantes.ParamByName('CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;

  GetDataSetColorantes.Open;
end;

function TFormulaImobiliariaBautech.fRetProdutoBautech(
  strProdut: String): String;
begin
  Result := strProdut;

  If Pos('3,2', strProdut) > 0 Then
    Result := Copy(strProdut,1,Pos('3,2', strProdut) - 1)
  Else If Pos('16,2', strProdut) > 0 Then
    Result := Copy(strProdut,1,Pos('16,2', strProdut) - 1)
  Else If Pos('810', strProdut) > 0 Then
    Result := Copy(strProdut,1,Pos('810', strProdut) - 1);
end;

function TFormulaImobiliariaBautech.GetCalculadorInterno: ICalculadorFormulaImobiliaria;
begin
  Result := TAbstractCalculadorFormulaImobiliaria.Create(Self);
end;

function TFormulaImobiliariaBautech.GetChaveIteTin(const dtsCadTin: IDataSet): string;
begin
  if Assigned(dtsCadTin.FindField('BAU_MD5KEY')) then
    Result := dtsCadTin.FieldByName('BAU_MD5KEY').AsString
  else
  begin
    Result :=
      dtsCadTin.FieldByName('BAU_CODBAS').AsString + ' ' +
      dtsCadTin.FieldByName('BAU_UNIDAD').AsString +
      dtsCadTin.FieldByName('BAU_PRODUT').AsString;
  end;

end;

function TFormulaImobiliariaBautech.GetDescricao(const dtsCadTin: IDataSet): String;
begin
  Result := dtsCadTin.FieldByName('BAU_PRODUT').AsString;
end;

function TFormulaImobiliariaBautech.GetFatorEstoque: Double;
begin
  Result := 1;
end;

function TFormulaImobiliariaBautech.GetIdePro: String;
begin
  Result := 'BAU';
end;

function TFormulaImobiliariaBautech.GetItemBaseOriginal(const strIteTin: String): String;
var
  qryGen: IDataSet;
begin
  qryGen := nil;
  Result := '';
  Try
    Try
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      qryGen.SQL :=
        ' SELECT                                ' +
        '   B.BAS_CODITE AS CODITE              ' +
        ' FROM                                  ' +
        '   BAU_CADBAS B                        ' +
        '   INNER JOIN BAU_CADBAU S             ' +
        '      ON B.BAS_CODBAS = S.BAU_CODBAS   ' +
        '     AND B.BAS_CODUNI = S.BAU_CODUNI   ' +
        '     AND B.BAS_DESCRI = S.BAU_PRODUT   ' +
        ' WHERE CONCAT(                         ' +
        '       S.BAU_CODBAS                    ' +
        '     , " "                             ' +
        '     , S.BAU_UNIDAD                    ' +
        '     , S.BAU_DESCRI                    ' +
        '   ) = :ITETIN                         ';
      qryGen.ParamByName('ITETIN').AsString := strIteTin;
      qryGen.Open;

      if qryGen.IsEmpty then
      begin
        qryGen.SQL :=
          ' SELECT                                ' +
          '   B.BAS_CODITE AS CODITE              ' +
          ' FROM                                  ' +
          '   BAU_CADBAS B                        ' +
          '   INNER JOIN BAU_CADBAU S             ' +
          '      ON B.BAS_CODBAS = S.BAU_CODBAS   ' +
          '     AND B.BAS_CODUNI = S.BAU_CODUNI   ' +
          '     AND B.BAS_DESCRI = S.BAU_PRODUT   ' +
          ' WHERE CONCAT(S.BAU_UNIDAD, S.BAU_DESCRI) = :ITETIN ';
        qryGen.ParamByName('ITETIN').AsString := strIteTin;
        qryGen.Open;

        if qryGen.IsEmpty then
        begin
          qryGen.SQL :=
            ' SELECT                                ' +
            '   B.BAS_CODITE AS CODITE              ' +
            ' FROM                                  ' +
            '   BAU_CADBAS B                        ' +
            '   INNER JOIN BAU_CADBAU S             ' +
            '      ON B.BAS_CODBAS = S.BAU_CODBAS   ' +
            '     AND B.BAS_CODUNI = S.BAU_CODUNI   ' +
            '     AND B.BAS_DESCRI = S.BAU_PRODUT   ' +
            ' WHERE CONCAT(S.BAU_DESCRI, " ", S.BAU_CODBAS, " ", S.BAU_UNIDAD) = :ITETIN ';
          qryGen.ParamByName('ITETIN').AsString := strIteTin;
          qryGen.Open;

          if qryGen.IsEmpty then
          begin
            qryGen.SQL :=
              ' SELECT                                                     ' +
              '   B.BAS_CODITE AS CODITE                                   ' +
              ' FROM                                                       ' +
              '   BAU_CADBAS B                                             ' +
              '   INNER JOIN BAU_CADBAU S                                  ' +
              '      ON B.BAS_CODBAS = S.BAU_CODBAS                        ' +
              '     AND B.BAS_CODUNI = S.BAU_CODUNI                        ' +
              '     AND B.BAS_DESCRI = S.BAU_PRODUT                        ' +
              ' WHERE UPPER(CAST(MD5(CONCAT(                               ' +
              '           CAST(IFNULL(BAU_FORM01, '''') AS CHAR)           ' +
              '           , CAST(FORMAT(IFNULL(BAU_QTDB01, 0), 4) AS CHAR) ' +
              '           , CAST(IFNULL(BAU_FORM02, '''') AS CHAR)         ' +
              '           , CAST(FORMAT(IFNULL(BAU_QTDB02, 0), 4) AS CHAR) ' +
              '           , CAST(IFNULL(BAU_FORM03, '''') AS CHAR)         ' +
              '           , CAST(FORMAT(IFNULL(BAU_QTDB03, 0), 4) AS CHAR) ' +
              '           , CAST(IFNULL(BAU_FORM04, '''') AS CHAR)         ' +
              '           , CAST(FORMAT(IFNULL(BAU_QTDB04, 0), 4) AS CHAR) ' +
              '           , CAST(IFNULL(BAU_FORM05, '''') AS CHAR)         ' +
              '           , CAST(FORMAT(IFNULL(BAU_QTDB05, 0), 4) AS CHAR) ' +
              '           , CAST(IFNULL(BAU_FORM06, '''') AS CHAR)         ' +
              '           , CAST(FORMAT(IFNULL(BAU_QTDB06, 0), 4) AS CHAR) ' +
              '           , CAST(IFNULL(BAU_FORM07, '''') AS CHAR)         ' +
              '           , CAST(FORMAT(IFNULL(BAU_QTDB07, 0), 4) AS CHAR) ' +
              '           , CAST(IFNULL(BAU_FORM08, '''') AS CHAR)         ' +
              '           , CAST(FORMAT(IFNULL(BAU_QTDB08, 0), 4) AS CHAR) ' +
              '           , CAST(IFNULL(BAU_FORM09, '''') AS CHAR)         ' +
              '           , CAST(FORMAT(IFNULL(BAU_QTDB09, 0), 4) AS CHAR) ' +
              '           , CAST(IFNULL(BAU_FORM10, '''') AS CHAR)         ' +
              '           , CAST(FORMAT(IFNULL(BAU_QTDB10, 0), 4) AS CHAR) ' +
              '           , CAST(IFNULL(BAU_FORM11, '''') AS CHAR)         ' +
              '           , CAST(FORMAT(IFNULL(BAU_QTDB11, 0), 4) AS CHAR) ' +
              '           , CAST(IFNULL(BAU_FORM12, '''') AS CHAR)         ' +
              '           , CAST(FORMAT(IFNULL(BAU_QTDB12, 0), 4) AS CHAR) ' +
              '           , CAST(IFNULL(BAU_FORM13, '''') AS CHAR)         ' +
              '           , CAST(FORMAT(IFNULL(BAU_QTDB13, 0), 4) AS CHAR) ' +
              '           , CAST(IFNULL(BAU_FORM14, '''') AS CHAR)         ' +
              '           , CAST(FORMAT(IFNULL(BAU_QTDB14, 0), 4) AS CHAR) ' +
              '           , CAST(IFNULL(BAU_FORM15, '''') AS CHAR)         ' +
              '           , CAST(FORMAT(IFNULL(BAU_QTDB15, 0), 4) AS CHAR) ' +
              '         )) AS CHAR)) = :ITETIN                             ';
            qryGen.ParamByName('ITETIN').AsString := strIteTin;
            qryGen.Open;
            if qryGen.IsEmpty then
            begin
              qryGen.SQL :=
                ' SELECT                                                     ' +
                '   B.BAS_CODITE AS CODITE                                   ' +
                ' FROM                                                       ' +
                '   BAU_CADBAS B                                             ' +
                '   INNER JOIN BAU_CADBAU S                                  ' +
                '     ON  B.BAS_CODBAS = S.BAU_CODBAS                        ' +
                '     AND B.BAS_CODUNI = S.BAU_CODUNI                        ' +
                '     AND B.BAS_DESCRI = S.BAU_PRODUT                        ' +
                ' WHERE UPPER(CAST(MD5(CONCAT(                               ' +
                '           CAST(IFNULL(BAU_FORM01, '''') AS CHAR)           ' +
                '           , CAST(FORMAT(IFNULL(BAU_QTDB01, 0), 4) AS CHAR) ' +
                '           , CAST(IFNULL(BAU_FORM02, '''') AS CHAR)         ' +
                '           , CAST(FORMAT(IFNULL(BAU_QTDB02, 0), 4) AS CHAR) ' +
                '           , CAST(IFNULL(BAU_FORM03, '''') AS CHAR)         ' +
                '           , CAST(FORMAT(IFNULL(BAU_QTDB03, 0), 4) AS CHAR) ' +
                '           , CAST(IFNULL(BAU_FORM04, '''') AS CHAR)         ' +
                '           , CAST(FORMAT(IFNULL(BAU_QTDB04, 0), 4) AS CHAR) ' +
                '           , CAST(IFNULL(BAU_FORM05, '''') AS CHAR)         ' +
                '           , CAST(FORMAT(IFNULL(BAU_QTDB05, 0), 4) AS CHAR) ' +
                '           , CAST(IFNULL(BAU_FORM06, '''') AS CHAR)         ' +
                '           , CAST(FORMAT(IFNULL(BAU_QTDB06, 0), 4) AS CHAR) ' +
                '           , CAST(IFNULL(BAU_FORM07, '''') AS CHAR)         ' +
                '           , CAST(FORMAT(IFNULL(BAU_QTDB07, 0), 4) AS CHAR) ' +
                '           , CAST(IFNULL(BAU_FORM08, '''') AS CHAR)         ' +
                '           , CAST(FORMAT(IFNULL(BAU_QTDB08, 0), 4) AS CHAR) ' +
                '           , CAST(IFNULL(BAU_FORM09, '''') AS CHAR)         ' +
                '           , CAST(FORMAT(IFNULL(BAU_QTDB09, 0), 4) AS CHAR) ' +
                '           , CAST(IFNULL(BAU_FORM10, '''') AS CHAR)         ' +
                '           , CAST(FORMAT(IFNULL(BAU_QTDB10, 0), 4) AS CHAR) ' +
                '           , CAST(IFNULL(BAU_FORM11, '''') AS CHAR)         ' +
                '           , CAST(FORMAT(IFNULL(BAU_QTDB11, 0), 4) AS CHAR) ' +
                '           , CAST(IFNULL(BAU_FORM12, '''') AS CHAR)         ' +
                '           , CAST(FORMAT(IFNULL(BAU_QTDB12, 0), 4) AS CHAR) ' +
                '           , CAST(IFNULL(BAU_FORM13, '''') AS CHAR)         ' +
                '           , CAST(FORMAT(IFNULL(BAU_QTDB13, 0), 4) AS CHAR) ' +
                '           , CAST(IFNULL(BAU_FORM14, '''') AS CHAR)         ' +
                '           , CAST(FORMAT(IFNULL(BAU_QTDB14, 0), 4) AS CHAR) ' +
                '           , CAST(IFNULL(BAU_FORM15, '''') AS CHAR)         ' +
                '           , CAST(FORMAT(IFNULL(BAU_QTDB15, 0), 4) AS CHAR) ' +
                '           , CAST(IFNULL(BAU_FORM16, '''') AS CHAR)         ' +
                '           , CAST(FORMAT(IFNULL(BAU_QTDB16, 0), 4) AS CHAR) ' +
                '           , CAST(IFNULL(BAU_FORM17, '''') AS CHAR)         ' +
                '           , CAST(FORMAT(IFNULL(BAU_QTDB17, 0), 4) AS CHAR) ' +
                '           , CAST(IFNULL(BAU_FORM18, '''') AS CHAR)         ' +
                '           , CAST(FORMAT(IFNULL(BAU_QTDB18, 0), 4) AS CHAR) ' +
                '           , CAST(IFNULL(BAU_FORM19, '''') AS CHAR)         ' +
                '           , CAST(FORMAT(IFNULL(BAU_QTDB19, 0), 4) AS CHAR) ' +
                '           , CAST(IFNULL(BAU_FORM20, '''') AS CHAR)         ' +
                '           , CAST(FORMAT(IFNULL(BAU_QTDB20, 0), 4) AS CHAR) ' +
                '         )) AS CHAR)) = :ITETIN                             ';
              qryGen.ParamByName('ITETIN').AsString := strIteTin;
              qryGen.Open;
            end;
          end;
        end;
      end;

      if not qryGen.IsEmpty then
        Result := qryGen.FieldByName('CODITE').AsString;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
  End;
end;

function TFormulaImobiliariaBautech.GetNomeCampoBaseCodIte: String;
begin
  Result := 'BAS_CODITE';
end;

function TFormulaImobiliariaBautech.GetNomeCampoCustoBase: String;
begin
  Result := 'BAS_PRECUS';
end;

function TFormulaImobiliariaBautech.GetNomeCampoVendaBase: String;
begin
  Result := 'BAS_PREVEN';
end;

function TFormulaImobiliariaBautech.GetNomeTabelaBase: String;
begin
  Result := 'BAU_CADBAS';
end;

function TFormulaImobiliariaBautech.GetNomeCampoColDesCol: string;
begin
  Result := 'COL_DESCRI';
end;

function TFormulaImobiliariaBautech.GetNomeTabelaColorantes: String;
begin
  Result := 'BAU_CADCOL';
end;

function TFormulaImobiliariaBautech.GetPrefixoFormulacao: String;
begin
  Result := 'BAU_FORM';
end;

function TFormulaImobiliariaBautech.GetPrefixoQuantidade(const strModo: String): String;
begin
  Result := 'BAU_QTDB';
end;

function TFormulaImobiliariaBautech.GetProdutoBaseFormula(const dtsCadTin: IDataSet): String;
var
  dtsGen: IDataSet;
begin
  Try
    Try
      dtsGen := TAutcomTintaFactory.Get.fGetDataSet;
      dtsGen.SQL :=
        ' SELECT                     ' +
        '   BAS_CODITE               ' +
        ' FROM                       ' +
        '   BAU_CADBAS               ' +
        ' WHERE BAS_CODBAS = :CODBAS ' +
        '   AND BAS_CODUNI = :CODUNI ' +
        '   AND BAS_DESCRI LIKE :DESCRI ' ;

      dtsGen.ParamByName('CODBAS').AsString := dtsCadTin.FieldByName('BAU_CODBAS').AsString;
      dtsGen.ParamByName('CODUNI').AsString := dtsCadTin.FieldByName('BAU_CODUNI').AsString;
      dtsGen.ParamByName('DESCRI').AsString := '%' + fRetProdutoBautech(dtsCadTin.FieldByName('BAU_PRODUT').AsString) + '%';
      dtsGen.Open;

      Result := dtsGen.FieldByName('BAS_CODITE').AsString;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
  End;
end;

function TFormulaImobiliariaBautech.GetQuantidadeFormulacao: Integer;
begin
  Result := 20;
end;

function TFormulaImobiliariaBautech.GetTextoInformativoCalculo: String;
begin
  Result :=
    'Valor da Base = ' + FloatToStrF(BasePrecoVenda, ffFixed, 12, 2) + sLineBreak +
    'Valor do Colorante = Quantidade * (Preço / Embalagem) ' + sLineBreak +
    'Valor da Tinta = Valor da Base + (Soma do Valor do Colorante de todos os Colorantes)';
end;

function TFormulaImobiliariaBautech.GetUnidade(const dtsCadTin: IDataSet): String;
begin
  Result := dtsCadTin.FieldByName('BAU_CODUNI').AsString;
end;

procedure TFormulaImobiliariaBautech.PreencheAcrescimoMaoObra(
  const dtsCadTin: IDataSet);
begin
  Self.AcrMob := dtsCadTin.FieldByName('BAU_ACRMOB').AsFloat;
end;

end.
