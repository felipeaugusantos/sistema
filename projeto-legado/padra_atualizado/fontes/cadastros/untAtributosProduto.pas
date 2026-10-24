unit untAtributosProduto;

interface

Uses
  Classes, SysUtils, Controls, ComCtrls, DB, UniClientDataSet, Forms, Uni,
  untZClient, Math, frxClass, frxBarcode, DBEditFocus, Variants,
  cxDBVGrid, cxStyles;

Const
  TIPO_ATR_ALFANUMERICOS    = 1;
  TIPO_ATR_INTEIRO          = 2;
  TIPO_ATR_DECIMAL          = 3;
  TIPO_ATR_DATA             = 4;
  TIPO_ATR_INTEVALO_INTEIRO = 5;
  TIPO_ATR_INTEVALO_DECIMAL = 6;
  TIPO_ATR_LISTA            = 7;

Type
  TAtributosProduto = Class
  Private
    FCodIte: String;

    FColunaFixa,
    FCategoria: TcxStyle;
    FAtributos: TcxDBVerticalGrid;
    FConsulta: Boolean;

    cdsAtrStr,
    cdsAtrNum,
    cdsAtrDat: TZClient;

    Function fSalvaTabela(cdsTabela: TZClient; strNomTab, strNomCam, strCodIte: String): Boolean;

    Function fCriaDados: Boolean;

    Function fCarregaGrid: Boolean;

    Function fCarregaAtributosClients(strCodIte: String): Boolean;

  Public

    cdsIteDte: TZClient;

    cdsDados: TZClient;

    constructor Create(cxsColunaFixa, cxsCategoria: TcxStyle; cxdAtributos: TcxDBVerticalGrid; blnConsulta: Boolean = False); Reintroduce;

    Destructor Destroy; override;

    procedure pEdita(blnEdita: Boolean = True);

    Function fCarregaAtributos(strCodIte: String): Boolean;

    Function fCarregaAtributosHeranca(strCodIte: String): Boolean;

    Function fSalvaAtributos(strCodIte: String): Boolean;

    procedure pExcluiAtributo;

    Function fIncluiAtributo(strCodAtri: String): Boolean;
  End;

implementation

Uses
  Vcl.StdCtrls,
  System.NetEncoding,
  cxInplaceContainer,
  StrUtils,
  untFuncoesSimples,
  cxVGrid,
  cxCurrencyEdit,
  cxDropDownEdit,
  cxCalendar,
  cxTextEdit;

constructor TAtributosProduto.Create(cxsColunaFixa, cxsCategoria: TcxStyle; cxdAtributos: TcxDBVerticalGrid; blnConsulta: Boolean = False);
Begin
  Inherited Create;

  FAtributos  := cxdAtributos;
  FColunaFixa := cxsColunaFixa;
  FCategoria  := cxsCategoria;
  FConsulta   := blnConsulta;

  cdsDados := TZClient.Create(Nil);

  cdsIteDte := TZClient.Create(Nil, 'SELECT * FROM ITEDTE WHERE ITE_CODITE = :CODITE');

  cdsAtrStr := TZClient.Create(Nil, 'SELECT A.*, ' +
                                    '  C.ATR_TIPATR AS TIPATR, C.ATR_CODIGO AS CODATR, C.ATR_DESCRI AS DESCRI, ' +
                                    '  ATR_NRODEC AS NRODEC, ATR_LISATR AS LISATR, GRU_DESCRI AS DESGRU, ' +
                                    '  CAST(NULL AS CHAR(60)) AS NOMCAM, CAST(NULL AS CHAR(60)) AS NOMCA2 FROM ATRSTR A ' +
                                    ' INNER JOIN CADATR C ON STR_CODATR = ATR_CODIGO ' +
                                    ' LEFT  JOIN GRUATR G ON ATR_CODGRU = GRU_CODIGO ' +
                                    ' WHERE STR_CODITE = :CODITE ' + IIF(FConsulta, ' AND GRU_EXICON = "S" ','') +
                                    ' ORDER BY DESGRU, DESCRI');

  cdsAtrNum := TZClient.Create(Nil, 'SELECT A.*, ' +
                                    '  C.ATR_TIPATR AS TIPATR, C.ATR_CODIGO AS CODATR, C.ATR_DESCRI AS DESCRI, ' +
                                    '  ATR_NRODEC AS NRODEC, ATR_LISATR AS LISATR, GRU_DESCRI AS DESGRU, ' +
                                    '  CAST(NULL AS CHAR(60)) AS NOMCAM, CAST(NULL AS CHAR(60)) AS NOMCA2 FROM ATRNUM A ' +
                                    ' INNER JOIN CADATR C ON NUM_CODATR = ATR_CODIGO ' +
                                    ' LEFT  JOIN GRUATR G ON ATR_CODGRU = GRU_CODIGO ' +
                                    ' WHERE NUM_CODITE = :CODITE ' + IIF(FConsulta, ' AND GRU_EXICON = "S" ','') +
                                    ' ORDER BY DESGRU, DESCRI');

  cdsAtrDat := TZClient.Create(Nil, 'SELECT A.*, ' +
                                    '  C.ATR_TIPATR AS TIPATR, C.ATR_CODIGO AS CODATR, C.ATR_DESCRI AS DESCRI, ' +
                                    '  ATR_NRODEC AS NRODEC, ATR_LISATR AS LISATR, GRU_DESCRI AS DESGRU, ' +
                                    '  CAST(NULL AS CHAR(60)) AS NOMCAM, CAST(NULL AS CHAR(60)) AS NOMCA2 FROM ATRDAT A ' +
                                    ' INNER JOIN CADATR C ON DAT_CODATR = ATR_CODIGO ' +
                                    ' LEFT  JOIN GRUATR G ON ATR_CODGRU = GRU_CODIGO ' +
                                    ' WHERE DAT_CODITE = :CODITE  ' + IIF(FConsulta, ' AND GRU_EXICON = "S" ','') +
                                    ' ORDER BY DESGRU, DESCRI');
