{ ******************************************************************************** }
{ * Classe responsável pelas rotidas especificas de uma formula Alv * }
{ *****************************************************************************AC* }
unit untFormulaImobiliariaAlv;

interface

uses
{$IFNDEF LINUX}
  Vcl.ComCtrls,
  Forms,
{$ENDIF}
  untAbstractFormulaImobiliaria, untICalculadorFormulaImobiliaria, untIDataSet,
  untColorante, SysUtils, Classes, untAbstractFormula, untStrUtils;

type
  TFormulaImobiliariaAlv = class(TAbstractFormulaImobiliaria)
  Private
    function fVerificaIMPDIG(): String;
    function fVerificaEmpPrdOprFlj(): Boolean;
    function fRetPesoEspColorante(AColorante: String): Double;
    function fVerificaPrecoGeracaoBlnUnitario(): Boolean;
    function fRetEmpresa(): String;
    function fEmpresaCd(strEmpCd, strCD_S_N: String): Boolean;
    function fEmpresaFat(strEmpFat, strFatS_N: String): Boolean;
  protected
    function GetCalculadorInterno(): ICalculadorFormulaImobiliaria; override;
    function GetNomeTabelaColorantes(): String; override;
    function GetTextoInformativoCalculo(): String; override;
    procedure CarregaPrecosColorantesAdicional(const dataSetColorantes
      : IDataSet; const colorante: TColorante); override;
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
    procedure CarregarColorantes; override;
    procedure PreencheAcrescimoMaoObra(const dtsCadTin: IDataSet); Override;
  {$IFNDEF LINUX}
    procedure pAjustaFormulacao(lsvFormulacao: TListView; Form: TForm); Override;
  {$ENDIF}
  {$IFNDEF LINUX}
    procedure pAddItemsFormulacao(lsvFormulacao: TListView; Formula: TAbstractFormula); Override;
  {$ENDIF}
    function fAlteraFormulacao(): Boolean; Override;
  end;

implementation

uses
  untAbstractCalculadorFormulaImobiliaria, untAutcomTintaFactory,
  untMultiSelectLocalizadorFactory;

{ TFormulaImobiliariaAlv }

procedure TFormulaImobiliariaAlv.CarregaPrecosColorantesAdicional
  (const dataSetColorantes: IDataSet; const colorante: TColorante);
begin
  colorante.Embalagem := dataSetColorantes.FieldByName('COL_EMBALA').AsFloat;
end;

procedure TFormulaImobiliariaAlv.CarregarColorantes;
var
  strSql: String;
begin
  strSql := ' SELECT         ' +
            '     COL_CODCOL ' +
            '   , COL_CODITE ' +
            '   , COL_EMBALA ';

  strSql := strSql + ' , ' + GetNomeCampoColDesCol;

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

  strSql := strSql + fVerificaIMPDIG;

  If (TAutcomTintaFactory.Get.fCfgSis('PREGER') = '0') Then
  begin
    strSql := strSql +
      '   , COL_PRECUS AS ITE_PRECUS ' +
      '   , COL_PREVEN AS ITE_PREVEN ';
  end

  Else If fVerificaPrecoGeracaoBlnUnitario Then
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
  GetDataSetCOlorantes.ParamByName('CODEMP').AsString := fRetEmpresa;

  GetDataSetColorantes.Open;
end;

function TFormulaImobiliariaAlv.fAlteraFormulacao: Boolean;
begin
  Result := True;
end;

function TFormulaImobiliariaAlv.fEmpresaCd(strEmpCd,
  strCD_S_N: String): Boolean;
begin
  Result := False;

  If Not (TStrUtils.fEmptyStr(strEmpCd)) Then
  Begin
    If strCD_S_N = 'S' Then
      Result := True;
  End;
end;

function TFormulaImobiliariaAlv.fEmpresaFat(strEmpFat,
  strFatS_N: String): Boolean;
begin
  Result := False;

  If Not (TStrUtils.fEmptyStr(strEmpFat)) Then
  Begin
    If strFatS_N = 'S' Then
      Result := True;
  End;
end;

function TFormulaImobiliariaAlv.fRetEmpresa: String;
begin
  If fVerificaEmpPrdOprFlj Then
    Result := Self.EmpPrd
  Else If  fEmpresaCd(Self.EmpCd_, Self.Cd_S_N) Then
    Result := Self.EmpCd_
  Else If fEmpresaFat(Self.EmpFat, Self.FatS_N) Then
    Result := Self.EmpFat
  Else
    Result := TAutcomTintaFactory.Get.GetCodEmp;
end;

