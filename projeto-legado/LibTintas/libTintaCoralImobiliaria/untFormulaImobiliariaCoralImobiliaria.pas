{********************************************************************************}
{* Classe responsável pelas rotidas especificas de uma formula CoralImobiliaria *}
{*****************************************************************************AC*}
unit untFormulaImobiliariaCoralImobiliaria;

interface

uses
  untAbstractFormulaImobiliaria, untICalculadorFormulaImobiliaria, untIDataSet, untColorante,
  SysUtils, untStrUtils;

type
  TFormulaImobiliariaCoralImobiliaria = class(TAbstractFormulaImobiliaria)
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
    function GetDataSetMensAlerta(const dtsCadTin: IDataSet): IDataSet; Override;
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
    procedure CarregarColorantes; override;
    procedure PreencheAcrescimoMaoObra(const dtsCadTin: IDataSet); Override;
  end;

implementation

uses
  untAbstractCalculadorFormulaImobiliaria, untAutcomTintaFactory;

{ TFormulaImobiliariaCoralImobiliaria }

procedure TFormulaImobiliariaCoralImobiliaria.CarregaPrecosColorantesAdicional(const dataSetColorantes: IDataSet; const colorante: TColorante);
begin
  colorante.Embalagem := dataSetColorantes.FieldByName('COL_EMBALA').AsFloat; //946;
end;

procedure TFormulaImobiliariaCoralImobiliaria.CarregarColorantes;
var
  strSql: String;
begin
  strSql := ' SELECT         ' +
    '     COL_CODCOL ' +
    '   , COL_CODITE ' +
    '   , COL_EMBALA ' ;

  if GetNomeCampoColDesCol <> '' then
    strSql := strSql + ' , '+ GetNomeCampoColDesCol
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
    strSql := strSql  + '   , I.ITE_IMPDIR  '
  else
    strSql := strSql  + '   , G.ITE_IMPDIR  ';

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
      '   , ITE_PREVE' + TAutcomTintaFactory.Get.fCfgSis('TABPRE') + ' AS ITE_PREVEN ';
  end
  else
  begin
    strSql := strSql +
      '   , ITE_PRECUS               ' +
      '   , ITE_PREVE' + Self.strTabPre + ' AS ITE_PREVEN ';
  end;

  strSql := strSql +
    ' FROM                               ' +
    '   ' + GetNomeTabelaColorantes + ' C                     ' +
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

function TFormulaImobiliariaCoralImobiliaria.GetCalculadorInterno: ICalculadorFormulaImobiliaria;
begin
  Result := TAbstractCalculadorFormulaImobiliaria.Create(Self);
end;

