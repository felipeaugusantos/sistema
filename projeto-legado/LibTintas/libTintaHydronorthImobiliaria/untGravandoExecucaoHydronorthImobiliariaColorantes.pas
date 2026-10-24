{******************************************************************************}
{* Classe responsável pela geração do cadastro de colorantes da tinta HydronorthImobiliaria *}
{***************************************************************************PH*}
unit untGravandoExecucaoHydronorthImobiliariaColorantes;

interface

uses
  untAbstractGravandoExecucaoHydronorthImobiliaria, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils;
type
  TGravandoExecucaoHydronorthImobiliariaColorantes = class(TAbstractGravandoExecucaoHydronorthImobiliaria)
  protected
     function GetSqlDestino(): string; Override;
     function GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings; intTabela: Integer): string; Override;
     function IsRegistroExistente(const qryOrigem: TDataSet; qryDestino: IDataSet; intUnidade: Integer): Boolean; Override;
     procedure GravarRegistro(const qryOrigem: TDataSet; qryDestino: IDataSet; intEmbalagem: Integer); Override;
     procedure DeletarRegistros();
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

uses untStrUtils;
{ TGravandoExecucaoHydronorthImobiliariaCores }

procedure TGravandoExecucaoHydronorthImobiliariaColorantes.DeletarRegistros;
Var
  qryDelete: IDataSet;
begin
  qryDelete := TAutcomTintaFactory.Get.fGetDataSet;
  qryDelete.Close;
  qryDelete.SQL := '  DELETE FROM HYD_CADCOL WHERE COL_CODCOL = "" OR COL_CODCOL = "0"      ';
  qryDelete.ExecSQL;
end;

procedure TGravandoExecucaoHydronorthImobiliariaColorantes.Executar(const gravando: IGravando);
Var
  qryOrigem: TDataSet;
  qryDestino: IDataSet;
  intContador: Integer;
begin
  Gravando.Texto := 'Verificando Path...';

  If Not fValidaPath Then
  Begin
    Gravando.Texto := Format('O arquivo [%s] não foi encontrado! Rever configurações.', [AnsiReplaceStr(GetPath, '"', '')]);
    Exit;
  End;

  If (Gravando.Status <> sgGravando) Then
          Exit;

  Gravando.Texto := 'Verificando PROCOD...';
  TAutcomTintaFactory.Get.fInsereProCod('HYD_CADCOL');
  Gravando.Texto := 'PROCOD verificado com sucesso...';

  For intContador := 0 To Tabelas.Count - 1 Do
  Begin
    Try
      Try
        Gravando.Texto := 'Carregando Dados...';

        CarregarDados(Gravando, qryOrigem, AnsiReplaceStr(GetPath, '"', ''), qryDestino, intContador);

        If (Gravando.Status <> sgGravando) Then
          Exit;

        Gravando.Texto := Format('Processando arquivo [%s]', [AnsiReplaceStr(GetPath, '"', '')]);
        Gravando.RegistrarProgresso(0, 0, 0);

        qryOrigem.First;

        While (Not qryOrigem.Eof) And (gravando.Status = sgGravando) Do
        Begin
          Try
            Try

              If (Gravando.Status <> sgGravando) Then
                Break;


              If Not IsRegistroExistente(qryOrigem, qryDestino, 0) Then
                GravarRegistro(qryOrigem, qryDestino, 0);

            Except
              On E: Exception Do
              Begin
                Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
              End;
            End;
          Finally
            qryOrigem.Next;
            Gravando.RegistrarProgresso(1, qryOrigem.RecNo, qryOrigem.RecordCount);
          End;
        End;

        Gravando.Texto := 'Deletando Registros não utilizados da tabela HYD_CADCOL...';

        DeletarRegistros;

        Gravando.Texto := 'Registros deletados com sucesso...';
      Except
        On E: Exception Do
          Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      End;
    Finally

    End;
  End;
end;

function TGravandoExecucaoHydronorthImobiliariaColorantes.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Colorantes';
end;

function TGravandoExecucaoHydronorthImobiliariaColorantes.GetSqlDestino: string;
begin
  Result := '   SELECT * FROM HYD_CADCOL    ';
end;

function TGravandoExecucaoHydronorthImobiliariaColorantes.GetSqlOrigem(
  const strNomeArquivo: string; const stlTabelas: TStrings; intTabela: Integer): string;
Var
  intCanister: Integer;
begin
  Result := '';
  Result := Result + '  SELECT DISTINCT                 ';
  Result := Result + '    [Canister1] AS COLORANTE      ';
  Result := Result + '  FROM                            ';
  Result := Result + '    [' + Tabelas[intTabela] + '$]          ';
  Result := Result + '  WHERE                           ';
  Result := Result + '    [Canister1] <> "0" OR         ';
  Result := Result + '    [Canister1] <> ""             ';

  For intCanister := 2 To 5 Do
  Begin
    Result := Result + '  UNION ALL                     ';
    Result := Result + '  SELECT DISTINCT               ';
    Result := Result + '    [Canister' + IntToStr(intCanister) + '] AS COLORANTE      ';
    Result := Result + '  FROM                          ';
    Result := Result + '    [' + Tabelas[intTabela] + '$]        ';
  End;
end;

procedure TGravandoExecucaoHydronorthImobiliariaColorantes.GravarRegistro(
  const qryOrigem: TDataSet; qryDestino: IDataSet; intEmbalagem: Integer);
begin
  qryDestino.Insert;
  qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('HYD_CADCOL', TAutcomTintaFactory.Get.GetCodEmp);
  qryDestino.FieldByName('COL_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
  qryDestino.FieldByName('COL_CODCOL').AsString := qryOrigem.FieldByName('COLORANTE').AsString;
  qryDestino.FieldByName('COL_EMBALA').AsFloat  := 1000;
  qryDestino.Post;
end;

function TGravandoExecucaoHydronorthImobiliariaColorantes.IsRegistroExistente(
  const qryOrigem: TDataSet; qryDestino: IDataSet;
  intUnidade: Integer): Boolean;
begin
  Result := qryDestino.Locate('COL_CODCOL', VarArrayOf([qryOrigem.FieldByName('COLORANTE').AsString]), []);
end;

end.

