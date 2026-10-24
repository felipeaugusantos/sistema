{*********************************************************}
{* CLASSE BAIXA ENTREGADORES                             *}
{*                                                       *}
{* DATA......: 30/07/2009                                *}
{* AUTOR.....: JOAO LUIS CATARINO                        *}
{*                                                       *}
{******************************************************AF*}
unit untBaixaComEntreg;

interface

uses Classes, frxClass, Uni, DB,  UniClientDataSet, strUtils, untTypesSistema;

type
  TBaixaEnt = class(TComponent)
  private
    FProEnt: String;
    FCodEnt: String;
    FTipEnt: TTipEbx;
    FInsDoc: TInsDoc;
    FChaAce: String;

    qryComEng: TUniQuery;
    qryComEnd: TUniQuery;
    FDocPen: Boolean;

    procedure setTipEnt(const Value: TTipEbx);
    procedure setInsDoc(const Value: TInsDoc);

    procedure pAfterScroll(DataSet: TDataSet);
    procedure pCarregaClienteEntrega;
    function  fRetNomeCliente(strNumDoc, strEspDoc, strCodEmp, strCodCli: String): String;
    function  fExisteDocumentosPendentes: Boolean;
    function fRetNomClienteConsumidorFat(strNumDoc, strEspDoc, strCodEmp: String): String;
    procedure pMarcaMotoristaComoDisponível;

  public
    strEspPer: String;

    cdsComEng: TUniClientDataSet;
    cdsComEnd: TUniClientDataSet;

    stlBaiEng: TStringList;
    stlBaiEnd: TStringList;
    intRecNo : Integer;

    procedure pMarcaTodosDocumentosEntregaPeloPai(strAutIncPai: String; strTipMar: String);
    function fStatusComEng(strAutInc: String): String;

    function fTipoBaixa: TTipoBaixaControleEntregadores;
    function fCarregaEntregasPendentes: Boolean;

    procedure pfecharConsulta;
    function  fBaixarEntrega: Boolean;
    procedure pMarca(blnTodas: Boolean; strTipMar: String);

    function  fMarcaDocumento(strNumDoc, strEspDoc, strCodEmp: String; strTipMar: String='S'): Boolean;
    procedure  pMarcaEntrega(strAutInc, strTipMar: String);
    function  fFilterComEnd: String;

    procedure setCodEnt(const Value: String);
    property strCodEnt: String  Read FCodEnt Write setCodEnt;
    property blnDocPen: Boolean Read FDocPen Write FDocPen;

    function getTipEnt: TTipEbx;
    function getInsDoc: TInsDoc;

    procedure setChaAce(const Value: String);
    function  getChaAce: String;

    Constructor Create(Owner: TComponent); Reintroduce;
    Destructor Destroy; Override;


  end;

implementation

uses SysUtils, untFuncoesSimples, untConstantes, UntMsgInterna, untFuncFat,
  untLiberacao;

{ TComEnt }

Constructor TBaixaEnt.Create(Owner: TComponent);
Var
  strTipEnt: String;
begin
  qryComEng := fCriaQuery(Self);
  qryComEnd := fCriaQuery(Self);
  stlBaiEng := TStringList.Create;
  stlBaiEnd := TStringList.Create;
  blnDocPen := False;

  strTipEnt := fCfgSis('TIPEBX', VarString);

  If (SameText(strTipEnt, 'B')) Then
    setTipEnt(tebBarras)
  Else If (SameText(strTipEnt, 'S')) Then
    setTipEnt(tebSenha)
  Else
    setTipEnt(tebCodigo);

  If (fCfgSis('TPDCEN', VarString) = '2') Then
    setInsDoc(idoBarras)
  Else
    setInsDoc(idoDocumento);

  setChaAce('');
end;

