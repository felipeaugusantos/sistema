unit untComFatVend;

interface

uses Classes, DB, untFuncoesSimples, UniClientDataSet, UniDataSetProvider, Uni;

Type
  TValidacaoCampo = (vcMargem, vcFaturamento);
  TAcaoObjeto     = (aoInserindo, aoEditando, aoDeletando);

Type
  TComFatVend = Class (TComponent)
  Private
    FCodTab: String;
    FDescri: String;
    FCodGat: String;
    FAutInc: String;
    FFatIni: Double;
    FFatFin: Double;
    FMarIni: Double;
    FMarFin: Double;
    FPerCom: Double;
    FPercentualBonificacao : Double;

    FblnUsaProCod: Boolean;
    FobjTipoAcao:  TAcaoObjeto;

    function getPerCom: Double;
    function getFatFin: Double;
    function getFatIni: Double;
    function getMarFin: Double;
    function getMarIni: Double;
    function GetblnUsaProCod: Boolean;
    function GetobjTipoAcao: TAcaoObjeto;

    procedure setPerCom(const Value: Double);
    procedure setFatFin(const Value: Double);
    procedure setFatIni(const Value: Double);
    procedure setMarFin(const Value: Double);
    procedure setMarIni(const Value: Double);
    procedure setCodTab(const Value: String);
    procedure setDescri(const Value: String);
    procedure setCodGat(const Value: String);
    procedure SetblnUsaProCod(const Value: Boolean);
    procedure SetobjTipoAcao(const Value: TAcaoObjeto);

    procedure pAfterOpen(Dataset: TDataSet);
  Public
    qryDados : TUniQuery;
    cdsDados : TUniClientDataSet;
    cpvDados : TUniDataSetProvider;
    qryTabela: TUniQuery;
    arrDefCam: TArrDefCam;

    Property strCodTab: String Read FCodTab   Write setCodTab;
    Property strDescri: String Read FDescri   Write setDescri;
    Property strCodGat: String Read FCodGat   Write setCodGat;
    Property strAutInc: String Read FAutInc   Write FAutInc;
    Property strFatIni: Double Read getFatIni Write setFatIni;
    Property strFatFin: Double Read getFatFin Write setFatFin;
    Property strMarIni: Double Read getMarIni Write setMarIni;
    Property strMarFin: Double Read getMarFin Write setMarFin;
    Property strPerCom: Double Read getPerCom Write setPerCom;
    Property PercentualBonificacao : Double read FPercentualBonificacao write FPercentualBonificacao;

    Property blnUsaProCod: Boolean     Read GetblnUsaProCod Write SetblnUsaProCod;
    Property objTipoAcao:  TAcaoObjeto Read GetobjTipoAcao  Write SetobjTipoAcao;

    function fExcluiRegistro: Boolean;
    procedure pAtualizaDados;
    procedure pAtualizaTabela;
    procedure pDeletaItem;
    procedure pInsereDados;
    procedure pAlteraDados;
    procedure pAtualizaRegistros;
    function fRetSQLCadOpe: String;
    function fExisteProCodCadastrado(strCodPro: String): Boolean;

    function fValidaMargemOuFatInvidual(fltValor: Double;
                                        strCampoIni, strCampoFin: String;
                                        fltValFatIni, fltValFatFin: Double;
                                        strCodGat: string = ''): Boolean;

    Constructor Create(Owner: TComponent); Reintroduce;
  end;

Const
  arrCampos   : array[0..10] of String     = ('COM_CODTAB','COM_DESCRI','COM_CODGAT','COM_FATINI','COM_FATFIN','COM_MARINI','COM_MARFIN','COM_PERCOM','COM_CODEMP','AUTOINCREM','COM_PERBON');
  arrDescricao: array[0..10] of String     = ('Código','Descrição','Grupo de Atividade','Faturamento Inicial','Faturamento Final','Margem Inicial','Margem Final','% Comissão','Empresa','AUTOINCREM','% Bonificação');
  arrTipo     : array[0..10] of TFieldType = (ftString,ftString,ftString,ftFloat,ftFloat,ftFloat,ftFloat,ftFloat,ftString,ftString,ftFloat);
  arrTamanhos : array[0..10] of Integer    = (6,50,3,0,0,0,0,0,3,20,0);
  arrVisible  : array[0..10] of Boolean    = (True,True,True,True,True,True,True,True,False,False,True);
  arrFormat   : array[0..10] of String     = ('','','','#,##0.000','#,##0.000','#,##0.000','#,##0.000','#,##0.00','','','#,##0.00');

implementation

uses SysUtils, Math;

{ TComFatVend }

constructor TComFatVend.Create(Owner: TComponent);
  Var
    intContador: Integer;