End;

Destructor TAtributosProduto.Destroy;
Begin
  FreeAndNil(cdsDados);
  FreeAndNil(cdsIteDte);
  FreeAndNil(cdsAtrStr);
  FreeAndNil(cdsAtrNum);
  FreeAndNil(cdsAtrDat);

  Inherited Destroy;
End;

Function TAtributosProduto.fCarregaAtributosClients(strCodIte: String): Boolean;
Begin
  FCodIte := strCodIte;

  cdsIteDte.qryQuery.ParamByName('CODITE').AsString := strCodIte;
  cdsAtrStr.qryQuery.ParamByName('CODITE').AsString := strCodIte;
  cdsAtrNum.qryQuery.ParamByName('CODITE').AsString := strCodIte;
  cdsAtrDat.qryQuery.ParamByName('CODITE').AsString := strCodIte;

  Result := cdsIteDte.fLeDados('TAtributosProduto.fCarregaAtributos') And
            cdsAtrStr.fLeDados('TAtributosProduto.fCarregaAtributos') And
            cdsAtrNum.fLeDados('TAtributosProduto.fCarregaAtributos') And
            cdsAtrDat.fLeDados('TAtributosProduto.fCarregaAtributos');

  If cdsIteDte.IsEmpty Then
    cdsIteDte.Append
  Else
    cdsIteDte.Edit;
End;

Function TAtributosProduto.fCarregaAtributos(strCodIte: String): Boolean;
Begin
  Result := fCarregaAtributosClients(strCodIte) And
            fCriaDados And
            fCarregaGrid;
End;

Function TAtributosProduto.fCarregaAtributosHeranca(strCodIte: String): Boolean;
  Var
    cdsIteDteHer,
    cdsAtrStrHer,
    cdsAtrNumHer,
    cdsAtrDatHer: TZClient;

    Procedure pCopiaTabela(cdsAtrStr, cdsAtrStrHer: TZClient);
      Var
        intContador: Integer;
    Begin
      cdsAtrStrHer.First;
      While Not cdsAtrStrHer.Eof Do
      Begin
        cdsAtrStr.Insert;

        For intContador := 0 To cdsAtrStr.Fields.Count - 1 Do
          If Pos(cdsAtrStr.Fields[intContador].FieldName, 'AUTOINCREM-STR_CODITE-NUM_CODITE-DAT_CODITE-ITE_CODITE') = 0 Then
            cdsAtrStr.Fields[intContador].Value := cdsAtrStrHer.FieldByName(cdsAtrStr.Fields[intContador].FieldName).Value;

        cdsAtrStr.Post;

        cdsAtrStrHer.Next;
      End;
    End;

Begin
  cdsIteDteHer := TZClient.Create(Nil, cdsIteDte.qryQuery.SQL.Text);
  cdsAtrStrHer := TZClient.Create(Nil, cdsAtrStr.qryQuery.SQL.Text);
  cdsAtrNumHer := TZClient.Create(Nil, cdsAtrNum.qryQuery.SQL.Text);
  cdsAtrDatHer := TZClient.Create(Nil, cdsAtrDat.qryQuery.SQL.Text);

  cdsIteDteHer.qryQuery.ParamByName('CODITE').AsString := strCodIte;
  cdsAtrStrHer.qryQuery.ParamByName('CODITE').AsString := strCodIte;
  cdsAtrNumHer.qryQuery.ParamByName('CODITE').AsString := strCodIte;
  cdsAtrDatHer.qryQuery.ParamByName('CODITE').AsString := strCodIte;

  Result := cdsIteDteHer.fLeDados('TAtributosProduto.fCarregaAtributos') And
            cdsAtrStrHer.fLeDados('TAtributosProduto.fCarregaAtributos') And
            cdsAtrNumHer.fLeDados('TAtributosProduto.fCarregaAtributos') And
            cdsAtrDatHer.fLeDados('TAtributosProduto.fCarregaAtributos') And
            fCarregaAtributosClients('');

  If Result Then
  Begin
    pCopiaTabela(cdsIteDte, cdsIteDteHer);
    pCopiaTabela(cdsAtrStr, cdsAtrStrHer);
    pCopiaTabela(cdsAtrNum, cdsAtrNumHer);
    pCopiaTabela(cdsAtrDat, cdsAtrDatHer);

    Result := fCriaDados And fCarregaGrid;
  End;

  If cdsIteDte.IsEmpty Then
    cdsIteDte.Append;

  FreeAndNil(cdsIteDteHer);
  FreeAndNil(cdsAtrStrHer);
  FreeAndNil(cdsAtrNumHer);
  FreeAndNil(cdsAtrDatHer);
