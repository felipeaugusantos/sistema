unit untNetpoints;

interface

uses System.Classes,cxProgressBar;

type
  TNetpoints = Class(TComponent)
  private
    FQueNps: String;
    FFonCli: String;
    FCpfCli: String;
    FNumDoc: String;
    FCodVen: String;
    FEspDoc: String;
    FCodEmp: String;
    FCodCli: String;
    FSerie_: String;
    FTotPro: Double;
    FDtaEnt: TDateTime;
    FCpfCad: Boolean;
    FQtdNps10 : Integer;
    procedure SetQueNps(const Value: String);
    procedure SetFonCli(const Value: String);
    procedure SetCpfCli(const Value: String);
    function fCalculaQtdNps(strEspDoc: String; fltTotPro: Double): Integer;
    function fRetNsuParceiro(strCnpjParc: String): Integer;
  public
    property strQueNps: String read FQueNps write SetQueNps;
    property strFonCli: String read FFonCli write SetFonCli;
    property strCpfCli: String read FCpfCli write SetCpfCli;
    property strNumDoc: String read FNumDoc write FNumDoc;
    property strEspDoc: String read FEspDoc write FEspDoc;
    property strCodEmp: String read FCodEmp write FCodEmp;
    property strCodCli: String read FCodCli write FCodCli;
    property strSerie_: String read FSerie_ write FSerie_;
    property strCodVen: String read FCodVen write FCodVen;
    property fltTotPro: Double read FTotPro write FTotPro;
    property dtaDtaEnt: TDateTime read FDtaEnt write FDtaEnt;
    property blnCpfCad: Boolean read FCpfCad write FCpfCad;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function fGravaNetpointsPendencia(blnDevolu: Boolean): Boolean;
    function fDesejaNetpoints(strEspecie: String): Boolean;
    procedure pCarregarPedidoOrcamento;
    class procedure pTransmitirNetpoints(strNumDoc, strEspDoc, strCodEmp, strCodCli, strSerie_: String);
    class procedure pTransmitirNetpointsCancelados(strNumDoc, strEspDoc, strCodEmp, strCodCli, strSerie_: String);
    class procedure pCancelarNetpoints(strNumDoc, strEspDoc, strCodEmp,
      strCodCli, strSerie_, strNomFrm, strMotDel, strOpeDel: String);
    class procedure pDeletarPedidoOrcamento(strNumDoc, strEspDoc, strCodEmp: String);
    class function fTemCadNps(strNumDoc, strEspDoc, strCodEmp, strCodCli, strSerie_: String): Boolean;
    class function fGerarInterfaceAnalitica(pgbProgresso: TcxProgressBar): Boolean;
    class function fGerarInterfaceConciliacao(pgbProgresso: TcxProgressBar): Boolean;
    class function fValidaDadosDoSFTP(var strHost, strUser, strPass: String; var intPort: Integer): Boolean;
  End;

implementation

{ TNetpoints }

uses untFuncoesSimples, System.SysUtils, System.Math, Uni, untNetpointsTypes,
     untNetpointsWS, untFuncoes, Data.Db, Variants, untFuncoesGenerica,
     untNetpointsInterfaceAnalitica, untNetpointsInterfaceConciliacao, DateUtils,
     untlibSFTP;

constructor TNetpoints.Create(Aowner: TComponent);
begin
  Inherited Create(AOwner);
  FQueNps := 'N';
  FFonCli := '';
  FCpfCli := '';
  FNumDoc := '';
  FCodVen := '';
  FEspDoc := '';
  FCodEmp := '';
  FCodCli := '';
  FSerie_ := '';
  FTotPro := 0;
  FDtaEnt := 0;
  FCpfCad := False;
  FQtdNps10 := fCfgSis('NPSP10', varInteger);
end;

destructor TNetpoints.Destroy;
begin
  inherited Destroy;
end;

