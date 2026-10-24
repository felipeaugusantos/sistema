{*************************************************************************}
{* Classe responsável pela geração do cadastro de cores da tinta Annetta *}
{**********************************************************************PH*}
unit untGravandoExecucaoAnnettaCores;

interface

uses
  untAbstractGravandoExecucaoAnnetta, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, untStatusGravando, ComObj, Dialogs, StrUtils, untStrUtils, Variants;

type
  TGravandoExecucaoAnnettaCores = class(TAbstractGravandoExecucaoAnnetta)
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
    function GetSQLOrigem(): String;
    function GetSQLBases(): String;
    function fRetQuantidade(qryOrigem: TADODataSet; qryBases: TADODataSet; intCont: Integer): Double;
    function fRetornaCodEmbalagem(strCodEmbalagemOrigem, strUniDes:String): String;
    function IsRegistroExiste(qryCores: IDataSet; qryOrigem: TADODataSet): Boolean;
    function fRetUnidade(fltVolume: Double): String;
    function GetSQLCor(): String;
    function fFormulaExiste(tblArquivo: TADODataSet; qryCadVer: IDataSet; tblBases: TADODataSet): Boolean;
    procedure DropColumn(qryCadVer: IDataSet; Gravando: IGravando);
  end;

Implementation

uses
  untFuncoesGenerica;

{ TGravandoExecucaoAnnettaCores }

procedure TGravandoExecucaoAnnettaCores.DropColumn(qryCadVer: IDataSet; Gravando: IGravando);
begin
  Gravando.Texto := 'Deletando coluna temporaria...';

  qryCadVer.Close;
  qryCadVer.SQL := 'ALTER TABLE ANN_CADANN DROP COLUMN ANN_IDBASE   ';
  qryCadVer.ExecSQL;
end;