End;

Function TAtributosProduto.fCarregaGrid: Boolean;
(*
  TIPO_ATR_DATA             = 4;

  TIPO_ATR_ALFANUMERICOS    = 1;
  TIPO_ATR_LISTA            = 7;

  TIPO_ATR_INTEIRO          = 2;
  TIPO_ATR_DECIMAL          = 3;
  TIPO_ATR_INTEVALO_INTEIRO = 5;
  TIPO_ATR_INTEVALO_DECIMAL = 6;
*)

  Var
    strBase64Calendar: string;
    intContador: Integer;
    Campo: TcxDBEditorRow;
    DoisCampos: TcxDBMultiEditorRow;

  Function fRetCategoria(strNomCat: String): TcxCategoryRow;
    Var
      row: TcxCustomRow;
  Begin
    row := FAtributos.RowByCaption(strNomCat);

    If Assigned(row) And Row.IsCategory Then
    Begin
      Result := TcxCategoryRow(row);
    End Else
    Begin
      Result :=  TcxCategoryRow(FAtributos.Add(TcxCategoryRow));
      Result.Properties.Caption := strNomCat;
      Result.Properties.HeaderAlignmentHorz := taCenter;
      Result.Options.TabStop := False;
      Result.Options.ShowExpandButton := strNomCat <> EmptyStr;
      Result.Styles.Header := FCategoria;
    End;

  End;

  Procedure pCriaRow(strDescricao, strGrupo: String);
  Begin
    Campo := TcxDBEditorRow(FAtributos.AddChild(fRetCategoria(strGrupo), TcxDBEditorRow));
    Campo.Properties.DataBinding.FieldName := cdsDados.Fields[intContador].FieldName;
    Campo.Styles.Header := FColunaFixa;
    Campo.Properties.Caption := strDescricao + '  ';
    Campo.Properties.HeaderAlignmentHorz := taRightJustify;
  End;