function TNetpoints.fCalculaQtdNps(strEspDoc: String;
  fltTotPro: Double): Integer;
  Var
    fltNpsCal : Double;
    fltNpsInt : Double;
    fltNpsFra : Double;
begin
  If (Pos(strEspDoc, 'OR_PD_') > 0) Or (fltTotPro = 0) Then
    Result := 0
  Else
  Begin
    fltNpsCal := ((fltTotPro * FQtdNps10) / 10);
    fltNpsInt := Int(fltNpsCal);
    fltNpsFra := Frac(fltNpsCal);

    If (Abs(fltNpsFra) >= 0.5)  Then
      fltNpsInt := fltNpsInt + IIF(fltNpsInt < 0, -1, 1);

    Result := fFloatToInt(fltNpsInt);
  End;
end;

function TNetpoints.fRetNsuParceiro(strCnpjParc: String): Integer;
  Var
    qruNpsNsu : TUniQuery;
    blnInTransaction : Boolean;
begin
  qruNpsNsu := fCriaQuery(Self);

  blnInTransaction := fInTransaction;
  Try
    Try

      If Not blnInTransaction Then
        fStartTransaction;

      With qruNpsNsu Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(' SELECT * ');
        SQL.Add('   FROM NPSNSU ');
        SQL.Add('  WHERE NSU_CNPARC = :CNPARC ');
        SQL.Add('    FOR UPDATE ');
        ParamByName('CNPARC').AsString := strCnpjParc;
        Open;

        If (IsEmpty) Then
        Begin
          Insert;
          FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('NPSNSU', VS_strCodEmp);
          FieldByName('NSU_NSUPAR').AsInteger := 1;
          FieldByName('NSU_CNPARC').AsString := strCnpjParc;
          Post;
        End;

        Result := FieldByName('NSU_NSUPAR').AsInteger;

        Edit;
        FieldByName('NSU_NSUPAR').AsInteger := FieldByName('NSU_NSUPAR').AsInteger + 1;
        Post;

        Close;

        If Not blnInTransaction Then
          fCommit;
      End;
    Except
      On E: Exception Do
      Begin
        Result := 0;

        If Not blnInTransaction Then
          fRollback;

        Raise Exception.Create(E.message + 'Não consegui pegar o proximo sequencial do NetPoints. Tente novamente!');
      End;
    End;
  Finally
    FreeAndNil(qruNpsNsu);
  End;
end;

function TNetpoints.fDesejaNetpoints(strEspecie: String): Boolean;
begin
  Result := (Pos(strEspecie, 'OR_PD_NF_EL_IF_IV_D1_') > 0) And
            (fCfgSis('UTINPS', varBoolean)) And
            (FQueNps = 'S');
end;

function TNetpoints.fGravaNetpointsPendencia(blnDevolu: Boolean): Boolean;
  Var
    qryCadNps : TUniQuery;
    strCnpjParceiro : String;
