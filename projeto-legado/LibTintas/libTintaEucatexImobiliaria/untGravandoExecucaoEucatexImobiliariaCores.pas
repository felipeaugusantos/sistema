unit untGravandoExecucaoEucatexImobiliariaCores;

interface

uses
  untAbstractGravandoExecucaoEucatexImobiliaria, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, untStrUtils, untStatusGravando, DB, StrUtils, ComObj,
  untLibTintaFactory, System.Classes, UniClientDataSet, Uni, Vcl.Graphics, Variants;

type
  TGravandoExecucaoEucatexImobiliariaCores = class(TAbstractGravandoExecucaoEucatexImobiliaria)
  Private
    cdColorantes: TUniClientDataSet;
    intCodSeq: Integer;
    function fRetMd5Key(qryCadCor : IDataSet) : String;
    function fRetUnidade(fVolume: Double) : String;
    Procedure ProcessClientDataSetColorantes(const Gravando: IGravando);
  Protected
    function IsRegistroExistente(const qryDestino: IDataSet; ArquivoText: TStringList; intArquivo: Integer): Boolean; Override;
    procedure GravarRegistro(const qryDestino: IDataSet; ArquivoText: TStringList;  intArquivo: Integer); Override;
    function GetSqlDestino(): string; Override;
    procedure IsDeletarRegistros(); Override;
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

Implementation

uses
  untFuncoesGenerica;

{ TGravandoExecucaoEucatexImobiliariaCores }


procedure TGravandoExecucaoEucatexImobiliariaCores.Executar(const gravando: IGravando);
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
      intCodSeq := 0;

      ProcessClientDataSetColorantes(Gravando);

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
          Gravando.Texto := 'Deletando registros da tabela EUC_CADEUC...';
          IsDeletarRegistros;
          blnExcluir := False;
        End;

        If (Gravando.Status <> sgGravando) Then
          Break;

        Gravando.Texto := 'Verificando PROCOD...';
        TAutcomTintaFactory.Get.fInsereProCod('EUC_CADEUC');
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


function TGravandoExecucaoEucatexImobiliariaCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;



function TGravandoExecucaoEucatexImobiliariaCores.fRetMd5Key(qryCadCor: IDataSet): String;
begin
  Result :=   qryCadCor.FieldByName('EUC_CODCOR').AsString +
              qryCadCor.FieldByName('EUC_DESCOR').AsString +
              qryCadCor.FieldByName('EUC_PRODUT').AsString +
              qryCadCor.FieldByName('EUC_DESBAS').AsString +
              qryCadCor.FieldByName('EUC_UNIDAD').AsString +
              qryCadCor.FieldByName('EUC_COLECA').AsString;
end;


function TGravandoExecucaoEucatexImobiliariaCores.fRetUnidade(fVolume: Double) : String;
begin
  If fVolume <= 1200 Then
    Result := 'LT'
  Else If fVolume <= 7500 Then
    Result := 'GL'
  Else
    Result := 'LA';
end;

function TGravandoExecucaoEucatexImobiliariaCores.GetSqlDestino: string;
begin
  Result := ' SELECT * FROM EUC_CADEUC  ';
end;

procedure TGravandoExecucaoEucatexImobiliariaCores.GravarRegistro(
  const qryDestino: IDataSet; ArquivoText: TStringList; intArquivo: Integer);
Var
  intColorante: Integer;
  intQuantidade: Integer;
  intContador: Integer;
  strMd5: String;
