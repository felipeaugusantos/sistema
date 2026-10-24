{*************************************************************************}
{* Classe responsável pela geração do cadastro de bases da tinta Colorbraz *}
{**********************************************************************PH*}
unit untGravandoExecucaoColorbrazCores;

interface

uses
  untAbstractGravandoExecucaoColorbraz, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils;

  type
    TGravandoExecucaoColorbrazCores = class(TAbstractGravandoExecucaoColorbraz)
  Private
    function fRetUnidade(fltEmbalagem: Double): String;
    procedure IsDeletarRegistros();
    procedure GravandoRegistro(Lista: TStringList; qryDestino: IDataSet);
    function fContaLinhas(strNomArq: String): Integer;
    function fVerificaMd5KeyExiste(strMd5Key: String): Boolean;
  public
    function GetAdoQuery(var strNomeArquivo:String):TADOQuery; override;
    function GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): string; override;
    function GetSqlDestino(): string; override;
    function GetDataSetDestino(): IDataSet; override;
    function fGetPath(intContador: Integer): String; override;
    function IsRegistroExistente(const qryOrigem: TDataSet; const qryDestino: IDataSet): Boolean; override;
    procedure GravarRegistro(const qryOrigem: TDataSet; const qryDestino: IDataSet); override;
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

{ TGravandoExecucaoColorbrazCores }

uses
  untFuncoesGenerica, untStrUtils, untDefinicaoTxtCampoTipo, untADOTxtFactory, untGenericDefinicaoTxtCampo, untGenericDefinicaoTxt,
    untIDefinicaoTxtCampo, untIDefinicaoTxt, untDefinicaoTxtCharacterSet;


procedure TGravandoExecucaoColorbrazCores.Executar(const gravando: IGravando);
Var
  qryDestino: IDataSet;
  intContador: Integer;
  Arquivo: TextFile;
  stlCsv: TStringList;
  strLinha: String;
  iRecordCount: Integer;
  intLinha: Integer;
begin
  For intContador := 0 To stlPaths.Count - 1 Do
  Begin
    Try
      Try


        Gravando.Texto := 'Verificando Path...';

        If Not fValidaPath(intContador) Then
        Begin
          Gravando.Texto := Format('O arquivo %s não foi encontrado! Rever Configurações.', [AnsiReplaceStr(fGetPath(intContador), '"', '')]);
          Break;
        End;

        If intContador = 0 Then
        Begin
          Gravando.Texto := 'Deletando Registros...';
          IsDeletarRegistros();
        End;


        Gravando.Texto := 'Carregando Dados...';
        iRecordCount := fContaLinhas(fGetPath(intContador));
        intLinha := 1;
        qryDestino := GetDataSetDestino;
        stlCsv := TStringList.Create();
        stlCsv.StrictDelimiter := True;
        stlCsv.Delimiter := ';';

        AssignFile(Arquivo, fGetPath(intContador));
        Reset(Arquivo);

        Gravando.Texto := 'Verificando PROCOD...';
        TAutcomTintaFactory.Get.fInsereProCod('CLB_CADCLB');
        Gravando.Texto := 'PROCOD verificado com sucesso...';

        Gravando.Texto := Format('Processando Arquivo: [%s]', [AnsiReplaceStr(fGetPath(intContador), '"', '')]);
        Gravando.RegistrarProgresso(0, 0, 0);

        While Not Eof(Arquivo) Do
        Begin

          If (Gravando.Status <> sgGravando) Then
            Break;

          ReadLn(Arquivo, strLinha);
          stlCsv.DelimitedText := strLinha;

          If stlCsv[0] <> 'id_seq' Then
          Begin
            GravandoRegistro(stlCsv, qryDestino);
            Inc(intLinha);
          End;

          Gravando.RegistrarProgresso(0, intLinha, iRecordCount);
        End;
      Except
        On E: Exception Do
        Begin
          Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
        End;
      End;
    Finally
      If Assigned(stlCsv) Then FreeAndNil(stlCsv);
      CloseFile(Arquivo);
    End;
  End;
end;


function TGravandoExecucaoColorbrazCores.fContaLinhas(
  strNomArq: String): Integer;
Var
  Arquivo: TextFile;
begin
  Result := 0;
  AssignFile(Arquivo, strNomArq);
  Reset(Arquivo);

  While Not Eof(Arquivo) Do
  Begin
    Readln(Arquivo);
    Result := Result + 1;
  End;

  CloseFile(Arquivo);
end;

function TGravandoExecucaoColorbrazCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;

function TGravandoExecucaoColorbrazCores.fGetPath(
  intContador: Integer): String;
begin
  Result := conf.fGet('PATCLB') + '\' + stlPaths[intContador];
  Result := Result + '.csv';
end;

function TGravandoExecucaoColorbrazCores.fRetUnidade(
  fltEmbalagem: Double): String;
