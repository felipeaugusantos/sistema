{********************************************************************************}
{* Classe responsável pelas rotidas especificas de uma formula International *}
{*****************************************************************************AC*}
unit untFormulaImobiliariaInternational;

interface

uses
  untAbstractFormulaImobiliaria, untICalculadorFormulaImobiliaria, untIDataSet, untColorante,
  SysUtils, untStrUtils;

type
  TFormulaImobiliariaInternational = class(TAbstractFormulaImobiliaria)
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
     function fMostraQuantidadeEmOnca(Var strOnca: String;
      const fltQtdCol: Double): Boolean; override;
    function GetChaveIteTin(const dtsCadTin: IDataSet): string; override;
    function GetNomeCampoColDesCol: string; override;
    procedure CarregarColorantes; override;
    procedure PreencheAcrescimoMaoObra(const dtsCadTin: IDataSet); Override;
  end;

implementation

uses
  untAbstractCalculadorFormulaImobiliaria, untAutcomTintaFactory;

{ TFormulaImobiliariaInternational }

procedure TFormulaImobiliariaInternational.CarregaPrecosColorantesAdicional(const dataSetColorantes: IDataSet; const colorante: TColorante);
begin
  colorante.Embalagem := dataSetColorantes.FieldByName('COL_EMBALA').AsFloat;
end;

procedure TFormulaImobiliariaInternational.CarregarColorantes;
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

function TFormulaImobiliariaInternational.fMostraQuantidadeEmOnca(
  var strOnca: String; const fltQtdCol: Double): Boolean;
var
  fltValor1 : Double;
  fltInteiro: Double;
  fltFracao : Double;

  fltVlrInt  : Double;
  fltVlrFrac : Double;

  strCalc : String;
begin
  Result := False;

  If (TAutcomTintaFactory.Get.fGetConfTinta('INT').fGet('INTMAN') = 'S' ) Then
  Begin
    Result := True;

    fltValor1 := (fltQtdCol/ 29.57);
    fltInteiro := Trunc(fltValor1);
    fltFracao  := Frac(fltValor1);

    fltValor1 := (fltFracao * 48);
    fltVlrInt := Trunc(fltValor1);
    fltVlrFrac := Trunc((Frac(fltValor1)) * 100);

    If (fltVlrFrac > 25) And (fltVlrFrac <= 50) Then
      fltVlrFrac := 50
    Else If fltVlrFrac > 75 Then
    Begin
      fltVlrFrac := 0;
      fltVlrInt := fltVlrInt + 1;
    End;

    strCalc := (FloatToStr(fltVlrInt) + ',' +  FloatToStr(fltVlrFrac));

    strOnca := FloatToStr(fltInteiro) + 'Y' + strCalc;
  End;
end;

function TFormulaImobiliariaInternational.GetCalculadorInterno: ICalculadorFormulaImobiliaria;
begin
  Result := TAbstractCalculadorFormulaImobiliaria.Create(Self);
end;

function TFormulaImobiliariaInternational.GetChaveIteTin(const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('INT_MD5KEY').AsString
end;

function TFormulaImobiliariaInternational.GetDescricao(const dtsCadTin: IDataSet): String;
begin
  Result := '';
end;

function TFormulaImobiliariaInternational.GetFatorEstoque: Double;
begin
  Result := 1;
end;

function TFormulaImobiliariaInternational.GetIdePro: String;
begin
  Result := 'INT';
end;

function TFormulaImobiliariaInternational.GetItemBaseOriginal(const strIteTin: String): String;
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
        '   INT_CADBAS B                     '    +
        '   INNER JOIN INT_CADINT S          '    +
        '      ON B.BAS_CODBAS = S.INT_CODBAS   ' +
        '     AND B.BAS_CODEMB = S.INT_CODEMB   ' +
        '   WHERE S.INT_MD5KEY = :ITETIN        ';
      qryGen.ParamByName('ITETIN').AsString := strIteTin;
      qryGen.Open;

      If qryGen.IsEmpty Then
      Begin
        qryGen.SQL :=
        ' SELECT                              ' +
        '   B.BAS_CODITE AS CODITE            ' +
        ' FROM                                ' +
        '   INT_CADINT C                   ' +
        '   INNER JOIN INT_CADBAS B        ' +
        '     ON C.INT_CODBAS = B.BAS_CODBAS  ' +
        '     AND C.INT_CODEMB = B.BAS_CODEMB ' +
        ' WHERE CONCAT(                       ' +
        '     IFNULL(C.INT_LINHA_ '''')      ' +
        '     , IFNULL(C.INT_DESCOR, '''')    ' +
        '     , IFNULL(C.INT_CODBAS, '''')    ' +
        '     , IFNULL(C.INT_CODEMB, '''')    ' +
        '     , IFNULL(C.INT_CODNFM, '''')    ' +
        '   ) = :ITETIN                       ';
      qryGen.ParamByName('ITETIN').AsString := strIteTin;
      qryGen.Open;
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

function TFormulaImobiliariaInternational.GetNomeCampoBaseCodIte: String;
begin
  Result := 'BAS_CODITE';
end;

function TFormulaImobiliariaInternational.GetNomeCampoCustoBase: String;
begin
  Result := 'BAS_PRECUS';
end;

function TFormulaImobiliariaInternational.GetNomeCampoVendaBase: String;
begin
  Result := 'BAS_PREVEN';
end;

function TFormulaImobiliariaInternational.GetNomeTabelaBase: String;
begin
  Result := 'INT_CADBAS';
end;

function TFormulaImobiliariaInternational.GetNomeCampoColDesCol: string;
begin
  Result := '';
end;

function TFormulaImobiliariaInternational.GetNomeTabelaColorantes: String;
begin
  Result := 'INT_CADCOL';
end;

function TFormulaImobiliariaInternational.GetPrefixoFormulacao: String;
begin
  Result := 'INT_FORM';
end;

function TFormulaImobiliariaInternational.GetPrefixoQuantidade(const strModo: String): String;
begin
  Result := 'INT_QTDC';
end;

function TFormulaImobiliariaInternational.GetProdutoBaseFormula(const dtsCadTin: IDataSet): String;
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
        '   INT_CADBAS               ' +
        ' WHERE BAS_CODBAS = :CODBAS ' +
        '   AND BAS_CODEMB = :CODEMB ' ;

      dtsGen.ParamByName('CODBAS').AsString := dtsCadTin.FieldByName('INT_CODBAS').AsString;
      dtsGen.ParamByName('CODEMB').AsString := dtsCadTin.FieldByName('INT_CODEMB').AsString;
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

function TFormulaImobiliariaInternational.GetQuantidadeFormulacao: Integer;
begin
  Result := 20;
end;

function TFormulaImobiliariaInternational.GetTextoInformativoCalculo: String;
begin
  Result :=
    'Valor da Base = ' + FloatToStrF(BasePrecoVenda, ffFixed, 12, 2) + sLineBreak +
    'Valor do Colorante = (Quantidade) * (Preço / Embalagem) ' + sLineBreak +
    'Valor da Tinta = Valor da Base + (Soma do Valor do Colorante de todos os Colorantes)';
end;

function TFormulaImobiliariaInternational.GetUnidade(const dtsCadTin: IDataSet): String;
begin
  Result := dtsCadTin.FieldByName('INT_CODEMB').AsString;
end;

procedure TFormulaImobiliariaInternational.PreencheAcrescimoMaoObra(
  const dtsCadTin: IDataSet);
begin
  Self.AcrMob := dtsCadTin.FieldByName('INT_ACRMOB').AsFloat;
end;

end.