procedure TGravandoExecucaoAnnettaCores.Executar(const gravando: IGravando);
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
        TAutcomTintaFactory.Get.fInsereProCod('ANN_CADANN');
        Gravando.Texto := 'PROCOD verificado com sucesso...';

        Gravando.Texto := 'Carregando Dados...';

        If intCont = 0 Then
        Begin
          Gravando.Texto := 'Deletando Registros da tabela ANN_CADANN...';
          qryCadCor := TAutcomTintaFactory.Get.fGetDataSet;
          qryCadVer := TAutcomTintaFactory.Get.fGetDataSet;
          qryCadCor.SQL := '    DELETE FROM ANN_CADANN      ';
          qryCadCor.ExecSQL;
          Gravando.Texto := 'Criando coluna temporaria...';
          qryCadVer.Close;
          qryCadVer.SQL := '  ALTER TABLE ANN_CADANN ADD COLUMN ANN_IDBASE VARCHAR(5)   ';
          qryCadVer.ExecSQL;
        End;



        qryCadCor.Close;
        qryCadCor.SQL := '    SELECT * FROM ANN_CADANN          ';
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
            qryCadVer.ParamByName('COLECA').AsString := tblArquivo.FieldByName('COLECAO').AsString;
            qryCadVer.Open;

            strDesAnt := qryCadVer.FieldByName('ANN_DESCRI').AsString;
            strCodAnt := qryCadVer.FieldByName('ANN_CODIGO').AsString;
            strBasAnt := qryCadVer.FieldByName('ANN_CODBAS').AsString;
            strProAnt := qryCadVer.FieldByName('ANN_PRODUT').AsString;
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
              qryCadCor.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('ANN_CADANN', TAutcomTintaFactory.Get.GetCodEmp);
              qryCadCor.FieldByName('ANN_CODSEQ').AsString := TStrUtils.fStrZero(intCodSeq, 6);
              qryCadCor.FieldByName('ANN_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
              qryCadCor.FieldByName('ANN_DESCRI').AsString := tblArquivo.FieldByName('COR').AsString;
              qryCadCor.FieldByName('ANN_CODIGO').AsString := tblArquivo.FieldByName('CODCOR').AsString;
              qryCadCor.FieldByName('ANN_UNIDAD').AsString := fRetUnidade(tblBases.FieldByName('Volume').AsFloat);
              qryCadCor.FieldByName('ANN_CODUNI').AsString := fRetUnidade(tblBases.FieldByName('Volume').AsFloat);
              qryCadCor.FieldByName('ANN_CODBAS').AsString := tblArquivo.FieldByName('BASE').AsString;
              qryCadCor.FieldByName('ANN_PRODUT').AsString := tblArquivo.FieldByName('PRODUT').AsString;
              qryCadCor.FieldByName('ANN_COLECA').AsString := tblArquivo.FieldByName('COLECAO').AsString;
              qryCadCor.FieldByName('ANN_CODEMB').AsString := fRetornaCodEmbalagem('2', qryCadCor.FieldByName('ANN_UNIDAD').AsString);
              qryCadCor.FieldByName('ANN_FORM01').AsString := tblArquivo.FieldByName('PIGMENTO').AsString;
              qryCadCor.FieldByName('ANN_IDBASE').AsString := tblArquivo.FieldByName('IDBASE').AsString;
              qryCadCor.FieldByName('ANN_QTDC01').AsFloat  := fRetQuantidade(tblArquivo, tblBases, intCont);
              qryCadCor.FieldByName('ANN_MD5KEY').AsString := GetMD5(qryCadCor.FieldByName('ANN_DESCRI').AsString +
                                                                     qryCadCor.FieldByName('ANN_CODIGO').AsString +
                                                                     qryCadCor.FieldByName('ANN_UNIDAD').AsString +
                                                                     qryCadCor.FieldByName('ANN_CODBAS').AsString +
                                                                     qryCadCor.FieldByName('ANN_CODEMB').AsString +
                                                                     qryCadCor.FieldByName('ANN_PRODUT').AsString +
                                                                     qryCadCor.FieldByName('ANN_COLECA').AsString);

              qryCadCor.Post;

              Inc(intCodSeq);
            End
            Else
            Begin
              qryCadVer.Edit;
              qryCadVer.FieldByName('ANN_FORM' + TStrUtils.fStrZero(intQuant, 2)).AsString := tblArquivo.FieldByName('PIGMENTO').AsString;
              qryCadVer.FieldByName('ANN_QTDC' + TStrUtils.fStrZero(intQuant, 2)).AsFloat := fRetQuantidade(tblArquivo, tblBases, intCont);
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


function TGravandoExecucaoAnnettaCores.fFormulaExiste(tblArquivo: TADODataSet;
  qryCadVer: IDataSet; tblBases: TADODataSet): Boolean;
begin
  Result := (qryCadVer.FieldByName('ANN_DESCRI').AsString = tblArquivo.FieldByName('COR').AsString) And
            (qryCadVer.FieldByName('ANN_CODIGO').AsString = tblArquivo.FieldByName('CODCOR').AsString) And
            (qryCadVer.FieldByName('ANN_UNIDAD').AsString = fRetUnidade(tblBases.FieldByName('Volume').AsFloat)) And
            (qryCadVer.FieldByName('ANN_CODBAS').AsString = tblArquivo.FieldByName('BASE').AsString) And
            (qryCadVer.FieldByName('ANN_PRODUT').AsString = tblArquivo.FieldByName('PRODUT').AsString) And
            (qryCadVer.FieldByName('ANN_IDBASE').AsString <> tblArquivo.FieldByName('IDBASE').AsString) And
            (qryCadVer.FieldByName('ANN_COLECA').AsString = tblArquivo.FieldByName('COLECAO').AsString);
end;

function TGravandoExecucaoAnnettaCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;

function TGravandoExecucaoAnnettaCores.fRetornaCodEmbalagem(
  strCodEmbalagemOrigem, strUniDes: String): String;
var
  qryGen: IDataSet;
Begin
  Try
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.SQL := '    SELECT EMB_CODEMB, EMB_UNIDAD FROM ANN_CADEMB WHERE EMB_QTDEMB IN (900, 3600, 18000)    ';
    qryGen.Open;

    If qryGen.Locate('EMB_UNIDAD', strUniDes, []) Then
      Result := qryGen.FieldByName('EMB_CODEMB').AsString
    Else
      Result := strCodEmbalagemOrigem;
  Except
    Raise;
  End;
End;

function TGravandoExecucaoAnnettaCores.fRetQuantidade(qryOrigem,
  qryBases: TADODataSet; intCont: Integer): Double;
Var
  fltFatOri: Double;
  fltFator: Double;
begin
  fltFatOri := qryBases.FieldByName('Volume').AsFloat;
  fltFator := 1;

  If fltFatOri = 3200 Then
    fltFator := 3200 / 800
  Else If fltFatOri = 3240 Then
    fltFator := 3240 / 810
  Else If fltFatOri = 14000 Then
    fltFator := 14000 / 800
  Else If fltFatOri = 15000 Then
    fltFator := 15000 / 800
  Else If fltFatOri = 16000 Then
    fltFator := 16000 / 800
  Else If fltFatOri = 16200 Then
    fltFator := 16200 / 810;

  If intCont = 0 Then
    Result := qryOrigem.FieldByName('QuanLitr').AsFloat * 0.800 * fltFator
  Else
    Result := qryOrigem.FieldByName('QuanLitr').AsFloat * 0.810 * fltFator;
end;

function TGravandoExecucaoAnnettaCores.fRetUnidade(fltVolume: Double): String;
begin
  Result := '';

  If fltVolume <= 900 Then
    Result := 'LT'
  Else If fltVolume <= 3600 Then
    Result := 'GL'
  Else If fltVolume <= 18000 Then
    Result := 'LA';
end;

function TGravandoExecucaoAnnettaCores.GetSQLBases: String;
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

function TGravandoExecucaoAnnettaCores.GetSQLCor: String;
begin
  Result := '';
  Result := Result + '  SELECT                    ';
  Result := Result + '    *                       ';
  Result := Result + '  FROM                      ';
  Result := Result + '    ANN_CADANN              ';
  Result := Result + '  WHERE                     ';
  Result := Result + '    ANN_DESCRI = :DESCRI AND        ';
  Result := Result + '    ANN_CODIGO = :CODIGO AND        ';
  Result := Result + '    ANN_UNIDAD = :UNIDAD AND        ';
  Result := Result + '    ANN_CODBAS = :CODBAS AND        ';
  Result := Result + '    ANN_PRODUT = :PRODUT AND        ';
  Result := Result + '    ANN_COLECA = :COLECA            ';
end;

function TGravandoExecucaoAnnettaCores.GetSQLOrigem: String;
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
  Result := Result + '    CO.COLECAO AS COLECAO             ';
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
  Result := Result + '  ORDER BY F.IDNOMEGRUPBASE ASC,  F.IDNOMEBASE, F.IDCOR, F.IDCOLECAO ASC      ';
end;

function TGravandoExecucaoAnnettaCores.IsRegistroExiste(qryCores: IDataSet;
  qryOrigem: TADODataSet): Boolean;
begin
  Result := False;
end;

end.
