{*************************************************************************}
{* Classe responsável pela geração do cadastro de cores da tinta Grafftex *}
{**********************************************************************PH*}
unit untGravandoExecucaoGrafftexCores;

interface

uses
  untAbstractGravandoExecucaoGrafftex, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils;



type
  TGravandoExecucaoGrafftexCores = class(TAbstractGravandoExecucaoGrafftex)
  Private
    function fRetUnidade(fltVolume: Double): String;
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
    function GetSqlDestino(): string; override;
    function GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): string; override;
    procedure GravarRegistro(const qryOrigem: TDataSet; qryDestino: IDataSet); Override;
    function IsRegistroExiste(const qryOrigem: TDataSet; qryDestino: IDataSet): Boolean; Override;
  end;

Implementation

uses
  untFuncoesGenerica, untStrUtils, untDefinicaoTxtCampoTipo, untADOTxtFactory, untGenericDefinicaoTxtCampo, untGenericDefinicaoTxt,
    untIDefinicaoTxtCampo, untIDefinicaoTxt, untDefinicaoTxtCharacterSet;

{ TGravandoExecucaoGrafftexCores }


procedure TGravandoExecucaoGrafftexCores.Executar(const gravando: IGravando);
Var
  qryOrigem: TDataSet;
  qryDestino: IDataSet;
  intContador: Integer;
begin
  For intContador := 0 To stlArquivos.Count - 1 Do
  Begin
    Try
      Try
        Gravando.Texto := 'Verificando Path do arquivo...';

        If Not fValidarPath(intContador) Then
        Begin
          Gravando.Texto := Format('O arquivo [%s] não foi encontrado! Verifique as Configurações.', [AnsiReplaceStr(fGetPath(intContador), '"', '')]);
          Exit;
        End;

        If (Gravando.Status <> sgGravando) Then
          Exit;

        Gravando.Texto := 'Path verificado com sucesso...';
        Gravando.Texto := 'Verificando PROCOD...';
        TAutcomTintaFactory.Get.fInsereProCod('GRA_CADGRA');
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

function TGravandoExecucaoGrafftexCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;

function TGravandoExecucaoGrafftexCores.fRetUnidade(fltVolume: Double): String;
begin
  If fltVolume <= 1.000 Then
    Result := 'LT'
  Else If (fltVolume > 1.000) And (fltVolume <= 5.000) Then
    Result := 'GL'
  Else
    Result := 'LA';
end;

function TGravandoExecucaoGrafftexCores.GetSqlDestino: string;
begin
  Result := '  SELECT * FROM GRA_CADGRA     ';
end;

function TGravandoExecucaoGrafftexCores.GetSqlOrigem(
  const strNomeArquivo: string; const stlTabelas: TStrings): string;
begin
  Result := '';
  Result := Result + '  SELECT                          ';
  Result := Result + '    F.Cod_Cor AS CODIGO,          ';
  Result := Result + '    F.Desc_Cor AS DESCRI,         ';
  Result := Result + '    F.Volume AS VOLUME,           ';
  Result := Result + '    F.Colecao AS COLECAO,         ';
  Result := Result + '    F.Produto AS PRODUTO,         ';
  Result := Result + '    F.Desc_Base AS BASE,          ';
  Result := Result + '    F.Corante_1 AS COR_01,        ';
  Result := Result + '    F.Corante_2 AS COR_02,        ';
  Result := Result + '    F.Corante_3 AS COR_03,        ';
  Result := Result + '    F.Corante_4 AS COR_04,        ';
  Result := Result + '    F.Corante_5 AS COR_05,        ';
  Result := Result + '    F.Corante_6 AS COR_06,        ';
  Result := Result + '    F.Qtd_ml_1 AS QTD_01,         ';
  Result := Result + '    F.Qtd_ml_2 AS QTD_02,         ';
  Result := Result + '    F.Qtd_ml_3 AS QTD_03,         ';
  Result := Result + '    F.Qtd_ml_4 AS QTD_04,         ';
  Result := Result + '    F.Qtd_ml_5 AS QTD_05,         ';
  Result := Result + '    F.Qtd_ml_6 AS QTD_06          ';
  Result := Result + '  FROM                            ';
  Result := Result + '    [Sheet1$] AS F                ';
  Result := Result + '  WHERE                           ';
  Result := Result + '    F.Produto <> ""               ';
end;

procedure TGravandoExecucaoGrafftexCores.GravarRegistro(
  const qryOrigem: TDataSet; qryDestino: IDataSet);
Var
  intContador: Integer;
  strMd5: String;
  strQtd: String;
begin
  qryDestino.Insert;
  qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('GRA_CADGRA', TAutcomTintaFactory.Get.GetCodEmp);
  qryDestino.FieldByName('GRA_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
  qryDestino.FieldByName('GRA_CODIGO').AsString := qryOrigem.FieldByName('CODIGO').AsString;
  qryDestino.FieldByName('GRA_BASE__').AsString := qryOrigem.FieldByName('BASE').AsString;
  qryDestino.FieldByName('GRA_DESCRI').AsString := qryOrigem.FieldByName('DESCRI').AsString;
  qryDestino.FieldByName('GRA_NOME__').AsString := qryOrigem.FieldByName('DESCRI').AsString;
  qryDestino.FieldByName('GRA_PRODUT').AsString := qryOrigem.FieldByName('PRODUTO').AsString;
  qryDestino.FieldByName('GRA_COLECA').AsString := qryOrigem.FieldByName('COLECAO').AsString;
  qryDestino.FieldByName('GRA_CODUNI').AsString := fRetUnidade(qryOrigem.FieldByName('VOLUME').AsFloat);

  For intContador := 1 To 6 Do
  Begin

    If TStrUtils.fEmptyStr(qryOrigem.FieldByName('COR_' + TStrUtils.fStrZero(intContador, 2)).AsString) Then
      Break;

    strQtd := AnsiReplaceStr(qryOrigem.FieldByName('QTD_' + TStrUtils.fStrZero(intContador, 2)).AsString, '.', '');

    qryDestino.FieldByName('GRA_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString := qryOrigem.FieldByName('COR_' + TStrUtils.fStrZero(intContador, 2)).AsString;
    qryDestino.FieldByName('GRA_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat  := StrToFloat(strQtd);
  End;

  strMd5 := '';
  strMd5 := strMd5 + qryDestino.FieldByName('GRA_CODIGO').AsString;
  strMd5 := strMd5 + qryDestino.FieldByName('GRA_DESCRI').AsString;
  strMd5 := strMd5 + qryDestino.FieldByName('GRA_BASE__').AsString;
  strMd5 := strMd5 + qryDestino.FieldByName('GRA_PRODUT').AsString;
  strMd5 := strMd5 + qryDestino.FieldByName('GRA_CODUNI').AsString;
  strMd5 := strMd5 + qryDestino.FieldByName('GRA_COLECA').AsString;

  qryDestino.FieldByName('GRA_MD5KEY').AsString := GetMD5(strMd5);
  qryDestino.Post;
end;

function TGravandoExecucaoGrafftexCores.IsRegistroExiste(
  const qryOrigem: TDataSet; qryDestino: IDataSet): Boolean;
begin
  Result := False;

  If (qryOrigem.FieldByName('VOLUME').AsFloat) <= 0 Then
    Result := True;
end;

end.