function TFormulaImobiliariaCoralImobiliaria.GetChaveIteTin(const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('COR_MD5KEY').AsString
end;

function TFormulaImobiliariaCoralImobiliaria.GetDataSetMensAlerta(
  const dtsCadTin: IDataSet): IDataSet;
Var
  strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + '  SELECT                        ';
  strSQL := strSQL + '    COR_OBSERV  AS MSG_MENSAG   ';
  strSQL := strSQL + '  FROM                          ';
  strSQL := strSQL + '    CORIMO_CADCOR               ';
  strSQL := strSQL + '  WHERE                         ';
  strSQL := strSQL + '    COR_DESCRI = :DESCRI AND            ';
  strSQL := strSQL + '    COR_COLID1 = :COLID1 AND            ';
  strSQL := strSQL + '    COR_COLID2 = :COLID2 AND            ';
  strSQL := strSQL + '    COR_UNIVER = :UNIVER AND            ';
  strSQL := strSQL + '    COR_DESPRO = :DESPRO AND            ';
  strSQL := strSQL + '    COR_CODBAS = :CODBAS AND            ';
  strSQL := strSQL + '    COR_CODIGO = :CODIGO AND            ';
  strSQL := strSQL + '    COR_UNIDAD = :UNIDAD                ';


  Result := TAutcomTintaFactory.Get.fGetDataSet;
  Result.Close;
  Result.SQL := strSQL;
  Result.ParamByName('DESCRI').AsString := dtsCadTin.FieldByName('COR_DESCRI').AsString;
  Result.ParamByName('COLID1').AsString := dtsCadTin.FieldByName('COR_COLID1').AsString;
  Result.ParamByName('COLID2').AsString := dtsCadTin.FieldByName('COR_COLID2').AsString;
  Result.ParamByName('UNIVER').AsString := dtsCadTin.FieldByName('COR_UNIVER').AsString;
  Result.ParamByName('DESPRO').AsString := dtsCadTin.FieldByName('COR_DESPRO').AsString;
  Result.ParamByName('CODBAS').AsString := dtsCadTin.FieldByName('COR_CODBAS').AsString;
  Result.ParamByName('CODIGO').AsString := dtsCadTin.FieldByName('COR_CODIGO').AsString;
  Result.ParamByName('UNIDAD').AsString := dtsCadTin.FieldByName('COR_UNIDAD').AsString;
  Result.Open;

  If TStrUtils.fEmptyStr(Result.FieldByName('MSG_MENSAG').AsString) Then
  Begin
    Result := Nil;
    Exit;
  End;
end;

function TFormulaImobiliariaCoralImobiliaria.GetDescricao(const dtsCadTin: IDataSet): String;
begin
  Result := dtsCadTin.FieldByName('COR_DESCRI').AsString;
end;

function TFormulaImobiliariaCoralImobiliaria.GetFatorEstoque: Double;
begin
  Result := 0.308;
end;

function TFormulaImobiliariaCoralImobiliaria.GetIdePro: String;
begin
  Result := 'CIM';
end;

function TFormulaImobiliariaCoralImobiliaria.GetItemBaseOriginal(const strIteTin: String): String;
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
        '   CORIMO_CADBAS B                     ' +
        '   INNER JOIN CORIMO_CADCOR S          ' +
        '      ON B.BAS_BASE__ = S.COR_CODBAS   ' +
        '     AND B.BAS_UNIDAD = S.COR_CODUNI   ' +
        '     AND B.BAS_DESCRI = S.COR_DESPRO   ' +
        '   WHERE S.COR_MD5KEY = :ITETIN        ';
      qryGen.ParamByName('ITETIN').AsString := strIteTin;
      qryGen.Open;

      If qryGen.IsEmpty Then
      Begin
        qryGen.SQL :=
          ' SELECT                              ' +
          '   B.BAS_CODITE AS CODITE            ' +
          ' FROM                                ' +
          '   CORIMO_CADCOR C                   ' +
          '   INNER JOIN CORIMO_CADBAS B        ' +
          '     ON C.COR_CODBAS = B.BAS_BASE__  ' +
          '     AND C.COR_CODUNI = B.BAS_UNIDAD ' +
          '     AND C.COR_DESPRO = B.BAS_DESCRI ' +
          ' WHERE CONCAT(                       ' +
          '     IFNULL(C.COR_DESCRI, '''')      ' +
          '     , IFNULL(C.COR_CODIGO, '''')    ' +
          '     , IFNULL(C.COR_UNIDAD, '''')    ' +
          '     , IFNULL(C.COR_COLID1, '''')    ' +
          '     , IFNULL(C.COR_COLID2, '''')    ' +
          '     , IFNULL(C.COR_DESPRO, '''')    ' +
          '     , IFNULL(C.COR_CODBAS, '''')    ' +
          '     , IFNULL(C.COR_CODEMB, '''')    ' +
          '     , IFNULL(C.COR_CODUNI, '''')    ' +
          '     , IFNULL(C.COR_UNIVER, '''')    ' +
          '   ) = :ITETIN                       ';
        qryGen.ParamByName('ITETIN').AsString := strIteTin;
        qryGen.Open;

        If qryGen.IsEmpty Then
        Begin
          qryGen.SQL :=
            ' SELECT                              ' +
            '   B.BAS_CODITE AS CODITE            ' +
            ' FROM                                ' +
            '   CORIMO_CADCOR C                   ' +
            '   INNER JOIN CORIMO_CADBAS B        ' +
            '     ON C.COR_CODBAS = B.BAS_BASE__  ' +
            '     AND C.COR_CODUNI = B.BAS_UNIDAD ' +
            '     AND C.COR_DESPRO = B.BAS_DESCRI ' +
            ' WHERE CONCAT(                       ' +
            '     IFNULL(C.COR_COLID1, '''')      ' +
            '     , IFNULL(C.COR_COLID2, '''')    ' +
            '     , IFNULL(C.COR_DESPRO, '''')    ' +
            '     , IFNULL(C.COR_CODBAS, '''')    ' +
            '     , IFNULL(C.COR_CODIGO, '''')    ' +
            '     , IFNULL(C.COR_UNIDAD, '''')    ' +
            '   ) = :ITETIN                       ';
          qryGen.ParamByName('ITETIN').AsString := strIteTin;
          qryGen.Open;

          If qryGen.IsEmpty Then
          Begin
            qryGen.SQL :=
              ' SELECT                              ' +
              '   B.BAS_CODITE AS CODITE            ' +
              ' FROM                                ' +
              '   CORIMO_CADCOR C                   ' +
              '   INNER JOIN CORIMO_CADBAS B        ' +
              '     ON C.COR_CODBAS = B.BAS_BASE__  ' +
              '     AND C.COR_CODUNI = B.BAS_UNIDAD ' +
              '     AND C.COR_DESPRO = B.BAS_DESCRI ' +
              ' WHERE C.COR_CODSEQ = :ITETIN        ';
            qryGen.ParamByName('ITETIN').AsString := strIteTin;
            qryGen.Open;
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

function TFormulaImobiliariaCoralImobiliaria.GetNomeCampoBaseCodIte: String;
begin
  Result := 'BAS_CODITE';
end;

function TFormulaImobiliariaCoralImobiliaria.GetNomeCampoCustoBase: String;
begin
  Result := 'BAS_PRECUS';
end;

function TFormulaImobiliariaCoralImobiliaria.GetNomeCampoVendaBase: String;
begin
  Result := 'BAS_PREVEN';
end;

function TFormulaImobiliariaCoralImobiliaria.GetNomeTabelaBase: String;
begin
  Result := 'CORIMO_CADBAS';
end;

function TFormulaImobiliariaCoralImobiliaria.GetNomeCampoColDesCol: string;
begin
  Result := '';
end;

function TFormulaImobiliariaCoralImobiliaria.GetNomeTabelaColorantes: String;
begin
  Result := 'CORIMO_CADCOL';
end;

function TFormulaImobiliariaCoralImobiliaria.GetPrefixoFormulacao: String;
begin
  Result := 'COR_FORM';
end;

function TFormulaImobiliariaCoralImobiliaria.GetPrefixoQuantidade(const strModo: String): String;
begin
  Result := 'COR_QTDC';
end;

function TFormulaImobiliariaCoralImobiliaria.GetProdutoBaseFormula(const dtsCadTin: IDataSet): String;
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
        '   CORIMO_CADBAS               ' +
        ' WHERE BAS_BASE__ = :CODBAS ' +
        '   AND BAS_UNIDAD = :CODUNI ' +
        '   AND BAS_DESCRI = :DESCRI ' ;

      dtsGen.ParamByName('CODBAS').AsString := dtsCadTin.FieldByName('COR_CODBAS').AsString;
      dtsGen.ParamByName('CODUNI').AsString := dtsCadTin.FieldByName('COR_CODUNI').AsString;
      dtsGen.ParamByName('DESCRI').AsString := dtsCadTin.FieldByName('COR_DESPRO').AsString;
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

function TFormulaImobiliariaCoralImobiliaria.GetQuantidadeFormulacao: Integer;
begin
  Result := 20;
end;

function TFormulaImobiliariaCoralImobiliaria.GetTextoInformativoCalculo: String;
begin
  Result :=
    'Valor da Base = ' + FloatToStrF(BasePrecoVenda, ffFixed, 12, 2) + sLineBreak +
    'Valor do Colorante = (Quantidade * 0.308) * (Preço / Embalagem) ' + sLineBreak +
    'Valor da Tinta = Valor da Base + (Soma do Valor do Colorante de todos os Colorantes)';
end;

function TFormulaImobiliariaCoralImobiliaria.GetUnidade(const dtsCadTin: IDataSet): String;
begin
  Result := dtsCadTin.FieldByName('COR_CODUNI').AsString;
end;

procedure TFormulaImobiliariaCoralImobiliaria.PreencheAcrescimoMaoObra(
  const dtsCadTin: IDataSet);
begin
  Self.AcrMob := dtsCadTin.FieldByName('COR_ACRMOB').AsFloat;
end;

end.
