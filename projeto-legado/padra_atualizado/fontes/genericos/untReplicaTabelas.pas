unit untReplicaTabelas;

interface

uses Uni, System.SysUtils, Data.DB;

type
  TReplicaTabelasAbstract = Class
  private
    FNomTab: String;
    FNumLoj: String; {<<-- Empresa de Destino}
    FLojLog: String; {<<-- Empresa de Origem}
    FFieldCodEmp  : String;
    FAutIncString : Boolean;

    FHerdarDadosDoBancoFisico : Boolean;
    FQueryBDFisico            : TUniQuery;

    function fMaxAutInc(strNomTab: String): Integer;
    function fGetIn(qryDestin: TUniQuery; strField: String): String;
  public
    procedure pAlteraEmpresaLogada(strEmpLog: String);
    procedure pUpDateTmp(intSeq: Integer; strNomTab: String; strWhere: String = ''); virtual; abstract;
    procedure pReplicaTabela;
    procedure pExecutarReplicacao;
    procedure pExecutarReplicacaoBancoFisico;
    constructor Create(strNomTab: String; strNumLoj: String; strFieldCodEmp: String; blnAutIncString: Boolean);

    property blnHerdarDadosDoBancoFisico : Boolean   read FHerdarDadosDoBancoFisico write FHerdarDadosDoBancoFisico;
    property qryBDFisico                 : TUniQuery read FQueryBDFisico            write FQueryBDFisico;

  End;

  TReplicaTabelaITEEMB = Class(TReplicaTabelasAbstract)
  public
    procedure pUpDateTmp(intSeq: Integer; strNomTab: String; strWhere: String = ''); override;
    constructor Create(strNumLoj: String); reintroduce;
  End;

  TReplicaTabelaITEGER = Class(TReplicaTabelasAbstract)
  public
    procedure pUpDateTmp(intSeq: Integer; strNomTab: String; strWhere: String = ''); override;
    constructor Create(strNumLoj: String); reintroduce;
  End;

  TReplicaTabelaACAGER = Class(TReplicaTabelasAbstract)
  public
    procedure pUpDateTmp(intSeq: Integer; strNomTab: String; strWhere: String = ''); override;
    constructor Create(strNumLoj: String); reintroduce;
  End;

  TReplicaTabelaCFGREL = Class(TReplicaTabelasAbstract)
  public
    procedure pUpDateTmp(intSeq: Integer; strNomTab: String; strWhere: String = ''); override;
    constructor Create(strNumLoj: String); reintroduce;
  End;

  TReplicaTabelaCNFBOL = Class(TReplicaTabelasAbstract)
  public
    procedure pUpDateTmp(intSeq: Integer; strNomTab: String; strWhere: String = ''); override;
    constructor Create(strNumLoj: String); reintroduce;
  End;

  TReplicaTabelaLAYETI = Class(TReplicaTabelasAbstract)
  public
    procedure pUpDateTmp(intSeq: Integer; strNomTab: String; strWhere: String = ''); override;
    constructor Create(strNumLoj: String); reintroduce;
  End;

  TReplicaTabelaCadLot = Class(TReplicaTabelasAbstract)
  public
    procedure pUpDateTmp(intSeq: Integer; strNomTab: String; strWhere: String = ''); override;
    constructor Create(strNumLoj: String); reintroduce;
  End;

  TReplicaTabelaCONEMP = Class(TReplicaTabelasAbstract)
  public
    procedure pUpDateTmp(intSeq: Integer; strNomTab: String; strWhere: String = ''); override;
    constructor Create(strNumLoj: String); reintroduce;
  End;

  TReplicaTabelaCADCAR = Class(TReplicaTabelasAbstract)
  public
    procedure pUpDateTmp(intSeq: Integer; strNomTab: String; strWhere: String = ''); override;
    constructor Create(strNumLoj: String); reintroduce;
  End;

implementation

uses untFuncoesSimples, untModulo;

{ TReplicaTabelasAbstract }

constructor TReplicaTabelasAbstract.Create(strNomTab: String; strNumLoj: String; strFieldCodEmp: String; blnAutIncString: Boolean);
begin
  Inherited Create;
  FNomTab := strNomTab;
  FNumLoj := strNumLoj;
  FLojLog := VS_strCodEmp;
  FFieldCodEmp := strFieldCodEmp;
  FAutIncString := blnAutIncString;

  FHerdarDadosDoBancoFisico := False;
  FQueryBDFisico            := Nil;

