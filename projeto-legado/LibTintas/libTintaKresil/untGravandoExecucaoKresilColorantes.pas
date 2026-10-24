{*************************************************************************}
{* Classe responsável pela geração do cadastro de Colorantes da tinta Kresil *}
{**********************************************************************PH*}
unit untGravandoExecucaoKresilColorantes;

interface

uses
  untAbstractGravandoExecucaoKresil, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils;

Type
  TGravandoExecucaoKresilColorantes = class(TAbstractGravandoExecucaoKresil)
  Private
    function fRetDescricaoColorante(strColorante: String): String;
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
    function GetSqlDestino(): string; override;
    function GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): string; override;
    procedure GravarRegistro(const qryOrigem: TDataSet; qryDestino: IDataSet; intEmb, intTotEmb: Integer); Override;
    function IsRegistroExiste(const qryOrigem: TDataSet; qryDestino: IDataSet; intEmb, intTotEmb: Integer): Boolean; Override;
  end;

implementation

{ TGravandoExecucaoKresilColorantes }

uses untStrUtils, untDefinicaoTxtCampoTipo, untADOTxtFactory, untGenericDefinicaoTxtCampo, untGenericDefinicaoTxt,
    untIDefinicaoTxtCampo, untIDefinicaoTxt, untDefinicaoTxtCharacterSet;

procedure TGravandoExecucaoKresilColorantes.Executar(const gravando: IGravando);
Var
  qryOrigem: TDataSet;
  qryDestino: IDataSet;
  intContador: Integer;
begin
  For intContador := 0 To stlPath.Count - 1 Do
  Begin
    Try
      Try
        Gravando.Texto := 'Verificando path do arquivo...';

        If Not fValidarPath(intContador) Then
        Begin
          Gravando.Texto := Format('O arquivo [%s] não foi encontrado! Verificar Configurações.', [AnsiReplaceStr(fGetPath(intContador), '"', '')]);
          Exit;
        End;

        If (Gravando.Status <> sgGravando) Then
          Exit;

        Gravando.Texto := 'Path verificado com sucesso...';
        Gravando.Texto := 'Verificando PROCOD...';
        TAutcomTintaFactory.Get.fInsereProCod('KRE_CADCOL');
        Gravando.Texto := 'PROCOD verificado com sucesso...';

        If (Gravando.Status <> sgGravando) Then
          Exit;

        Gravando.Texto := 'Carregando Dados...';
        CarregarDados(Gravando, qryOrigem, fGetPath(intContador), qryDestino);

        Gravando.Texto := Format('Processando Arquivo: [%s]', [AnsiReplaceStr(fGetPath(intContador), '"', '')]);
        Gravando.RegistrarProgresso(0, 0, 0);
        qryOrigem.First;

        While Not qryOrigem.Eof Do
        Begin
          Try
            Try
              If (Gravando.Status <> sgGravando) THen
                Break;

              If Not IsRegistroExiste(qryOrigem, qryDestino, 0, 0) Then
                GravarRegistro(qryOrigem, qryDestino, 0, 0);

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

function TGravandoExecucaoKresilColorantes.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Colorantes';
end;

function TGravandoExecucaoKresilColorantes.fRetDescricaoColorante(
  strColorante: String): String;
begin
  Result := '';

  If strColorante = 'KX' Then
    Result := 'BRANCO'
  Else If strColorante = 'R' Then
    Result := 'VERMELHO'
  Else If strColorante = 'T' Then
    Result := 'LARANJA (AMARELO MÉDIO)'
  Else If strColorante = 'C' Then
    Result := 'AMARELO OXIDO'
  Else If strColorante = 'AXX' Then
    Result := 'AMARELO'
  Else If strColorante = 'D' Then
    Result := 'VERDE'
  Else If strColorante = 'B' Then
    Result := 'PRETO'
  Else If strColorante = 'F' Then
    Result := 'VERMELHO OXIDO'
  Else If strColorante = 'I' Then
    Result := 'MARROM'
  Else If strColorante = 'L' Then
    Result := 'TERRA'
  Else If strColorante = 'E' Then
    Result := 'AZUL'
  Else If strColorante = 'V' Then
    Result := 'MAGENTA';
