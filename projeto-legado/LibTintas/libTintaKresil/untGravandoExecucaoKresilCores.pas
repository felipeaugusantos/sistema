{*************************************************************************}
{* Classe responsável pela geração do cadastro de bases da tinta Kresil *}
{**********************************************************************PH*}
unit untGravandoExecucaoKresilCores;

interface

uses
  untAbstractGravandoExecucaoKresil, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils;

  type
    TGravandoExecucaoKresilCores = class(TAbstractGravandoExecucaoKresil)
  Private
    strAnterior: String;
    function fRetTotalUnidade(strEmbalagem: String): Integer;
    function fRetUnidade(strEmbalagem: String; intEmb: Integer; intTotEmb: Integer): String;
    function fRetFator(strUnidade: String; intRegistros: Integer; intEmb: Integer): Double;
    procedure IsDeletaFormulas();
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
    function GetSqlDestino(): string; override;
    function GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): string; override;
    procedure GravarRegistro(const qryOrigem: TDataSet; qryDestino: IDataSet; intEmb, intTotEmb: Integer); Override;
    function IsRegistroExiste(const qryOrigem: TDataSet; qryDestino: IDataSet; intEmb, intTotEmb: Integer): Boolean; Override;
  end;

implementation

{ TGravandoExecucaoKresilCores }

uses
  untFuncoesGenerica, untStrUtils, untDefinicaoTxtCampoTipo, untADOTxtFactory, untGenericDefinicaoTxtCampo, untGenericDefinicaoTxt,
    untIDefinicaoTxtCampo, untIDefinicaoTxt, untDefinicaoTxtCharacterSet;


procedure TGravandoExecucaoKresilCores.Executar(const gravando: IGravando);
Var
  qryOrigem: TDataSet;
  qryDestino: IDataSet;
  intContador: Integer;
  intEmb, intTotEmb: Integer;
begin
  For intContador := 0 To stlPath.Count - 1 Do
  Begin
    Try
      Try
        Gravando.Texto := 'Verificando path do arquivo...';

        If Not fValidarPath(intContador) Then
        Begin
          Gravando.Texto := Format('O arquivo [%s] não foi encontrado! Rever Configurações.', [AnsiReplaceStr(fGetPath(intContador), '"', '')]);
          Exit;
        End;

        If (Gravando.Status <> sgGravando) Then
          Exit;


        Gravando.Texto := 'Path verificado com sucesso...';

        If intContador = 0 Then
        Begin
          Gravando.Texto := 'Deletando registros da tabela KRE_CADKRE...';
          IsDeletaFormulas();
          Gravando.Texto := 'Registros deletados com sucesso...';
        End;

        Gravando.Texto := 'Verificando PROCOD...';
        TAutcomTintaFactory.Get.fInsereProCod('KRE_CADKRE');
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
              If (Gravando.Status <> sgGravando) Then
                Break;

              strAnterior := '';
              intTotEmb := fRetTotalUnidade(qryOrigem.FieldByName('EMBALAGEM_D').AsString);

              For intEmb := 1 To intTotEmb Do
              Begin
                If Not IsRegistroExiste(qryOrigem, qryDestino, intEmb, intTotEmb) Then
                  GravarRegistro(qryOrigem, qryDestino, intEmb, intTotEmb);
              End;
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

function TGravandoExecucaoKresilCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;

function TGravandoExecucaoKresilCores.fRetFator(strUnidade: String;
  intRegistros: Integer; intEmb: Integer): Double;