Destructor TBaixaEnt.Destroy;
begin
  pfecharConsulta;

  If Assigned(stlBaiEng) Then
    FreeAndNil(stlBaiEng);

  If Assigned(stlBaiEnd) Then
    FreeAndNil(stlBaiEnd);

  Inherited Destroy;
end;

procedure TBaixaEnt.setChaAce(const Value: String);
begin
  FChaAce := Value;
end;

procedure TBaixaEnt.setCodEnt(const Value: String);
begin

  If Not fEmptyStr(Value) Then
    FCodEnt := Value
  Else
    Raise ExceptionAutCom.Create('O campo Código do entregador deve ter um valor!');

end;

procedure TBaixaEnt.setInsDoc(const Value: TInsDoc);
begin
  FInsDoc := Value;
end;

procedure TBaixaEnt.setTipEnt(const Value: TTipEbx);
begin
  FTipEnt := Value;
end;

function TBaixaEnt.fCarregaEntregasPendentes: Boolean;
  Var
    strSql: String;

  function fGetSQLTotDoc(blnSomenteBaixados: Boolean): String;
  begin
    Result := ' IFNULL((SELECT COUNT(*) FROM COMEND WHERE END_SEQENG = COMENG.AUTOINCREM '+IIF(blnSomenteBaixados,'AND END_DTABAI IS NOT NULL','')+' ), 0) '
  end;

begin

  strSql := '';
  strSql := strSql + '  SELECT SQL_NO_CACHE          ';
  strSql := strSql + '    AUTOINCREM,                ';
  strSql := strSql + '    ENG_PROENT,                ';
  strSql := strSql + '    ENG_CODEMP,                ';
  strSql := strSql + '    ENG_CODENT,                ';
  strSql := strSql + '    ENG_DTACAD,                ';
  strSql := strSql + '    ENG_HRACAD,                ';
  strSql := strSql + '    '+fGetSQLTotDoc(False)+' AS ENG_TOTDOC, ';
  strSql := strSql + '    '+fGetSQLTotDoc(True) +' AS ENG_TOTBAI, ';
  strSql := strSql + '    CAST(IF('+fGetSQLTotDoc(True)+'>0, "P", " ") AS CHAR(1)) AS MARCAD ';
  strSql := strSql + '  FROM                         ';
  strSql := strSql + '    COMENG                     ';
  strSql := strSql + '  WHERE                        ';
  strSql := strSql + '    ENG_CODENT = :CODENT AND   ';
  strSql := strSql + '    ENG_DTABAI IS NULL         ';
  strSql := strSql + '  ORDER BY                     ';
  strSql := strSql + '    ENG_CODENT                 ';

  With qryComEng Do
  Begin
    Close;
    sql.Clear;
    SQL.Add(strSql);
    ParamByName('CODENT').AsString := strCodEnt;
    Open;

    If IsEmpty Then
      Result := False
    Else
      Result := True;
  End;

  If Result Then
  Begin
    With qryComEnd Do
    Begin
      strSql := ' ';
      strSql := strSql + '  SELECT SQL_NO_CACHE       ';
      strSql := strSql + '    "N"          AS MARCAD, ';
      strSql := strSql + '    D.END_SEQENG,           ';
      strSql := strSql + '    D.END_CODEMP,           ';
      strSql := strSql + '    D.END_NUMDOC,           ';
      strSql := strSql + '    D.END_ESPDOC,           ';
      strSql := strSql + '    D.END_EMPDOC,           ';
      strSql := strSql + '    D.END_CODCLI,           ';
      strSql := strSql + '    "' + fReplicatorStr(' ',69) + '" AS CLI_CODCLI, ';
      strSql := strSql + '    D.AUTOINCREM            ';
      strSql := strSql + '  FROM                      ';
      strSql := strSql + '    COMEND D                ';
      strSql := strSql + '    INNER JOIN COMENG G ON (D.END_SEQENG = G.AUTOINCREM) ';
      strSql := strSql + '  WHERE                      ';
      strSql := strSql + '    G.ENG_DTABAI IS NULL AND ';
      strSql := strSql + '    D.END_DTABAI IS NULL AND ';
      strSql := strSql + '    G.ENG_CODENT = :CODENT   ';
      strSql := strSql + '  ORDER BY                   ';
      strSql := strSql + '    D.END_NUMDOC             ';

      Close;
      sql.Clear;
      SQL.Add(strSql);
      ParamByName('CODENT').AsString := strCodEnt;
      Open;

      RecordCount;

      If IsEmpty Then
        Result := False
      Else
        Result := True;

    End;

  End;


  If Not Result Then
    pfecharConsulta
  Else
  Begin
    cdsComEng := fCriaClientDatset(qryComEng);
    cdsComEnd := fCriaClientDatset(qryComEnd);
    cdsComEnd.IndexFieldNames := 'END_NUMDOC';
    pCarregaClienteEntrega;
    cdsComEng.AfterScroll := pAfterScroll;

    If (Not blnDocPen) Then
    Begin
      cdsComEnd.Filter   := fFilterComEnd;
      cdsComEnd.Filtered := True;
    End;

    cdsComEng.First;
  End;

