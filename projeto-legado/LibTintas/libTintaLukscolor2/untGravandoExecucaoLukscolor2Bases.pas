{*************************************************************************}
{* Classe responsável pela geração do cadastro de bases da tinta Lukscolor2 *}
{**********************************************************************PH*}
unit untGravandoExecucaoLukscolor2Bases;

interface

uses
  untAbstractGravandoExecucaoLukscolor2, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils;

type
  TGravandoExecucaoLukscolor2Bases = class(TAbstractGravandoExecucaoLukscolor2)
  Private
    function fRetUnidade(fltEmbalagem: Double): String;
  public
    function GetAdoQuery(var strNomeArquivo:String):TADOQuery; override;
    function GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): string; override;
    function GetSqlDestino(): string; override;
    function fGetPath(intContador: Integer): String; override;
    function IsRegistroExistente(const qryOrigem: TDataSet; const qryDestino: IDataSet): Boolean; override;
    procedure GravarRegistro(const qryOrigem: TDataSet; const qryDestino: IDataSet); override;
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;

  end;

implementation

uses untStrUtils, untIDefinicaoTxt, untGenericDefinicaoTxt, untDefinicaoTxtCharacterSet,
  untIDefinicaoTxtCampo, untGenericDefinicaoTxtCampo, untDefinicaoTxtCampoTipo, untADOTxtFactory;

{ TGravandoExecucaoLukscolor2Bases }

procedure TGravandoExecucaoLukscolor2Bases.Executar(const gravando: IGravando);
Var
  qryOrigem: TDataSet;
  qryDestino: IDataSet;
  intContador: Integer;
begin
  For intContador := 0 To stlPaths.Count - 1 Do
  Begin
    Try
      Try
        If (Gravando.Status <> sgGravando) Then
          Break;

        Gravando.Texto := 'Verificando Path...';

        If Not fValidaPath(intContador) Then
        Begin
          Gravando.Texto := Format('O arquivo %s não foi encontrado! Rever Configurações.', [AnsiReplaceStr(fGetPath(intContador), '"', '')]);
          Break;
        End;

        Gravando.Texto := 'Carregando Dados...';
        CarregarDados(Gravando, qryOrigem, fGetPath(intContador), qryDestino);

        Gravando.Texto := 'Verificando PROCOD...';
        TAutcomTintaFactory.Get.fInsereProCod('LKC_CADBAS');
        Gravando.Texto := 'PROCOD verificado com sucesso...';

        If (Gravando.Status <> sgGravando) Then
          Break;

        Gravando.Texto := Format('Processando Arquivo: [%s]', [AnsiReplaceStr(fGetPath(intContador), '"', '')]);
        Gravando.RegistrarProgresso(0, 0, 0);

        qryOrigem.First;

        While Not qryOrigem.Eof Do
        Begin
          If (Gravando.Status <> sgGravando) Then
            Break;

          Try
            Try

              If Not IsRegistroExistente(qryOrigem, qryDestino) Then
                GravarRegistro(qryOrigem, qryDestino);

            Except
              On E: Exception Do
                Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
            End;
          Finally
            qryOrigem.Next;
            Gravando.RegistrarProgresso(0, qryOrigem.RecNo, qryOrigem.RecordCount);
          End;
        End;
      Except
        On E: Exception Do
        Begin
          Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
        End;
      End;
    Finally
      If Assigned(qryOrigem) Then FreeAndNil(qryOrigem);
    End;
  End;
end;

function TGravandoExecucaoLukscolor2Bases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases';
end;



function TGravandoExecucaoLukscolor2Bases.fGetPath(
  intContador: Integer): String;
begin
  Result := Conf.fGet('PATLKC') + '\' + stlPaths[intContador];
  Result := Result + '.csv';
end;

function TGravandoExecucaoLukscolor2Bases.fRetUnidade(
  fltEmbalagem: Double): String;
begin
  Result := '';

  If (fltEmbalagem > 0) And (fltEmbalagem < 1500) Then
    Result := 'LT'
  Else If (fltEmbalagem > 1500) And (fltEmbalagem < 5000) Then
    Result := 'GL'
  Else If fltEmbalagem > 5000 Then
    Result := 'LA';
end;

function TGravandoExecucaoLukscolor2Bases.GetAdoQuery(
  var strNomeArquivo: String): TADOQuery;
Var
  Definicao: IDefinicaoTxt;
