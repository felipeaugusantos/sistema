{******************************************************************************}
{* Classe responsável pela geração do cadastro de Embalagem da tinta AdvanceTintoSystem *}
{***************************************************************************PH*}
unit untGravandoExecucaoAdvanceTintoSystemEmbalagem;

interface

uses
  untAbstractGravandoExecucaoAdvanceTintoSystem, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils;
type
  TGravandoExecucaoAdvanceTintoSystemEmbalagem = class(TAbstractGravandoExecucaoAdvanceTintoSystem)
  private
    function fRetUnidadeEmbalagem(strDescri:String):String;
  public
    function fGetNomeGravacao: string; override;
    function GetAdoQuery(var strNomeArquivo:String):TADOQuery; override;
    function GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): string; override;
    function GetSqlDestino(): string; override;
    function IsRegistroExistente(const qryOrigem: TDataSet; const qryDestino: IDataSet): Boolean; override;
    procedure GravarRegistro(const qryOrigem: TDataSet; const qryDestino: IDataSet); override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

uses untStrUtils, untDefinicaoTxtCampoTipo, untADOTxtFactory, untGenericDefinicaoTxtCampo, untGenericDefinicaoTxt,
    untIDefinicaoTxtCampo, untIDefinicaoTxt, untDefinicaoTxtCharacterSet;
{ TGravandoExecucaoAdvanceTintoSystemCores }

procedure TGravandoExecucaoAdvanceTintoSystemEmbalagem.Executar(const gravando: IGravando);
Var
  qryOrigem : TDataSet;
  qryDestino: IDataSet;
begin
  Try
    Try
      Gravando.Texto := 'Verificando Path do arquivo...';

      If Not fValidaPath Then
      Begin
        Gravando.Texto := Format('O path [%s] não está configurado, ou não existe!', [AnsiReplaceStr(GetPath, '"', '')]);
        Exit;
      End;

      If (Gravando.Status <> sgGravando) Then
        Exit;

      Gravando.Texto := 'Path verificado com sucesso...';

      Gravando.Texto := 'Carregando dados do Cadastro de Embalagem...';

      CarregarDados(Gravando, qryOrigem, GetPath, qryDestino);

      If (Gravando.Status <> sgGravando) Then
        Exit;

      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('ADT_CADEMB');
      Gravando.Texto := 'PROCOD verificado com sucesso...';

      Gravando.Texto := 'Dados carregados com sucesso...';

      Gravando.Texto := Format('Processando Arquivo: [%s]', [AnsiReplaceStr(GetPath, '"', '')]);
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
        Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
    End;
  Finally
    Gravando.Texto := Format('Cadastro de %s processado com sucesso!', ['Embalagem']);
  End;
end;

function TGravandoExecucaoAdvanceTintoSystemEmbalagem.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Embalagem';
end;


function TGravandoExecucaoAdvanceTintoSystemEmbalagem.fRetUnidadeEmbalagem(
  strDescri: String): String;
begin
  Result := '';
  If (strDescri = 'QUARTO') Or (strDescri = 'KIT2QUARTOS') Then
    Result := 'QT'
  Else If (strDescri = 'GALAO') Or (strDescri = 'KIT2GALOES') Then
    Result := 'GL'
  Else If (strDescri = 'BALDE18') Or (strDescri = 'BALDE20') Then
    Result := 'LA';
end;

function TGravandoExecucaoAdvanceTintoSystemEmbalagem.GetAdoQuery(
  var strNomeArquivo: String): TADOQuery;
Var
  Definicao: IDefinicaoTxt;
begin
  Definicao := TGenericDefinicaoTxt.Create(strNomeArquivo, True, ';', dtcsDefault, '.', '.',
    TArrayIDefinicaoTxtCampoFactory.GetArrayIDefinicaoTxtCampo([
    TGenericDefinicaoTxtCampo.Create('IdProdBas', dtctText),
    TGenericDefinicaoTxtCampo.Create('Embalagem', dtctText),
    TGenericDefinicaoTxtCampo.Create('Conteudo', dtctDouble),
    TGenericDefinicaoTxtCampo.Create('IdEmb', dtctText),
    TGenericDefinicaoTxtCampo.Create('Produto', dtctText),
    TGenericDefinicaoTxtCampo.Create('IdProduto', dtctText),
    TGenericDefinicaoTxtCampo.Create('Base', dtctText),
    TGenericDefinicaoTxtCampo.Create('Cod Base', dtctText),
    TGenericDefinicaoTxtCampo.Create('Id_Base', dtctText),
    TGenericDefinicaoTxtCampo.Create('Peso Especif', dtctDouble),
    TGenericDefinicaoTxtCampo.Create('Código Barra', dtctText),
    TGenericDefinicaoTxtCampo.Create('Data', dtctDate)]));

  TADOTxtFactory.Registrar(Definicao);
  strNomeArquivo := Definicao.NomeArquivo;
  Result := TADOTxtFactory.GetTxt12Query(ExtractFileDir(strNomeArquivo));
end;

function TGravandoExecucaoAdvanceTintoSystemEmbalagem.GetSqlDestino: string;
begin
  Result := '   SELECT * FROM ADT_CADEMB    ';
end;

function TGravandoExecucaoAdvanceTintoSystemEmbalagem.GetSqlOrigem(
  const strNomeArquivo: string; const stlTabelas: TStrings): string;
begin
  Result := '   SELECT DISTINCT           ' +
            '     IDEMB,                  ' +
            '     EMBALAGEM               ' +
            '   FROM                      ' +
            '     Bases#csv               ' ;
end;

procedure TGravandoExecucaoAdvanceTintoSystemEmbalagem.GravarRegistro(
  const qryOrigem: TDataSet; const qryDestino: IDataSet);
begin
  qryDestino.Insert;
  qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('ADT_CADEMB', TAutcomTintaFactory.Get.GetCodEmp);
  qryDestino.FieldByName('EMB_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
  qryDestino.FieldByName('EMB_CODEMB').AsString := TStrUtils.fStrZero(LimpaTexto(qryOrigem.FieldByName('IDEMB').AsString), 3);
  qryDestino.FieldByName('EMB_DESCRI').AsString := LimpaTexto(qryOrigem.FieldByName('EMBALAGEM').AsString);
  qryDestino.FieldByName('EMB_CODUNI').AsString := fRetUnidadeEmbalagem(qryDestino.FieldByName('EMB_DESCRI').AsString);
  qryDestino.Post;
end;

function TGravandoExecucaoAdvanceTintoSystemEmbalagem.IsRegistroExistente(
  const qryOrigem: TDataSet; const qryDestino: IDataSet): Boolean;
begin
  Result := qryDestino.Locate('EMB_CODEMB', VarArrayOf([TStrUtils.fStrZero(LimpaTexto(qryOrigem.FieldByName('IDEMB').AsString), 3)]), []);
end;

end.

