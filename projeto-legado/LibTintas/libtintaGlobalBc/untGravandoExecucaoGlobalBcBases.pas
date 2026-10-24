{**********************************************************************************}
{* Classe responsável pela geração do cadastro de bases da tinta GlobalBc *}
{*******************************************************************************AC*}
unit untGravandoExecucaoGlobalBcBases;

interface

uses
  untAbstractGravandoExecucaoGlobalBc, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils;
type
  TGravandoExecucaoGlobalBcBases = class(TAbstractGravandoExecucaoGlobalBc)
  Private
    procedure ProcessaBases(qryOrigem: TDataSet; qryDestino: IDataSet; const gravando: IGravando);
    function fRetUnidade(fltVolume: Double): String;
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
    function GetSqlDestino(): string; override;
    function GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): string; override;
    procedure GravarRegistro(const qryOrigem: TDataSet; qryDestino: IDataSet); Override;
    function IsRegistroExiste(const qryOrigem: TDataSet; qryDestino: IDataSet): Boolean; Override;
  end;

implementation

uses untStrUtils, untIDefinicaoTxt, untGenericDefinicaoTxt, untDefinicaoTxtCharacterSet,
  untIDefinicaoTxtCampo, untGenericDefinicaoTxtCampo, untDefinicaoTxtCampoTipo, untADOTxtFactory;

{ TGravandoExecucaoGlobalBcBases }

procedure TGravandoExecucaoGlobalBcBases.Executar(const gravando: IGravando);
Var
  qryOrigem: TDataSet;
  qryDestino: IDataSet;
  intContador: Integer;
  intArquivo: Integer;
begin
  For intContador := 0 To stlPastas.Count - 1 Do
  Begin
    Try
      Try
        ListarArquivo(Conf.fGet('PATGBC') + '\' + stlPastas[intContador]);

        For intArquivo := 0 To stlArquivos.Count - 1 Do
        Begin
          Gravando.Texto := 'Verificando Path do arquivo...';

          If Not fValidarPath(intArquivo, intContador) Then
          Begin
            Gravando.Texto := Format('O arquivo [%s] não foi encontrado! Verifique as Configurações.', [AnsiReplaceStr(fGetPath(intArquivo, intContador), '"', '')]);
            Exit;
          End;

          If (Gravando.Status <> sgGravando) Then
            Exit;

          Gravando.Texto := 'Path verificado com sucesso...';
          Gravando.Texto := 'Verificando PROCOD...';
          TAutcomTintaFactory.Get.fInsereProCod('GBC_CADBAS');
          Gravando.Texto := 'PROCOD verificado com sucesso...';

          If (Gravando.Status <> sgGravando) Then
            Exit;

          Gravando.Texto := 'Carregando Dados...';
          CarregarDados(Gravando, qryOrigem, fGetPath(intArquivo, intContador), qryDestino);

          Gravando.Texto := Format('Processando Arquivos: [%s]', [AnsiReplaceStr(fGetPath(intArquivo, intContador), '"', '')]);
          Gravando.RegistrarProgresso(0, 0, 0);
          qryOrigem.First;

          ProcessaBases(qryOrigem, qryDestino, Gravando);
          If Assigned(qryOrigem) Then
            FreeAndNil(qryOrigem);
        End;
      Except
        On E: Exception Do
          Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      End;
    Finally
    End;
  End;
end;

function TGravandoExecucaoGlobalBcBases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases';
end;


function TGravandoExecucaoGlobalBcBases.fRetUnidade(fltVolume: Double): String;
begin
  If fltVolume <= 1.000 Then
    Result := 'LT'
  Else If (fltVolume <= 7.000) Then
    Result := 'GL'
  Else
    Result := 'LA';
end;

function TGravandoExecucaoGlobalBcBases.GetSqlDestino: string;
begin
  Result := ' SELECT * FROM GBC_CADBAS      ';
end;

function TGravandoExecucaoGlobalBcBases.GetSqlOrigem(
  const strNomeArquivo: string; const stlTabelas: TStrings): string;
begin
  Result := '';
  Result := Result + '  SELECT DISTINCT                ';
  Result := Result + '    [B.Desc_Base] AS BASE,       ';
  Result := Result + '    [B.Volume] AS VOLUME,        ';
  Result := Result + '    [B.Colecao] AS COLECAO,      ';
  Result := Result + '    [B.Produto] AS PRODUTO       ';
  Result := Result + '  FROM                           ';
  Result := Result + '    [Sheet1$] AS B               ';
  Result := Result + '  WHERE                          ';
  Result := Result + '    B.Produto <> ""              ';
end;

procedure TGravandoExecucaoGlobalBcBases.GravarRegistro(
  const qryOrigem: TDataSet; qryDestino: IDataSet);
begin
  qryDestino.Insert;
  qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('GBC_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
  qryDestino.FieldByName('BAS_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
  qryDestino.FieldByName('BAS_CODBAS').AsString := qryOrigem.FieldByName('BASE').AsString;
  qryDestino.FieldByName('BAS_EMBALA').AsFloat  := qryOrigem.FieldByName('VOLUME').AsFloat;
  qryDestino.FieldByName('BAS_UNIDAD').AsString := fRetUnidade(qryOrigem.FieldByName('VOLUME').AsFloat);
  qryDestino.FieldByName('BAS_PRODUT').AsString := qryOrigem.FieldByName('PRODUTO').AsString;
  qryDestino.Post;
end;

function TGravandoExecucaoGlobalBcBases.IsRegistroExiste(
  const qryOrigem: TDataSet; qryDestino: IDataSet): Boolean;
begin
  Result := qryDestino.Locate('BAS_CODBAS;BAS_PRODUT;BAS_UNIDAD', VarArrayOf([qryOrigem.FieldByName('BASE').AsString,
    qryOrigem.FieldByName('PRODUTO').AsString, fRetUnidade(qryOrigem.FieldByName('VOLUME').AsFloat)]), []);

  If (qryOrigem.FieldByName('VOLUME').AsFloat) <= 0 Then
    Result := True;
end;

procedure TGravandoExecucaoGlobalBcBases.ProcessaBases(qryOrigem: TDataSet;
  qryDestino: IDataSet; const gravando: IGravando);
begin
  While Not qryOrigem.Eof Do
  Begin
    Try
      Try

        If (Gravando.Status <> sgGravando) Then
          Break;

        If Not IsRegistroExiste(qryOrigem, qryDestino) Then
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
end;

end.
