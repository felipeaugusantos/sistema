{******************************************************************************}
{* Classe responsável pela geração do cadastro de ScriptAtualizacao da tinta suvinil *}
{***************************************************************************PH*}
unit untGravandoExecucaoSuvinilScriptAtualizacao;

interface

uses
  untAbstractGravandoExecucaoSuvinil, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, untStatusGravando, DateUtils, untStrUtils, StrUtils,
  untVariantUtils, Variants, UniClientDataSet, DB, Uni, Classes;

type
  TGravandoExecucaoSuvinilScriptAtualizacao = class(TAbstractGravandoExecucaoSuvinil)
  private
    intAutoIncrem: Integer;
    function fRetAutoincremMaximo: Integer;
    function fRetAutoincremMaximoMsg: Integer;
    function fExisteRegistroScript(intAutoIncrem: Integer): Boolean;
    function fExisteRegistroScriptMsg(intAutoIncrem: Integer): Boolean;
    function fCriaTabelaCopia: String;
    function fCriaTabelaCopiaMsg: String;
    procedure pInsereTabelaScript(qrySuvinil: IDataSet);
    procedure pInsereTabelaScriptMsg(qrySuvinil: IDataSet);
    procedure pDeleteTabelScript(qrySuvinil: IDataSet);
    procedure pDeleteTabelScriptMsg(qrySuvinil: IDataSet);
    function fInsertSUV(qrySuvinil: IDataSet): String;
    function fInsertSUVMsg(qrySuvinil: IDataSet): String;
    function fDeleteSUV(qrySuvinil: IDataSet): String;
    function fDeleteSUVMsg(qrySuvinil: IDataSet): String;
    procedure pExecutaTabelaScripts(const Gravando: IGravando);
    procedure pExecutaTabelaScriptsMsg(const Gravando: IGravando);
    function  fRetDataSeparada(Data: TDateTime): String;
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
    function fHabilitaOpcao(): Boolean; Override;
  end;

implementation

{ TGravandoExecucaoSuvinilCores }

procedure TGravandoExecucaoSuvinilScriptAtualizacao.Executar(const gravando: IGravando);
var
  qrySuvinil: IDataSet;
  qryGenerica: IDataSet;
