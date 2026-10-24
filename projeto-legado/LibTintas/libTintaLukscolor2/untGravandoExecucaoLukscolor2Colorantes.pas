{*************************************************************************}
{* Classe responsável pela geração do cadastro de Colorantes da tinta Lukscolor2 *}
{**********************************************************************PH*}
unit untGravandoExecucaoLukscolor2Colorantes;

interface

uses
  untAbstractGravandoExecucaoLukscolor2, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils;

Type
  TGravandoExecucaoLukscolor2Colorantes = class(TAbstractGravandoExecucaoLukscolor2)
  public
    function GetAdoQuery(var strNomeArquivo:String):TADOQuery; override;
    function GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): string; override;
    function GetSqlDestino(): string; override;
    function fGetPath(intContador: Integer): String; override;
    function IsRegistroExistente(const qryOrigem: TDataSet; const qryDestino: IDataSet): Boolean; override;
    procedure GravarRegistro(const qryOrigem: TDataSet; const qryDestino: IDataSet); override;
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

{ TGravandoExecucaoLukscolor2Colorantes }

uses untStrUtils, untDefinicaoTxtCampoTipo, untADOTxtFactory, untGenericDefinicaoTxtCampo, untGenericDefinicaoTxt,
    untIDefinicaoTxtCampo, untIDefinicaoTxt, untDefinicaoTxtCharacterSet;

procedure TGravandoExecucaoLukscolor2Colorantes.Executar(const gravando: IGravando);
Var
  qryDestino: IDataSet;
  qryOrigem: TDataSet;
  intContador: Integer;
begin
  For intContador := 0 To stlPaths.Count - 1 Do
  Begin
    Try
      Try
        If (Gravando.Status <> sgGravando) Then
          Break;

        Gravando.Texto := 'Verificando Path...';

        If Not fValidaPath(intContador) Then
        Begin
          Gravando.Texto := Format('O arquivo %s não foi encontrado! Rever Configurações.', [AnsiReplaceStr(fGetPath(intContador), '"', '')]);
          Break;
        End;

        Gravando.Texto := 'Carregando Dados...';

        CarregarDados(Gravando, qryOrigem, fGetPath(intContador), qryDestino);

        Gravando.Texto := 'Verificando PROCOD...';
        TAutcomTintaFactory.Get.fInsereProCod('LKC_CADCOL');
        Gravando.Texto := 'PROCOD verificado com sucesso...';

        If (Gravando.Status <> sgGravando) Then
          Break;

        Gravando.Texto := Format('Processando Arquivo:[%s]', [AnsiReplaceStr(fGetPath(intContador), '"', '')]);
        Gravando.RegistrarProgresso(0, 0, 0);

        While Not qryOrigem.Eof Do
        Begin
          If (Gravando.Status <> sgGravando) Then
            Break;

          Try
            Try

              If Not IsRegistroExistente(qryOrigem, qryDestino) Then
                GravarRegistro(qryOrigem, qryDestino);

            Except
              On E: Exception Do
                Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
            End;
          Finally
            qryOrigem.Next;
            Gravando.RegistrarProgresso(0, qryOrigem.RecNo, qryOrigem.RecordCount);
          End;
        End;
      Except
        On E: Exception Do
        Begin
          Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
        End;
      End;
    Finally
      If Assigned(qryOrigem) Then FreeAndNil(qryOrigem);
    End;
  End;
end;

function TGravandoExecucaoLukscolor2Colorantes.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Colorantes';
end;

function TGravandoExecucaoLukscolor2Colorantes.fGetPath(
  intContador: Integer): String;
begin
  Result := Conf.fGet('PATLKC') + '\' + stlPaths[intContador];
  Result := Result + '.csv';
end;

function TGravandoExecucaoLukscolor2Colorantes.GetAdoQuery(
  var strNomeArquivo: String): TADOQuery;
Var
  Definicao: IDefinicaoTxt;
