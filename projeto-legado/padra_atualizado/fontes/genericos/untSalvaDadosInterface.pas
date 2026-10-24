unit untSalvaDadosInterface;

interface

uses
  Classes, SysUtils, Controls, ComCtrls, DB, UniClientDataSet, Forms, untZClient,
  StrUtils, Math, untFuncoesSimples, ExtCtrls, StdCtrls, EditFocus, MaskEditFocus,
  CheckLst, Uni, untTypesSistema, untTEditFocusWithTConsultasArray, DBClient;

Type
  TSalvaInterface = Class(TZClient)

  Private
    FfrmForm: TForm;
    FNomFrm: String;
    FCodOpe: String;

    FArrFrame: Array Of TFrame;
    blnValMin: Boolean;

    Function fSQLInterface(strValKey, strCodOpe: String): String;
    function fAtualizaObjeto(objObjeto: TWinControl): Boolean;
    Function fInterfaceToClient(objObjeto: TWinControl): Boolean;
    Function fSQLInsert: String;

    Function fBuscaNosFrames(strNomCom: String): TComponent;
    procedure pInsereDataGrid(strNOMFRM,
                              StrVALKEY,
                              strNOMCOM,
                              strVALCOM,
                              strAutInc,
                              strCODOPE: String);

  Public

    strNomTab: String;

    blnDeleteNaoEncontrados: Boolean;
    strAutIncCadInt: String;

    constructor Create(Owner: TComponent); Reintroduce;

    Procedure pLocalizaRegistro(strNomCom: String);

    Function fCarregaDados(strValKey: String; frmForm: TForm; strNomFrm: String = ''; strCodOpe: String = '';
       blnCarregaTela: Boolean = True; blnLimparMultiSelecao: Boolean = False; AblnValMin: Boolean = True): Boolean; Virtual;

    Function fAtualizaDados: Boolean; Virtual;

    Procedure pSetFrame(fraFrame: TFrame);

    Function fSalvaDados(strValKey: String;
                         strNomFrm: String = '';
                         strCodOpe: String = '';
                         blnAtualizaDados: Boolean = False;
                         arrCampos: TArrString = Nil;
                         strNomeTabela: String = 'CADINT'): Boolean; Virtual;

    Procedure pAddMultiSelecao(arrMultSel: TConsultasArray; strNomPar: String);
    procedure pAddDataGrid(ClientDataSet: TUniClientDataSet);
    procedure pCarregaDataGrid(ClientDataSet: TUniClientDataSet);

    Procedure pCarregaMultiSelecao(Var arrMultSel: TConsultasArray; strNomPar: String);

    Class Function fApagaInterface(strValKey: String; strNomFrm, strCodOpe, strNomtabela: String): Boolean;

    Class Function fTemInterface(strValKey: String; strNomFrm, strCodOpe, strNomTabela: String): Boolean;

    Procedure pInicializaFrames;

    Property frmDados: TForm Read FfrmForm Write FfrmForm;

  End;

implementation

constructor TSalvaInterface.Create(Owner: TComponent);
Begin
  Inherited Create(Owner, '');
  blnValMin := True;

  strNomTab := 'CADINT';

  SetLength(FArrFrame, 0);

  blnDeleteNaoEncontrados := True;
End;

Procedure TSalvaInterface.pInicializaFrames;
Begin
  SetLength(FArrFrame, 0);
End;

