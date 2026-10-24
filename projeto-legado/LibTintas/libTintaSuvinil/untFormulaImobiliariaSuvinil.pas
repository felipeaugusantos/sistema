{***********************************************************************}
{* Classe responsável pelas rotidas especificas de uma formula suvinil *}
{********************************************************************PH*}
unit untFormulaImobiliariaSuvinil;

interface

uses
{$IFNDEF LINUX}
   Vcl.ComCtrls,
   Forms,
{$ENDIF}
  untAbstractFormulaImobiliaria, untICalculadorFormulaImobiliaria, untIDataSet, untColorante,
  SysUtils, untStrUtils, untAbstractFormula, Classes;

type
  TFormulaImobiliariaSuvinil = class(TAbstractFormulaImobiliaria)
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


    function GetDataSetMensAlerta(const dtsCadTin: IDataSet): IDataSet; override;
    function GetProdutoBaseFormula(const dtsCadTin: IDataSet): String; override;
    function GetFatorEstoque(): Double; override;
    function GetIdePro: String; override;
    function GetItemBaseOriginal(const strIteTin: String): String; override;
    function GetChaveIteTin(const dtsCadTin: IDataSet): string; override;
    function GetNomeCampoColDesCol: string; override;
    procedure CarregarColorantes; override;
    procedure PreencheAcrescimoMaoObra(const dtsCadTin: IDataSet); Override;
    function fAlteraFormulacao(): Boolean; Override;

    {$IFNDEF LINUX}
      procedure pAjustaFormulacao(lsvFormulacao: TListView; Form: TForm); Override;
      procedure pAddItemsFormulacao(lsvFormulacao: TListView; Formula: TAbstractFormula); Override;
    {$ENDIF}
  end;

implementation

uses
  untAbstractCalculadorFormulaImobiliaria, untAutcomTintaFactory;

{ TFormulaImobiliariaSuvinil }

procedure TFormulaImobiliariaSuvinil.CarregaPrecosColorantesAdicional(const dataSetColorantes: IDataSet; const colorante: TColorante);
begin
  colorante.Embalagem := dataSetColorantes.FieldByName('COL_EMBALA').AsFloat; //1000;
end;

procedure TFormulaImobiliariaSuvinil.CarregarColorantes;
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

function TFormulaImobiliariaSuvinil.fAlteraFormulacao: Boolean;
begin
  Result := True;
end;

function TFormulaImobiliariaSuvinil.GetCalculadorInterno: ICalculadorFormulaImobiliaria;
begin
  Result := TAbstractCalculadorFormulaImobiliaria.Create(Self);
end;