begin
  strCnpjParceiro := fCfgSis('CGCNPS', varString, strCodEmp);
  If fEmptyStr(strCnpjParceiro) Then
    strCnpjParceiro := fCampoTabela('EMP_C_G_C_', 'CADEMP', ['EMP_CODEMP'], [strCodEmp]);

  qryCadNps := fCriaQuery(Self);
  Try
    Try
      With qryCadNps Do
      Begin
        Close;
        SQL.Text := 'SELECT * FROM CADNPS WHERE FALSE';
        Open;
        Insert;
        FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CADNPS', VS_strCodEmp);
        FieldByName('NPS_CNPARC').AsString := strCnpjParceiro;
        FieldByName('NPS_NSUPAR').AsInteger := fRetNsuParceiro(strCnpjParceiro);
        FieldByName('NPS_NUMDOC').AsString := strNumDoc;
        FieldByName('NPS_ESPDOC').AsString := strEspDoc;
        FieldByName('NPS_CODEMP').AsString := strCodEmp;
        FieldByName('NPS_CODCLI').AsString := strCodCLi;

        If Not fEmptyStr(strSerie_) Then
          FieldByName('NPS_SERIE_').AsString := strSerie_
        Else
          FieldByName('NPS_SERIE_').Value := Null;

        FieldByName('NPS_NPSCAL').AsInteger := fCalculaQtdNps(strEspDoc, IIF(blnDevolu, -Abs(fltTotPro), fltTotPro));
        FieldByName('NPS_FONCLI').AsString := strFonCli;
        FieldByName('NPS_CPFCLI').AsString := strCpfCli;
        FieldByName('NPS_CODOPE').AsString := strCodVen;
        FieldByName('NPS_TOTPRO').AsFloat := IIF(blnDevolu, -Abs(fltTotPro), fltTotPro);
        FieldByName('NPS_QTDNPS').AsInteger := 0; // Será preenchido quando fizer o acumulo On-Line

        If (Pos(strEspDoc, 'OR_PD_') > 0) Then
        Begin
          FieldByName('NPS_STATUS').AsString := STATUS_NPS[tsnPedidoOrcamento];
          FieldByName('NPS_CODSTS').AsInteger := CODSTS_NPS[tsnPedidoOrcamento];
        End
        Else
        Begin
          FieldByName('NPS_STATUS').AsString := STATUS_NPS[tsnPendenteDeAcumulo];
          FieldByName('NPS_CODSTS').AsInteger := CODSTS_NPS[tsnPendenteDeAcumulo];
        End;

        FieldByName('NPS_CPFCAD').AsString := IIF(blnCpfCad, 'S', 'N');
        FieldByName('NPS_DTAENT').AsDateTime := dtaDtaEnt;
        FieldByName('NPS_IDEPDV').AsString := '1';
        Post;
        Close;
      End;

      Result := True;
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[TNetpoints.fGravaNetpointsPendencia]');
      End;
    End;
  Finally
    FreeAndNil(qryCadNps);
  End;
end;

class function TNetpoints.fTemCadNps(strNumDoc, strEspDoc, strCodEmp, strCodCli,
  strSerie_: String): Boolean;
  Var
    qryCadNps : TUniQuery;
begin
  qryCadNps := fCriaQuery(Nil);
  Try
    With qryCadNps Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT COUNT(*) CNT ');
      SQL.Add('  FROM CADNPS ');
      SQL.Add(' WHERE NPS_NUMDOC = :NUMDOC ');
      SQL.Add('   AND NPS_ESPDOC = :ESPDOC ');
      SQL.Add('   AND NPS_CODEMP = :CODEMP ');
      SQL.Add('   AND NPS_CODCLI = :CODCLI ');

      If Not fEmptyStr(strSerie_) Then
      Begin
        SQL.Add(' AND NPS_SERIE_ = :SERIE_ ');
        ParamByName('SERIE_').AsString := strSerie_;
      End
      Else
        SQL.Add(' AND NPS_SERIE_ IS NULL ');

      ParamByName('NUMDOC').AsString := strNumDoc;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('CODCLI').AsString := strCodCli;
      Open;
      Result := (FieldByName('CNT').AsInteger > 0);
      Close;
    End;
  Finally
    FreeAndNil(qryCadNps);
  End;
end;

class procedure TNetpoints.pCancelarNetpoints(strNumDoc, strEspDoc, strCodEmp,
  strCodCli, strSerie_, strNomFrm, strMotDel, strOpeDel: String);
  Var
    qryCadNps : TUniQuery;
    blnErro : Boolean;
