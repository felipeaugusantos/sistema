unit untImpRecCtrPersonalizado;

interface

uses Classes, SysUtils, Uni, StrUtils, untFuncoesSimples, UniClientDataSet;

type
  TImpRecCtrPersonalizado = class(TComponent)
    private
      FNumDup: String;
      FEspDoc: String;
      FCodCli: String;
      FCodEmp: String;
      FTemDup: Boolean;
      FNomFrm: String;
      cdsImpRec : TUniClientDataSet;
      function fGetSqlDuplicatas: string;
      function fGetSQLAdiantamentos: String;
      procedure pCarregaDadosDuplicatas;
      procedure pCarregaDuplicatas(qryDuplic: TUniQuery);
      function fGetQueryEnderecoConsumidor: TUniQuery;
    public
      constructor Create(AOwner: TComponent; strNumDup, strEspDoc, strCodEmp, strCodCli, strNomFrm: String); reintroduce;
      destructor Destroy; override;
      function fImprimirRecibo(): Boolean;
      property blnTemDup : Boolean read FTemDup;
    end;

implementation

uses Data.DB, untReciboCtr, untFastPrintEditor, untCfgRel;

{ TImpRecCtrPersonalizado }

constructor TImpRecCtrPersonalizado.Create(AOwner: TComponent;
  strNumDup, strEspDoc, strCodEmp, strCodCli, strNomFrm: String);
begin
  FNumDup := strNumDup;
  FEspDoc := strEspDoc;
  FCodCli := strCodCli;
  FCodEmp := strCodEmp;
  FNomFrm := strNomFrm;
  cdsImpRec := fCriaClientDatasetReciboCTR;
  pCarregaDadosDuplicatas;
end;

procedure TImpRecCtrPersonalizado.pCarregaDadosDuplicatas;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Self);

  With qryGen, SQL Do
  Begin
    Add(fGetSqlDuplicatas);
    Open;

    FTemDup := Not IsEmpty;

    If Not FTemDup Then
    Begin
      Close;
      SQL.Clear;
      SQL.Add(fGetSQLAdiantamentos);
      Open;

      FTemDup := Not IsEmpty;
    End;

    If FTemDup Then
      pCarregaDuplicatas(qryGen);
  End;

  FreeAndNil(qryGen);
end;

procedure TImpRecCtrPersonalizado.pCarregaDuplicatas(qryDuplic: TUniQuery);
  Var
    qryConsumidor : TUniQuery;
