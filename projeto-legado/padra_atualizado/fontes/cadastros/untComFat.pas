{*********************************************************}
{* CLASSE DO CADASTRO DE FAIXAS DE COMISSÃO POR MARGEM   *}
{*                                                       *}
{* DATA......: 15/07/2009                                *}
{* AUTOR.....: MARCOS VINICIUS DA SILVA                  *}
{*                                                       *}
{******************************************************AF*}
unit untComFat;

interface

uses Classes, DB, untFuncoesSimples, UniClientDataSet, UniDataSetProvider, Uni;

Type
  TValidacaoCampo = (vcMargem, vcFaturamento);
  TAcaoObjeto     = (aoInserindo, aoEditando, aoDeletando);
  TTipoComissao   = (tcDepartamento, tcMecanico);

Type
  TComFat = Class (TComponent)
  Private
    FCodTab: String;
    FDescri: String;
    FAutInc: String;
    FCodDep: String;
    FFatIni: Double;
    FFatFin: Double;
    FMarIni: Double;
    FMarFin: Double;
    FPerCom: Double;

    FblnUsaProCod: Boolean;
    FobjTipoAcao:  TAcaoObjeto;

    FTipoComissao   : TTipoComissao;
    FNomeTabela     : String;
    FcdsMecanicos   : TUniClientDataSet;
    FCodigoMecanico : String;
    FNomeMecanico   : String;

    function getPerCom: Double;
    function getFatFin: Double;
    function getFatIni: Double;
    function getMarFin: Double;
    function getMarIni: Double;
    function getCodDep: String;
    function GetblnUsaProCod: Boolean;
    function GetobjTipoAcao: TAcaoObjeto;

    procedure setPerCom(const Value: Double);
    procedure setFatFin(const Value: Double);
    procedure setFatIni(const Value: Double);
    procedure setMarFin(const Value: Double);
    procedure setMarIni(const Value: Double);
    procedure setCodTab(const Value: String);
    procedure setDescri(const Value: String);
    procedure setCodDep(const Value: String);
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
    Property strAutInc: String Read FAutInc   Write FAutInc;
    Property strFatIni: Double Read getFatIni Write setFatIni;
    Property strFatFin: Double Read getFatFin Write setFatFin;
    Property strMarIni: Double Read getMarIni Write setMarIni;
    Property strMarFin: Double Read getMarFin Write setMarFin;
    Property strPerCom: Double Read getPerCom Write setPerCom;
    Property strCodDep: String Read getCodDep Write setCodDep;

    Property blnUsaProCod: Boolean     Read GetblnUsaProCod Write SetblnUsaProCod;
    Property objTipoAcao:  TAcaoObjeto Read GetobjTipoAcao  Write SetobjTipoAcao;

    Property NomeDaTabela   : String             Read FNomeTabela;
    Property cdsMecanicos   : TUniClientDataSet  Read FcdsMecanicos;
    Property CodigoMecanico : String             Read FCodigoMecanico Write FCodigoMecanico;
    Property NomeMecanico   : String             Read FNomeMecanico   Write FNomeMecanico;

    function fExcluiRegistro: Boolean;
    procedure pAtualizaDados;
    procedure pAtualizaTabela;
    procedure pDeletaItem;
    procedure pInsereDados;
    procedure pAlteraDados;
    function fAtualizaRegistros(var AMensagem : string) : Boolean;
    function fExisteProCodCadastrado(strCodPro: String): Boolean;

    function fValidaMargemOuFatInvidual(fltValor: Double;
                                        strCampoIni, strCampoFin: String;
                                        fltValFatIni, fltValFatFin: Double): Boolean;

    Constructor Create(Owner: TComponent; ATTipoComissao : TTipoComissao); Reintroduce;

    function fValidarMecanicoJaExiste(ACodigoMecanica : String; var AMensagem : String) : Boolean;
    procedure pAdicionarMecanico;
    procedure pSalvarDadosMecanicos;
    procedure pExcluiMecanico;
    procedure pCarregaDadosMecanicos;

  end;

Const
  arrCampos   : array[0..9] of String     = ('COM_CODTAB','COM_DESCRI','COM_FATINI','COM_FATFIN','COM_MARINI','COM_MARFIN','COM_PERCOM','COM_CODEMP','COM_CODDEP','AUTOINCREM');
  arrDescricao: array[0..9] of String     = ('Código','Descrição','Faturamento Inicial','Faturamento Final','Margem Inicial','Margem Final','% Comissão','Empresa','Departamento','AUTOINCREM');
  arrTipo     : array[0..9] of TFieldType = (ftString,ftString,ftFloat,ftFloat,ftFloat,ftFloat,ftFloat,ftString,ftString,ftString);
  arrTamanhos : array[0..9] of Integer    = (6,50,0,0,0,0,0,3,3,20);
  arrVisible  : array[0..9] of Boolean    = (True,True,True,True,True,True,True,False,True,False);
  arrFormat   : array[0..9] of String     = ('','','#,##0.000','#,##0.000','#,##0.000','#,##0.000','#,##0.00','','','');