end;

function TReplicaTabelasAbstract.fGetIn(qryDestin: TUniQuery;
  strField: String): String;
begin
  Result := '';
  qryDestin.First;
  While Not qryDestin.Eof Do
  Begin
    If fEmptyStr(Result) Then
      Result := '"' + qryDestin.FieldByName(strField).AsString + '"'
    Else
      Result := Result + ', ' + '"' + qryDestin.FieldByName(strField).AsString + '"';
    qryDestin.Next;
  End;

  If Not fEmptyStr(Result) Then
    Result := strField + ' IN (' + Result + ') ';
end;

function TReplicaTabelasAbstract.fMaxAutInc(strNomTab: String): Integer;
  Var
    qryMaxAut : TUniQuery;
begin
  qryMaxAut := fCriaQuery;

  With qryMaxAut Do
  Begin
    Close;
    SQL.Clear;

    If (FAutIncString) Then
      SQL.Add(' SELECT MAX(CAST(SUBSTR(AUTOINCREM, 4, 14) AS UNSIGNED)) AS AUTINC ')
    Else
      SQL.Add(' SELECT MAX(AUTOINCREM) AS AUTINC ');

    SQL.Add('   FROM ' + strNomTab);
    Open;
    Result := FieldByName('AUTINC').AsInteger;
    Close;
  End;

  FreeAndNil(qryMaxAut);
end;

procedure TReplicaTabelasAbstract.pAlteraEmpresaLogada(strEmpLog: String);
begin
  FLojLog := strEmpLog;
end;

procedure TReplicaTabelasAbstract.pExecutarReplicacao;
  Const
    intMaxTen : Integer = 10;
  Var
    qryTabela : TUniQuery;
    qryProInc : TUniQuery;
    strNomTabTmp : String;
    intProInc : Integer;
    intCntTen : Integer;