end;

function TGravandoExecucaoKresilColorantes.GetSqlDestino: string;
begin
  Result := '   SELECT * FROM KRE_CADCOL    ';
end;

function TGravandoExecucaoKresilColorantes.GetSqlOrigem(
  const strNomeArquivo: string; const stlTabelas: TStrings): string;
begin
  Result := '';
  Result := Result + '  SELECT                              ';
  Result := Result + '    [C.CORANTE 1] AS COLORANTE        ';
  Result := Result + '  FROM                                ';
  Result := Result + '    [Plan1$] AS C                     ';
  Result := Result + '  WHERE [CORANTE 1] <> ""             ';
  Result := Result + '  UNION ALL                           ';
  Result := Result + '  SELECT                              ';
  Result := Result + '    [C.CORANTE 2] AS COLORANTE        ';
  Result := Result + '  FROM                                ';
  Result := Result + '    [Plan1$] AS C                     ';
  Result := Result + '  WHERE [CORANTE 2] <> ""             ';
  Result := Result + '  UNION ALL                           ';
  Result := Result + '  SELECT                              ';
  Result := Result + '    [C.CORANTE 3] AS COLORANTE        ';
  Result := Result + '  FROM                                ';
  Result := Result + '    [Plan1$] AS C                     ';
  Result := Result + '  WHERE [CORANTE 3] <> ""             ';
  Result := Result + '  UNION ALL                           ';
  Result := Result + '  SELECT                              ';
  Result := Result + '    [C.CORANTE 4] AS COLORANTE        ';
  Result := Result + '  FROM                                ';
  Result := Result + '    [Plan1$] AS C                     ';
  Result := Result + '  WHERE [CORANTE 4] <> ""             ';
  Result := Result + '  UNION ALL                           ';
  Result := Result + '  SELECT                              ';
  Result := Result + '    [C.CORANTE 5] AS COLORANTE        ';
  Result := Result + '  FROM                                ';
  Result := Result + '    [Plan1$] AS C                     ';
  Result := Result + '  WHERE [CORANTE 5] <> ""             ';
end;

procedure TGravandoExecucaoKresilColorantes.GravarRegistro(
  const qryOrigem: TDataSet; qryDestino: IDataSet; intEmb, intTotEmb: Integer);
var
  strColorante: String;
  intPos: Integer;
begin
  intPos := Pos('-', qryOrigem.FieldByName('COLORANTE').AsString);

  strColorante := Copy(qryOrigem.FieldByName('COLORANTE').AsString, 1, intPos - 1);

  If TStrUtils.fEmptyStr(strColorante) Then
    Exit;

  qryDestino.Insert;
  qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('KRE_CADCOL', TAutcomTintaFactory.Get.GetCodEmp);
  qryDestino.FieldByName('COL_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
  qryDestino.FieldByName('COL_CODCOL').AsString := strColorante;
  qryDestino.FieldByName('COL_DESCRI').AsString := fRetDescricaoColorante(strColorante);
  qryDestino.FieldByName('COL_EMBALA').AsFloat  := 946.00;
  qryDestino.Post;
end;

function TGravandoExecucaoKresilColorantes.IsRegistroExiste(
  const qryOrigem: TDataSet; qryDestino: IDataSet; intEmb,
  intTotEmb: Integer): Boolean;
Var
  intPos: Integer;
begin
  intPos := Pos('-', qryOrigem.FieldByName('COLORANTE').AsString);
  Result := qryDestino.Locate('COL_CODCOL', VarArrayOf([Copy(qryOrigem.FieldByName('COLORANTE').AsString, 1, intPos - 1)]), []);
end;

end.
