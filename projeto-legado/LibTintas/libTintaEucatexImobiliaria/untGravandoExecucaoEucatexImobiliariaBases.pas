{******************************************************************************************}
{* Classe responsável pela geração do cadastro de Bases da tinta Eucatex Imobiliaria *}
{***************************************************************************************PH*}
unit untGravandoExecucaoEucatexImobiliariaBases;

interface

uses
  untAbstractGravandoExecucaoEucatexImobiliaria, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, untStatusGravando, DB, Classes, StrUtils, Variants;

type
  TGravandoExecucaoEucatexImobiliariaBases = class(TAbstractGravandoExecucaoEucatexImobiliaria)
  Private
    function fRetUnidade(fVolume: Double) : String;
  Protected
    function IsRegistroExistente(const qryDestino: IDataSet; ArquivoText: TStringList; intArquivo: Integer): Boolean; Override;
    procedure GravarRegistro(const qryDestino: IDataSet; ArquivoText: TStringList;  intArquivo: Integer); Override;
    function GetSqlDestino(): string; Override;
    procedure IsDeletarRegistros(); Override;
  Public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

uses untStrUtils;

{ TGravandoExecucaoEucatexImobiliariaCores }

procedure TGravandoExecucaoEucatexImobiliariaBases.Executar(const gravando: IGravando);
Var
  qryDestino: IDataSet;
  Arquivo: TextFile;
  stlCsv: TStringList;
  strLinha: String;
  iRecordCount: Integer;
  intLinha: Integer;
  intArquivo: Integer;
  blnExcluir: Boolean;
begin
  Try
    Try
      blnExcluir := True;

      For intArquivo := 0 To stlArquivos.Count - 1 Do
      Begin
        If Pos('ArquivoComplementar', stlArquivos[intArquivo]) > 0 Then
          Continue;

        Gravando.Texto := 'Verificando Path do Arquivo...';


        If Not fValidarPath(intArquivo) Then
        Begin
          Gravando.Texto := Format('O arquivo [%s] não foi encontrado. Verifique as configurações da tinta', [AnsiReplaceStr(fGetPath(intArquivo), '"', '')]);
          Exit;
        End;

        If blnExcluir Then
        Begin
          Gravando.Texto := 'Deletando registros da tabela EUC_CADBAS...';
          IsDeletarRegistros;
          blnExcluir := False;
        End;

        If (Gravando.Status <> sgGravando) Then
          Break;

        Gravando.Texto := 'Verificando PROCOD...';
        TAutcomTintaFactory.Get.fInsereProCod('EUC_CADBAS');
        Gravando.Texto := 'PROCOD verificado com sucesso...';

        Gravando.Texto := 'Carregando dados...';

        Gravando.Texto := 'Carregando Dados...';
        iRecordCount := fContaLinhas(fGetPath(intArquivo));
        intLinha := 1;
        qryDestino := GetDataSetDestino;
        stlCsv := TStringList.Create();
        stlCsv.StrictDelimiter := True;
        stlCsv.Delimiter := ';';

        AssignFile(Arquivo, fGetPath(intArquivo));
          Reset(Arquivo);

        If (Gravando.Status <> sgGravando) Then
          Break;

        Gravando.Texto := Format('Processando Arquivo: [%s]', [AnsiReplaceStr(fGetPath(intArquivo), '"', '')]);
        Gravando.RegistrarProgresso(0, 0, 0);

        While Not Eof(Arquivo) Do
        Begin
          If (Gravando.Status <> sgGravando) Then
              Break;

          ReadLn(Arquivo, strLinha);
          stlCsv.DelimitedText := strLinha;

          If Not IsRegistroExistente(qryDestino, stlCsv, intArquivo) Then
            GravarRegistro(qryDestino, stlCsv, intArquivo);

          Inc(intLinha);
          Gravando.RegistrarProgresso(0, intLinha, iRecordCount);
        End;

        If Assigned(stlCsv) Then
          FreeAndNil(stlCsv);

        CloseFile(Arquivo);
      End;
    Except
      On E: Exception Do
      Begin
        Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
        Gravando.Cancelar;
      End;
    End;
  Finally
  End;
end;

function TGravandoExecucaoEucatexImobiliariaBases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases';
end;

function TGravandoExecucaoEucatexImobiliariaBases.fRetUnidade(fVolume: Double) : String;
begin
  If fVolume <= 1200 Then
    Result := 'LT'
  Else If fVolume <= 7500 Then
    Result := 'GL'
  Else
    Result := 'LA';
end;

function TGravandoExecucaoEucatexImobiliariaBases.GetSqlDestino: string;
begin
  Result := ' SELECT * FROM EUC_CADBAS  ';
end;

procedure TGravandoExecucaoEucatexImobiliariaBases.GravarRegistro(
  const qryDestino: IDataSet; ArquivoText: TStringList; intArquivo: Integer);
begin
  qryDestino.Insert;
  qryDestino.FieldByName('AUTOINCREM').AsString  := TAutcomTintaFactory.Get.fRetAutoIncrem('EUC_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
  qryDestino.FieldByName('BAS_CODEMP').AsString  := TAutcomTintaFactory.Get.GetCodEmp;
  qryDestino.FieldByName('BAS_DESCRI').AsString  := ArquivoText[4];
  qryDestino.FieldByName('BAS_PRODUT').AsString  := ArquivoText[8];
  qryDestino.FieldByName('BAS_CODUNI').AsString  := fRetUnidade(StrToFloat(ArquivoText[6]));
  qryDestino.Post;
end;

procedure TGravandoExecucaoEucatexImobiliariaBases.IsDeletarRegistros;
Var
  qryDelet: IDataSet;
begin
  qryDelet := TAutcomTintaFactory.Get.fGetDataSet;
  qryDelet.SQL := 'DELETE FROM EUC_CADBAS       ';
  qryDelet.ExecSQL;
end;

function TGravandoExecucaoEucatexImobiliariaBases.IsRegistroExistente(
  const qryDestino: IDataSet; ArquivoText: TStringList;
  intArquivo: Integer): Boolean;
begin
  If ArquivoText[0] = 'id_seq' Then
    Exit(True);

  Result := qryDestino.Locate('BAS_DESCRI;BAS_PRODUT;BAS_CODUNI', VarArrayOf([ArquivoText[4], ArquivoText[8],
    fRetUnidade(StrToFloat(ArquivoText[6]))]), []);
end;

end.

