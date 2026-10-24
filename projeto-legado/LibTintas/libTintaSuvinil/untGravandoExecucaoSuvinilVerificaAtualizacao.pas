{******************************************************************************}
{* Classe responsável pela geração do cadastro de VerificaAtualizacao da tinta suvinil *}
{***************************************************************************PH*}
unit untGravandoExecucaoSuvinilVerificaAtualizacao;

interface

uses
  untAbstractGravandoExecucaoSuvinil, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, untStatusGravando, DateUtils, untStrUtils, StrUtils,
  untVariantUtils, Variants, UniClientDataSet, DB, Uni;

type
  TGravandoExecucaoSuvinilVerificaAtualizacao = class(TAbstractGravandoExecucaoSuvinil)
  private
    function fCriaTabelaCopia(): String;
    function fCriaTabelaCopiaMsg(): String;
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

procedure TGravandoExecucaoSuvinilVerificaAtualizacao.Executar(const gravando: IGravando);
var
  qrySuvinil: IDataSet;
  qryGenerica: IDataSet;
  blnDiverMsg: Boolean;
begin
  Try
    Try
      blnDiverMsg := True;
      Gravando.Texto := 'Verificando tabela original da Suvinil[SUV_CADSUV]...';

      If Not TAutcomTintaFactory.Get.fTabelaExiste('SUV_CADSUV_ORIGINAL') Then
      Begin
        Gravando.Texto := 'A verificação do Script não podera ser feita pois não existe a copia original [SUV_CADSUV_ORIGINAL]...';
        Exit;
      End;

      Gravando.Texto := 'Carregando Dados...';

      If TAutcomTintaFactory.Get.fTabelaExiste('SUV_CADSUV_ORIGINAL' + fRetDataSeparada(Date)) Then
        TAutcomTintaFactory.Get.DropTable('SUV_CADSUV_ORIGINAL' + fRetDataSeparada(Date));


      qryGenerica := TAutcomTintaFactory.Get.fGetDataSet;
      qryGenerica.Close;
      qryGenerica.SQL := fCriaTabelaCopia();
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

      If qrySuvinil.IsEmpty And qryGenerica.IsEmpty Then
      Begin
        Gravando.Texto := 'Não existe diferença entre as tabelas[SUV_CADSUV]...';
        Gravando.Texto := 'Verificado com sucesso[SUV_CADSUV]]...';
      End
      Else
      Begin
        Gravando.Texto := 'Existe diferença na atualização de script, verificar o script de atualização[SUV_CADSUV]...';
      End;

      Gravando.Texto := 'Verificando tabela original de mensagens da Suvinil[SUV_CADMSG]';

      If Not TAutcomTintaFactory.Get.fTabelaExiste('SUV_CADMSG_ORIGINAL') Then
      Begin
        Gravando.Texto := 'A verificação do Script não podera ser feita pois não existe a copia original [SUV_CADMSG_ORIGINAL]...';
        Exit;
      End;

      Gravando.Texto := 'Carregando Dados...';

      qryGenerica.Close;
      qryGenerica.SQL := fCriaTabelaCopiaMsg();
      qryGenerica.ExecSQL;

      pExecutaTabelaScriptsMsg(Gravando);

      Gravando.Texto := 'Verificando tabela atual e original[SUV_CADMSG]...';

      qrySuvinil.Close;
      qrySuvinil.SQL := '  SELECT * FROM SUV_CADMSG  ';
      qrySuvinil.Open;

      qryGenerica.Close;
      qryGenerica.SQL := '  SELECT * FROM SUV_CADMSG_ORIGINAL' + fRetDataSeparada(Date);
      qryGenerica.Open;

      While Not qrySuvinil.Eof Do
      Begin
        If Not qryGenerica.Locate('MSG_DESCRI;MSG_REFERE;MSG_UNIDAD;MSG_CODFML;MSG_NOMCOR;MSG_CODBAS;MSG_MENSAG', VarArrayOf([qrySuvinil.FieldByName('MSG_DESCRI').AsString,
          qrySuvinil.FieldByName('MSG_REFERE').AsString, qrySuvinil.FieldByName('MSG_UNIDAD').AsString, qrySuvinil.FieldByName('MSG_CODFML').AsString,
          qrySuvinil.FieldByName('MSG_NOMCOR').AsString, qrySuvinil.FieldByName('MSG_CODBAS').AsString, qrySuvinil.FieldByName('MSG_MENSAG').AsString]), []) Then
        Begin
          blnDiverMsg := False;
          Break;
        End;

        qrySuvinil.Next;
        Gravando.RegistrarProgresso(0, qrySuvinil.RecNo, qrySuvinil.RecordCount);
      End;

      If blnDiverMsg Then
      Begin
        Gravando.Texto := 'Não existe diferença entre as tabelas[SUV_CADMSG]...';
        Gravando.Texto := 'Verificado com sucesso[SUV_CADMSG]]...';
      End
      Else
        Gravando.Texto := 'Existe diferença na atualização de script, verificar o script de atualização[SUV_CADMSG]...';

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

function TGravandoExecucaoSuvinilVerificaAtualizacao.fCriaTabelaCopia: String;
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

function TGravandoExecucaoSuvinilVerificaAtualizacao.fCriaTabelaCopiaMsg: String;
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

function TGravandoExecucaoSuvinilVerificaAtualizacao.fGetNomeGravacao: string;
begin
  Result := 'Verificar Atualização';
end;

function TGravandoExecucaoSuvinilVerificaAtualizacao.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TGravandoExecucaoSuvinilVerificaAtualizacao.fRetDataSeparada(Data: TDateTime): String;
begin
  Result := '_' + FormatDateTime('yyyy', Data) + '_' + FormatDateTime('mm', Data) + '_' +  FormatDateTime('dd', Data);
end;

procedure TGravandoExecucaoSuvinilVerificaAtualizacao.pExecutaTabelaScripts(const Gravando: IGravando);
Var
  qryExecut,
  qryScript: IDataSet;
  strSQL: String;
  intContador: Integer;
begin
  Gravando.Texto := 'Verificando tabela de scripts...';
  IntContador := 1;

  qryScript := TAutcomTintaFactory.Get.fGetDataSet;
  qryExecut := TAutcomTintaFactory.Get.fGetDataSet;
  qryScript.SQL := '  SELECT * FROM SUV_SCRIPT  ORDER BY SCR_VERSAO  ';
  qryScript.Open;

  Gravando.Texto := 'Executando scripts de atualizações...';

  While Not qryScript.Eof Do
  Begin
   strSQL := '';
   strSQL := strSQL + AnsiReplaceStr(qryScript.FieldByName('SCR_COMAND').AsString, 'SUV_CADSUV', 'SUV_CADSUV_ORIGINAL' + fRetDataSeparada(Date));
   strSQL := AnsiReplaceStr(strSQL, 'CHAVEUNICA', 'CHAVEUNICA' + IntToStr(intContador));

    qryExecut.Close;
    qryExecut.SQL := strSQL;
    qryExecut.ExecSQL;

    qryScript.Next;
    Gravando.RegistrarProgresso(0, qryScript.RecNo, qryScript.RecordCount);
    Inc(intContador);
  End;
end;

procedure TGravandoExecucaoSuvinilVerificaAtualizacao.pExecutaTabelaScriptsMsg(
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

end.