implementation

uses SysUtils, Variants, Math;

{ TComFat }

constructor TComFat.Create(Owner: TComponent; ATTipoComissao : TTipoComissao);
  Var
    intContador: Integer;
begin

  FTipoComissao := ATTipoComissao;
  if FTipoComissao = tcDepartamento then
    FNomeTabela := 'COMFAT'
  else
    FNomeTabela := 'COMMEC';

  Try
    SetLength(arrDefCam, 10);

    For intContador := 0 To Length(arrDefCam) - 1 Do
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
    qryTabela.SQL.Add('SELECT * FROM '+FNomeTabela+' WHERE FALSE');
    qryTabela.Open;
    pAtualizaDados;

    FCodTab := '';
    FDescri := '';
    FCodDep := '';
    FFatIni := 0;
    FFatFin := 0;
    FMarIni := 0;
    FMarFin := 0;
    FPerCom := 0;

  Except
    On E: Exception Do
      Raise Exception.Create('Ocorreu um erro ao criar o objeto '+FNomeTabela+'!' + #13 + E.Message);
  End;

end;

function TComFat.getPerCom: Double;
begin
  Result := FPerCom;
end;

function TComFat.getCodDep: String;
begin
  Result := FCodDep;
end;

function TComFat.fExcluiRegistro: Boolean;
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
      SQL.Add(' SELECT * FROM '+FNomeTabela+' WHERE COM_CODTAB = :CODTAB');
      ParamByName('CODTAB').AsString := strCodTab;
      Open;

      If Not IsEmpty Then
      Begin
        First;
        While Not Eof Do
        Begin
          fVerificaIntegridade(Self.Name, FNomeTabela, qryTmp, True);
          Next;
        End;

        Close;
        SQL.Clear;
        SQL.Add(' DELETE FROM '+FNomeTabela+' WHERE COM_CODTAB = :CODTAB');
        ParamByName('CODTAB').AsString := strCodTab;
        ExecSQL;
        Result := RowsAffected > 0;
        Close;

        if FTipoComissao = tcMecanico then
        begin
          Close;
          SQL.Clear;
          SQL.Add(' DELETE FROM COMMED WHERE COM_CODTAB = :CODTAB');
          ParamByName('CODTAB').AsString := strCodTab;
          ExecSQL;
          Result := RowsAffected > 0;
          Close;
        end;
      End;
    End;
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message + '[fExcluiRegistro]');
  End;

  FreeAndNil(qryTmp);
end;

function TComFat.fValidaMargemOuFatInvidual(fltValor: Double; strCampoIni,
  strCampoFin: String; fltValFatIni, fltValFatFin: Double): Boolean;
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
            Result := False;
            Break;
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
        fMensagem('ATENÇÃO', 'Já existe um % de comissão cadastrado para essa faixa de margem e faturamento!', ['&Ok']);

      GotoBookmark(Marca);
      FreeBookmark(Marca);
      EnableControls;
    End;
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message + '[fValidaMargemOuFatInvidual]');
  End;
end;

function TComFat.fValidarMecanicoJaExiste(ACodigoMecanica: String; var AMensagem: String): Boolean;
begin
  if not Assigned(FcdsMecanicos) then
    Exit(False);

  Result := FcdsMecanicos.Locate('COM_CODMEC', ACodigoMecanica,[]);
  if Result then
    AMensagem := 'Mecânico já foi adicionado!';
end;

function TComFat.GetblnUsaProCod: Boolean;
begin
  Result := FblnUsaProCod;
end;

function TComFat.getFatFin: Double;
begin
  Result := FFatFin;
end;

function TComFat.getFatIni: Double;
begin
  Result := FFatIni;
end;

function TComFat.getMarFin: Double;
begin
  Result := FMarFin;
end;

function TComFat.getMarIni: Double;
begin
  Result := FFatIni;
end;

function TComFat.GetobjTipoAcao: TAcaoObjeto;
begin
  Result := FobjTipoAcao;
end;