begin
  Inc(intCodSeq);
  strMd5 := '';
  intColorante := 11;
  intQuantidade := 17;

  qryDestino.Insert;
  qryDestino.FieldByName('AUTOINCREM').AsString  := TAutcomTintaFactory.Get.fRetAutoIncrem('EUC_CADEUC', TAutcomTintaFactory.Get.GetCodEmp);
  qryDestino.FieldByName('EUC_CODEMP').AsString  := TAutcomTintaFactory.Get.GetCodEmp;
  qryDestino.FieldByName('EUC_DTACAD').AsDate    := Date;
  qryDestino.FieldByName('EUC_CODSEQ').AsString  := TStrUtils.fStrZero(intCodSeq, 6);
  qryDestino.FieldByName('EUC_COLECA').AsString  := ArquivoText[10];
  qryDestino.FieldByName('EUC_CODCOR').AsString  := ArquivoText[1];
  qryDestino.FieldByName('EUC_DESCOR').AsString  := ArquivoText[2];
  qryDestino.FieldByName('EUC_PRODUT').AsString  := ArquivoText[8];
  qryDestino.FieldByName('EUC_DESBAS').AsString  := ArquivoText[4];
  qryDestino.FieldByName('EUC_UNIDAD').AsString  := fRetUnidade(StrToFloat(ArquivoText[6]));
  strMd5  := strMd5 + fRetMd5Key(qryDestino);

  For intContador := 1 To 6 Do
  Begin
    If TStrUtils.fEmptyStr( ArquivoText[intColorante]) Then
      Break;

    If Not cdColorantes.Locate('ID', ArquivoText[intColorante], []) Then
      Break;

    qryDestino.FieldByName('EUC_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString := cdColorantes.FieldByName('CODIGO').AsString;
    qryDestino.FieldByName('EUC_QTDB' + TStrUtils.fStrZero(intContador, 2)).AsFloat  := StrToFloat(ArquivoText[intQuantidade]) / (29.5735295625 / 48);

    strMd5 := strMd5 + qryDestino.FieldByName('EUC_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString;
    strMd5 := strMd5 + qryDestino.FieldByName('EUC_QTDB' + TStrUtils.fStrZero(intContador, 2)).AsString;

    Inc(intColorante);
    Inc(intQuantidade);
  End;

  qryDestino.FieldByName('EUC_MD5KEY').AsString := GetMD5(strMd5);
  qryDestino.Post;
end;

procedure TGravandoExecucaoEucatexImobiliariaCores.IsDeletarRegistros;
Var
  qryDelet: IDataSet;
begin
  qryDelet := TAutcomTintaFactory.Get.fGetDataSet;
  qryDelet.SQL := 'DELETE FROM EUC_CADEUC       ';
  qryDelet.ExecSQL;
end;

function TGravandoExecucaoEucatexImobiliariaCores.IsRegistroExistente(
  const qryDestino: IDataSet; ArquivoText: TStringList;
  intArquivo: Integer): Boolean;
begin
  Result := False;

  If ArquivoText[0] = 'id_seq' Then
    Exit(True);

//  Result := qryDestino.Locate('EUC_CODCOR;EUC_DESCOR;EUC_PRODUT;EUC_DESBAS;EUC_UNIDAD;EUC_COLECA', VarArrayOf([ArquivoText[1], ArquivoText[2],
//    ArquivoText[8], ArquivoText[4], fRetUnidade(StrToFloat(ArquivoText[6])), ArquivoText[10]]), []);
end;

procedure TGravandoExecucaoEucatexImobiliariaCores.ProcessClientDataSetColorantes(
  const Gravando: IGravando);
Var
  intContador: Integer;
  Arquivo: TextFile;
  ArquivoText: TStringList;
  strLinha: String;
  iRecordCount: Integer;
  intLinha: Integer;
begin
  Try
    Try
      For intContador := 0 To stlArquivos.Count - 1 Do
      Begin
        If Pos('ArquivoComplementar', stlArquivos[intContador]) <= 0 Then
          Continue;


        Gravando.Texto := 'Verificando arquivo de Colorantes...';

        If Not fValidarPath(intContador) Then
        Begin
          Gravando.Texto := Format('O arquivo [%s] não foi encontrado. Verifique as configurações da tinta', [AnsiReplaceStr(fGetPath(intContador), '"', '')]);
          Exit;
        End;

        cdColorantes := TUniClientDataSet.Create(Nil);

        cdColorantes.FieldDefs.AddFieldDef;
        cdColorantes.FieldDefs[0].DataType := ftString;
        cdColorantes.FieldDefs[0].Name := 'ID';
        cdColorantes.FieldDefs[0].Size := 4;

        cdColorantes.FieldDefs.AddFieldDef;
        cdColorantes.FieldDefs[1].DataType := ftString;
        cdColorantes.FieldDefs[1].Name := 'CODIGO';
        cdColorantes.FieldDefs[1].Size := 6;

        cdColorantes.CreateDataSet();

        Gravando.Texto := 'Processando arquivos de colorantes...';
        iRecordCount := fContaLinhas(fGetPath(intContador));
        intLinha := 1;
        ArquivoText := TStringList.Create();
        ArquivoText.StrictDelimiter := True;
        ArquivoText.Delimiter := ';';
        AssignFile(Arquivo, fGetPath(intContador));
        Reset(Arquivo);

        While Not Eof(Arquivo) Do
        Begin
          If (Gravando.Status <> sgGravando) Then
            Break;

          ReadLn(Arquivo, strLinha);
          ArquivoText.DelimitedText := strLinha;

          If ArquivoText[0] = 'id' Then
          Begin
            Inc(intLinha);
            Gravando.RegistrarProgresso(0, intLinha, iRecordCount);
            Continue;
          End;

          cdColorantes.Append;
          cdColorantes.FieldByName('ID').AsString := ArquivoText[0];
          cdColorantes.FieldByName('CODIGO').AsString := ArquivoText[1];
          cdColorantes.Post;

          Inc(intLinha);
          Gravando.RegistrarProgresso(0, intLinha, iRecordCount);
        End;

        If Assigned(ArquivoText) Then
          FreeAndNil(ArquivoText);
        CloseFile(Arquivo);
        Exit;
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

end.