begin
  Try
    Try
      intAutoIncrem := fRetAutoincremMaximo;
      Gravando.Texto := 'Verificando tabela original da Suvinil[SUV_CADSUV]';

      If Not TAutcomTintaFactory.Get.fTabelaExiste('SUV_CADSUV_ORIGINAL') Then
      Begin
        Gravando.Texto := 'A atualização do Script não podera ser feita pois não existe a copia original [SUV_CADSUV_ORIGINAL]...';
        Exit;
      End;

      Gravando.Texto := 'Verificado com sucesso...';

      Gravando.Texto := 'Carregando Dados...';

      If TAutcomTintaFactory.Get.fTabelaExiste('SUV_CADSUV_ORIGINAL' + fRetDataSeparada(Date)) Then
        TAutcomTintaFactory.Get.DropTable('SUV_CADSUV_ORIGINAL' + fRetDataSeparada(Date));


      qryGenerica := TAutcomTintaFactory.Get.fGetDataSet;
      qryGenerica.Close;
      qryGenerica.SQL := fCriaTabelaCopia;
      qryGenerica.ExecSQL;

      pExecutaTabelaScripts(Gravando);

      Gravando.Texto := 'Verificando tabela atual e original[SUV_CADSUV]...';

      qrySuvinil := TAutcomTintaFactory.Get.fGetDataSet;
      qrySuvinil.Close;
      qrySuvinil.SQL := ' SELECT * FROM SUV_CADSUV WHERE SUV_MD5KEY NOT IN (SELECT SUV_MD5KEY FROM SUV_CADSUV_ORIGINAL' + fRetDataSeparada(Date) + ');  ';
      qrySuvinil.Open;

      qryGenerica.Close;
      qryGenerica.SQL := '  SELECT * FROM SUV_CADSUV_ORIGINAL' + fRetDataSeparada(Date) + ' WHERE SUV_MD5KEY NOT IN (SELECT SUV_MD5KEY FROM SUV_CADSUV)  ';
      qryGenerica.Open;

      Gravando.Texto := 'Gerando Scripts de Atualizações da tabela atual e original[SUV_CADSUV]...';

      While Not qryGenerica.Eof Do
      Begin
        pDeleteTabelScript(qryGenerica);
        qryGenerica.Next;
        Gravando.RegistrarProgresso(0, qryGenerica.RecNo, qryGenerica.RecordCount);
      End;

      While Not qrySuvinil.Eof Do
      Begin
        pInsereTabelaScript(qrySuvinil);
        qrySuvinil.Next;
        Gravando.RegistrarProgresso(0, qrySuvinil.RecNo, qrySuvinil.RecordCount);
      End;

      Gravando.Texto := 'Verificando tabela original de mensagens da Suvinil[SUV_CADMSG]';

      If Not TAutcomTintaFactory.Get.fTabelaExiste('SUV_CADMSG_ORIGINAL') Then
      Begin
        Gravando.Texto := 'A atualização do Script não podera ser feita pois não existe a copia original [SUV_CADMSG_ORIGINAL]...';
        Exit;
      End;

      Gravando.Texto := 'Carregando Dados...';

      intAutoIncrem := fRetAutoincremMaximoMsg;

      qryGenerica.Close;
      qryGenerica.SQL := fCriaTabelaCopiaMsg;
      qryGenerica.ExecSQL;

      pExecutaTabelaScriptsMsg(Gravando);

      qrySuvinil.Close;
      qrySuvinil.SQL := ' SELECT * FROM SUV_CADMSG  ';
      qrySuvinil.Open;

      qryGenerica.Close;
      qryGenerica.SQL := '  SELECT * FROM SUV_CADMSG_ORIGINAL' + fRetDataSeparada(Date);
      qryGenerica.Open;

      Gravando.Texto := 'Gerando Scripts de Atualizações da tabela atual e original[SUV_CADMSG]...';

      While Not qryGenerica.Eof Do
      Begin
        If Not qrySuvinil.Locate('MSG_DESCRI;MSG_REFERE;MSG_UNIDAD;MSG_CODFML;MSG_NOMCOR;MSG_CODBAS;MSG_MENSAG', VarArrayOf([qryGenerica.FieldByName('MSG_DESCRI').AsString,
          qryGenerica.FieldByName('MSG_REFERE').AsString, qryGenerica.FieldByName('MSG_UNIDAD').AsString, qryGenerica.FieldByName('MSG_CODFML').AsString,
          qryGenerica.FieldByName('MSG_NOMCOR').AsString, qryGenerica.FieldByName('MSG_CODBAS').AsString, qryGenerica.FieldByName('MSG_MENSAG').AsString]), []) Then
        Begin
          pDeleteTabelScriptMsg(qryGenerica);
        End;

        qryGenerica.Next;
        Gravando.RegistrarProgresso(0, qryGenerica.RecNo, qryGenerica.RecordCount);
      End;

      qrySuvinil.First;
      qryGenerica.First;

      While Not qrySuvinil.Eof Do
      Begin
        If Not qryGenerica.Locate('MSG_DESCRI;MSG_REFERE;MSG_UNIDAD;MSG_CODFML;MSG_NOMCOR;MSG_CODBAS;MSG_MENSAG', VarArrayOf([qrySuvinil.FieldByName('MSG_DESCRI').AsString,
          qrySuvinil.FieldByName('MSG_REFERE').AsString, qrySuvinil.FieldByName('MSG_UNIDAD').AsString, qrySuvinil.FieldByName('MSG_CODFML').AsString,
          qrySuvinil.FieldByName('MSG_NOMCOR').AsString, qrySuvinil.FieldByName('MSG_CODBAS').AsString, qrySuvinil.FieldByName('MSG_MENSAG').AsString]), []) Then
        Begin
          pInsereTabelaScriptMsg(qrySuvinil);
        End;

        qrySuvinil.Next;
        Gravando.RegistrarProgresso(0, qrySuvinil.RecNo, qrySuvinil.RecordCount);
      End;
    Except
      On E: Exception Do
      Begin
        Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
        Gravando.Cancelar;
      End;
    End;
  Finally
    If TAutcomTintaFactory.Get.fTabelaExiste('SUV_CADSUV_ORIGINAL' + fRetDataSeparada(Date)) Then
      TAutcomTintaFactory.Get.DropTable('SUV_CADSUV_ORIGINAL' + fRetDataSeparada(Date));

    If TAutcomTintaFactory.Get.fTabelaExiste('SUV_CADMSG_ORIGINAL' + fRetDataSeparada(Date)) Then
      TAutcomTintaFactory.Get.DropTable('SUV_CADMSG_ORIGINAL' + fRetDataSeparada(Date));
  End;
end;

