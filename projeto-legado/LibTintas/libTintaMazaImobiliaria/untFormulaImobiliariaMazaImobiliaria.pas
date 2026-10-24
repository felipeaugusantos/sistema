{***********************************************************************}
{* Classe responsável pelas rotidas especificas de uma formula MazaImobiliaria *}
{********************************************************************PH*}
unit untFormulaImobiliariaMazaImobiliaria;

interface

uses
  untAbstractFormulaImobiliaria, untICalculadorFormulaImobiliaria, untIDataSet, untColorante,
  SysUtils, untStrUtils;

type
  TFormulaImobiliariaMazaImobiliaria = class(TAbstractFormulaImobiliaria)
  protected
    function GetCalculadorInterno(): ICalculadorFormulaImobiliaria; override;
    function GetNomeTabelaColorantes(): String; override;
    function GetTextoInformativoCalculo(): String; override;
    procedure CarregaPrecosColorantesAdicional(const dataSetColorantes: IDataSet; const colorante: TColorante); override;
    function GetNomeCampoCustoBase: String; override;
    function GetNomeCampoVendaBase: String; override;
    function GetNomeTabelaBase: String; override;
    function GetNomeCampoBaseCodIte: String; override;
    function fRetornaProdutoParaFundo(strProduto: String): String;
    function fRetornaBaseParaFundo(strCodBas, strProduto: String): String;
  public
    function GetDataSetMensAlerta(const dtsCadTin: IDataSet): IDataSet; Override;
    function fUsaMensAlertaNovo(const dtsCadTin: IDataSet): Boolean; Override;
    procedure GetDataSetMensAlertaNovo(const dtsCadTin: IDataSet); Override;
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
    procedure CarregarColorantes; override;
    procedure PreencheAcrescimoMaoObra(const dtsCadTin: IDataSet); Override;

  end;

implementation

uses
  untAbstractCalculadorFormulaImobiliaria, untAutcomTintaFactory, untLibTintaFactory, untTypesSistema;

{ TFormulaImobiliariaMazaImobiliaria }

procedure TFormulaImobiliariaMazaImobiliaria.CarregaPrecosColorantesAdicional(const dataSetColorantes: IDataSet; const colorante: TColorante);
begin
  colorante.Embalagem := dataSetColorantes.FieldByName('COL_EMBALA').AsFloat;
end;


procedure TFormulaImobiliariaMazaImobiliaria.CarregarColorantes;
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

function TFormulaImobiliariaMazaImobiliaria.fMostraQuantidadeEmOnca(
  var strOnca: String; const fltQtdCol: Double): Boolean;
begin
  Result := False;

  strOnca := TLibTintaFactory.GetLibTinta.MlParaOnca(fltQtdCol);
end;

function TFormulaImobiliariaMazaImobiliaria.fRetornaBaseParaFundo(strCodBas,
  strProduto: String): String;
begin
  If Pos('ACRILICO', strProduto) > 0 Then
  Begin
    If strCodBas = 'BASE B1' Then
      Result := 'BASE A'
    Else If strCodBas = 'BASE B2' Then
      Result := 'BASE B1'
    Else If strCodBas = 'BASE C' Then
      Result := 'BASE B2';
  End
  Else If strProduto = 'REVESTIMENTO PEDRAS NATURAIS (BASE)' Then
  Begin
    Result := 'BASE UNICA'
  End
  Else
    Result := 'BASE ECO PRIMER';
end;

function TFormulaImobiliariaMazaImobiliaria.fRetornaProdutoParaFundo(
  strProduto: String): String;
begin
  If Pos('ACRILICO', strProduto) > 0 Then
    Result := 'ACRILICO PREMIUM FOSCO'
  Else If strProduto = 'REVESTIMENTO PEDRAS NATURAIS (BASE)' Then
    Result := 'PRIMER P/ REV. PEDRA NATURAL (BASE)'
  Else
    Result := 'ECO PRIMER';
end;

function TFormulaImobiliariaMazaImobiliaria.fUsaMensAlertaNovo(
  const dtsCadTin: IDataSet): Boolean;
begin
  {$IFDEF LINUX}
  Exit(False);
{$ELSE}
  If (dtsCadTin.FieldByName('MZI_BAICOB').AsString = 'N') Or (TStrUtils.fEmptyStr(dtsCadTin.FieldByName('MZI_BAICOB').AsString)) Then
    Exit(False);

  Result := True;
{$ENDIF}
end;