begin
  Result := '';

  If fltEmbalagem < 1500 Then
    Result := 'LT'
  Else If fltEmbalagem < 5000 Then
    Result := 'GL'
  Else If fltEmbalagem > 5000 Then
    Result := 'LA';
end;

function TGravandoExecucaoColorbrazCores.fVerificaMd5KeyExiste(
  strMd5Key: String): Boolean;
Var
  qryGen: IDataSet;
begin
  Try
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.Close;
    qryGen.SQL := ' SELECT * FROM CLB_CADCLB  WHERE CLB_MD5KEY = :MD5KEY    ';
    qryGen.ParamByName('MD5KEY').AsString := strMd5Key;
    qryGen.Open;

    Result := Not qryGen.IsEmpty;
  Except
    Raise;
  End;

end;

function TGravandoExecucaoColorbrazCores.GetAdoQuery(
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

function TGravandoExecucaoColorbrazCores.GetDataSetDestino: IDataSet;
begin
  Result := TAutcomTintaFactory.Get.fGetDataSet;
end;

function TGravandoExecucaoColorbrazCores.GetSqlDestino: string;
begin
  Result := TAutcomTintaFactory.Get.GetInsert('CLB_CADCLB');
end;

function TGravandoExecucaoColorbrazCores.GetSqlOrigem(
  const strNomeArquivo: string; const stlTabelas: TStrings): string;
begin
  Result := '';
end;


procedure TGravandoExecucaoColorbrazCores.GravandoRegistro(Lista: TStringList;
  qryDestino: IDataSet);
Var
  intContador,
  intForm: Integer;
begin
  qryDestino.SQL := GetSqlDestino;
  qryDestino.ParamByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('CLB_CADCLB', TAutcomTintaFactory.Get.GetCodEmp);
  qryDestino.ParamByName('CLB_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
  qryDestino.ParamByName('CLB_CODBAS').AsString := LimpaTexto(Lista[4]);
  qryDestino.ParamByName('CLB_CODIGO').AsString := LimpaTexto(Lista[1]);
  qryDestino.ParamByName('CLB_NOMCOR').AsString := LimpaTexto(Lista[2]);
  qryDestino.ParamByName('CLB_PRODUT').AsString := LimpaTexto(Lista[8]);
  qryDestino.ParamByName('CLB_COLECA').AsString := LimpaTexto(Lista[9]);
  qryDestino.ParamByName('CLB_SUBCOL').AsString := LimpaTexto(Lista[10]);
  qryDestino.ParamByName('CLB_UNIDAD').AsString := LimpaTexto(fRetUnidade(TAutcomTintaFactory.Get.fStrToFloat(Lista[6])));

  intForm := 1;

  For intContador := 11 To 16 Do
  Begin

    If TStrUtils.fEmptyStr(Lista[intContador]) Then
      Continue;

    qryDestino.ParamByName('CLB_FORM' + TStrUtils.fStrZero(intForm, 2)).AsString := Lista[intContador];

    Inc(intForm);
  End;

  intForm := 1;

  For intContador := 17 To 22 Do
  Begin

    If TAutcomTintaFactory.Get.fStrToFloat(Lista[intContador]) <=0 Then
      Continue;

    qryDestino.ParamByName('CLB_QTDC' + TStrUtils.fStrZero(intForm, 2)).AsFloat := TAutcomTintaFactory.Get.fStrToFloat(Lista[intContador]);

    Inc(intForm);
  End;

  qryDestino.ParamByName('CLB_MD5KEY').AsString := GetMD5(qryDestino.ParamByName('CLB_CODIGO').AsString +
                                                          qryDestino.ParamByName('CLB_CODBAS').AsString +
                                                          qryDestino.ParamByName('CLB_NOMCOR').AsString +
                                                          qryDestino.ParamByName('CLB_PRODUT').AsString +
                                                          qryDestino.ParamByName('CLB_UNIDAD').AsString);



  qryDestino.ParamByName('CLB_ATIVO_').AsString := 'S';

  If Not fVerificaMd5KeyExiste(qryDestino.ParamByName('CLB_MD5KEY').AsString) Then
    qryDestino.ExecSQL;
end;

procedure TGravandoExecucaoColorbrazCores.GravarRegistro(
  const qryOrigem: TDataSet; const qryDestino: IDataSet);
begin
end;

procedure TGravandoExecucaoColorbrazCores.IsDeletarRegistros;
Var
  qryDelet: IDataSet;
begin
  qryDelet := TAutcomTintaFactory.Get.fGetDataSet;
  qryDelet.SQL := 'DELETE FROM CLB_CADCLB        ';
  qryDelet.ExecSQL;
end;

function TGravandoExecucaoColorbrazCores.IsRegistroExistente(
  const qryOrigem: TDataSet; const qryDestino: IDataSet): Boolean;
begin
  Result := False;
end;

end.
