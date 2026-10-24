{******************************************************************************}
{* Classe responsável pela geração do cadastro de Bases da tinta BellaCor *}
{***************************************************************************PH*}
unit untGravandoExecucaoBellaCorBases;

interface

uses
  untAbstractGravandoExecucaoBellaCor, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils;
type
  TGravandoExecucaoBellaCorBases = class(TAbstractGravandoExecucaoBellaCor)
  Private
    procedure IsDeletarRegistros();
    function fRetUnidade(fltEmbalagem: Double): String;
  Protected
    function IsRegistroExistente(const qryDestino: IDataSet; ArquivoText: TStringList; intArquivo: Integer): Boolean; Override;
    procedure GravarRegistro(const qryDestino: IDataSet; ArquivoText: TStringList;  intArquivo: Integer); Override;
    function GetSqlDestino(): string; Override;

  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;

  end;

implementation

uses untStrUtils, untIDefinicaoTxt, untGenericDefinicaoTxt, untDefinicaoTxtCharacterSet,
  untIDefinicaoTxtCampo, untGenericDefinicaoTxtCampo, untDefinicaoTxtCampoTipo, untADOTxtFactory;

{ TGravandoExecucaoBellaCorCores }


procedure TGravandoExecucaoBellaCorBases.Executar(const gravando: IGravando);
Var
  qryDestino: IDataSet;
  intContador: Integer;
  Arquivo: TextFile;
  stlCsv: TStringList;
  strLinha: RawByteString;
  iRecordCount: Integer;
  intLinha: Integer;
  blnExcluir: Boolean;
begin
  blnExcluir := True;
  Try
    For intContador := 0 To stlArquivos.Count - 1 Do
    Begin
      If stlArquivos[intContador] = 'ArquivoComplementar.CSV' Then
        Continue;
      Try
        Gravando.Texto := 'Verificando Path do arquivo...';

        If Not fValidaPath(intContador) Then
        Begin
          Gravando.Texto := Format('O arquivo [%s] não foi encontrado! Verifique as Configurações.', [AnsiReplaceStr(GetPath(intContador), '"', '')]);
            Exit;
        End;

        If (Gravando.Status <> sgGravando) Then
          Break;

        If (blnExcluir) Then
        Begin
          Gravando.Texto := 'Deletando Registros da tabela BEL_CADBAS...';
          IsDeletarRegistros();
          blnExcluir := False;
        End;

        Gravando.Texto := 'Path verificado com sucesso...';
        Gravando.Texto := 'Verificando PROCOD...';
        TAutcomTintaFactory.Get.fInsereProCod('BEL_CADBAS');
        Gravando.Texto := 'PROCOD verificado com sucesso...';

        Gravando.Texto := 'Carregando Dados...';
        iRecordCount := fContaLinhas(GetPath(intContador));
        intLinha := 1;
        qryDestino := GetDataSetDestino;
        stlCsv := TStringList.Create();
        stlCsv.StrictDelimiter := True;
        stlCsv.Delimiter := ';';

        AssignFile(Arquivo, GetPath(intContador));
        Reset(Arquivo);

        If (Gravando.Status <> sgGravando) Then
            Break;

        Gravando.Texto := Format('Processando Arquivo: [%s]', [AnsiReplaceStr(GetPath(intContador), '"', '')]);
        Gravando.RegistrarProgresso(0, 0, 0);

        While Not Eof(Arquivo) Do
        Begin
          If (Gravando.Status <> sgGravando) Then
            Break;

          ReadLn(Arquivo, strLinha);
          stlCsv.DelimitedText := UTF8ToWideString(strLinha);

          If Not IsRegistroExistente(qryDestino, stlCsv, intContador) Then
            GravarRegistro(qryDestino, stlCsv, intContador);

          Inc(intLinha);
          Gravando.RegistrarProgresso(0, intLinha, iRecordCount);
        End;
      Finally
        If Assigned(stlCsv) Then
          FreeAndNil(stlCsv);
        CloseFile(Arquivo);
      End;
    End;
  Except
    On E: Exception Do
      Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
  End;
end;

function TGravandoExecucaoBellaCorBases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases';
end;

function TGravandoExecucaoBellaCorBases.fRetUnidade(
  fltEmbalagem: Double): String;
begin
  If fltEmbalagem < 1000 Then
    Result := 'LT'
  Else If fltEmbalagem < 7000 Then
    Result := 'GL'
  Else
    Result := 'LA';
end;

function TGravandoExecucaoBellaCorBases.GetSqlDestino: string;
begin
  Result := ' SELECT * FROM BEL_CADBAS  ';
end;

procedure TGravandoExecucaoBellaCorBases.GravarRegistro(
  const qryDestino: IDataSet; ArquivoText: TStringList; intArquivo: Integer);
begin
  qryDestino.Insert;
  qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('BEL_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
  qryDestino.FieldByName('BAS_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
  qryDestino.FieldByName('BAS_CODBAS').AsString := LimpaTexto(ArquivoText[4]);
  qryDestino.FieldByName('BAS_PRODUT').AsString := LimpaTexto(ArquivoText[8]);
  qryDestino.FieldByName('BAS_DESCRI').AsString := LimpaTexto(ArquivoText[4]);
  qryDestino.FieldByName('BAS_CODUNI').AsString := fRetUnidade(StrToFloat(ArquivoText[6]));
  qryDestino.Post;
end;

procedure TGravandoExecucaoBellaCorBases.IsDeletarRegistros;
Var
  qryDelet: IDataSet;
begin
  qryDelet := TAutcomTintaFactory.Get.fGetDataSet;
  qryDelet.SQL := '              ' +
  ' SET FOREIGN_KEY_CHECKS=0;    ' +
  ' DELETE FROM BEL_CADBAS;      ' +
  ' SET FOREIGN_KEY_CHECKS=1;    ';
  qryDelet.ExecSQL;
end;

function TGravandoExecucaoBellaCorBases.IsRegistroExistente(
  const qryDestino: IDataSet; ArquivoText: TStringList;
  intArquivo: Integer): Boolean;
begin
  If ArquivoText[0] = 'id_seq' Then
  Begin
    Result := True;
    Exit;
  End;

  Result := qryDestino.Locate('BAS_CODBAS;BAS_PRODUT;BAS_CODUNI', VarArrayOf([LimpaTexto(ArquivoText[4]), LimpaTexto(ArquivoText[8]),
    fRetUnidade(StrToFloat(ArquivoText[6]))]), []);
end;

end.