function TGravandoExecucaoSuvinilScriptAtualizacao.fCriaTabelaCopia: String;
begin
  Result := 'CREATE TABLE SUV_CADSUV_ORIGINAL' + fRetDataSeparada(Date) + ' ( ' +
            ' AUTOINCREM VARCHAR(20) NOT NULL,  ' +
            ' SUV_CODITE VARCHAR(5) DEFAULT NULL,  ' +
            ' SUV_CODEMP CHAR(3) DEFAULT NULL,  ' +
            ' SUV_DESCRI VARCHAR(60) DEFAULT NULL, ' +
            ' SUV_REFERE VARCHAR(35) DEFAULT NULL, ' +
            ' SUV_UNIDAD CHAR(4) DEFAULT NULL, ' +
            ' SUV_PREVEN DECIMAL(12,4) DEFAULT NULL, ' +
            ' SUV_PRECUS DECIMAL(12,4) DEFAULT NULL,  ' +
            ' SUV_FORM01 VARCHAR(6) DEFAULT NULL,  ' +
            ' SUV_QTDB01 DECIMAL(12,4) DEFAULT NULL,  ' +
            ' SUV_FORM02 VARCHAR(6) DEFAULT NULL,  ' +
            ' SUV_QTDB02 DECIMAL(12,4) DEFAULT NULL,  ' +
            ' SUV_FORM03 VARCHAR(6) DEFAULT NULL,  ' +
            ' SUV_QTDB03 DECIMAL(12,4) DEFAULT NULL,  ' +
            ' SUV_FORM04 VARCHAR(6) DEFAULT NULL,  ' +
            ' SUV_QTDB04 DECIMAL(12,4) DEFAULT NULL,  ' +
            ' SUV_FORM05 VARCHAR(6) DEFAULT NULL,  ' +
            ' SUV_QTDB05 DECIMAL(12,4) DEFAULT NULL,  ' +
            ' SUV_COLVEN DECIMAL(12,4) DEFAULT NULL,  ' +
            ' SUV_COLCUS DECIMAL(12,4) DEFAULT NULL,  ' +
            ' SUV_FORM06 VARCHAR(6) DEFAULT NULL,  ' +
            ' SUV_QTDB06 DECIMAL(12,4) DEFAULT NULL,  ' +
            ' SUV_FORM07 VARCHAR(6) DEFAULT NULL,  ' +
            ' SUV_QTDB07 DECIMAL(12,4) DEFAULT NULL,  ' +
            ' SUV_FORM08 VARCHAR(6) DEFAULT NULL,  ' +
            ' SUV_QTDB08 DECIMAL(12,4) DEFAULT NULL,  ' +
            ' SUV_FORM09 VARCHAR(6) DEFAULT NULL,  ' +
            ' SUV_QTDB09 DECIMAL(12,4) DEFAULT NULL,  ' +
            ' SUV_FORM10 VARCHAR(6) DEFAULT NULL,  ' +
            ' SUV_QTDB10 DECIMAL(12,4) DEFAULT NULL,  ' +
            ' SUV_FORM11 VARCHAR(6) DEFAULT NULL,  ' +
            ' SUV_QTDB11 DECIMAL(12,4) DEFAULT NULL,  ' +
            ' SUV_FORM12 VARCHAR(6) DEFAULT NULL,  ' +
            ' SUV_QTDB12 DECIMAL(12,4) DEFAULT NULL,  ' +
            ' SUV_FORM13 VARCHAR(6) DEFAULT NULL,  ' +
            ' SUV_QTDB13 DECIMAL(12,4) DEFAULT NULL,  ' +
            ' SUV_FORM14 VARCHAR(6) DEFAULT NULL,     ' +
            ' SUV_QTDB14 DECIMAL(12,4) DEFAULT NULL,  ' +
            ' SUV_FORM15 VARCHAR(6) DEFAULT NULL,     ' +
            ' SUV_QTDB15 DECIMAL(12,4) DEFAULT NULL,  ' +
            ' SUV_CODFML VARCHAR(10) DEFAULT NULL,  ' +
            ' SUV_CODBAS VARCHAR(10) DEFAULT NULL,  ' +
            ' SUV_CODUNI CHAR(2) DEFAULT NULL,  ' +
            ' SUV_NOMCOR VARCHAR(50) DEFAULT NULL,  ' +
            ' SUV_MD5KEY VARCHAR(32) DEFAULT NULL,  ' +
            ' SUV_ATIVAD CHAR(1) DEFAULT NULL,  ' +
            ' SUV_FORM16 VARCHAR(6) DEFAULT NULL,  ' +
            ' SUV_FORM17 VARCHAR(6) DEFAULT NULL,  ' +
            ' SUV_FORM18 VARCHAR(6) DEFAULT NULL,  ' +
            ' SUV_FORM19 VARCHAR(6) DEFAULT NULL,  ' +
            ' SUV_FORM20 VARCHAR(6) DEFAULT NULL,  ' +
            ' SUV_QTDB16 DECIMAL(12,4) DEFAULT NULL,  ' +
            ' SUV_QTDB17 DECIMAL(12,4) DEFAULT NULL,  ' +
            ' SUV_QTDB18 DECIMAL(12,4) DEFAULT NULL,  ' +
            ' SUV_QTDB19 DECIMAL(12,4) DEFAULT NULL,  ' +
            ' SUV_QTDB20 DECIMAL(12,4) DEFAULT NULL,  ' +
            ' SUV_DTACAD DATE DEFAULT NULL, ' +
            ' SUV_ACRMOB DECIMAL(12,4) DEFAULT NULL,  ' +
            ' SUV_R_G_B_ VARCHAR(6) DEFAULT NULL,   ' +
            ' SUV_TONALI VARCHAR(50) DEFAULT NULL,  ' +
            ' SUV_CORNOM VARCHAR(50) DEFAULT NULL,  ' +
            ' SUV_RED___ CHAR(3) DEFAULT NULL,  ' +
            ' SUV_GREEN_ CHAR(3) DEFAULT NULL,  ' +
            ' SUV_BLUE__ CHAR(3) DEFAULT NULL,  ' +
            ' PRIMARY KEY (AUTOINCREM),  ' +
            ' UNIQUE KEY UK_SUV_CADSUV_01 (SUV_MD5KEY),  ' +
            ' KEY IDX_SUV_CADSUV_01 (SUV_DESCRI),  ' +
            ' KEY IDX_SUV_CADSUV_03 (SUV_CODITE, SUV_REFERE),  ' +
            ' KEY IDX_SUV_CADSUV_04 (SUV_CODFML, SUV_CODBAS, SUV_CODUNI),  ' +
            ' KEY IDX_SUV_CADSUV_07 (SUV_CODBAS, SUV_CODFML, SUV_CODUNI, SUV_DESCRI, SUV_NOMCOR, SUV_REFERE),  ' +
            ' KEY IDX_SUV_CADSUV_08 (SUV_CODBAS, SUV_CODFML, SUV_CODUNI, SUV_DESCRI, SUV_REFERE),  ' +
            ' KEY IDX_SUV_CADSUV_10 (SUV_CODBAS, SUV_CODFML, SUV_CODUNI, SUV_NOMCOR, SUV_REFERE),  ' +
            ' KEY IDX_SUV_CADSUV_11 (SUV_CODBAS, SUV_CODFML, SUV_CODUNI, SUV_REFERE),  ' +
            ' KEY IDX_SUV_CADSUV_12 (SUV_NOMCOR, SUV_QTDB01, SUV_REFERE),  ' +
            ' KEY FK_SUV_CADSUV_02 (SUV_CODUNI),  ' +
            ' KEY FK_SUV_CADSUV_03 (SUV_UNIDAD),  ' +
            ' KEY FK_SUV_CADSUV_04 (SUV_CODEMP),  ' +
            ' KEY IDX_SUV_CADSUV_02 (AUTOINCREM), ' +
            ' KEY IDX_SUV_CADSUV_05 (SUV_REFERE)  ' +
          ') ENGINE=INNODB DEFAULT CHARSET=latin1;  ';

  Result := Result + ' INSERT INTO SUV_CADSUV_ORIGINAL' + fRetDataSeparada(Date) + ' SELECT * FROM SUV_CADSUV_ORIGINAL; ';