begin
  Result := 1;

  If intRegistros = 2 Then
  Begin
    If (intEmb = 1) And (strUnidade = 'QT') Then
    Begin
      Result := 800 / 800;
      strAnterior := 'QT';
    End
    Else If (intEmb = 1) And (strUnidade = 'GL') Then
    Begin
      Result := 3200 / 3200;
      strAnterior := 'GL';
    End
    Else If (intEmb = 2) And (strUnidade = 'GL') And (strAnterior = 'QT') Then
      Result := 3200 / 800
    Else If (intEmb = 2) And (strUnidade = 'BD') And (strAnterior = 'QT') Then
      Result := 16000 / 800
    Else If (intEmb = 2) And (strUnidade = 'BD') And (strAnterior = 'GL') Then
      Result := 16000 / 3200;
  End
  Else If intRegistros = 3 Then
  Begin
    If strUnidade = 'QT' Then
      Result := 800 / 800
    Else If strUnidade = 'GL' Then
      Result := 3200 / 800
    Else If strUnidade = 'BD' Then
      Result := 16000 / 800;
  End;
end;

function TGravandoExecucaoKresilCores.fRetTotalUnidade(
  strEmbalagem: String): Integer;
begin
  Result := 1;

  If strEmbalagem = 'BALDE' Then
    Result := Result + 1
  Else If strEmbalagem = 'GALAO;BALDE' Then
    Result := Result + 2
  Else If strEmbalagem = 'QUARTO;GALAO;BALDE' Then
    Result := 3;

end;

function TGravandoExecucaoKresilCores.fRetUnidade(strEmbalagem: String; intEmb,
  intTotEmb: Integer): String;
begin
  Result := 'QT';

  If intTotEmb = 3 Then
  Begin
    If intEmb = 1 Then
      Result := 'QT'
    Else If intEmb = 2 Then
      Result := 'GL'
    Else If intEmb = 3 Then
      Result := 'BD';
  End
  Else If (intTotEmb = 2) And (strEmbalagem = 'BALDE') Then
  Begin
    If intEmb = 1 Then
      Result := 'GL'
    Else If intEmb = 2 Then
      Result := 'BD';
  End;
end;

function TGravandoExecucaoKresilCores.GetSqlDestino: string;
begin
  Result := '   SELECT * FROM KRE_CADKRE    ';
end;

function TGravandoExecucaoKresilCores.GetSqlOrigem(const strNomeArquivo: string;
  const stlTabelas: TStrings): string;
begin
  Result := '';
  Result := Result + '  SELECT                              ';
  Result := Result + '    [F.COLECAO] AS COLECAO,           ';
  Result := Result + '    [F.CÓDIGO COR] AS C_COR,          ';
  Result := Result + '    [F.NOME DA COR] AS N_COR,         ';
  Result := Result + '    [F.BASE] AS BASE,                 ';
  Result := Result + '    [F.PRODUTO] AS PRODUTO,           ';
  Result := Result + '    [F.EMBALAGEM] AS EMBALAGEM,       ';
  Result := Result + '    [F.CORANTE 1] AS C_1,             ';
  Result := Result + '    [F.CORANTE 2] AS C_2,             ';
  Result := Result + '    [F.CORANTE 3] AS C_3,             ';
  Result := Result + '    [F.CORANTE 4] AS C_4,             ';
  Result := Result + '    [F.CORANTE 5] AS C_5,             ';
  Result := Result + '    [F.EMBALAGEM_D] AS EMBALAGEM_D    ';
  Result := Result + '  FROM                                ';
  Result := Result + '    [Plan1$] AS F                     ';
  Result := Result + '  WHERE                               ';
  Result := Result + '    [COLECAO] <> ""                   ';
  Result := Result + '  ORDER BY [CÓDIGO COR]               ';
end;

procedure TGravandoExecucaoKresilCores.GravarRegistro(const qryOrigem: TDataSet;
  qryDestino: IDataSet; intEmb, intTotEmb: Integer);
Var
  intContador: Integer;
  fltFator: Double;
  strColorante: String;
  strQuantidade: String;
  intPos, intPos1: Integer;
  fltInteiro: Double;
  fltFracao: Double;
  strTemFracao: String;