end;

procedure TBaixaEnt.pAfterScroll(DataSet: TDataSet);
begin
  cdsComEnd.Filter   := fFilterComEnd;
  cdsComEnd.Filtered := True;
  intRecNo := DataSet.RecNo;   
end;

procedure TBaixaEnt.pfecharConsulta;
begin

  If Assigned(cdsComEng) Then
  Begin
    cdsComEng.EmptyDataSet;
    FreeAndNil(cdsComEng);
  End;

  If Assigned(cdsComEnd) Then
  Begin
    cdsComEnd.EmptyDataSet;
    FreeAndNil(cdsComEnd);
  End;

  If Assigned(stlBaiEng) Then
    stlBaiEng.Clear;

  If Assigned(stlBaiEnd) Then
    stlBaiEnd.Clear;
end;

function TBaixaEnt.fBaixarEntrega: Boolean;
  Var
    qryBaixa : TUniQuery;
    intIndex : Integer;
    objLiberacao : TLiberacao;
begin

  Try

    Result    := True;

    If (fExisteDocumentosPendentes) Then
    Begin
      objLiberacao := TLiberacao.Create;
      try
        objLiberacao.objMsgLibera.pAddTexto('Liberação para baixa parcial de documentos referente a entregas');

        objLiberacao.strDirAce := 'BAIENT';
        objLiberacao.strMsgSen := 'Liberação na Baixa de Entregas';
        objLiberacao.strCodOpe := strLoginUsuarioLogado;

        If (Not objLiberacao.fLibera) Then
        Begin
          Result := False;
        End
      finally
        FreeAndNil(objLiberacao);
      end;
    End;

    If (Result) Then
    Begin

      fStartTransaction;

      For intIndex := 0 To stlBaiEng.Count -1 Do
      Begin

        FProEnt := stlBaiEng[intIndex];

        qryBaixa := fCriaQuery(Nil);

        With qryBaixa Do
        Begin
          sql.Add(' UPDATE                  ');
          sql.Add('   COMENG                ');
          sql.Add(' SET                     ');
          sql.Add('   ENG_DTABAI = :DTABAI, ');
          sql.Add('   ENG_HRABAI = :HRABAI  ');
          sql.Add(' WHERE                   ');
          sql.Add('   ENG_PROENT = :PROENT  ');

          ParamByName('DTABAI').AsDateTime := VS_Date;
          ParamByName('HRABAI').AsDateTime := fTime();
          ParamByName('PROENT').AsString   := FProEnt;

          ExecSQL;
        End;

        FreeAndNil(qryBaixa);

      End;

      For intIndex := 0 To stlBaiEnd.Count - 1 Do
      Begin

        qryBaixa := fCriaQuery(Nil);

        With qryBaixa, Sql Do
        Begin
          If fCfgSis('MATCON', varBoolean) Then
          Begin
            Close;
            Clear;

            Add(' UPDATE MOVRQG                                    ');
            Add(' INNER JOIN COMEND ON END_NUMDOC = REQ_NUMREQ AND ');
            Add('                      END_ESPDOC = "RQ"       AND ');
            Add('                      END_EMPDOC = REQ_CODEMP AND ');
            Add('                      END_CODCLI = REQ_FORCLI     ');
            Add(' SET REQ_BAIXAD = "S"                             ');
            Add(' WHERE COMEND.AUTOINCREM = :AUTINC                ');

            ParamByName('AUTINC').AsString   := stlBaiEnd[intIndex];

            ExecSQL;
          End;

          Close;
          Clear;
          Add(' UPDATE                  ');
          Add('   COMEND                ');
          Add(' SET                     ');
          Add('   END_DTABAI = :DTABAI, ');
          Add('   END_HRABAI = :HRABAI  ');
          Add(' WHERE                   ');
          Add('   COMEND.AUTOINCREM = :AUTINC  ');

          ParamByName('DTABAI').AsDateTime := VS_Date;
          ParamByName('HRABAI').AsDateTime := fTime();
          ParamByName('AUTINC').AsString   := stlBaiEnd[intIndex];

          ExecSQL;
        End;

        FreeAndNil(qryBaixa);

      End;

      pMarcaMotoristaComoDisponível;

      fCommit;

    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      fRollBack;
      pMensagensErro(E.Message, '[TBaixaEnt.pBaixarEntrega]')
    End;
  End;

  If (Result) Then
    pfecharConsulta;

