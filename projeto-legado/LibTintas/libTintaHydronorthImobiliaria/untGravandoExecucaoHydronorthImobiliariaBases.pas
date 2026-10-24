{**********************************************************************************}
{* Classe responsável pela geração do cadastro de bases da tinta HydronorthImobiliaria *}
{*******************************************************************************AC*}
unit untGravandoExecucaoHydronorthImobiliariaBases;

interface

uses
  untAbstractGravandoExecucaoHydronorthImobiliaria, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils;

type
  TGravandoExecucaoHydronorthImobiliariaBases = class(TAbstractGravandoExecucaoHydronorthImobiliaria)
  protected
     function GetSqlDestino(): string; Override;
     function GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings; intTabela: Integer): string; Override;
     function IsRegistroExistente(const qryOrigem: TDataSet; qryDestino: IDataSet; intUnidade: Integer; Tabela: String): Boolean; Reintroduce;
     procedure GravarRegistro(const qryOrigem: TDataSet; qryDestino: IDataSet; intEmbalagem: Integer; Tabela: String); Reintroduce;
     function GeraUnidades(intEmbalagem: Integer; Tabela: String): String;
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  const
  ArrUnidade: Array[1..3] Of String = ('QUA', 'GAL', 'LAA');
  end;

implementation

uses untStrUtils;
{ TGravandoExecucaoHydronorthImobiliariaBases }

procedure TGravandoExecucaoHydronorthImobiliariaBases.Executar(const gravando: IGravando);
var
  qryOrigem: TDataSet;
  qryDestino: IDataSet;
  intEmbalagem: Integer;
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
  TAutcomTintaFactory.Get.fInsereProCod('HYD_CADBAS');
  Gravando.Texto := 'PROCOD verificado com sucesso...';


  For intContador := 0 To Tabelas.Count - 1 Do
  Begin
    Try
      Try
        gravando.Texto := 'Carregando Dados...';

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

              If gravando.Status <> sgGravando Then
                Break;


              For intEmbalagem := 1 To 3 Do
              Begin

                If intEmbalagem = 1 Then
                Begin
                  If Not GeraLitroBase(Tabelas[intContador]) Then
                    Continue;
                End;

                If Not IsRegistroExistente(qryOrigem, qryDestino, intEmbalagem, Tabelas[intContador]) Then
                  GravarRegistro(qryOrigem, qryDestino, intEmbalagem, Tabelas[intContador]);

              End;
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
        end;
      Except
        On E: Exception Do
          Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      End;
    Finally

    End;
  End;
end;

function TGravandoExecucaoHydronorthImobiliariaBases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases';
end;

function TGravandoExecucaoHydronorthImobiliariaBases.GeraUnidades(intEmbalagem: Integer; Tabela: String): String;
begin
  Result := arrUnidade[intEmbalagem];

  If (Tabela = 'GRAFIATO LISO') And (intEmbalagem = 2) Then
    Result := 'GAT'
  Else If (Tabela = 'GRAFIATO ARTE') And (intEmbalagem = 2) Then
    Result := 'GAT'
  Else If (Tabela = 'GRAFIATO RISCADO') And (intEmbalagem = 2) Then
    Result := 'GAT'
  Else If (Tabela = 'GRAFIATO ARTE') And (intEmbalagem = 3) Then
    Result := 'LAT'
  Else If (Tabela = 'GRAFIATO LISO') And (intEmbalagem = 3) Then
    Result := 'LAT'
  Else If (Tabela = 'GRAFIATO RISCADO') And (intEmbalagem = 3) Then
    Result := 'LTA';
end;

function TGravandoExecucaoHydronorthImobiliariaBases.GetSqlDestino: string;
begin
  Result := '   SELECT  * FROM  HYD_CADBAS  ';
end;

function TGravandoExecucaoHydronorthImobiliariaBases.GetSqlOrigem(
  const strNomeArquivo: string; const stlTabelas: TStrings; intTabela: Integer): string;
begin
  Result := '';
  Result := Result + '  SELECT DISTINCT                     ';
  Result := Result + '    [Base] AS CODBAS,                 ';
  Result := Result + '    [Produto] AS PRODUT               ';
  Result := Result + '  FROM                                ';
  Result := Result + '    [' + Tabelas[intTabela] + '$]     ';
  Result := Result + '  WHERE [Produto] <> ""               ';
end;

procedure TGravandoExecucaoHydronorthImobiliariaBases.GravarRegistro(
  const qryOrigem: TDataSet; qryDestino: IDataSet; intEmbalagem: Integer; Tabela: String);
begin
  qryDestino.Insert;
  qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('HYD_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
  qryDestino.FieldByName('BAS_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
  qryDestino.FieldByName('BAS_BASE__').AsString := Trim(qryOrigem.FieldByName('CODBAS').AsString);
  qryDestino.FieldByName('BAS_CODEMB').AsString := GeraUnidades(intEmbalagem, Tabela);
  qryDestino.FieldByName('BAS_PRODUT').AsString := qryOrigem.FieldByName('PRODUT').AsString;
  qryDestino.Post;
end;

function TGravandoExecucaoHydronorthImobiliariaBases.IsRegistroExistente(
  const qryOrigem: TDataSet; qryDestino: IDataSet;
  intUnidade: Integer; Tabela: String): Boolean;
begin
  Result := qryDestino.Locate('BAS_BASE__;BAS_CODEMB;BAS_PRODUT', VarArrayOf([qryOrigem.FieldByName('CODBAS').AsString,
    ArrUnidade[intUnidade], qryOrigem.FieldByName('PRODUT').AsString]), []);
end;

end.
