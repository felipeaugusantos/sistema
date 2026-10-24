{******************************************************************************************}
{* Classe responsável pela geração do cadastro de colorantes da tinta Eucatex Imobiliaria *}
{***************************************************************************************PH*}
unit untGravandoExecucaoEucatexImobiliariaColorantes;

interface

uses
  untAbstractGravandoExecucaoEucatexImobiliaria, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, untStatusGravando, DB, Classes, StrUtils, Variants;

type
  TGravandoExecucaoEucatexImobiliariaColorantes = class(TAbstractGravandoExecucaoEucatexImobiliaria)
  Protected
    function IsRegistroExistente(const qryDestino: IDataSet; ArquivoText: TStringList; intArquivo: Integer): Boolean; Override;
    procedure GravarRegistro(const qryDestino: IDataSet; ArquivoText: TStringList;  intArquivo: Integer); Override;
    function GetSqlDestino(): string; Override;
    procedure IsDeletarRegistros(); Override;
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

uses untStrUtils;

{ TGravandoExecucaoEucatexImobiliariaCores }

procedure TGravandoExecucaoEucatexImobiliariaColorantes.Executar(const gravando: IGravando);
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
        If Pos('ArquivoComplementar', stlArquivos[intArquivo]) <= 0 Then
          Continue;

        Gravando.Texto := 'Verificando Path do Arquivo...';

        If Not fValidarPath(intArquivo) Then
        Begin
          Gravando.Texto := Format('O arquivo [%s] não foi encontrado. Verifique as configurações da tinta', [AnsiReplaceStr(fGetPath(intArquivo), '"', '')]);
          Exit;
        End;

        If blnExcluir Then
        Begin
          Gravando.Texto := 'Deletando registros da tabela EUC_CADCOL...';
          IsDeletarRegistros;
          blnExcluir := False;
        End;

        If (Gravando.Status <> sgGravando) Then
          Break;

        Gravando.Texto := 'Verificando PROCOD...';
        TAutcomTintaFactory.Get.fInsereProCod('EUC_CADCOL');
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

function TGravandoExecucaoEucatexImobiliariaColorantes.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Colorantes';
end;

function TGravandoExecucaoEucatexImobiliariaColorantes.GetSqlDestino: string;
begin
  Result := ' SELECT * FROM EUC_CADCOL  ';
end;

procedure TGravandoExecucaoEucatexImobiliariaColorantes.GravarRegistro(
  const qryDestino: IDataSet; ArquivoText: TStringList; intArquivo: Integer);
begin
  qryDestino.Insert;
  qryDestino.FieldByName('AUTOINCREM').AsString  := TAutcomTintaFactory.Get.fRetAutoIncrem('EUC_CADCOL', TAutcomTintaFactory.Get.GetCodEmp);
  qryDestino.FieldByName('COL_CODEMP').AsString  := TAutcomTintaFactory.Get.GetCodEmp;
  qryDestino.FieldByName('COL_CODCOL').AsString  := ArquivoText[1];
  qryDestino.FieldByName('COL_EMBALA').AsFloat   := StrToFloat(ArquivoText[3]);
  qryDestino.Post;
end;

procedure TGravandoExecucaoEucatexImobiliariaColorantes.IsDeletarRegistros;
Var
  qryDelet: IDataSet;
begin
  qryDelet := TAutcomTintaFactory.Get.fGetDataSet;
  qryDelet.SQL := 'DELETE FROM EUC_CADCOL       ';
  qryDelet.ExecSQL;
end;

function TGravandoExecucaoEucatexImobiliariaColorantes.IsRegistroExistente(
  const qryDestino: IDataSet; ArquivoText: TStringList;
  intArquivo: Integer): Boolean;
begin
  Result := False;

  If ArquivoText[0] = 'id' Then
    Exit(True);
end;

end.

