{*********************************************************}
{* CLASSE DO CADASTRO DE FAIXAS DE COMISSÃO POR PESO     *}
{*                                                       *}
{* DATA......: 20/05/2009                                *}
{* AUTOR.....: ALEXANDRE OLIVEIRA FERRI                  *}
{*                                                       *}
{******************************************************AF*}
unit untComPes;

interface

uses Classes, DB, untFuncoesSimples, UniClientDataSet, UniDataSetProvider, Uni;

Type
  TValidacaoCampo = (vcPeso, vcValor);
  TAcaoObjeto     = (aoInserindo, aoEditando, aoDeletando);

Type
  TComPes = Class (TComponent)
  Private
    FCodTab: String;
    FDescri: String;
    FAutInc: String;
    FPesIni: Double;
    FPesFin: Double;
    FValIni: Double;
    FValFin: Double;
    FPerCom: Double;

    FblnUsaProCod: Boolean;
    FobjTipoAcao:  TAcaoObjeto;

    function getPerCom: String;
    function getPesFin: String;
    function getPesIni: String;
    function getValFin: String;
    function getValIni: String;
    function GetblnUsaProCod: Boolean;
    function GetobjTipoAcao: TAcaoObjeto;

    procedure setPerCom(const Value: String);
    procedure setPesFin(const Value: String);
    procedure setPesIni(const Value: String);
    procedure setValFin(const Value: String);
    procedure setValIni(const Value: String);
    procedure setCodTab(const Value: String);
    procedure setDescri(const Value: String);
    procedure SetblnUsaProCod(const Value: Boolean);
    procedure SetobjTipoAcao(const Value: TAcaoObjeto);

    procedure pAfterOpen(Dataset: TDataSet);
    procedure pMostraFaixaPesosCadastras;
  Public
    qryDados : TUniQuery;
    cdsDados : TUniClientDataSet;
    cpvDados : TUniDataSetProvider;
    qryTabela: TUniQuery;
    arrDefCam: TArrDefCam;

    Property strCodTab: String Read FCodTab   Write setCodTab;
    Property strDescri: String Read FDescri   Write setDescri;
    Property strAutInc: String Read FAutInc   Write FAutInc;
    Property strPesIni: String Read getPesIni Write setPesIni;
    Property strPesFin: String Read getPesFin Write setPesFin;
    Property strValIni: String Read getValIni Write setValIni;
    Property strValFin: String Read getValFin Write setValFin;
    Property strPerCom: String Read getPerCom Write setPerCom;

    Property blnUsaProCod: Boolean     Read GetblnUsaProCod Write SetblnUsaProCod;
    Property objTipoAcao:  TAcaoObjeto Read GetobjTipoAcao  Write SetobjTipoAcao;

    function fValidaPesoValorInvidual(fltValor: Double;
                                      strCampoIni, strCampoFin: String;
                                      vcOpcao: TValidacaoCampo;
                                      fltValorOld: Double): Boolean;

    function fValidaFaixaPesoValor(fltValorIni, fltValorFin: Double;
                                   strCampoIni, strCampoFin: String;
                                   vcOpcao: TValidacaoCampo;
                                   fltValorIniOld,
                                   fltValorFinOld: Double): Boolean;

    function fExcluiRegistro: Boolean;
    procedure pAtualizaDados;
    procedure pAtualizaTabela;
    procedure pDeletaItem;
    procedure pInsereDados;
    procedure pAlteraDados;
    procedure pAtualizaRegistros;
    function fExisteProCodCadastrado(strCodPro: String): Boolean;


    Constructor Create(Owner: TComponent); Reintroduce;
  end;