begin
  Definicao := TGenericDefinicaoTxt.Create(strNomeArquivo, True, ';',
  dtcsDefault, '.', '.',
  TArrayIDefinicaoTxtCampoFactory.GetArrayIDefinicaoTxtCampo([
  TGenericDefinicaoTxtCampo.Create('id_seq', dtctText),
  TGenericDefinicaoTxtCampo.Create('cor_id', dtctText),
  TGenericDefinicaoTxtCampo.Create('nome_cor', dtctText),
  TGenericDefinicaoTxtCampo.Create('id_base', dtctText),
  TGenericDefinicaoTxtCampo.Create('base', dtctText),
  TGenericDefinicaoTxtCampo.Create('id_embalagem', dtctText),
  TGenericDefinicaoTxtCampo.Create('embalagem', dtctDouble),
  TGenericDefinicaoTxtCampo.Create('cod_produto', dtctText),
  TGenericDefinicaoTxtCampo.Create('produto', dtctText),
  TGenericDefinicaoTxtCampo.Create('colecao', dtctText),
  TGenericDefinicaoTxtCampo.Create('sub_colecao', dtctText),
  TGenericDefinicaoTxtCampo.Create('corante1', dtctText),
  TGenericDefinicaoTxtCampo.Create('corante2', dtctText),
  TGenericDefinicaoTxtCampo.Create('corante3', dtctText),
  TGenericDefinicaoTxtCampo.Create('corante4', dtctText),
  TGenericDefinicaoTxtCampo.Create('corante5', dtctText),
  TGenericDefinicaoTxtCampo.Create('corante6', dtctText),
  TGenericDefinicaoTxtCampo.Create('Qtd1(ML)', dtctDouble),
  TGenericDefinicaoTxtCampo.Create('Qtd2(ML)', dtctDouble),
  TGenericDefinicaoTxtCampo.Create('Qtd3(ML)', dtctDouble),
  TGenericDefinicaoTxtCampo.Create('Qtd4(ML)', dtctDouble),
  TGenericDefinicaoTxtCampo.Create('Qtd5(ML)', dtctDouble),
  TGenericDefinicaoTxtCampo.Create('Qtd6(ML)', dtctDouble),
  TGenericDefinicaoTxtCampo.Create('Volume_Final(ML)', dtctDouble),
  TGenericDefinicaoTxtCampo.Create('preco_final', dtctCurrency),
  TGenericDefinicaoTxtCampo.Create('data_geracao', dtctDate)]));

  TADOTxtFactory.Registrar(Definicao);
  strNomeArquivo := Definicao.NomeArquivo;
  Result := TADOTxtFactory.GetTxt12Query(ExtractFileDir(strNomeArquivo));
end;

function TGravandoExecucaoLukscolor2Bases.GetSqlDestino: string;
begin
  Result := '   SELECT * FROM LKC_CADBAS    ';
end;

function TGravandoExecucaoLukscolor2Bases.GetSqlOrigem(
  const strNomeArquivo: string; const stlTabelas: TStrings): string;
begin
    Result := '';
  Result := Result + '  SELECT DISTINCT           ';
  Result := Result + '    base,                   ';
  Result := Result + '    embalagem,              ';
  Result := Result + '    produto                 ';
  Result := Result + '  FROM                      ';
  Result := Result +    strTabela + '#csv         ';
end;

procedure TGravandoExecucaoLukscolor2Bases.GravarRegistro(
  const qryOrigem: TDataSet; const qryDestino: IDataSet);
begin
  qryDestino.Insert;
  qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('LKC_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
  qryDestino.FieldByName('BAS_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
  qryDestino.FieldByName('BAS_CODBAS').AsString := LimpaTexto(qryOrigem.FieldByName('base').AsString);
  qryDestino.FieldByName('BAS_DESCRI').AsString := LimpaTexto(qryOrigem.FieldByName('base').AsString);
  qryDestino.FieldByName('BAS_UNIDAD').AsString := LimpaTexto(fRetUnidade(qryOrigem.FieldByName('embalagem').AsFloat));
  qryDestino.FieldByName('BAS_CONTEU').AsFloat := qryOrigem.FieldByName('embalagem').AsFloat;
  qryDestino.FieldByName('BAS_PRODUT').AsString := LimpaTexto(qryOrigem.FieldByName('produto').AsString);
  qryDestino.Post;
end;

function TGravandoExecucaoLukscolor2Bases.IsRegistroExistente(
  const qryOrigem: TDataSet; const qryDestino: IDataSet): Boolean;
begin
  Result := qryDestino.Locate('BAS_CODBAS;BAS_PRODUT;BAS_UNIDAD;BAS_CONTEU', VarArrayOf([
    LimpaTexto(qryOrigem.FieldByName('base').AsString), LimpaTexto(qryOrigem.FieldByName('produto').AsString),
    LimpaTexto(fRetUnidade(qryOrigem.FieldByName('embalagem').AsFloat)), qryOrigem.FieldByName('embalagem').AsFloat]),  []);
end;

end.