begin
  Try
    SetLength(arrDefCam,9);
    For intContador := 0 To Length(arrDefCam)-1 Do
    Begin
      arrDefCam[intContador].strNomCam := arrCampos[intContador];
      arrDefCam[intContador].strDesCri := arrDescricao[intContador];
      arrDefCam[intContador].ftpTipCam := arrTipo[intContador];
      arrDefCam[intContador].intTamCam := arrTamanhos[intContador];
      arrDefCam[intContador].blnVisible:= arrVisible[intContador];
      arrDefCam[intContador].strFormat := arrFormat[intContador];
    End;
    qryTabela := fCriaQuery(Self);
    qryTabela.AfterOpen := pAfterOpen;

    qryDados := fCriaQuery(Self);
    cdsDados := TUniClientDataSet.Create(Self);
    cpvDados := TUniDataSetProvider.Create(Self);
    cpvDados.DataSet := qryDados;
    cdsDados.AfterOpen := pAfterOpen;
    cdsDados.IndexFieldNames := 'COM_CODTAB;COM_MARINI;COM_FATINI';

    qryTabela.Close;
    qryTabela.SQL.Clear;
    qryTabela.SQL.Add('SELECT * FROM COMFAV WHERE FALSE');
    qryTabela.Open;
    pAtualizaDados;

    FCodTab := '';
    FDescri := '';
    FCodGat := '';
    FFatIni := 0;
    FFatFin := 0;
    FMarIni := 0;
    FMarFin := 0;
    FPerCom := 0;
    FPercentualBonificacao := 0;
  Except
    On E: Exception Do
      Raise Exception.Create('Ocorreu um erro ao criar o objeto ComFatVend!' + #13 + E.Message);
  End;
end;

function TComFatVend.getPerCom: Double;
begin
  Result := FPerCom;
end;

function TComFatVend.fExcluiRegistro: Boolean;
  Var
    qryTmp: TUniQuery;
begin
  Try
    Result := False;
    qryTmp := fCriaQuery;

    With qryTmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT * FROM COMFAV WHERE COM_CODTAB = :CODTAB');
      ParamByName('CODTAB').AsString := strCodTab;
      Open;

      If Not IsEmpty Then
      Begin
        First;
        While Not Eof Do
        Begin
          fVerificaIntegridade(Self.Name, 'COMFAV', qryTmp, True);
          Next;
        End;

        Close;
        SQL.Clear;
        SQL.Add(' DELETE FROM COMFAV WHERE COM_CODTAB = :CODTAB');
        ParamByName('CODTAB').AsString := strCodTab;
        ExecSQL;
        Result := RowsAffected > 0;
        Close;
      End;
    End;
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message + '[fExcluiRegistro]');
  End;

  FreeAndNil(qryTmp);
end;

function TComFatVend.fExisteProCodCadastrado(strCodPro: String): Boolean;
  Var
    qryTmp: TUniQuery;
Begin
  Try
    qryTmp := fCriaQuery(Self);

    With qryTmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT * FROM COMFAV WHERE COM_CODTAB = :CODTAB');
      ParamByName('CODTAB').AsString := strCodPro;
      Open;

      Result := Not IsEmpty;
    End;
  Finally
    FreeAndNil(qryTmp);
  End;
end;

function TComFatVend.fRetSQLCadOpe: String;
begin
  Result := '';
  Result := Result + 'SELECT SQL_NO_CACHE ';
  Result := Result + '  OPE_CODOPE,       ';
  Result := Result + '  OPE_NOMOPE,       ';
  Result := Result + '  OPE_SALFIX,       ';
  Result := Result + '  OPE_PERADI,       ';
  Result := Result + '  OPE_CODFAV,       ';
  Result := Result + '  AUTOINCREM,       ';
  Result := Result + '   CASE OPE_INTEXT WHEN ''A'' THEN ''ADMINISTRATIVO'' '+
                     '                   WHEN ''C'' THEN ''COMPRAS'' '+
                     '                   WHEN ''I'' THEN ''VENDEDOR INTERNO'' '+
                     '                   WHEN ''E'' THEN ''REPRES. EXTERNO LOJA'' '+
                     '                   WHEN ''D'' THEN ''REPRES. EXTERNO DISTRIBUIDOR'' '+
                     '                   WHEN ''S'' THEN ''SUB-GERENTE'' '+
                     '                   WHEN ''G'' THEN ''GERENTE''     '+
                     '                   WHEN ''M'' THEN ''MECÂNICO''    '+
                     '                   WHEN ''O'' THEN ''OPERACIONAL'' '+
                     '    END OPE_INTEXT ';
  Result := Result + 'FROM                ';
  Result := Result + '  CADOPE            ';
  Result := Result + 'WHERE               ';
  Result := Result + '  OPE_STATUS = "A"  ';
  Result := Result + 'ORDER BY            ';
  Result := Result + '  OPE_NOMOPE        ';
