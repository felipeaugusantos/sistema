{**********************************************************************************}
{* Classe responsável pela geração do cadastro de Linhas da tinta BlascorAutomotiva *}
{*******************************************************************************AC*}
unit untGravandoExecucaoBlascorAutomotivaLinhas;

interface

uses
  untAbstractGravandoExecucaoBlascorAutomotiva, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils;
type
  TGravandoExecucaoBlascorAutomotivaLinhas = class(TAbstractGravandoExecucaoBlascorAutomotiva)
  Private
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

{ TGravandoExecucaoBlascorAutomotivaLinhas }

procedure TGravandoExecucaoBlascorAutomotivaLinhas.Executar(const gravando: IGravando);
Var
  qryDestino: IDataSet;
  Arquivo: TextFile;
  stlCsv: TStringList;
  strLinha: RawByteString;
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

      Gravando.Texto := 'Deletando Registros da tabela BLA_CADLIN...';
      IsDeletarRegistros();

      Gravando.Texto := 'Path verificado com sucesso...';
      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('BLA_CADLIN');
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
        stlCsv.DelimitedText := UTF8ToWideString(strLinha);

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

function TGravandoExecucaoBlascorAutomotivaLinhas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Linhas';
end;


function TGravandoExecucaoBlascorAutomotivaLinhas.fGetPath(): String;
begin
  Result := Conf.fGet('PATBLA');
end;

function TGravandoExecucaoBlascorAutomotivaLinhas.GetAdoQuery(
  var strNomeArquivo: String): TADOQuery;
begin
  Result := Nil;
end;

function TGravandoExecucaoBlascorAutomotivaLinhas.GetSqlDestino: string;
begin
  Result := ' SELECT * FROM BLA_CADLIN';
end;

function TGravandoExecucaoBlascorAutomotivaLinhas.GetSqlOrigem(
  const strNomeArquivo: string; const stlTabelas: TStrings): string;
begin
  Result := '';
end;

procedure TGravandoExecucaoBlascorAutomotivaLinhas.GravarRegistro(const qryDestino: IDataSet; ArquivoText: TStringList);
begin
  qryDestino.Insert;
  qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('BLA_CADLIN', TAutcomTintaFactory.Get.GetCodEmp);
  qryDestino.FieldByName('LIN_CODLIN').AsString := LimpaTexto(ArquivoText[5]);
  qryDestino.FieldByName('LIN_DESCRI').AsString := LimpaTexto(ArquivoText[6]);
  qryDestino.Post;
end;

procedure TGravandoExecucaoBlascorAutomotivaLinhas.IsDeletarRegistros;
Var
  qryDelet: IDataSet;
begin
  qryDelet := TAutcomTintaFactory.Get.fGetDataSet;
  qryDelet.SQL := 'DELETE FROM BLA_CADLIN        ';
  qryDelet.ExecSQL;
end;

function TGravandoExecucaoBlascorAutomotivaLinhas.IsRegistroExistente(const qryDestino: IDataSet; ArquivoText: TStringList): Boolean;
begin
  If ArquivoText[0] = 'codInterno' Then
  Begin
    Result := True;
    Exit;
  End;

  Result := qryDestino.Locate('LIN_CODLIN', LimpaTexto(ArquivoText[5]), []);
end;

end.
