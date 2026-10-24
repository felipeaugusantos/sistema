{************************************************************************************}
{* Classe responsável pelas rotidas especificas de uma formula Brasimix Imobiliaria *}
{******************************************************************************** PH*}
unit untFormulaImobiliariaBrasimixImobiliaria;

interface

uses
  untAbstractFormulaImobiliaria, untICalculadorFormulaImobiliaria, untIDataSet, untColorante,
  SysUtils, untITintaDeMaquinaComponente, untStrUtils, Vcl.ComCtrls, Vcl.Forms, untAbstractFormula,
  Classes;

type
  TFormulaImobiliariaBrasimixImobiliaria = class(TAbstractFormulaImobiliaria)
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
  {$ENDIF}
  {$IFNDEF LINUX}
    procedure pAddItemsFormulacao(lsvFormulacao: TListView; Formula: TAbstractFormula); Override;
  {$ENDIF}
  function fAlteraFormulacao(): Boolean; Override;
  end;

implementation

uses
  untCalculadorFormulaImobiliariaBrasimixImobiliaria, untAutcomTintaFactory, untMultiSelectLocalizadorFactory;

{ TFormulaImobiliariaBrasimixImobiliaria }

procedure TFormulaImobiliariaBrasimixImobiliaria.CarregaPrecosColorantesAdicional(const dataSetColorantes: IDataSet; const colorante: TColorante);
begin
  colorante.PesoEspecifico := dataSetColorantes.FieldByName('COL_PESESP').AsFloat;

  If colorante.PesoEspecifico <= 0 Then
    colorante.PesoEspecifico := 1;

  colorante.Embalagem := dataSetColorantes.FieldByName('COL_EMBALA').AsFloat;
end;

procedure TFormulaImobiliariaBrasimixImobiliaria.CarregarColorantes;
var
  strSql: String;