begin
  With qryDuplic Do
  Begin
    First;

    While Not Eof Do
    Begin
      cdsImpRec.Insert;
      cdsImpRec.FieldByName('CODCLI').AsString := FieldByName('CLI_CODCLI').AsString;
      cdsImpRec.FieldByName('NOMCLI').AsString := fRetNomCliente(FieldByName('CLI_CODCLI').AsString);
      cdsImpRec.FieldByName('ENDERE').AsString := FieldByName('CLI_ENDERE').AsString;
      cdsImpRec.FieldByName('ENDNUM').AsString := FieldByName('CLI_ENDNUM').AsString;
      cdsImpRec.FieldByName('ENDCMP').AsString := FieldByName('CLI_ENDCOM').AsString;
      cdsImpRec.FieldByName('BAIRRO').AsString := FieldByName('CLI_BAIRRO').AsString;
      cdsImpRec.FieldByName('C_E_P_').AsString := FieldByName('CLI_C_E_P_').AsString;
      cdsImpRec.FieldByName('CIDADE').AsString := fRetNomCidade(FieldByName('CLI_CODCID').AsString);
      cdsImpRec.FieldByName('ESTADO').AsString := fRetUFCliente(FieldByName('CLI_CODCLI').AsString);
      cdsImpRec.FieldByName('C_G_C_').AsString := FieldByName('CLI_C_G_C_').AsString;
      cdsImpRec.FieldByName('FONE01').AsString := FieldByName('CLI_FONE01').AsString;
      cdsImpRec.FieldByName('F_A_X_').AsString := FieldByName('CLI_F_A_X_').AsString;

      If (Pos('CONSUMIDOR', cdsImpRec.FieldByName('NOMCLI').AsString) > 0) Or
         (Pos('BALCAO',     cdsImpRec.FieldByName('NOMCLI').AsString) > 0) Or
         (Pos('BALCÃO',     cdsImpRec.FieldByName('NOMCLI').AsString) > 0) Then
      Begin
        qryConsumidor := fGetQueryEnderecoConsumidor;

        If Not qryConsumidor.IsEmpty Then
        Begin
          cdsImpRec.FieldByName('NOMCLI').AsString := qryConsumidor.FieldByName('NOMCON').AsString;
          cdsImpRec.FieldByName('ENDERE').AsString := qryConsumidor.FieldByName('ENDCON').AsString;
          cdsImpRec.FieldByName('ENDNUM').AsString := '';
          cdsImpRec.FieldByName('ENDCMP').AsString := '';
          cdsImpRec.FieldByName('F_A_X_').AsString := '';
          cdsImpRec.FieldByName('BAIRRO').AsString := qryConsumidor.FieldByName('BAICON').AsString;
          cdsImpRec.FieldByName('C_E_P_').AsString := qryConsumidor.FieldByName('CEPCON').AsString;
          cdsImpRec.FieldByName('CIDADE').AsString := IIF(fEmptyStr(qryConsumidor.FieldByName('CIDCON').AsString), '', fRetNomCidade(qryConsumidor.FieldByName('CIDCON').AsString));
          cdsImpRec.FieldByName('ESTADO').AsString := qryConsumidor.FieldByName('ESTCON').AsString;
          cdsImpRec.FieldByName('C_G_C_').AsString := qryConsumidor.FieldByName('CGCCON').AsString;
          cdsImpRec.FieldByName('FONE01').AsString := qryConsumidor.FieldByName('TELCON').AsString;
        End;

        FreeAndNil(qryConsumidor);
      End;
      cdsImpRec.FieldByName('NOMCON').AsString := cdsImpRec.FieldByName('NOMCLI').AsString;

      cdsImpRec.FieldByName('DESCRI').AsString := FieldByName('CLI_CODCLI').AsString + '-' + cdsImpRec.FieldByName('NOMCLI').AsString;
      cdsImpRec.FieldByName('HORREC').AsDateTime := fTime();

      If (FindField('CTR_CODCLI') <> Nil) Then
      Begin
        cdsImpRec.FieldByName('NUMDOC').AsString := FieldByName('CTR_NUMDUP').AsString;
        cdsImpRec.FieldByName('PARCEL').AsString := FieldByName('CTR_PARCEL').AsString;
        cdsImpRec.FieldByName('ESPDOC').AsString := FieldByName('CTR_ESPDOC').AsString;
        cdsImpRec.FieldByName('CODEMP').AsString := FieldByName('CTR_CODEMP').AsString;
        cdsImpRec.FieldByName('DTACAD').AsDateTime := FieldByName('CTR_DTACAD').AsDateTime;
        cdsImpRec.FieldByName('DTAVEN').AsDateTime := FieldByName('CTR_DTAVEN').AsDateTime;
        cdsImpRec.FieldByName('DTAREC').AsDateTime := FieldByName('CTR_DTAREC').AsDateTime;
        cdsImpRec.FieldByName('SEQBAI').AsInteger := FieldByName('CTR_SEQBAI').AsInteger;
        cdsImpRec.FieldByName('SEQCON').AsInteger := FieldByName('CTR_SEQCON').AsInteger;
        cdsImpRec.FieldByName('NOSNUM').AsString := FieldByName('CTR_NOSNUM').AsString;
        cdsImpRec.FieldByName('CODVEN').AsString := FieldByName('CTR_CODVEN').AsString;
        cdsImpRec.FieldByName('VALORI').AsFloat := FieldByName('CTR_VALORI').AsFloat;
        cdsImpRec.FieldByName('VALJUR').AsFloat := FieldByName('CTR_VALJUR').AsFloat;
        cdsImpRec.FieldByName('VALDES').AsFloat := FieldByName('CTR_VALDES').AsFloat;
        cdsImpRec.FieldByName('VALREC').AsFloat := FieldByName('CTR_VALREC').AsFloat;
        cdsImpRec.FieldByName('VALDOC').AsFloat := FieldByName('CTR_VALORI').AsFloat;
        cdsImpRec.FieldByName('CODCTA').AsString := FieldByName('CTR_CODCTA').AsString;
        cdsImpRec.FieldByName('DESCTA').AsString := IIF(fEmptyStr(FieldByName('CTR_CODCTA').AsString), '', fRetNomeConta(FieldByName('CTR_CODCTA').AsString));
        cdsImpRec.FieldByName('HIST01').AsString := FieldByName('CTR_HIST01').AsString;
        cdsImpRec.FieldByName('HIST02').AsString := FieldByName('CTR_HIST02').AsString;
        cdsImpRec.FieldByName('CTR_DINHEI').AsFloat := FieldByName('CTR_DINHEI').AsFloat;
        cdsImpRec.FieldByName('CTR_CHQAVI').AsFloat := FieldByName('CTR_CHQAVI').AsFloat;
        cdsImpRec.FieldByName('CTR_CHQPRE').AsFloat := FieldByName('CTR_CHQPRE').AsFloat;
        cdsImpRec.FieldByName('CTR_CARTAO').AsFloat := FieldByName('CTR_CARTAO').AsFloat;
        cdsImpRec.FieldByName('CTR_ORDPAG').AsFloat := FieldByName('CTR_ORDPAG').AsFloat;
      End
      Else If (FindField('ADT_CODCLI') <> Nil) Then
      Begin
        cdsImpRec.FieldByName('NUMDOC').AsString := FieldByName('ADT_NUMDOC').AsString;
        cdsImpRec.FieldByName('PARCEL').AsString := 'A';
        cdsImpRec.FieldByName('ESPDOC').AsString := FieldByName('ADT_ESPDOC').AsString;
        cdsImpRec.FieldByName('CODEMP').AsString := FieldByName('ADT_CODEMP').AsString;
        cdsImpRec.FieldByName('DTACAD').AsDateTime := FieldByName('ADT_DTALAN').AsDateTime;
        cdsImpRec.FieldByName('DTAVEN').AsDateTime := FieldByName('ADT_DTALAN').AsDateTime;
        cdsImpRec.FieldByName('DTAREC').AsDateTime := FieldByName('ADT_DTALAN').AsDateTime;
        cdsImpRec.FieldByName('SEQBAI').AsInteger := 0;
        cdsImpRec.FieldByName('SEQCON').AsInteger := FieldByName('ADT_SEQCON').AsInteger;
        cdsImpRec.FieldByName('NOSNUM').AsString := '';
        cdsImpRec.FieldByName('CODVEN').AsString := FieldByName('ADT_OPELAN').AsString;
        cdsImpRec.FieldByName('VALORI').AsFloat := FieldByName('ADT_VALLAN').AsFloat;
        cdsImpRec.FieldByName('VALJUR').AsFloat := 0;
        cdsImpRec.FieldByName('VALDES').AsFloat := 0;
        cdsImpRec.FieldByName('VALREC').AsFloat := FieldByName('ADT_VALLAN').AsFloat;
        cdsImpRec.FieldByName('VALDOC').AsFloat := FieldByName('ADT_VALLAN').AsFloat;
        cdsImpRec.FieldByName('CODCTA').AsString := '';
        cdsImpRec.FieldByName('DESCTA').AsString := '';
        cdsImpRec.FieldByName('HIST01').AsString := '';
        cdsImpRec.FieldByName('HIST02').AsString := '';
        cdsImpRec.FieldByName('CTR_DINHEI').AsFloat := FieldByName('ADT_VALDIN').AsFloat;
        cdsImpRec.FieldByName('CTR_CHQAVI').AsFloat := FieldByName('ADT_VALCHV').AsFloat;
        cdsImpRec.FieldByName('CTR_CHQPRE').AsFloat := FieldByName('ADT_VALCHP').AsFloat;
        cdsImpRec.FieldByName('CTR_CARTAO').AsFloat := FieldByName('ADT_VALCAR').AsFloat;
        cdsImpRec.FieldByName('CTR_ORDPAG').AsFloat := FieldByName('ADT_VALORD').AsFloat;
      End;

      cdsImpRec.Post;

      Next;
    End;
  End;
