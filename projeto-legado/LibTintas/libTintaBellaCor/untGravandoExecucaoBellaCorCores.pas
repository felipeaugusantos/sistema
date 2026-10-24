{*************************************************************************}
{* Classe responsável pela geração do cadastro de cores da tinta BellaCor *}
{**********************************************************************PH*}
unit untGravandoExecucaoBellaCorCores;

interface

uses
  untAbstractGravandoExecucaoBellaCor, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, untStrUtils, untStatusGravando, DB, StrUtils, ComObj,
  untLibTintaFactory, System.Classes, UniClientDataSet, Uni;

type
  TGravandoExecucaoBellaCorCores = class(TAbstractGravandoExecucaoBellaCor)
  Private
    cdsCadCol: TUniClientDataSet;
    procedure PreencheDtaSetColorantes(const Gravando: IGravando);
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

Implementation

uses
  untFuncoesGenerica;

{ TGravandoExecucaoBellaCorCores }


procedure TGravandoExecucaoBellaCorCores.Executar(const gravando: IGravando);
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

          Gravando.Texto := 'Path verificado com sucesso...';

          If (Gravando.Status <> sgGravando) Then
            Break;

          If (blnExcluir) Then
          Begin
            Gravando.Texto := 'Deletando Registros da tabela BEL_CADBEL...';
            IsDeletarRegistros();
            blnExcluir := False;
            PreencheDtaSetColorantes(Gravando);
          End;

          Gravando.Texto := 'Verificando PROCOD...';
          TAutcomTintaFactory.Get.fInsereProCod('BEL_CADBEL');
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
  Finally
    If Assigned(cdsCadCol) Then
      FreeAndNil(cdsCadCol);
  End;
end;


function TGravandoExecucaoBellaCorCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;

function TGravandoExecucaoBellaCorCores.fRetUnidade(
  fltEmbalagem: Double): String;
begin
  If fltEmbalagem < 1000 Then
    Result := 'LT'
  Else If fltEmbalagem < 7000 Then
    Result := 'GL'
  Else
    Result := 'LA';
end;

function TGravandoExecucaoBellaCorCores.GetSqlDestino: string;
begin
  Result := ' SELECT * FROM BEL_CADBEL  ';
end;

procedure TGravandoExecucaoBellaCorCores.GravarRegistro(
  const qryDestino: IDataSet; ArquivoText: TStringList; intArquivo: Integer);
Var
  intColorante,
  intQuantidade,
  intContador: Integer;
