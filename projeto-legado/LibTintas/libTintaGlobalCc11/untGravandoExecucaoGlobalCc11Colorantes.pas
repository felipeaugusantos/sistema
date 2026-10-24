{******************************************************************************}
{* Classe responsável pela geração do cadastro de colorantes da tinta GlobalCc11 *}
{***************************************************************************PH*}
unit untGravandoExecucaoGlobalCc11Colorantes;

interface

uses
  untAbstractGravandoExecucaoGlobalCc11, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils;
type
  TGravandoExecucaoGlobalCc11Colorantes = class(TAbstractGravandoExecucaoGlobalCc11)
  Private
    procedure IsDeletarRegistros();
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
    function GetAdoQuery(var strNomeArquivo:String):TADOQuery; override;
    function GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): string; override;
    function GetSqlDestino(): string; override;
    function fGetPath(intContador: Integer; intDiretorio: Integer): String; override;
    function IsRegistroExistente(const qryDestino: IDataSet; ArquivoText: TStringList;  intArquivo: Integer; intDiretorio: Integer): Boolean; override;
    procedure GravarRegistro(const qryDestino: IDataSet; ArquivoText: TStringList;  intArquivo: Integer; intDiretorio: Integer); override;
  end;

implementation

uses untStrUtils, untIDefinicaoTxt, untGenericDefinicaoTxt, untDefinicaoTxtCharacterSet,
  untIDefinicaoTxtCampo, untGenericDefinicaoTxtCampo, untDefinicaoTxtCampoTipo, untADOTxtFactory;

{ TGravandoExecucaoGlobalCc11Cores }

procedure TGravandoExecucaoGlobalCc11Colorantes.Executar(const gravando: IGravando);
Var
  qryDestino: IDataSet;
  intContador: Integer;
  Arquivo: TextFile;
  stlCsv: TStringList;
  strLinha: String;
  iRecordCount: Integer;
  intLinha: Integer;
  intArquivo: Integer;
  blnExcluir: Boolean;