end;

function TGravandoExecucaoSuvinilScriptAtualizacao.fCriaTabelaCopiaMsg: String;
begin
  Result := 'CREATE TABLE SUV_CADMSG_ORIGINAL' + fRetDataSeparada(Date) + '( ' +
            'MSG_DESCRI VARCHAR(60) DEFAULT NULL,  ' +
            'MSG_REFERE VARCHAR(35) DEFAULT NULL,  ' +
            'MSG_UNIDAD CHAR(2) DEFAULT NULL,      ' +
            'MSG_CODFML VARCHAR(4) DEFAULT NULL,   ' +
            'MSG_NOMCOR VARCHAR(50) DEFAULT NULL,  ' +
            'MSG_CODBAS VARCHAR(10) DEFAULT NULL,  ' +
            'MSG_MENSAG TEXT,                      ' +
            'KEY IDX_NOVO_SUV_CADMSG_01 (MSG_DESCRI, MSG_REFERE, MSG_UNIDAD, MSG_CODFML, MSG_NOMCOR, MSG_CODBAS) ' +
            ') ENGINE=INNODB DEFAULT CHARSET=latin1; ';

  Result := Result + '  INSERT INTO SUV_CADMSG_ORIGINAL' + fRetDataSeparada(Date) + ' SELECT * FROM SUV_CADMSG_ORIGINAL; ';
end;

function TGravandoExecucaoSuvinilScriptAtualizacao.fDeleteSUV(qrySuvinil: IDataSet): String;
begin
  Result := ' DELETE FROM SUV_CADSUV WHERE SUV_MD5KEY = "' + qrySuvinil.FieldByName('SUV_MD5KEY').AsString + '";';
end;

function TGravandoExecucaoSuvinilScriptAtualizacao.fDeleteSUVMsg(
  qrySuvinil: IDataSet): String;