end;

function TComFatVend.fValidaMargemOuFatInvidual(fltValor: Double; strCampoIni,
  strCampoFin: String; fltValFatIni, fltValFatFin: Double; strCodGat: string = ''): Boolean;
  Var
    Marca: TBookMark;

  function fVerificaCampo(qryDataSet: TDataSet): Boolean;
  Begin
    Result := True;
    
    With qryDataSet Do
    Begin
      First;

      While Not Eof Do
      Begin
        If SameText(FieldByName('AUTOINCREM').AsString, strAutInc) Then
        Begin
          Next;
          Continue;
        End;

        If (RoundTo(fltValor, -3) >= RoundTo(FieldByName(strCampoIni).AsFloat, -3)) And
           (RoundTo(fltValor, -3) <= RoundTo(FieldByName(strCampoFin).AsFloat, -3)) Then
        Begin
          If ((RoundTo(fltValFatIni, -3) >= RoundTo(FieldByName('COM_FATINI').AsFloat, -3)) And
              (RoundTo(fltValFatIni, -3) <= RoundTo(FieldByName('COM_FATFIN').AsFloat, -3))) Or
             ((RoundTo(fltValFatFin, -3) >= RoundTo(FieldByName('COM_FATINI').AsFloat, -3)) And
              (RoundTo(fltValFatFin, -3) <= RoundTo(FieldByName('COM_FATFIN').AsFloat, -3))) Then
          Begin
            If fCfgSis('UTGRAT', varBoolean) Then
            Begin
              If (strCodGat = FieldByName('COM_CODGAT').AsString) Then
              Begin
                Result := False;
                Break;
              End;
            End
            Else
            Begin
              Result := False;
              Break;
            End;
          End;
        End;

        Next;
      End;
    End;
  End;
begin
  Try
    With cdsDados Do
    Begin
      Marca := GetBookmark;
      DisableControls;

      Result := fVerificaCampo(cdsDados);

      If (Not Result) Then
        fMensagem('ATENÇÃO', 'Já existe um % de comissão cadastrado para ' + IIF(fCfgSis('UTGRAT', varBoolean), 'esse grupo de atividade, ', 'essa ') + 'faixa de margem e faturamento!', ['&Ok']);

      GotoBookmark(Marca);
      FreeBookmark(Marca);
      EnableControls;
    End;
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message + '[fValidaMargemOuFatInvidual]');
  End;
end;

function TComFatVend.GetblnUsaProCod: Boolean;
begin
  Result := FblnUsaProCod;
end;

function TComFatVend.getFatFin: Double;
begin
  Result := FFatFin;
end;

function TComFatVend.getFatIni: Double;
begin
  Result := FFatIni;
end;

function TComFatVend.getMarFin: Double;
begin
  Result := FMarFin;
end;

function TComFatVend.getMarIni: Double;
begin
  Result := FFatIni;
end;

function TComFatVend.GetobjTipoAcao: TAcaoObjeto;
begin
  Result := FobjTipoAcao;
end;

procedure TComFatVend.pAfterOpen(Dataset: TDataSet);
begin
  TFloatField(Dataset.FieldByName('COM_MARINI')).DisplayFormat := '#,##0.000';
  TFloatField(Dataset.FieldByName('COM_MARFIN')).DisplayFormat := '#,##0.000';
  TFloatField(Dataset.FieldByName('COM_FATINI')).DisplayFormat := '#,##0.000';
  TFloatField(Dataset.FieldByName('COM_FATFIN')).DisplayFormat := '#,##0.000';
  TFloatField(Dataset.FieldByName('COM_PERCOM')).DisplayFormat := '#,##0.00';
  TFloatField(Dataset.FieldByName('COM_PERBON')).DisplayFormat := '#,##0.00';
end;

procedure TComFatVend.pAlteraDados;
begin
  Try
    With cdsDados Do
    Begin
      If Locate('AUTOINCREM', strAutInc, []) Then
      Begin
        Edit;
        FieldByName('COM_MARINI').AsFloat := FMarIni;
        FieldByName('COM_MARFIN').AsFloat := FMarFin;
        FieldByName('COM_FATINI').AsFloat := FFatIni;
        FieldByName('COM_FATFIN').AsFloat := FFatFin;
        FieldByName('COM_PERCOM').AsFloat := FPerCom;
        FieldByName('COM_PERBON').AsFloat := FPercentualBonificacao;
        if fEmptyStr(FCodGat) then
          FieldByName('COM_CODGAT').Clear
        else
          FieldByName('COM_CODGAT').AsString := FCodGat;
        Post;
      End;
    End;
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message + '[pAlteraDados]');
  End;
end;