begin
  blnExcluir := True;

  For intContador := 0 To stlPastas.Count - 1 Do
  Begin
    ListarArquivo(Conf.fGet('PATC11') + '\' + stlPastas[intContador]);

    For intArquivo := 0 To stlArquivos.Count - 1 Do
    Begin
      Try
        Try
          Gravando.Texto := 'Verificando Path do arquivo...';

          If Not fValidarPath(intArquivo, intContador) Then
          Begin
            Gravando.Texto := Format('O arquivo [%s] não foi encontrado! Verifique as Configurações.', [AnsiReplaceStr(fGetPath(intArquivo, intContador), '"', '')]);
            Exit;
          End;

          If (Gravando.Status <> sgGravando) Then
            Break;

          If (blnExcluir) Then
          Begin
            Gravando.Texto := 'Deletando Registros da tabela C11_CADCOL...';
            IsDeletarRegistros();
            blnExcluir := False;
          End;

          Gravando.Texto := 'Path verificado com sucesso...';
          Gravando.Texto := 'Verificando PROCOD...';
          TAutcomTintaFactory.Get.fInsereProCod('C11_CADCOL');
          Gravando.Texto := 'PROCOD verificado com sucesso...';

          Gravando.Texto := 'Carregando Dados...';
          iRecordCount := fContaLinhas(fGetPath(intArquivo ,intContador));
          intLinha := 1;
          qryDestino := GetDataSetDestino;
          stlCsv := TStringList.Create();
          stlCsv.StrictDelimiter := True;
          stlCsv.Delimiter := ';';

          AssignFile(Arquivo, fGetPath(intArquivo, intContador));
          Reset(Arquivo);

          If (Gravando.Status <> sgGravando) Then
            Break;

          Gravando.Texto := Format('Processando Arquivo: [%s]', [AnsiReplaceStr(fGetPath(intArquivo, intContador), '"', '')]);
          Gravando.RegistrarProgresso(0, 0, 0);

          While Not Eof(Arquivo) Do
          Begin
            If (Gravando.Status <> sgGravando) Then
              Break;

            ReadLn(Arquivo, strLinha);
            stlCsv.DelimitedText := strLinha;

            If Not IsRegistroExistente(qryDestino, stlCsv, intArquivo, intContador) Then
              GravarRegistro(qryDestino, stlCsv, intArquivo, intContador);

            Inc(intLinha);
            Gravando.RegistrarProgresso(0, intLinha, iRecordCount);
          End;
        Except
          On E: Exception Do
            Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
        End;
      Finally
        If Assigned(stlCsv) Then FreeAndNil(stlCsv);
        CloseFile(Arquivo);
      End;
    End;
  End;
end;

function TGravandoExecucaoGlobalCc11Colorantes.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Colorantes';
end;

function TGravandoExecucaoGlobalCc11Colorantes.fGetPath(
  intContador: Integer; intDiretorio: Integer): String;
begin
  Result := Conf.fGet('PATC11') + '\' + stlPastas[intDiretorio] + '\' + stlArquivos[intContador];
end;

function TGravandoExecucaoGlobalCc11Colorantes.GetAdoQuery(
  var strNomeArquivo: String): TADOQuery;
Var
  Definicao: IDefinicaoTxt;
begin
  Definicao := TGenericDefinicaoTxt.Create(strNomeArquivo, True, ';',
  dtcsDefault, '.', '.',
  TArrayIDefinicaoTxtCampoFactory.GetArrayIDefinicaoTxtCampo([
  TGenericDefinicaoTxtCampo.Create('Cod. cor', dtctText),
  TGenericDefinicaoTxtCampo.Create('Desc. base', dtctText),
  TGenericDefinicaoTxtCampo.Create('Desc. cor', dtctText),
  TGenericDefinicaoTxtCampo.Create('Vol. (L)', dtctDouble),
  TGenericDefinicaoTxtCampo.Create('Corante 1', dtctText),
  TGenericDefinicaoTxtCampo.Create('Corante 2', dtctText),
  TGenericDefinicaoTxtCampo.Create('Corante 3', dtctText),
  TGenericDefinicaoTxtCampo.Create('Corante 4', dtctText),
  TGenericDefinicaoTxtCampo.Create('Corante 5', dtctText),
  TGenericDefinicaoTxtCampo.Create('Corante 6', dtctText),
  TGenericDefinicaoTxtCampo.Create('Qtd ml 1', dtctDouble),
  TGenericDefinicaoTxtCampo.Create('Qtd ml 2', dtctDouble),
  TGenericDefinicaoTxtCampo.Create('Qtd ml 3', dtctDouble),
  TGenericDefinicaoTxtCampo.Create('Qtd ml 4', dtctDouble),
  TGenericDefinicaoTxtCampo.Create('Qtd ml 5', dtctDouble),
  TGenericDefinicaoTxtCampo.Create('Qtd ml 6', dtctDouble)]));

  TADOTxtFactory.Registrar(Definicao);
  strNomeArquivo := Definicao.NomeArquivo;
  Result := TADOTxtFactory.GetTxt12Query(ExtractFileDir(strNomeArquivo));
end;

function TGravandoExecucaoGlobalCc11Colorantes.GetSqlDestino: string;
begin
  Result := ' SELECT * FROM C11_CADCOL  ';
end;

function TGravandoExecucaoGlobalCc11Colorantes.GetSqlOrigem(
  const strNomeArquivo: string; const stlTabelas: TStrings): string;
begin
  Result := '';
end;

procedure TGravandoExecucaoGlobalCc11Colorantes.GravarRegistro(
  const qryDestino: IDataSet; ArquivoText: TStringList;  intArquivo: Integer;
  intDiretorio: Integer);
Var
  intContador: Integer;
  intColorante: Integer;
begin
  intColorante := 4;

  For intContador := 1 To 6 Do
  Begin
    If Not qryDestino.Locate('COL_CODCOL', VarArrayOf([ArquivoText[intColorante]]), []) Then
    Begin
      If TStrUtils.fEmptyStr(ArquivoText[intColorante]) Then
        Exit;

      qryDestino.Insert;
      qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('C11_CADCOL', TAutcomTintaFactory.Get.GetCodEmp);
      qryDestino.FieldByName('COL_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
      qryDestino.FieldByName('COL_CODCOL').AsString := ArquivoText[intColorante];
      qryDestino.FieldByName('COL_DESCRI').AsString := ArquivoText[intColorante];
      qryDestino.FieldByName('COL_EMBALA').AsFloat  := 900;
      qryDestino.Post;
    End;
    Inc(intColorante, 2);
  End;
end;

procedure TGravandoExecucaoGlobalCc11Colorantes.IsDeletarRegistros;
Var
  qryDelet: IDataSet;
begin
  qryDelet := TAutcomTintaFactory.Get.fGetDataSet;
  qryDelet.SQL := 'DELETE FROM C11_CADCOL       ';
  qryDelet.ExecSQL;
end;

function TGravandoExecucaoGlobalCc11Colorantes.IsRegistroExistente(
  const qryDestino: IDataSet; ArquivoText: TStringList;  intArquivo: Integer;
  intDiretorio: Integer): Boolean;
begin
  Result := False;

  If ArquivoText[0] = 'Cod. cor' Then
  Begin
    Result := True;
    Exit;
  End;
end;


end.