begin
  Result := 'DELETE FROM SUV_CADMSG WHERE MSG_DESCRI = "' + qrySuvinil.FieldByName('MSG_DESCRI').AsString + '" AND ' +
            'MSG_REFERE = "' + qrySuvinil.FieldByName('MSG_REFERE').AsString + '" AND ' +
            'MSG_UNIDAD = "' + qrySuvinil.FieldByName('MSG_UNIDAD').AsString + '" AND ' +
            'MSG_CODFML = "' + qrySuvinil.FieldByName('MSG_CODFML').AsString + '" AND ' +
            'MSG_NOMCOR = "' + qrySuvinil.FieldByName('MSG_NOMCOR').AsString + '" AND ' +
            'MSG_CODBAS = "' + qrySuvinil.FieldByName('MSG_CODBAS').AsString + '" AND ' +
            'MSG_MENSAG = "' + qrySuvinil.FieldByName('MSG_MENSAG').AsString + '";';
end;

function TGravandoExecucaoSuvinilScriptAtualizacao.fExisteRegistroScript(
  intAutoIncrem: Integer): Boolean;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.Close;
  qryGen.SQL := ' SELECT * FROM SUV_SCRIPT WHERE SCR_VERSAO = :VERSAO ';
  qryGen.ParamByName('VERSAO').AsString := '5_0_4' + fRetDataSeparada(Date) + '_' + TStrUtils.fStrZero(intAutoIncrem, 6);
  qryGen.Open;

  Result := qryGen.IsEmpty;
end;

function TGravandoExecucaoSuvinilScriptAtualizacao.fExisteRegistroScriptMsg(
  intAutoIncrem: Integer): Boolean;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.Close;
  qryGen.SQL := ' SELECT * FROM SUV_SCRMSG WHERE SCR_VERSAO = :VERSAO ';
  qryGen.ParamByName('VERSAO').AsString := '5_0_4' + fRetDataSeparada(Date) + '_' + TStrUtils.fStrZero(intAutoIncrem, 6);
  qryGen.Open;

  Result := qryGen.IsEmpty;
end;

function TGravandoExecucaoSuvinilScriptAtualizacao.fGetNomeGravacao: string;
begin
  Result := 'Scripts de Atualização';
end;