Begin
  strBase64Calendar := 'iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAAXNSR0IArs4c6QAAAA'+
                       'RnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAKYSURBVDhPfZL5SxRh'+
                       'HIcnKju0+0+pSEOkQqRSiUiNDhOPNhUts0NNzRTzyCPL1RTxaDPNrDxBJNNczTIUgz'+
                       'BS99Ddnd1x190tSfdw7dP7vru1/aIDD893hvk+zDDDkWMTweM/tqzDVhd03kzYwElD'+
                       'ggY/hAZj6EwgBk+fxMCp4+gPDsDbQH9G74lj6Ak4gm5/P3Qd9UW732G88fXBC+8DUh'+
                       'Lw4EbCgmFuroS5qQLGxnIYJWUw1j+EoaaIoa8qgL7iPnSPcqAryQJfmAk+Pw2vfA6C'+
                       'BLZxw6FBMJFF7b0EaO7GQ5MeC1WqCHO3ohmzyZFQXLsEecJFyOLOY1p0FvLkGLR6s8'+
                       'B2jj76Ql0J1BmuxdsxbEmZFMFQJISTxQuYEZ3DdEwYpqJCIEuMxMtD+2nAkxM/n4DD'+
                       '8Rs22+o/rHaCyxabw43VfV4mGaMBL67s6TgLPOv4AqXaDEn7BHNDm9P1r8eZhYIbMG'+
                       'jnocu7jiXLCopqR2lgB1dMBodjFTKVaV30WgF6XsC8RsDish15VSPOQH7VR9hXVlHb'+
                       'OoaZWRNqWj4zVzePMlc2fmLmsxMhqAVoMuPx45cd2eXDNLCTyxEPwW53YEppxHfCWt'+
                       'aqtAyeYFq0IaP0PQ3s4jLJYCMBsWQE3xRGPG4YZi6tkzIX1wwyz6VchmaWJ18oCoaf'+
                       'VqQU9tHAbi6VDFYSmJQbMClbWNNqJQ8VRcFj3mRFcm6vM0CHZesKHlQP4Ou0AQVP+p'+
                       'nzKt4x54r7mOWJ4ZiTa9jPpDNacDWrhwb2cHRYIgFapQhmCwSTG3qzlrEM7YITnhCX'+
                       '3u0MRN9skcZldJMLXYil3PlLp5M0Mqd14golldIBESEiqWmIBDwJ5H+m70JrbvauwT'+
                       '4XdPbiOG7jHxkJmflqfDKfAAAAAElFTkSuQmCC';

  Result := True;

  FAtributos.DataController.DataSource := cdsDados.dtsSource;
  FAtributos.ClearRows;

  For intContador := 0 To cdsDados.FieldCount - 1 Do
  Begin

    If AnsiStartsStr('C', cdsDados.Fields[intContador].FieldName) And
       cdsAtrStr.Locate('NOMCAM', cdsDados.Fields[intContador].FieldName, []) Then
    Begin
      pCriaRow(cdsAtrStr.FieldByName('DESCRI').AsString, cdsAtrStr.FieldByName('DESGRU').AsString);

      Case cdsAtrStr.FieldByName('TIPATR').AsInteger Of

        TIPO_ATR_LISTA: Begin
                          Campo.Properties.EditPropertiesClass := TcxComboBoxProperties;
                          TcxComboBoxProperties(Campo.Properties.EditProperties).Items.Text := AnsiReplaceStr(cdsAtrStr.FieldByName('LISATR').AsString, '<<csq>>', #13#10);
                          TcxComboBoxProperties(Campo.Properties.EditProperties).DropDownListStyle := lsFixedList;
                          TcxComboBoxProperties(Campo.Properties.EditProperties).ImmediatePost := True;
                          TcxComboBoxProperties(Campo.Properties.EditProperties).ImmediateUpdateText := True;
                          Campo.Properties.Options.ShowEditButtons := TcxEditItemShowEditButtons(2);
                        End;

        Else Begin
//               Campo.Properties.EditPropertiesClass := TcxCustomTextEditProperties;
//               TcxTextEditProperties(Campo.Properties.EditProperties).CharCase := ecUpperCase;
             End;
      End;

    End

    Else If AnsiStartsStr('D', cdsDados.Fields[intContador].FieldName) And
            cdsAtrDat.Locate('NOMCAM', cdsDados.Fields[intContador].FieldName, []) Then
    Begin
      pCriaRow(cdsAtrDat.FieldByName('DESCRI').AsString, cdsAtrDat.FieldByName('DESGRU').AsString);

      Campo.Properties.EditPropertiesClass := TcxDateEditProperties;
      TcxDateEditProperties(Campo.Properties.EditProperties).View := cavClassic;
      TcxDateEditProperties(Campo.Properties.EditProperties).DateButtons := [];

      TcxDateEditProperties(Campo.Properties.EditProperties).ButtonGlyph.LoadFromStream(TBytesStream.Create(TNetEncoding.Base64.DecodeStringToBytes(strBase64Calendar)));
      Campo.Properties.Options.ShowEditButtons := TcxEditItemShowEditButtons(2);
    End

    Else If AnsiStartsStr('N', cdsDados.Fields[intContador].FieldName) And
            (cdsAtrNum.Locate('NOMCAM', cdsDados.Fields[intContador].FieldName, []) Or
             cdsAtrNum.Locate('NOMCA2', cdsDados.Fields[intContador].FieldName, [])) Then
    Begin

      Case cdsAtrNum.FieldByName('TIPATR').AsInteger Of

        TIPO_ATR_INTEVALO_INTEIRO,
        TIPO_ATR_INTEVALO_DECIMAL: Begin
                                     DoisCampos := TcxDBMultiEditorRow(FAtributos.RowByName('COD_ATRIB_' + cdsAtrNum.FieldByName('CODATR').AsString));

                                     If Not Assigned(DoisCampos) Then
                                     Begin
                                       DoisCampos := TcxDBMultiEditorRow(FAtributos.AddChild(fRetCategoria(cdsAtrNum.FieldByName('DESGRU').AsString), TcxDBMultiEditorRow));
                                       DoisCampos.Name := 'COD_ATRIB_' + cdsAtrNum.FieldByName('CODATR').AsString;
                                       DoisCampos.Styles.Header :=  FColunaFixa;
                                     End;

                                     DoisCampos.Properties.Editors.Add;
                                     DoisCampos.Properties.Editors[DoisCampos.Properties.Editors.Count -1].DataBinding.FieldName := cdsDados.Fields[intContador].FieldName;
                                     DoisCampos.Properties.Editors[DoisCampos.Properties.Editors.Count -1].HeaderAlignmentHorz := taRightJustify;

                                     If DoisCampos.Properties.Editors.Count = 1 Then
                                       DoisCampos.Properties.Editors[DoisCampos.Properties.Editors.Count -1].Caption := cdsAtrNum.FieldByName('DESCRI').AsString + ' (Mín.)   '
                                     Else
                                       DoisCampos.Properties.Editors[DoisCampos.Properties.Editors.Count -1].Caption := cdsAtrNum.FieldByName('DESCRI').AsString + ' (Máx.)   ';

                                     DoisCampos.Properties.Editors[DoisCampos.Properties.Editors.Count -1].EditPropertiesClass   := TcxCurrencyEditProperties;

                                     If cdsAtrNum.FieldByName('TIPATR').AsInteger = TIPO_ATR_INTEVALO_INTEIRO Then
                                     Begin
                                       TcxCurrencyEditProperties(DoisCampos.Properties.Editors[DoisCampos.Properties.Editors.Count -1].EditProperties).DecimalPlaces := 0;
                                       TcxCurrencyEditProperties(DoisCampos.Properties.Editors[DoisCampos.Properties.Editors.Count -1].EditProperties).DisplayFormat := '#,##0;-#,##0';
                                     End Else
                                     Begin
                                       TcxCurrencyEditProperties(DoisCampos.Properties.Editors[DoisCampos.Properties.Editors.Count -1].EditProperties).DecimalPlaces := cdsAtrNum.FieldByName('NRODEC').AsInteger;
                                       TcxCurrencyEditProperties(DoisCampos.Properties.Editors[DoisCampos.Properties.Editors.Count -1].EditProperties).DisplayFormat :=
                                            '#,##0.' + fStrZero('0', cdsAtrNum.FieldByName('NRODEC').AsInteger) + ';-#,##0.' + fStrZero('0', cdsAtrNum.FieldByName('NRODEC').AsInteger);
                                     End;
                                   End;

       TIPO_ATR_INTEIRO: Begin
                           pCriaRow(cdsAtrNum.FieldByName('DESCRI').AsString, cdsAtrNum.FieldByName('DESGRU').AsString);
                           Campo.Properties.EditPropertiesClass := TcxCurrencyEditProperties;
                           TcxCurrencyEditProperties(Campo.Properties.EditProperties).DecimalPlaces := 0;
                           TcxCurrencyEditProperties(Campo.Properties.EditProperties).DisplayFormat := '#,##0;-#,##0';
                         End;


        Else Begin
               pCriaRow(cdsAtrNum.FieldByName('DESCRI').AsString, cdsAtrNum.FieldByName('DESGRU').AsString);
               Campo.Properties.EditPropertiesClass := TcxCurrencyEditProperties;
               TcxCurrencyEditProperties(Campo.Properties.EditProperties).DecimalPlaces := cdsAtrNum.FieldByName('NRODEC').AsInteger;
               TcxCurrencyEditProperties(Campo.Properties.EditProperties).DisplayFormat := '#,##0.' + fStrZero('0', cdsAtrNum.FieldByName('NRODEC').AsInteger) +
                                                                                  ';-#,##0.' + fStrZero('0', cdsAtrNum.FieldByName('NRODEC').AsInteger);
             End;

      End;

    End;

  End;

  FAtributos.Refresh;
End;

Function TAtributosProduto.fCriaDados: Boolean;
  Var
    strSQL: String;
    intContador: Integer;
    stlLista: TStringList;
    stlListaOrdenada: TStringList;
    stlOrdem: TStringList;

    Procedure pSetaNomeCampoNumero(strNomCam: String = 'NOMCAM');
    Begin
      cdsAtrNum.Edit;
      cdsAtrNum.FieldByName(strNomCam).AsString := 'N' + IntToStr(intContador) + '_' + cdsAtrNum.FieldByName('CODATR').AsString + IIF(strNomCam = 'NOMCAM', '_1', '_2');
      cdsAtrNum.Post;

      stlOrdem.Add(cdsAtrNum.FieldByName('DESGRU').AsString + '_' + cdsAtrNum.FieldByName('DESCRI').AsString + IIF(strNomCam = 'NOMCAM', '_1', '_2')+ '_' + fStrZero(IntToStr(intContador), 3));

      Inc(intContador);
    End;

Begin
  Result := True;

  intContador := 0;
  stlLista := TStringList.Create;
  stlListaOrdenada := TStringList.Create;

  stlOrdem := TStringList.Create;
  stlOrdem.Sorted := True;

  cdsAtrStr.First;
  While Not cdsAtrStr.Eof Do
  Begin
    stlLista.Add(' CAST(' + IIF(cdsAtrStr.FieldByName('STR_VALATR').IsNull, 'NULL', '''' + AnsiReplaceStr(cdsAtrStr.FieldByName('STR_VALATR').AsString, '''', '''''') + '''') + ' AS CHAR(999999)) AS C' + IntToStr(intContador) + '_' + cdsAtrStr.FieldByName('CODATR').AsString + '_1');

    stlOrdem.Add(cdsAtrStr.FieldByName('DESGRU').AsString + '_' + cdsAtrStr.FieldByName('DESCRI').AsString + '_' + fStrZero(IntToStr(intContador), 3));

    cdsAtrStr.Edit;
    cdsAtrStr.FieldByName('NOMCAM').AsString := 'C' + IntToStr(intContador) + '_' + cdsAtrStr.FieldByName('CODATR').AsString + '_1';
    cdsAtrStr.Post;

    Inc(intContador);
    cdsAtrStr.Next;
  End;

  cdsAtrNum.First;
  While Not cdsAtrNum.Eof Do
  Begin

    Case cdsAtrNum.FieldByName('TIPATR').AsInteger Of
      TIPO_ATR_INTEIRO          : Begin
                                    stlLista.Add(' CAST(' + IIF(cdsAtrNum.FieldByName('NUM_VALATR').IsNull, 'NULL', AnsiReplaceStr(cdsAtrNum.FieldByName('NUM_VALATR').AsString, ',', '.')) + ' AS DECIMAL(12, 0)) AS N' + IntToStr(intContador) + '_' + cdsAtrNum.FieldByName('CODATR').AsString + '_1');
                                    pSetaNomeCampoNumero;
                                  End;

      TIPO_ATR_DECIMAL          : Begin
                                    stlLista.Add(' CAST(' + IIF(cdsAtrNum.FieldByName('NUM_VALATR').IsNull, 'NULL', AnsiReplaceStr(cdsAtrNum.FieldByName('NUM_VALATR').AsString, ',', '.')) + ' AS DECIMAL(12, ' + cdsAtrNum.FieldByName('NRODEC').AsString + ')) AS N' + IntToStr(intContador) + '_' + cdsAtrNum.FieldByName('CODATR').AsString + '_1');
                                    pSetaNomeCampoNumero;
                                  End;

      TIPO_ATR_INTEVALO_INTEIRO : Begin
                                    stlLista.Add(' CAST(' + IIF(cdsAtrNum.FieldByName('NUM_VALATR').IsNull, 'NULL', AnsiReplaceStr(cdsAtrNum.FieldByName('NUM_VALATR').AsString, ',', '.')) + ' AS DECIMAL(12, 0)) AS N' + IntToStr(intContador) + '_' + cdsAtrNum.FieldByName('CODATR').AsString + '_1');
                                    pSetaNomeCampoNumero;

                                    stlLista.Add(' CAST(' + IIF(cdsAtrNum.FieldByName('NUM_VALATR').IsNull, 'NULL', AnsiReplaceStr(cdsAtrNum.FieldByName('NUM_VALAT2').AsString, ',', '.')) + ' AS DECIMAL(12, 0)) AS N' + IntToStr(intContador) + '_' + cdsAtrNum.FieldByName('CODATR').AsString + '_2');
                                    pSetaNomeCampoNumero('NOMCA2');
                                  End;

      TIPO_ATR_INTEVALO_DECIMAL : Begin
                                    stlLista.Add(' CAST(' + IIF(cdsAtrNum.FieldByName('NUM_VALATR').IsNull, 'NULL', AnsiReplaceStr(cdsAtrNum.FieldByName('NUM_VALATR').AsString, ',', '.')) + ' AS DECIMAL(12, ' + cdsAtrNum.FieldByName('NRODEC').AsString + ')) AS N' + IntToStr(intContador) + '_' + cdsAtrNum.FieldByName('CODATR').AsString + '_1');
                                    pSetaNomeCampoNumero;

                                    stlLista.Add(' CAST(' + IIF(cdsAtrNum.FieldByName('NUM_VALATR').IsNull, 'NULL', AnsiReplaceStr(cdsAtrNum.FieldByName('NUM_VALAT2').AsString, ',', '.')) + ' AS DECIMAL(12, ' + cdsAtrNum.FieldByName('NRODEC').AsString + ')) AS N' + IntToStr(intContador) + '_' + cdsAtrNum.FieldByName('CODATR').AsString + '_2');
                                    pSetaNomeCampoNumero('NOMCA2');
                                  End;
    End;

    cdsAtrNum.Next;
  End;

  cdsAtrDat.First;
  While Not cdsAtrDat.Eof Do
  Begin
    stlLista.Add(' CAST(' + IIF(cdsAtrDat.FieldByName('DAT_VALATR').IsNull, 'NULL', '"' + FormatDateTime('YYYY-MM-DD', cdsAtrDat.FieldByName('DAT_VALATR').AsDateTime) + '"') + ' AS DATE) AS D' + IntToStr(intContador) + '_' + cdsAtrDat.FieldByName('CODATR').AsString + '_1');
    stlOrdem.Add(cdsAtrDat.FieldByName('DESGRU').AsString + '_' + cdsAtrDat.FieldByName('DESCRI').AsString+ '_' + fStrZero(IntToStr(intContador), 3));

    cdsAtrDat.Edit;
    cdsAtrDat.FieldByName('NOMCAM').AsString := 'D' + IntToStr(intContador) + '_' + cdsAtrDat.FieldByName('CODATR').AsString + '_1';
    cdsAtrDat.Post;

    Inc(intContador);
    cdsAtrDat.Next;
  End;

  For intContador := 0 To stlOrdem.Count - 1 Do
    stlListaOrdenada.Add(stlLista[StrToIntDef(RightStr(stlOrdem[intContador], 3), 0)]);

  If stlLista.Count > 0 Then
  Begin
    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + fCommaText(stlListaOrdenada);

    cdsDados.qryQuery.SQL.Text := strSQL;

    Result := cdsDados.fLeDados('TAtributosProduto.fCriaDados');
  End

  Else If cdsDados.Active Then
         cdsDados.Close;

  FreeAndNil(stlLista);
  FreeAndNil(stlOrdem);
  FreeAndNil(stlListaOrdenada);
End;

Function TAtributosProduto.fSalvaAtributos(strCodIte: String): Boolean;
  Var
    intContador: Integer;
Begin
  Try
    If cdsDados.Active And (cdsDados.State = dsEdit) Then
      cdsDados.Post;

    For intContador := 0 To cdsDados.FieldCount - 1 Do
    Begin

      If AnsiStartsStr('C', cdsDados.Fields[intContador].FieldName) Then
      Begin

        If cdsAtrStr.Locate('NOMCAM', cdsDados.Fields[intContador].FieldName, []) Then
        Begin
          cdsAtrStr.Edit;
          cdsAtrStr.FieldByName('STR_VALATR').Value := cdsDados.Fields[intContador].Value;
          cdsAtrStr.Post;
        End;

      End

      Else If AnsiStartsStr('N', cdsDados.FieldS[intContador].FieldName) Then
      Begin

        If cdsAtrNum.Locate('NOMCAM', cdsDados.Fields[intContador].FieldName, []) Then
        Begin
          cdsAtrNum.Edit;
          cdsAtrNum.FieldByName('NUM_VALATR').Value := cdsDados.Fields[intContador].Value;
          cdsAtrNum.Post;
        End

        Else If cdsAtrNum.Locate('NOMCA2', cdsDados.Fields[intContador].FieldName, []) Then
        Begin
          cdsAtrNum.Edit;
          cdsAtrNum.FieldByName('NUM_VALAT2').Value := cdsDados.Fields[intContador].Value;
          cdsAtrNum.Post;
        End;

      End

      Else If AnsiStartsStr('D', cdsDados.FieldS[intContador].FieldName) Then
      Begin

        If cdsAtrDat.Locate('NOMCAM', cdsDados.Fields[intContador].FieldName, []) Then
        Begin
          cdsAtrDat.Edit;
          cdsAtrDat.FieldByName('DAT_VALATR').Value := cdsDados.Fields[intContador].Value;
          cdsAtrDat.Post;
        End;

      End

    End;

    Result := fSalvaTabela(cdsIteDte, 'ITEDTE', 'ITE_CODITE', strCodIte) And
              fSalvaTabela(cdsAtrStr, 'ATRSTR', 'STR_CODITE', strCodIte) And
              fSalvaTabela(cdsAtrNum, 'ATRNUM', 'NUM_CODITE', strCodIte) And
              fSalvaTabela(cdsAtrDat, 'ATRDAT', 'DAT_CODITE', strCodIte);

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TAtributosProduto.fSalvaAtributos]');
      Result := False;
    End;
  End;
End;

Function TAtributosProduto.fSalvaTabela(cdsTabela: TZClient; strNomTab, strNomCam, strCodIte: String): Boolean;
Begin
  If cdsTabela.State In dsEditModes Then
    cdsTabela.Post;

  cdsTabela.Filter   := 'AUTOINCREM IS NULL';
  cdsTabela.Filtered := True;
  cdsTabela.First;

  While Not cdsTabela.Eof Do
  Begin
    cdsTabela.Edit;
    cdsTabela.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem(strNomTab, VS_strCodEmp);
    cdsTabela.FieldByName(strNomCam).AsString    := strCodIte;
    cdsTabela.Post;
  End;

  cdsTabela.Filtered := False;

  Result := cdsTabela.fSalva;
End;

procedure TAtributosProduto.pEdita(blnEdita: Boolean = True);
Begin
  FAtributos.OptionsData.Editing := blnEdita;
End;

procedure TAtributosProduto.pExcluiAtributo;
  Var
    strNomCam,
    strTitulo: String;
Begin
  Try
    If Not Assigned(FAtributos.FocusedRow) Then
      Exit;

    If FAtributos.FocusedRow.IsCategory Then
      Exit;

    If FAtributos.FocusedRow Is TcxDBEditorRow Then
    Begin
      strTitulo := Trim(TcxDBEditorRow(FAtributos.FocusedRow).Properties.Caption);
      strNomCam := TcxDBEditorRow(FAtributos.FocusedRow).Properties.DataBinding.FieldName;
    End Else
    Begin
      strTitulo := Trim(TcxDBMultiEditorRow(FAtributos.FocusedRow).Properties.Editors[0].Caption);
      strTitulo := Trim(AnsiReplaceStr(strTitulo, '(Mín.)', ''));
      strNomCam := TcxDBMultiEditorRow(FAtributos.FocusedRow).Properties.Editors[0].DataBinding.FieldName;
    End;

    If Not fPergunta('Confirma a exclusão do atributo "' + strTitulo + '" ?') Then
      Exit;

    FAtributos.FocusedRow.Visible := False;

    If AnsiStartsStr('C', strNomCam) Then
    Begin

      If cdsAtrStr.Locate('NOMCAM', strNomCam, []) Then
      Begin
        cdsAtrStr.Delete;
      End;

    End

    Else If AnsiStartsStr('N', strNomCam) Then
    Begin

      If cdsAtrNum.Locate('NOMCAM', strNomCam, []) Then
      Begin
        cdsAtrNum.Delete;
      End

      Else If cdsAtrNum.Locate('NOMCA2', strNomCam, []) Then
      Begin
        cdsAtrNum.Delete;
      End;

    End

    Else If AnsiStartsStr('D', strNomCam) Then
    Begin

      If cdsAtrDat.Locate('NOMCAM', strNomCam, []) Then
      Begin
        cdsAtrDat.Delete;
      End;

    End

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TAtributosProduto.pExcluiAtributo]');
    End;
  End;
