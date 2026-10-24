{*************************************************************************}
{* Classe responsável pela geração do cadastro de bases da tinta ProfissionalAutomotiva *}
{**********************************************************************PH*}
unit untGravandoExecucaoProfissionalAutomotivaBases;

interface

uses
  untAbstractGravandoExecucaoProfissionalAutomotiva, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils,
  UniClientDataSet, Vcl.Graphics, ComObj;

type
  TGravandoExecucaoProfissionalAutomotivaBases = class(TAbstractGravandoExecucaoProfissionalAutomotiva)
  Private
    procedure LimparTabelas;
    function fQtdEmbalagemMl(strEmbalagem: String): String;
    function IsRegistroExistenteCatalisador(const qryDestino: IDataSet): Boolean;
  public
    function GetAdoQuery(var strNomeArquivo:String):TADOQuery; override;
    function GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): string; override;
    function GetSqlDestino(): string; override;
    function fGetPath(intPasta: Integer): String; override;
    function IsRegistroExistente(const qryDestino: IDataSet; ArquivoText: TStringList): Boolean; Override;
    procedure GravarRegistro(const qryDestino: IDataSet; ArquivoText: TStringList; AContador: Integer); Reintroduce;
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

uses untStrUtils, untIDefinicaoTxt, untGenericDefinicaoTxt, untDefinicaoTxtCharacterSet,
  untIDefinicaoTxtCampo, untGenericDefinicaoTxtCampo, untDefinicaoTxtCampoTipo, untADOTxtFactory;

{ TGravandoExecucaoProfissionalAutomotivaBases }

procedure TGravandoExecucaoProfissionalAutomotivaBases.Executar(const gravando: IGravando);
Var
  qryDestino: IDataSet;
  Arquivo: TextFile;
  stlCsv: TStringList;
  strLinha: RawByteString;
  iRecordCount: Integer;
  intLinha: Integer;
  blnExcluir: Boolean;
  intContador: Integer;