begin
  strSql :=
    ' SELECT         ' +
    '     COL_CODCOL ' +
    '   , COL_CODITE ' +
    '   , COL_PESESP ' +
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
  Else
    strSql := strSql  + '   , G.ITE_IMPDIR  ';

  If (TAutcomTintaFactory.Get.fCfgSis('PREGER') = '0') Then
  Begin
    strSql := strSql +
      '   , COL_PRECUS AS ITE_PRECUS ' +
      '   , COL_PREVEN AS ITE_PREVEN ';
  End
  Else If (TAutcomTintaFactory.Get.fCfgSis('PREGER') = '1') And (BlnCalculaUnitario) Then
  Begin
    strSql := strSql +
      '   , ITE_PRECUS               ' +
      '   , ITE_PREVE' + TAutcomTintaFactory.Get.fCfgSis('TABPRE') + ' AS ITE_PREVEN ';
  End
  Else
  Begin
    strSql := strSql +
      '   , ITE_PRECUS               ' +
      '   , ITE_PREVE' + Self.strTabPre + ' AS ITE_PREVEN ';
  End;

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
  Else If (Not TStrUtils.fEmptyStr(Self.EmpCd_)) And (Self.CD_S_N = 'S') Then
    GetDataSetColorantes.ParamByName('CODEMP').AsString := Self.EmpCd_
  Else If (Not TStrUtils.fEmptyStr(Self.EmpFat)) And (Self.FatS_N = 'S') Then
    GetDataSetColorantes.ParamByName('CODEMP').AsString := Self.EmpFat
  Else
    GetDataSetColorantes.ParamByName('CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;

  GetDataSetColorantes.Open;
end;

function TFormulaImobiliariaBrasimixImobiliaria.fAlteraFormulacao: Boolean;
begin
  Result := True;
end;

function TFormulaImobiliariaBrasimixImobiliaria.GetCalculadorInterno: ICalculadorFormulaImobiliaria;
begin
  Result := TCalculadorFormulaImobiliariaBrasimixImobiliaria.Create(Self);
end;

function TFormulaImobiliariaBrasimixImobiliaria.GetChaveIteTin(const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('BZI_MD5KEY').AsString;
end;

function TFormulaImobiliariaBrasimixImobiliaria.GetDescricao(const dtsCadTin: IDataSet): String;
begin
  Result := dtsCadTin.FieldByName('BZI_DESCRI').AsString;
end;

function TFormulaImobiliariaBrasimixImobiliaria.GetFatorEstoque: Double;
begin
  Result := 1;
end;

function TFormulaImobiliariaBrasimixImobiliaria.GetIdePro: String;
begin
  Result := 'BZI';
end;

function TFormulaImobiliariaBrasimixImobiliaria.GetItemBaseOriginal(const strIteTin: String): String;
var
  qryGen: IDataSet;
begin
  Result := '';
  Try
    Try
      If TMultiSelectLocalizadorFactory.GetLocalizador('BZIBAS').Localizar(qryGen, ['ITETIN'], [strIteTin]) Then
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

function TFormulaImobiliariaBrasimixImobiliaria.GetNomeCampoBaseCodIte: String;
begin
  Result := 'BAS_CODITE';
end;

function TFormulaImobiliariaBrasimixImobiliaria.GetNomeCampoColDesCol: string;
begin
  Result := '';
end;

function TFormulaImobiliariaBrasimixImobiliaria.GetNomeCampoCustoBase: String;
begin
  Result := 'BAS_PRECUS';
end;

function TFormulaImobiliariaBrasimixImobiliaria.GetNomeCampoVendaBase: String;
begin
  Result := 'BAS_PREVEN';
end;

function TFormulaImobiliariaBrasimixImobiliaria.GetNomeTabelaBase: String;
begin
  Result := 'BZI_CADBAS';
end;

function TFormulaImobiliariaBrasimixImobiliaria.GetNomeTabelaColorantes: String;
begin
  Result := 'BZI_CADCOL';
end;

function TFormulaImobiliariaBrasimixImobiliaria.GetPrefixoFormulacao: String;
begin
  Result := 'BZI_CODC';
end;

function TFormulaImobiliariaBrasimixImobiliaria.GetPrefixoQuantidade(const strModo: String): String;
begin
  Result := 'BZI_QTDC';
end;

function TFormulaImobiliariaBrasimixImobiliaria.GetProdutoBaseFormula(const dtsCadTin: IDataSet): String;
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
        '   BZI_CADBAS               ' +
        ' WHERE                      ' +
        '   BAS_LINHA_ = :LINHA_ AND ' +
        '   BAS_BASE__ = :CODBAS AND ' +
        '   BAS_UNIDAD = :CODUNI AND ' +
        '   BAS_DESCRI = :DESCRI AND ' +
        '   BAS_EMBALA = :EMBALA     ';

      dtsGen.ParamByName('LINHA_').AsString := dtsCadTin.FieldByName('BZI_LINHA_').AsString;
      dtsGen.ParamByName('CODBAS').AsString := dtsCadTin.FieldByName('BZI_CODBAS').AsString;
      dtsGen.ParamByName('CODUNI').AsString := dtsCadTin.FieldByName('BZI_CODUNI').AsString;
      dtsGen.ParamByName('DESCRI').AsString := dtsCadTin.FieldByName('BZI_DESCRI').AsString;
      dtsGen.ParamByName('EMBALA').AsFloat  := dtsCadTin.FieldByName('BZI_EMBALA').AsFloat;
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

function TFormulaImobiliariaBrasimixImobiliaria.GetQuantidadeFormulacao: Integer;
begin
  Result := 20;
end;

function TFormulaImobiliariaBrasimixImobiliaria.GetTextoInformativoCalculo: String;
begin
  Result :=
    'Valor da Base = ' + FloatToStrF(BasePrecoVenda, ffFixed, 12, 2) + sLineBreak +
    'Valor do Colorante = (Quantidade / Peso Específico Colorante) * (Preço / Embalagem) ' + sLineBreak +
    'Valor da Tinta = Valor da Base + (Soma do Valor do Colorante de todos os Colorantes)';
end;

function TFormulaImobiliariaBrasimixImobiliaria.GetUnidade(
  const dtsCadTin: IDataSet): String;
begin
  Result := dtsCadTin.FieldByName('BZI_CODUNI').AsString;
end;

{$IFNDEF LINUX}
procedure TFormulaImobiliariaBrasimixImobiliaria.pAddItemsFormulacao(
  lsvFormulacao: TListView; Formula: TAbstractFormula);
Var
  Colorante: TColorante;
  intContador: Integer;
begin
  For intContador := 0 To formula.Count - 1 Do
  Begin
    colorante := TColorante(formula.Items[intContador]);

    With lsvFormulacao.Items.Add Do
    Begin
      If colorante.DescricaoColorante <> '' Then
        Caption := colorante.CodigoColorante + ' - '+ colorante.DescricaoColorante
      Else
        Caption := colorante.CodigoColorante;


      SubItems.Add(FloatToStrF(Colorante.Quantidade, ffFixed, 12, 3));
      SubItems.Add(FloatToStrF(Colorante.Quantidade / Colorante.PesoEspecifico, ffFixed, 12, 3));
      SubItems.Add(FloatToStrF(Colorante.PrecoVenda, ffFixed, 12, 6));
      SubItems.Add(FloatToStrF(Colorante.PesoEspecifico, ffFixed, 12, 4));
      SubItems.Add(FloatToStrF(Colorante.Embalagem, ffFixed, 12, 4));
    End;
  End;
end;

procedure TFormulaImobiliariaBrasimixImobiliaria.pAjustaFormulacao(
  lsvFormulacao: TListView; Form: TForm);
begin
  lsvFormulacao.Columns.Clear;
  Form.ClientWidth := 650;

  With lsvFormulacao.Columns.Add Do
  Begin
    Alignment := taRightJustify;
    Caption   := 'Colorante';
    Width     := (lsvFormulacao.Width - 10) div 6;
  End;

  With lsvFormulacao.Columns.Add Do
  Begin
    Alignment := taRightJustify;
    Caption   := 'Quantidade(G)';
    Width     := (lsvFormulacao.Width - 10) div 6;
  End;

  With lsvFormulacao.Columns.Add Do
  Begin
    Alignment := taRightJustify;
    Caption   := 'Quantidade(ML)';
    Width     := (lsvFormulacao.Width - 10) div 6;
  End;

  With lsvFormulacao.Columns.Add Do
  Begin
    Alignment := taRightJustify;
    Caption   := 'Preço';
    Width     := (lsvFormulacao.Width - 10) div 6;
  End;

  With lsvFormulacao.Columns.Add Do
  Begin
    Alignment := taRightJustify;
    Caption   := 'Peso Específico';
    Width     := (lsvFormulacao.Width - 10) div 6;
  End;

  With lsvFormulacao.Columns.Add Do
  Begin
    Alignment := taRightJustify;
    Caption   := 'Embalagem';
    Width     := (lsvFormulacao.Width - 10) div 6;
  End;
end;
{$ENDIF LINUX}

end.