function TFormulaImobiliariaAlv.fRetPesoEspColorante(
  AColorante: String): Double;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT COL_PESESP FROM ALV_CADCOL WHERE COL_CODCOL = :CODCOL  ';
  qryGen.ParamByName('CODCOL').AsString := AColorante;
  qryGen.Open;

  Result := qryGen.FieldByName('COL_PESESP').AsFloat;
end;

function TFormulaImobiliariaAlv.fVerificaEmpPrdOprFlj: Boolean;
begin
  Result := False;

  If Not (TStrUtils.fEmptyStr(Self.EmpPrd)) Then
  Begin
    If Self.OprFlj = 'S' Then
      Result := True;
  End;
end;

function TFormulaImobiliariaAlv.fVerificaIMPDIG: String;
begin
  If TAutcomTintaFactory.Get.fCfgSis('IMPDIG') = '1' Then
    Result := '   , I.ITE_IMPDIR  '
  Else
    Result := '   , G.ITE_IMPDIR  ';
end;

function TFormulaImobiliariaAlv.fVerificaPrecoGeracaoBlnUnitario: Boolean;
begin
  Result := False;

  If (TAutcomTintaFactory.Get.fCfgSis('PREGER') = '1') Then
  Begin
    If BlnCalculaUnitario Then
      Result := True;
  End;
end;

function TFormulaImobiliariaAlv.GetCalculadorInterno
  : ICalculadorFormulaImobiliaria;
begin
  Result := TAbstractCalculadorFormulaImobiliaria.Create(Self);
end;

