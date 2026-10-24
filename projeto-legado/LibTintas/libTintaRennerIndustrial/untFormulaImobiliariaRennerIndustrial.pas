{********************************************************************************}
{* Classe responsável pelas rotidas especificas de uma formula RennerIndustrial *}
{*****************************************************************************AC*}
unit untFormulaImobiliariaRennerIndustrial;

interface

uses
{$IFNDEF LINUX}
  Vcl.ComCtrls,
  Forms,
{$ENDIF}
  untAbstractFormulaImobiliaria, untICalculadorFormulaImobiliaria, untIDataSet, untColorante,
  SysUtils, Classes, untAbstractFormula, untStrUtils;

type
  TFormulaImobiliariaRennerIndustrial = class(TAbstractFormulaImobiliaria)
  Private
    function fCalculaOnca(Quantidade: Double): String;
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
    procedure CarregarColorantes; override;
  {$IFNDEF LINUX}
    procedure pAjustaFormulacao(lsvFormulacao: TListView; Form: TForm); Override;
    procedure pAddItemsFormulacao(lsvFormulacao: TListView; Formula: TAbstractFormula); Override;
  {$ENDIF}
    function fAlteraFormulacao(): Boolean; Override;
    procedure PreencheAcrescimoMaoObra(const dtsCadTin: IDataSet); Override;
  end;

implementation

uses
  untAbstractCalculadorFormulaImobiliaria, untAutcomTintaFactory,
  untMultiSelectLocalizadorFactory;

{ TFormulaImobiliariaRennerIndustrial }

procedure TFormulaImobiliariaRennerIndustrial.CarregaPrecosColorantesAdicional(const dataSetColorantes: IDataSet; const colorante: TColorante);
begin
  colorante.Embalagem := dataSetColorantes.FieldByName('COL_EMBALA').AsFloat;
end;

procedure TFormulaImobiliariaRennerIndustrial.CarregarColorantes;
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

function TFormulaImobiliariaRennerIndustrial.fAlteraFormulacao: Boolean;
begin
  Result := True;
end;

function TFormulaImobiliariaRennerIndustrial.fCalculaOnca(
  Quantidade: Double): String;
Var
  strDosadora  : String;
  strValor     : String;
  strValorY    : String;
  strValorX    : String;

  fltValorY    : Double;
  fltValorX    : Double;
  fltFracao    : Double;
  fltFracaoY   : Double;
  fltResult    : Double;
  fltDosadora  : Double;
begin
  strValorY := '';
  strValorX := '';
  strDosadora := '';

  // 1ª PARTE: DESCOBRIR O 'Y'

  fltValorY := Trunc((Quantidade / 0.616) / 48);

  // 2ª PARTE: DESCOBRIR A FRAÇÃO '/48'

  fltFracao  := (Quantidade / 0.616);
  fltFracaoY :=  fltValorY * 48;
  fltValorX  := (fltFracao - fltFracaoY);

  // 3ª PARTE: DESCOBRIR A FRAÇÃO '/96'

  fltResult := Quantidade - (fltValorY * 29.57) - (Trunc(fltValorX) * 0.616);
  fltDosadora :=  fltResult / 0.308;

  If Trunc(fltValorX) > 0 Then
    strValorX := FloatToStr(Trunc(fltValorX));

  If Trunc(fltDosadora) > 0 Then
    strDosadora := IntToStr(Trunc(fltDosadora)) + '/96';

  If fltValorY > 0 Then
    strValorY := FloatToStr(fltValorY) + 'Y';

  If Not TStrUtils.fEmptyStr(strValorY) Then
    strValor := strValorY;

  If Not TStrUtils.fEmptyStr(strValorX) Then
    strValor := strValor + ' ' + strValorX;

  If Not TStrUtils.fEmptyStr(strDosadora) Then
    strValor := strValor + ' ' + strDosadora;

  Result := strValor;
end;

function TFormulaImobiliariaRennerIndustrial.GetCalculadorInterno: ICalculadorFormulaImobiliaria;
begin
  Result := TAbstractCalculadorFormulaImobiliaria.Create(Self);
end;