begin
  qryDestino.Insert;
  qryDestino.FieldByName('AUTOINCREM').AsString  := TAutcomTintaFactory.Get.fRetAutoIncrem('BEL_CADBEL', TAutcomTintaFactory.Get.GetCodEmp);
  qryDestino.FieldByName('BEL_CODEMP').AsString  := TAutcomTintaFactory.Get.GetCodEmp;
  qryDestino.FieldByName('BEL_DTACAD').AsDate    := Date;
  qryDestino.FieldByName('BEL_COLECA').AsString  := LimpaTexto(ArquivoText[10]);
  qryDestino.FieldByName('BEL_PRODUT').AsString  := LimpaTexto(ArquivoText[8]);
  qryDestino.FieldByName('BEL_CODBAS').AsString  := LimpaTexto(ArquivoText[4]);
  qryDestino.FieldByName('BEL_DESCRI').AsString  := LimpaTexto(ArquivoText[1]);
  qryDestino.FieldByName('BEL_NOMCOR').AsString  := LimpaTexto(ArquivoText[1]);
  qryDestino.FieldByName('BEL_CODUNI').AsString  := fRetUnidade(StrToFloat(ArquivoText[6]));

  intColorante := 11;
  intQuantidade := 17;

  For intContador := 1 To 6 Do
  Begin
    If TStrUtils.fEmptyStr(ArquivoText[intColorante]) Then
      Break;

    If Not cdsCadCol.Locate('ID', ArquivoText[intColorante], []) Then
      Break;

    qryDestino.FieldByName('BEL_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString := cdsCadCol.FieldByName('COD').AsString;
    qryDestino.FieldByName('BEL_QTDB' + TStrUtils.fStrZero(intContador, 2)).AsFloat  := StrToFloat(AnsiReplaceStr(ArquivoText[intQuantidade], '.', ','));

    Inc(intQuantidade, 1);
    Inc(intColorante, 1);
  End;

  qryDestino.FieldByName('BEL_MD5KEY').AsString  := GetMD5(qryDestino.FieldByName('BEL_COLECA').AsString +
                                                           qryDestino.FieldByName('BEL_PRODUT').AsString +
                                                           qryDestino.FieldByName('BEL_DESCRI').AsString +
                                                           qryDestino.FieldByName('BEL_NOMCOR').AsString +
                                                           qryDestino.FieldByName('BEL_CODUNI').AsString +
                                                           qryDestino.FieldByName('BEL_CODBAS').AsString +
                                                           qryDestino.FieldByName('BEL_CODEMP').AsString);

  qryDestino.Post;
end;

procedure TGravandoExecucaoBellaCorCores.IsDeletarRegistros;
Var
  qryDelet: IDataSet;
begin
  qryDelet := TAutcomTintaFactory.Get.fGetDataSet;
  qryDelet.SQL := 'DELETE FROM BEL_CADBEL        ';
  qryDelet.ExecSQL;
end;

function TGravandoExecucaoBellaCorCores.IsRegistroExistente(
  const qryDestino: IDataSet; ArquivoText: TStringList;
  intArquivo: Integer): Boolean;
begin
  If ArquivoText[0] = 'id_seq' Then
  Begin
    Result := True;
    Exit;
  End;

  Result := False;
end;

procedure TGravandoExecucaoBellaCorCores.PreencheDtaSetColorantes(const Gravando: IGravando);
Var
  Arquivo: TextFile;
  ArquivoText: TStringList;
  strLinha: RawByteString;
  iRecordCount: Integer;
  intLinha: Integer;
begin
  Gravando.Texto := 'Processando Tabelas de Colorantes...';

  cdsCadCol := TUniClientDataSet.Create(Nil);

  cdsCadCol.FieldDefs.AddFieldDef;
  cdsCadCol.FieldDefs[0].DataType := ftString;
  cdsCadCol.FieldDefs[0].Name := 'ID';
  cdsCadCol.FieldDefs[0].Size := 2;

  cdsCadCol.FieldDefs.AddFieldDef;
  cdsCadCol.FieldDefs[1].DataType := ftString;
  cdsCadCol.FieldDefs[1].Name := 'COD';
  cdsCadCol.FieldDefs[1].Size := 10;

  cdsCadCol.CreateDataSet;

  iRecordCount := fContaLinhas(Conf.fGet('PATBEL') + '\ArquivoComplementar.CSV');
  intLinha := 1;
  ArquivoText := TStringList.Create();
  ArquivoText.StrictDelimiter := True;
  ArquivoText.Delimiter := ';';

  AssignFile(Arquivo, Conf.fGet('PATBEL') + '\ArquivoComplementar.CSV');
  Reset(Arquivo);

  Try
    While Not Eof(Arquivo) Do
    Begin
     If (Gravando.Status <> sgGravando) Then
       Break;

     ReadLn(Arquivo, strLinha);
     ArquivoText.DelimitedText := UTF8ToWideString(strLinha);


     If ArquivoText[0] <> 'id' Then
     Begin
       cdsCadCol.Append;
       cdsCadCol.FieldByName('ID').AsString := ArquivoText[0];
       cdsCadCol.FieldByName('COD').AsString := ArquivoText[1];
       cdsCadCol.Post;
     End;

     Inc(intLinha);
     Gravando.RegistrarProgresso(0, intLinha, iRecordCount);
    End;
  Finally
    If Assigned(ArquivoText) Then
      FreeAndNil(ArquivoText);
    CloseFile(Arquivo);
  End;
end;

end.