begin
  Try
    Try
      blnExcluir := True;

      For intContador := 0 To FPastas.Count - 1 Do
      Begin
        ListarArquivo(Conf.fGet('PATPFA') + '\' + FPastas[intContador]);

        Gravando.Texto := 'Verificando Path do arquivo...';

        If Not fValidarPath(intContador) Then
        Begin
          Gravando.Texto := Format('O arquivo [%s] não foi encontrado! Verifique as Configurações.', [AnsiReplaceStr(fGetPath(intContador), '"', '')]);
          Exit;
        End;

        If (Gravando.Status <> sgGravando) Then
          Exit;

        If (blnExcluir) Then
        Begin
          Gravando.Texto := 'Deletando Registros da tabela PFA_CADBAS...';
          LimparTabelas;
          blnExcluir := False;
        End;

        pCarregarBases(Gravando, intContador);

        Gravando.Texto := 'Path verificado com sucesso...';
        Gravando.Texto := 'Verificando PROCOD...';
        TAutcomTintaFactory.Get.fInsereProCod('PFA_CADBAS');
        Gravando.Texto := 'PROCOD verificado com sucesso...';

        Gravando.Texto := 'Carregando Dados...';
        iRecordCount := fContaLinhas(fGetPath(intContador));
        intLinha := 1;
        qryDestino := GetDataSetDestino;
        stlCsv := TStringList.Create();
        stlCsv.StrictDelimiter := True;
        stlCsv.Delimiter := ';';

        AssignFile(Arquivo, fGetPath(intContador));
        Reset(Arquivo);

        If (Gravando.Status <> sgGravando) Then
          Exit;

        Gravando.Texto := Format('Processando Arquivo: [%s]', [AnsiReplaceStr(fGetPath(intContador), '"', '')]);
        Gravando.RegistrarProgresso(0, 0, 0);

        cdsBases.Filtered := False;
        cdsBases.Filter := 'TIPO = ' + QuotedStr('CATALISADOR');
        cdsBases.Filtered := True;
        cdsBases.First;

        While Not cdsBases.Eof Do
        Begin
           If Not IsRegistroExistenteCatalisador(qryDestino) Then
             GravarRegistro(qryDestino, Nil, intContador);

          Gravando.RegistrarProgresso(0, cdsBases.RecNo, cdsBases.RecordCount);
          cdsBases.Next;
        End;

        cdsBases.Filtered := False;
        cdsBases.First;

        While Not Eof(Arquivo) Do
        Begin
          If (Gravando.Status <> sgGravando) Then
            Break;

          ReadLn(Arquivo, strLinha);
          stlCsv.DelimitedText := UTF8ToWideString(strLinha);

          If Not cdsBases.Locate('TIPO;COD_PRODUTO', VarArrayOf([stlCsv[8], stlCsv[9]]), []) Then
          Begin
            Inc(intLinha);
            Gravando.RegistrarProgresso(0, intLinha, iRecordCount);
            Continue;
          End;

          If Not IsRegistroExistente(qryDestino, stlCsv) Then
            GravarRegistro(qryDestino, stlCsv, intContador);

          Inc(intLinha);
          Gravando.RegistrarProgresso(0, intLinha, iRecordCount);
        End;

        If Assigned(stlCsv) Then FreeAndNil(stlCsv);
        CloseFile(Arquivo);
      End;
    Except
      On E: Exception Do
        Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
    End;
  Finally
  End;
end;

function TGravandoExecucaoProfissionalAutomotivaBases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases';
end;


function TGravandoExecucaoProfissionalAutomotivaBases.fGetPath(intPasta: Integer): String;
begin
  Result := Conf.fGet('PATPFA') + '\' + FPastas[intPasta] +  '\' + FNomeArqFormulas;
end;

function TGravandoExecucaoProfissionalAutomotivaBases.fQtdEmbalagemMl(
  strEmbalagem: String): String;
begin
  Result := Trim(strEmbalagem) + ' ML';
end;

function TGravandoExecucaoProfissionalAutomotivaBases.GetAdoQuery(
  var strNomeArquivo: String): TADOQuery;
begin
  Result := Nil;
end;

function TGravandoExecucaoProfissionalAutomotivaBases.GetSqlDestino: string;
begin
  Result := ' SELECT * FROM PFA_CADBAS  ';
end;

function TGravandoExecucaoProfissionalAutomotivaBases.GetSqlOrigem(
  const strNomeArquivo: string; const stlTabelas: TStrings): string;
begin
  Result := '';
end;

procedure TGravandoExecucaoProfissionalAutomotivaBases.GravarRegistro(const qryDestino: IDataSet; ArquivoText: TStringList; AContador: Integer);
begin
  qryDestino.Insert;
  qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('PFA_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
  qryDestino.FieldByName('BAS_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
  qryDestino.FieldByName('BAS_CODBAS').AsString := cdsBases.FieldByName('BASE').AsString;
  qryDestino.FieldByName('BAS_DESCRI').AsString := cdsBases.FieldByName('DESCRICAO').AsString;
  qryDestino.FieldByName('BAS_CODBAR').AsString := cdsBases.FieldByName('COD_BARRA').AsString;
  qryDestino.FieldByName('BAS_SKUFAB').AsString := cdsBases.FieldByName('SKU_FAB').AsString;
  qryDestino.FieldByName('BAS_EMBALA').AsFloat  := cdsBases.FieldByName('EMBALA').AsFloat;
  qryDestino.FieldByName('BAS_PESESP').AsFloat  := cdsBases.FieldByName('PESESP').AsFloat;
  qryDestino.FieldByName('BAS_QTDEMB').AsString := AnsiReplaceStr(fQtdEmbalagemMl(FloatToStrF(qryDestino.FieldByName('BAS_EMBALA').AsFloat, ffNumber, 12, 0)), '.', '');
  qryDestino.Post;
end;

function TGravandoExecucaoProfissionalAutomotivaBases.IsRegistroExistente(const qryDestino: IDataSet; ArquivoText: TStringList): Boolean;
begin
  If ArquivoText[0] = 'LINHA' Then
  Begin
    Result := True;
    Exit;
  End;

  Result := qryDestino.Locate('BAS_CODBAS', cdsBases.FieldByName('BASE').AsString, []);
end;

function TGravandoExecucaoProfissionalAutomotivaBases.IsRegistroExistenteCatalisador(
  const qryDestino: IDataSet): Boolean;
begin
  Result := qryDestino.Locate('BAS_CODBAS', cdsBases.FieldByName('BASE').AsString, []);
end;

procedure TGravandoExecucaoProfissionalAutomotivaBases.LimparTabelas;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'DELETE FROM PFA_CADBAS';
  qryGen.ExecSQL;
end;

end.