end;

procedure TBaixaEnt.pMarca(blnTodas: Boolean; strTipMar: String);
begin

  If Not Assigned(cdsComEng) Then
    Exit;

  If cdsComEng.IsEmpty Then
    Exit;

  cdsComEng.AfterScroll := Nil;

  If Not blnTodas Then
  Begin

    FProEnt := cdsComEng.FieldByName('ENG_PROENT').AsString;

    With cdsComEng Do
    Begin
      If (strTipMar = 'S') Then
        pAddStringList(stlBaiEng, FProEnt);

      Edit;
      FieldByName('MARCAD').AsString := strTipMar;
      Post;
    End;

  End
  Else
  Begin
    stlBaiEng.Clear;

    With cdsComEng Do
    Begin
      DisableControls;
      First;

      While Not Eof Do
      Begin
        pAddStringList(stlBaiEng, FieldByName('ENG_PROENT').AsString);

        Edit;
        FieldByName('MARCAD').AsString := strTipMar;
        Post;
        Next;
      End;

      First;
      EnableControls;
    End;

  End;

  cdsComEng.AfterScroll := pAfterScroll;

end;

procedure TBaixaEnt.pMarcaTodosDocumentosEntregaPeloPai(strAutIncPai: String; strTipMar: String);
  Var
    qryGen: TUniQuery;
begin
   qryGen := fCriaQuery;
   Try
     qryGen.SQL.Text := 'SELECT AUTOINCREM, END_NUMDOC, END_ESPDOC, END_EMPDOC FROM COMEND '+
                        ' WHERE END_DTABAI IS NULL '+
                        '   AND END_SEQENG = '+QuotedStr(strAutIncPai);

     qryGen.Open;

     qryGen.First;
     If Not qryGen.IsEmpty Then
     Begin
       While Not qryGen.Eof Do
       Begin
         Self.fMarcaDocumento(qryGen.FieldByName('END_NUMDOC').AsString,
                              qryGen.FieldByName('END_ESPDOC').AsString,
                              qryGen.FieldByName('END_EMPDOC').AsString,
                              strTipMar);
         qryGen.Next;
       End;
     End;
   Finally
     FreeAndNil(qryGen);
   End;