begin
  qryCadNps := fCriaQuery(Nil);
  Try
    With qryCadNps Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT * ');
      SQL.Add('  FROM CADNPS ');
      SQL.Add(' WHERE NPS_NUMDOC = :NUMDOC ');
      SQL.Add('   AND NPS_ESPDOC = :ESPDOC ');
      SQL.Add('   AND NPS_CODEMP = :CODEMP ');
      SQL.Add('   AND NPS_CODCLI = :CODCLI ');

      If Not fEmptyStr(strSerie_) Then
      Begin
        SQL.Add(' AND NPS_SERIE_ = :SERIE_ ');
        ParamByName('SERIE_').AsString := strSerie_;
      End
      Else
        SQL.Add(' AND NPS_SERIE_ IS NULL ');

      ParamByName('NUMDOC').AsString := strNumDoc;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('CODCLI').AsString := strCodCli;
      Open;

      If Not IsEmpty Then
      Begin
        blnErro := False;
        Try
          fVerificaIntegridade(strNomFrm, 'CADNPS', qryCadNps, True, False, strMotDel, strOpeDel, False);
        Except
          On E: Exception Do
          Begin
            blnErro := True;
            pMensagensErro(E.Message, '[TNetpoints.pCancelarNetpoints]');
          End;
        End;

        If Not blnErro Then
          qryCadNps.Delete;
      End;

      Close;
    End;
  Finally
    FreeAndNil(qryCadNps);
  End;
end;

procedure TNetpoints.pCarregarPedidoOrcamento;
  Var
    qryCadNps : TUniQuery;
begin
  qryCadNps := fCriaQuery(Self);
  Try
    Try
      With qryCadNps Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT * ');
        SQL.Add('  FROM CADNPS ');
        SQL.Add(' WHERE TRUE ');
        SQL.Add('   AND NPS_NUMDOC = :NUMDOC ');
        SQL.Add('   AND NPS_ESPDOC = :ESPDOC ');
        SQL.Add('   AND NPS_CODEMP = :CODEMP ');
        SQL.Add('   AND NPS_CODCLI = :CODCLI ');

        If Not fEmptyStr(strSerie_) Then
        Begin
          SQL.Add(' AND NPS_SERIE_ = :SERIE_ ');
          ParamByName('SERIE_').AsString := strSerie_;
        End
        Else
          SQL.Add(' AND NPS_SERIE_ IS NULL ');

        ParamByName('NUMDOC').AsString := strNumDoc;
        ParamByName('ESPDOC').AsString := strEspDoc;
        ParamByName('CODEMP').AsString := strCodEmp;
        ParamByName('CODCLI').AsString := strCodCli;
        Open;

        strQueNps := 'N';

        If (Not IsEmpty) Then
        Begin
          strFonCli := FieldByName('NPS_FONCLI').AsString;
          strCpfCli := FieldByName('NPS_CPFCLI').AsString;
          strCodVen := FieldByName('NPS_CODOPE').AsString;
          fltTotPro := FieldByName('NPS_TOTPRO').AsFloat;
          dtaDtaEnt := FieldByName('NPS_DTAENT').AsDateTime;
          strQueNps := 'S';
        End;

        Close;
      End;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TNetpoints.pCarregarPedidoOrcamento]');
    End;
  Finally
    FreeAndNil(qryCadNps);
  End;
end;

class procedure TNetpoints.pDeletarPedidoOrcamento(strNumDoc, strEspDoc,
  strCodEmp: String);
  Var
    qryCadNps : TUniQuery;
begin
  If (Pos(strEspDoc, 'OR_PD_') > 0) Then
  Begin
    qryCadNps := fCriaQuery(Nil);
    Try
      Try
        With qryCadNps Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add('DELETE ');
          SQL.Add('  FROM CADNPS ');
          SQL.Add(' WHERE NPS_NUMDOC = :NUMDOC ');
          SQL.Add('   AND NPS_ESPDOC = :ESPDOC ');
          SQL.Add('   AND NPS_CODEMP = :CODEMP ');
          ParamByName('NUMDOC').AsString := strNumDoc;
          ParamByName('ESPDOC').AsString := strEspDoc;
          ParamByName('CODEMP').AsString := strCodEmp;
          ExecSQL;
        End;
      Except
        On E: Exception Do
          pMensagensErro(E.Message, '[TNetpoints.pDeletarPedidoOrcamento]');
      End;
    Finally
      FreeAndNil(qryCadNps);
    End;
  End;