procedure TComFatVend.pAtualizaDados;
begin
  With qryDados Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM COMFAV WHERE COM_CODTAB = :CODTAB');
    ParamByName('CODTAB').AsString := qryTabela.FieldByName('COM_CODTAB').AsString;
    Open;

    pSetaClient(qryDados);

    cdsDados.Close;
    cdsDados.SetProvider(cpvDados);
    cdsDados.Open;

    If (Not cdsDados.IsEmpty) Then
    Begin
      If fEmptyStr(strCodTab) Then
        strCodTab := cdsDados.FieldByName('COM_CODTAB').AsString;

      If fEmptyStr(strDescri) Then
        strDescri := cdsDados.FieldByName('COM_DESCRI').AsString;

      If (qryTabela.State = dsInsert) Then
      Begin
        qryTabela.FieldByName('COM_CODTAB').AsString := cdsDados.FieldByName('COM_CODTAB').AsString;
        qryTabela.FieldByName('COM_DESCRI').AsString := cdsDados.FieldByName('COM_DESCRI').AsString;
        qryTabela.FieldByName('COM_CODGAT').AsString := cdsDados.FieldByName('COM_CODGAT').AsString;
        qryTabela.FieldByName('COM_MARINI').AsFloat  := cdsDados.FieldByName('COM_MARINI').AsFloat;
        qryTabela.FieldByName('COM_MARFIN').AsFloat  := cdsDados.FieldByName('COM_MARFIN').AsFloat;
      End;
    End;
  End;
end;

procedure TComFatVend.pAtualizaRegistros;
  Var
    intRecNo: Integer;
begin
  intRecNo := cdsDados.RecNo;

  Try
    cdsDados.IndexFieldNames := '';
    cdsDados.DisableControls;
    cdsDados.First;
    While Not cdsDados.Eof Do
    Begin
      cdsDados.Edit;
      cdsDados.FieldByName('COM_CODTAB').AsString := FCodTab;
      cdsDados.FieldByName('COM_DESCRI').AsString := FDescri;
      cdsDados.Post;
      cdsDados.Next;
    End;
  Finally
    cdsDados.IndexFieldNames := 'COM_CODTAB;COM_MARINI;COM_FATINI';
    cdsDados.RecNo := intRecNo;
    cdsDados.EnableControls;
  End;
end;

procedure TComFatVend.pAtualizaTabela;
begin
  With qryTabela Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM COMFAV WHERE COM_CODTAB = :CODTAB');
    ParamByName('CODTAB').AsString := FCodTab;
    Open;
  End;
end;

procedure TComFatVend.pDeletaItem;
begin
  Try
    If cdsDados.IsEmpty Then
      Exit;
      
    cdsDados.Delete;
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;
end;

procedure TComFatVend.pInsereDados;
begin
  Try
    With cdsDados Do
    Begin
      Append;
      FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('COMFAV', VS_strCodEmp);
      FieldByName('COM_CODEMP').AsString := VS_strCodEmp;
      FieldByName('COM_CODTAB').AsString := FCodTab;
      FieldByName('COM_DESCRI').AsString := FDescri;
      if fEmptyStr(FCodGat) then
        FieldByName('COM_CODGAT').Clear
      else
        FieldByName('COM_CODGAT').AsString := FCodGat;
      FieldByName('COM_MARINI').AsFloat  := FMarIni;
      FieldByName('COM_MARFIN').AsFloat  := FMarFin;
      FieldByName('COM_FATINI').AsFloat  := FFatIni;
      FieldByName('COM_FATFIN').AsFloat  := FFatFin;
      FieldByName('COM_PERCOM').AsFloat  := FPerCom;
      FieldByName('COM_PERBON').AsFloat  := FPercentualBonificacao;
      Post;
    End;
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;
end;

procedure TComFatVend.SetblnUsaProCod(const Value: Boolean);
begin
  FblnUsaProCod := Value;
end;

procedure TComFatVend.setCodTab(const Value: String);
begin
  FCodTab := Value;
end;

procedure TComFatVend.setDescri(const Value: String);
begin
  FDescri := Value;
end;

procedure TComFatVend.setCodGat(const Value: String);
begin
  FCodGat := Value;
end;

procedure TComFatVend.setPerCom(const Value: Double);
begin
  FPerCom := Value;
end;

procedure TComFatVend.setFatFin(const Value: Double);
begin
  FFatFin := Value;
end;

procedure TComFatVend.setFatIni(const Value: Double);
begin
  FFatIni := Value;
end;

procedure TComFatVend.setMarFin(const Value: Double);
begin
  FMarFin := Value;
end;

procedure TComFatVend.setMarIni(const Value: Double);
begin
  FMarIni := Value;
end;

procedure TComFatVend.SetobjTipoAcao(const Value: TAcaoObjeto);
begin
  FobjTipoAcao := Value;
end;

end.