end;

procedure TBaixaEnt.pCarregaClienteEntrega;
begin

  With cdsComEnd Do
  Begin

    DisableControls;

    First;

    While Not Eof Do
    Begin
      Edit;

      If FieldByName('END_ESPDOC').AsString = 'PC' Then
        FieldByName('CLI_CODCLI').AsString := FieldByName('END_CODCLI').AsString + '-' + fRetNomFornecedor(FieldByName('END_CODCLI').AsString)

      Else If FieldByName('END_ESPDOC').AsString = 'OS' Then
        FieldByName('CLI_CODCLI').AsString := TMsgInterna.fRetOperadorEnvio(RightStr(FieldByName('END_NUMDOC').AsString, 6))

      Else
        FieldByName('CLI_CODCLI').AsString := FieldByName('END_CODCLI').AsString + '-' +
                                              fRetNomeCliente(FieldByName('END_NUMDOC').AsString,
                                                              FieldByName('END_ESPDOC').AsString,
                                                              FieldByName('END_EMPDOC').AsString,
                                                              FieldByName('END_CODCLI').AsString);

      Post;
      Next;
    End;
    
    EnableControls;

  End;

end;

function TBaixaEnt.fMarcaDocumento(strNumDoc, strEspDoc, strCodEmp: String; strTipMar: String='S'): Boolean;
  Var
   auxAutIncPai: String;
begin
  Result := False;

  Try

    With cdsComEnd Do
    Begin
      Filtered := False;
      Filter   := '';
      Filter   := 'END_NUMDOC = ' + QuotedStr(strNumDoc) + ' AND ' +
                  'END_ESPDOC = ' + QuotedStr(strEspDoc) + ' AND ' +
                  'END_EMPDOC = ' + QuotedStr(strCodEmp);
      Filtered := True;

      If (Not IsEmpty) Then
      Begin
        If (Self.fTipoBaixa = tpbceRapida) Then
        Begin
          Edit;

          If strTipMar = 'N' Then
          Begin
            pDelStringList(stlBaiEnd, FieldByName('AUTOINCREM').AsString);
            FieldByName('MARCAD').AsString := 'N';
          End
          Else
          Begin
            pAddStringList(stlBaiEnd, FieldByName('AUTOINCREM').AsString);
            FieldByName('MARCAD').AsString := 'S';
          End;

          Post;
        End
        Else
        Begin
          Edit;
          pAddStringList(stlBaiEnd, FieldByName('AUTOINCREM').AsString);
          FieldByName('MARCAD').AsString := 'S';
          Post;
        End;

        Result := True;
      End;

      auxAutIncPai := FieldByName('END_SEQENG').AsString;

      cdsComEnd.Filtered := False;
      cdsComEnd.Filter := fFilterComEnd;
      cdsComEnd.Filtered := True;

      pMarcaEntrega(auxAutIncPai, fStatusComEng(auxAutIncPai));
    End;

  Except
    On E:Exception Do
      pMensagensErro(E.Message, '[TBaixaEnt.fMarcaDocumento]');
  End;

end;

function TBaixaEnt.fFilterComEnd: String;
begin
  If (Self.fTipoBaixa = tpbceRapida) Then
  Begin
   Result := 'END_SEQENG = ' + QuotedStr(cdsComEng.FieldByName('AUTOINCREM').AsString);
  End
  Else
  Begin
    If (blnDocPen) Then
      Result := 'END_SEQENG = ' + QuotedStr(cdsComEng.FieldByName('AUTOINCREM').AsString)
    Else
      Result := 'END_SEQENG = ' + QuotedStr(cdsComEng.FieldByName('AUTOINCREM').AsString) + ' AND MARCAD = ' + QuotedStr('S');
  End;
end;

function TBaixaEnt.fRetNomeCliente(strNumDoc, strEspDoc,
  strCodEmp, strCodCli: String): String;
