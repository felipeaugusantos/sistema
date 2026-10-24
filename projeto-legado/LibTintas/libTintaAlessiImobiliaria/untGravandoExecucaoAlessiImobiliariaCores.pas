{************************************************************************************}
{* Classe responsável pela geração do cadastro de cores da tinta Alessi Imobiliaria *}
{*********************************************************************************AC*}
unit untGravandoExecucaoAlessiImobiliariaCores;

interface

uses
  untAbstractGravandoExecucaoAlessiImobiliaria, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, untStrUtils, untStatusGravando, DB, untAbstractCriadorTabela,
  StrUtils, Classes, Math;

type
  TGravandoExecucaoAlessiImobiliariaCores = class(TAbstractGravandoExecucaoAlessiImobiliaria)
  private
    intTabela: Integer;
    function fRetTabela(intContador: Integer): String;
    function fRetEmbalagem(intContador: Integer): String;
    function IsRegistroExistente(const qryOrigem: TDataSet; qryDestino: IDataSet): Boolean;
    procedure GravarRegistro(const qryOrigem: TDataSet; qryDestino: IDataSet);
    procedure LimparTabelas;

    procedure MlParaOnca(fltMl: Double; var intParteInteira: Integer; var fltParteFracao: Double);
    function fRetCodUnidade(strEmbalagem: String): String;
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
    function GetSqlDestino(): string; override;
    function GetSqlOrigem(const strNomeArquivo: string;
      const stlTabelas: TStrings): string; override;
    function GetDataSetDestino(): IDataSet; override;
  end;

implementation

uses
  untCriadorTabelas, untFuncoesGenerica;

{ TGravandoExecucaoAlessiImobiliariaCores }

procedure TGravandoExecucaoAlessiImobiliariaCores.LimparTabelas;
var
  qryGen: IDataSet;
begin
  qryGen := nil;
  Try
    Try
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      qryGen.SQL := 'TRUNCATE TABLE ALE_CADALE';
      qryGen.ExecSQL;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally

  End;
end;

procedure TGravandoExecucaoAlessiImobiliariaCores.Executar(const gravando: IGravando);
var
  qryOrigem: TDataSet;
  qryDestino: IDataSet;
  iRecordCount: Integer;
  intContador: Integer;
begin
  Try
    Try
      gravando.Texto := 'Limpando tabela de formulação...';
      LimparTabelas;
      gravando.Texto := 'Tabela limpa com sucesso...';

      gravando.Texto := 'Verificando path dos arquivos...';

      if not FileExists(AnsiReplaceStr(fGetNomeArquivo, '"', '')) then
      begin
        gravando.Texto := Format('O arquivo [%s] não existe, ou não foi encontrado!', [AnsiReplaceStr(fGetNomeArquivo, '"', '')]);
        gravando.Cancelar;
      end;

      if gravando.Status <> sgGravando then
      begin
        Exit;
      end;

      gravando.Texto := 'Path validado com sucesso...';

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('ALE_CADALE', False);
      gravando.Texto := 'PROCOD verificado com sucesso!';

      For intContador := 1 To 5 Do
      Begin
        intTabela := intContador;
        gravando.Texto := 'Carregando dados: ' + fRetTabela(intContador);

        CarregarDados(gravando, qryOrigem, AnsiReplaceStr(fGetNomeArquivo, '"', ''), qryDestino);

        if gravando.Status <> sgGravando then
        begin
          Exit;
        end;

        gravando.Texto := 'Dados carregados com sucesso...';

        gravando.Texto := Format('Processando arquivo [%s]', [AnsiReplaceStr(fGetNomeArquivo, '"', '')]);
        gravando.RegistrarProgresso(0, 0, 0);

        qryOrigem.First;
        iRecordCount := qryOrigem.RecordCount;
        while (not qryOrigem.Eof) and (gravando.Status = sgGravando) do
        begin
          Try
            Try

              if gravando.Status <> sgGravando then
              begin
                Exit;
              end;

              if not IsRegistroExistente(qryOrigem, qryDestino) then
              begin
                GravarRegistro(qryOrigem, qryDestino);
              end;

            Except
              on E: Exception do
              begin
                gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
              end;
            End;
          Finally
            qryOrigem.Next;
            gravando.RegistrarProgresso(1, qryOrigem.RecNo, iRecordCount);
          End;
        end;

        If Assigned(qryOrigem) Then
          FreeAndNil(qryOrigem);
      End;
    Except
      on E: Exception do
      begin
        gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      end;
    End;
  Finally
    //
  End;
