{ ******************************************************************************** }
{ * Classe responsável pelas rotidas especificas de uma formula GlobalColor * }
{ *****************************************************************************AC* }
unit untFormulaImobiliariaGlobalColor;

interface

uses
{$IFNDEF LINUX}
  Vcl.ComCtrls,
  Forms,
{$ENDIF}
  untAbstractFormulaImobiliaria, untICalculadorFormulaImobiliaria, untIDataSet,
  untColorante, SysUtils,  Classes, untAbstractFormula, untStrUtils;

type
  TFormulaImobiliariaGlobalColor = class(TAbstractFormulaImobiliaria)
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
    function fMostraQuantidadeEmOnca(Var strOnca: String;
      const fltQtdCol: Double): Boolean; override;
  {$IFNDEF LINUX}
    procedure pAjustaFormulacao(lsvFormulacao: TListView; Form: TForm); Override;
  {$ENDIF}
  {$IFNDEF LINUX}
    procedure pAddItemsFormulacao(lsvFormulacao: TListView; Formula: TAbstractFormula); Override;
  {$ENDIF}
    function fAlteraFormulacao(): Boolean; Override;
    procedure PreencheAcrescimoMaoObra(const dtsCadTin: IDataSet); Override;
  end;

implementation

uses
  untAbstractCalculadorFormulaImobiliaria, untAutcomTintaFactory,
  untMultiSelectLocalizadorFactory;

{ TFormulaImobiliariaGlobalColor }

procedure TFormulaImobiliariaGlobalColor.CarregaPrecosColorantesAdicional
  (const dataSetColorantes: IDataSet; const colorante: TColorante);
begin
  colorante.Embalagem := dataSetColorantes.FieldByName('COL_EMBALA').AsFloat;
end;

procedure TFormulaImobiliariaGlobalColor.CarregarColorantes;
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

  strSql := strSql + '   , IFNULL(ITE_ITEATI, "N") ITE_ITEATI      ' +
    '   , ITE_CNV_ML ' + '   , ITE_OUTVAL ' + '   , ITE_ICMSAI ' +
    '   , ITE_IMPFED ' + '   , ITE_DESOPE ' + '   , ITE_PREMED ' +
    '   , ITE_IMPULT ' + '   , ITE_PREULT ' +

    '   , ITE_PRECOM ' + '   , ITE_DESF01 ' + '   , ITE_DESF02 ' +
    '   , ITE_DESF03 ' + '   , ITE_DESF04 ' + '   , ITE_DESF05 ' +
    '   , ITE_DESF06 ';

  If TAutcomTintaFactory.Get.fCfgSis('IMPDIG') = '1' Then
    strSql := strSql + '   , I.ITE_IMPDIR  '
  else
    strSql := strSql + '   , G.ITE_IMPDIR  ';

  If (TAutcomTintaFactory.Get.fCfgSis('PREGER') = '0') Then
  begin
    strSql := strSql + '   , COL_PRECUS AS ITE_PRECUS ' +
      '   , COL_PREVEN AS ITE_PREVEN ';
  end

  Else If (TAutcomTintaFactory.Get.fCfgSis('PREGER') = '1') And BlnCalculaUnitario Then
  begin
    strSql := strSql + '   , ITE_PRECUS               ' +
                       '   , ITE_PREVE' + TAutcomTintaFactory.Get.fCfgSis('TABPRE') + ' AS ITE_PREVEN ';
  end
  else
  begin
    strSql := strSql + '   , ITE_PRECUS               ' + '   , ITE_PREVE' +
      Self.strTabPre + ' AS ITE_PREVEN ';
  end;

  strSql := strSql + ' FROM                               ' + '   ' +
    GetNomeTabelaColorantes + ' C                     ' +
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

function TFormulaImobiliariaGlobalColor.fAlteraFormulacao: Boolean;
begin
  Result := True;
end;

function TFormulaImobiliariaGlobalColor.fMostraQuantidadeEmOnca(
  var strOnca: String; const fltQtdCol: Double): Boolean;
