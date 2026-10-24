{**********************************************************************************}
{* Classe responsável pela geração do cadastro de bases da tinta BlascorAutomotiva *}
{*******************************************************************************AC*}
unit untGravandoExecucaoBlascorAutomotivaBases;

interface

uses
  untAbstractGravandoExecucaoBlascorAutomotiva, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils;
type
  TGravandoExecucaoBlascorAutomotivaBases = class(TAbstractGravandoExecucaoBlascorAutomotiva)
  Private
    function fQtdEmbalagemMl(strEmbalagem: String): String;
    procedure IsDeletarRegistros();
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
    function GetAdoQuery(var strNomeArquivo:String):TADOQuery; override;
    function GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): string; override;
    function GetSqlDestino(): string; override;
    function fGetPath(): String; override;
    function IsRegistroExistente(const qryDestino: IDataSet; ArquivoText: TStringList): Boolean; override;
    procedure GravarRegistro(const qryDestino: IDataSet; ArquivoText: TStringList); override;
  end;

implementation

uses untStrUtils, untIDefinicaoTxt, untGenericDefinicaoTxt, untDefinicaoTxtCharacterSet,
  untIDefinicaoTxtCampo, untGenericDefinicaoTxtCampo, untDefinicaoTxtCampoTipo, untADOTxtFactory;

{ TGravandoExecucaoBlascorAutomotivaBases }

procedure TGravandoExecucaoBlascorAutomotivaBases.Executar(const gravando: IGravando);
Var
  qryDestino: IDataSet;
  Arquivo: TextFile;
  stlCsv: TStringList;
  strLinha: String;
  iRecordCount: Integer;
  intLinha: Integer;
begin
  Try
    Try
      Gravando.Texto := 'Verificando Path do arquivo...';

      If Not fValidarPath Then
      Begin
        Gravando.Texto := Format('O arquivo [%s] não foi encontrado! Verifique as Configurações.', [AnsiReplaceStr(fGetPath, '"', '')]);
        Exit;
      End;

      If (Gravando.Status <> sgGravando) Then
        Exit;

      Gravando.Texto := 'Deletando Registros da tabela BLA_CADBAS...';
      IsDeletarRegistros();

      Gravando.Texto := 'Path verificado com sucesso...';
      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('BLA_CADBAS');
      Gravando.Texto := 'PROCOD verificado com sucesso...';

      Gravando.Texto := 'Carregando Dados...';
      iRecordCount := fContaLinhas(fGetPath);
      intLinha := 1;
      qryDestino := GetDataSetDestino;
      stlCsv := TStringList.Create();
      stlCsv.StrictDelimiter := True;
      stlCsv.Delimiter := ',';

      AssignFile(Arquivo, fGetPath);
      Reset(Arquivo);

      If (Gravando.Status <> sgGravando) Then
        Exit;

      Gravando.Texto := Format('Processando Arquivo: [%s]', [AnsiReplaceStr(fGetPath, '"', '')]);
      Gravando.RegistrarProgresso(0, 0, 0);

      While Not Eof(Arquivo) Do
      Begin
        If (Gravando.Status <> sgGravando) Then
          Break;

        ReadLn(Arquivo, strLinha);
        stlCsv.DelimitedText := strLinha;

        If Not IsRegistroExistente(qryDestino, stlCsv) Then
          GravarRegistro(qryDestino, stlCsv);

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
end;

function TGravandoExecucaoBlascorAutomotivaBases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases';
end;


function TGravandoExecucaoBlascorAutomotivaBases.fGetPath(): String;
begin
  Result := Conf.fGet('PATBLA');
end;

function TGravandoExecucaoBlascorAutomotivaBases.fQtdEmbalagemMl(
  strEmbalagem: String): String;
begin
  Result := Trim(strEmbalagem) + ' ML';
end;

function TGravandoExecucaoBlascorAutomotivaBases.GetAdoQuery(
  var strNomeArquivo: String): TADOQuery;
begin
  Result := Nil;
end;

function TGravandoExecucaoBlascorAutomotivaBases.GetSqlDestino: string;
begin
  Result := ' SELECT * FROM BLA_CADBAS';
end;

function TGravandoExecucaoBlascorAutomotivaBases.GetSqlOrigem(
  const strNomeArquivo: string; const stlTabelas: TStrings): string;
begin
  Result := '';
end;

procedure TGravandoExecucaoBlascorAutomotivaBases.GravarRegistro(const qryDestino: IDataSet; ArquivoText: TStringList);
begin
  qryDestino.Insert;
  qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('BLA_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
  qryDestino.FieldByName('BAS_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
  qryDestino.FieldByName('BAS_CODBAS').AsString := LimpaTexto(ArquivoText[14]);
  qryDestino.FieldByName('BAS_DESCRI').AsString := LimpaTexto(ArquivoText[15]);
  qryDestino.FieldByName('BAS_EMBALA').AsFloat  := 900;
  qryDestino.FieldByName('BAS_PESESP').AsFloat  := StrToFloat(AnsiReplaceStr(ArquivoText[20], '.', ','));
  qryDestino.FieldByName('BAS_QTDEMB').AsString := AnsiReplaceStr(fQtdEmbalagemMl(FloatToStrF(qryDestino.FieldByName('BAS_EMBALA').AsFloat, ffNumber, 12, 0)), '.', '');
  qryDestino.Post;
end;

procedure TGravandoExecucaoBlascorAutomotivaBases.IsDeletarRegistros;
Var
  qryDelet: IDataSet;
begin
  qryDelet := TAutcomTintaFactory.Get.fGetDataSet;
  qryDelet.SQL := 'DELETE FROM BLA_CADBAS        ';
  qryDelet.ExecSQL;
end;

function TGravandoExecucaoBlascorAutomotivaBases.IsRegistroExistente(const qryDestino: IDataSet; ArquivoText: TStringList): Boolean;
begin
  If ArquivoText[0] = 'codInterno' Then
  Begin
    Result := True;
    Exit;
  End;

  Result := qryDestino.Locate('BAS_CODBAS', LimpaTexto(ArquivoText[14]), []);
end;

end.
