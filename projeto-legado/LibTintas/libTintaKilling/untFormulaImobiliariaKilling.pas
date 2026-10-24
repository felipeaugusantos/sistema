{***********************************************************************}
{* Classe responsável pelas rotidas especificas de uma formula Killing *}
{********************************************************************PH*}
unit untFormulaImobiliariaKilling;

interface

uses
{$IFNDEF LINUX}
  Vcl.ComCtrls,
  Forms,
{$ENDIF}
  untAbstractFormulaImobiliaria, untICalculadorFormulaImobiliaria, untIDataSet, untColorante,
  SysUtils, Classes, untAbstractFormula, untStrUtils;

type
  TFormulaImobiliariaKilling = class(TAbstractFormulaImobiliaria)
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
    function fMostraQuantidadeAutomatica(const fltQtdCol: Double): Boolean; override;
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
  untAbstractCalculadorFormulaImobiliaria, untAutcomTintaFactory, untLibTintaFactory;

{ TFormulaImobiliariaKilling }

procedure TFormulaImobiliariaKilling.CarregaPrecosColorantesAdicional(const dataSetColorantes: IDataSet; const colorante: TColorante);
begin
  Colorante.Embalagem := dataSetColorantes.FieldByName('COL_EMBALA').AsFloat;
end;

procedure TFormulaImobiliariaKilling.CarregarColorantes;
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

function TFormulaImobiliariaKilling.fAlteraFormulacao: Boolean;
begin
  Result := True;
end;

function TFormulaImobiliariaKilling.fMostraQuantidadeAutomatica(const fltQtdCol: Double): Boolean;
begin
  Result := True;
end;

function TFormulaImobiliariaKilling.fMostraQuantidadeEmOnca(
  var strOnca: String; const fltQtdCol: Double): Boolean;
begin
  Result := False;

  strOnca := TLibTintaFactory.GetLibTinta.MlParaOnca(fltQtdCol);
end;

function TFormulaImobiliariaKilling.GetCalculadorInterno: ICalculadorFormulaImobiliaria;
begin
  Result := TAbstractCalculadorFormulaImobiliaria.Create(Self);
end;