function TFormulaImobiliariaMazaImobiliaria.GetCalculadorInterno: ICalculadorFormulaImobiliaria;
begin
  Result := TAbstractCalculadorFormulaImobiliaria.Create(Self);
end;

function TFormulaImobiliariaMazaImobiliaria.GetChaveIteTin(const dtsCadTin: IDataSet): string;
begin
  if Assigned(dtsCadTin.FindField('MZI_MD5KEY')) then
    Result := dtsCadTin.FieldByName('MZI_MD5KEY').AsString
  else
  begin
    Result := dtsCadTin.FieldByName('MZI_CODMZI').AsString +
              dtsCadTin.FieldByName('MZI_CODEMP').AsString +
              dtsCadTin.FieldByName('MZI_CODUNI').AsString +
              dtsCadTin.FieldByName('MZI_PRODUT').AsString +
              dtsCadTin.FieldByName('MZI_COLNUM').AsString +
              dtsCadTin.FieldByName('MZI_CODBAS').AsString;
  end;

end;

function TFormulaImobiliariaMazaImobiliaria.GetDataSetMensAlerta(
  const dtsCadTin: IDataSet): IDataSet;
begin
{$IFDEF LINUX}
  Exit(Nil);
{$ELSE}
  Result := Nil;
{$ENDIF}
end;

procedure TFormulaImobiliariaMazaImobiliaria.GetDataSetMensAlertaNovo(const dtsCadTin: IDataSet);
Var
  arrMensagem: TStringArray;
begin
  TAutcomTintaFactory.Get.pAddDados(arrMensagem, 'ESTA COR É DE BAIXA COBERTURA. É RECOMENDADA A APLICAÇÃO DA COR DE FUNDO:');
  TAutcomTintaFactory.Get.pAddDados(arrMensagem, 'Descrição: ' + dtsCadTin.FieldByName('MZI_COLNAM').AsString + ' [FUNDO PARA COR]');
  TAutcomTintaFactory.Get.pAddDados(arrMensagem, 'Produto: ' + fRetornaProdutoParaFundo(dtsCadTin.FieldByName('MZI_PRODUT').AsString));
  TAutcomTintaFactory.Get.pAddDados(arrMensagem, 'Base: ' + fRetornaBaseParaFundo(dtsCadTin.FieldByName('MZI_CODBAS').AsString, dtsCadTin.FieldByName('MZI_PRODUT').AsString));
  TAutcomTintaFactory.Get.pAddDados(arrMensagem, ' ');
  TAutcomTintaFactory.Get.pAddDados(arrMensagem, 'PARA A COR DE FUNDO, RECOMENDA-SE SEMPRE A METADE DA QUANTIDADE DO PRODUTO SELECIONADO');

  TAutcomTintaFactory.Get.fMensagemTabela('ATENÇÃO!', 'AVISO', arrMensagem, '', ['&Ok'], 1, True, 1, 827, False, 0, False, False, False, 20, 360, 850, True);
end;

function TFormulaImobiliariaMazaImobiliaria.GetDescricao(const dtsCadTin: IDataSet): String;
begin
  Result := dtsCadTin.FieldByName('MZI_CODMZI').AsString + ' ' +
            dtsCadTin.FieldByName('MZI_PRODUT').AsString + ' ' +
            dtsCadTin.FieldByName('MZI_CODUNI').AsString;
end;

function TFormulaImobiliariaMazaImobiliaria.GetFatorEstoque: Double;
begin
  Result := 1;
end;

function TFormulaImobiliariaMazaImobiliaria.GetIdePro: String;
begin
  Result := 'MZI';
end;

function TFormulaImobiliariaMazaImobiliaria.GetItemBaseOriginal(const strIteTin: String): String;
var
  qryGen: IDataSet;