procedure TComFat.pAdicionarMecanico;
begin
  if not Assigned(FcdsMecanicos) then
    pCarregaDadosMecanicos;

  FcdsMecanicos.Append;
  FcdsMecanicos.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('COMMED',VS_strCodEmp);
  FcdsMecanicos.FieldByName('COM_CODEMP').AsString := VS_strCodEmp;
  FcdsMecanicos.FieldByName('COM_CODTAB').AsString := FCodTab;
  FcdsMecanicos.FieldByName('COM_CODMEC').AsString := FCodigoMecanico;
  FcdsMecanicos.FieldByName('OPE_NOMOPE').AsString := FNomeMecanico;
  FcdsMecanicos.Post;
end;

procedure TComFat.pAfterOpen(Dataset: TDataSet);
begin
  TFloatField(Dataset.FieldByName('COM_MARINI')).DisplayFormat := '#,##0.000';
  TFloatField(Dataset.FieldByName('COM_MARFIN')).DisplayFormat := '#,##0.000';
  TFloatField(Dataset.FieldByName('COM_FATINI')).DisplayFormat := '#,##0.000';
  TFloatField(Dataset.FieldByName('COM_FATFIN')).DisplayFormat := '#,##0.000';
  TFloatField(Dataset.FieldByName('COM_PERCOM')).DisplayFormat := '#,##0.00';
end;

procedure TComFat.pAlteraDados;
begin
  Try
    With cdsDados Do
    Begin
      If Locate('AUTOINCREM', strAutInc, []) Then
      Begin
        Edit;
        FieldByName('COM_MARINI').AsFloat  := FMarIni;
        FieldByName('COM_MARFIN').AsFloat  := FMarFin;
        FieldByName('COM_FATINI').AsFloat  := FFatIni;
        FieldByName('COM_FATFIN').AsFloat  := FFatFin;
        FieldByName('COM_PERCOM').AsFloat  := FPerCom;
        Post;
      End;
    End;
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message + '[pAlteraDados]');
  End;
end;

procedure TComFat.pAtualizaDados;
begin

  With qryDados Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM '+FNomeTabela+' WHERE COM_CODTAB = :CODTAB');
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

      if FTipoComissao = tcDepartamento then
      begin
        If fEmptyStr(strCodDep) Then
          strCodDep := cdsDados.FieldByName('COM_CODDEP').AsString;
      end;

      If (qryTabela.State = dsInsert) Then
      Begin
        qryTabela.FieldByName('COM_CODTAB').AsString := cdsDados.FieldByName('COM_CODTAB').AsString;
        qryTabela.FieldByName('COM_DESCRI').AsString := cdsDados.FieldByName('COM_DESCRI').AsString;
        qryTabela.FieldByName('COM_MARINI').AsFloat  := cdsDados.FieldByName('COM_MARINI').AsFloat;
        qryTabela.FieldByName('COM_MARFIN').AsFloat  := cdsDados.FieldByName('COM_MARFIN').AsFloat;
        if FTipoComissao = tcDepartamento then
          qryTabela.FieldByName('COM_CODDEP').AsString := cdsDados.FieldByName('COM_CODDEP').AsString;
      End;

      if FTipoComissao = tcMecanico then
        pCarregaDadosMecanicos;
    End;
  End;
end;

function TComFat.fAtualizaRegistros(var AMensagem : string) : Boolean;
  Var
    intRecNo: Integer;
begin
  Result := True;

  if FTipoComissao = tcMecanico then
  begin
    if (not Assigned(FcdsMecanicos)) or (FcdsMecanicos.RecordCount = 0) then
    begin
      AMensagem := 'É necessário informar ao menos um mecânico para gravar as faixas desta comissão.';
      Exit(False);
    end;
  end;

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

      if FTipoComissao = tcDepartamento then
      begin
        If (FCodDep = '') Then
          cdsDados.FieldByName('COM_CODDEP').Value    := null
        else
          cdsDados.FieldByName('COM_CODDEP').AsString := FCodDep;
      end;

      cdsDados.Post;
      cdsDados.Next;
    End;

  Finally
    cdsDados.IndexFieldNames := 'COM_CODTAB;COM_MARINI;COM_FATINI';
    cdsDados.RecNo := intRecNo;
    cdsDados.EnableControls;
  End;

end;

function TComFat.fExisteProCodCadastrado(strCodPro: String): Boolean;
  Var
    qryTmp: TUniQuery;
Begin
  Try
    qryTmp := fCriaQuery(Self);

    With qryTmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT * FROM '+FNomeTabela+' WHERE COM_CODTAB = :CODTAB');
      ParamByName('CODTAB').AsString := strCodPro;
      Open;

      Result := Not IsEmpty;
    End;
  Finally
    FreeAndNil(qryTmp);
  End;
End;


procedure TComFat.pAtualizaTabela;
begin

  With qryTabela Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM '+FNomeTabela+' WHERE COM_CODTAB = :CODTAB');
    ParamByName('CODTAB').AsString := FCodTab;
    Open;
  End;