end;

class procedure TNetpoints.pTransmitirNetpoints(strNumDoc, strEspDoc, strCodEmp, strCodCli, strSerie_: String);
  Var
    qryCadNps : TUniQuery;
    objNpsWS : TNetpointsWS;
    intQtdNps : Integer;
    strMensag : String;
    tipStatusNps : TTipoStatusNps;
    blnCliCad : Boolean;
    strCpfOpe : String;
begin
  If (Pos(strEspDoc, 'OR_PD_') > 0) Then
    Exit;

  qryCadNps := fCriaQuery(Nil);
  objNpsWS := TNetpointsWS.Create(Nil, strCodEmp);
  Try
    Try
      With qryCadNps Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT * ');
        SQL.Add('  FROM CADNPS ');
        SQL.Add(' WHERE TRUE ');

        If fEmptyStr(strNumDoc + strEspDoc + strCodEmp + strCodCli + strSerie_) Then
        begin
          SQL.Add('   AND NPS_CODSTS IN (' + IntToStr( CODSTS_NPS[tsnPendenteDeAcumulo] ) + ', ' +
                                             IntToStr( CODSTS_NPS[tsnPendenteDesfazimento] ) + ' ) ');
          SQL.Add(' ORDER BY NPS_DTAENT DESC ');
          SQL.Add(' LIMIT ' + IntToStr(QTD_VERIFICA_PENDENCIA));
        End
        Else
        Begin
          SQL.Add('   AND NPS_NUMDOC = :NUMDOC ');
          SQL.Add('   AND NPS_ESPDOC = :ESPDOC ');
          SQL.Add('   AND NPS_CODEMP = :CODEMP ');
          SQL.Add('   AND NPS_CODCLI = :CODCLI ');

          If Not fEmptyStr(strSerie_) Then
          Begin
            SQL.Add(' AND NPS_SERIE_ = :SERIE_ ');
            ParamByName('SERIE_').AsString := strSerie_;
          End
          Else
            SQL.Add(' AND NPS_SERIE_ IS NULL ');

          ParamByName('NUMDOC').AsString := strNumDoc;
          ParamByName('ESPDOC').AsString := strEspDoc;
          ParamByName('CODEMP').AsString := strCodEmp;
          ParamByName('CODCLI').AsString := strCodCli;
        End;

        Open;

        First;
        While Not Eof Do
        Begin
          blnCliCad := True;

          strCpfOpe := fCampoTabela('OPE_NUMCPF', 'CADOPE', ['OPE_CODOPE'], [FieldByName('NPS_CODOPE').AsString]);

          If (FieldByName('NPS_CPFCAD').AsString = 'N') Then
          Begin
            blnCliCad := objNpsWS.fCadastrarCliente(FieldByName('NPS_CPFCLI').AsString,
                                                    FieldByName('NPS_FONCLI').AsString,
                                                    strCpfOpe,
                                                    0,
                                                    False,
                                                    FieldByName('NPS_CNPARC').AsString);
          End;

          If (blnCliCad) Then
          Begin
            If (STATUS_NPS[tsnPendenteDeAcumulo] = FieldByName('NPS_STATUS').AsString) Then
            Begin
              tipStatusNps := objNpsWS.fAcionarAcumuloOnLine(FieldByName('NPS_NUMDOC').AsString,
                                                             FieldByName('NPS_ESPDOC').AsString,
                                                             FieldByName('NPS_CODEMP').AsString,
                                                             FieldByName('NPS_CODCLI').AsString,
                                                             FieldByName('NPS_SERIE_').AsString,
                                                             FieldByName('NPS_CPFCLI').AsString,
                                                             strCpfOpe,
                                                             FieldByName('NPS_IDEPDV').AsString,
                                                             FieldByName('NPS_DTAENT').AsDateTime,
                                                             FieldByName('NPS_TOTPRO').AsFloat,
                                                             intQtdNps,
                                                             strMensag,
                                                             (FieldByName('NPS_TOTPRO').AsFloat < 0),
                                                             FieldByName('NPS_CNPARC').AsString,
                                                             FieldByName('NPS_NSUPAR').AsInteger);

              Edit;
              FieldByName('NPS_OBSERV').AsString := strMensag;
              FieldByName('NPS_STATUS').AsString := STATUS_NPS[tipStatusNps];
              FieldByName('NPS_CODSTS').AsInteger := CODSTS_NPS[tipStatusNps];
              If (tipStatusNps In [tsnAcumulado, tsnAcumuloJaEnviado]) Then
                FieldByName('NPS_QTDNPS').AsInteger := intQtdNps;
              Post;
            End
            Else If (STATUS_NPS[tsnPendenteDesfazimento] = FieldByName('NPS_STATUS').AsString) Then
            Begin
              tipStatusNps := objNpsWS.fConfirmacaoEDesfazimentoDeAcumulo(ttaDesfazimentoAcumulo,
                                                                          FieldByName('NPS_NUMDOC').AsString,
                                                                          FieldByName('NPS_ESPDOC').AsString,
                                                                          FieldByName('NPS_CODEMP').AsString,
                                                                          FieldByName('NPS_CODCLI').AsString,
                                                                          FieldByName('NPS_SERIE_').AsString,
                                                                          FieldByName('NPS_CPFCLI').AsString,
                                                                          strCpfOpe,
                                                                          FieldByName('NPS_IDEPDV').AsString,
                                                                          FieldByName('NPS_TOTPRO').AsFloat,
                                                                          FieldByName('NPS_DTAENT').AsDateTime,
                                                                          intQtdNps,
                                                                          strMensag,
                                                                          (FieldByName('NPS_TOTPRO').AsFloat < 0),
                                                                          FieldByName('NPS_CNPARC').AsString,
                                                                          FieldByName('NPS_NSUPAR').AsInteger);

              Edit;
              FieldByName('NPS_OBSERV').AsString := strMensag;
              FieldByName('NPS_STATUS').AsString := STATUS_NPS[tipStatusNps];
              FieldByName('NPS_CODSTS').AsInteger := CODSTS_NPS[tipStatusNps];
              If (tipStatusNps In [tsnAcumulado, tsnAcumuloJaEnviado]) Then
                FieldByName('NPS_QTDNPS').AsInteger := intQtdNps;
              Post;
            End;
          End;

          Next;
        End;

        Close;
      End;
    Except
    End;
  Finally
    FreeAndNil(qryCadNps);
    FreeAndNil(objNpsWS);
  End;