begin
  Randomize;
  strNomTabTmp := 'TMP_NOVO' + FNomTab + '_' + fTiraCaracEspeciaisPonto(GetIPAddressAsString +
    IntToStr(Random(1000)) + FormatDateTime('yyyyMMddhhmmss', fNow()));

  qryTabela := fCriaQuery;
  qryProInc := fCriaQuery;
  intProInc := 1;

  If fCampoExiste(FNomTab,'AUTOINCREM') Then
    pValidaProCod(FNomTab);

  fStartTransaction;

  Try
    Try
      If fCampoExiste(FNomTab,'AUTOINCREM') Then
      Begin
        With qryProInc Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(' SELECT SQL_NO_CACHE ');
          SQL.Add('        *            ');
          SQL.Add('   FROM PROINC       ');
          SQL.Add('  WHERE PRO_NOMARQ = "' + FNomTab + '" ');
          SQL.Add('    FOR UPDATE ');
          Open;

          If FieldByName('PRO_AUTINC').IsNull Then
            intProInc := 1
          Else
            intProInc := FieldByName('PRO_AUTINC').AsInteger;
        End;
      End;

      With qryTabela Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add('CREATE TABLE ' + strNomTabTmp + ' ( ');
        SQL.Add(' SELECT * FROM ' + FNomTab + ' WHERE ' + FFieldCodEmp + ' = ' + QuotedStr(FLojLog));
        SQL.Add(' ) ');
        ExecSQL;

        If fCampoExiste(FNomTab,'AUTOINCREM') Then
        Begin
          pUpDateTmp(intProInc, strNomTabTmp);

          intCntTen := 0;

          While (True) Do
          Begin
            Inc(intCntTen);

            If (intCntTen > intMaxTen) Then
            Begin
              fRollBack;
              Raise Exception.Create('Atenção! AUTOINCREM da tabela "' + FNomTab + '" com problemas!' + Chr(13) +
                                     'Ligue na Citel imediatamente!');
            End;

            // RECUPERA O ULTIMO AUTOINCREM GERADO NA TEMPORÁRIA!
            intProInc := fMaxAutInc(strNomTabTmp);

            Close;
            SQL.Clear;
            SQL.Add(' SELECT TAB.AUTOINCREM ');
            SQL.Add('   FROM ' + strNomTabTmp + ' TAB ');
            SQL.Add('  INNER JOIN ' + FNomTab + ' ON ' + FNomTab + '.AUTOINCREM = TAB.AUTOINCREM ');
            Open;

            If Not IsEmpty Then
              pUpDateTmp(intProInc, strNomTabTmp, fGetIn(qryTabela, 'AUTOINCREM'))
            Else
              Break;
          End;

          qryProInc.Edit;
          qryProInc.FieldByName('PRO_AUTINC').AsInteger := fMaxAutInc(strNomTabTmp);
          qryProInc.Post;
        End
        Else
          pUpDateTmp(intProInc, strNomTabTmp, '');


        Close;
        SQL.Clear;
        SQL.Add('INSERT INTO ' + FNomTab + ' (SELECT * FROM ' + strNomTabTmp + ') ');
        ExecSQL;

        if pos(FNomTab,'CFGREL_CNFBOL') > 0 then
          fGravaLogRep(qryTabela.Sql.Text.Replace(#13#10, ' '), FNomTab, 'N', frmModulo.GetCurrentConnection);

        // APAGA A TEMPORARIA
        Close;
        SQL.Clear;
        SQL.Add('DROP TABLE ' + strNomTabTmp);
        ExecSQL;
      End;

      qryProInc.Close;

      fCommit;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[TReplicaTabelasAbstract.pReplicaTabela]');
      End;
    End;
  Finally
    FreeAndNil(qryProInc);
    FreeAndNil(qryTabela);
    fDropTable(strNomTabTmp);
  End;
end;

procedure TReplicaTabelasAbstract.pExecutarReplicacaoBancoFisico;
Const
  intMaxTen : Integer = 10;
Var
  qryTabela    : TUniQuery;
  qryProInc    : TUniQuery;
  strNomTabTmp : String;
  intProInc    : Integer;
  intCntTen    : Integer;
  intCampo     : Integer;
begin

  Randomize;
  strNomTabTmp := 'TMP_NOVO' + FNomTab + '_' + fTiraCaracEspeciaisPonto(GetIPAddressAsString +
    IntToStr(Random(1000)) + FormatDateTime('yyyyMMddhhmmss', fNow()));

  qryTabela := fCriaQuery;
  qryProInc := fCriaQuery;
  intProInc := 1;
  If fCampoExiste(FNomTab,'AUTOINCREM') Then
    pValidaProCod(FNomTab);

  fStartTransaction;

  Try
    Try
      If fCampoExiste(FNomTab,'AUTOINCREM') Then
      Begin
        With qryProInc Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(' SELECT SQL_NO_CACHE ');
          SQL.Add('        *            ');
          SQL.Add('   FROM PROINC       ');
          SQL.Add('  WHERE PRO_NOMARQ = "' + FNomTab + '" ');
          SQL.Add('    FOR UPDATE ');
          Open;

          If FieldByName('PRO_AUTINC').IsNull Then
            intProInc := 1
          Else
            intProInc := FieldByName('PRO_AUTINC').AsInteger;
        End;
      End;

      With qryTabela Do
      Begin

        Close;
        SQL.Clear;
        SQL.Add('CREATE TABLE ' + strNomTabTmp + ' ( ');
        SQL.Add(' SELECT * FROM ' + FNomTab + ' WHERE FALSE');
        SQL.Add(' ) ');
        ExecSQL;

        Close;
        SQL.Clear;
        SQL.Add('SELECT * FROM ' + strNomTabTmp);
        Open;

        FQueryBDFisico.Close;
        FQueryBDFisico.SQL.Clear;
        FQueryBDFisico.SQL.Add('SELECT * FROM ' + FNomTab + ' WHERE ' + FFieldCodEmp + ' = ' + QuotedStr(FLojLog));
        FQueryBDFisico.Open;

        FQueryBDFisico.First;
        While Not FQueryBDFisico.Eof Do
        Begin
          Append;
          for intCampo := 0 to Fields.Count -1 do
            FieldByName(Fields[intCampo].FieldName).Value := FQueryBDFisico.FieldByName(Fields[intCampo].FieldName).Value;
          Post;
          FQueryBDFisico.Next;
        End;

        If fCampoExiste(FNomTab,'AUTOINCREM') Then
        Begin
          pUpDateTmp(intProInc, strNomTabTmp);

          intCntTen := 0;

          While (True) Do
          Begin
            Inc(intCntTen);

            If (intCntTen > intMaxTen) Then
            Begin
              fRollBack;
              Raise Exception.Create('Atenção! AUTOINCREM da tabela "' + FNomTab + '" com problemas!' + Chr(13) +
                                     'Ligue na Citel imediatamente!');
            End;

            // RECUPERA O ULTIMO AUTOINCREM GERADO NA TEMPORÁRIA!
            intProInc := fMaxAutInc(strNomTabTmp);

            Close;
            SQL.Clear;
            SQL.Add(' SELECT TAB.AUTOINCREM ');
            SQL.Add('   FROM ' + strNomTabTmp + ' TAB ');
            SQL.Add('  INNER JOIN ' + FNomTab + ' ON ' + FNomTab + '.AUTOINCREM = TAB.AUTOINCREM ');
            Open;

            If Not IsEmpty Then
              pUpDateTmp(intProInc, strNomTabTmp, fGetIn(qryTabela, 'AUTOINCREM'))
            Else
              Break;
          End;

          qryProInc.Edit;
          qryProInc.FieldByName('PRO_AUTINC').AsInteger := fMaxAutInc(strNomTabTmp);
          qryProInc.Post;
        End
        Else
          pUpDateTmp(intProInc, strNomTabTmp, '');

        Close;
        SQL.Clear;
        SQL.Add('INSERT INTO ' + FNomTab + ' (SELECT * FROM ' + strNomTabTmp + ') ');
        ExecSQL;

        if pos(FNomTab,'CFGREL_CNFBOL') > 0 then
          fGravaLogRep(qryTabela.Sql.Text.Replace(#13#10, ' '), FNomTab, 'N', frmModulo.GetCurrentConnection);

        // APAGA A TEMPORARIA
        Close;
        SQL.Clear;
        SQL.Add('DROP TABLE ' + strNomTabTmp);
        ExecSQL;
      End;

      qryProInc.Close;

      fCommit;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[TReplicaTabelasAbstract.pExecutarReplicacaoBancoFisico]');
      End;
    End;
  Finally
    FreeAndNil(qryProInc);
    FreeAndNil(qryTabela);
    fDropTable(strNomTabTmp);
  End;
end;

procedure TReplicaTabelasAbstract.pReplicaTabela;
begin
  If (FHerdarDadosDoBancoFisico) Then
    pExecutarReplicacaoBancoFisico
  Else
    pExecutarReplicacao;
end;

{ TReplicaTabelaITEEMB }

constructor TReplicaTabelaITEEMB.Create(strNumLoj: String);
begin
  inherited Create('ITEEMB', strNumLoj, 'ITB_CODEMP', True);
end;

procedure TReplicaTabelaITEEMB.pUpDateTmp(intSeq: Integer; strNomTab,
  strWhere: String);
  Var
    qryTmp : TUniQuery;
begin
  qryTmp := fCriaQuery;

  With qryTmp Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(' SET @AUT = ' + IntToStr(intSeq) + '; ');
    SQL.Add(' UPDATE ' + strNomTab   );
    SQL.Add('    SET ITB_CODEMP = ' + QuotedStr(FNumLoj) + ', ');
    SQL.Add('        AUTOINCREM = CONCAT("' + fRetEmpresaFisica + '", RIGHT(CONCAT("000000000000000000", @AUT:=@AUT+1), 14), "' + FNumLoj + '") ');

    If Not fEmptyStr(strWhere) Then
      SQL.Add(' WHERE ' + strWhere );

    ExecSQL;
  End;

  FreeAndNil(qryTmp);
end;

{ TReplicaTabelaITEGER }

constructor TReplicaTabelaITEGER.Create(strNumLoj: String);
begin
  inherited Create('ITEGER', strNumLoj, 'ITE_CODEMP', True);
end;

procedure TReplicaTabelaITEGER.pUpDateTmp(intSeq: Integer; strNomTab,
  strWhere: String);
  Var
    qryTmp : TUniQuery;
begin
  qryTmp := fCriaQuery;

  With qryTmp Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(' SET @AUT = ' + IntToStr(intSeq) + '; ');
    SQL.Add(' UPDATE ' + strNomTab   );
    SQL.Add('    SET ITE_LOCFIS = "",  ');
//    SQL.Add('        ITE_COMVAR = 0.0, ');
//    SQL.Add('        ITE_COMATA = 0.0, ');
//    SQL.Add('        ITE_COMDIS = 0.0, ');
    SQL.Add('        ITE_SALBAL = 0.0, ');
    SQL.Add('        ITE_ML_BAL = 0.0, ');
    SQL.Add('        ITE_SALDOS = 0.0, ');
    SQL.Add('        ITE_ESTMIN = 0.0, ');
    SQL.Add('        ITE_ESTMAX = 0.0, ');
    SQL.Add('        ITE_SAL_ML = 0.0, ');
    SQL.Add('        ITE_CODEMP = ' + QuotedStr(FNumLoj) + ', ');
    SQL.Add('        ITE_DTABAL = DATE_ADD(' + fCurrentDate + ', INTERVAL -1 DAY), ');
    SQL.Add('        ITE_LOCSEP = NULL, ');
    SQL.Add('        ITE_LOCSUP = NULL, ');
    SQL.Add('        ITE_SALCON = 0.0,  ');
    SQL.Add('        ITE_GMLCON = 0.0,  ');
    SQL.Add('        ITE_DIGCON = "N",  ');
    SQL.Add('        ITE_ORDCON = 0,    ');
    SQL.Add('        ITE_DTAULT = NULL, ');
    SQL.Add('        ITE_FORULT = NULL, ');
    SQL.Add('        ITE_NOTULT = NULL, ');
    SQL.Add('        ITE_PREULT = 0.0,  ');
    SQL.Add('        ITE_IMPULT = 0.0,  ');
    SQL.Add('        ITE_QTDUCO = 0.0,  ');
    SQL.Add('        ITE_PREMED = 0.0,  ');
    SQL.Add('        ITE_DTAUVE = NULL, ');
    SQL.Add('        ITE_PREUVE = 0.0,  ');
    SQL.Add('        ITE_QTDUVE = 0.0,  ');
    SQL.Add('        ITE_QTDETI = 0,    ');
    SQL.Add('        ITE_ULTAUD = NULL, ');
    SQL.Add('        ITE_ULTAEF = NULL, ');
    SQL.Add('        ITE_QTPD_V = 0.0,  ');
    SQL.Add('        ITE_QTPD_F = 0.0,  ');
    SQL.Add('        ITE_QTPD_P = 0.0,  ');
    SQL.Add('        ITE_QTEF_A = 0.0,  ');
    SQL.Add('        ITE_QTEF_F = 0.0,  ');
    SQL.Add('        ITE_QTEF_P = 0.0,  ');
    SQL.Add('        ITE_QTPDBF = 0.0,  ');
    SQL.Add('        ITE_SDPDBF = 0.0,  ');
    SQL.Add('        ITE_QTPD_E = 0.0,  ');
    SQL.Add('        ITE_SALTRA = 0.0,  ');
    SQL.Add('        ITE_SALREG = 0.0,  ');
    SQL.Add('        ITE_SALEXT = 0.0,  ');
    SQL.Add('        ITE_SALREP = 0.0,  ');
    SQL.Add('        AUTOINCREM = CONCAT("' + fRetEmpresaFisica + '", RIGHT(CONCAT("000000000000000000", @AUT:=@AUT+1), 14), "' + FNumLoj + '") ');

    If Not fEmptyStr(strWhere) Then
      SQL.Add(' WHERE ' + strWhere );

    ExecSQL;
  End;

  FreeAndNil(qryTmp);
end;

{ TReplicaTabelaACAGER }

constructor TReplicaTabelaACAGER.Create(strNumLoj: String);
begin
  inherited Create('ACAGER', strNumLoj, 'ACA_EMPEST', True);
end;

procedure TReplicaTabelaACAGER.pUpDateTmp(intSeq: Integer; strNomTab,
  strWhere: String);
  Var
    qryTmp : TUniQuery;
begin
  qryTmp := fCriaQuery;

  With qryTmp Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(' SET @AUT = ' + IntToStr(intSeq) + '; ');
    SQL.Add(' UPDATE ' + strNomTab   );
    SQL.Add('    SET ACA_EMPEST = ' + QuotedStr(FNumLoj) + ',  ');
    SQL.Add('        ACA_SALDOS = 0.0, ');
    SQL.Add('        AUTOINCREM = CONCAT("' + fRetEmpresaFisica + '", RIGHT(CONCAT("000000000000000000", @AUT:=@AUT+1), 14), "' + FNumLoj + '") ');

    If Not fEmptyStr(strWhere) Then
      SQL.Add(' WHERE ' + strWhere );

    ExecSQL;
  End;

  FreeAndNil(qryTmp);
end;

{ TReplicaTabelaCFGREL }

constructor TReplicaTabelaCFGREL.Create(strNumLoj: String);
begin
  inherited Create('CFGREL', strNumLoj, 'REL_CODEMP', True);
end;

procedure TReplicaTabelaCFGREL.pUpDateTmp(intSeq: Integer; strNomTab,
  strWhere: String);
  Var
    qryTmp : TUniQuery;
begin
  qryTmp := fCriaQuery;

  With qryTmp Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(' SET @AUT = ' + IntToStr(intSeq) + '; ');
    SQL.Add(' UPDATE ' + strNomTab   );
    SQL.Add('    SET REL_CODEMP = ' + QuotedStr(FNumLoj) + ', ');
    SQL.Add('        AUTOINCREM = CONCAT("' + fRetEmpresaFisica + '", RIGHT(CONCAT("000000000000000000", @AUT:=@AUT+1), 14), "' + FNumLoj + '") ');

    If Not fEmptyStr(strWhere) Then
      SQL.Add(' WHERE ' + strWhere );

    ExecSQL;
  End;

  FreeAndNil(qryTmp);
end;

{ TReplicaTabelaCNFBOL }

constructor TReplicaTabelaCNFBOL.Create(strNumLoj: String);
begin
  inherited Create('CNFBOL', strNumLoj, 'CNF_CODEMP', False);
end;

procedure TReplicaTabelaCNFBOL.pUpDateTmp(intSeq: Integer; strNomTab, strWhere: String);
Var
  qryTmp            : TUniQuery;
  LintMaxAutoIncrem : Integer;
begin
  qryTmp := fCriaQuery;

  LintMaxAutoIncrem := fMaxAutInc('CNFBOL');

  With qryTmp Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(' SET @AUT = ' + IntToStr(LintMaxAutoIncrem) + '; ');
    SQL.Add(' UPDATE ' + strNomTab   );
    SQL.Add('    SET CNF_CODEMP = ' + QuotedStr(FNumLoj) + ', ');
    SQL.Add('        AUTOINCREM = @AUT:=@AUT+1 ');

    If Not fEmptyStr(strWhere) Then
      SQL.Add(' WHERE ' + strWhere );

    ExecSQL;
  End;

  FreeAndNil(qryTmp);
end;

{ TReplicaTabelaLAYETI }

constructor TReplicaTabelaLAYETI.Create(strNumLoj: String);
begin
  inherited Create('LAYETI', strNumLoj, 'LAY_CODEMP', True);
end;

procedure TReplicaTabelaLAYETI.pUpDateTmp(intSeq: Integer; strNomTab,
  strWhere: String);
  Var
    qryTmp : TUniQuery;
begin
  qryTmp := fCriaQuery;

  With qryTmp Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(' SET @AUT = ' + IntToStr(intSeq) + '; ');
    SQL.Add(' UPDATE ' + strNomTab   );
    SQL.Add('    SET LAY_CODEMP = ' + QuotedStr(FNumLoj) + ', ');
    SQL.Add('        AUTOINCREM = CONCAT("' + fRetEmpresaFisica + '", RIGHT(CONCAT("000000000000000000", @AUT:=@AUT+1), 14), "' + FNumLoj + '") ');

    If Not fEmptyStr(strWhere) Then
      SQL.Add(' WHERE ' + strWhere );

    ExecSQL;
  End;

  FreeAndNil(qryTmp);
end;

{ TReplicaTabelaCadLot }

constructor TReplicaTabelaCadLot.Create(strNumLoj: String);
begin
  inherited Create('CADLOT', strNumLoj, 'LOT_CODEMP', True);
end;

procedure TReplicaTabelaCadLot.pUpDateTmp(intSeq: Integer; strNomTab,
  strWhere: String);
  Var
    qryTmp : TUniQuery;
begin
  qryTmp := fCriaQuery;

  With qryTmp Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(' SET @AUT = ' + IntToStr(intSeq) + '; ');
    SQL.Add(' UPDATE ' + strNomTab   );
    SQL.Add('    SET   ');
    SQL.Add('        LOT_DTABAL = DATE_ADD(' + fCurrentDate + ', INTERVAL -1 DAY), ');
    SQL.Add('        LOT_SALBAL = 0.0, ');
    SQL.Add('        LOT_SALDOS = 0.0, ');
    SQL.Add('        LOT_ML_BAL = 0.0, ');
    SQL.Add('        LOT_SAL_ML = 0.0, ');
    SQL.Add('        LOT_SALCON = 0.0, ');
    SQL.Add('        LOT_DIGCON = "N", ');
    SQL.Add('        LOT_ORDCON = NULL, ');
    SQL.Add('        LOT_SALCON = 0.0, ');
    SQL.Add('        LOT_DIFSAL = 0.0, ');
    SQL.Add('        LOT_LOCFIS = IF(LOT_NUMLOT = "A DEFINIR", "", LOT_LOCFIS), ');
    SQL.Add('        LOT_QTPD_V = 0.0, ');
    SQL.Add('        LOT_QTPD_F = 0.0, ');
    SQL.Add('        LOT_QTPD_P = 0.0, ');
    SQL.Add('        LOT_QTPD_E = 0.0, ');
    SQL.Add('        LOT_CODEMP = ' + QuotedStr(FNumLoj) + ', ');
    SQL.Add('        AUTOINCREM = CONCAT("' + fRetEmpresaFisica + '", RIGHT(CONCAT("000000000000000000", @AUT:=@AUT+1), 14), "' + FNumLoj + '") ');

    If Not fEmptyStr(strWhere) Then
      SQL.Add(' WHERE ' + strWhere );

    ExecSQL;
  End;

  FreeAndNil(qryTmp);

end;


{ TReplicaTabelaCONEMP }

constructor TReplicaTabelaCONEMP.Create(strNumLoj: String);
begin
  inherited Create('CONEMP', strNumLoj, 'CON_EMPORI', False);
end;

procedure TReplicaTabelaCONEMP.pUpDateTmp(intSeq: Integer; strNomTab, strWhere: String);
  Var
    qryTmp : TUniQuery;
begin
  qryTmp := fCriaQuery;

  With qryTmp Do
  Begin
    {AJUSTA A EMPRESA LOGADA NA TABELA TEMPORÁRIA}
    Close;
    SQL.Clear;
    SQL.Add(' UPDATE ' + strNomTab );
    SQL.Add(' SET CON_EMPDES = CON_EMPORI ');
    SQL.Add(' WHERE CON_EMPDES = ' + QuotedStr(FNumLoj));
    ExecSQL;

    Close;
    SQL.Clear;
    SQL.Add(' UPDATE ' + strNomTab   );
    SQL.Add('    SET CON_EMPORI = ' + QuotedStr(FNumLoj) );
    ExecSQL;
  End;
  FreeAndNil(qryTmp);
end;


{ TReplicaTabelaCADCAR }

constructor TReplicaTabelaCADCAR.Create(strNumLoj: String);
begin
  inherited Create('CADCAR', strNumLoj, 'CAR_CODEMP', True);
end;

procedure TReplicaTabelaCADCAR.pUpDateTmp(intSeq: Integer; strNomTab, strWhere: String);
Var
  qryTmp    : TUniQuery;
  strProCod : String;
  qryAux : TUniQuery;
begin

  qryAux := fCriaQuery;
  qryTmp := fCriaQuery;
  try

    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT AUTOINCREM FROM '+strNomTab);
    qryAux.Open;
    qryAux.First;
    while not qryAux.Eof do
    begin
      strProCod := '';
      While fEmptyStr(strProCod) Do
      Begin
        strProCod := fStrZero(fAtualizaProCod('CADCAR', '', ''), 5);
        If Not fEmptyStr(fRetNomeCartao(strProCod)) Then
          strProCod := '';
      End;

      strWhere := 'AUTOINCREM = '+qryAux.FieldByName('AUTOINCREM').AsString;

      With qryTmp Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(' UPDATE ' + strNomTab   );
        SQL.Add('    SET CAR_CODEMP = ' + QuotedStr(FNumLoj)   + ', ');
        SQL.Add('        CAR_CODCAR = ' + QuotedStr(strProCod) + ', ');
        SQL.Add('        AUTOINCREM = CONCAT("' + fRetEmpresaFisica + '", RIGHT(CONCAT("000000000000000000", :AUTOINCREM), 14), "' + FNumLoj + '") ');

        If Not fEmptyStr(strWhere) Then
          SQL.Add(' WHERE ' + strWhere );

        ParamByName('AUTOINCREM').AsString := intSeq.ToString;

        ExecSQL;
      End;

      Inc(intSeq);

      qryAux.Next;
    end;
  finally
    FreeAndNil(qryTmp);
    FreeAndNil(qryAux);
  end;
end;

end.
