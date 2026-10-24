{***********************************************************************}
{* Classe responsável pelas rotidas especificas de uma formula SherwinWilliams2 *}
{********************************************************************PH*}
unit untFormulaImobiliariaSherwinWilliams2;

interface

uses
{$IFNDEF LINUX}
  Vcl.ComCtrls,
  Forms,
{$ENDIF}
  untAbstractFormulaImobiliaria, untICalculadorFormulaImobiliaria, untIDataSet, untColorante,
  SysUtils, Classes, untAbstractFormula, untStrUtils;

type
  TFormulaImobiliariaSherwinWilliams2 = class(TAbstractFormulaImobiliaria)
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
    function fMostraQuantidadeEmOnca(Var strOnca: String; const fltQtdCol: Double): Boolean; Override;
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

{ TFormulaImobiliariaSherwinWilliams2 }

procedure TFormulaImobiliariaSherwinWilliams2.CarregaPrecosColorantesAdicional(const dataSetColorantes: IDataSet; const colorante: TColorante);
begin
  colorante.Embalagem := dataSetColorantes.FieldByName('COL_EMBALA').AsFloat;
end;

procedure TFormulaImobiliariaSherwinWilliams2.CarregarColorantes;
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

function TFormulaImobiliariaSherwinWilliams2.fAlteraFormulacao: Boolean;
begin
  Result := True;
end;

function TFormulaImobiliariaSherwinWilliams2.fMostraQuantidadeEmOnca(
  var strOnca: String; const fltQtdCol: Double): Boolean;
Var
  fltFracao: Double;
begin
  Result := True;

  fltFracao := fltQtdCol / 0.924;

  //strOnca := TLibTintaFactory.GetLibTinta.GetQuantidadeOncaPulsoMl(fltQtdCol, intInteiro, fltFracao);
  strOnca := FloatToStrF(fltFracao, ffNumber, 12, 2);
end;

function TFormulaImobiliariaSherwinWilliams2.GetCalculadorInterno: ICalculadorFormulaImobiliaria;
begin
  Result := TAbstractCalculadorFormulaImobiliaria.Create(Self);
end;

function TFormulaImobiliariaSherwinWilliams2.GetChaveIteTin(const dtsCadTin: IDataSet): string;
begin
  Result := '';

  if Assigned(dtsCadTin.FindField('SHW_MD5KEY')) then
    Result := dtsCadTin.FieldByName('SHW_MD5KEY').AsString;

end;

function TFormulaImobiliariaSherwinWilliams2.GetDataSetMensAlerta(
  const dtsCadTin: IDataSet): IDataSet;
Var
  strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + '  SELECT                        ';
  strSQL := strSQL + '    SHW_OBSERV  AS MSG_MENSAG   ';
  strSQL := strSQL + '  FROM SHW_CADSHW               ';
  strSQL := strSQL + '  WHERE SHW_MD5KEY = :MD5KEY    ';


  Result := TAutcomTintaFactory.Get.fGetDataSet;
  Result.Close;
  Result.SQL := strSQL;
  Result.ParamByName('MD5KEY').AsString := dtsCadTin.FieldByName('SHW_MD5KEY').AsString;
  Result.Open;

  If TStrUtils.fEmptyStr(Result.FieldByName('MSG_MENSAG').AsString) Then
  Begin
    Result := Nil;
    Exit;
  End;
end;

function TFormulaImobiliariaSherwinWilliams2.GetDescricao(const dtsCadTin: IDataSet): String;
begin
  Result := dtsCadTin.FieldByName('SHW_DESCRI').AsString;
end;

function TFormulaImobiliariaSherwinWilliams2.GetFatorEstoque: Double;
begin
  Result := 1;
end;

function TFormulaImobiliariaSherwinWilliams2.GetIdePro: String;
begin
  Result := 'SHW';
end;

function TFormulaImobiliariaSherwinWilliams2.GetItemBaseOriginal(const strIteTin: String): String;
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
        '   SHW_CADBAS B                        ' +
        '   INNER JOIN SHW_CADSHW S             ' +
        '      ON B.BAS_CODBAS = S.SHW_BASE__   ' +
        '     AND B.BAS_CODUNI = S.SHW_CODUNI   ' +
        '     AND B.BAS_PRODUT = S.SHW_PRODUT   ' +
        ' WHERE S.SHW_MD5KEY = :ITETIN          ';
      qryGen.ParamByName('ITETIN').AsString := strIteTin;
      qryGen.Open;

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

function TFormulaImobiliariaSherwinWilliams2.GetNomeCampoBaseCodIte: String;
begin
  Result := 'BAS_CODITE';
end;

function TFormulaImobiliariaSherwinWilliams2.GetNomeCampoCustoBase: String;
begin
  Result := 'BAS_PRECUS';
end;

function TFormulaImobiliariaSherwinWilliams2.GetNomeCampoVendaBase: String;
begin
  Result := 'BAS_PREVEN';
end;

function TFormulaImobiliariaSherwinWilliams2.GetNomeTabelaBase: String;
begin
  Result := 'SHW_CADBAS';
end;

function TFormulaImobiliariaSherwinWilliams2.GetNomeCampoColDesCol: string;
begin
  Result := '';
end;

function TFormulaImobiliariaSherwinWilliams2.GetNomeTabelaColorantes: String;
begin
  Result := 'SHW_CADCOL';
end;