end;

class procedure TNetpoints.pTransmitirNetpointsCancelados(strNumDoc, strEspDoc,
  strCodEmp, strCodCli, strSerie_: String);
  Var
    qryCadNps : TUniQuery;
    objNpsWS : TNetpointsWS;
    intQtdNps : Integer;
    strMensag : String;
    tipStatusNps : TTipoStatusNps;
begin
  If (Pos(strEspDoc, 'OR_PD_') > 0) Then
    Exit;

  qryCadNps := fCriaQuery(Nil);
  objNpsWS := TNetpointsWS.Create(Nil, strCodEmp);
  Try
    Try
      With qryCadNps Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT * ');
        SQL.Add('  FROM DEL_CADNPS ');
        SQL.Add(' WHERE TRUE ');

        If fEmptyStr(strNumDoc + strEspDoc + strCodEmp + strCodCli + strSerie_) Then
        begin
          SQL.Add('   AND NPS_CODSTS NOT IN ( ' + IntToStr(CODSTS_NPS[tsnCancelado]) + ', ' +
                                                  IntToStr(CODSTS_NPS[tsnPedidoOrcamento]) + ' ) ');
          SQL.Add(' ORDER BY DTADEL DESC ');
          SQL.Add(' LIMIT ' + IntToStr(QTD_VERIFICA_PENDENCIA));
        End
        Else
        Begin
          SQL.Add('   AND NPS_NUMDOC = :NUMDOC ');
          SQL.Add('   AND NPS_ESPDOC = :ESPDOC ');
          SQL.Add('   AND NPS_CODEMP = :CODEMP ');
          SQL.Add('   AND NPS_CODCLI = :CODCLI ');

          If Not fEmptyStr(strSerie_) Then
          Begin
            SQL.Add(' AND NPS_SERIE_ = :SERIE_ ');
            ParamByName('SERIE_').AsString := strSerie_;
          End
          Else
            SQL.Add(' AND NPS_SERIE_ IS NULL ');

          ParamByName('NUMDOC').AsString := strNumDoc;
          ParamByName('ESPDOC').AsString := strEspDoc;
          ParamByName('CODEMP').AsString := strCodEmp;
          ParamByName('CODCLI').AsString := strCodCli;
        End;

        Open;

        First;
        While Not Eof Do
        Begin
          If (STATUS_NPS[tsnAcumulado] = FieldByName('NPS_STATUS').AsString) Or
             (STATUS_NPS[tsnPendenteDesfazimento] = FieldByName('NPS_STATUS').AsString) Then
          Begin
            tipStatusNps := objNpsWS.fConfirmacaoEDesfazimentoDeAcumulo(ttaDesfazimentoAcumulo,
                                                                        FieldByName('NPS_NUMDOC').AsString,
                                                                        FieldByName('NPS_ESPDOC').AsString,
                                                                        FieldByName('NPS_CODEMP').AsString,
                                                                        FieldByName('NPS_CODCLI').AsString,
                                                                        FieldByName('NPS_SERIE_').AsString,
                                                                        FieldByName('NPS_CPFCLI').AsString,
                                                                        fCampoTabela('OPE_NUMCPF', 'CADOPE', ['OPE_CODOPE'], [FieldByName('NPS_CODOPE').AsString]),
                                                                        FieldByName('NPS_IDEPDV').AsString,
                                                                        FieldByName('NPS_TOTPRO').AsFloat,
                                                                        FieldByName('NPS_DTAENT').AsDateTime,
                                                                        intQtdNps,
                                                                        strMensag,
                                                                        (FieldByName('NPS_TOTPRO').AsFloat < 0),
                                                                        FieldByName('NPS_CNPARC').AsString,
                                                                        FieldByName('NPS_NSUPAR').AsInteger);

            Edit;
            FieldByName('NPS_OBSERV').AsString := strMensag;
            FieldByName('NPS_STATUS').AsString := STATUS_NPS[tipStatusNps];
            FieldByName('NPS_CODSTS').AsInteger := CODSTS_NPS[tipStatusNps];
            Post;
          End
          Else
          Begin
            Edit;
            FieldByName('NPS_STATUS').AsString := STATUS_NPS[tsnCancelado];
            FieldByName('NPS_CODSTS').AsInteger := CODSTS_NPS[tsnCancelado];
            Post;
          End;

          Next;
        End;

        Close;
      End;
    Except
    End;
  Finally
    FreeAndNil(qryCadNps);
    FreeAndNil(objNpsWS);
  End;