end;

destructor TImpRecCtrPersonalizado.Destroy;
begin
  FreeAndNil(cdsImpRec);
  inherited;
end;

function TImpRecCtrPersonalizado.fImprimirRecibo: Boolean;
  Var
    editorFast : TFastPrintFileEditor;
    reciboCtr : TReciboCtr;
    qryCfgRel : TUniQuery;
    strNomFil : String;
    strTipImp : String;
begin
  Result := False;

  If FTemDup Then
  Begin
    qryCfgRel := fCriaQuery(Self);
    pCarregaConfImpr(qryCfgRel, FNomFrm);
    fPreImpressao(qryCfgRel, strNomFil, strTipImp, False);

    editorFast := TFastPrintFileEditor.Create(Self);
    reciboCtr := TReciboCtr.CreateInstance(cdsImpRec);
    editorFast.pSetFastPrintFile(reciboCtr);

    If editorFast.fLoadReport Then
    Begin
      Result := True;
      If Not cdsImpRec.IsEmpty Then
        editorFast.pPrint;
    End;

    FreeAndNil(editorFast);
    FreeAndNil(qryCfgRel);
  End;
end;

function TImpRecCtrPersonalizado.fGetQueryEnderecoConsumidor: TUniQuery;

  function fGetSelectEnderecoConsumidor(strNomeTabela: String): String;
  Begin
    Result := '         SELECT ';
    Result := Result + ' GER_NOMCON NOMCON, GER_ENDCON ENDCON, GER_BAICON BAICON, ';
    Result := Result + ' GER_CEPCON CEPCON, GER_ESTCON ESTCON, GER_TELCON TELCON, ';
    Result := Result + ' GER_CGCCON CGCCON, GER_IESCON IESCON, GER_EMLCON EMLCON, ';
    Result := Result + ' GER_R_GCON R_GCON, GER_CIDCON CIDCON ';
    Result := Result + '  FROM ' + strNomeTabela ;
    Result := Result + ' WHERE GER_NUMDOC = :NUMDOC ';
    Result := Result + '   AND GER_ESPDOC = :ESPDOC ';
    Result := Result + '   AND GER_CODEMP = :CODEMP ';
    Result := Result + '   AND GER_CODCLI = :CODCLI ';
  End;

  function fGetSelectEnderecoConsumidorFatGor: String;
  begin
    Result := '         SELECT ';
    Result := Result + ' FGO_NOMCON NOMCON, FGO_ENDCON ENDCON, FGO_BAICON BAICON, ';
    Result := Result + ' FGO_CEPCON CEPCON, FGO_ESTCON ESTCON, FGO_TELCON TELCON, ';
    Result := Result + ' FGO_CGCCON CGCCON, FGO_IESCON IESCON, FGO_EMLCON EMLCON, ';
    Result := Result + ' FGO_R_GCON R_GCON, FGO_CIDCON CIDCON ';
    Result := Result + '  FROM FATGOR ';
    Result := Result + ' WHERE FGO_NUMDOC = :NUMDOC ';
    Result := Result + '   AND FGO_ESPDOC = :ESPDOC ';
    Result := Result + '   AND FGO_CODEMP = :CODEMP ';
    Result := Result + '   AND FGO_CODCLI = :CODCLI ';
  end;

  Const
    arrTabelas : Array[1..2] Of String = ('MOVDET', 'NOTDET');

  Var
    intCnt : Integer;

