{*************************************************************************}
{* Classe responsável pela geração do cadastro de cores da tinta HydronorthImobiliaria *}
{**********************************************************************PH*}
unit untGravandoExecucaoHydronorthImobiliariaCores;

interface

uses
  untAbstractGravandoExecucaoHydronorthImobiliaria, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils;

type
  TGravandoExecucaoHydronorthImobiliariaCores = class(TAbstractGravandoExecucaoHydronorthImobiliaria)
  protected
     function GetSqlDestino(): string; Override;
     function GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings; intTabela: Integer): string; Override;
     function IsRegistroExistente(const qryOrigem: TDataSet; qryDestino: IDataSet; intUnidade: Integer; Tabela: String): Boolean; Reintroduce;
     procedure GravarRegistro(const qryOrigem: TDataSet; qryDestino: IDataSet; intEmbalagem: Integer; Tabela: String); Reintroduce;
     procedure IsDeletarRegistros();
     function fRetFatorEmbalagem(strEmbalagem: String): Double;
     procedure IsDeletarRegistrosDuplicados(Gravando: IGravando);
     function GeraEmbalagem(intEmbalagem: Integer; Tabela: String): String;
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  const
    arrEmbalagem: Array[1..3] Of String = ('QUA', 'GAL', 'LAA');
  end;

Implementation

uses
  untFuncoesGenerica, untStrUtils;

{ TGravandoExecucaoHydronorthImobiliariaCores }

procedure TGravandoExecucaoHydronorthImobiliariaCores.Executar(const gravando: IGravando);
Var
  qryOrigem: TDataSet;
  qryDestino: IDataSet;
  intEmbalagem: Integer;
  intContador: Integer;
begin
  Gravando.Texto := 'Verificando Path...';

  If Not fValidaPath Then
  Begin
    Gravando.Texto := Format('O arquivo [%s] não foi encontrado! Rever Configurações.', [AnsiReplaceStr(GetPath, '"', '')]);
    Exit;
  End;

  If (Gravando.Status <> sgGravando) Then
    Exit;

  Gravando.Texto := 'Deletando registros da tabela HYD_CADHYD...';
  IsDeletarRegistros();
  Gravando.Texto := 'Registros deletados...';

  Gravando.Texto := 'Verificando PROCOD...';
  TAutcomTintaFactory.Get.fInsereProCod('HYD_CADHYD');
  Gravando.Texto := 'PROCOD verificado com sucesso...';

  For intContador := 0 To Tabelas.Count - 1 Do
  Begin
    Try
      Try
        Gravando.Texto := 'Carregar Dados...';

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

      Gravando.Texto := 'Excluindo Fórmulas duplicadas...';
      IsDeletarRegistrosDuplicados(Gravando);
    Finally

    End;
  End
end;

function TGravandoExecucaoHydronorthImobiliariaCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;

function TGravandoExecucaoHydronorthImobiliariaCores.fRetFatorEmbalagem(
  strEmbalagem: String): Double;
begin
  Result := 1;

  If strEmbalagem = 'QUA' Then
    Result := 800 / 800
  Else If strEmbalagem = 'GAL' Then
    Result := 3200 / 800
  Else If strEmbalagem = 'LAA' Then
    Result := 16000 / 800
  Else If strEmbalagem = 'GAT' Then
    Result := 6000 / 6000
  Else If strEmbalagem = 'LAT' Then
    Result := 25000 / 6000
  Else If strEmbalagem = 'LTA' Then
    Result := 28000 / 6000;
end;

function TGravandoExecucaoHydronorthImobiliariaCores.GeraEmbalagem(
  intEmbalagem: Integer; Tabela: String): String;
begin
  Result := arrEmbalagem[intEmbalagem];

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

function TGravandoExecucaoHydronorthImobiliariaCores.GetSqlDestino: string;
begin
  Result := '   SELECT * FROM HYD_CADHYD      ';
end;

function TGravandoExecucaoHydronorthImobiliariaCores.GetSqlOrigem(
  const strNomeArquivo: string; const stlTabelas: TStrings; intTabela: Integer): string;
begin
  Result := '';
  Result := Result + '  SELECT                              ';
  Result := Result + '    [Grupo de Cor] AS COLECAO,        ';
  Result := Result + '    [Produto] AS PRODUTO,             ';
  Result := Result + '    [Código Cor] AS CODIGO,           ';
  Result := Result + '    [Base] AS CODBAS,                 ';
  Result := Result + '    [Nome Cor] AS NOME_COR,           ';
  Result := Result + '    [Canister1] AS COLORANTE_1,       ';
  Result := Result + '    [1-384/oz] AS QUANTIDADE_1,       ';  //Quantidade Shot 1
  Result := Result + '    [Canister2] AS COLORANTE_2,       ';
  Result := Result + '    [2-384/oz] AS QUANTIDADE_2,       ';  //Quantidade Shot 2
  Result := Result + '    [Canister3] AS COLORANTE_3,       ';
  Result := Result + '    [3-384/oz] AS QUANTIDADE_3,       ';  //Quantidade Shot 3
  Result := Result + '    [Canister4] AS COLORANTE_4,       ';
  Result := Result + '    [4-384/oz] AS QUANTIDADE_4,       ';  //Quantidade Shot 4
  Result := Result + '    [Canister5] AS COLORANTE_5,       ';
  Result := Result + '    [5-384/oz] AS QUANTIDADE_5        ';  //Quantidade Shot 5
  Result := Result + '  FROM                                ';
  Result := Result + '    [' + Tabelas[intTabela] + '$]              ';
  Result := Result + '  WHERE                               ';
  Result := Result + '    [Produto] <> ""                   ';

