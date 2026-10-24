{***********************************************************************}
{* Classe responsável pelas rotidas especificas de uma formula Ciacollor *}
{********************************************************************PH*}
unit untFormulaImobiliariaCiacollor;

interface

uses
  untAbstractFormulaImobiliaria, untICalculadorFormulaImobiliaria, untIDataSet, untColorante,
  SysUtils, untStrUtils;

type
  TFormulaImobiliariaCiacollor = class(TAbstractFormulaImobiliaria)
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

{ TFormulaImobiliariaCiacollor }

procedure TFormulaImobiliariaCiacollor.CarregaPrecosColorantesAdicional(const dataSetColorantes: IDataSet; const colorante: TColorante);
begin
  colorante.Embalagem := dataSetColorantes.FieldByName('COL_EMBALA').AsFloat;
end;

procedure TFormulaImobiliariaCiacollor.CarregarColorantes;
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

function TFormulaImobiliariaCiacollor.GetCalculadorInterno: ICalculadorFormulaImobiliaria;
begin
  Result := TAbstractCalculadorFormulaImobiliaria.Create(Self);
end;

function TFormulaImobiliariaCiacollor.GetChaveIteTin(const dtsCadTin: IDataSet): string;
begin
  if Assigned(dtsCadTin.FindField('CIA_MD5KEY')) then
    Result := dtsCadTin.FieldByName('CIA_MD5KEY').AsString
  else
  begin
    Result :=
      dtsCadTin.FieldByName('CIA_CODBAS').AsString + ' ' +
      dtsCadTin.FieldByName('CIA_UNIDAD').AsString +
      dtsCadTin.FieldByName('CIA_PRODUT').AsString;
  end;

end;

function TFormulaImobiliariaCiacollor.GetDescricao(const dtsCadTin: IDataSet): String;
begin
  Result := dtsCadTin.FieldByName('CIA_PRODUT').AsString;
end;

function TFormulaImobiliariaCiacollor.GetFatorEstoque: Double;
begin
  Result := 1;
end;

function TFormulaImobiliariaCiacollor.GetIdePro: String;
begin
  Result := 'CIA';
end;