function TGravandoExecucaoSuvinilScriptAtualizacao.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TGravandoExecucaoSuvinilScriptAtualizacao.fInsertSUV(qrySuvinil: IDataSet): String;
begin
  Result := ' INSERT INTO SUV_CADSUV (AUTOINCREM, SUV_CODEMP, SUV_DESCRI, SUV_REFERE, SUV_UNIDAD, SUV_FORM01, SUV_QTDB01, SUV_FORM02, SUV_QTDB02, SUV_FORM03, SUV_QTDB03,' +
                                    ' SUV_FORM04, SUV_QTDB04, SUV_FORM05, SUV_QTDB05, SUV_FORM06, SUV_QTDB06, SUV_FORM07, SUV_QTDB07, SUV_FORM08, SUV_QTDB08, SUV_FORM09,' +
                                    ' SUV_QTDB09, SUV_FORM10, SUV_QTDB10, SUV_FORM11, SUV_QTDB11, SUV_FORM12, SUV_QTDB12, SUV_FORM13, SUV_QTDB13, SUV_FORM14, SUV_QTDB14,' +
                                    ' SUV_FORM15, SUV_QTDB15, SUV_CODFML, SUV_CODBAS, SUV_CODUNI, SUV_NOMCOR, SUV_MD5KEY, SUV_ATIVAD, SUV_FORM16, SUV_FORM17, SUV_FORM18,' +
                                    ' SUV_FORM19, SUV_FORM20, SUV_QTDB16, SUV_QTDB17, SUV_QTDB18, SUV_QTDB19, SUV_QTDB20, SUV_R_G_B_, SUV_TONALI, SUV_CORNOM, SUV_RED___,' +
                                    ' SUV_GREEN_, SUV_BLUE__)' + ' VALUES(' +
                                           ' "CHAVEUNICA",' +
                                           ' "' + TAutcomTintaFactory.Get.GetCodEmp + '",' +
                                           ' "' + qrySuvinil.FieldByName('SUV_DESCRI').AsString + '",' +
                                           ' "' + qrySuvinil.FieldByName('SUV_REFERE').AsString + '",' +
                                           ' "' + qrySuvinil.FieldByName('SUV_UNIDAD').AsString + '",' +
                                           ' "' + TVariantUtils.IfNull(qrySuvinil.FieldByName('SUV_FORM01').AsString, Null) + '",' +
                                           ' "' + TVariantUtils.IfNull(AnsiReplaceStr(qrySuvinil.FieldByName('SUV_QTDB01').AsString, ',', '.'), 0) + '",' +
                                           ' "' + TVariantUtils.IfNull(qrySuvinil.FieldByName('SUV_FORM02').AsString, Null) + '",' +
                                           ' "' + TVariantUtils.IfNull(AnsiReplaceStr(qrySuvinil.FieldByName('SUV_QTDB02').AsString, ',', '.'), 0) + '",' +
                                           ' "' + TVariantUtils.IfNull(qrySuvinil.FieldByName('SUV_FORM03').AsString, Null) + '",' +
                                           ' "' + TVariantUtils.IfNull(AnsiReplaceStr(qrySuvinil.FieldByName('SUV_QTDB03').AsString, ',', '.'), 0) + '",' +
                                           ' "' + TVariantUtils.IfNull(qrySuvinil.FieldByName('SUV_FORM04').AsString, Null) + '",' +
                                           ' "' + TVariantUtils.IfNull(AnsiReplaceStr(qrySuvinil.FieldByName('SUV_QTDB04').AsString, ',', '.'), 0) + '",' +
                                           ' "' + TVariantUtils.IfNull(qrySuvinil.FieldByName('SUV_FORM05').AsString, Null) + '",' +
                                           ' "' + TVariantUtils.IfNull(AnsiReplaceStr(qrySuvinil.FieldByName('SUV_QTDB05').AsString, ',', '.'), 0) + '",' +
                                           ' "' + TVariantUtils.IfNull(qrySuvinil.FieldByName('SUV_FORM06').AsString, Null) + '",' +
                                           ' "' + TVariantUtils.IfNull(AnsiReplaceStr(qrySuvinil.FieldByName('SUV_QTDB06').AsString, ',', '.'), 0) + '",' +
                                           ' "' + TVariantUtils.IfNull(qrySuvinil.FieldByName('SUV_FORM07').AsString, Null) + '",' +
                                           ' "' + TVariantUtils.IfNull(AnsiReplaceStr(qrySuvinil.FieldByName('SUV_QTDB07').AsString, ',', '.'), 0) + '",' +
                                           ' "' + TVariantUtils.IfNull(qrySuvinil.FieldByName('SUV_FORM08').AsString, Null) + '",' +
                                           ' "' + TVariantUtils.IfNull(AnsiReplaceStr(qrySuvinil.FieldByName('SUV_QTDB08').AsString, ',', '.'), 0) + '",' +
                                           ' "' + TVariantUtils.IfNull(qrySuvinil.FieldByName('SUV_FORM09').AsString, Null) + '",' +
                                           ' "' + TVariantUtils.IfNull(AnsiReplaceStr(qrySuvinil.FieldByName('SUV_QTDB09').AsString, ',', '.'), 0) + '",' +
                                           ' "' + TVariantUtils.IfNull(qrySuvinil.FieldByName('SUV_FORM10').AsString, Null) + '",' +
                                           ' "' + TVariantUtils.IfNull(AnsiReplaceStr(qrySuvinil.FieldByName('SUV_QTDB10').AsString, ',', '.'), 0) + '",' +
                                           ' "' + TVariantUtils.IfNull(qrySuvinil.FieldByName('SUV_FORM11').AsString, Null) + '",' +
                                           ' "' + TVariantUtils.IfNull(AnsiReplaceStr(qrySuvinil.FieldByName('SUV_QTDB11').AsString, ',', '.'), 0) + '",' +
                                           ' "' + TVariantUtils.IfNull(qrySuvinil.FieldByName('SUV_FORM12').AsString, Null) + '",' +
                                           ' "' + TVariantUtils.IfNull(AnsiReplaceStr(qrySuvinil.FieldByName('SUV_QTDB12').AsString, ',', '.'), 0) + '",' +
                                           ' "' + TVariantUtils.IfNull(qrySuvinil.FieldByName('SUV_FORM13').AsString, Null) + '",' +
                                           ' "' + TVariantUtils.IfNull(AnsiReplaceStr(qrySuvinil.FieldByName('SUV_QTDB13').AsString, ',', '.'), 0) + '",' +
                                           ' "' + TVariantUtils.IfNull(qrySuvinil.FieldByName('SUV_FORM14').AsString, Null) + '",' +
                                           ' "' + TVariantUtils.IfNull(AnsiReplaceStr(qrySuvinil.FieldByName('SUV_QTDB14').AsString, ',', '.'), 0) + '",' +
                                           ' "' + TVariantUtils.IfNull(qrySuvinil.FieldByName('SUV_FORM15').AsString, Null) + '",' +
                                           ' "' + TVariantUtils.IfNull(AnsiReplaceStr(qrySuvinil.FieldByName('SUV_QTDB15').AsString, ',', '.'), 0) + '",' +
                                           ' "' + qrySuvinil.FieldByName('SUV_CODFML').AsString + '",' +
                                           ' "' + qrySuvinil.FieldByName('SUV_CODBAS').AsString + '",' +
                                           ' "' + qrySuvinil.FieldByName('SUV_CODUNI').AsString + '",' +
                                           ' "' + qrySuvinil.FieldByName('SUV_NOMCOR').AsString + '",' +
                                           ' "' + qrySuvinil.FieldByName('SUV_MD5KEY').AsString + '",' +
                                           ' "' + qrySuvinil.FieldByName('SUV_ATIVAD').AsString + '",' +
                                           ' "' + TVariantUtils.IfNull(qrySuvinil.FieldByName('SUV_FORM16').AsString, Null) + '",' +
                                           ' "' + TVariantUtils.IfNull(qrySuvinil.FieldByName('SUV_FORM17').AsString, Null) + '",' +
                                           ' "' + TVariantUtils.IfNull(qrySuvinil.FieldByName('SUV_FORM18').AsString, Null) + '",' +
                                           ' "' + TVariantUtils.IfNull(qrySuvinil.FieldByName('SUV_FORM19').AsString, Null) + '",' +
                                           ' "' + TVariantUtils.IfNull(qrySuvinil.FieldByName('SUV_FORM20').AsString, Null) + '",' +
                                           ' "' + TVariantUtils.IfNull(AnsiReplaceStr(qrySuvinil.FieldByName('SUV_QTDB16').AsString, ',', '.'), 0) + '",' +
                                           ' "' + TVariantUtils.IfNull(AnsiReplaceStr(qrySuvinil.FieldByName('SUV_QTDB17').AsString, ',', '.'), 0) + '",' +
                                           ' "' + TVariantUtils.IfNull(AnsiReplaceStr(qrySuvinil.FieldByName('SUV_QTDB18').AsString, ',', '.'), 0) + '",' +
                                           ' "' + TVariantUtils.IfNull(AnsiReplaceStr(qrySuvinil.FieldByName('SUV_QTDB19').AsString, ',', '.'), 0) + '",' +
                                           ' "' + TVariantUtils.IfNull(AnsiReplaceStr(qrySuvinil.FieldByName('SUV_QTDB20').AsString, ',', '.'), 0) + '",' +
                                           ' "' + qrySuvinil.FieldByName('SUV_R_G_B_').AsString + '",' +
                                           ' "' + qrySuvinil.FieldByName('SUV_TONALI').AsString + '",' +
                                           ' "' + qrySuvinil.FieldByName('SUV_CORNOM').AsString + '",' +
                                           ' "' + qrySuvinil.FieldByName('SUV_RED___').AsString + '",' +
                                           ' "' + qrySuvinil.FieldByName('SUV_GREEN_').AsString + '",' +
                                           ' "' + qrySuvinil.FieldByName('SUV_BLUE__').AsString + '"); ';