function TFormulaImobiliariaKilling.GetChaveIteTin(const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('KIL_MD5KEY').AsString;
end;

function TFormulaImobiliariaKilling.GetDescricao(const dtsCadTin: IDataSet): String;
begin
  Result := dtsCadTin.FieldByName('KIL_DESCRI').AsString + ' ' +
            dtsCadTin.FieldByName('KIL_CODFML').AsString + ' ' +
            dtsCadTin.FieldByName('KIL_CODUNI').AsString;
end;

function TFormulaImobiliariaKilling.GetFatorEstoque: Double;
begin
  Result := (29.5735 / 48);
end;

function TFormulaImobiliariaKilling.GetIdePro: String;
begin
  Result := 'KIL';
end;

function TFormulaImobiliariaKilling.GetItemBaseOriginal(const strIteTin: String): String;
var
  qryGen: IDataSet;
begin
  qryGen := nil;
  Result := '';

  Try
    Try
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      qryGen.SQL := ' SELECT B.BAS_CODITE                                       '+
                    '   FROM KILD_CADKIL F                                      '+
                    ' INNER JOIN KILD_CADBAS B ON F.KIL_CODBAS = B.BAS_CODBAS   '+
                    '                         AND F.KIL_CODUNI = B.BAS_CODUNI   '+
                    '                         AND F.KIL_CODFML = B.BAS_CODFML   '+
                    ' WHERE F.KIL_MD5KEY  = :ITETIN                             ';

      qryGen.ParamByName('ITETIN').AsString := strIteTin;
      qryGen.Open;

      if not qryGen.IsEmpty then
        Result := qryGen.FieldByName('BAS_CODITE').AsString;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
  End;
end;

function TFormulaImobiliariaKilling.GetNomeCampoBaseCodIte: String;
begin
  Result := 'BAS_CODITE';
end;

function TFormulaImobiliariaKilling.GetNomeCampoCustoBase: String;
begin
  Result := 'BAS_PRECUS';
end;

function TFormulaImobiliariaKilling.GetNomeCampoVendaBase: String;
begin
  Result := 'BAS_PREVEN';
end;

function TFormulaImobiliariaKilling.GetNomeTabelaBase: String;
begin
  Result := 'KILD_CADBAS';
end;

function TFormulaImobiliariaKilling.GetNomeCampoColDesCol: string;
begin
  Result := 'COL_DESCRI';
end;

function TFormulaImobiliariaKilling.GetNomeTabelaColorantes: String;
begin
  Result := 'KILD_CADCOL';
end;

function TFormulaImobiliariaKilling.GetPrefixoFormulacao: String;
begin
  Result := 'KIL_FORM';
end;

function TFormulaImobiliariaKilling.GetPrefixoQuantidade(const strModo: String): String;
begin
  Result := 'KIL_QTDB';
end;

function TFormulaImobiliariaKilling.GetProdutoBaseFormula(const dtsCadTin: IDataSet): String;
var
  dtsGen: IDataSet;
begin
  Try
    Try
      dtsGen := TAutcomTintaFactory.Get.fGetDataSet;
      dtsGen.SQL :=
        ' SELECT                      ' +
        '   BAS_CODITE                ' +
        ' FROM                        ' +
        '   KILD_CADBAS               ' +
        ' WHERE BAS_CODBAS = :CODBAS  ' +
        '   AND BAS_CODUNI = :CODUNI  ' +
        '   AND BAS_CODFML = :FORMULA ';

      dtsGen.ParamByName('CODBAS').AsString := dtsCadTin.FieldByName('KIL_CODBAS').AsString;
      dtsGen.ParamByName('CODUNI').AsString := dtsCadTin.FieldByName('KIL_CODUNI').AsString;
      dtsGen.ParamByName('FORMULA').AsString := dtsCadTin.FieldByName('KIL_CODFML').AsString;
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

function TFormulaImobiliariaKilling.GetQuantidadeFormulacao: Integer;
begin
  Result := 20;
end;

function TFormulaImobiliariaKilling.GetTextoInformativoCalculo: String;
begin
  Result :=
    'Valor da Base    = ' + FloatToStrF(BasePrecoVenda, ffFixed, 12, 2) + sLineBreak +
    'Valor Colorantes = (Quantidade * (29.5735 / 48)) * (Preço / Embalagem) ' + sLineBreak +
    'Valor da Tinta   = Valor da Base + (Soma do Valor dos Colorantes)';
end;


function TFormulaImobiliariaKilling.GetUnidade(const dtsCadTin: IDataSet): String;
begin
  Result := dtsCadTin.FieldByName('KIL_CODUNI').AsString;
end;

{$IFNDEF LINUX}
procedure TFormulaImobiliariaKilling.pAddItemsFormulacao(
  lsvFormulacao: TListView; Formula: TAbstractFormula);
Var
  Colorante : TColorante;
  intContador: Integer;
begin
  For intContador := 0 To formula.Count - 1 Do
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

      subItems.Add(FloatToStrF(colorante.Quantidade * 4 , ffFixed, 12, 2));
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
procedure TFormulaImobiliariaKilling.pAjustaFormulacao(lsvFormulacao: TListView;
  Form: TForm);
begin
  lsvFormulacao.Columns.Clear;
  Form.ClientWidth := 600;

  With lsvFormulacao.Columns.Add Do
  Begin
    Alignment := taRightJustify;
    Caption   := 'Colorante';
    Width := (lsvFormulacao.Width - 10) div 5;
  End;

  With lsvFormulacao.Columns.Add Do
  Begin
    Alignment := taRightJustify;
    Caption   := 'Auto';
    Width := (lsvFormulacao.Width - 10) div 5;
  End;

  With lsvFormulacao.Columns.Add Do
  Begin
    Alignment := taRightJustify;
    Caption   := 'Manual';
    Width := (lsvFormulacao.Width - 10) div 5;
  End;

  With lsvFormulacao.Columns.Add Do
  Begin
    Alignment := taRightJustify;
    Caption   := 'Pre'#231'o';
    Width := (lsvFormulacao.Width - 10) div 5;
  End;

  With lsvFormulacao.Columns.Add Do
  Begin
    Alignment := taRightJustify;
    Caption   := 'Embalagem';
    Width := (lsvFormulacao.Width - 10) div 5;
  End;
end;
{$ENDIF}

procedure TFormulaImobiliariaKilling.PreencheAcrescimoMaoObra(
  const dtsCadTin: IDataSet);
begin
  Self.AcrMob := dtsCadTin.FieldByName('KIL_ACRMOB').AsFloat;
end;

end.