begin
  Definicao := TGenericDefinicaoTxt.Create(strNomeArquivo, True, ';',
  dtcsDefault, '.', '.',
  TArrayIDefinicaoTxtCampoFactory.GetArrayIDefinicaoTxtCampo([
  TGenericDefinicaoTxtCampo.Create('id_seq', dtctText),
  TGenericDefinicaoTxtCampo.Create('cor_id', dtctText),
  TGenericDefinicaoTxtCampo.Create('nome_cor', dtctText),
  TGenericDefinicaoTxtCampo.Create('id_base', dtctText),
  TGenericDefinicaoTxtCampo.Create('base', dtctText),
  TGenericDefinicaoTxtCampo.Create('id_embalagem', dtctText),
  TGenericDefinicaoTxtCampo.Create('embalagem', dtctDouble),
  TGenericDefinicaoTxtCampo.Create('cod_produto', dtctText),
  TGenericDefinicaoTxtCampo.Create('produto', dtctText),
  TGenericDefinicaoTxtCampo.Create('colecao', dtctText),
  TGenericDefinicaoTxtCampo.Create('sub_colecao', dtctText),
  TGenericDefinicaoTxtCampo.Create('corante1', dtctText),
  TGenericDefinicaoTxtCampo.Create('corante2', dtctText),
  TGenericDefinicaoTxtCampo.Create('corante3', dtctText),
  TGenericDefinicaoTxtCampo.Create('corante4', dtctText),
  TGenericDefinicaoTxtCampo.Create('corante5', dtctText),
  TGenericDefinicaoTxtCampo.Create('corante6', dtctText),
  TGenericDefinicaoTxtCampo.Create('Qtd1(ML)', dtctDouble),
  TGenericDefinicaoTxtCampo.Create('Qtd2(ML)', dtctDouble),
  TGenericDefinicaoTxtCampo.Create('Qtd3(ML)', dtctDouble),
  TGenericDefinicaoTxtCampo.Create('Qtd4(ML)', dtctDouble),
  TGenericDefinicaoTxtCampo.Create('Qtd5(ML)', dtctDouble),
  TGenericDefinicaoTxtCampo.Create('Qtd6(ML)', dtctDouble),
  TGenericDefinicaoTxtCampo.Create('Volume_Final(ML)', dtctDouble),
  TGenericDefinicaoTxtCampo.Create('preco_final', dtctCurrency),
  TGenericDefinicaoTxtCampo.Create('data_geracao', dtctDate)]));

  TADOTxtFactory.Registrar(Definicao);
  strNomeArquivo := Definicao.NomeArquivo;
  Result := TADOTxtFactory.GetTxt12Query(ExtractFileDir(strNomeArquivo));
end;

function TGravandoExecucaoLukscolor2Colorantes.GetSqlDestino: string;
begin
  Result := '   SELECT * FROM LKC_CADCOL        ';
end;

function TGravandoExecucaoLukscolor2Colorantes.GetSqlOrigem(
  const strNomeArquivo: string; const stlTabelas: TStrings): string;
begin
  Result := '';
  Result := Result + '  SELECT                      ';
  Result := Result + '    corante1 AS CODIGO        ';
  Result := Result + '  FROM                        ';
  Result := Result +      strTabela + '#CSV         ';
  Result := Result + '  UNION ALL                   ';
  Result := Result + '  SELECT DISTINCT             ';
  Result := Result + '    corante2 AS CODIGO        ';
  Result := Result + '  FROM                        ';
  Result := Result +      strTabela + '#csv         ';
  Result := Result + '  UNION ALL                   ';
  Result := Result + '  SELECT DISTINCT             ';
  Result := Result + '    corante3 AS CODIGO        ';
  Result := Result + '  FROM                        ';
  Result := Result +      strTabela + '#csv         ';
  Result := Result + '  UNION ALL                   ';
  Result := Result + '  SELECT DISTINCT             ';
  Result := Result + '    corante4 AS CODIGO        ';
  Result := Result + '  FROM                        ';
  Result := Result +      strTabela + '#csv         ';
  Result := Result + '  UNION ALL                   ';
  Result := Result + '  SELECT DISTINCT             ';
  Result := Result + '    corante5 AS CODIGO        ';
  Result := Result + '  FROM                        ';
  Result := Result +      strTabela + '#csv         ';
  Result := Result + '  UNION ALL                   ';
  Result := Result + '  SELECT DISTINCT             ';
  Result := Result + '    corante6 AS CODIGO        ';
  Result := Result + '  FROM                        ';
  Result := Result +      strTabela + '#csv         ';
end;

procedure TGravandoExecucaoLukscolor2Colorantes.GravarRegistro(
  const qryOrigem: TDataSet; const qryDestino: IDataSet);
begin
  qryDestino.Insert;
  qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('LKC_CADCOL', TAutcomTintaFactory.Get.GetCodEmp);
  qryDestino.FieldByName('COL_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
  qryDestino.FieldByName('COL_CODCOL').AsString := LimpaTexto(qryOrigem.FieldByName('CODIGO').AsString);
  qryDestino.FieldByName('COL_DESCRI').AsString := 'COLORANTE ' + LimpaTexto(qryOrigem.FieldByName('CODIGO').AsString);
  qryDestino.FieldByName('COL_EMBALA').AsFloat  := 1000;
  qryDestino.Post;
end;

function TGravandoExecucaoLukscolor2Colorantes.IsRegistroExistente(
  const qryOrigem: TDataSet; const qryDestino: IDataSet): Boolean;
begin
  Result := qryDestino.Locate('COL_CODCOL', VarArrayOf([
    LimpaTexto(qryOrigem.FieldByName('CODIGO').AsString)]), []) Or (TStrUtils.fEmptyStr(LimpaTexto(qryOrigem.FieldByName('CODIGO').AsString)));
end;

end.