end;

function TGravandoExecucaoSuvinilScriptAtualizacao.fInsertSUVMsg(
  qrySuvinil: IDataSet): String;
begin
  Result := 'INSERT INTO SUV_CADMSG(MSG_DESCRI, MSG_REFERE, MSG_UNIDAD, MSG_CODFML, MSG_NOMCOR, MSG_CODBAS, MSG_MENSAG) ' +
            'VALUES("' + qrySuvinil.FieldByName('MSG_DESCRI').AsString + '", ' +
                   '"' + qrySuvinil.FieldByName('MSG_REFERE').AsString + '", ' +
                   '"' + qrySuvinil.FieldByName('MSG_UNIDAD').AsString + '", ' +
                   '"' + qrySuvinil.FieldByName('MSG_CODFML').AsString + '", ' +
                   '"' + qrySuvinil.FieldByName('MSG_NOMCOR').AsString + '", ' +
                   '"' + qrySuvinil.FieldByName('MSG_CODBAS').AsString + '", ' +
                   '"' + qrySuvinil.FieldByName('MSG_MENSAG').AsString + '");';
end;

function TGravandoExecucaoSuvinilScriptAtualizacao.fRetAutoincremMaximo: Integer;
begin
  Result := 0;

  Repeat
    Inc(Result);
  Until (fExisteRegistroScript(Result));
end;

function TGravandoExecucaoSuvinilScriptAtualizacao.fRetAutoincremMaximoMsg: Integer;
begin
  Result := 0;

  Repeat
    Inc(Result);
  Until (fExisteRegistroScriptMsg(Result));
end;

function TGravandoExecucaoSuvinilScriptAtualizacao.fRetDataSeparada(Data: TDateTime): String;
begin
  Result := '_' + FormatDateTime('yyyy', Data) + '_' + FormatDateTime('mm', Data) + '_' +  FormatDateTime('dd', Data);
end;

procedure TGravandoExecucaoSuvinilScriptAtualizacao.pDeleteTabelScript(qrySuvinil: IDataSet);
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT * FROM SUV_SCRIPT    ';
  qryGen.Open;

  qryGen.Insert;
  qryGen.FieldByName('SCR_VERSAO').AsString := '5_0_4' + fRetDataSeparada(Date) + '_' + TStrUtils.fStrZero(intAutoIncrem, 6);
  qryGen.FieldByName('SCR_OCORRE').AsDate   :=  TAutcomTintaFactory.Get.fNow();
  qryGen.FieldByName('SCR_COMAND').AsString :=  fDeleteSUV(qrySuvinil);
  qryGen.Post;

  Inc(intAutoIncrem);