function TFormulaImobiliariaAlv.GetChaveIteTin(const dtsCadTin
  : IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('ALV_MD5KEY').AsString
end;

function TFormulaImobiliariaAlv.GetDescricao(const dtsCadTin
  : IDataSet): String;
begin
  Result := dtsCadTin.FieldByName('ALV_PRODUT').AsString;
end;

function TFormulaImobiliariaAlv.GetFatorEstoque: Double;
begin
  Result := 1;
end;

function TFormulaImobiliariaAlv.GetIdePro: String;
begin
  Result := 'ALV';
end;

function TFormulaImobiliariaAlv.GetItemBaseOriginal(const strIteTin
  : String): String;
var
  qryGen: IDataSet;
begin
  qryGen := nil;
  Result := '';
  Try
    Try
      If TMultiSelectLocalizadorFactory.GetLocalizador('ALVBAS')
        .Localizar(qryGen, ['ITETIN'], [strIteTin]) Then
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

function TFormulaImobiliariaAlv.GetNomeCampoBaseCodIte: String;
begin
  Result := 'BAS_CODITE';
end;

function TFormulaImobiliariaAlv.GetNomeCampoCustoBase: String;
begin
  Result := 'BAS_PRECUS';
end;

function TFormulaImobiliariaAlv.GetNomeCampoVendaBase: String;
begin
  Result := 'BAS_PREVEN';
end;

function TFormulaImobiliariaAlv.GetNomeTabelaBase: String;
begin
  Result := 'ALV_CADBAS';
end;

function TFormulaImobiliariaAlv.GetNomeCampoColDesCol: string;
begin
  Result := 'COL_DESCRI';
end;

function TFormulaImobiliariaAlv.GetNomeTabelaColorantes: String;
begin
  Result := 'ALV_CADCOL';
end;

function TFormulaImobiliariaAlv.GetPrefixoFormulacao: String;
begin
  Result := 'ALV_FORM';
end;

function TFormulaImobiliariaAlv.GetPrefixoQuantidade(const strModo
  : String): String;
begin
  Result := 'ALV_QTDC';
end;

function TFormulaImobiliariaAlv.GetProdutoBaseFormula(const dtsCadTin
  : IDataSet): String;
var
  dtsGen: IDataSet;
begin
  Try
    Try
      dtsGen := TAutcomTintaFactory.Get.fGetDataSet;
      dtsGen.SQL := ' SELECT                     ' +
        '   BAS_CODITE               ' + ' FROM                       ' +
        '   ALV_CADBAS               ' + ' WHERE BAS_CODBAS = :CODBAS ' +
        '   AND BAS_UNIDAD = :CODUNI ' + '  AND BAS_PRODUT = :DESCRI  ' +
        '   AND BAS_EMBALA = :EMBALA ';

      dtsGen.ParamByName('CODBAS').AsString := dtsCadTin.FieldByName('ALV_CODBAS').AsString;
      dtsGen.ParamByName('CODUNI').AsString := dtsCadTin.FieldByName('ALV_UNIDAD').AsString;
      dtsGen.ParamByName('DESCRI').AsString := dtsCadTin.FieldByName('ALV_PRODUT').AsString;
      dtsGen.ParamByName('EMBALA').AsFloat  := dtsCadTin.FieldByName('ALV_VOLUME').AsFloat;
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

function TFormulaImobiliariaAlv.GetQuantidadeFormulacao: Integer;
begin
  Result := 20;
end;

function TFormulaImobiliariaAlv.GetTextoInformativoCalculo: String;
begin
  Result :=
    'Valor da Base = ' + FloatToStrF(BasePrecoVenda, ffFixed, 12, 2) + sLineBreak +
    'Valor do Colorante = (Quantidade) * (Preço / Embalagem) ' + sLineBreak +
    'Valor da Tinta = Valor da Base + (Soma do Valor do Colorante de todos os Colorantes)';
end;

function TFormulaImobiliariaAlv.GetUnidade(const dtsCadTin: IDataSet): String;
begin
  Result := dtsCadTin.FieldByName('ALV_UNIDAD').AsString;
end;

{$IFNDEF LINUX}
procedure TFormulaImobiliariaAlv.pAddItemsFormulacao(
  lsvFormulacao: TListView; Formula: TAbstractFormula);
Var
  Colorante: TColorante;
  intContador: Integer;
begin
  For intContador := 0 To Formula.Count - 1 Do
  Begin
    Colorante := TColorante(Formula.Items[intContador]);

    If Colorante.Embalagem <= 0 Then
      lsvFormulacao.Columns[4].Caption := '';

    If Colorante.DescricaoColorante <> '' Then
      lsvFormulacao.Items.Add.Caption := Colorante.CodigoColorante + ' - ' + Colorante.DescricaoColorante
    Else
      lsvFormulacao.Items.Add.Caption := Colorante.CodigoColorante;

    lsvFormulacao.Items[intContador].SubItems.Add(FloatToStrF(Colorante.Quantidade, ffFixed, 12, 2));
    lsvFormulacao.Items[intContador].SubItems.Add(FloatToStrF(Colorante.Quantidade * fRetPesoEspColorante(Colorante.CodigoColorante), ffFixed, 12, 2));
    lsvFormulacao.Items[intContador].SubItems.Add(FloatToStrF(Colorante.PrecoVenda, ffFixed, 12, 6));

    If Colorante.Embalagem > 0 Then
      lsvFormulacao.Items[intContador].SubItems.Add(FloatToStrF(Colorante.Embalagem, ffFixed, 12, 4));
  End;
end;
{$ENDIF}

{$IFNDEF LINUX}
procedure TFormulaImobiliariaAlv.pAjustaFormulacao(
  lsvFormulacao: TListView; Form: TForm);
begin
  Form.ClientWidth := 600;
  lsvFormulacao.Columns.Clear;

  lsvFormulacao.Columns.Add;
  lsvFormulacao.Columns.Items[0].Alignment := taRightJustify;
  lsvFormulacao.Columns.Items[0].Caption   := 'Colorante';
  lsvFormulacao.Columns.Items[0].Width     := (lsvFormulacao.Width - 10) div 5;

  lsvFormulacao.Columns.Add;
  lsvFormulacao.Columns.Items[1].Alignment := taRightJustify;
  lsvFormulacao.Columns.Items[1].Caption   := 'Quantidade(ML)';
  lsvFormulacao.Columns.Items[1].Width     := (lsvFormulacao.Width - 10) div 5;

  lsvFormulacao.Columns.Add;
  lsvFormulacao.Columns.Items[2].Alignment := taRightJustify;
  lsvFormulacao.Columns.Items[2].Caption   := 'Quantidade(G)';
  lsvFormulacao.Columns.Items[2].Width     := (lsvFormulacao.Width - 10) div 5;

  lsvFormulacao.Columns.Add;
  lsvFormulacao.Columns.Items[3].Alignment := taRightJustify;
  lsvFormulacao.Columns.Items[3].Caption   := 'Preço';
  lsvFormulacao.Columns.Items[3].Width     := (lsvFormulacao.Width - 10) div 5;

  lsvFormulacao.Columns.Add;
  lsvFormulacao.Columns.Items[4].Alignment := taRightJustify;
  lsvFormulacao.Columns.Items[4].Caption   := 'Embalagem';
  lsvFormulacao.Columns.Items[4].Width     := (lsvFormulacao.Width - 10) div 5;
end;
{$ENDIF}

procedure TFormulaImobiliariaAlv.PreencheAcrescimoMaoObra(
  const dtsCadTin: IDataSet);
begin
  Self.AcrMob := dtsCadTin.FieldByName('ALV_ACRMOB').AsFloat;
end;

end.