Const
  arrCampos   : array[0..8] of String     = ('COM_CODTAB','COM_DESCRI','COM_PESINI','COM_PESFIN','COM_VALINI','COM_VALFIN','COM_PERCOM','COM_CODEMP','AUTOINCREM');
  arrDescricao: array[0..8] of String     = ('Código','Descrição','Peso Inicial','Peso Final','Valor Inicial','Valor Final','% Comissão','Empresa','AUTOINCREM');
  arrTipo     : array[0..8] of TFieldType = (ftString,ftString,ftFloat,ftFloat,ftFloat,ftFloat,ftFloat,ftString,ftString);
  arrTamanhos : array[0..8] of Integer    = (6,50,0,0,0,0,0,3,20);
  arrVisible  : array[0..8] of Boolean    = (True,True,True,True,True,True,True,False,False);
  arrFormat   : array[0..8] of String     = ('','','#,##0.000','#,##0.000','#,##0.00','#,##0.00','#,##0.00','','');

implementation

uses SysUtils, Math, Forms, untMemo;

{ TComPes }

constructor TComPes.Create(Owner: TComponent);
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
    cdsDados.IndexFieldNames := 'COM_CODTAB;COM_PESINI';
    
    qryTabela.Close;
    qryTabela.SQL.Clear;
    qryTabela.SQL.Add('SELECT * FROM COMPES WHERE FALSE');
    qryTabela.Open;
    pAtualizaDados;

    FCodTab := '';
    FDescri := '';
    FPesIni := 0;
    FPesFin := 0;
    FValIni := 0;
    FValFin := 0;
    FPerCom := 0;

  Except
    On E: Exception Do
      Raise Exception.Create('Ocorreu um erro ao criar o objeto ComPes!' + #13 + E.Message);
  End;

end;

function TComPes.getPerCom: String;
begin
  Result := FloatToStrF(FPerCom,ffNumber,12,2);
end;

function TComPes.getPesFin: String;
begin
  Result := FloatToStrF(FPesFin,ffNumber,12,3);
end;

function TComPes.getPesIni: String;
begin
  Result := FloatToStrF(FPesIni,ffNumber,12,3);
end;

function TComPes.getValFin: String;
begin
  Result := FloatToStrF(FValFin,ffNumber,12,2);
end;

function TComPes.getValIni: String;
begin
  Result := FloatToStrF(FValIni,ffNumber,12,2);
end;

procedure TComPes.pAfterOpen(Dataset: TDataSet);
begin
  TFloatField(Dataset.FieldByName('COM_VALINI')).DisplayFormat := '#,##0.00';
  TFloatField(Dataset.FieldByName('COM_VALFIN')).DisplayFormat := '#,##0.00';
  TFloatField(Dataset.FieldByName('COM_PESINI')).DisplayFormat := '#,##0.000';
  TFloatField(Dataset.FieldByName('COM_PESFIN')).DisplayFormat := '#,##0.000';
  TFloatField(Dataset.FieldByName('COM_PERCOM')).DisplayFormat := '#,##0.00';
end;

procedure TComPes.pAlteraDados;
begin
  Try
    With cdsDados Do
    Begin
      If Locate('AUTOINCREM', strAutInc, []) Then
      Begin
        Edit;
        FieldByName('COM_PESINI').AsFloat  := FPesIni;
        FieldByName('COM_PESFIN').AsFloat  := FPesFin;
        FieldByName('COM_PERCOM').AsFloat  := FPerCom;
        Post;
      End;
    End;
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message + '[pAlteraDados]');
  End;
end;

procedure TComPes.pAtualizaDados;
begin

  With qryDados Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM COMPES WHERE COM_CODTAB = :CODTAB');
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
        qryTabela.FieldByName('COM_VALINI').AsFloat  := cdsDados.FieldByName('COM_VALINI').AsFloat;
        qryTabela.FieldByName('COM_VALFIN').AsFloat  := cdsDados.FieldByName('COM_VALFIN').AsFloat;
      End;
    End;

  End;

end;

procedure TComPes.pAtualizaRegistros;
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
      cdsDados.FieldByName('COM_VALINI').AsFloat  := FValIni;
      cdsDados.FieldByName('COM_VALFIN').AsFloat  := FValFin;
      cdsDados.Post;
      
      cdsDados.Next;
    End;
  Finally
    cdsDados.IndexFieldNames := 'COM_CODTAB;COM_PESINI';
    cdsDados.RecNo := intRecNo;
    cdsDados.EnableControls;
  End;
