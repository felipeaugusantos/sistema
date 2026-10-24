{***********************************************************************}
{* Classe responsável pelas rotidas especificas de uma formula QualyVinil *}
{********************************************************************PH*}
unit untFormulaImobiliariaQualyVinil;

interface

uses
  untAbstractFormulaImobiliaria, untICalculadorFormulaImobiliaria, untIDataSet, untColorante,
  SysUtils, untStrUtils;

type
  TFormulaImobiliariaQualyVinil = class(TAbstractFormulaImobiliaria)
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
    function fMostraQuantidadeEmOnca(Var strOnca: String;
      const fltQtdCol: Double): Boolean; override;
    procedure CarregarColorantes; override;
    procedure PreencheAcrescimoMaoObra(const dtsCadTin: IDataSet); Override;
  end;

implementation

uses
  untAbstractCalculadorFormulaImobiliaria, untAutcomTintaFactory, untLibTintaFactory;

{ TFormulaImobiliariaQualyVinil }

procedure TFormulaImobiliariaQualyVinil.CarregaPrecosColorantesAdicional(const dataSetColorantes: IDataSet; const colorante: TColorante);
begin
  colorante.Embalagem := dataSetColorantes.FieldByName('COL_EMBALA').AsFloat;
end;

procedure TFormulaImobiliariaQualyVinil.CarregarColorantes;
var
  strSql: String;