Var
  fltInteiroOnca: Double;
  fltFracaoOnca: Double;
  fltCalculo: Double;
Begin
  Result := True;
  fltCalculo := (fltQtdCol / 48) / 0.616125;
  fltInteiroOnca := Trunc(fltCalculo);
  fltFracaoOnca  := TAutcomTintaFactory.Get.fStrToFloat(FormatFloat('0.000', (fltCalculo - fltInteiroOnca) * 48));  //Frac(fltInteiroOnca);
  strOnca        := Format('%dY%.1f', [Trunc(fltInteiroOnca), fltFracaoOnca]);
End;

function TFormulaImobiliariaGlobalColor.GetCalculadorInterno
  : ICalculadorFormulaImobiliaria;
begin
  Result := TAbstractCalculadorFormulaImobiliaria.Create(Self);
end;

function TFormulaImobiliariaGlobalColor.GetChaveIteTin(const dtsCadTin
  : IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('GLO_MD5KEY').AsString
end;

function TFormulaImobiliariaGlobalColor.GetDescricao(const dtsCadTin
  : IDataSet): String;
begin
  Result := dtsCadTin.FieldByName('GLO_PRODUT').AsString;
end;

function TFormulaImobiliariaGlobalColor.GetFatorEstoque: Double;
begin
  Result := 1;
end;

function TFormulaImobiliariaGlobalColor.GetIdePro: String;
begin
  Result := 'GLO';
end;

function TFormulaImobiliariaGlobalColor.GetItemBaseOriginal(const strIteTin
  : String): String;
var
  qryGen: IDataSet;
begin
  qryGen := nil;
  Result := '';
  Try
    Try
      If TMultiSelectLocalizadorFactory.GetLocalizador('GLOBAS')
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

function TFormulaImobiliariaGlobalColor.GetNomeCampoBaseCodIte: String;
begin
  Result := 'BAS_CODITE';
end;

function TFormulaImobiliariaGlobalColor.GetNomeCampoCustoBase: String;
begin
  Result := 'BAS_PRECUS';
end;

function TFormulaImobiliariaGlobalColor.GetNomeCampoVendaBase: String;
begin
  Result := 'BAS_PREVEN';
end;

function TFormulaImobiliariaGlobalColor.GetNomeTabelaBase: String;
begin
  Result := 'GLO_CADBAS';
end;

function TFormulaImobiliariaGlobalColor.GetNomeCampoColDesCol: string;
begin
  Result := 'COL_DESCRI';
end;

function TFormulaImobiliariaGlobalColor.GetNomeTabelaColorantes: String;
begin
  Result := 'GLO_CADCOL';
end;

function TFormulaImobiliariaGlobalColor.GetPrefixoFormulacao: String;
begin
  Result := 'GLO_FORM';
end;

function TFormulaImobiliariaGlobalColor.GetPrefixoQuantidade(const strModo
  : String): String;
begin
  Result := 'GLO_QTDC';
end;

function TFormulaImobiliariaGlobalColor.GetProdutoBaseFormula(const dtsCadTin
  : IDataSet): String;
var
  dtsGen: IDataSet;
begin
  Try
    Try
      dtsGen := TAutcomTintaFactory.Get.fGetDataSet;
      dtsGen.SQL := ' SELECT                     ' +
        '   BAS_CODITE               ' + ' FROM                       ' +
        '   GLO_CADBAS               ' + ' WHERE BAS_BASE__ = :CODBAS ' +
        '   AND BAS_UNIDAD = :CODUNI ' + '  AND BAS_DESCRI = :DESCRI  ';

      dtsGen.ParamByName('CODBAS').AsString :=
        dtsCadTin.FieldByName('GLO_CODBAS').AsString;
      dtsGen.ParamByName('CODUNI').AsString :=
        dtsCadTin.FieldByName('GLO_UNIDAD').AsString;
      dtsGen.ParamByName('DESCRI').AsString :=
        dtsCadTin.FieldByName('GLO_PRODUT').AsString;
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

function TFormulaImobiliariaGlobalColor.GetQuantidadeFormulacao: Integer;
begin
  Result := 20;
end;

function TFormulaImobiliariaGlobalColor.GetTextoInformativoCalculo: String;
begin
  Result := 'Valor da Base = ' + FloatToStrF(BasePrecoVenda, ffFixed, 12, 2) +
    sLineBreak +
    'Quantidade em ML = (Parte Inteira * 29.5735295625) + (Parte Fração * 0.61611520)' +
    sLineBreak +
    'Valor do Colorante = Quantidade * (Preço / Embalagem) ' +
    sLineBreak +
    'Valor da Tinta = Valor da Base + (Soma do Valor do Colorante de todos os Colorantes)';
end;

function TFormulaImobiliariaGlobalColor.GetUnidade(const dtsCadTin: IDataSet): String;
begin
  Result := dtsCadTin.FieldByName('GLO_UNIDAD').AsString;
end;

{$IFNDEF LINUX}
procedure TFormulaImobiliariaGlobalColor.pAddItemsFormulacao(
  lsvFormulacao: TListView; Formula: TAbstractFormula);
Var
  Colorante : TColorante;
  intContador: Integer;
  strOnca:String;
begin
  For intContador := 0 To formula.Count-1 Do
  Begin
    colorante := TColorante(formula.Items[intContador]);

    If Colorante.Embalagem <= 0 Then
      lsvFormulacao.Columns[4].Caption := '';

    If Colorante.PesoEspecifico > 0 Then
      lsvFormulacao.Columns[4].Caption := 'Peso Específico';

    With lsvFormulacao.Items.Add Do
    Begin

      If colorante.DescricaoColorante <> '' Then
        Caption := colorante.CodigoColorante + ' - '+ colorante.DescricaoColorante
      Else
        Caption := colorante.CodigoColorante;

      If fMostraQuantidadeEmOnca(strOnca, colorante.Quantidade) Then
        SubItems.Add(strOnca);

      SubItems.Add(FloatToStrF(colorante.Quantidade, ffFixed, 12, 3));
      SubItems.Add(FloatToStrF(colorante.PrecoVenda, ffFixed, 12, 6));

      If Colorante.PesoEspecifico > 0 Then
        SubItems.Add(FloatToStrF(Colorante.PesoEspecifico, ffFixed, 12, 4))
      Else If Colorante.Embalagem > 0 Then
        SubItems.Add(FloatToStrF(Colorante.Embalagem, ffFixed, 12, 4));
    End;
  End;
end;
{$ENDIF}

{$IFNDEF LINUX}
procedure TFormulaImobiliariaGlobalColor.pAjustaFormulacao(
  lsvFormulacao: TListView; Form: TForm);
begin
  Form.ClientWidth := 600;
  lsvFormulacao.Columns.Clear;

  With lsvFormulacao.Columns.Add Do
  Begin
    Alignment := taRightJustify;
    Caption   := 'Colorante';
    Width     := (lsvFormulacao.Width - 10) div 5;
  End;

  With lsvFormulacao.Columns.Add Do
  Begin
    Alignment := taRightJustify;
    Caption   := 'Quantidade(Onças)';
    Width     := (lsvFormulacao.Width - 10) div 5;
  End;

  With lsvFormulacao.Columns.Add Do
  Begin
    Alignment := taRightJustify;
    Caption   := 'Quantidade(Ml)';
    Width     := (lsvFormulacao.Width - 10) div 5;
  End;

  With lsvFormulacao.Columns.Add Do
  Begin
    Alignment := taRightJustify;
    Caption   := 'Pre'#231'o';
    Width     := (lsvFormulacao.Width - 10) div 5;
  End;

  With lsvFormulacao.Columns.Add Do
  Begin
    Alignment := taRightJustify;
    Caption   := 'Embalagem';
    Width     := (lsvFormulacao.Width - 10) div 5;
  End;
end;
{$ENDIF}

procedure TFormulaImobiliariaGlobalColor.PreencheAcrescimoMaoObra(
  const dtsCadTin: IDataSet);
begin
  Self.AcrMob := dtsCadTin.FieldByName('GLO_ACRMOB').AsFloat;
end;

end.
