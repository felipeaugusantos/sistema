unit untProcessadorGravandoExecucaoAdvanceTintoSystemBasesColorantes;

interface

uses
  untAbstractAdoProcessadorGravandoExecucaoArquivos, ADODB, Classes, DB, SysUtils,
  untIGravando, Variants;

type
  TProcessadorGravandoExecucaoAdvanceTintoSystemBasesColorantes = class (TAbstractAdoProcessadorGravandoExecucaoArquivos)
  private
    qryCatalisadores: TADOQuery;
    function GetCatalisadores(): TADOQuery;
  protected
    function GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): string; override;
    function GetAdoQuery(var strNomeArquivo: string): TADOQuery;  override;
  public
    procedure GetTabelasVerificaProCod(const stlTabelas: TStrings); override;
    procedure GetArquivosProcessar(const stlArquivos: TStrings); override;
    function GetSqlDestino(): string; override;
    function IsRegistroExistente(const qryOrigem: TDataSet; const qryDestino: TDataSet): Boolean; override;
    procedure GravarRegistro(const qryOrigem: TDataSet; const qryDestino: TDataSet); override;
    procedure RegistrarImpossivelGravarRegistro(const E: Exception; const gravando: IGravando;
      const qryOrigem, qryDestino: TDataSet); override;
    function fGetNomeGravacao(): string; override;
  end;

implementation

uses untFuncoesSimples,untIDefinicaoTxtCampo, untFuncTinta,untDefinicaoTxtCampoTipo,
     untIDefinicaoTxt,untDefinicaoTxtCharacterSet,untGenericDefinicaoTxtCampo,
     untGenericDefinicaoTxt, untADOTxtFactory;

{ TProcessadorGravandoExecucaoAdvanceTintoSystemColorantes }

function TProcessadorGravandoExecucaoAdvanceTintoSystemBasesColorantes.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases Colorantes';
end;

function TProcessadorGravandoExecucaoAdvanceTintoSystemBasesColorantes.GetAdoQuery(var strNomeArquivo: string): TADOQuery;
var
  definicao: IDefinicaoTxt;