begin
  qryDestino.Insert;
  qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('KRE_CADKRE', TAutcomTintaFactory.Get.GetCodEmp);
  qryDestino.FieldByName('KRE_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
  qryDestino.FieldByName('KRE_CODIGO').AsString := qryOrigem.FieldByName('C_COR').AsString;
  qryDestino.FieldByName('KRE_NOMCOR').AsString := qryOrigem.FieldByName('N_COR').AsString;
  qryDestino.FieldByName('KRE_COLECA').AsString := qryOrigem.FieldByName('COLECAO').AsString;
  qryDestino.FieldByName('KRE_BASE__').AsString := qryOrigem.FieldByName('BASE').AsString;
  qryDestino.FieldByName('KRE_PRODUT').AsString := qryOrigem.FieldByName('PRODUTO').AsString;
  qryDestino.FieldByName('KRE_UNIDAD').AsString := fRetUnidade(qryOrigem.FieldByName('EMBALAGEM_D').AsString, intEmb, intTotEmb);
  qryDestino.FieldByName('KRE_ATIVO_').AsString := 'S';

  fltFator := fRetFator(qryDestino.FieldByName('KRE_UNIDAD').AsString, intTotEmb, intEmb);

  For intContador := 1 To 20 Do
  Begin

    If TStrUtils.fEmptyStr(qryOrigem.FieldByName('C_' + IntToStr(intContador)).AsString) Then
      Break;

    intPos := Pos('-', qryOrigem.FieldByName('C_' + IntToStr(intContador)).AsString);
    strColorante := Copy(qryOrigem.FieldByName('C_' + IntToStr(intContador)).AsString, 1, intPos - 1);
    strQuantidade := Copy(qryOrigem.FieldByName('C_' + IntToStr(intContador)).AsString, intPos + 1,
      Length(qryOrigem.FieldByName('C_' + IntToStr(intContador)).AsString));
    strQuantidade := AnsiReplaceStr(strQuantidade, '.', ',');


    qryDestino.FieldByName('KRE_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString := strColorante;

    intPos1 := Pos('Y', strQuantidade);

    If (intPos1 = 0) Then
    Begin
      qryDestino.FieldByName('KRE_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat :=
        (StrToFloat(strQuantidade) * (29.573529564112 / 48)) * fltFator;
    End
    Else
    Begin
      strTemFracao := Copy(strQuantidade, intPos1 + 1, Length(strQuantidade));

      fltInteiro := StrToFloat(Copy(strQuantidade, 1, intPos1 - 1));

      If Not TStrUtils.fEmptyStr(strTemFracao) Then
      Begin
        fltFracao := StrToFloat(Copy(strQuantidade, intPos1 + 1, Length(strQuantidade)));
        fltFracao  := (fltFracao * (29.573529564112 / 48));
      End
      Else
        fltFracao := 0.0;

      fltInteiro := fltInteiro * 29.573529564112;


      qryDestino.FieldByName('KRE_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat :=
        (fltInteiro + fltFracao) * fltFator;
    End;
  End;

  qryDestino.FieldByName('KRE_MD5KEY').AsString := GetMD5(qryDestino.FieldByName('KRE_CODIGO').AsString +
                                                          qryDestino.FieldByName('KRE_NOMCOR').AsString +
                                                          qryDestino.FieldByName('KRE_BASE__').AsString +
                                                          qryDestino.FieldByName('KRE_PRODUT').AsString +
                                                          qryDestino.FieldByName('KRE_UNIDAD').AsString +
                                                          qryDestino.FieldByName('KRE_COLECA').AsString);
  qryDestino.Post;
end;

procedure TGravandoExecucaoKresilCores.IsDeletaFormulas;
Var
  qryDel: IDataSet;
begin
  qryDel := TAutcomTintaFactory.Get.fGetDataSet;
  qryDel.Close;
  qryDel.SQL := ' DELETE FROM KRE_CADKRE    ';
  qryDel.ExecSQL;
end;

function TGravandoExecucaoKresilCores.IsRegistroExiste(
  const qryOrigem: TDataSet; qryDestino: IDataSet; intEmb,
  intTotEmb: Integer): Boolean;
begin
  Result := False;
end;

end.