function TFormulaImobiliariaSuvinil.GetChaveIteTin(const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('SUV_MD5KEY').AsString;
end;

function TFormulaImobiliariaSuvinil.GetDataSetMensAlerta(const dtsCadTin: IDataSet): IDataSet;
begin
  Result := Nil;

  Result:= TAutcomTintaFactory.Get.fGetDataSet;
  Result.SQL := 'SELECT MSG_MENSAG '+
                '  FROM SUV_CADMSG '+
                ' WHERE MSG_DESCRI =:DESCRI '+
                '   AND MSG_REFERE =:REFERE '+
                '   AND MSG_UNIDAD =:UNIDAD '+
                '   AND MSG_CODFML =:CODFML '+
                '   AND MSG_NOMCOR =:NOMCOR '+
                '   AND MSG_CODBAS =:CODBAS ';

  Result.ParamByName('DESCRI').AsString := dtsCadTin.FieldByName('SUV_DESCRI').AsString;
  Result.ParamByName('REFERE').AsString := dtsCadTin.FieldByName('SUV_REFERE').AsString;
  Result.ParamByName('UNIDAD').AsString := dtsCadTin.FieldByName('SUV_CODUNI').AsString;
  Result.ParamByName('CODFML').AsString := dtsCadTin.FieldByName('SUV_CODFML').AsString;
  Result.ParamByName('NOMCOR').AsString := dtsCadTin.FieldByName('SUV_NOMCOR').AsString;
  Result.ParamByName('CODBAS').AsString := dtsCadTin.FieldByName('SUV_CODBAS').AsString;

  Result.Open;
end;

function TFormulaImobiliariaSuvinil.GetDescricao(const dtsCadTin: IDataSet): String;
begin
  Result := dtsCadTin.FieldByName('SUV_DESCRI').AsString;
end;

function TFormulaImobiliariaSuvinil.GetFatorEstoque: Double;
begin
  Result := 0.154;
end;

function TFormulaImobiliariaSuvinil.GetIdePro: String;
begin
  Result := 'SUV';
end;

function TFormulaImobiliariaSuvinil.GetItemBaseOriginal(const strIteTin: String): String;
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
        '   B.SUV_CODITE AS CODITE              ' +
        ' FROM                                  ' +
        '   SUV_CADBAS B                        ' +
        '   INNER JOIN SUV_CADSUV S             ' +
        '     ON B.SUV_CODFML = S.SUV_CODFML    ' +
        '     AND B.SUV_CODBAS = S.SUV_CODBAS   ' +
        '     AND B.SUV_CODUNI = S.SUV_CODUNI   ' +
        ' WHERE SUV_MD5KEY = :ITETIN            ';
      qryGen.ParamByName('ITETIN').AsString := strIteTin;
      qryGen.Open;

      If Not qryGen.IsEmpty Then
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

function TFormulaImobiliariaSuvinil.GetNomeCampoBaseCodIte: String;
begin
  Result := 'SUV_CODITE';
end;

function TFormulaImobiliariaSuvinil.GetNomeCampoColDesCol: string;
begin
  Result := '';
end;

function TFormulaImobiliariaSuvinil.GetNomeCampoCustoBase: String;
begin
  Result := 'SUV_PRECUS';
end;

function TFormulaImobiliariaSuvinil.GetNomeCampoVendaBase: String;
begin
  Result := 'SUV_PREVEN';
end;

function TFormulaImobiliariaSuvinil.GetNomeTabelaBase: String;
begin
  Result := 'SUV_CADBAS';
end;

function TFormulaImobiliariaSuvinil.GetNomeTabelaColorantes: String;
begin
  Result := 'SUV_CADCOL';
end;

function TFormulaImobiliariaSuvinil.GetPrefixoFormulacao: String;
begin
  Result := 'SUV_FORM';
end;

function TFormulaImobiliariaSuvinil.GetPrefixoQuantidade(const strModo: String): String;
begin
  Result := 'SUV_QTDB';
end;

function TFormulaImobiliariaSuvinil.GetProdutoBaseFormula(const dtsCadTin: IDataSet): String;
var
  dtsGen: IDataSet;
begin
  Try
    Try
      dtsGen := TAutcomTintaFactory.Get.fGetDataSet;
      dtsGen.SQL :=
        ' SELECT                     ' +
        '   SUV_CODITE               ' +
        ' FROM                       ' +
        '   SUV_CADBAS               ' +
        ' WHERE SUV_CODFML = :CODFML ' +
        '   AND SUV_CODBAS = :CODBAS ' +
        '   AND SUV_CODUNI = :CODUNI ';
      dtsGen.ParamByName('CODFML').AsString := dtsCadTin.FieldByName('SUV_CODFML').AsString;
      dtsGen.ParamByName('CODBAS').AsString := dtsCadTin.FieldByName('SUV_CODBAS').AsString;
      dtsGen.ParamByName('CODUNI').AsString := dtsCadTin.FieldByName('SUV_CODUNI').AsString;
      dtsGen.Open;

      Result := dtsGen.FieldByName('SUV_CODITE').AsString;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
  End;
end;

function TFormulaImobiliariaSuvinil.GetQuantidadeFormulacao: Integer;
begin
  Result := 20;
end;

function TFormulaImobiliariaSuvinil.GetTextoInformativoCalculo: String;
begin
  Result :=
    'Valor da Base = ' + FloatToStrF(BasePrecoVenda, ffFixed, 12, 2) + sLineBreak +
    'Valor do Colorante = (Quantidade Pulso * 0.154) * (Preço / Embalagem) ' + sLineBreak +
    'Valor da Tinta = Valor da Base + (Soma do Valor do Colorante de todos os Colorantes)';
end;

function TFormulaImobiliariaSuvinil.GetUnidade(const dtsCadTin: IDataSet): String;
begin
  Result := dtsCadTin.FieldByName('SUV_CODUNI').AsString;
end;

{$IFNDEF LINUX}
procedure TFormulaImobiliariaSuvinil.pAddItemsFormulacao(
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

    lsvFormulacao.Items[intContador].SubItems.Add(FloatToStrF(Colorante.Quantidade , ffFixed, 12, 3));
    lsvFormulacao.Items[intContador].SubItems.Add(FloatToStrF(Colorante.Quantidade * GetFatorEstoque, ffFixed, 12, 3));
    lsvFormulacao.Items[intContador].SubItems.Add(FloatToStrF(Colorante.PrecoVenda, ffFixed, 12, 6));

    If Colorante.Embalagem > 0 Then
      lsvFormulacao.Items[intContador].SubItems.Add(FloatToStrF(Colorante.Embalagem, ffFixed, 12, 4));
  End;
end;

procedure TFormulaImobiliariaSuvinil.pAjustaFormulacao(lsvFormulacao: TListView;
  Form: TForm);
begin
  Form.ClientWidth := 750;
  lsvFormulacao.Columns.Clear;

  lsvFormulacao.Columns.Add;
  lsvFormulacao.Columns.Items[0].Alignment := taRightJustify;
  lsvFormulacao.Columns.Items[0].Caption   := 'Colorante';
  lsvFormulacao.Columns.Items[0].Width     := (lsvFormulacao.Width - 10) div 5;

  lsvFormulacao.Columns.Add;
  lsvFormulacao.Columns.Items[1].Alignment := taRightJustify;
  lsvFormulacao.Columns.Items[1].Caption   := 'Quantidade(Pulso)';
  lsvFormulacao.Columns.Items[1].Width     := (lsvFormulacao.Width - 10) div 5;

  lsvFormulacao.Columns.Add;
  lsvFormulacao.Columns.Items[2].Alignment := taRightJustify;
  lsvFormulacao.Columns.Items[2].Caption   := 'Quantidade(ML)';
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


procedure TFormulaImobiliariaSuvinil.PreencheAcrescimoMaoObra(
  const dtsCadTin: IDataSet);
begin
  Self.AcrMob := dtsCadTin.FieldByName('SUV_ACRMOB').AsFloat;
end;

end.