begin

  If (fClienteConsumidor(fRetNomCliente(strCodCli))) Then
    Result := fRetNomClienteConsumidorFat(strNumDoc, strEspDoc, strCodEmp)
  Else
    Result := fRetNomCliente(strCodCli);

end;

function TBaixaEnt.fStatusComEng(strAutInc: String): String;
Var
  cdsEngTmp: TUniClientDataSet;
  cdsEndTmp: TUniClientDataSet;
begin
  Result := 'N';

  cdsEngTmp := TUniClientDataSet.Create(Nil);
  cdsEndTmp := TUniClientDataSet.Create(Nil);
  Try
    pCloneDataSet(cdsEngTmp, cdsComEng);
    pCloneDataSet(cdsEndTmp, cdsComEnd);

    If cdsEngTmp.Locate('AUTOINCREM', strAutInc, []) Then
    Begin
      cdsEndTmp.Filtered := False;
      cdsEndTmp.Filter := 'END_SEQENG = ' + QuotedStr(strAutInc) + ' AND MARCAD = ' + QuotedStr('S');
      cdsEndTmp.Filtered := True;

      If cdsEndTmp.IsEmpty Then
      Begin
        If cdsEngTmp.FieldByName('ENG_TOTBAI').AsInteger > 0 Then
          Result := 'P';
      End
      Else
      Begin
        If cdsEngTmp.FieldByName('ENG_TOTDOC').AsInteger = (cdsEngTmp.FieldByName('ENG_TOTBAI').AsInteger + cdsEndTmp.RecordCount) Then
          Result := 'S'
        Else
          Result := 'P'
      End;

      If Pos(Result, 'P_N_') > 0 Then
        pDelStringList(stlBaiEng, cdsEngTmp.FieldByName('ENG_PROENT').AsString);
    End;

  Finally
    FreeAndNil(cdsEngTmp);
    FreeAndNil(cdsEndTmp);
  End;
end;

function TBaixaEnt.fTipoBaixa: TTipoBaixaControleEntregadores;
begin
  Result := TTipoBaixaControleEntregadores(fCfgSis('TPBXCE', varInteger));
end;

function TBaixaEnt.getChaAce: String;
begin
  Result := FChaAce;
end;

function TBaixaEnt.getInsDoc: TInsDoc;
begin
  Result := FInsDoc;
end;

function TBaixaEnt.getTipEnt: TTipEbx;
begin
  Result := FTipEnt;
end;

procedure TBaixaEnt.pMarcaEntrega(strAutInc, strTipMar: String);
begin
  If cdsComEng.Locate('AUTOINCREM', strAutInc, []) Then
  Begin
    pMarca(False, strTipMar);
  End;
end;

procedure TBaixaEnt.pMarcaMotoristaComoDisponível;
var
  qryMotorista: TUniQuery;
begin
  if fEmptyStr(strCodEnt) then
    Exit;

  qryMotorista := fCriaQuery;

  try
    qryMotorista.Close;
    qryMotorista.SQL.Clear;
    qryMotorista.SQL.Add('SELECT MOT.MOT_CODMOT');
    qryMotorista.SQL.Add('FROM CADMOT MOT');
    qryMotorista.SQL.Add('INNER JOIN COMENG ENG');
    qryMotorista.SQL.Add('ON(MOT.MOT_CODMOT = ENG.ENG_CODENT)');
    qryMotorista.SQL.Add('INNER JOIN COMEND EN');
    qryMotorista.SQL.Add('ON(EN.END_SEQENG = ENG.AUTOINCREM)');
    qryMotorista.SQL.Add('WHERE MOT.MOT_CODMOT = :CODMOT');
    qryMotorista.SQL.Add('AND EN.END_DTABAI IS NULL');
    qryMotorista.SQL.Add('AND EN.END_HRABAI IS NULL');
    qryMotorista.ParamByName('CODMOT').AsString := strCodEnt;
    qryMotorista.Open;

    if not qryMotorista.IsEmpty then
      Exit;


    qryMotorista.Close;
    qryMotorista.SQL.Clear;
    qryMotorista.SQL.Add('UPDATE CADMOT');
    qryMotorista.SQL.Add('SET MOT_SITUAC = "D" ');
    qryMotorista.SQL.Add('WHERE MOT_CODMOT = :CODMOT');
    qryMotorista.ParamByName('CODMOT').AsString := strCodEnt;
    qryMotorista.ExecSQL;
  finally
    FreeAndNil(qryMotorista);
  end;