End;

Function TAtributosProduto.fIncluiAtributo(strCodAtri: String): Boolean;
Const
  SQL_ATRSTR = 'SELECT A.*, ' +
               '  C.ATR_TIPATR AS TIPATR, C.ATR_CODIGO AS CODATR, C.ATR_DESCRI AS DESCRI, ' +
               '  ATR_NRODEC AS NRODEC, ATR_LISATR AS LISATR, GRU_DESCRI AS DESGRU, ' +
               '  CAST(NULL AS CHAR(60)) AS NOMCAM, CAST(NULL AS CHAR(60)) AS NOMCA2 FROM CADATR C ' +
               ' LEFT  JOIN ATRSTR A ON STR_CODATR = ATR_CODIGO AND STR_CODITE = :CODITE ' +
               ' LEFT  JOIN GRUATR G ON ATR_CODGRU = GRU_CODIGO ' +
               ' WHERE ATR_CODIGO = :CODATR';

  SQL_ATRNUM = 'SELECT A.*, ' +
               '  C.ATR_TIPATR AS TIPATR, C.ATR_CODIGO AS CODATR, C.ATR_DESCRI AS DESCRI, ' +
               '  ATR_NRODEC AS NRODEC, ATR_LISATR AS LISATR, GRU_DESCRI AS DESGRU, ' +
               '  CAST(NULL AS CHAR(60)) AS NOMCAM, CAST(NULL AS CHAR(60)) AS NOMCA2 FROM CADATR C ' +
               ' LEFT JOIN ATRNUM A ON NUM_CODATR = ATR_CODIGO AND NUM_CODITE = :CODITE ' +
               ' LEFT  JOIN GRUATR G ON ATR_CODGRU = GRU_CODIGO ' +
               ' WHERE ATR_CODIGO = :CODATR';

  SQL_ATRDAT = 'SELECT A.*, ' +
                '  C.ATR_TIPATR AS TIPATR, C.ATR_CODIGO AS CODATR, C.ATR_DESCRI AS DESCRI, ' +
                '  ATR_NRODEC AS NRODEC, ATR_LISATR AS LISATR, GRU_DESCRI AS DESGRU, ' +
                '  CAST(NULL AS CHAR(60)) AS NOMCAM, CAST(NULL AS CHAR(60)) AS NOMCA2 FROM CADATR C ' +
                ' LEFT JOIN  ATRDAT A ON DAT_CODATR = ATR_CODIGO AND DAT_CODITE = :CODITE ' +
                ' LEFT  JOIN GRUATR G ON ATR_CODGRU = GRU_CODIGO ' +
                ' WHERE ATR_CODIGO = :CODATR';

  Var
    qryCadAtr: TUniQuery;
    cdsSalva: TUniClientDataSet;

  Procedure pIncluiRegisro(cdsAtrStr: TZClient; strSQL, strCampo: String);
    Var
      intContador: Integer;
  Begin
    qryCadAtr.SQL.Text := strSQL;
    qryCadAtr.ParamByName('CODATR').AsString := strCodAtri;
    qryCadAtr.ParamByName('CODITE').AsString := FCodIte;
    qryCadAtr.Open;

    cdsAtrStr.Insert;
    For intContador := 0 To cdsAtrStr.Fields.Count - 1 Do
      cdsAtrStr.Fields[intContador].Value := qryCadAtr.FieldByName(cdsAtrStr.Fields[intContador].FieldName).Value;

    cdsAtrStr.FieldByName(strCampo).Value := cdsAtrStr.FieldByName('CODATR').Value;

    cdsAtrStr.Post;
  End;

  Function fSalvaDados: Boolean;
  Begin
    cdsSalva := Nil;

    If cdsDados.Active Then
    Begin
      cdsSalva := TUniClientDataSet.Create(Nil);
      cdsSalva.Data := cdsDados.Data;
    End;

    Result := True;
  End;

  Function fRestauraDados: Boolean;
    Var
      intContador,
      intDados: Integer;
  Begin

    If Assigned(cdsSalva) Then
    Begin
      cdsDados.Edit;

      For intContador := 0 To cdsSalva.Fields.Count - 1 Do
        For intDados := 0 To cdsDados.Fields.Count - 1 Do
          If SameText(RightStr(cdsSalva.Fields[intContador].FieldName, 7), RightStr(cdsDados.Fields[intDados].FieldName, 7)) Then
            cdsDados.Fields[intDados].Value := cdsSalva.Fields[intContador].Value;

      cdsDados.Post;

      FreeAndNil(cdsSalva);
    End;

    Result := True;
  End;