end;

procedure TGravandoExecucaoHydronorthImobiliariaCores.GravarRegistro(
  const qryOrigem: TDataSet; qryDestino: IDataSet; intEmbalagem: Integer; Tabela: String);
Var
  intContador: Integer;
  fltFator: Double;
begin
  qryDestino.Insert;
  qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('HYD_CADHYD', TAutcomTintaFactory.Get.GetCodEmp);
  qryDestino.FieldByName('HYD_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
  qryDestino.FieldByName('HYD_COLECA').AsString := qryOrigem.FieldByName('COLECAO').AsString;
  qryDestino.FieldByName('HYD_PRODUT').AsString := qryOrigem.FieldByName('PRODUTO').AsString;
  qryDestino.FieldByName('HYD_C_O_R_').AsString := qryOrigem.FieldByName('CODIGO').AsString;
  qryDestino.FieldByName('HYD_CORLON').AsString := qryOrigem.FieldByName('NOME_COR').AsString;
  qryDestino.FieldByName('HYD_BASE__').AsString := Trim(qryOrigem.FieldByName('CODBAS').AsString);
  qryDestino.FieldByName('HYD_CODEMB').AsString := GeraEmbalagem(intEmbalagem, Tabela);

  fltFator := fRetFatorEmbalagem(qryDestino.FieldByName('HYD_CODEMB').AsString);

  For intContador := 1 To 5 Do
  Begin

    If (qryOrigem.FieldByName('COLORANTE_' + IntToStr(intContador)).AsString = '0') Or
      (qryOrigem.FieldByName('QUANTIDADE_' + IntToStr(intContador)).AsFloat = 0) Then
      Break;

    qryDestino.FieldByName('HYD_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString :=
      qryOrigem.FieldByName('COLORANTE_' + IntToStr(intContador)).AsString;

    If TStrUtils.fEmptyStr(qryDestino.FieldByName('HYD_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString) Then
      qryDestino.FieldByName('HYD_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString := 'BWI';

    qryDestino.FieldByName('HYD_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat :=
      qryOrigem.FieldByName('QUANTIDADE_' + IntToStr(intContador)).AsFloat * 0.077 * fltFator;
  End;

  qryDestino.FieldByName('HYD_MD5KEY').AsString := GetMD5(qryDestino.FieldByName('HYD_COLECA').AsString +
                                                          qryDestino.FieldByName('HYD_PRODUT').AsString +
                                                          qryDestino.FieldByName('HYD_C_O_R_').AsString +
                                                          qryDestino.FieldByName('HYD_CORLON').AsString +
                                                          qryDestino.FieldByName('HYD_BASE__').AsString +
                                                          qryDestino.FieldByName('HYD_CODEMB').AsString);

  qryDestino.Post;


end;

procedure TGravandoExecucaoHydronorthImobiliariaCores.IsDeletarRegistros;
Var
  qryDelete: IDataSet;
begin
  qryDelete := TAutcomTintaFactory.Get.fGetDataSet;
  qryDelete.Close;
  qryDelete.SQL := '    DELETE FROM HYD_CADHYD        ';
  qryDelete.ExecSQL;
end;

procedure TGravandoExecucaoHydronorthImobiliariaCores.IsDeletarRegistrosDuplicados(
  Gravando: IGravando);
Var
  qryGen: IDataSet;
  qryMD5: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;

  qryGen.SQL := ' SELECT COUNT(*) AS QTD, ' +
                '        HYD_MD5KEY       ' +
                '   FROM HYD_CADHYD       ' +
                '  GROUP BY HYD_MD5KEY    ' +
                ' HAVING COUNT(*) > 1     ';

  qryGen.Open;

   If Not qryGen.IsEmpty Then
   Begin
     qryMD5 := TAutcomTintaFactory.Get.fGetDataSet;

     qryGen.First;

     Gravando.Texto := 'Excluindo fórmulas duplicadas da tabela HYD_CADHYD...';

     While Not qryGen.Eof Do
     Begin
       qryMd5.Close;
       qryMD5.SQL := '  DELETE FROM HYD_CADHYD WHERE HYD_MD5KEY = :MD5      ';
       qryMd5.SQL := qryMd5.SQL + ' LIMIT ' + IntToStr(qryGen.FieldByName('QTD').AsInteger - 1);
       qryMd5.ParamByName('MD5').AsString := qryGen.FieldByName('HYD_MD5KEY').AsString;
       qryMd5.ExecSQL;

       gravando.RegistrarProgresso(0, qryGen.RecNo, qryGen.RecordCount);

       qryGen.Next;
     End;
   End;
end;

function TGravandoExecucaoHydronorthImobiliariaCores.IsRegistroExistente(
  const qryOrigem: TDataSet; qryDestino: IDataSet;
  intUnidade: Integer; Tabela: String): Boolean;
begin
  Result := False;
end;

end.
