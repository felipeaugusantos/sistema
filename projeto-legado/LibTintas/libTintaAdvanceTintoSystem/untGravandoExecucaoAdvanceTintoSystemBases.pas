{ ********************************************************************************** }
{ * Classe responsável pela geração do cadastro de bases da tinta AdvanceTintoSystem * }
{ *******************************************************************************AC* }
unit untGravandoExecucaoAdvanceTintoSystemBases;

interface

uses
  untAbstractGravandoExecucaoAdvanceTintoSystem, untIGravando, SysUtils,
  untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes,
  StrUtils;

type
  TGravandoExecucaoAdvanceTintoSystemBases = class
    (TAbstractGravandoExecucaoAdvanceTintoSystem)
  public
    function fGetNomeGravacao: string; override;
    function GetAdoQuery(var strNomeArquivo: String): TADOQuery; override;
    function GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): string; override;
    function GetSqlDestino(): string; override;
    function IsRegistroExistente(const qryOrigem: TDataSet; const qryDestino: IDataSet): Boolean; override;
    procedure GravarRegistro(const qryOrigem: TDataSet; const qryDestino: IDataSet); override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

uses untStrUtils, untIDefinicaoTxt, untGenericDefinicaoTxt,
  untDefinicaoTxtCharacterSet, untIDefinicaoTxtCampo,
  untGenericDefinicaoTxtCampo,
  untDefinicaoTxtCampoTipo, untADOTxtFactory;

{ TGravandoExecucaoAdvanceTintoSystemBases }

procedure TGravandoExecucaoAdvanceTintoSystemBases.Executar(const gravando
  : IGravando);
Var
  qryOrigem: TDataSet;
  qryDestino: IDataSet;
begin
  Try
    Try
      Gravando.Texto := 'Verificando path do arquivo...';

      If Not fValidaPath Then
      Begin
        Gravando.Texto := Format('O Path [%s] não está configurado, ou não existe!', [AnsiReplaceStr(GetPath, '"', '')]);
        Exit;
      End;

      If (Gravando.Status <> sgGravando) Then
        Exit;

      Gravando.Texto := 'Path verificado com sucesso...';

      Gravando.Texto := 'Carregando dados do Cadastro de Bases...';

      CarregarDados(Gravando, qryOrigem, GetPath, qryDestino);

      If Gravando.Status <> sgGravando Then
        Exit;

      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('ADT_CADBAS');
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
            Begin
              Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
            End;

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
    Gravando.Texto := 'Cadastro de Bases processado com sucesso!';
  End;
end;


function TGravandoExecucaoAdvanceTintoSystemBases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases';
end;

function TGravandoExecucaoAdvanceTintoSystemBases.GetAdoQuery(var strNomeArquivo
  : String): TADOQuery;
Var
  Definicao: IDefinicaoTxt;
begin

  Definicao := TGenericDefinicaoTxt.Create(ExtractFilePath(strNomeArquivo), True, ';',
    dtcsDefault, '.', '.',
    TArrayIDefinicaoTxtCampoFactory.GetArrayIDefinicaoTxtCampo
    ([TGenericDefinicaoTxtCampo.Create('IdProdBas', dtctText),
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


function TGravandoExecucaoAdvanceTintoSystemBases.GetSqlDestino: string;
begin
  Result := '   SELECT * FROM ADT_CADBAS    ';
end;

function TGravandoExecucaoAdvanceTintoSystemBases.GetSqlOrigem(
  const strNomeArquivo: string; const stlTabelas: TStrings): string;
begin
  Result := '   SELECT * FROM Bases#csv   ';
end;

procedure TGravandoExecucaoAdvanceTintoSystemBases.GravarRegistro(
  const qryOrigem:TDataSet; const qryDestino: IDataSet);
begin
  qryDestino.Insert;
  qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('ADT_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
  qryDestino.FieldByName('BAS_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
  qryDestino.FieldByName('BAS_CODBAS').AsString := LimpaTexto(qryOrigem.FieldByName('Cod Base').AsString);
  qryDestino.FieldByName('BAS_CODEMB').AsString := TStrUtils.fStrZero(LimpaTexto(qryOrigem.FieldByName('IdEmb').AsString), 3);
  qryDestino.FieldByName('BAS_PRODUT').AsString := LimpaTexto(qryOrigem.FieldByName('Produto').AsString);
  qryDestino.FieldByName('BAS_DESCRI').AsString := LimpaTexto(qryOrigem.FieldByName('Base').AsString);
  qryDestino.FieldByName('BAS_PESESP').AsFloat  := qryOrigem.FieldByName('Peso Especif').AsFloat;
  qryDestino.FieldByName('BAS_CONTEU').AsFloat  := qryOrigem.FieldByName('Conteudo').AsFloat;
  qryDestino.Post;
end;

function TGravandoExecucaoAdvanceTintoSystemBases.IsRegistroExistente(
  const qryOrigem:TDataSet; const qryDestino: IDataSet): Boolean;
begin
  Result := qryDestino.Locate('BAS_CODBAS;BAS_PRODUT;BAS_CODEMB;BAS_CONTEU', VarArrayOf([
    LimpaTexto(qryOrigem.FieldByName('Cod Base').AsString),
    LimpaTexto(qryOrigem.FieldByName('Produto').AsString),
    TStrUtils.fStrZero(qryOrigem.FieldByName('IdEmb').AsString, 3),
    qryOrigem.FieldByName('Conteudo').AsFloat]), []) Or fGetCatalisadores.Locate('CODCATALIS', VarArrayOf([qryOrigem.FieldByName('Cod Base').AsString]), []);
end;

end.