end;

function TBaixaEnt.fExisteDocumentosPendentes: Boolean;
Var
  cdsEngTmp: TUniClientDataSet;
  cdsEndTmp: TUniClientDataSet;
begin

  Result := False;

  cdsEngTmp := TUniClientDataSet.Create(Nil);
  cdsEndTmp := TUniClientDataSet.Create(Nil);
  Try
    Try
      cdsEngTmp.Data := cdsComEng.Data;
      cdsEndTmp.Data := cdsComEnd.Data;

      cdsEngTmp.Open;
      cdsEndTmp.Open;

      cdsEngTmp.Filter   := 'MARCAD = ' + QuotedStr('S');
      cdsEngTmp.Filtered := True;

      If (Not cdsEngTmp.IsEmpty) Then
      Begin
        cdsEndTmp.Filter   := 'MARCAD = ' + QuotedStr('S');
        cdsEndTmp.Filtered := True;
        cdsEndTmp.First;

        With cdsEndTmp Do
        Begin
          While Not Eof Do
          Begin
            cdsEngTmp.Filtered := False;
            cdsEngTmp.Filter   := '';
            cdsEngTmp.Filter   := 'AUTOINCREM = ' + QuotedStr(FieldByName('END_SEQENG').AsString) + ' AND MARCAD = ' + QuotedStr('S');
            cdsEngTmp.Filtered := True;

            If (cdsEngTmp.IsEmpty) Then
            Begin
              Result := True;
              Break;
            End;

            Next;
          End;
        End;

      End
      Else
        Result := True;

    Except
      On E: Exception Do
      Begin
        Result := True;
        pMensagensErro(E.Message, '[TBaixaEnt.fExisteDocumentosPendentes]');
      End;
    End;
  Finally
    FreeAndNil(cdsEngTmp);
    FreeAndNil(cdsEndTmp);
  End;
end;

function TBaixaEnt.fRetNomClienteConsumidorFat(strNumDoc, strEspDoc, strCodEmp: String): String;
Var
  strSQL: String;
  qryCon: TUniQuery;

  strTabela: String;
  strSigCam: String;
Begin

  Try

    If (Pos(strEspDoc, 'PD_OR_') > 0) Then
    Begin
      strTabela := 'FATGOR';
      strSigCam := 'FGO_';
    End
    Else
    Begin
      strTabela := 'MOVGER';
      strSigCam := 'GER_';
    End;

    qryCon := fCriaQuery(Nil);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + ' ' + strSigCam + 'NOMCON AS NOMCON ';
    strSQL := strSQL + 'FROM   ';
    strSQL := strSQL + ' ' + strTabela + ' ';
    strSQL := strSQL + 'WHERE  ';
    strSQL := strSQL +    strSigCam + 'NUMDOC = :NUMDOC AND ';
    strSQL := strSQL +    strSigCam + 'ESPDOC = :ESPDOC AND ';
    strSQL := strSQL +    strSigCam + 'CODEMP = :CODEMP     ';

    With qryCon Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDOC').AsString := strNumDoc;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODEMP').AsString := strCodEmp;
      Open;

      Result := FieldByName('NOMCON').AsString;
    End;

  Finally
    FreeAndNil(qryCon);
  End;

End;

end.
