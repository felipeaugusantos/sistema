{**************************************************************************}
{* Classe responsável pela geração do cadastro de Montadoras da tinta KillingIndustrial *}
{***********************************************************************AC*}
unit untGravandoExecucaoKillingIndustrialCores;

interface

uses
  untAbstractGravandoExecucaoKillingIndustrial, untIGravando, SysUtils, untIDataSet, Uni,
  untAutcomTintaFactory, ADODB, untStatusGravando, ComObj, dialogs,Classes,
  DBFUniProvider, StrUtils,System.Variants;

type
  TGravandoExecucaoKillingIndustrialCores = class(TAbstractGravandoExecucaoKillingIndustrial)
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

uses
  untStrUtils, untFuncoesGenerica;

{ TGravandoExecucaoKillingIndustrialCores }

procedure TGravandoExecucaoKillingIndustrialCores.Executar(const gravando: IGravando);
Var
  qryUniCores: TUniQuery;
  qryCadCor: IDataSet;
  strSQL: String;
  intContador: Integer;
  strAntFormula: String;
  strProFormula: String;
  qryGen: IDataSet;
  strMd5: String;
begin
  Try
    Try
      Gravando.Texto := 'Validando Path...';
      strAntFormula := '';
      intContador := 0;

      If Not fValidaPath Then
      Begin
        Gravando.Texto := Format('O arquivo %s não foi encontrado! Rever configurações.', [AnsiReplaceStr(fGetPath, '"', '')]);
        Exit;
      End;

      Gravando.Texto := 'Carregando Dados...';
      strSQL := '';
      strSQL := strSQL + '  SELECT                            ';
      strSQL := strSQL + '    FF.COD_FORMULA AS FORMULA,      ';
      strSQL := strSQL + '    FF.COD_MP,                      ';
      strSQL := strSQL + '    FF.QTD AS QUANTIDADE,           ';
      strSQL := strSQL + '    FF.PERCENTUTAL AS PORQTD,       ';
      strSQL := strSQL + '    M.CODIGO_MP AS BASE,            ';
      strSQL := strSQL + '    F.VERSAO AS VERSAO,             ';
      strSQL := strSQL + '    P.COD_PROD AS PRODUTO,          ';
      strSQL := strSQL + '    P.NOME_COR AS NOMECOR,          ';
      strSQL := strSQL + '    P.COD_MONTADORA AS MONTADORA,   ';
      strSQL := strSQL + '    P.COD_LINHA AS LINHA,           ';
      strSQL := strSQL + '    P.ANO_COR AS ANOCOR,            ';
      strSQL := strSQL + '    P.DESCRICAO AS DESCRICAO,       ';
      strSQL := strSQL + '    S.CLIENTE AS SISTEM,            ';
      strSQL := strSQL + '    L.NOME AS DESLIN,               ';
      strSQL := strSQL + '    MM.NOME AS DESMON,              ';
      strSQL := strSQL + '    O.NOME AS ORIGEM                ';
      strSQL := strSQL + '  FROM                              ';
      strSQL := strSQL + '    FORMULACOES  FF                 ';
      strSQL := strSQL + '  INNER JOIN FORMULAS F ON                 ';
      strSQL := strSQL + '    FF.COD_FORMULA = F.CODIGO                     ';
      strSQL := strSQL + '  INNER JOIN MATERIAS_PRIMAS M ON          ';
      strSQL := strSQL + '    FF.COD_MP = M.CODIGO                          ';
      strSQL := strSQL + '  INNER JOIN PRODUTOS P ON                 ';
      strSQL := strSQL + '    F.COD_PROD = P.CODIGO                         ';
      strSQL := strSQL + '  INNER JOIN MONTADORAS MM ON              ';
      strSQL := strSQL + '    P.COD_MONTADORA = MM.CODIGO                   ';
      strSQL := strSQL + '  INNER JOIN LINHAS L ON                   ';
      strSQL := strSQL + '    P.COD_LINHA = L.CODIGO                        ';
      strSQL := strSQL + '  INNER JOIN SISTEMA  S ON                 ';
      strSQL := strSQL + '    P.COD_SISTEMA = S.CODIGO                      ';
      strSQL := strSQL + '  INNER JOIN ORIGEM O ON                   ';
      strSQL := strSQL + '    P.COD_ORIGEM = O.CODIGO                       ';
      strSQL := strSQL + '  ORDER BY FF.COD_FORMULA                  ';

      qryUniCores := TUniQuery.Create(Nil);
      qryUniCores.Connection := fConexaoKilling;
      qryUniCores.Close;
      qryUniCores.SQL.Clear;
      qryUniCores.SQL.Add(strSQL);
      qryUniCores.Open;

      Gravando.Texto := 'Deletando registros da tabela KIN_CADKIN...';
      qryCadCor := TAutcomTintaFactory.Get.fGetDataSet;
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadCor.SQL := '  DELETE FROM KIN_CADKIN    ';
      qryCadCor.ExecSQL;

      Gravando.Texto := 'Abrindo cadastros de Cores...';
      qryCadCor.Close;
      qryCadCor.SQL := '  SELECT * FROM KIN_CADKIN WHERE FALSE    ';
      qryCadCor.Open;

      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('KIN_CADKIN');
      Gravando.Texto := 'PROCOD verificado com sucesso...';

      If (Gravando.Status <> sgGravando) Then
        Exit;

      Gravando.Texto := Format('Processando Arquivo: [%s]', [AnsiReplaceStr(fGetPath, '"', '')]);
      Gravando.RegistrarProgresso(0, 0, 0);

      While Not qryUniCores.Eof Do
      Begin
        strProFormula := qryUniCores.FieldByName('FORMULA').AsString;

        If (TStrUtils.fEmptyStr(strAntFormula)) Or (strAntFormula <> strProFormula) Then
        Begin
          intContador := 1;
          strMd5 := '';
          strAntFormula := qryUniCores.FieldByName('FORMULA').AsString;

          qryCadCor.Insert;
          qryCadCor.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('KIN_CADKIN', TAutcomTintaFactory.Get.GetCodEmp);
          qryCadCor.FieldByName('KIN_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
          qryCadCor.FieldByName('KIN_CODIGO').AsString := qryUniCores.FieldByName('PRODUTO').AsString;
          qryCadCor.FieldByName('KIN_NOMCOR').AsString := qryUniCores.FieldByName('NOMECOR').AsString;
          qryCadCor.FieldByName('KIN_PRODUT').AsString := qryUniCores.FieldByName('PRODUTO').AsString;
          qryCadCor.FieldByName('KIN_SISTEM').AsString := qryUniCores.FieldByName('SISTEM').AsString;
          qryCadCor.FieldByName('KIN_ORIGEM').AsString := qryUniCores.FieldByName('ORIGEM').AsString;
          qryCadCor.FieldByName('KIN_CODMON').AsString := qryUniCores.FieldByName('MONTADORA').AsString;
          qryCadCor.FieldByName('KIN_LINHA_').AsString := qryUniCores.FieldByName('LINHA').AsString;
          qryCadCor.FieldByName('KIN_ANOCOR').AsString := qryUniCores.FieldByName('ANOCOR').AsString;
          qryCadCor.FieldByName('KIN_DESCRI').AsString := qryUniCores.FieldByName('DESCRICAO').AsString;
          qryCadCor.FieldByName('KIN_DESLIN').AsString := qryUniCores.FieldByName('DESLIN').AsString;
          qryCadCor.FieldByName('KIN_DESMON').AsString := qryUniCores.FieldByName('DESMON').AsString;
          qryCadCor.FieldByName('KIN_BASE' + TStrUtils.fStrZero(intContador, 2)).AsString := qryUniCores.FieldByName('BASE').AsString;
          qryCadCor.FieldByName('KIN_QTDB' + TStrUtils.fStrZero(intContador, 2)).AsFloat := qryUniCores.FieldByName('QUANTIDADE').AsFloat;
          strMd5 := strMd5 + qryCadCor.FieldByName('KIN_CODIGO').AsString;
          strMd5 := strMd5 + qryCadCor.FieldByName('KIN_NOMCOR').AsString;
          strMd5 := strMd5 + qryCadCor.FieldByName('KIN_PRODUT').AsString;
          strMd5 := strMd5 + qryCadCor.FieldByName('KIN_SISTEM').AsString;
          strMd5 := strMd5 + qryCadCor.FieldByName('KIN_ORIGEM').AsString;
          strMd5 := strMd5 + qryCadCor.FieldByName('KIN_BASE' + TStrUtils.fStrZero(intContador, 2)).AsString;
          strMd5 := strMd5 + AnsiReplaceStr(FormatFloat('0.00000', qryCadCor.FieldByName('KIN_QTDB' + TStrUtils.fStrZero(intContador, 2)).AsFloat), ',', '.');
          strMd5 := GetMD5(strMd5);
          qryCadCor.FieldByName('KIN_MD5KEY').AsString := strMd5;
          qryCadCor.Post;
        End
        Else
        Begin
          Inc(intContador);

          qryGen.Close;
          qryGen.SQL := '';
          qryGen.SQL := qryGen.SQL + '  SELECT            ';
          qryGen.SQL := qryGen.SQL + '    *               ';
          qryGen.SQL := qryGen.SQL + '  FROM              ';
          qryGen.SQL := qryGen.SQL + '    KIN_CADKIN      ';
          qryGen.SQL := qryGen.SQL + '  WHERE             ';
          qryGen.SQL := qryGen.SQL + '    KIN_MD5KEY = :MD5KEY      ';
          qryGen.ParamByName('MD5KEY').AsString := strMd5;
          qryGen.Open;

          qryGen.Edit;
          qryGen.FieldByName('KIN_BASE' + TStrUtils.fStrZero(intContador, 2)).AsString := qryUniCores.FieldByName('BASE').AsString;
          qryGen.FieldByName('KIN_QTDB' + TStrUtils.fStrZero(intContador, 2)).AsFloat := qryUniCores.FieldByName('QUANTIDADE').AsFloat;
          qryGen.Post;
        End;

        qryUniCores.Next;
        Gravando.RegistrarProgresso(0, qryUniCores.RecNo, qryUniCores.RecordCount);
      End;
    Except
      On E: Exception Do
      Begin
        Gravando.Cancelar;
        Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      End;
    End;
  Finally

  End;
End;

function TGravandoExecucaoKillingIndustrialCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;

end.