end;

procedure TNetpoints.SetCpfCli(const Value: String);
begin
  If fEmptyStr(Value) And (FQueNps = 'S') Then
    Raise Exception.Create('É necessário informar o CPF do cliente!')
  Else
    FCpfCli := Value;
end;

procedure TNetpoints.SetFonCli(const Value: String);
begin
  If (Not FCpfCad) And (fEmptyStr(Value)) And (FQueNps = 'S') Then
    Raise Exception.Create('É necessário informar o celular do cliente!')
  Else
    FFonCli := Value;

  If Not fEmptyStr(FFonCli) Then
  Begin
    If Not fValidaTelefone(FFonCli) Then
    Begin
      FFonCli := '';
      Raise Exception.Create('É necessário informar um número de celular válido!');
    End;
  End;
end;

procedure TNetpoints.SetQueNps(const Value: String);
begin
  If Pos(Value, 'SN') > 0 Then
    FQueNps := Value
  Else
    Raise Exception.Create('Quer ganhar Netpoints deve ser (S) ou (N)!');
end;


class function TNetpoints.fValidaDadosDoSFTP(var strHost, strUser, strPass: String; var intPort: Integer): Boolean;
begin
  strHost := fCfgSis('NPSFTP', varString);
  strUser := fCfgSis('SFTPUS', varString);
  strPass := fCfgSis('SFTPSE', varString);
  intPort := fCfgSis('SFTPPT', varInteger);

  Result := (Not fEmptyStr(strHost)) And
            (Not fEmptyStr(strUser)) And
            (Not fEmptyStr(strPass)) And
            (intPort <> 0);
