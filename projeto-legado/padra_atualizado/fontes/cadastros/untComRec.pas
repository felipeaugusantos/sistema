{*********************************************************}
{* CLASSE DO CADASTRO DE FAIXAS DE COMISSÃO POR RECEBIM. *}
{*                                                       *}
{* DATA......: 06/09/2010                                *}
{* AUTOR.....: IVAN RICARDO SOUZA ARRUE                  *}
{*                                                       *}
{******************************************************IV*}
unit untComRec;

interface

uses Classes, DB, untFuncoesSimples, UniClientDataSet, UniDataSetProvider, Uni, Variants;

Type TComRec = Class (TComponent)
  Private
    FCodTab: String;
    FDescri: String;
    FTipOpe: String;    
    FAutInc: String;
    FRecIni: Double;
    FRecFin: Double;
    FPerCom: Double;
    FCodEmp: String;
    FCodDep: String;

    function getPerCom: String;
    function getRecFin: String;
    function getRecIni: String;

    procedure setPerCom(const Value: String);
    procedure setRecFin(const Value: String);
    procedure setRecIni(const Value: String);
    procedure setCodTab(const Value: String);
    procedure setDescri(const Value: String);
    procedure setTipOpe(const Value: String);

    function getCodDep: String;
    procedure setCodDep(const Value: String);

    procedure pAfterOpen(Dataset: TDataSet);

  Public
    qryDados : TUniQuery;
    cdsDados : TUniClientDataSet;
    cpvDados : TUniDataSetProvider;
    qryTabela: TUniQuery;
    arrDefCam: TArrDefCam;
    strTabela: String;
    blnRecEmp: Boolean;

    Property strCodTab: String Read FCodTab   Write setCodTab;
    Property strDescri: String Read FDescri   Write setDescri;
    Property strTipOpe: String Read FTipOpe   Write setTipOpe;
    Property strCodEmp: String Read FCodEmp   Write FCodEmp;
    Property strAutInc: String Read FAutInc   Write FAutInc;
    Property strRecIni: String Read getRecIni Write setRecIni;
    Property strRecFin: String Read getRecFin Write setRecFin;
    Property strPerCom: String Read getPerCom Write setPerCom;
    Property strCodDep: String Read getCodDep Write setCodDep;

    procedure pAtualizaDados(blnBuscaPorTipoOpe: Boolean = False; strEmpresa: String = '');
    procedure pAtualizaTabela;
    procedure pDeletaRegistro;
    procedure pInsereDados(strEmpresa: String);
    procedure pAtualizaRegistros;
    procedure pAtualizaRegistro;
    procedure pDeletaFaixaCompleta(strComTab, strNomFrm, strEmpresa: String);

    function fTipOpeCadastrado(strTipOpe, strCodDep: String): Boolean;

    Constructor Create(Owner: TComponent); Reintroduce;
  end;

Const
  arrCampos   : array[0..8] of String     = ('COM_CODTAB','COM_DESCRI','COM_TIPOPE','COM_RECINI','COM_RECFIN','COM_PERCOM','COM_CODEMP', 'COM_CODDEP','AUTOINCREM');
  arrDescricao: array[0..8] of String     = ('Código','Descrição','Tipo de Operador','Recebimento Inicial','Recebimento Final','% Comissão','Empresa', 'Departamento', 'AUTOINCREM');
  arrTipo     : array[0..8] of TFieldType = (ftString,ftString,ftString,ftFloat,ftFloat,ftFloat,ftString,ftString,ftString);
  arrTamanhos : array[0..8] of Integer    = (6,50,1,0,0,0,3,3,20);
  arrVisible  : array[0..8] of Boolean    = (True,True,True,True,True,True,False,True,False);
  arrFormat   : array[0..8] of String     = ('','','','#,##0.00','#,##0.00','#,##0.00','','','');

implementation

uses SysUtils;

{ TComRec }

constructor TComRec.Create(Owner: TComponent);
  Var
    intContador: Integer;