begin
  Result := fCriaQuery;

  If (FEspDoc = 'PD') Then
  Begin
    Result.Close;
    Result.SQL.Clear;
    Result.SQL.Add(fGetSelectEnderecoConsumidorFatGor);
    Result.ParamByName('NUMDOC').AsString := FNumDup;
    Result.ParamByName('ESPDOC').AsString := FEspDoc;
    Result.ParamByName('CODEMP').AsString := FCodEmp;
    Result.ParamByName('CODCLI').AsString := FCodCli;
    Result.Open;
  End
  Else
  Begin
    For intCnt := 1 To 4 Do
    Begin
      Result.Close;
      Result.SQL.Clear;
      Result.SQL.Add(fGetSelectEnderecoConsumidor(arrTabelas[intCnt]));
      Result.ParamByName('NUMDOC').AsString := FNumDup;
      Result.ParamByName('ESPDOC').AsString := FEspDoc;
      Result.ParamByName('CODEMP').AsString := FCodEmp;
      Result.ParamByName('CODCLI').AsString := FCodCli;
      Result.Open;

      If Not Result.IsEmpty Then
        Break;
    End;
  End;
end;

function TImpRecCtrPersonalizado.fGetSQLAdiantamentos: String;
begin
  Result := '';
  Result := Result + ' SELECT ';
  Result := Result + '   ADTCLI.*, ';
  Result := Result + '   CLI_CODCLI, ';
  Result := Result + '   CLI_ENDERE, ';
  Result := Result + '   CLI_ENDNUM, ';
  Result := Result + '   CLI_ENDCOM, ';
  Result := Result + '   CLI_BAIRRO, ';
  Result := Result + '   CLI_C_E_P_, ';
  Result := Result + '   CLI_CODCID, ';
  Result := Result + '   CLI_C_G_C_, ';
  Result := Result + '   CLI_FONE01, ';
  Result := Result + '   CLI_F_A_X_  ';
  Result := Result + ' FROM ';
  Result := Result + '   ADTCLI ';
  Result := Result + '   INNER JOIN CADCLI ON ADT_CODCLI = CLI_CODCLI ';
  Result := Result + ' WHERE ADT_NUMDOC = ' + QuotedStr(FNumDup);
  Result := Result + '   AND ADT_ESPDOC = ' + QuotedStr(FEspDoc);
  Result := Result + '   AND ADT_CODCLI = ' + QuotedStr(FCodCli);
  Result := Result + '   AND ADT_CODEMP = ' + QuotedStr(FCodEmp);
  Result := Result + ' ORDER BY ';
  Result := Result + '   ADT_DTALAN ';