end;

procedure TGravandoExecucaoSuvinilScriptAtualizacao.pDeleteTabelScriptMsg(
  qrySuvinil: IDataSet);
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT * FROM SUV_SCRMSG    ';
  qryGen.Open;

  qryGen.Insert;
  qryGen.FieldByName('SCR_VERSAO').AsString := '5_0_4' + fRetDataSeparada(Date) + '_' + TStrUtils.fStrZero(intAutoIncrem, 6);
  qryGen.FieldByName('SCR_OCORRE').AsDate   :=  TAutcomTintaFactory.Get.fNow();
  qryGen.FieldByName('SCR_COMAND').AsString :=  fDeleteSUVMsg(qrySuvinil);
  qryGen.Post;

  Inc(intAutoIncrem);
end;

procedure TGravandoExecucaoSuvinilScriptAtualizacao.pExecutaTabelaScripts(const Gravando: IGravando);
Var
  qryExecut,
  qryScript: IDataSet;
  intContador: Integer;
begin
  Gravando.Texto := 'Verificando tabela de scripts[SUV_CADSUV]...';
  intContador := 1;

  qryScript := TAutcomTintaFactory.Get.fGetDataSet;
  qryExecut := TAutcomTintaFactory.Get.fGetDataSet;
  qryScript.SQL := '  SELECT * FROM SUV_SCRIPT  ORDER BY SCR_VERSAO  ';
  qryScript.Open;

  Gravando.Texto := 'Executando scripts de atualizações...';

  While Not qryScript.Eof Do
  Begin
    qryExecut.Close;
    qryExecut.SQL := AnsiReplaceStr(qryScript.FieldByName('SCR_COMAND').AsString, 'SUV_CADSUV', 'SUV_CADSUV_ORIGINAL' + fRetDataSeparada(Date));
    qryExecut.SQL := AnsiReplaceStr(qryExecut.SQL, 'CHAVEUNICA', 'CHAVEUNICA' + IntToStr(intContador));
    qryExecut.ExecSQL;

    qryScript.Next;
    Gravando.RegistrarProgresso(0, qryScript.RecNo, qryScript.RecordCount);
    Inc(intContador);
  End;
end;

procedure TGravandoExecucaoSuvinilScriptAtualizacao.pExecutaTabelaScriptsMsg(
  const Gravando: IGravando);
Var
  qryExecut,
  qryScript: IDataSet;
begin
  Gravando.Texto := 'Verificando tabela de scripts[SUV_CADMSG]...';

  qryScript := TAutcomTintaFactory.Get.fGetDataSet;
  qryExecut := TAutcomTintaFactory.Get.fGetDataSet;
  qryScript.SQL := '  SELECT * FROM SUV_SCRMSG  ORDER BY SCR_VERSAO  ';
  qryScript.Open;

  Gravando.Texto := 'Executando scripts de atualizações...';

  While Not qryScript.Eof Do
  Begin
    qryExecut.Close;
    qryExecut.SQL := AnsiReplaceStr(qryScript.FieldByName('SCR_COMAND').AsString, 'SUV_CADMSG', 'SUV_CADMSG_ORIGINAL' + fRetDataSeparada(Date));
    qryExecut.ExecSQL;

    qryScript.Next;
    Gravando.RegistrarProgresso(0, qryScript.RecNo, qryScript.RecordCount);
  End;
end;

procedure TGravandoExecucaoSuvinilScriptAtualizacao.pInsereTabelaScript(qrySuvinil: IDataSet);
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT * FROM SUV_SCRIPT    ';
  qryGen.Open;

  qryGen.Insert;
  qryGen.FieldByName('SCR_VERSAO').AsString := '5_0_4' + fRetDataSeparada(Date) + '_' + TStrUtils.fStrZero(intAutoIncrem, 6);
  qryGen.FieldByName('SCR_OCORRE').AsDate   :=  TAutcomTintaFactory.Get.fNow();
  qryGen.FieldByName('SCR_COMAND').AsString :=  fInsertSUV(qrySuvinil);
  qryGen.Post;

  Inc(intAutoIncrem);
end;

procedure TGravandoExecucaoSuvinilScriptAtualizacao.pInsereTabelaScriptMsg(
  qrySuvinil: IDataSet);
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT * FROM SUV_SCRMSG    ';
  qryGen.Open;

  qryGen.Insert;
  qryGen.FieldByName('SCR_VERSAO').AsString := '5_0_4' + fRetDataSeparada(Date) + '_' + TStrUtils.fStrZero(intAutoIncrem, 6);
  qryGen.FieldByName('SCR_OCORRE').AsDate   :=  TAutcomTintaFactory.Get.fNow();
  qryGen.FieldByName('SCR_COMAND').AsString :=  fInsertSUVMsg(qrySuvinil);
  qryGen.Post;

  Inc(intAutoIncrem);
end;

end.