end;

procedure TComPes.pAtualizaTabela;
begin

  With qryTabela Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM COMPES WHERE COM_CODTAB = :CODTAB');
    ParamByName('CODTAB').AsString := FCodTab;
    Open;
  End;

end;

procedure TComPes.pDeletaItem;
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

function TComPes.fExcluiRegistro: Boolean;
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
      SQL.Add(' SELECT * FROM COMPES WHERE COM_CODTAB = :CODTAB');
      ParamByName('CODTAB').AsString := strCodTab;
      Open;

      If Not IsEmpty Then
      Begin
        First;
        While Not Eof Do
        Begin
          fVerificaIntegridade(Self.Name, 'COMPES', qryTmp, True);
          Next;
        End;

        Close;
        SQL.Clear;
        SQL.Add(' DELETE FROM COMPES WHERE COM_CODTAB = :CODTAB');
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

function TComPes.fExisteProCodCadastrado(strCodPro: String): Boolean;
  Var
    qryTmp: TUniQuery;
Begin
  Try
    qryTmp := fCriaQuery(Self);

    With qryTmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT * FROM COMPES WHERE COM_CODTAB = :CODTAB');
      ParamByName('CODTAB').AsString := strCodPro;
      Open;

      Result := Not IsEmpty;
    End;
  Finally
    FreeAndNil(qryTmp);
  End;
End;

procedure TComPes.pMostraFaixaPesosCadastras;
  Var
    qryTmp: TUniQuery;
    strSQL: String;
    lstLista: TStringList;
begin
  Try
    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   COM_CODTAB, ';
    strSQL := strSQL + '   COM_DESCRI, ';
    strSQL := strSQL + '   COM_VALINI, ';
    strSQL := strSQL + '   COM_VALFIN, ';
    strSQL := strSQL + '   COM_PERCOM  ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   COMPES ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   COM_CODTAB <> :CODTAB ';
    strSQL := strSQL + ' GROUP BY COM_CODTAB ';

    qryTmp := fCriaQuery;

    With qryTmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODTAB').AsString := strCodTab;
      Open;

      If Not IsEmpty Then
      Begin
        lstLista := TStringList.Create;

        lstLista.Add('-----------------------------------------------------------------------');
        lstLista.Add('                FAIXA DE PESOS PARA COMISSÃO CADASTRADOS               ');
        lstLista.Add('-----------------------------------------------------------------------');
        lstLista.Add(' CÓDIGO | DESCRIÇÃO            | VLR. INICIAL | VLR. FINAL   |  COM. % ');
        lstLista.Add('-----------------------------------------------------------------------');

        First;
        while Not Eof Do
        Begin
          lstLista.Add(' ' + fPadR(FieldByName('COM_CODTAB').AsString,6)  + ' | ' +
                             fPadR(FieldByName('COM_DESCRI').AsString,20) + ' | ' +
                             fPadL(FormatFloat('#,##0.00',FieldByName('COM_VALINI').AsFloat),12) + ' | ' +
                             fPadL(FormatFloat('#,##0.00',FieldByName('COM_VALFIN').AsFloat),12) + ' | ' +
                             fPadL(FormatFloat('#,##0.00',FieldByName('COM_PERCOM').AsFloat),7) + '%');
          Next;
        end;

        lstLista.Add('-----------------------------------------------------------------------');

        pCriarFormularios(TfrmMemo, frmMemo);
        frmMemo.cxMemo.Style.Font.Style := [];
        frmMemo.cxMemo.Lines := lstLista;
        frmMemo.ShowModal;
        
        FreeAndNil(lstLista);
        pFreeAndNil(frmMemo);
      End;
    End;
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message + '[pMostraFaixaPesosCadastras]');
  End;

  FreeAndNil(qryTmp);
end;