function TFormulaImobiliariaRennerIndustrial.GetChaveIteTin(const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('REN_MD5KEY').AsString
end;

function TFormulaImobiliariaRennerIndustrial.GetDescricao(const dtsCadTin: IDataSet): String;
begin
  Result := dtsCadTin.FieldByName('REN_DESCRI').AsString;
end;

function TFormulaImobiliariaRennerIndustrial.GetFatorEstoque: Double;
begin
  Result := 1;
end;

function TFormulaImobiliariaRennerIndustrial.GetIdePro: String;
begin
  Result := 'REN';
end;

function TFormulaImobiliariaRennerIndustrial.GetItemBaseOriginal(const strIteTin: String): String;
var
  qryGen: IDataSet;
begin
  qryGen := nil;
  Result := '';
  Try
    Try
      If TMultiSelectLocalizadorFactory.GetLocalizador('RENBAS')
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

function TFormulaImobiliariaRennerIndustrial.GetNomeCampoBaseCodIte: String;
begin
  Result := 'BAS_CODITE';
end;

function TFormulaImobiliariaRennerIndustrial.GetNomeCampoCustoBase: String;
begin
  Result := 'BAS_PRECUS';
end;

function TFormulaImobiliariaRennerIndustrial.GetNomeCampoVendaBase: String;
begin
  Result := 'BAS_PREVEN';
end;

function TFormulaImobiliariaRennerIndustrial.GetNomeTabelaBase: String;
begin
  Result := 'REN_CADBAS';
end;

function TFormulaImobiliariaRennerIndustrial.GetNomeCampoColDesCol: string;
begin
  Result := 'COL_DESCRI';
end;

function TFormulaImobiliariaRennerIndustrial.GetNomeTabelaColorantes: String;
begin
  Result := 'REN_CADCOL';
end;

function TFormulaImobiliariaRennerIndustrial.GetPrefixoFormulacao: String;
begin
  Result := 'REN_FORM';
end;

function TFormulaImobiliariaRennerIndustrial.GetPrefixoQuantidade(const strModo: String): String;
begin
  Result := 'REN_QTDC';
end;

function TFormulaImobiliariaRennerIndustrial.GetProdutoBaseFormula(const dtsCadTin: IDataSet): String;
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
        '   REN_CADBAS               ' +
        ' WHERE BAS_BASE__ = :CODBAS ' +
        '   AND BAS_UNIDAD = :CODUNI ';

      dtsGen.ParamByName('CODBAS').AsString := dtsCadTin.FieldByName('REN_CODBAS').AsString;
      dtsGen.ParamByName('CODUNI').AsString := dtsCadTin.FieldByName('REN_UNIDAD').AsString;
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

function TFormulaImobiliariaRennerIndustrial.GetQuantidadeFormulacao: Integer;
begin
  Result := 20;
end;

function TFormulaImobiliariaRennerIndustrial.GetTextoInformativoCalculo: String;
begin
  Result :=
    'Valor da Base = ' + FloatToStrF(BasePrecoVenda, ffFixed, 12, 2) + sLineBreak +
    'Valor do Colorante = (Quantidade * Preço) / Embalagem ' + sLineBreak +
    'Valor da Tinta = Valor da Base + (Soma do Valor do Colorante de todos os Colorantes)';
end;

function TFormulaImobiliariaRennerIndustrial.GetUnidade(const dtsCadTin: IDataSet): String;
begin
  Result := dtsCadTin.FieldByName('REN_UNIDAD').AsString;
end;

{$IFNDEF LINUX}
procedure TFormulaImobiliariaRennerIndustrial.pAddItemsFormulacao(
  lsvFormulacao: TListView; Formula: TAbstractFormula);
Var
  Colorante: TColorante;
  intContador: Integer;
  strOnca: String;
begin
  For intContador := 0 To Formula.Count - 1 Do
  Begin
    Colorante := TColorante(Formula.Items[intContador]);

    With lsvFormulacao.Items.Add Do
    Begin
      If Colorante.DescricaoColorante <> '' Then
        Caption := Colorante.CodigoColorante + ' - ' + Colorante.DescricaoColorante
      Else
        Caption := Colorante.CodigoColorante;

      strOnca := fCalculaOnca(Colorante.Quantidade);

      SubItems.Add(FloatToStrF(Colorante.Quantidade, ffFixed, 12, 3));
      SubItems.Add(strOnca);
      SubItems.Add(FloatToStrF(Colorante.PrecoVenda, ffFixed, 12, 6));
      SubItems.Add(FloatToStrF(Colorante.Embalagem, ffFixed, 12, 4));
    End;
  End;
end;

procedure TFormulaImobiliariaRennerIndustrial.pAjustaFormulacao(
  lsvFormulacao: TListView; Form: TForm);
begin
  Form.ClientWidth := 530;
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
    Caption   := 'Quantidade(Ml)';
    Width     := (lsvFormulacao.Width - 10) div 5;
  End;

  With lsvFormulacao.Columns.Add Do
  Begin
    Alignment := taRightJustify;
    Caption   := 'Quantidade(Onça)';
    Width     := (lsvFormulacao.Width - 10) div 5;
  End;

  With lsvFormulacao.Columns.Add Do
  Begin
    Alignment := taRightJustify;
    Caption   := 'Preço';
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

procedure TFormulaImobiliariaRennerIndustrial.PreencheAcrescimoMaoObra(
  const dtsCadTin: IDataSet);
begin
  Self.AcrMob := dtsCadTin.FieldByName('REN_ACRMOB').AsFloat;
end;

end.