function TFormulaImobiliariaCiacollor.GetItemBaseOriginal(const strIteTin: String): String;
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
        '   CIA_CADBAS B                        ' +
        '   INNER JOIN CIA_CADCIA S             ' +
        '      ON B.BAS_CODBAS = S.CIA_CODBAS   ' +
        '     AND B.BAS_CODUNI = S.CIA_CODUNI   ' +
        '     AND B.BAS_PRODUT = S.CIA_PRODUT   ' +
        '     AND B.BAS_VOLUME = S.CIA_VOLUME   ' +
        ' WHERE CIA_MD5KEY = :ITETIN            ';
      qryGen.ParamByName('ITETIN').AsString := strIteTin;
      qryGen.Open;

      If qryGen.IsEmpty Then
      Begin
        qryGen.SQL :=
          ' SELECT                                ' +
          '   B.BAS_CODITE AS CODITE              ' +
          ' FROM                                  ' +
          '   CIA_CADBAS B                        ' +
          '   INNER JOIN CIA_CADCIA S             ' +
          '      ON B.BAS_CODBAS = S.CIA_CODBAS   ' +
          '     AND B.BAS_CODUNI = S.CIA_CODUNI   ' +
          '     AND B.BAS_PRODUT = S.CIA_PRODUT   ' +
          '     AND B.BAS_VOLUME = S.CIA_VOLUME   ' +
          ' WHERE CONCAT(                         ' +
          '       S.CIA_CODBAS                    ' +
          '     , " "                             ' +
          '     , S.CIA_UNIDAD                    ' +
          '     , S.CIA_DESCRI                    ' +
          '   ) = :ITETIN                         ';
        qryGen.ParamByName('ITETIN').AsString := strIteTin;
        qryGen.Open;

        If qryGen.IsEmpty Then
        Begin
          qryGen.SQL :=
            ' SELECT                                ' +
            '   B.BAS_CODITE AS CODITE              ' +
            ' FROM                                  ' +
            '   CIA_CADBAS B                        ' +
            '   INNER JOIN CIA_CADCIA S             ' +
            '      ON B.BAS_CODBAS = S.CIA_CODBAS   ' +
            '     AND B.BAS_CODUNI = S.CIA_CODUNI   ' +
            '     AND B.BAS_PRODUT = S.CIA_PRODUT   ' +
            '     AND B.BAS_VOLUME = S.CIA_VOLUME   ' +
            ' WHERE CONCAT(S.CIA_UNIDAD, S.CIA_DESCRI) = :ITETIN ';
          qryGen.ParamByName('ITETIN').AsString := strIteTin;
          qryGen.Open;

          If qryGen.IsEmpty Then
          Begin
            qryGen.SQL :=
              ' SELECT                                ' +
              '   B.BAS_CODITE AS CODITE              ' +
              ' FROM                                  ' +
              '   CIA_CADBAS B                        ' +
              '   INNER JOIN CIA_CADCIA S             ' +
              '      ON B.BAS_CODBAS = S.CIA_CODBAS   ' +
              '     AND B.BAS_CODUNI = S.CIA_CODUNI   ' +
              '     AND B.BAS_PRODUT = S.CIA_PRODUT   ' +
              '     AND B.BAS_VOLUME = S.CIA_VOLUME   ' +
              ' WHERE CONCAT(S.CIA_UNIDAD, S.CIA_DESCRI) = :ITETIN ';
            qryGen.ParamByName('ITETIN').AsString := strIteTin;
            qryGen.Open;

            If qryGen.IsEmpty Then
            Begin
              qryGen.SQL :=
                ' SELECT                                ' +
                '   B.BAS_CODITE AS CODITE              ' +
                ' FROM                                  ' +
                '   CIA_CADBAS B                        ' +
                '   INNER JOIN CIA_CADCIA S             ' +
                '      ON B.BAS_CODBAS = S.CIA_CODBAS   ' +
                '     AND B.BAS_CODUNI = S.CIA_CODUNI   ' +
                '     AND B.BAS_PRODUT = S.CIA_PRODUT   ' +
                '     AND B.BAS_VOLUME = S.CIA_VOLUME   ' +
                ' WHERE CONCAT(S.CIA_DESCRI, " ", S.CIA_CODBAS, " ", S.CIA_UNIDAD) = :ITETIN ';
              qryGen.ParamByName('ITETIN').AsString := strIteTin;
              qryGen.Open;

              If qryGen.IsEmpty Then
              Begin
                qryGen.SQL :=
                  ' SELECT                                                     ' +
                  '   B.BAS_CODITE AS CODITE                                   ' +
                  ' FROM                                                       ' +
                  '   CIA_CADBAS B                                             ' +
                  '   INNER JOIN CIA_CADCIA S                                  ' +
                  '      ON B.BAS_CODBAS = S.CIA_CODBAS                        ' +
                  '     AND B.BAS_CODUNI = S.CIA_CODUNI                        ' +
                  '     AND B.BAS_PRODUT = S.CIA_PRODUT                        ' +
                  '     AND B.BAS_VOLUME = S.CIA_VOLUME                        ' +
                  ' WHERE UPPER(CAST(MD5(CONCAT(                               ' +
                  '           CAST(IFNULL(CIA_FORM01, '''') AS CHAR)           ' +
                  '           , CAST(FORMAT(IFNULL(CIA_QTDB01, 0), 4) AS CHAR) ' +
                  '           , CAST(IFNULL(CIA_FORM02, '''') AS CHAR)         ' +
                  '           , CAST(FORMAT(IFNULL(CIA_QTDB02, 0), 4) AS CHAR) ' +
                  '           , CAST(IFNULL(CIA_FORM03, '''') AS CHAR)         ' +
                  '           , CAST(FORMAT(IFNULL(CIA_QTDB03, 0), 4) AS CHAR) ' +
                  '           , CAST(IFNULL(CIA_FORM04, '''') AS CHAR)         ' +
                  '           , CAST(FORMAT(IFNULL(CIA_QTDB04, 0), 4) AS CHAR) ' +
                  '           , CAST(IFNULL(CIA_FORM05, '''') AS CHAR)         ' +
                  '           , CAST(FORMAT(IFNULL(CIA_QTDB05, 0), 4) AS CHAR) ' +
                  '           , CAST(IFNULL(CIA_FORM06, '''') AS CHAR)         ' +
                  '           , CAST(FORMAT(IFNULL(CIA_QTDB06, 0), 4) AS CHAR) ' +
                  '           , CAST(IFNULL(CIA_FORM07, '''') AS CHAR)         ' +
                  '           , CAST(FORMAT(IFNULL(CIA_QTDB07, 0), 4) AS CHAR) ' +
                  '           , CAST(IFNULL(CIA_FORM08, '''') AS CHAR)         ' +
                  '           , CAST(FORMAT(IFNULL(CIA_QTDB08, 0), 4) AS CHAR) ' +
                  '           , CAST(IFNULL(CIA_FORM09, '''') AS CHAR)         ' +
                  '           , CAST(FORMAT(IFNULL(CIA_QTDB09, 0), 4) AS CHAR) ' +
                  '           , CAST(IFNULL(CIA_FORM10, '''') AS CHAR)         ' +
                  '           , CAST(FORMAT(IFNULL(CIA_QTDB10, 0), 4) AS CHAR) ' +
                  '           , CAST(IFNULL(CIA_FORM11, '''') AS CHAR)         ' +
                  '           , CAST(FORMAT(IFNULL(CIA_QTDB11, 0), 4) AS CHAR) ' +
                  '           , CAST(IFNULL(CIA_FORM12, '''') AS CHAR)         ' +
                  '           , CAST(FORMAT(IFNULL(CIA_QTDB12, 0), 4) AS CHAR) ' +
                  '           , CAST(IFNULL(CIA_FORM13, '''') AS CHAR)         ' +
                  '           , CAST(FORMAT(IFNULL(CIA_QTDB13, 0), 4) AS CHAR) ' +
                  '           , CAST(IFNULL(CIA_FORM14, '''') AS CHAR)         ' +
                  '           , CAST(FORMAT(IFNULL(CIA_QTDB14, 0), 4) AS CHAR) ' +
                  '           , CAST(IFNULL(CIA_FORM15, '''') AS CHAR)         ' +
                  '           , CAST(FORMAT(IFNULL(CIA_QTDB15, 0), 4) AS CHAR) ' +
                  '         )) AS CHAR)) = :ITETIN                             ';
                qryGen.ParamByName('ITETIN').AsString := strIteTin;
                qryGen.Open;

                If qryGen.IsEmpty Then
                Begin
                  qryGen.SQL :=
                    ' SELECT                                                     ' +
                    '   B.BAS_CODITE AS CODITE                                   ' +
                    ' FROM                                                       ' +
                    '   CIA_CADBAS B                                             ' +
                    '   INNER JOIN CIA_CADCIA S                                  ' +
                    '     ON  B.BAS_CODBAS = S.CIA_CODBAS                        ' +
                    '     AND B.BAS_CODUNI = S.CIA_CODUNI                        ' +
                    '     AND B.BAS_PRODUT = S.CIA_PRODUT                        ' +
                    '     AND B.BAS_VOLUME = S.CIA_VOLUME                        ' +
                    ' WHERE UPPER(CAST(MD5(CONCAT(                               ' +
                    '           CAST(IFNULL(CIA_FORM01, '''') AS CHAR)           ' +
                    '           , CAST(FORMAT(IFNULL(CIA_QTDB01, 0), 4) AS CHAR) ' +
                    '           , CAST(IFNULL(CIA_FORM02, '''') AS CHAR)         ' +
                    '           , CAST(FORMAT(IFNULL(CIA_QTDB02, 0), 4) AS CHAR) ' +
                    '           , CAST(IFNULL(CIA_FORM03, '''') AS CHAR)         ' +
                    '           , CAST(FORMAT(IFNULL(CIA_QTDB03, 0), 4) AS CHAR) ' +
                    '           , CAST(IFNULL(CIA_FORM04, '''') AS CHAR)         ' +
                    '           , CAST(FORMAT(IFNULL(CIA_QTDB04, 0), 4) AS CHAR) ' +
                    '           , CAST(IFNULL(CIA_FORM05, '''') AS CHAR)         ' +
                    '           , CAST(FORMAT(IFNULL(CIA_QTDB05, 0), 4) AS CHAR) ' +
                    '           , CAST(IFNULL(CIA_FORM06, '''') AS CHAR)         ' +
                    '           , CAST(FORMAT(IFNULL(CIA_QTDB06, 0), 4) AS CHAR) ' +
                    '           , CAST(IFNULL(CIA_FORM07, '''') AS CHAR)         ' +
                    '           , CAST(FORMAT(IFNULL(CIA_QTDB07, 0), 4) AS CHAR) ' +
                    '           , CAST(IFNULL(CIA_FORM08, '''') AS CHAR)         ' +
                    '           , CAST(FORMAT(IFNULL(CIA_QTDB08, 0), 4) AS CHAR) ' +
                    '           , CAST(IFNULL(CIA_FORM09, '''') AS CHAR)         ' +
                    '           , CAST(FORMAT(IFNULL(CIA_QTDB09, 0), 4) AS CHAR) ' +
                    '           , CAST(IFNULL(CIA_FORM10, '''') AS CHAR)         ' +
                    '           , CAST(FORMAT(IFNULL(CIA_QTDB10, 0), 4) AS CHAR) ' +
                    '           , CAST(IFNULL(CIA_FORM11, '''') AS CHAR)         ' +
                    '           , CAST(FORMAT(IFNULL(CIA_QTDB11, 0), 4) AS CHAR) ' +
                    '           , CAST(IFNULL(CIA_FORM12, '''') AS CHAR)         ' +
                    '           , CAST(FORMAT(IFNULL(CIA_QTDB12, 0), 4) AS CHAR) ' +
                    '           , CAST(IFNULL(CIA_FORM13, '''') AS CHAR)         ' +
                    '           , CAST(FORMAT(IFNULL(CIA_QTDB13, 0), 4) AS CHAR) ' +
                    '           , CAST(IFNULL(CIA_FORM14, '''') AS CHAR)         ' +
                    '           , CAST(FORMAT(IFNULL(CIA_QTDB14, 0), 4) AS CHAR) ' +
                    '           , CAST(IFNULL(CIA_FORM15, '''') AS CHAR)         ' +
                    '           , CAST(FORMAT(IFNULL(CIA_QTDB15, 0), 4) AS CHAR) ' +
                    '           , CAST(IFNULL(CIA_FORM16, '''') AS CHAR)         ' +
                    '           , CAST(FORMAT(IFNULL(CIA_QTDB16, 0), 4) AS CHAR) ' +
                    '           , CAST(IFNULL(CIA_FORM17, '''') AS CHAR)         ' +
                    '           , CAST(FORMAT(IFNULL(CIA_QTDB17, 0), 4) AS CHAR) ' +
                    '           , CAST(IFNULL(CIA_FORM18, '''') AS CHAR)         ' +
                    '           , CAST(FORMAT(IFNULL(CIA_QTDB18, 0), 4) AS CHAR) ' +
                    '           , CAST(IFNULL(CIA_FORM19, '''') AS CHAR)         ' +
                    '           , CAST(FORMAT(IFNULL(CIA_QTDB19, 0), 4) AS CHAR) ' +
                    '           , CAST(IFNULL(CIA_FORM20, '''') AS CHAR)         ' +
                    '           , CAST(FORMAT(IFNULL(CIA_QTDB20, 0), 4) AS CHAR) ' +
                    '         )) AS CHAR)) = :ITETIN                             ';
                  qryGen.ParamByName('ITETIN').AsString := strIteTin;
                  qryGen.Open;
                End;
              End;
            End;
          End;
        End;
      End;

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

function TFormulaImobiliariaCiacollor.GetNomeCampoBaseCodIte: String;
begin
  Result := 'BAS_CODITE';
end;

function TFormulaImobiliariaCiacollor.GetNomeCampoCustoBase: String;
begin
  Result := 'BAS_PRECUS';
end;

function TFormulaImobiliariaCiacollor.GetNomeCampoVendaBase: String;
begin
  Result := 'BAS_PREVEN';
end;

function TFormulaImobiliariaCiacollor.GetNomeTabelaBase: String;
begin
  Result := 'CIA_CADBAS';
end;

function TFormulaImobiliariaCiacollor.GetNomeCampoColDesCol: string;
begin
  Result := 'COL_DESCRI';
end;

function TFormulaImobiliariaCiacollor.GetNomeTabelaColorantes: String;
begin
  Result := 'CIA_CADCOL';
end;

function TFormulaImobiliariaCiacollor.GetPrefixoFormulacao: String;
begin
  Result := 'CIA_FORM';
end;

function TFormulaImobiliariaCiacollor.GetPrefixoQuantidade(const strModo: String): String;
begin
  Result := 'CIA_QTDB';
end;

function TFormulaImobiliariaCiacollor.GetProdutoBaseFormula(const dtsCadTin: IDataSet): String;
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
        '   CIA_CADBAS               ' +
        ' WHERE BAS_CODBAS = :CODBAS ' +
        '   AND BAS_CODUNI = :CODUNI ' +
        '   AND BAS_PRODUT = :PRODUT ' +
        '   AND BAS_VOLUME = :VOLUME ';

      dtsGen.ParamByName('CODBAS').AsString := dtsCadTin.FieldByName('CIA_CODBAS').AsString;
      dtsGen.ParamByName('CODUNI').AsString := dtsCadTin.FieldByName('CIA_CODUNI').AsString;
      dtsGen.ParamByName('PRODUT').AsString := dtsCadTin.FieldByName('CIA_PRODUT').AsString;
      dtsGen.ParamByName('VOLUME').AsString := dtsCadTin.FieldByName('CIA_VOLUME').AsString;
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

function TFormulaImobiliariaCiacollor.GetQuantidadeFormulacao: Integer;
begin
  Result := 20;
end;

function TFormulaImobiliariaCiacollor.GetTextoInformativoCalculo: String;
begin
  Result :=
    'Valor da Base = ' + FloatToStrF(BasePrecoVenda, ffFixed, 12, 2) + sLineBreak +
    'Valor do Colorante = (Quantidade * Preço / Embalagem) ' + sLineBreak +
    'Valor da Tinta = Valor da Base + (Soma do Valor do Colorante de todos os Colorantes)';
end;

function TFormulaImobiliariaCiacollor.GetUnidade(const dtsCadTin: IDataSet): String;
begin
  Result := dtsCadTin.FieldByName('CIA_CODUNI').AsString;
end;

procedure TFormulaImobiliariaCiacollor.PreencheAcrescimoMaoObra(
  const dtsCadTin: IDataSet);
begin
  Self.AcrMob := dtsCadTin.FieldByName('CIA_ACRMOB').AsFloat;
end;

end.