Begin
  Try

    Try
      cdsDados.DisableControls;

      Result := False;

      qryCadAtr := fCriaQuery;
      qryCadAtr.SQL.Text := 'SELECT * FROM CADATR WHERE ATR_CODIGO = :CODATR';
      qryCadAtr.ParamByName('CODATR').AsString := strCodAtri;
      qryCadAtr.Open;

      If Not qryCadAtr.IsEmpty Then
      Begin
        If cdsAtrStr.Locate('CODATR', strCodAtri, []) Or
           cdsAtrNum.Locate('CODATR', strCodAtri, []) Or
           cdsAtrDat.Locate('CODATR', strCodAtri, []) Then
        Begin
          pMensagemOk('Esse atributo já existe no produto!');
          Exit;
        End;

        Case qryCadAtr.FieldByName('ATR_TIPATR').AsInteger Of
          TIPO_ATR_LISTA,
          TIPO_ATR_ALFANUMERICOS    : pIncluiRegisro(cdsAtrStr, SQL_ATRSTR, 'STR_CODATR');

          TIPO_ATR_INTEIRO,
          TIPO_ATR_DECIMAL,
          TIPO_ATR_INTEVALO_INTEIRO,
          TIPO_ATR_INTEVALO_DECIMAL : pIncluiRegisro(cdsAtrNum, SQL_ATRNUM, 'NUM_CODATR');

          TIPO_ATR_DATA             : pIncluiRegisro(cdsAtrDat, SQL_ATRDAT, 'DAT_CODATR');
        End;

      End;

      Result := fSalvaDados And fCriaDados And fRestauraDados And fCarregaGrid;


    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[TAtributosProduto.pIncluiAtributo]');
      End;
    End;

  Finally
    cdsDados.EnableControls;

    FreeAndNil(qryCadAtr);
  End;

End;

end.
