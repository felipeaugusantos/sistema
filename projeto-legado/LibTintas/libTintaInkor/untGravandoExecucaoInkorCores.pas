{*************************************************************************}
{* Classe responsável pela geração do cadastro de cores da tinta Inkor *}
{**********************************************************************PH*}
unit untGravandoExecucaoInkorCores;

interface

uses
  untAbstractGravandoExecucaoInkor, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, untStatusGravando, ComObj, Dialogs, StrUtils, untStrUtils, Variants;

type
  TGravandoExecucaoInkorCores = class(TAbstractGravandoExecucaoInkor)
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
    function GetSQLOrigem(): String;
    function GetSQLBases(): String;
    function fRetQuantidade(qryOrigem: TADODataSet; qryBases: TADODataSet; intCont: Integer): Double;
    function IsRegistroExiste(qryCores: IDataSet; qryOrigem: TADODataSet): Boolean;
    function fRetUnidade(fltVolume: Double): String;
    function GetSQLCor(): String;
    function fFormulaExiste(tblArquivo: TADODataSet; qryCadVer: IDataSet; tblBases: TADODataSet): Boolean;
    procedure DropColumn(qryCadVer: IDataSet; Gravando: IGravando);
  end;

Implementation

uses
  untFuncoesGenerica;

{ TGravandoExecucaoInkorCores }

procedure TGravandoExecucaoInkorCores.DropColumn(qryCadVer: IDataSet; Gravando: IGravando);
begin
  Gravando.Texto := 'Deletando coluna temporaria...';

  qryCadVer.Close;
  qryCadVer.SQL := 'ALTER TABLE INK_CADINK DROP COLUMN INK_IDBASE   ';
  qryCadVer.ExecSQL;
end;

procedure TGravandoExecucaoInkorCores.Executar(const gravando: IGravando);
Var
  qryCadCor: IDataSet;
  intCont: Integer;
  tblBases: TADODataSet;
  ConBases: TADOConnection;
  intCodSeq: Integer;
  qryCadVer: IDataSet;
  intQuant: Integer;
  strIdCor: String;
  strCodAnt, strDesAnt,
  strBasAnt, strProAnt: String;