end;

function TGravandoExecucaoAlessiImobiliariaCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;

function TGravandoExecucaoAlessiImobiliariaCores.GetDataSetDestino: IDataSet;
begin
  Result := TAutcomTintaFactory.Get.fGetDataSet;
end;

function TGravandoExecucaoAlessiImobiliariaCores.GetSqlDestino: string;
begin
  Result := TAutcomTintaFactory.Get.GetInsert('ALE_CADALE');
end;

function TGravandoExecucaoAlessiImobiliariaCores.GetSqlOrigem(
  const strNomeArquivo: string; const stlTabelas: TStrings): string;
begin
  Result :=
    ' SELECT                         ' +
    '     F.[COLECAO]                ' +
    '   , F.[PRODUTO]                ' +
    '	, F.[BASE]                     ' +
    '   , F.[CODIGO_FORMULA]         ' +
    '	, F.[NOME_FORMULA]             ' +
    '	, F.[CORANTE_1]                ' +
    '	, F.[ML_1]                     ' +
    '	, F.[CORANTE_2]                ' +
    '	, F.[ML_2]                     ' +
    '	, F.[CORANTE_3]                ' +
    '	, F.[ML_3]                     ' +
    '	, F.[CORANTE_4]                ' +
    '	, F.[ML_4]                     ' +
    '	, F.[CORANTE_5]                ' +
    '	, F.[ML_5]                     ' +
    ' , B.[NOME EMBALAGEM]                ' +
    ' FROM                           ' +
    '   ' + fRetTabela(intTabela) +  ' AS F ' +
    '   INNER JOIN [BASES$] AS B     ' +
    '     ON F.PRODUTO = B.[NOME PRODUTO] ' +
    '     AND F.BASE = B.[NOME BASE]      ' +
    ' WHERE B.[NOME EMBALAGEM] = "' + fRetEmbalagem(intTabela) + '" ';
end;

procedure TGravandoExecucaoAlessiImobiliariaCores.GravarRegistro(const qryOrigem: TDataSet; qryDestino: IDataSet);
var
  intCont: Integer;
  strMd5: String;
  intParteInteira: Integer;
  fltParteFracao: Double;