procedure TComPes.pInsereDados;
begin

  Try

    With cdsDados Do
    Begin
      Append;
      FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('COMPES',VS_strCodEmp);
      FieldByName('COM_CODEMP').AsString := VS_strCodEmp;
      FieldByName('COM_CODTAB').AsString := FCodTab;
      FieldByName('COM_DESCRI').AsString := FDescri;
      FieldByName('COM_VALINI').AsFloat  := FValIni;
      FieldByName('COM_VALFIN').AsFloat  := FValFin;
      FieldByName('COM_PESINI').AsFloat  := FPesIni;
      FieldByName('COM_PESFIN').AsFloat  := FPesFin;
      FieldByName('COM_PERCOM').AsFloat  := FPerCom;
      Post;
    End;

  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;

end;

procedure TComPes.SetobjTipoAcao(const Value: TAcaoObjeto);
begin
  FobjTipoAcao := Value;
end;

procedure TComPes.SetblnUsaProCod(const Value: Boolean);
begin
  FblnUsaProCod := Value;
end;

function TComPes.fValidaFaixaPesoValor(fltValorIni, fltValorFin: Double;
  strCampoIni, strCampoFin: String; vcOpcao: TValidacaoCampo;
  fltValorIniOld, fltValorFinOld: Double): Boolean;
  Var
    Marca: TBookMark;
    qryTmp: TUniQuery;

  function fVerificaCampo(qryDataSet: TDataSet): Boolean;
  Begin
    Result := True;
    
    With qryDataSet Do
    Begin
      First;

      While Not Eof Do
      Begin
        If SameText(FieldByName('AUTOINCREM').AsString, strAutInc) And
           (vcOpcao = vcPeso) Then
        Begin
          Next;
          Continue;
        End;
          
        If (RoundTo(fltValorIni, -3) >= RoundTo(FieldByName(strCampoIni).AsFloat, -3)) Then
        Begin
          If (RoundTo(fltValorFin, -3) <= RoundTo(FieldByName(strCampoFin).AsFloat, -3)) Then
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
  Result := True;

  Try
    If vcOpcao = vcPeso Then
    Begin
      With cdsDados Do
      Begin
        Marca := GetBookmark;
        DisableControls;

        Result := fVerificaCampo(cdsDados);

        If (Not Result) Then
          fMensagem('ATENÇÃO', 'Já existe um % de comissão cadastrado para essa faixa de peso!', ['&Ok']);

        GotoBookmark(Marca);
        FreeBookmark(Marca);
        EnableControls;
      End;
    End
    Else
    Begin
      If (Not fEmptyStr(strAutInc)) And
         (RoundTo(fltValorIni, -3) = RoundTo(fltValorIniOld, -3)) And
         (RoundTo(fltValorFin, -3) = RoundTo(fltValorFinOld, -3)) Then
        Exit;

      qryTmp := fCriaQuery;

      With qryTmp Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT * FROM COMPES WHERE COM_CODTAB <> :CODTAB ');
        ParamByName('CODTAB').AsString := strCodTab;
        Open;

        If Not IsEmpty Then
        Begin
          Result := fVerificaCampo(qryTmp);

          If (Not Result) Then
          Begin
            fMensagem('ATENÇÃO', 'Já existe um % de comissão cadastrado para essa faixa de valor!', ['&Ok']);
            pMostraFaixaPesosCadastras;
          End;
        End;
      End;
      
      FreeAndNil(qryTmp);
    End;
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message + '[fValidaFaixaPesoValor]');
  End;
end;

function TComPes.fValidaPesoValorInvidual(fltValor: Double;
  strCampoIni, strCampoFin: String; vcOpcao: TValidacaoCampo;
  fltValorOld: Double): Boolean;
  Var
    Marca: TBookMark;
    qryTmp: TUniQuery;

  function fVerificaCampo(qryDataSet: TDataSet): Boolean;
  Begin
    Result := True;
    
    With qryDataSet Do
    Begin
      First;

      While Not Eof Do
      Begin
        If SameText(FieldByName('AUTOINCREM').AsString, strAutInc) And
           (vcOpcao = vcPeso) Then
        Begin
          Next;
          Continue;
        End;

        If (RoundTo(fltValor, -3) >= RoundTo(FieldByName(strCampoIni).AsFloat, -3)) And
           (RoundTo(fltValor, -3) <= RoundTo(FieldByName(strCampoFin).AsFloat, -3)) Then
        Begin
          Result := False;
          Break;
        End;

        Next;
      End;
    End;
  End;
