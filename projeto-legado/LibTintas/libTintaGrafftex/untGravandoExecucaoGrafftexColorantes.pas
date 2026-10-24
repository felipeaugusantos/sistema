{******************************************************************************}
{* Classe responsável pela geração do cadastro de colorantes da tinta Grafftex *}
{***************************************************************************PH*}
unit untGravandoExecucaoGrafftexColorantes;

interface

uses
  untAbstractGravandoExecucaoGrafftex, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils;

type
  TGravandoExecucaoGrafftexColorantes = class(TAbstractGravandoExecucaoGrafftex)
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
    function GetSqlDestino(): string; override;
    function GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): string; override;
    procedure GravarRegistro(const qryOrigem: TDataSet; qryDestino: IDataSet); Override;
    function IsRegistroExiste(const qryOrigem: TDataSet; qryDestino: IDataSet): Boolean; Override;
  end;

implementation

uses untStrUtils, untDefinicaoTxtCampoTipo, untADOTxtFactory, untGenericDefinicaoTxtCampo, untGenericDefinicaoTxt,
    untIDefinicaoTxtCampo, untIDefinicaoTxt, untDefinicaoTxtCharacterSet;

{ TGravandoExecucaoGrafftexCores }

procedure TGravandoExecucaoGrafftexColorantes.Executar(const gravando: IGravando);
Var
  qryOrigem: TDataSet;
  qryDestino: IDataSet;
  intContador: Integer;
begin
  For intContador := 0 To stlArquivos.Count - 1 Do
  Begin
    Try
      Try
        Gravando.Texto := 'Verificando path do arquivo...';

        If Not fValidarPath(intContador) Then
        Begin
          Gravando.Texto := Format('O arquivo [%s] não foi encontrado! Verifique as Configurações.', [AnsiReplaceStr(fGetPath(intContador), '"', '')]);
          Exit;
        End;

        If (Gravando.Status <> sgGravando) Then
          Exit;

        Gravando.Texto := 'Path verificado com sucesso...';
        Gravando.Texto := 'Verificando PROCOD...';
        TAutcomTintaFactory.Get.fInsereProCod('GRA_CADCOL');
        Gravando.Texto := 'PROCOD verificado com sucesso...';

        If (Gravando.Status <> sgGravando) Then
          Exit;

        Gravando.Texto := 'Carregando Dados...';

        CarregarDados(Gravando, qryOrigem, fGetPath(intContador), qryDestino);

        Gravando.Texto := Format('Processando Arquivos: [%s]', [AnsiReplaceStr(fGetPath(intContador), '"', '')]);
        Gravando.RegistrarProgresso(0, 0, 0);
        qryOrigem.First;

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
      Except
        On E: Exception Do
        Begin
          Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
        End;
      End;
    Finally
      If Assigned(qryOrigem) Then
        FreeAndNil(qryOrigem);
    End;
  End;
end;

function TGravandoExecucaoGrafftexColorantes.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Colorantes';
end;


function TGravandoExecucaoGrafftexColorantes.GetSqlDestino: string;
begin
  Result := '   SELECT * FROM GRA_CADCOL    ';
end;

function TGravandoExecucaoGrafftexColorantes.GetSqlOrigem(
  const strNomeArquivo: string; const stlTabelas: TStrings): string;
begin
  Result := '';
  Result := Result + '   SELECT           ';
  Result := Result + '     Corante_1 AS COLORANTE,          ';
  Result := Result + '     Produto AS PRODUTO               ';
  Result := Result + '   FROM             ';
  Result := Result + '     [Sheet1$]      ';
  Result := Result + '   WHERE Corante_1 <> ""            ';
  Result := Result + '   AND Produto <> ""                ';
  Result := Result + '   UNION ALL        ';
  Result := Result + '   SELECT           ';
  Result := Result + '     Corante_2 AS COLORANTE,          ';
  Result := Result + '     Produto AS PRODUTO               ';
  Result := Result + '   FROM             ';
  Result := Result + '     [Sheet1$]      ';
  Result := Result + '   WHERE Corante_2 <> ""            ';
  Result := Result + '   AND Produto <> ""                ';
  Result := Result + '   UNION ALL        ';
  Result := Result + '   SELECT           ';
  Result := Result + '     Corante_3 AS COLORANTE,          ';
  Result := Result + '     Produto AS PRODUTO               ';
  Result := Result + '   FROM             ';
  Result := Result + '     [Sheet1$]      ';
  Result := Result + '   WHERE Corante_3 <> ""            ';
  Result := Result + '   AND Produto <> ""                ';
  Result := Result + '   UNION ALL        ';
  Result := Result + '   SELECT           ';
  Result := Result + '     Corante_4 AS COLORANTE,          ';
  Result := Result + '     Produto AS PRODUTO               ';
  Result := Result + '   FROM             ';
  Result := Result + '     [Sheet1$]      ';
  Result := Result + '   WHERE Corante_4 <> ""            ';
  Result := Result + '   AND Produto <> ""                ';
  Result := Result + '   UNION ALL        ';
  Result := Result + '   SELECT           ';
  Result := Result + '     Corante_5 AS COLORANTE,          ';
  Result := Result + '     Produto AS PRODUTO               ';
  Result := Result + '   FROM             ';
  Result := Result + '     [Sheet1$]      ';
  Result := Result + '   WHERE Corante_5 <> ""            ';
  Result := Result + '   AND Produto <> ""                ';
  Result := Result + '   UNION ALL        ';
  Result := Result + '   SELECT           ';
  Result := Result + '     Corante_6 AS COLORANTE,          ';
  Result := Result + '     Produto AS PRODUTO               ';
  Result := Result + '   FROM             ';
  Result := Result + '     [Sheet1$]      ';
  Result := Result + '   WHERE Corante_6 <> ""            ';
  Result := Result + '   AND Produto <> ""                ';
end;

procedure TGravandoExecucaoGrafftexColorantes.GravarRegistro(
  const qryOrigem: TDataSet; qryDestino: IDataSet);
begin
  qryDestino.Insert;
  qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('GRA_CADCOL', TAutcomTintaFactory.Get.GetCodEmp);
  qryDestino.FieldByName('COL_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
  qryDestino.FieldByName('COL_CODCOL').AsString := qryOrigem.FieldByName('COLORANTE').AsString;
  qryDestino.FieldByName('COL_DESCRI').AsString := qryOrigem.FieldByName('COLORANTE').AsString;
  qryDestino.FieldByName('COL_EMBALA').AsFloat  := 2000;
  qryDestino.Post;
end;

function TGravandoExecucaoGrafftexColorantes.IsRegistroExiste(
  const qryOrigem: TDataSet; qryDestino: IDataSet): Boolean;
begin
  Result := qryDestino.Locate('COL_CODCOL', VarArrayOf([qryOrigem.FieldByName('COLORANTE').AsString]), []);
end;

end.