procedure TSalvaInterface.pInsereDataGrid(strNOMFRM, StrVALKEY, strNOMCOM, strVALCOM, strAutInc, strCODOPE: String);
var qryInsert: TUniQuery;
begin
  If FileExists(ExtractFilePath(Application.ExeName) + '\' + strCodOpe + '_' + FNomFrm + '.xml') Then
  Begin
    qryInsert := fCriaQuery;
    qryInsert.SQL.Add('INSERT INTO CADINT (');
    qryInsert.SQL.Add('INT_NOMFRM,');
    qryInsert.SQL.Add('INT_VALKEY ,');
    qryInsert.SQL.Add('INT_NOMCOM ,');
    qryInsert.SQL.Add('INT_VALCOM ,');
    qryInsert.SQL.Add('AUTOINCREM ,');
    qryInsert.SQL.Add('INT_CODOPE) VALUES (');
    qryInsert.SQL.Add(':NOMFRM, ');
    qryInsert.SQL.Add(':VALKEY, ');
    qryInsert.SQL.Add(':NOMCOM, ');
    qryInsert.SQL.Add(':VALCOM, ');
    qryInsert.SQL.Add(':AUTINC, ');
    qryInsert.SQL.Add(':CODOPE) ;');


    qryInsert.ParamByName('NOMFRM').AsString := strNOMFRM;
    If StrVALKEY= '' Then
      qryInsert.ParamByName('VALKEY').Clear
    Else
      qryInsert.ParamByName('VALKEY').AsString := StrVALKEY;
    qryInsert.ParamByName('NOMCOM').AsString := strNOMCOM;
    qryInsert.ParamByName('VALCOM').LoadFromFile(ExtractFilePath(Application.ExeName) + '\' + strCodOpe + '_' + FNomFrm + '.xml', ftBlob);

    qryInsert.ParamByName('AUTINC').AsString := strAutInc;
    qryInsert.ParamByName('CODOPE').AsString := strCODOPE;

    qryInsert.ExecSQL;

    FreeAndNil(qryInsert);
    DeleteFile(ExtractFilePath(Application.ExeName) + '\' + strCodOpe + '_' + FNomFrm + '.xml');
  End;
end;

Function TSalvaInterface.fSQLInterface(strValKey, strCodOpe: String): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT C.* FROM ' + strNomTab + ' C ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   C.INT_NOMFRM = :NOMFRM  ';

  If Not fEmptyStr(strValKey) Then
  Begin
    strSQL := strSQL + ' AND C.INT_VALKEY = :VALKEY ';
    If blnValMin Then
    begin
      strSQL := strSQL + ' AND C.AUTOINCREM = (SELECT MIN(M.AUTOINCREM) FROM ' + strNomTab + ' M ';
      strSQL := strSQL + '                     WHERE C.INT_VALKEY = M.INT_VALKEY AND C.INT_NOMCOM = M.INT_NOMCOM) ';
    End;
  End;

  If Not fEmptyStr(strCodOpe) Then
    strSQL := strSQL + ' AND C.INT_CODOPE = :CODOPE ';

  If fEmptyStr(strCodOpe) And fEmptyStr(strValKey) Then
    strSQL := strSQL + ' AND FALSE ';

  Result := strSQL;
End;

Class Function TSalvaInterface.fTemInterface(strValKey: String; strNomFrm, strCodOpe, strNomTabela: String): Boolean;
  Var
    qryInfo: TUniQuery;
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT COUNT(*) AS QTDINF FROM ' + strNomTabela + ' ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   INT_NOMFRM = :NOMFRM  ';

  If Not fEmptyStr(strValKey) Then
    strSQL := strSQL + ' AND INT_VALKEY = :VALKEY ';

  If Not fEmptyStr(strCodOpe) Then
    strSQL := strSQL + ' AND INT_CODOPE = :CODOPE ';

  If fEmptyStr(strCodOpe) And fEmptyStr(strValKey) Then
    strSQL := strSQL + ' AND FALSE ';

  qryInfo := fCriaQuery(Nil);

  With qryInfo Do
  Begin
    SQL.Text := strSQL;

    ParamByName('NOMFRM').AsString := strNomFrm;

    If Not fEmptyStr(strValKey) Then
      ParamByName('VALKEY').AsString := strValKey;

    If Not fEmptyStr(strCodOpe) Then
      ParamByName('CODOPE').AsString := strCodOpe;

    Open;

    Result := FieldByName('QTDINF').AsInteger > 0;
  End;

  FreeAndNil(qryInfo);
End;

Function TSalvaInterface.fBuscaNosFrames(strNomCom: String): TComponent;
  Var
    intContador: Integer;
Begin
  Result := Nil;

  For intContador := Low(FArrFrame) To High(FArrFrame) Do
  If Assigned(FArrFrame[intContador]) Then
  Begin

    Result := FArrFrame[intContador].FindComponent(strNomCom);

    If Assigned(Result) Then
      Break;
  End;
End;

Procedure TSalvaInterface.pSetFrame(fraFrame: TFrame);
Begin
  SetLength(FArrFrame, Succ(Length(FArrFrame)));
  FArrFrame[High(FArrFrame)] := fraFrame;
End;

Function TSalvaInterface.fCarregaDados(strValKey: String; frmForm: TForm; strNomFrm: String = ''; strCodOpe: String = '';
                                       blnCarregaTela: Boolean = True; blnLimparMultiSelecao: Boolean = False; AblnValMin: Boolean = True): Boolean;
  Var
    comComponente: TComponent;
    intContador : Integer;
    intContador2: Integer;
    sltLista: TStringList;
Begin
  Try
    FfrmForm := frmForm;
    FCodOpe := strCodOpe;
    blnValMin := AblnValMin;
    With qryQuery Do
    Begin
      SQL.Text := fSQLInterface(strValKey, strCodOpe);

      If fEmptyStr(strNomFrm) Then
        FNomFrm := FfrmForm.Name
      Else
        FNomFrm := strNomFrm;

      ParamByName('NOMFRM').AsString := FNomFrm;

      If Not fEmptyStr(strValKey) Then
        ParamByName('VALKEY').AsString := strValKey;

      If Not fEmptyStr(strCodOpe) Then
        ParamByName('CODOPE').AsString := strCodOpe;
    End;

    Result := fAbreClient(True, 'fCarregaDados');

    If Not Result Then
      Exit;

    IndexFieldNames := 'INT_NOMCOM';

    If Not blnCarregaTela Then
      Exit;

    First;
    While Not Eof Do
    Begin
      comComponente := FfrmForm.FindComponent(FieldByName('INT_NOMCOM').AsString);

      If FieldByName('INT_NOMCOM').AsString = 'DATAGRID' Then
      Begin
        If FieldByName('INT_VALCOM').AsString <> '' Then
          TBlobField(FieldByName('INT_VALCOM')).SaveToFile(ExtractFilePath(Application.ExeName) + '\' + strCodOpe + '_' + FNomFrm + '.xml');
      End;

      If Not Assigned(comComponente) Then
        comComponente := fBuscaNosFrames(FieldByName('INT_NOMCOM').AsString);

      If Assigned(comComponente) Then
      Begin

        If SameText(comComponente.ClassName, 'TEditFocus') Then
        Begin
          If blnLimparMultiSelecao Then
          Begin
            If (fStrZero('0', TEditFocus(comComponente).TamCampo) = FieldByName('INT_VALCOM').AsString) Or
                SameText('+1', FieldByName('INT_VALCOM').AsString) Then
                TEditFocus(comComponente).Text := '';

          End
          Else
          Begin
            If Pos(cChaveIdentificaConsultasArray, FieldByName('INT_VALCOM').AsString) > 0 Then
            Begin
              TEditFocus(comComponente).Text := fStrZero('0', TEditFocus(comComponente).TamCampo);
              TEditFocus(comComponente).pIncorporaConsultaArray(FieldByName('INT_VALCOM').AsString);
            End
            Else
              TEditFocus(comComponente).Text := FieldByName('INT_VALCOM').AsString;
          End;
        End

        Else If SameText(comComponente.ClassName, 'TMaskEditFocus') Then
        Begin
          If (blnLimparMultiSelecao) And (fStrZero('0', Length(FieldByName('INT_VALCOM').AsString)) = FieldByName('INT_VALCOM').AsString) Then
            TMaskEditFocus(comComponente).Text := ''
          Else
          Begin


            If Pos(cChaveIdentificaConsultasArray, FieldByName('INT_VALCOM').AsString) > 0 Then
            Begin
              TMaskEditFocus(comComponente).pIncorporaConsultaArray(FieldByName('INT_VALCOM').AsString);
              TMaskEditFocus(comComponente).Text := fStrZero('0', TMaskEditFocus(comComponente).TamanhoCodigo);
            End
            Else
              TMaskEditFocus(comComponente).Text := FieldByName('INT_VALCOM').AsString;
          End;
        End

        Else If SameText(comComponente.ClassName, 'TCheckBox') Then
        Begin

          TCheckBox(comComponente).Checked := FieldByName('INT_VALCOM').AsString = '1';

        End

        Else If SameText(comComponente.ClassName, 'TRadioButton') Then
          TRadioButton(comComponente).Checked := FieldByName('INT_VALCOM').AsString = '1'

        Else If SameText(comComponente.ClassName, 'TComboBox') Or
                SameText(comComponente.ClassName, 'TComboBoxFocus') Then
        Begin

          With TComboBox(comComponente) Do
          If Items.IndexOf(FieldByName('INT_VALCOM').AsString) < Items.Count Then
            ItemIndex := Items.IndexOf(FieldByName('INT_VALCOM').AsString);

        End

        Else If SameText(comComponente.ClassName, 'TRadioGroup') Then
        Begin

          With TRadioGroup(comComponente) Do
          If Items.IndexOf(FieldByName('INT_VALCOM').AsString) < Items.Count Then
            ItemIndex := Items.IndexOf(FieldByName('INT_VALCOM').AsString);

        End

        Else If SameText(comComponente.ClassName, 'TCheckListBox') Then
        Begin
          sltLista      := TStringList.Create;
          sltLista.Text := Trim(FieldByName('INT_VALCOM').AsString);

          With TCheckListBox(comComponente) Do
          For intContador := 0 To sltLista.Count - 1 Do
            For intContador2 := 0 To TCheckListBox(comComponente).Items.Count - 1 Do
              If SameText(Trim(sltLista[intContador]), Trim(Items[intContador2])) Then
                Checked[intContador2] := True;

          FreeAndNil(sltLista);
        End;

        Next;
      End

      Else If blnDeleteNaoEncontrados Then
             Delete
           Else
             Next;

    End;

    Result := True;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, 'TSalvaInterface.fCarregaDados');
    End;
  End;
End;

Procedure TSalvaInterface.pLocalizaRegistro(strNomCom: String);
Begin
  If Locate('INT_NOMCOM', strNomCom, []) Then
  Begin
    Edit;
  End Else
  Begin
    Insert;
    FieldByName('INT_NOMCOM').AsString := strNomCom;
  End;
End;

Function TSalvaInterface.fInterfaceToClient(objObjeto: TWinControl): Boolean;
  Var
    comComponente: TComponent;
    intContador: Integer;
    sltLista: TStringList;
Begin

  Try

    If Assigned(objObjeto) And (objObjeto Is TComponent) Then
    Begin
      comComponente := (objObjeto As TComponent);

      If SameText(comComponente.ClassName, 'TEditFocus') Then
      Begin
        If (comComponente.ClassType = EditFocus.TEditFocus) Then
        Begin
          pLocalizaRegistro(comComponente.Name);
          FieldByName('INT_VALCOM').AsString := TEditFocus(comComponente).Text;
          Post;
        End
        Else
        Begin
          pLocalizaRegistro(comComponente.Name);
          If High(TEditFocus(comComponente).ConsultasArray) > 0 Then
            FieldByName('INT_VALCOM').AsString := TEditFocus(comComponente).ExtraiListaAConsultasArray
          Else
            FieldByName('INT_VALCOM').AsString := TEditFocus(comComponente).Text;
          Post;
        End;

      End

      Else If SameText(comComponente.ClassName, 'TMaskEditFocus') Then
      Begin
        If (comComponente.ClassType = MaskEditFocus.TMaskEditFocus) Then
        Begin
          pLocalizaRegistro(comComponente.Name);
          FieldByName('INT_VALCOM').AsString := TMaskEditFocus(comComponente).Text;
          Post;
        End
        Else
        Begin
          pLocalizaRegistro(comComponente.Name);
          If High(TMaskEditFocus(comComponente).ConsultasArray) > 0 Then
            FieldByName('INT_VALCOM').AsString := TMaskEditFocus(comComponente).ExtraiListaAConsultasArray
          Else
            FieldByName('INT_VALCOM').AsString := TMaskEditFocus(comComponente).Text;
          Post;
        End;
      End

      Else If SameText(comComponente.ClassName, 'TCheckBox') Then
      Begin
        pLocalizaRegistro(comComponente.Name);

        If TCheckBox(comComponente).Checked Then
          FieldByName('INT_VALCOM').AsString := '1'
        Else
          FieldByName('INT_VALCOM').AsString := '0';

        Post;
      End

      Else If SameText(comComponente.ClassName, 'TRadioButton') Then
      Begin
        pLocalizaRegistro(comComponente.Name);

        If TRadioButton(comComponente).Checked Then
          FieldByName('INT_VALCOM').AsString := '1'
        Else
          FieldByName('INT_VALCOM').AsString := '0';

        Post;
      End


      Else If SameText(comComponente.ClassName, 'TComboBox') Or
              SameText(comComponente.ClassName, 'TComboBoxFocus') Then
      Begin
        pLocalizaRegistro(comComponente.Name);
        FieldByName('INT_VALCOM').AsString := TComboBox(comComponente).Text;
        Post;
      End

      Else If SameText(comComponente.ClassName, 'TRadioGroup') Then
      Begin
        pLocalizaRegistro(comComponente.Name);

        With TRadioGroup(comComponente) Do
        If (ItemIndex > -1) And (ItemIndex < Items.Count) Then
        FieldByName('INT_VALCOM').AsString := Items[ItemIndex];

        Post;
      End

      Else If SameText(comComponente.ClassName, 'TCheckListBox') Then
      Begin
        sltLista := TStringList.Create;

        pLocalizaRegistro(comComponente.Name);

        With TCheckListBox(comComponente) Do
        Begin
          For intContador := 0 To Items.Count - 1 Do
            If Checked[intContador] Then
              sltLista.Add(Trim(Items[intContador]))
        End;

        FieldByName('INT_VALCOM').AsString := Trim(sltLista.Text);
        Post;

        FreeAndNil(sltLista);
      End;

    End;

    Result := True;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, 'TSalvaInterface.fInterfaceToClient');
    End;
  End;

End;

Function TSalvaInterface.fAtualizaDados: Boolean;
Begin
  Try

    Result := fAtualizaObjeto(FfrmForm);

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, 'TSalvaInterface.fAtualizaDados');
    End;
  End;
End;

function TSalvaInterface.fAtualizaObjeto(objObjeto: TWinControl): Boolean;
  Var
    intContador: Integer;
Begin
  Result := True;

  If Assigned(objObjeto) Then
  For intContador := 0 To objObjeto.ComponentCount -1 Do
  Begin
    If (objObjeto.Components[intContador] Is TPanel)     Or
       (objObjeto.Components[intContador] Is TScrollBox) Or
       (objObjeto.Components[intContador] Is TGroupBox)  Or
       (objObjeto.Components[intContador] Is TFrame)  Or
       (objObjeto.Components[intContador] Is TTabSheet)  Then
    Begin

      If (objObjeto.Components[intContador] Is TTabSheet) Then
      Begin
        (objObjeto.Components[intContador] As TTabSheet).PageControl.ActivePage := (objObjeto.Components[intContador] As TTabSheet);
      End;

      Result := fAtualizaObjeto((objObjeto.Components[intContador] As TWinControl));

      If Not Result Then
        Exit;

    End
    Else
    Begin
      If (objObjeto.Components[intContador] Is TWinControl) Then
      Begin

        Result := fInterfaceToClient((objObjeto.Components[intContador] As TWinControl));

      End;

      If Not Result Then
        Exit;
    End;

  End;

end;

Function TSalvaInterface.fSQLInsert: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' INSERT INTO ' + strNomTab + ' (';
  strSQL := strSQL + '  INT_NOMFRM, ';
  strSQL := strSQL + '  INT_VALKEY, ';
  strSQL := strSQL + '  INT_NOMCOM, ';
  strSQL := strSQL + '  INT_VALCOM, ';
  strSQL := strSQL + '  INT_CODOPE, ';
  strSQL := strSQL + '  AUTOINCREM  ';
  strSQL := strSQL + ') VALUES ';

  Result := strSQL;
End;

procedure TSalvaInterface.pAddDataGrid(ClientDataSet: TUniClientDataSet);
begin
  ClientDataSet.SaveToFile(ExtractFilePath(Application.ExeName) + '\' + FCodOpe + '_' + FNomFrm + '.xml', dfXml);
  pLocalizaRegistro('DATAGRID');

  FieldByName('INT_VALCOM').AsString := '';

  Post;
end;

Procedure TSalvaInterface.pAddMultiSelecao(arrMultSel: TConsultasArray; strNomPar: String);
  Var
    stlLista: TStringList;
    intContador: Integer;
Begin
  stlLista := TStringList.Create;

  For intContador := Low(arrMultSel) To High(arrMultSel) Do
    If Not fEmptyStr(arrMultSel[intContador].strCodigo) Then
      stlLista.Add(arrMultSel[intContador].strCodigo);

  pLocalizaRegistro(strNomPar);

  FieldByName('INT_VALCOM').AsString := stlLista.Text;
  Post;

  FreeAndNil(stlLista);
End;

procedure TSalvaInterface.pCarregaDataGrid(ClientDataSet: TUniClientDataSet);
begin
  If FileExists(ExtractFilePath(Application.ExeName) + '\' + FCodOpe + '_' + FNomFrm + '.xml') Then
  Begin
    Try
      ClientDataSet.LoadFromFile(ExtractFilePath(Application.ExeName) + '\' + FCodOpe + '_' + FNomFrm + '.xml');
      DeleteFile(ExtractFilePath(Application.ExeName) + '\' + FCodOpe + '_' + FNomFrm + '.xml');

    Except
      DeleteFile(ExtractFilePath(Application.ExeName) + '\' + FCodOpe + '_' + FNomFrm + '.xml');

      ClientDataSet.CreateDataSet;
      ClientDataSet.LogChanges := False;
    End;
  End;
end;

Procedure TSalvaInterface.pCarregaMultiSelecao(Var arrMultSel: TConsultasArray; strNomPar: String);
  Var
    stlLista: TStringList;
    intContador: Integer;
Begin
  stlLista := TStringList.Create;

  pLocalizaRegistro(strNomPar);
  stlLista.Text := Trim(FieldByName('INT_VALCOM').AsString);
  Post;

  SetLength(arrMultSel, stlLista.Count);

  For intContador := Low(arrMultSel) To High(arrMultSel) Do
    arrMultSel[intContador].strCodigo := stlLista[intContador];

  FreeAndNil(stlLista);
End;

Function TSalvaInterface.fSalvaDados(strValKey: String;
                                     strNomFrm: String = '';
                                     strCodOpe: String = '';
                                     blnAtualizaDados: Boolean = False;
                                     arrCampos: TArrString = Nil;
                                     strNomeTabela: String = 'CADINT'): Boolean;
  Var
    stlLista: TStringList;
    strNomCom: String;
    qryCadInt: TUniQuery;
    intContador: Integer;
    blnDeletaCadIntAntes: Boolean;


  procedure pGeraInsert;
  Begin
    If Not SameText(strNomCom, FieldByName('INT_NOMCOM').AsString) Then
    Begin
      If FieldByName('INT_NOMCOM').AsString = 'DATAGRID' Then
        pInsereDataGrid(FNomFrm, IfThen(fEmptyStr(strValKey), '', strValKey),
                        FieldByName('INT_NOMCOM').AsString,
                        FieldByName('INT_VALCOM').AsString,
                        strAutIncCadInt,
                        IfThen(fEmptyStr(strCodOpe), '', strCodOpe))
      Else
      Begin
        If stlLista.Count > 0 Then
          stlLista.Add(', ');

        stlLista.Add('(' + QuotedStr(FNomFrm)   + ', ' +
                           IfThen(fEmptyStr(strValKey), '(NULL)', QuotedStr(strValKey)) + ', ' +
                           QuotedStr(FieldByName('INT_NOMCOM').AsString) + ', ' +
                           QuotedStr(FieldByName('INT_VALCOM').AsString) + ', ' +
                           IfThen(fEmptyStr(strCodOpe), '(NULL)', QuotedStr(strCodOpe)) + ', ' +
                           QuotedStr(strAutIncCadInt) + ')');
      End;
      strNomCom := FieldByName('INT_NOMCOM').AsString;

      strAutIncCadInt := fNextAutoIncrem(strAutIncCadInt);
    End;
  End;
Begin
  FCodOpe := strCodOpe;

  blnDeletaCadIntAntes := False;
  If SameText(strNomFrm, 'frmAltPrecoIndividual') Then
    blnDeletaCadIntAntes := True;

  Try
    If blnAtualizaDados Then
      If Not fAtualizaDados Then
      Begin
        Result := False;
        Exit;
      End;

    If Not Active Then
    Begin
      Result := True;
      Exit;
    End;

    strNomTab := strNomeTabela;

    If Not fEmptyStr(strNomFrm) Then
      FNomFrm := strNomFrm;

    stlLista := TStringList.Create;

    If blnDeletaCadIntAntes Then
     fApagaInterface(strValKey, FNomFrm, strCodOpe, strNomTab);

    strNomCom := '';

    strAutIncCadInt := fRetAutoIncrem(strNomTab, VS_strCodEmp, RecordCount);

    First;
    While Not Eof Do
    Begin

      If Assigned(arrCampos) then
      Begin

        For intContador := Low(arrCampos) To High(arrCampos) Do
        Begin
          If FieldByName('INT_NOMCOM').AsString = arrCampos[intContador] Then
            pGeraInsert;
        End;


      End
      Else
      Begin
        pGeraInsert;
      End;

      Next;
    End;

    If stlLista.Count > 0 Then
    Begin

      If Not blnDeletaCadIntAntes Then
        fApagaInterface(strValKey, FNomFrm, strCodOpe, strNomTab);

      qryCadInt := fCriaQuery;

      qryCadInt.SQL.add(fSqlInsert);
      qryCadInt.SQL.Add(stlLista.Text + ';');

      qryCadInt.ExecSQL;

      FreeAndNil(qryCadInt);
    End;

    Result := True;

    stlLista.Clear;
    FreeAndNil(stlLista);

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, 'TSalvaInterface.fSalvaDados');
    End;
  End;
End;

Class Function TSalvaInterface.fApagaInterface(strValKey: String; strNomFrm, strCodOpe, strNomTabela: String): Boolean;
  Var
    strSQL: String;
    qryDelete: TUniQuery;
Begin
  Try
    strSQL := '';
    strSQL := strSQL + ' DELETE FROM ' + strNomTabela + ' ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   INT_NOMFRM = :NOMFRM ';

    If Not fEmptyStr(strValKey) Then
      strSQL := strSQL + ' AND INT_VALKEY = :VALKEY '

    Else If Not fEmptyStr(strCodOpe) Then
      strSQL := strSQL + ' AND INT_CODOPE = :CODOPE ';

    qryDelete := fCriaQuery;
    With qryDelete Do
    Begin
      SQL.Text := strSQL;

      ParamByName('NOMFRM').AsString := strNomFrm;

      If Not fEmptyStr(strValKey) Then
        ParamByName('VALKEY').AsString := strValKey

      Else If Not fEmptyStr(strCodOpe) Then
        ParamByName('CODOPE').AsString := strCodOpe;

      ExecSQL;
    End;
    FreeAndNil(qryDelete);

    Result := True;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, 'TSalvaInterface.fApagaInterface');
    End;
  End;

End;

end.