begin
  Result := True;

  Try
    If vcOpcao = vcPeso Then
    Begin
      With cdsDados Do
      Begin
        Marca := GetBookmark;
        DisableControls;

        Result := fVerificaCampo(cdsDados);
        
        If (Not Result) Then
          fMensagem('ATENÇÃO', 'Já existe um % de comissão cadastrado para essa faixa de peso!', ['&Ok']);

        GotoBookmark(Marca);
        FreeBookmark(Marca);
        EnableControls;
      End;
    End
    Else
    Begin
      If (Not fEmptyStr(strAutInc)) And
         (RoundTo(fltValor, -3) = RoundTo(fltValorOld, -3)) Then
        Exit;

      qryTmp := fCriaQuery;

      With qryTmp Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT * FROM COMPES WHERE COM_CODTAB <> :CODTAB ');
        ParamByName('CODTAB').AsString := strCodTab;
        Open;

        If Not IsEmpty Then
        Begin
          Result := fVerificaCampo(qryTmp);

          If (Not Result) Then
          Begin
            fMensagem('ATENÇÃO', 'Já existe um % de comissão cadastrado para essa faixa de valor!', ['&Ok']);
            pMostraFaixaPesosCadastras;
          End;
        End;
      End;
      
      FreeAndNil(qryTmp);
    End;
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message + '[fValidaPesoValorInvidual]');
  End;
end;

function TComPes.GetobjTipoAcao: TAcaoObjeto;
begin
  Result := FobjTipoAcao;
end;

function TComPes.GetblnUsaProCod: Boolean;
begin
  Result := FblnUsaProCod;
end;

procedure TComPes.setCodTab(const Value: String);
begin
  If Not fEmptyStr(Value) Then
    FCodTab := Value;

  If Not blnUsaProCod Then
  Begin
    If fEmptyStr(Value) Then
      fMensagem('ATENÇÃO','O código deve ser preenchido!',['&Ok']);
  End;
end;

procedure TComPes.setDescri(const Value: String);
begin
  If Not fEmptyStr(Value) Then
    FDescri := Value
  Else
    fMensagem('ATENÇÃO','A descrição deve ser preenchida!',['&Ok']);
end;

procedure TComPes.setPerCom(const Value: String);
begin
  If Not fEmptyStr(Value) Then
    FPerCom := fStrToFloat(Value)
  Else
    fMensagem('ATENÇÃO','O % de comissão deve ser preenchido!',['&Ok']);
end;

procedure TComPes.setPesFin(const Value: String);
begin
  If Not fEmptyStr(Value) Then
    FPesFin := fStrToFloat(Value)
  Else
    fMensagem('ATENÇÃO','O peso final deve ser preenchido!',['&Ok']);
end;

procedure TComPes.setPesIni(const Value: String);
begin
  If Not fEmptyStr(Value) Then
    FPesIni := fStrToFloat(Value)
  Else
    fMensagem('ATENÇÃO','O peso inicial deve ser preenchido!',['&Ok']);
end;

procedure TComPes.setValFin(const Value: String);
begin
  If Not fEmptyStr(Value) Then
    FValFin := fStrToFloat(Value)
  Else
    fMensagem('ATENÇÃO','O valor final deve ser preenchido!',['&Ok']);
end;

procedure TComPes.setValIni(const Value: String);
begin
  If Not fEmptyStr(Value) Then
    FValIni := fStrToFloat(Value)
  Else
    fMensagem('ATENÇÃO','O valor inicial deve ser preenchido!',['&Ok']);
end;

end.
