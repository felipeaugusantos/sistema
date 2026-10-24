{*************************************************************************}
{* Classe responsável pela geração do cadastro de bases da tinta MegaTintas *}
{**********************************************************************PH*}
unit untGravandoExecucaoMegaTintasBases;

interface

uses
  untAbstractGravandoExecucaoMegaTintas, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils;

type
  TGravandoExecucaoMegaTintasBases = class(TAbstractGravandoExecucaoMegaTintas)
  Private
    function fRetUnidade(fltVolume: Double): String;
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

{ TGravandoExecucaoMegaTintasBases }

procedure TGravandoExecucaoMegaTintasBases.Executar(const gravando: IGravando);
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

  For intContador := 0 To 0 Do
  Begin
    ListarArquivo(Conf.fGet('PATMEG') + '\' + stlPastas[intContador]);

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
            Gravando.Texto := 'Deletando Registros da tabela MEG_CADBAS...';
            IsDeletarRegistros();
            blnExcluir := False;
          End;

          Gravando.Texto := 'Path verificado com sucesso...';
          Gravando.Texto := 'Verificando PROCOD...';
          TAutcomTintaFactory.Get.fInsereProCod('MEG_CADBAS');
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

function TGravandoExecucaoMegaTintasBases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases';
end;

function TGravandoExecucaoMegaTintasBases.fGetPath(intContador,
  intDiretorio: Integer): String;
begin
  Result := Conf.fGet('PATMEG') + '\' + stlPastas[intDiretorio] + '\' + stlArquivos[intContador];
end;

function TGravandoExecucaoMegaTintasBases.fRetUnidade(
  fltVolume: Double): String;
begin
  If fltVolume <= 1.000 Then
    Result := 'LT'
  Else If (fltVolume <= 7.000) Then
    Result := 'GL'
  Else
    Result := 'LA';
end;

function TGravandoExecucaoMegaTintasBases.GetAdoQuery(
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

function TGravandoExecucaoMegaTintasBases.GetSqlDestino: string;
begin
  Result := ' SELECT * FROM MEG_CADBAS';
end;

function TGravandoExecucaoMegaTintasBases.GetSqlOrigem(
  const strNomeArquivo: string; const stlTabelas: TStrings): string;
begin
  Result := '';
end;

procedure TGravandoExecucaoMegaTintasBases.GravarRegistro(
  const qryDestino: IDataSet; ArquivoText: TStringList; intArquivo,
  intDiretorio: Integer);
Var
  strProduto: String;
begin
  strProduto := Copy(stlArquivos[intArquivo], Pos('_', stlArquivos[intArquivo]) + 1, Length(stlArquivos[intArquivo]));

  qryDestino.Insert;
  qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('MEG_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
  qryDestino.FieldByName('BAS_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
  qryDestino.FieldByName('BAS_CODBAS').AsString := ArquivoText[1];
  qryDestino.FieldByName('BAS_DESCRI').AsString := ArquivoText[1];
  qryDestino.FieldByName('BAS_EMBALA').AsFloat  := StrToFloat(ArquivoText[3]);
  qryDestino.FieldByName('BAS_CODUNI').AsString := fRetUnidade(StrToFloat(ArquivoText[3]));
  qryDestino.FieldByName('BAS_PRODUT').AsString := Copy(stlArquivos[intArquivo], Pos('_', stlArquivos[intArquivo]) + 1, Length(strProduto) - 4);
  qryDestino.Post;
end;

procedure TGravandoExecucaoMegaTintasBases.IsDeletarRegistros;
Var
  qryDelet: IDataSet;
begin
  qryDelet := TAutcomTintaFactory.Get.fGetDataSet;
  qryDelet.SQL := 'DELETE FROM MEG_CADBAS        ';
  qryDelet.ExecSQL;
end;

function TGravandoExecucaoMegaTintasBases.IsRegistroExistente(
  const qryDestino: IDataSet; ArquivoText: TStringList; intArquivo,
  intDiretorio: Integer): Boolean;
Var
  strProduto: String;
begin
  If ArquivoText[0] = 'Cod. cor' Then
  Begin
    Result := True;
    Exit;
  End;

  strProduto := Copy(stlArquivos[intArquivo], Pos('_', stlArquivos[intArquivo]) + 1, Length(stlArquivos[intArquivo]));

  Result := qryDestino.Locate('BAS_CODBAS;BAS_PRODUT;BAS_CODUNI', VarArrayOf([ArquivoText[1],
    Copy(stlArquivos[intArquivo], Pos('_', stlArquivos[intArquivo]) + 1, Length(strProduto) - 4), fRetUnidade(StrToFloat(ArquivoText[3]))]), []);
end;

end.