begin
  qryGen := nil;
  Result := '';

  Try
    Try
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      qryGen.SQL := ' SELECT B.BAS_CODITE                                     ' +
                    '   FROM MZI_CADMZI F                                     ' +
                    '  INNER JOIN MZI_CADBAS B ON F.MZI_CODBAS = B.BAS_CODBAS ' +
                    '                         AND F.MZI_CODUNI = B.BAS_CODUNI ' +
                    '  WHERE F.MZI_MD5KEY  = :ITETIN                          ';

      qryGen.ParamByName('ITETIN').AsString := strIteTin;
      qryGen.Open;

      If qryGen.IsEmpty Then
      Begin
        qryGen.SQL := ' SELECT B.BAS_CODITE                                     ' +
                      '   FROM MZI_CADMZI F                                     ' +
                      '  INNER JOIN MZI_CADBAS B ON F.MZI_CODBAS = B.BAS_CODBAS ' +
                      '                         AND F.MZI_CODUNI = B.BAS_CODUNI ' +
                      '  WHERE CONCAT(IFNULL(MZI_CODMZI, ""),                   ' +
                      '    IFNULL(MZI_CODEMP, ""),                              ' +
                      '    IFNULL(MZI_CODUNI, ""),                              ' +
                      '    IFNULL(MZI_PRODUT, ""),                              ' +
                      '    IFNULL(MZI_COLNUM, ""),                              ' +
                      '    IFNULL(MZI_CODBAS, "")) = :ITETIN                    ';

        qryGen.ParamByName('ITETIN').AsString := strIteTin;
        qryGen.Open;
      End;

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

function TFormulaImobiliariaMazaImobiliaria.GetNomeCampoBaseCodIte: String;
begin
  Result := 'BAS_CODITE';
end;

function TFormulaImobiliariaMazaImobiliaria.GetNomeCampoCustoBase: String;
begin
  Result := 'BAS_PRECUS';
end;

function TFormulaImobiliariaMazaImobiliaria.GetNomeCampoVendaBase: String;
begin
  Result := 'BAS_PREVEN';
end;

function TFormulaImobiliariaMazaImobiliaria.GetNomeTabelaBase: String;
begin
  Result := 'MZI_CADBAS';
end;

function TFormulaImobiliariaMazaImobiliaria.GetNomeCampoColDesCol: string;
begin
  Result := '';
end;

function TFormulaImobiliariaMazaImobiliaria.GetNomeTabelaColorantes: String;
begin
  Result := 'MZI_CADCOL';
end;

function TFormulaImobiliariaMazaImobiliaria.GetPrefixoFormulacao: String;
begin
  Result := 'MZI_CODC';
end;

function TFormulaImobiliariaMazaImobiliaria.GetPrefixoQuantidade(const strModo: String): String;
begin
  Result := 'MZI_QTDC';
end;

function TFormulaImobiliariaMazaImobiliaria.GetProdutoBaseFormula(const dtsCadTin: IDataSet): String;
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
        '   MZI_CADBAS               ' +
        ' WHERE BAS_CODBAS = :CODBAS ' +
        '   AND BAS_CODUNI = :CODUNI ' +
        '   AND BAS_PRODUT = :PRODUT ' ;

      dtsGen.ParamByName('CODBAS').AsString := dtsCadTin.FieldByName('MZI_CODBAS').AsString;
      dtsGen.ParamByName('CODUNI').AsString := dtsCadTin.FieldByName('MZI_CODUNI').AsString;
      dtsGen.ParamByName('PRODUT').AsString := dtsCadTin.FieldByName('MZI_PRODUT').AsString;
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

function TFormulaImobiliariaMazaImobiliaria.GetQuantidadeFormulacao: Integer;
begin
  Result := 20;
end;

function TFormulaImobiliariaMazaImobiliaria.GetTextoInformativoCalculo: String;
begin

  Result :=
    'Valor da Base    = ' + FloatToStrF(BasePrecoVenda, ffFixed, 12, 2) + sLineBreak +
    'Valor Colorantes = (Quantidade ) *  (Preço / Embalagem) ' + sLineBreak +
    'Valor da Tinta   = Valor da Base + (Soma do Valor dos Colorantes)';
end;

function TFormulaImobiliariaMazaImobiliaria.GetUnidade(const dtsCadTin: IDataSet): String;
begin
  Result := dtsCadTin.FieldByName('MZI_CODUNI').AsString;
end;

procedure TFormulaImobiliariaMazaImobiliaria.PreencheAcrescimoMaoObra(
  const dtsCadTin: IDataSet);
begin
  Self.AcrMob := dtsCadTin.FieldByName('MZI_ACRMOB').AsFloat;
end;

end.