end;


class function TNetpoints.fGerarInterfaceAnalitica(pgbProgresso: TcxProgressBar): Boolean;
  Var
    objIntAna : TNetpointsInterfaceAnalitica;
    strNomeTrava : String;
begin
  Result := True;

  strNomeTrava := 'NETPOINTS_INTERFACE_ANALITICA';

  If fLock_Unlock(strNomeTrava, True, False, False, '', False) Then
  Begin
    objIntAna := TNetpointsInterfaceAnalitica.Create(Nil);
    Try
      objIntAna.fEnviar(IncDay(VS_Date, -5), IncDay(VS_Date, -1));
    Finally
      fLock_Unlock(strNomeTrava, False, False, False, '', False);
      FreeAndNil(objIntAna);
    End;
  End;
end;

class function TNetpoints.fGerarInterfaceConciliacao(pgbProgresso: TcxProgressBar): Boolean;
  Var
    objIntCon : TNetpointsInterfaceImportacao;
    objIntRes : TNetpointsInterfaceImportacao;
    strNomeTrava : String;
    strHost : String;
    strUser : String;
    strPass : String;
    intPort : Integer;
begin
  Result := True;

  strNomeTrava := 'NETPOINTS_INTERFACE_CONCILIACAO';

  If fLock_Unlock(strNomeTrava, True, False, False, '', False) Then
  Begin
    Try
      objIntCon := TNetpointsInterfaceImportacao.Create(TNetpointsInterfaceConciliacao.Create());
      objIntRes := TNetpointsInterfaceImportacao.Create(TNetpointsInterfaceResgate.Create());

      If (fValidaDadosDoSFTP(strHost, strUser, strPass, intPort)) And
         ((Not fEmptyStr(objIntCon.strPathConciliacaoOut)) And (DirectoryExists(objIntCon.strPathConciliacaoOut))) Then
      Begin
        If TlibSFTP.fGetFiles(strHost, strUser, strPass, '/' + PATH_SFTP_INT_CONCILIACAO_OUT, objIntCon.strPathConciliacaoOut, intPort, '.csv') Then
        Begin
          objIntCon.pImportar(objIntCon.strPathConciliacaoOut);
          objIntRes.pImportar(objIntRes.strPathConciliacaoOut);
        End;
      End;
    Finally
      fLock_Unlock(strNomeTrava, False, False, False, '', False);

      If Assigned(objIntCon) Then
        FreeAndNil(objIntCon);

      If Assigned(objIntRes) Then
        FreeAndNil(objIntRes);
    End;
  End;
end;


end.