function TFormulaImobiliariaSherwinWilliams2.GetPrefixoFormulacao: String;
begin
  Result := 'SHW_FORM';
end;

function TFormulaImobiliariaSherwinWilliams2.GetPrefixoQuantidade(const strModo: String): String;
begin
  Result := 'SHW_QTDC';
end;

function TFormulaImobiliariaSherwinWilliams2.GetProdutoBaseFormula(const dtsCadTin: IDataSet): String;
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
        '   SHW_CADBAS               ' +
        ' WHERE BAS_CODBAS = :CODBAS ' +
        '   AND BAS_CODUNI = :CODUNI ' +
        '   AND BAS_PRODUT = :PRODUT ' ;

      dtsGen.ParamByName('CODBAS').AsString := dtsCadTin.FieldByName('SHW_BASE__').AsString;
      dtsGen.ParamByName('CODUNI').AsString := dtsCadTin.FieldByName('SHW_CODUNI').AsString;
      dtsGen.ParamByName('PRODUT').AsString := dtsCadTin.FieldByName('SHW_PRODUT').AsString;
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

function TFormulaImobiliariaSherwinWilliams2.GetQuantidadeFormulacao: Integer;
begin
  Result := 20;
end;

function TFormulaImobiliariaSherwinWilliams2.GetTextoInformativoCalculo: String;
begin
  Result :=
    'Valor da Base = ' + FloatToStrF(BasePrecoVenda, ffFixed, 12, 2) + sLineBreak +
    'Valor do Colorante = (Quantidade * Preço / Embalagem) ' + sLineBreak +
    'Valor da Tinta = Valor da Base + (Soma do Valor do Colorante de todos os Colorantes)';
end;

function TFormulaImobiliariaSherwinWilliams2.GetUnidade(const dtsCadTin: IDataSet): String;
begin
  Result := dtsCadTin.FieldByName('SHW_CODUNI').AsString;
end;

{$IFNDEF LINUX}
procedure TFormulaImobiliariaSherwinWilliams2.pAddItemsFormulacao(
  lsvFormulacao: TListView; Formula: TAbstractFormula);
Var
  Colorante: TColorante;
  intContador: Integer;
  strOnca: String;
begin
  For intContador := 0 To Formula.Count - 1 Do
  Begin
    colorante := TColorante(formula.Items[intContador]);

    If Colorante.Embalagem <= 0 Then
      lsvFormulacao.Columns[4].Caption := '';

    If Colorante.PesoEspecifico > 0 Then
      lsvFormulacao.Columns[4].Caption := 'Peso Específico';

    With lsvFormulacao.Items.Add Do
    Begin
      If Colorante.DescricaoColorante <> '' Then
        Caption := Colorante.CodigoColorante + ' - ' + Colorante.DescricaoColorante
      Else
        Caption := Colorante.CodigoColorante;

      If (TAutcomTintaFactory.Get.fGetConfTinta('SHW').fGet('EXIQML') = 'S') Or
        (TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fGetConfTinta('SHW').fGet('EXIQML'))) Then
        SubItems.Add(FloatToStrF(Colorante.Quantidade, ffFixed, 12, 3));

      If fMostraQuantidadeEmOnca(strOnca, Colorante.Quantidade) Then
        SubItems.Add(strOnca);

      SubItems.Add(FloatToStrF(Colorante.PrecoVenda, ffFixed, 12, 6));
      SubItems.Add(FloatToStrF(Colorante.Embalagem, ffFixed, 12, 4));
    End;
  End;
end;

procedure TFormulaImobiliariaSherwinWilliams2.pAjustaFormulacao(
  lsvFormulacao: TListView; Form: TForm);
begin
  Form.ClientWidth := 600;
  lsvFormulacao.Columns.Clear;

  If (TAutcomTintaFactory.Get.fGetConfTinta('SHW').fGet('EXIQML') = 'S') Or
    (TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fGetConfTinta('SHW').fGet('EXIQML'))) Then
  Begin
    With lsvFormulacao.Columns.Add Do
    Begin
      Alignment := taRightJustify;
      Caption   := 'Colorante';
      Width     := (lsvFormulacao.Width - 10) div 5;
    End;

    With lsvFormulacao.Columns.Add Do
    Begin
      Alignment := taRightJustify;
      Caption   := 'Quantidade(ML)';
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
  End
  Else
  Begin
    With lsvFormulacao.Columns.Add Do
    Begin
      Alignment := taRightJustify;
      Caption   := 'Colorante';
      Width     := (lsvFormulacao.Width - 10) div 4;
    End;

    With lsvFormulacao.Columns.Add Do
    Begin
      Alignment := taRightJustify;
      Caption   := 'Quantidade(Onça)';
      Width     := (lsvFormulacao.Width - 10) div 4;
    End;

    With lsvFormulacao.Columns.Add Do
    Begin
      Alignment := taRightJustify;
      Caption   := 'Preço';
      Width     := (lsvFormulacao.Width - 10) div 4;
    End;

    With lsvFormulacao.Columns.Add Do
    Begin
      Alignment := taRightJustify;
      Caption   := 'Embalagem';
      Width     := (lsvFormulacao.Width - 10) div 4;
    End;
  End;
end;
{$ENDIF}

procedure TFormulaImobiliariaSherwinWilliams2.PreencheAcrescimoMaoObra(
  const dtsCadTin: IDataSet);
begin
  Self.AcrMob := dtsCadTin.FieldByName('SHW_ACRMOB').AsFloat;
end;

end.