begin
  strSql := ' SELECT         ' +
            '     COL_CODCOL ' +
            '   , COL_CODITE ' +
            '   , COL_EMBALA ' ;

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

  Else If (TAutcomTintaFactory.Get.fCfgSis('PREGER') = '1') And BlnCalculaUnitario Then
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

  If (Not TStrUtils.fEmptyStr(Self.EmpPrd)) And (Self.OprFlj = 'S') Then
    GetDataSetColorantes.ParamByName('CODEMP').AsString := Self.EmpPrd
  Else If (Not TStrUtils.fEmptyStr(Self.EmpCd_)) And (Self.Cd_S_N = 'S') Then
    GetDataSetColorantes.ParamByName('CODEMP').AsString := Self.EmpCd_
  Else If (Not TStrUtils.fEmptyStr(Self.EmpFat)) And (Self.FatS_N = 'S') Then
    GetDataSetColorantes.ParamByName('CODEMP').AsString := Self.EmpFat
  Else
    GetDataSetColorantes.ParamByName('CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;

  GetDataSetColorantes.Open;

end;

function TFormulaImobiliariaQualyVinil.fMostraQuantidadeEmOnca(
  var strOnca: String; const fltQtdCol: Double): Boolean;
begin
  Result := False;

  //strOnca := TLibTintaFactory.GetLibTinta.MlParaOnca(fltQtdCol);
end;

function TFormulaImobiliariaQualyVinil.GetCalculadorInterno: ICalculadorFormulaImobiliaria;
begin
  Result := TAbstractCalculadorFormulaImobiliaria.Create(Self);
end;

function TFormulaImobiliariaQualyVinil.GetChaveIteTin(const dtsCadTin: IDataSet): string;
begin
  if Assigned(dtsCadTin.FindField('QUA_MD5KEY')) then
    Result := dtsCadTin.FieldByName('QUA_MD5KEY').AsString
  else
  begin
    Result :=
      dtsCadTin.FieldByName('QUA_CODBAS').AsString+
      dtsCadTin.FieldByName('QUA_PRODUT').AsString+
      dtsCadTin.FieldByName('QUA_DESCRI').AsString+
      dtsCadTin.FieldByName('QUA_NOMCOR').AsString+
      dtsCadTin.FieldByName('QUA_CODUNI').AsString;


  end;

end;

function TFormulaImobiliariaQualyVinil.GetDescricao(const dtsCadTin: IDataSet): String;
begin
  Result := dtsCadTin.FieldByName('QUA_PRODUT').AsString;
end;

function TFormulaImobiliariaQualyVinil.GetFatorEstoque: Double;
begin
  Result := 1;
end;

function TFormulaImobiliariaQualyVinil.GetIdePro: String;
begin
  Result := 'QUA';
end;

function TFormulaImobiliariaQualyVinil.GetItemBaseOriginal(const strIteTin: String): String;
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
        '   QUA_CADBAS B                        ' +
        '   INNER JOIN QUA_CADQUA S             ' +
        '      ON B.BAS_CODBAS = S.QUA_CODBAS   ' +
        '     AND B.BAS_CODUNI = S.QUA_CODUNI   ' +
        '     AND B.BAS_PRODUT = S.QUA_PRODUT   ' +
        ' WHERE CONCAT(                         ' +
        '       S.QUA_CODBAS                    ' +
        '     , " "                             ' +
        '     , S.QUA_CODUNI                    ' +
        '     , S.QUA_PRODUT                    ' +
        '   ) = :ITETIN                         ';
      qryGen.ParamByName('ITETIN').AsString := strIteTin;
      qryGen.Open;

      if qryGen.IsEmpty then
      begin
        qryGen.SQL :=
          ' SELECT                                ' +
          '   B.BAS_CODITE AS CODITE              ' +
          ' FROM                                  ' +
          '   QUA_CADBAS B                        ' +
          '   INNER JOIN QUA_CADQUA S             ' +
          '      ON B.BAS_CODBAS = S.QUA_CODBAS   ' +
          '     AND B.BAS_CODUNI = S.QUA_CODUNI   ' +
          '     AND B.BAS_PRODUT = S.QUA_PRODUT   ' +
          ' WHERE CONCAT(S.QUA_CODUNI, S.QUA_PRODUT) = :ITETIN ';
        qryGen.ParamByName('ITETIN').AsString := strIteTin;
        qryGen.Open;

        if qryGen.IsEmpty then
        begin
          qryGen.SQL :=
            ' SELECT                                ' +
            '   B.BAS_CODITE AS CODITE              ' +
            ' FROM                                  ' +
            '   QUA_CADBAS B                        ' +
            '   INNER JOIN QUA_CADQUA S             ' +
            '      ON B.BAS_CODBAS = S.QUA_CODBAS   ' +
            '     AND B.BAS_CODUNI = S.QUA_CODUNI   ' +
            '     AND B.BAS_PRODUT = S.QUA_PRODUT   ' +
            ' WHERE CONCAT(S.QUA_PRODUT, " ", S.QUA_CODBAS, " ", S.QUA_CODUNI) = :ITETIN ';
          qryGen.ParamByName('ITETIN').AsString := strIteTin;
          qryGen.Open;

          if qryGen.IsEmpty then
          begin
            qryGen.SQL :=
              ' SELECT                                                     ' +
              '   B.BAS_CODITE AS CODITE                                   ' +
              ' FROM                                                       ' +
              '   QUA_CADBAS B                                             ' +
              '   INNER JOIN QUA_CADQUA S                                  ' +
              '      ON B.BAS_CODBAS = S.QUA_CODBAS                        ' +
              '     AND B.BAS_CODUNI = S.QUA_CODUNI                        ' +
              '     AND B.BAS_PRODUT = S.QUA_PRODUT                        ' +
              ' WHERE UPPER(CAST(MD5(CONCAT(                               ' +
              '           CAST(IFNULL(QUA_FORM01, '''') AS CHAR)           ' +
              '           , CAST(FORMAT(IFNULL(QUA_QTDB01, 0), 4) AS CHAR) ' +
              '           , CAST(IFNULL(QUA_FORM02, '''') AS CHAR)         ' +
              '           , CAST(FORMAT(IFNULL(QUA_QTDB02, 0), 4) AS CHAR) ' +
              '           , CAST(IFNULL(QUA_FORM03, '''') AS CHAR)         ' +
              '           , CAST(FORMAT(IFNULL(QUA_QTDB03, 0), 4) AS CHAR) ' +
              '           , CAST(IFNULL(QUA_FORM04, '''') AS CHAR)         ' +
              '           , CAST(FORMAT(IFNULL(QUA_QTDB04, 0), 4) AS CHAR) ' +
              '           , CAST(IFNULL(QUA_FORM05, '''') AS CHAR)         ' +
              '           , CAST(FORMAT(IFNULL(QUA_QTDB05, 0), 4) AS CHAR) ' +
              '           , CAST(IFNULL(QUA_FORM06, '''') AS CHAR)         ' +
              '           , CAST(FORMAT(IFNULL(QUA_QTDB06, 0), 4) AS CHAR) ' +
              '           , CAST(IFNULL(QUA_FORM07, '''') AS CHAR)         ' +
              '           , CAST(FORMAT(IFNULL(QUA_QTDB07, 0), 4) AS CHAR) ' +
              '           , CAST(IFNULL(QUA_FORM08, '''') AS CHAR)         ' +
              '           , CAST(FORMAT(IFNULL(QUA_QTDB08, 0), 4) AS CHAR) ' +
              '           , CAST(IFNULL(QUA_FORM09, '''') AS CHAR)         ' +
              '           , CAST(FORMAT(IFNULL(QUA_QTDB09, 0), 4) AS CHAR) ' +
              '           , CAST(IFNULL(QUA_FORM10, '''') AS CHAR)         ' +
              '           , CAST(FORMAT(IFNULL(QUA_QTDB10, 0), 4) AS CHAR) ' +
              '           , CAST(IFNULL(QUA_FORM11, '''') AS CHAR)         ' +
              '           , CAST(FORMAT(IFNULL(QUA_QTDB11, 0), 4) AS CHAR) ' +
              '           , CAST(IFNULL(QUA_FORM12, '''') AS CHAR)         ' +
              '           , CAST(FORMAT(IFNULL(QUA_QTDB12, 0), 4) AS CHAR) ' +
              '           , CAST(IFNULL(QUA_FORM13, '''') AS CHAR)         ' +
              '           , CAST(FORMAT(IFNULL(QUA_QTDB13, 0), 4) AS CHAR) ' +
              '           , CAST(IFNULL(QUA_FORM14, '''') AS CHAR)         ' +
              '           , CAST(FORMAT(IFNULL(QUA_QTDB14, 0), 4) AS CHAR) ' +
              '           , CAST(IFNULL(QUA_FORM15, '''') AS CHAR)         ' +
              '           , CAST(FORMAT(IFNULL(QUA_QTDB15, 0), 4) AS CHAR) ' +
              '         )) AS CHAR)) = :ITETIN                             ';
            qryGen.ParamByName('ITETIN').AsString := strIteTin;
            qryGen.Open;
            if qryGen.IsEmpty then
            begin
              qryGen.SQL :=
                ' SELECT                                                     ' +
                '   B.BAS_CODITE AS CODITE                                   ' +
                ' FROM                                                       ' +
                '   QUA_CADBAS B                                             ' +
                '   INNER JOIN QUA_CADQUA S                                  ' +
                '     ON  B.BAS_CODBAS = S.QUA_CODBAS                        ' +
                '     AND B.BAS_CODUNI = S.QUA_CODUNI                        ' +
                '     AND B.BAS_PRODUT = S.QUA_PRODUT                        ' +
                ' WHERE UPPER(CAST(MD5(CONCAT(                               ' +
                '           CAST(IFNULL(QUA_FORM01, '''') AS CHAR)           ' +
                '           , CAST(FORMAT(IFNULL(QUA_QTDB01, 0), 4) AS CHAR) ' +
                '           , CAST(IFNULL(QUA_FORM02, '''') AS CHAR)         ' +
                '           , CAST(FORMAT(IFNULL(QUA_QTDB02, 0), 4) AS CHAR) ' +
                '           , CAST(IFNULL(QUA_FORM03, '''') AS CHAR)         ' +
                '           , CAST(FORMAT(IFNULL(QUA_QTDB03, 0), 4) AS CHAR) ' +
                '           , CAST(IFNULL(QUA_FORM04, '''') AS CHAR)         ' +
                '           , CAST(FORMAT(IFNULL(QUA_QTDB04, 0), 4) AS CHAR) ' +
                '           , CAST(IFNULL(QUA_FORM05, '''') AS CHAR)         ' +
                '           , CAST(FORMAT(IFNULL(QUA_QTDB05, 0), 4) AS CHAR) ' +
                '           , CAST(IFNULL(QUA_FORM06, '''') AS CHAR)         ' +
                '           , CAST(FORMAT(IFNULL(QUA_QTDB06, 0), 4) AS CHAR) ' +
                '           , CAST(IFNULL(QUA_FORM07, '''') AS CHAR)         ' +
                '           , CAST(FORMAT(IFNULL(QUA_QTDB07, 0), 4) AS CHAR) ' +
                '           , CAST(IFNULL(QUA_FORM08, '''') AS CHAR)         ' +
                '           , CAST(FORMAT(IFNULL(QUA_QTDB08, 0), 4) AS CHAR) ' +
                '           , CAST(IFNULL(QUA_FORM09, '''') AS CHAR)         ' +
                '           , CAST(FORMAT(IFNULL(QUA_QTDB09, 0), 4) AS CHAR) ' +
                '           , CAST(IFNULL(QUA_FORM10, '''') AS CHAR)         ' +
                '           , CAST(FORMAT(IFNULL(QUA_QTDB10, 0), 4) AS CHAR) ' +
                '           , CAST(IFNULL(QUA_FORM11, '''') AS CHAR)         ' +
                '           , CAST(FORMAT(IFNULL(QUA_QTDB11, 0), 4) AS CHAR) ' +
                '           , CAST(IFNULL(QUA_FORM12, '''') AS CHAR)         ' +
                '           , CAST(FORMAT(IFNULL(QUA_QTDB12, 0), 4) AS CHAR) ' +
                '           , CAST(IFNULL(QUA_FORM13, '''') AS CHAR)         ' +
                '           , CAST(FORMAT(IFNULL(QUA_QTDB13, 0), 4) AS CHAR) ' +
                '           , CAST(IFNULL(QUA_FORM14, '''') AS CHAR)         ' +
                '           , CAST(FORMAT(IFNULL(QUA_QTDB14, 0), 4) AS CHAR) ' +
                '           , CAST(IFNULL(QUA_FORM15, '''') AS CHAR)         ' +
                '           , CAST(FORMAT(IFNULL(QUA_QTDB15, 0), 4) AS CHAR) ' +
                '           , CAST(IFNULL(QUA_FORM16, '''') AS CHAR)         ' +
                '           , CAST(FORMAT(IFNULL(QUA_QTDB16, 0), 4) AS CHAR) ' +
                '           , CAST(IFNULL(QUA_FORM17, '''') AS CHAR)         ' +
                '           , CAST(FORMAT(IFNULL(QUA_QTDB17, 0), 4) AS CHAR) ' +
                '           , CAST(IFNULL(QUA_FORM18, '''') AS CHAR)         ' +
                '           , CAST(FORMAT(IFNULL(QUA_QTDB18, 0), 4) AS CHAR) ' +
                '           , CAST(IFNULL(QUA_FORM19, '''') AS CHAR)         ' +
                '           , CAST(FORMAT(IFNULL(QUA_QTDB19, 0), 4) AS CHAR) ' +
                '           , CAST(IFNULL(QUA_FORM20, '''') AS CHAR)         ' +
                '           , CAST(FORMAT(IFNULL(QUA_QTDB20, 0), 4) AS CHAR) ' +
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

function TFormulaImobiliariaQualyVinil.GetNomeCampoBaseCodIte: String;
begin
  Result := 'BAS_CODITE';
end;

function TFormulaImobiliariaQualyVinil.GetNomeCampoCustoBase: String;
begin
  Result := 'BAS_PRECUS';
end;

function TFormulaImobiliariaQualyVinil.GetNomeCampoVendaBase: String;
begin
  Result := 'BAS_PREVEN';
end;

function TFormulaImobiliariaQualyVinil.GetNomeTabelaBase: String;
begin
  Result := 'QUA_CADBAS';
end;

function TFormulaImobiliariaQualyVinil.GetNomeCampoColDesCol: string;
begin
  Result := 'COL_DESCRI';
end;

function TFormulaImobiliariaQualyVinil.GetNomeTabelaColorantes: String;
begin
  Result := 'QUA_CADCOL';
end;

function TFormulaImobiliariaQualyVinil.GetPrefixoFormulacao: String;
begin
  Result := 'QUA_FORM';
end;

function TFormulaImobiliariaQualyVinil.GetPrefixoQuantidade(const strModo: String): String;
begin
  Result := 'QUA_QTDB';
end;

function TFormulaImobiliariaQualyVinil.GetProdutoBaseFormula(const dtsCadTin: IDataSet): String;
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
        '   QUA_CADBAS               ' +
        ' WHERE BAS_CODBAS = :CODBAS ' +
        '   AND BAS_CODUNI = :CODUNI ' +
        '   AND BAS_PRODUT = :PRODUT ' ;

      dtsGen.ParamByName('CODBAS').AsString := dtsCadTin.FieldByName('QUA_CODBAS').AsString;
      dtsGen.ParamByName('CODUNI').AsString := dtsCadTin.FieldByName('QUA_CODUNI').AsString;
      dtsGen.ParamByName('PRODUT').AsString := dtsCadTin.FieldByName('QUA_PRODUT').AsString;
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

function TFormulaImobiliariaQualyVinil.GetQuantidadeFormulacao: Integer;
begin
  Result := 20;
end;

function TFormulaImobiliariaQualyVinil.GetTextoInformativoCalculo: String;
begin
  Result :=
    'Valor da Base    = ' + FloatToStrF(BasePrecoVenda, ffFixed, 12, 2) + sLineBreak +
    'Valor Colorantes = (Preço / Embalagem ) * Quantidade ' + sLineBreak +
    'Valor da Tinta   = Valor da Base + (Soma do Valor dos Colorantes)';
end;

function TFormulaImobiliariaQualyVinil.GetUnidade(const dtsCadTin: IDataSet): String;
begin
  Result := dtsCadTin.FieldByName('QUA_CODUNI').AsString;
end;

procedure TFormulaImobiliariaQualyVinil.PreencheAcrescimoMaoObra(
  const dtsCadTin: IDataSet);
begin
  Self.AcrMob := dtsCadTin.FieldByName('QUA_ACRMOB').AsFloat;
end;

end.