begin

  Try
    blnRecEmp := fCfgSis('RECEMP', VarBoolean);

    If blnRecEmp Then
      strTabela := 'RECCOM'
    Else
      strTabela := 'COMREC';

    SetLength(arrDefCam,7);

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

    qryTabela.Close;
    qryTabela.SQL.Clear;
    qryTabela.SQL.Add('SELECT * FROM ' + strTabela + ' WHERE FALSE');
    qryTabela.Open;
    pAtualizaDados;

    FCodTab := '';
    FDescri := '';
    FTipOpe := '';    
    FCodDep := '';
    FRecIni := 0;
    FRecFin := 0;
    FPerCom := 0;

  Except
    On E: Exception Do
      Raise Exception.Create('Ocorreu um erro ao criar o objeto ComRec!' + #13 + E.Message);
  End;

end;

function TComRec.fTipOpeCadastrado(strTipOpe, strCodDep: String): Boolean;
  Var
    qryAux : TUniQuery;
begin
  qryAux := fCriaQuery(Self);

  With qryAux Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM ' + strTabela + ' ');
    SQL.Add('WHERE COM_TIPOPE  = :CODTIP ');
    SQL.Add('AND   COALESCE(COM_CODDEP, "") = :CODDEP ');
    SQL.Add('AND   COM_CODTAB <> :CODTAB ');

    If blnRecEmp Then
      SQL.Add('AND COM_CODEMP = :CODEMP ');

    ParamByName('CODTIP').AsString := strTipOpe;
    ParamByName('CODDEP').AsString := strCodDep;
    ParamByName('CODTAB').AsString := qryTabela.FieldByName('COM_CODTAB').AsString;

    If blnRecEmp Then
      ParamByName('CODEMP').AsString := qryTabela.FieldByName('COM_CODEMP').AsString;

    Open;

    If (Not qryAux.IsEmpty) Then
      Result := True
    Else
      Result := False;
  End;

  FreeAndNil(qryAux);
end;

function TComRec.getCodDep: String;
begin
  Result := FCodDep;
end;

function TComRec.getPerCom: String;
begin
  Result := FloatToStrF(FPerCom,ffNumber,12,2);
end;

function TComRec.getRecFin: String;
begin
  Result := FloatToStrF(FRecFin,ffNumber,12,3);
end;

function TComRec.getRecIni: String;
begin
  Result := FloatToStrF(FRecIni,ffNumber,12,3);
end;

procedure TComRec.pAfterOpen(Dataset: TDataSet);
begin
  TFloatField(Dataset.FieldByName('COM_RECINI')).DisplayFormat := '#,##0.00';
  TFloatField(Dataset.FieldByName('COM_RECFIN')).DisplayFormat := '#,##0.00';
  TFloatField(Dataset.FieldByName('COM_PERCOM')).DisplayFormat := '#,##0.00';
end;

procedure TComRec.pAtualizaDados(blnBuscaPorTipoOpe: Boolean = False; strEmpresa: String = '');
begin

  With qryDados Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM ' + strTabela + ' ');

    If (blnBuscaPorTipoOpe) Then
    Begin
      SQL.Add('WHERE COM_TIPOPE = :CODTIP');
      ParamByName('CODTIP').AsString := qryTabela.FieldByName('COM_TIPOPE').AsString;
    End
    Else
    Begin
      SQL.Add('WHERE COM_CODTAB = :CODTAB');
      ParamByName('CODTAB').AsString := qryTabela.FieldByName('COM_CODTAB').AsString;
    End;

    If blnRecEmp And (Not fEmptyStr(strEmpresa)) Then
    Begin
      SQL.Add('AND COM_CODEMP = :CODEMP ');
      ParamByName('CODEMP').AsString := strEmpresa;
    End;

    Open;

    pSetaClient(qryDados);

    cdsDados.Close;
    cdsDados.SetProvider(cpvDados);
    cdsDados.IndexFieldNames := 'COM_CODTAB;COM_RECINI;COM_RECFIN';
    cdsDados.Open;

    If (Not cdsDados.IsEmpty) And (qryTabela.State = dsInsert) Then
    Begin
      qryTabela.FieldByName('COM_CODTAB').AsString := cdsDados.FieldByName('COM_CODTAB').AsString;
      qryTabela.FieldByName('COM_DESCRI').AsString := cdsDados.FieldByName('COM_DESCRI').AsString;
      qryTabela.FieldByName('COM_TIPOPE').AsString := cdsDados.FieldByName('COM_TIPOPE').AsString;
      qryTabela.FieldByName('COM_CODDEP').AsString := cdsDados.FieldByName('COM_CODDEP').AsString;

      If blnRecEmp Then
        qryTabela.FieldByName('COM_CODEMP').AsString := cdsDados.FieldByName('COM_CODEMP').AsString;
    End;

  End;

end;

procedure TComRec.pAtualizaRegistro;
begin
  With cdsDados Do
  Begin
    Edit;
    FieldByName('COM_RECINI').AsFloat := FRecIni;
    FieldByName('COM_RECFIN').AsFloat := FRecFin;
    FieldByName('COM_PERCOM').AsFloat := FPerCom;

    If (FCodDep = '') Then
      FieldByName('COM_CODDEP').Value    := Null
    Else
      FieldByName('COM_CODDEP').AsString := FCodDep;

    Post;
  End;
end;

procedure TComRec.pAtualizaRegistros;
  Var
    intCont: Integer;
begin

  Try
    intCont := 0;
    cdsDados.DisableControls;

    cdsDados.First;
    While Not cdsDados.Eof Do
    Begin
      cdsDados.Edit;
      cdsDados.FieldByName('COM_CODTAB').AsString := FCodTab;
      cdsDados.FieldByName('COM_DESCRI').AsString := FDescri;
      cdsDados.FieldByName('COM_TIPOPE').AsString := FTipOpe;

      If blnRecEmp Then
        cdsDados.FieldByName('COM_CODEMP').AsString := FCodEmp;

      If (FCodDep = '') Then
        cdsDados.FieldByName('COM_CODDEP').Value    := Null
      Else
        cdsDados.FieldByName('COM_CODDEP').AsString := FCodDep;

      cdsDados.Post;
      cdsDados.Next;

      Inc(intCont);

      If (intCont < cdsDados.RecordCount)        And
         (cdsDados.RecordCount = cdsDados.RecNo) Then
        cdsDados.First;
    End;

  Finally
    cdsDados.EnableControls;
  End;

end;

procedure TComRec.pAtualizaTabela;
begin

  With qryTabela Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM ' + strTabela + ' WHERE AUTOINCREM = :AUTINC');
    ParamByName('AUTINC').AsString := FAutInc;
    Open;
  End;

end;

procedure TComRec.pDeletaFaixaCompleta(strComTab, strNomFrm, strEmpresa: String);
  Var
    strSQL: String;
    qryTmp: TUniQuery;
begin
  Try
    qryTmp := fCriaQuery;

    With qryTmp Do
    Begin
      strSQL := '';
      strSQL := strSQL + ' SELECT * FROM ';
      strSQL := strSQL + strTabela;
      strSQL := strSQL + ' WHERE ';
      strSQL := strSQL + '   COM_CODTAB = :COMTAB ';

      If blnRecEmp Then
        strSQL := strSQL + ' AND COM_CODEMP = :CODEMP ';

      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('COMTAB').AsString := strComTab;

      If blnRecEmp Then
        ParamByName('CODEMP').AsString := strEmpresa;

      Open;

      If Not IsEmpty Then
      Begin
        First;
        While Not Eof Do
        Begin
          fVerificaIntegridade(strNomFrm, strTabela, qryTmp);
          Next;
        End;
      End;

      strSQL := '';
      strSQL := strSQL + ' DELETE FROM ';
      strSQL := strSQL + strTabela;
      strSQL := strSQL + ' WHERE ';
      strSQL := strSQL + '   COM_CODTAB = :COMTAB ';

      If blnRecEmp Then
        strSQL := strSQL + ' AND COM_CODEMP = :CODEMP ';

      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('COMTAB').AsString := strComTab;

      If blnRecEmp Then
        ParamByName('CODEMP').AsString := strEmpresa;

      ExecSQL;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TComRec.pDeletaFaixaCompleta]');
  End;

  FreeAndNil(qryTmp);