begin
  definicao := TGenericDefinicaoTxt.Create(strNomeArquivo, True, ';', dtcsDefault, '.', '.',
    TArrayIDefinicaoTxtCampoFactory.GetArrayIDefinicaoTxtCampo([
      TGenericDefinicaoTxtCampo.Create('IdFormula', dtctText),
      TGenericDefinicaoTxtCampo.Create('Codigo da Cor', dtctText),
      TGenericDefinicaoTxtCampo.Create('Codigo Tecnico', dtctText),
      TGenericDefinicaoTxtCampo.Create('Produto', dtctText),
      TGenericDefinicaoTxtCampo.Create('IdProduto', dtctText),
      TGenericDefinicaoTxtCampo.Create('Base', dtctText),
      TGenericDefinicaoTxtCampo.Create('Cod Base', dtctText),
      TGenericDefinicaoTxtCampo.Create('Id_Base', dtctText),
      TGenericDefinicaoTxtCampo.Create('IdProdBas', dtctText),
      TGenericDefinicaoTxtCampo.Create('Embalagem', dtctText),
      TGenericDefinicaoTxtCampo.Create('Conteudo', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('IdEmb', dtctText),
      TGenericDefinicaoTxtCampo.Create('Preco Base', dtctCurrency),
      TGenericDefinicaoTxtCampo.Create('IdCoran1', dtctText),
      TGenericDefinicaoTxtCampo.Create('IdCoran2', dtctText),
      TGenericDefinicaoTxtCampo.Create('IdCoran3', dtctText),
      TGenericDefinicaoTxtCampo.Create('IdCoran4', dtctText),
      TGenericDefinicaoTxtCampo.Create('IdCoran5', dtctText),
      TGenericDefinicaoTxtCampo.Create('IdCoran6', dtctText),
      TGenericDefinicaoTxtCampo.Create('IdCoran7', dtctText),
      TGenericDefinicaoTxtCampo.Create('IdCoran8', dtctText),
      TGenericDefinicaoTxtCampo.Create('IdCoran9', dtctText),
      TGenericDefinicaoTxtCampo.Create('IdCoran10', dtctText),
      TGenericDefinicaoTxtCampo.Create('IdCoran11', dtctText),
      TGenericDefinicaoTxtCampo.Create('IdCoran12', dtctText),
      TGenericDefinicaoTxtCampo.Create('IdCoran13', dtctText),
      TGenericDefinicaoTxtCampo.Create('IdCoran14', dtctText),
      TGenericDefinicaoTxtCampo.Create('IdCoran15', dtctText),
      TGenericDefinicaoTxtCampo.Create('IdCoran16', dtctText),
      TGenericDefinicaoTxtCampo.Create('IdCoran17', dtctText),
      TGenericDefinicaoTxtCampo.Create('CodCoran1', dtctText),
      TGenericDefinicaoTxtCampo.Create('CodCoran2', dtctText),
      TGenericDefinicaoTxtCampo.Create('CodCoran3', dtctText),
      TGenericDefinicaoTxtCampo.Create('CodCoran4', dtctText),
      TGenericDefinicaoTxtCampo.Create('CodCoran5', dtctText),
      TGenericDefinicaoTxtCampo.Create('CodCoran6', dtctText),
      TGenericDefinicaoTxtCampo.Create('CodCoran7', dtctText),
      TGenericDefinicaoTxtCampo.Create('CodCoran8', dtctText),
      TGenericDefinicaoTxtCampo.Create('CodCoran9', dtctText),
      TGenericDefinicaoTxtCampo.Create('CodCoran10', dtctText),
      TGenericDefinicaoTxtCampo.Create('CodCoran11', dtctText),
      TGenericDefinicaoTxtCampo.Create('CodCoran12', dtctText),
      TGenericDefinicaoTxtCampo.Create('CodCoran13', dtctText),
      TGenericDefinicaoTxtCampo.Create('CodCoran14', dtctText),
      TGenericDefinicaoTxtCampo.Create('CodCoran15', dtctText),
      TGenericDefinicaoTxtCampo.Create('CodCoran16', dtctText),
      TGenericDefinicaoTxtCampo.Create('CodCoran17', dtctText),
      TGenericDefinicaoTxtCampo.Create('Desc_Corante1', dtctText),
      TGenericDefinicaoTxtCampo.Create('Desc_Corante2', dtctText),
      TGenericDefinicaoTxtCampo.Create('Desc_Corante3', dtctText),
      TGenericDefinicaoTxtCampo.Create('Desc_Corante4', dtctText),
      TGenericDefinicaoTxtCampo.Create('Desc_Corante5', dtctText),
      TGenericDefinicaoTxtCampo.Create('Desc_Corante6', dtctText),
      TGenericDefinicaoTxtCampo.Create('Desc_Corante7', dtctText),
      TGenericDefinicaoTxtCampo.Create('Desc_Corante8', dtctText),
      TGenericDefinicaoTxtCampo.Create('Desc_Corante9', dtctText),
      TGenericDefinicaoTxtCampo.Create('Desc_Corante10', dtctText),
      TGenericDefinicaoTxtCampo.Create('Desc_Corante11', dtctText),
      TGenericDefinicaoTxtCampo.Create('Desc_Corante12', dtctText),
      TGenericDefinicaoTxtCampo.Create('Desc_Corante13', dtctText),
      TGenericDefinicaoTxtCampo.Create('Desc_Corante14', dtctText),
      TGenericDefinicaoTxtCampo.Create('Desc_Corante15', dtctText),
      TGenericDefinicaoTxtCampo.Create('Desc_Corante16', dtctText),
      TGenericDefinicaoTxtCampo.Create('Desc_Corante17', dtctText),
      TGenericDefinicaoTxtCampo.Create('ML_Corante1', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('ML_Corante2', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('ML_Corante3', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('ML_Corante4', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('ML_Corante5', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('ML_Corante6', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('ML_Corante7', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('ML_Corante8', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('ML_Corante9', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('ML_Corante10', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('ML_Corante11', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('ML_Corante12', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('ML_Corante13', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('ML_Corante14', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('ML_Corante15', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('ML_Corante16', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('ML_Corante17', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('ML_TotalCor', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('Preco_Cor', dtctCurrency),
      TGenericDefinicaoTxtCampo.Create('Catalisador', dtctText),
      TGenericDefinicaoTxtCampo.Create('CodCatalis', dtctText),
      TGenericDefinicaoTxtCampo.Create('IdCatalis', dtctText),
      TGenericDefinicaoTxtCampo.Create('Volume Catal', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('Preco Catal', dtctCurrency),
      TGenericDefinicaoTxtCampo.Create('Volume Final', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('Preco', dtctCurrency),
      TGenericDefinicaoTxtCampo.Create('Data', dtctDate)
    ]));

  TADOTxtFactory.Registrar(definicao);
  
  definicao := TGenericDefinicaoTxt.Create(strNomeArquivo, True, ';', dtcsDefault, '.', '.',
    TArrayIDefinicaoTxtCampoFactory.GetArrayIDefinicaoTxtCampo([
      TGenericDefinicaoTxtCampo.Create('IdProdBas', dtctText),
      TGenericDefinicaoTxtCampo.Create('Embalagem', dtctText),
      TGenericDefinicaoTxtCampo.Create('Conteudo', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('IdEmb', dtctText),
      TGenericDefinicaoTxtCampo.Create('Produto', dtctText),
      TGenericDefinicaoTxtCampo.Create('IdProduto', dtctText),
      TGenericDefinicaoTxtCampo.Create('Base', dtctText),
      TGenericDefinicaoTxtCampo.Create('Cod Base', dtctText),
      TGenericDefinicaoTxtCampo.Create('Id_Base', dtctText),
      TGenericDefinicaoTxtCampo.Create('Peso Especif', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('Código Barra', dtctText),
      TGenericDefinicaoTxtCampo.Create('Data', dtctDate)
    ]));

  TADOTxtFactory.Registrar(definicao);
  strNomeArquivo := definicao.NomeArquivo;
  Result := TADOTxtFactory.GetTxt12Query(ExtractFileDir(strNomeArquivo));
end;

procedure TProcessadorGravandoExecucaoAdvanceTintoSystemBasesColorantes.GetArquivosProcessar(const stlArquivos: TStrings);
begin
  stlArquivos.Text := fGetConfTinta('ADT').fGet('PATADV') +  '\Bases.csv';
end;

function TProcessadorGravandoExecucaoAdvanceTintoSystemBasesColorantes.GetCatalisadores: TADOQuery;
begin
  if not Assigned(qryCatalisadores) then
  begin
    qryCatalisadores := TADOTxtFactory.GetTxt12Query(fGetConfTinta('ADT').fGet('PATADV'));
    qryCatalisadores.SQL.Text :=
      ' SELECT DISTINCT                   ' +
      '   I.CODCATALIS                    ' +
      ' FROM                              ' +
      '   INTEGRACAO#CSV AS I,            ' +
      '   BASES#CSV AS B                  ' +
      ' WHERE I.CODCATALIS = B.[COD BASE] ';
  end;

  qryCatalisadores.Open;
  Result := qryCatalisadores;
end;

function TProcessadorGravandoExecucaoAdvanceTintoSystemBasesColorantes.GetSqlDestino: string;
begin
  Result := 'SELECT * FROM ADT_CADCOL';
end;

function TProcessadorGravandoExecucaoAdvanceTintoSystemBasesColorantes.GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): string; 
begin
  Result :=
    ' SELECT DISTINCT                            ' +
    '   B1.[COD BASE]                            ' +
    '   , B1.BASE                                ' +
    '   , B1.CONTEUDO                            ' +
    '   , B1.[PESO ESPECIF]                      ' +
    ' FROM                                       ' +
    '   BASES#CSV AS B1                          ' +
    '   INNER JOIN                               ' +
    '     (SELECT                                ' +
    '       [COD BASE]                           ' +
    '       , MAX(CONTEUDO) AS MAX_CONTEUDO      ' +
    '     FROM                                   ' +
    '       BASES#CSV GROUP BY [COD BASE]) AS B2 ' +
    '       ON B1.[COD BASE] = B2.[COD BASE]     ' +
    '       AND B1.[CONTEUDO] = B2.MAX_CONTEUDO  ';
end;

procedure TProcessadorGravandoExecucaoAdvanceTintoSystemBasesColorantes.GetTabelasVerificaProCod(const stlTabelas: TStrings);
begin
  stlTabelas.Text := 'ADT_CADCOL';
end;

procedure TProcessadorGravandoExecucaoAdvanceTintoSystemBasesColorantes.GravarRegistro(const qryOrigem, qryDestino: TDataSet);
begin
  qryDestino.Insert;
  qryDestino.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('ADT_CADCOL', VS_strCodEmp);
  qryDestino.FieldByName('COL_CODEMP').AsString := VS_strCodEmp;
  qryDestino.FieldByName('COL_CODCOL').AsString := LimpaTexto(qryOrigem.FieldByName('COD BASE').AsString);
  qryDestino.FieldByName('COL_DESCRI').AsString := LimpaTexto(qryOrigem.FieldByName('BASE').AsString);
  qryDestino.FieldByName('COL_PESESP').AsFloat := qryOrigem.FieldByName('PESO ESPECIF').AsFloat;
  qryDestino.FieldByName('COL_EMBALA').AsFloat := qryOrigem.FieldByName('CONTEUDO').AsFloat;
//  qryDestino.FieldByName('COL_CATALI').AsString := 'N';
  qryDestino.Post;
end;

function TProcessadorGravandoExecucaoAdvanceTintoSystemBasesColorantes.IsRegistroExistente(const qryOrigem, qryDestino: TDataSet): Boolean;
begin
  Result := qryDestino.Locate('COL_CODCOL', VarArrayOf([LimpaTexto(qryOrigem.FieldByName('COD BASE').AsString)]), [])
    or GetCatalisadores.Locate('CODCATALIS', qryOrigem.FieldByName('COD BASE').AsString, []);;
end;

procedure TProcessadorGravandoExecucaoAdvanceTintoSystemBasesColorantes.RegistrarImpossivelGravarRegistro(const E: Exception;
  const gravando: IGravando; const qryOrigem, qryDestino: TDataSet);
begin
  gravando.Texto := Format('Não foi possível cadastrar o colorante [%s - %s - %.2f][%s: %s]',
    [LimpaTexto(qryOrigem.FieldByName('COD BASE').AsString),
    LimpaTexto(qryOrigem.FieldByName('BASE').AsString),
    qryOrigem.FieldByName('CONTEUDO').AsFloat,
    E.ClassName, E.Message]);
end;

end.