begin
  IntCodSeq := 1;
  intQuant := 0;
  qryCadCor := TAutcomTintaFactory.Get.fGetDataSet;
  qryCadVer := TAutcomTintaFactory.Get.fGetDataSet;

  For intCont := 0 To stlTables.Count - 1 Do
  Begin
    Try
      Try

        If (Gravando.Status <> sgGravando) Then
          Break;

        Gravando.Texto := 'Verificando Path...';

        qryCadCor := TAutcomTintaFactory.Get.fGetDataSet;
        qryCadVer := TAutcomTintaFactory.Get.fGetDataSet;

        If Not fValidaPath(intCont) Then
        Begin
          Gravando.Texto := Format('O arquivo %s não foi encontrado! Rever Configurações.', [AnsiReplaceStr(fGetPath(intCont), '"', '')]);
          Break;
        End;

        Gravando.Texto := 'Verificando PROCOD...';
        TAutcomTintaFactory.Get.fInsereProCod('INK_CADINK');
        Gravando.Texto := 'PROCOD verificado com sucesso...';

        Gravando.Texto := 'Carregando Dados...';

        If intCont = 0 Then
        Begin
          Gravando.Texto := 'Deletando Registros da tabela INK_CADINK...';
          qryCadCor := TAutcomTintaFactory.Get.fGetDataSet;
          qryCadVer := TAutcomTintaFactory.Get.fGetDataSet;
          qryCadCor.SQL := '    DELETE FROM INK_CADINK      ';
          qryCadCor.ExecSQL;
          Gravando.Texto := 'Criando coluna temporaria...';
          qryCadVer.Close;
          qryCadVer.SQL := '  ALTER TABLE INK_CADINK ADD COLUMN INK_IDBASE VARCHAR(5)   ';
          qryCadVer.ExecSQL;
        End;



        qryCadCor.Close;
        qryCadCor.SQL := '    SELECT * FROM INK_CADINK          ';
        qryCadCor.Open;


        CreateConnection(intCont);

        tblArquivo.CommandText := GetSQLOrigem;
        tblArquivo.Open;
        tblArquivo.First;

        conBases := TADOConnection.Create(Nil);
        conBases.LoginPrompt := False;
        conBases.ConnectionString := fConnection(intCont);
        conBases.Open();


        tblBases := TADODataSet.Create(Nil);
        tblBases.Connection := conBases;
        tblBases.CommandText := GetSQLBases;


        Gravando.Texto := Format('Processando Arquivo:[%s]', [AnsiReplaceStr(fGetPath(intCont), '"', '')]);
        Gravando.RegistrarProgresso(0, 0, 0);


        While Not tblArquivo.Eof Do
        Begin
          If (Gravando.Status <> sgGravando) Then
            Break;

          tblBases.Close;
          tblBases.Parameters.ParamByName('IDBASE').Value := tblArquivo.FieldByName('IDBASE').AsString;
          tblBases.Parameters.ParamByName('GPBASE').Value := tblArquivo.FieldByName('IDGBASE').AsString;
          tblBases.Open;
          Inc(intQuant);

          While Not tblBases.Eof Do
          Begin

            qryCadVer.Close;
            qryCadVer.SQL := GetSQLCor();
            qryCadVer.ParamByName('DESCRI').AsString := tblArquivo.FieldByName('COR').AsString;
            qryCadVer.ParamByName('CODIGO').AsString := tblArquivo.FieldByName('CODCOR').AsString;
            qryCadVer.ParamByName('UNIDAD').AsString := fRetUnidade(tblBases.FieldByName('Volume').AsFloat);
            qryCadVer.ParamByName('CODBAS').AsString := tblArquivo.FieldByName('BASE').AsString;
            qryCadVer.ParamByName('PRODUT').AsString := tblArquivo.FieldByName('PRODUT').AsString;
            qryCadVer.Open;

            strDesAnt := qryCadVer.FieldByName('INK_DESCRI').AsString;
            strCodAnt := qryCadVer.FieldByName('INK_CODIGO').AsString;
            strBasAnt := qryCadVer.FieldByName('INK_BASE__').AsString;
            strProAnt := qryCadVer.FieldByName('INK_PRODUT').AsString;
            strIdCor  := tblArquivo.FieldByName('CODCOR').AsString;

            If fFormulaExiste(tblArquivo, qryCadVer, tblBases) Then
            Begin
              tblBases.Next;
              Continue;
            End;

            If qryCadVer.IsEmpty Then
            Begin
              intQuant := 1;

              qryCadCor.Insert;
              qryCadCor.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('INK_CADINK', TAutcomTintaFactory.Get.GetCodEmp);
              qryCadCor.FieldByName('INK_CODSEQ').AsString := TStrUtils.fStrZero(intCodSeq, 6);
              qryCadCor.FieldByName('INK_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
              qryCadCor.FieldByName('INK_DESCRI').AsString := tblArquivo.FieldByName('COR').AsString;
              qryCadCor.FieldByName('INK_CODIGO').AsString := tblArquivo.FieldByName('CODCOR').AsString;
              qryCadCor.FieldByName('INK_UNIDAD').AsString := fRetUnidade(tblBases.FieldByName('Volume').AsFloat);
              qryCadCor.FieldByName('INK_BASE__').AsString := tblArquivo.FieldByName('BASE').AsString;
              qryCadCor.FieldByName('INK_PRODUT').AsString := tblArquivo.FieldByName('PRODUT').AsString;
              qryCadCor.FieldByName('INK_FORM01').AsString := tblArquivo.FieldByName('PIGMENTO').AsString;
              qryCadCor.FieldByName('INK_IDBASE').AsString := tblArquivo.FieldByName('IDBASE').AsString;
              qryCadCor.FieldByName('INK_QTDC01').AsFloat  := fRetQuantidade(tblArquivo, tblBases, intCont);
              qryCadCor.FieldByName('INK_COLECA').AsString := tblArquivo.FieldByName('COLECAO').AsString;
              qryCadCor.FieldByName('INK_MD5KEY').AsString := GetMD5(qryCadCor.FieldByName('INK_CODIGO').AsString +
                                                                     qryCadCor.FieldByName('INK_BASE__').AsString +
                                                                     qryCadCor.FieldByName('INK_PRODUT').AsString +
                                                                     qryCadCor.FieldByName('INK_UNIDAD').AsString +
                                                                     qryCadCor.FieldByName('INK_DESCRI').AsString);
              qryCadCor.Post;

              Inc(intCodSeq);
            End
            Else
            Begin
              qryCadVer.Edit;
              qryCadVer.FieldByName('INK_FORM' + TStrUtils.fStrZero(intQuant, 2)).AsString := tblArquivo.FieldByName('PIGMENTO').AsString;
              qryCadVer.FieldByName('INK_QTDC' + TStrUtils.fStrZero(intQuant, 2)).AsFloat := fRetQuantidade(tblArquivo, tblBases, intCont);
              qryCadVer.Post;
            End;

            tblBases.Next;
          End;

          tblArquivo.Next;
          Gravando.RegistrarProgresso(0, tblArquivo.RecNo, tblArquivo.RecordCount);
        End;

      Except
        On E: Exception Do
          Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      End;
    Finally
      DestroyConnection;
    End;
  End;

  DropColumn(qryCadVer, Gravando);
  Gravando.Texto := 'Cadastro de Cores finalizado...';
end;


function TGravandoExecucaoInkorCores.fFormulaExiste(tblArquivo: TADODataSet;
  qryCadVer: IDataSet; tblBases: TADODataSet): Boolean;
begin
  Result := (qryCadVer.FieldByName('INK_DESCRI').AsString = tblArquivo.FieldByName('COR').AsString) And
            (qryCadVer.FieldByName('INK_CODIGO').AsString = tblArquivo.FieldByName('CODCOR').AsString) And
            (qryCadVer.FieldByName('INK_UNIDAD').AsString = fRetUnidade(tblBases.FieldByName('Volume').AsFloat)) And
            (qryCadVer.FieldByName('INK_BASE__').AsString = tblArquivo.FieldByName('BASE').AsString) And
            (qryCadVer.FieldByName('INK_PRODUT').AsString = tblArquivo.FieldByName('PRODUT').AsString) And
            (qryCadVer.FieldByName('INK_IDBASE').AsString <> tblArquivo.FieldByName('IDBASE').AsString);
end;

function TGravandoExecucaoInkorCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;

function TGravandoExecucaoInkorCores.fRetQuantidade(qryOrigem,
  qryBases: TADODataSet; intCont: Integer): Double;
Var
  fltFatOri: Double;
  fltFator: Double;
begin
  fltFatOri := qryBases.FieldByName('Volume').AsFloat;
  fltFator := 1;

  If fltFatOri = 3200 Then
    fltFator := 3200 / 800
  Else If fltFatOri = 14000 Then
    fltFator := 14000 / 800
  Else If fltFatOri = 15000 Then
    fltFator := 15000 / 800
  Else If fltFatOri = 16000 Then
    fltFator := 16000 / 800
  Else If fltFatOri = 3240 Then
    fltFator := 3240 / 810
  Else If fltFatOri = 16200 Then
    fltFator := 16200 / 810;

  If (fltFatOri = 800) Or (fltFatOri = 3200) Or (fltFatOri = 14000) Or (fltFatOri = 15000) Then
    Result := qryOrigem.FieldByName('QuanLitr').AsFloat * 0.800 * fltFator
  Else
    Result := qryOrigem.FieldByName('QuanLitr').AsFloat * 0.810 * fltFator;
end;

function TGravandoExecucaoInkorCores.fRetUnidade(fltVolume: Double): String;
begin
  Result := '';

  If fltVolume <= 900 Then
    Result := 'LT'
  Else If fltVolume <= 3600 Then
    Result := 'GL'
  Else If fltVolume <= 18000 Then
    Result := 'LA';
end;

function TGravandoExecucaoInkorCores.GetSQLBases: String;
begin
  Result := '';
  Result := Result + '  SELECT              ';
  Result := Result + '    *                 ';
  Result := Result + '  FROM                ';
  Result := Result + '    TBLBASES          ';
  Result := Result + '  WHERE               ';
  Result := Result + '    IDNOMEBASE = :IDBASE  AND       ';
  Result := Result + '    IDNOMEGRUPBASE = :GPBASE        ';
end;

function TGravandoExecucaoInkorCores.GetSQLCor: String;
begin
  Result := '';
  Result := Result + '  SELECT                    ';
  Result := Result + '    *                       ';
  Result := Result + '  FROM                      ';
  Result := Result + '    INK_CADINK              ';
  Result := Result + '  WHERE                     ';
  Result := Result + '    INK_DESCRI = :DESCRI AND        ';
  Result := Result + '    INK_CODIGO = :CODIGO AND        ';
  Result := Result + '    INK_UNIDAD = :UNIDAD AND        ';
  Result := Result + '    INK_BASE__ = :CODBAS AND        ';
  Result := Result + '    INK_PRODUT = :PRODUT            ';
end;

function TGravandoExecucaoInkorCores.GetSQLOrigem: String;
begin
  Result := '';
  Result := Result + '  SELECT                              ';
  Result := Result + '    F.*,                              ';
  Result := Result + '    F.IdNomeBase AS IDBASE,           ';
  Result := Result + '    F.IdNomeGrupBase AS IDGBASE,      ';
  Result := Result + '    B.NomeBase  AS BASE,              ';
  Result := Result + '    G.NomeGrupBase AS PRODUT,         ';
  Result := Result + '    C.Codigo AS CODCOR,               ';
  Result := Result + '    C.Cor AS COR,                     ';
  Result := Result + '    P.Codigo AS PIGMENTO,             ';
  Result := Result + '    CO.Colecao AS COLECAO             ';
  Result := Result + '  FROM                                ';
  Result := Result + '    TBLFORMULAS F,                    ';
  Result := Result + '    TBLNOMEBASE B,                    ';
  Result := Result + '    TBLNOMEGRUPBASE G,                ';
  Result := Result + '    TBLCORES C,                       ';
  Result := Result + '    TBLCORANTES P,                    ';
  Result := Result + '    TBLCOLECOES CO                    ';
  Result := Result + '  WHERE                               ';
  Result := Result + '    F.IDNOMEBASE = B.IDNOMEBASE AND               ';
  Result := Result + '    F.IDNOMEGRUPBASE = G.IDNOMEGRUPBASE AND       ';
  Result := Result + '    F.IDCOR = C.IDCOR AND                         ';
  Result := Result + '    F.IDCORANTE = P.IDCORANTE AND                 ';
  Result := Result + '    F.IDCOLECAO = CO.IDCOLECAO                    ';
  Result := Result + '  ORDER BY F.IDNOMEGRUPBASE ASC,  F.IDNOMEBASE, F.IDCOR ASC      ';
end;

function TGravandoExecucaoInkorCores.IsRegistroExiste(qryCores: IDataSet;
  qryOrigem: TADODataSet): Boolean;
begin
  Result := False;
end;

end.