end;

function TImpRecCtrPersonalizado.fGetSqlDuplicatas: string;
begin
  Result := '';
  Result := Result + ' SELECT ';
  Result := Result + '   CADREC.*, ';
  Result := Result + '   CLI_CODCLI, ';
  Result := Result + '   CLI_ENDERE, ';
  Result := Result + '   CLI_ENDNUM, ';
  Result := Result + '   CLI_ENDCOM, ';
  Result := Result + '   CLI_BAIRRO, ';
  Result := Result + '   CLI_C_E_P_, ';
  Result := Result + '   CLI_CODCID, ';
  Result := Result + '   CLI_C_G_C_, ';
  Result := Result + '   CLI_FONE01, ';
  Result := Result + '   CLI_F_A_X_  ';
  Result := Result + ' FROM ';
  Result := Result + '   CADREC ';
  Result := Result + '   INNER JOIN CADCLI ON CTR_CODCLI = CLI_CODCLI ';
  Result := Result + ' WHERE CTR_NUMDUP = ' + QuotedStr(FNumDup);
  Result := Result + '   AND CTR_ESPDOC = ' + QuotedStr(FEspDoc);
  Result := Result + '   AND CTR_CODCLI = ' + QuotedStr(FCodCli);
  Result := Result + '   AND CTR_CODEMP = ' + QuotedStr(FCodEmp);
  Result := Result + '   AND CTR_DTAREC IS NOT NULL ';
  Result := Result + ' ORDER BY ';
  Result := Result + '   CTR_DTAVEN ';
end;

end.