end;

procedure TComFat.pCarregaDadosMecanicos;
  var
    LQuery : TUniQuery;
begin
  LQuery := fCriaQuery;
  Try
    LQuery.Sql.Text := 'SELECT C.* , O.OPE_NOMOPE '+
                       '  FROM COMMED C '+
                       '  JOIN CADOPE O ON C.COM_CODMEC = O.OPE_CODOPE '+
                       ' WHERE C.COM_CODTAB = :CODTAB ';
    LQuery.ParamByName('CODTAB').AsString:= qryTabela.FieldByName('COM_CODTAB').AsString;
    LQuery.Open;
    FcdsMecanicos := fCriaClientDatset(LQuery);
    LQuery.Close;
  Finally
    FreeAndNil(LQuery)
  End;
end;

procedure TComFat.pDeletaItem;
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

procedure TComFat.pExcluiMecanico;
begin
  Try
    If FcdsMecanicos.IsEmpty Then
      Exit;
    FcdsMecanicos.Delete;
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;
end;

procedure TComFat.pInsereDados;
begin

  Try

    With cdsDados Do
    Begin
      Append;
      FieldByName('AUTOINCREM').AsString := fRetAutoIncrem(FNomeTabela,VS_strCodEmp);
      FieldByName('COM_CODEMP').AsString := VS_strCodEmp;
      FieldByName('COM_CODTAB').AsString := FCodTab;
      FieldByName('COM_DESCRI').AsString := FDescri;
      FieldByName('COM_MARINI').AsFloat  := FMarIni;
      FieldByName('COM_MARFIN').AsFloat  := FMarFin;
      FieldByName('COM_FATINI').AsFloat  := FFatIni;
      FieldByName('COM_FATFIN').AsFloat  := FFatFin;
      FieldByName('COM_PERCOM').AsFloat  := FPerCom;

      if FTipoComissao = tcDepartamento then
      begin
        If (FCodDep = '') Then
          FieldByName('COM_CODDEP').Value    := null
        else
          FieldByName('COM_CODDEP').AsString := FCodDep;
      end;
      Post;
    End;

  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;

end;

procedure TComFat.pSalvarDadosMecanicos;
  var
    LQuery : TUniQuery;
begin
  LQuery := fCriaQuery;
  Try
    LQuery.SQL.Text := ' DELETE FROM COMMED WHERE COM_CODTAB = :CODTAB';
    LQuery.ParamByName('CODTAB').AsString := strCodTab;
    LQuery.ExecSQL;

    if not Assigned(FcdsMecanicos) then
      Exit;

    LQuery.Sql.Clear;
    LQuery.Sql.Text := ' REPLACE INTO COMMED (AUTOINCREM, COM_CODTAB, COM_CODEMP, COM_CODMEC) VALUES '+
                       ' (:AUTINC, :CODTAB, :CODEMP, :CODMEC) ';
    FcdsMecanicos.First;
    while not FcdsMecanicos.Eof do
    begin
      LQuery.ParamByName('AUTINC').AsString := FcdsMecanicos.FieldByName('AUTOINCREM').AsString;
      LQuery.ParamByName('CODTAB').AsString := FcdsMecanicos.FieldByName('COM_CODTAB').AsString;
      LQuery.ParamByName('CODEMP').AsString := FcdsMecanicos.FieldByName('COM_CODEMP').AsString;
      LQuery.ParamByName('CODMEC').AsString := FcdsMecanicos.FieldByName('COM_CODMEC').AsString;
      LQuery.ExecSql;

      FcdsMecanicos.Next;
    end;
  Finally
    FreeAndNil(LQuery)
  End;
end;

procedure TComFat.SetblnUsaProCod(const Value: Boolean);
begin
  FblnUsaProCod := Value;
end;

procedure TComFat.setCodDep(const Value: String);
begin
  FCodDep := Value;
end;

procedure TComFat.setCodTab(const Value: String);
begin
  FCodTab := Value;
end;

procedure TComFat.setDescri(const Value: String);
begin
  FDescri := Value;
end;

procedure TComFat.setPerCom(const Value: Double);
begin
  FPerCom := Value;
end;

procedure TComFat.setFatFin(const Value: Double);
begin
  FFatFin := Value;
end;

procedure TComFat.setFatIni(const Value: Double);
begin
  FFatIni := Value;
end;

procedure TComFat.setMarFin(const Value: Double);
begin
  FMarFin := Value;
end;

procedure TComFat.setMarIni(const Value: Double);
begin
  FMarIni := Value;
end;

procedure TComFat.SetobjTipoAcao(const Value: TAcaoObjeto);
begin
  FobjTipoAcao := Value;
end;
end.
