{******************************************************************************}
{* Classe responsável pela geração do cadastro de colorantes da tinta BellaCor *}
{***************************************************************************PH*}
unit untGravandoExecucaoBellaCorColorantes;

interface

uses
  untAbstractGravandoExecucaoBellaCor, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils;
type
  TGravandoExecucaoBellaCorColorantes = class(TAbstractGravandoExecucaoBellaCor)
  Private
    procedure IsDeletarRegistros();
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


procedure TGravandoExecucaoBellaCorColorantes.Executar(const gravando: IGravando);
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
      If stlArquivos[intContador] <> 'ArquivoComplementar.CSV' Then
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
          Gravando.Texto := 'Deletando Registros da tabela BEL_CADCOL...';
          IsDeletarRegistros();
          blnExcluir := False;
        End;

        Gravando.Texto := 'Path verificado com sucesso...';
        Gravando.Texto := 'Verificando PROCOD...';
        TAutcomTintaFactory.Get.fInsereProCod('BEL_CADCOL');
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

      End;
    End;
  Except
    On E: Exception Do
      Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
  End;


  {Try

    Try
      If Not FileExists(GetPath)  Then
      Begin
        gravando.Texto := 'Arquivo para a geração dos colorantes não é válido...';
        gravando.Cancelar;
        Exit;
      End;

      gravando.Texto := 'Arquivo Validado com Sucesso ...';

      if gravando.Status <> sgGravando then
        Exit;

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('BEL_CADCOL');
      gravando.Texto := 'PROCOD verificado com sucesso!';

      if gravando.Status <> sgGravando then
        Exit;

      gravando.Texto := 'Excluindo os registros...';
      qryDelete := TAutcomTintaFactory.Get.fGetDataSet;
      qryDelete.SQL := 'DELETE FROM BEL_CADCOL';
      qryDelete.ExecSQL;


      gravando.Texto := 'Iniciando Geração do Cadastro de Colorantes...';

      slArquivo     := TStringList.Create;
      slQuebraLinha := TStringList.Create;

      slArquivo.LoadFromFile(GetPath);
      intProcesso := 0;

      For intCont := 0 to slArquivo.Count - 1 do
      Begin
        if gravando.Status <> sgGravando then
          Exit;

        slQuebraLinha.Delimiter := ';';
        slQuebraLinha.StrictDelimiter := True;
        slQuebraLinha.DelimitedText := slArquivo[intCont];


        strCodigo := UpperCase(slQuebraLinha[5]);

        qryCadCol := TAutcomTintaFactory.Get.fGetDataSet;
        qryCadCol.SQL := 'SELECT * '+
                         '  FROM BEL_CADCOL'+
                         ' WHERE COL_CODCOL = :CODIGO';
        qryCadCol.ParamByName('CODIGO').AsString :=  strCodigo;
        qryCadCol.Open;

        IF (qryCadCol.IsEmpty)Then
        Begin
          qryCadCol.Insert;
          qryCadCol.FieldByName('AUTOINCREM').AsString  := TAutcomTintaFactory.Get.fRetAutoIncrem('BEL_CADCOL', TAutcomTintaFactory.Get.GetCodEmp);
          qryCadCol.FieldByName('COL_CODEMP').AsString  := TAutcomTintaFactory.Get.GetCodEmp;
          qryCadCol.FieldByName('COL_CODCOL').AsString  := strCodigo;
          qryCadCol.FieldByName('COL_DESCRI').AsString  := strCodigo;
          qryCadCol.Post;
        End;

        Inc(intProcesso);
        gravando.RegistrarProgresso(0, intProcesso, slArquivo.Count);
      End;

    Except
      on E: Exception do
      begin
        gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      end;
    End;

  Finally

  End;}

end;

function TGravandoExecucaoBellaCorColorantes.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Colorantes';
end;

function TGravandoExecucaoBellaCorColorantes.GetSqlDestino: string;
begin
  Result := ' SELECT * FROM BEL_CADCOL  ';
end;

procedure TGravandoExecucaoBellaCorColorantes.GravarRegistro(
  const qryDestino: IDataSet; ArquivoText: TStringList; intArquivo: Integer);
begin
  qryDestino.Insert;
  qryDestino.FieldByName('AUTOINCREM').AsString  := TAutcomTintaFactory.Get.fRetAutoIncrem('BEL_CADCOL', TAutcomTintaFactory.Get.GetCodEmp);
  qryDestino.FieldByName('COL_CODEMP').AsString  := TAutcomTintaFactory.Get.GetCodEmp;
  qryDestino.FieldByName('COL_CODCOL').AsString  := LimpaTexto(ArquivoText[1]);
  qryDestino.FieldByName('COL_DESCRI').AsString  := LimpaTexto(ArquivoText[2]);
  qryDestino.FieldByName('COL_EMBALA').AsFloat   := StrToFloat(ArquivoText[3]);
  qryDestino.Post;
end;

procedure TGravandoExecucaoBellaCorColorantes.IsDeletarRegistros;
Var
  qryDelet: IDataSet;
begin
  qryDelet := TAutcomTintaFactory.Get.fGetDataSet;
  qryDelet.SQL := 'DELETE FROM BEL_CADCOL        ';
  qryDelet.ExecSQL;
end;

function TGravandoExecucaoBellaCorColorantes.IsRegistroExistente(
  const qryDestino: IDataSet; ArquivoText: TStringList;
  intArquivo: Integer): Boolean;
begin
  If ArquivoText[0] = 'id' Then
  Begin
    Result := True;
    Exit;
  End;

  Result := qryDestino.Locate('COL_CODCOL', LimpaTexto(ArquivoText[1]), []);
end;

end.