begin
  qryDestino.SQL := GetSqlDestino;

  qryDestino.ParamByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('ALE_CADALE', TAutcomTintaFactory.Get.GetCodEmp);
  qryDestino.ParamByName('ALE_COLECA').AsString := LimpaTexto(qryOrigem.FieldByName('COLECAO').AsString);
  qryDestino.ParamByName('ALE_PRODUT').AsString := LimpaTexto(qryOrigem.FieldByName('PRODUTO').AsString);
  qryDestino.ParamByName('ALE_BASE__').AsString := LimpaTexto(qryOrigem.FieldByName('BASE').AsString);
  qryDestino.ParamByName('ALE_NOMCOR').AsString := LimpaTexto(qryOrigem.FieldByName('CODIGO_FORMULA').AsString);
  qryDestino.ParamByName('ALE_NOMLON').AsString := LimpaTexto(qryOrigem.FieldByName('NOME_FORMULA').AsString);
  qryDestino.ParamByName('ALE_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
  qryDestino.ParamByName('ALE_EMBALA').AsString := LimpaTexto(qryOrigem.FieldByName('NOME EMBALAGEM').AsString);
  qryDestino.ParamByName('ALE_CODUNI').AsString := fRetCodUnidade(LimpaTexto(qryOrigem.FieldByName('NOME EMBALAGEM').AsString));
  qryDestino.ParamByName('ALE_DTACAD').AsDateTime := Date;

  strMd5 := '';

  for intCont := 1 to 5 do
  begin
    if TAutcomTintaFactory.Get.fStrToFloat(qryOrigem.FieldByName('ML_' + IntToStr(intCont)).AsString) <= 0 then
      Break;

    MlParaOnca(qryOrigem.FieldByName('ML_' + IntToStr(intCont)).AsFloat, intParteInteira, fltParteFracao);

    qryDestino.ParamByName('ALE_CODC' + TStrUtils.fStrZero(intCont, 2)).AsString  := LimpaTexto(qryOrigem.FieldByName('CORANTE_' + IntToStr(intCont)).AsString);
    qryDestino.ParamByName('ALE_QTOZ' + TStrUtils.fStrZero(intCont, 2)).AsInteger := intParteInteira;
    qryDestino.ParamByName('ALE_QSHO' + TStrUtils.fStrZero(intCont, 2)).AsFloat   := RoundTo(fltParteFracao,-2);

    strMd5 := strMd5 + qryDestino.ParamByName('ALE_CODC' + TStrUtils.fStrZero(intCont, 2)).AsString +
                IntToStr(qryDestino.ParamByName('ALE_QTOZ' + TStrUtils.fStrZero(intCont, 2)).AsInteger) +
              FloatToStr(qryDestino.ParamByName('ALE_QSHO' + TStrUtils.fStrZero(intCont, 2)).AsFloat);
  end;

  qryDestino.ParamByName('ALE_MD5KEY').AsString := GetMD5(qryDestino.ParamByName('ALE_COLECA').AsString +
                                                          qryDestino.ParamByName('ALE_PRODUT').AsString +
                                                          qryDestino.ParamByName('ALE_BASE__').AsString +
                                                          qryDestino.ParamByName('ALE_NOMCOR').AsString +
                                                          qryDestino.ParamByName('ALE_NOMLON').AsString +
                                                          qryDestino.ParamByName('ALE_EMBALA').AsString +
                                                          strMd5);

  qryDestino.ParamByName('ALE_ATIVAD').AsString := 'S';

  qryDestino.ExecSQL;
end;

function TGravandoExecucaoAlessiImobiliariaCores.IsRegistroExistente(
  const qryOrigem: TDataSet; qryDestino: IDataSet): Boolean;
begin
  Result := False;
end;

procedure TGravandoExecucaoAlessiImobiliariaCores.MlParaOnca(fltMl: Double;
  var intParteInteira: Integer; var fltParteFracao: Double);
var
  fltCalculo: Double;
begin
  fltCalculo := ((fltMl / 48) / 0.616125);
  intParteInteira := Trunc(fltCalculo);
  fltParteFracao := TAutcomTintaFactory.Get.fStrToFloat(FormatFloat('0.00', (fltCalculo - intParteInteira) * 48));
end;

function TGravandoExecucaoAlessiImobiliariaCores.fRetCodUnidade(strEmbalagem: String): String;
begin
  Result := 'LT';

  if ((strEmbalagem =  'GALAO') Or (strEmbalagem =  '5KG')Or (strEmbalagem =  '4.4 KG')) Then
    Result := 'GL'
  else if ((strEmbalagem =  'LATA') Or (strEmbalagem =  '25KG')Or (strEmbalagem =  '22 KG')) Then
    Result := 'LA'
  else if (strEmbalagem =  'QUARTO') Then
    Result := 'QT';
end;

function TGravandoExecucaoAlessiImobiliariaCores.fRetEmbalagem(
  intContador: Integer): String;
begin
  If intContador = 1 Then
    Result := 'QUARTO'
  Else If intContador = 2 Then
    Result := 'GALÃO'
  Else If intContador = 3 Then
    Result := 'LATA'
  Else If intContador = 4 Then
    Result := '4.4 KG'
  Else
    Result := '22 KG';
end;

function TGravandoExecucaoAlessiImobiliariaCores.fRetTabela(
  intContador: Integer): String;
begin
  If intContador = 1 Then
    Result := '[F.QUARTO$]'
  Else If intContador = 2 Then
    Result := '[F.GALAO$]'
  Else If intContador = 3 Then
    Result := '[F.LATA$]'
  Else If intContador = 4 Then
    Result := '[F.4.4KG$]'
  Else
    Result := '[F.22KG$]';
end;

end.