end;

procedure TComRec.pDeletaRegistro;
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

procedure TComRec.pInsereDados(strEmpresa: String);
begin

  Try

    With cdsDados Do
    Begin
      Append;
      FieldByName('AUTOINCREM').AsString := fRetAutoIncrem(strTabela, strEmpresa);
      FieldByName('COM_CODEMP').AsString := strEmpresa;
      FieldByName('COM_CODTAB').AsString := FCodTab;
      FieldByName('COM_DESCRI').AsString := FDescri;
      FieldByName('COM_TIPOPE').AsString := FTipOpe;      
      FieldByName('COM_RECINI').AsFloat  := FRecIni;
      FieldByName('COM_RECFIN').AsFloat  := FRecFin;
      FieldByName('COM_PERCOM').AsFloat  := FPerCom;
      If (FCodDep = '') Then
        FieldByName('COM_CODDEP').Value    := Null
      Else
        FieldByName('COM_CODDEP').AsString := FCodDep;
      Post;
    End;

  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;

end;

procedure TComRec.setCodDep(const Value: String);
begin
  FCodDep := Value;
end;

procedure TComRec.setCodTab(const Value: String);
begin
  FCodTab := Value;
end;

procedure TComRec.setDescri(const Value: String);
begin
  FDescri := Value;
end;

procedure TComRec.setPerCom(const Value: String);
begin
  FPerCom := fStrToFloat(Value);
end;

procedure TComRec.setRecFin(const Value: String);
begin
  If Not fEmptyStr(Value) Then
    FRecFin := fStrToFloat(Value)
  Else
    fMensagem('ATENÇÃO','O Recebimento final deve ser preenchido!',['&Ok']);
end;

procedure TComRec.setRecIni(const Value: String);
begin
  If Not fEmptyStr(Value) Then
    FRecIni := fStrToFloat(Value)
  Else
    fMensagem('ATENÇÃO','O Recebimento inicial deve ser preenchido!',['&Ok']);
end;

procedure TComRec.setTipOpe(const Value: String);
begin
  FTipOpe := Value;
end;

end.
