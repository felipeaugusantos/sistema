unit untConfiguraConsulta;

interface

Uses
  Uni,
  ExtCtrls,
  EditFocus,
  Dialogs,
  SysUtils,
  DB, UniClientDataSet, UniDataSetProvider,
  Controls,
  Classes,
  StrUtils,
  cxVGrid,
  cxEdit,
  untModulo,
  cxClasses,
  cxCustomData,
  cxCalendar,
  cxTimeEdit,
  cxCurrencyEdit,
  cxGridDBTableView,
  cxGridCustomView,
  cxTextEdit,
  cxDropDownEdit,
  cxGrid,
  Variants,
  Graphics,
  cxStyles,
  dxCore,
  untPesquisa,
  Windows,
  ComCtrls,
  CRParser,
//  MyParserUni,
  untClassPanelCx,
  untTypesSistema,
  StdCtrls;

Type
  TRecConfiguracao = Record
    blnFetch_: Boolean;
    blnComKey: Boolean;
    blnZebrad: Boolean;
    intCorZeb: Integer;
    intTanFon: Integer;
    blnConsCo: Boolean;
    blnConsCoOriginal: Boolean;

    intAltPan,
    intRowHea,
    intWidRow,
    intWidVal,
    intRecNo: Integer;

    strValor: String;

    aliAliPes: TAlign;
  End;

  TConfiguraConsulta = Class(TComponent)
    Private
      FLeuConf: Boolean;
      FChave: String;
      FCfgCon: TUniQuery;
      FCfgEmp: TUniQuery;

      FarrSubCon: TArrRecSubConsulta;
      FAutoSelecao: TStringList;
      FContida: TStringList;

      FIndDef: TStringList;

      FConfigur: TRecConfiguracao;
      FColunas : TUniClientDataSet;
      FColSelec: TUniClientDataSet;
      FConsulta: TDataSet;
      FFullText: TUniClientDataSet;

      FstlFullT: TStringList;

      FPesquisa    : TcxVerticalGrid;
      FStyleEve    : TcxStyle;
      FConsultaView: TcxGridDBTableView;
      FSepPes      : TSplitter;
      FcxConsulta  : TcxGrid;
      FLoadView    : Boolean;

      FstrSQL: String;

      FCurrRow: Integer;

      FCalcAlt: Boolean;

      FEmpresas: TUniClientDataSet;
      FarrSimNao: TStringArrayArray;
      FpAtualizaPesquisa : TAtualizaDados;

      Function fNomeCampoFiltro(strNomCam: String): String;
      Function fConverteFullText(strFiltro: String): String;
      Function fReplicaConfiguracao: String;
      Function fLeConfiguracao(blnLoadV, blnMontaFullText, blnMontaPesquisa: Boolean): Boolean;
      Function fSalvaConfiguracao: Boolean;
      Function fRetCamposPesquisa: String;
      Function fRetCamposContida: String;
      Function fRetCamposExibir: String;
      Function fRetCamposCompletaComZeros: String;
      Function fRetDecimais(strDisplay: String): Integer;
      Function fTotalSelecao: Double;
      Function fCarregarView: Boolean;
      Function fRetCamposFullText: String;
      Function fSQLFullText(strNomCam, strFiltro: String): String;

      Procedure pMarcaFullText;
      Procedure pIncluiConfEmpresa(strCodEmp, strSeqGer: String);
      Procedure pSalvaCFGEMP(strAutInc: String);
      Procedure pCarregaCFGEMP(strAutInc: String);
      Procedure pCriaColunas;
      Procedure pCriaColunasSel;
      Procedure pCriaEmpresas;
      Procedure pCarregaColunas;
      Procedure pCarregaExibir;
      Procedure pCarregaPesquisar;
      procedure pBeforePostColunas(DataSet: TDataSet);
      procedure pIncluiContida(blnInclui: Boolean; strNomCam: String);
      procedure pReordenaColunasSel;
      Procedure pSetaColunasGrid;
      Procedure pRecriaConfEmpresas;
      Procedure pMontaFulltext(blnMarcar: Boolean);
      Procedure pBeforePostEmpresas(dataSet: TDataSet);
      Procedure pCarregaFullText(strFullText : String);

      procedure cxValidate(Sender: TObject; var DisplayValue: Variant;
                              var ErrorText: TCaption; var Error: Boolean);

      procedure pChangeComboBox(Sender: TObject);

      function fGetSQLTextoContido(strCampo, strTexto: String): String;

      procedure pCompletaComZerosPesquisa(cxEditorRow: TcxEditorRow);
      procedure pAjustaConsultaContida(cxEditorRow: TcxEditorRow);

    Public
      blnConsCoCfg: Boolean;

      constructor Create(Owner: TComponent;
                         strChave,
                         strSQL: String;
                         stlIndices: TStringList;
                         cdsConsulta: TDataSet;
                         cxgPesquisa: TcxVerticalGrid;
                         cxConsultaView: TcxGridDBTableView;
                         cxStyleEven: TcxStyle;
                         splSepPes: TSplitter;
                         cxConsulta  : TcxGrid;
                     var arrSimNao: TStringArrayArray;
                         pAtualizaPesquisaP : TAtualizaDados;
                         arrSubCon: TArrRecSubConsulta); Reintroduce;

      Destructor Destroy; override;

      Function fConsultaContida(strCampo: String): Boolean;
      Function fPesquisaNaDigitacao: Boolean;
      Procedure pMontaPesquisa(blnLimpar: Boolean = False);

      Procedure pAjustaTamanhoDefaultGridPesquisa;

      Function fDescricaoToNomeCampo(strDescricao: String): String;
      Function fEditaConfiguracoes: Boolean;
      Function fValidaConsulta: Boolean;
      Function fSalvaPesquisa(pnlPesquisaHeight: Integer; view: TcxGridDBTableView; qryConsulta: TDataSet): Boolean;

      Procedure pMarcaEmpresas(blnMarcar: Boolean);
      Procedure pMudaOrdenacao(strNomCol: String);
      Procedure pAlteraOrdemColuna(blnSobe: Boolean);
      Procedure pMudaCorZebra(blnBestFit: Boolean);
      Procedure pMarcaExibirTodos(blnMarcar: Boolean);
      procedure pDefineConsultaContida(blnUtiliza: Boolean; strNomCam: String);
      Procedure pFocoNaPesquisa;
      Procedure pVerificaLimitePesquisa;
      Procedure pProximaOrdenacao;
      Procedure pPosicionaOrdenacao;
      Procedure pCriaFulltext;

      Function fSQLFiltro: String;
      Function fColunaAutoSelecao(strNomCam: String): Boolean;

    published

      property cdsEmpresas: TUniClientDataSet Read FEmpresas Write FEmpresas;
      property cdsColunas:  TUniClientDataSet Read FColunas  Write FColunas;
      property cdsColSelec: TUniClientDataSet Read FColSelec Write FColSelec;
      property cdsFullText: TUniClientDataSet Read FFullText Write FFullText;
      property blnLeuConf : Boolean           Read FLeuConf;

      property recConfigur: TRecConfiguracao Read FConfigur;
      property blnCalcAlt: Boolean Read FCalcAlt Write FCalcAlt;
      property blnLoadView: Boolean Read FLoadView;

  End;

implementation

uses untFuncoesCXGrid, untFuncoesConsulta, untFuncoes, untConfiguraConsultaEdicao;

constructor TConfiguraConsulta.Create(Owner: TComponent;
   strChave,
   strSQL: String;
   stlIndices: TStringList;
   cdsConsulta: TDataSet;
   cxgPesquisa: TcxVerticalGrid;
   cxConsultaView: TcxGridDBTableView;
   cxStyleEven: TcxStyle;
   splSepPes: TSplitter;
   cxConsulta: TcxGrid;
   var arrSimNao: TStringArrayArray;
   pAtualizaPesquisaP : TAtualizaDados;
   arrSubCon: TArrRecSubConsulta);
Begin
  Inherited Create(Owner);

  FarrSubCon := arrSubCon;

  blnConsCoCfg := fCfgSis('CONSCO', VarBoolean);

  FContida := TStringList.Create;
  FContida.Sorted := True;

  FstrSQL   := strSQL;
  FChave    := strChave;
  FConsulta := cdsConsulta;
  FCfgCon   := fCriaQuery(Self);
  FCfgEmp   := fCriaQuery(Self);
  FPesquisa := cxgPesquisa;
  FStyleEve := cxStyleEven;
  FSepPes   := splSepPes;

  FIndDef      := TStringList.Create;
  FIndDef.Text := stlIndices.Text;

  FcxConsulta   := cxConsulta;
  FConsultaView := cxConsultaView;

  FFullText := Nil;
  FColunas  := Nil;
  FColSelec := Nil;
  FCurrRow  := 1;

  FstlFullT := TStringList.Create;
  FarrSimNao := arrSimNao;
  FpAtualizaPesquisa := pAtualizaPesquisaP;

  FLeuConf := fLeConfiguracao(True, False, False);

  pMudaCorZebra(False);

  If Not FLeuConf Then
  Begin
    FConsultaView.ApplyBestFit;
  End;
End;

Destructor TConfiguraConsulta.Destroy;
Begin
  Inherited;

  FreeAndNil(FIndDef);
  FreeAndNil(FstlFullT);
  FreeAndNil(FContida);
End;

Function TConfiguraConsulta.fRetDecimais(strDisplay: String): Integer;
  Var
    intPosicao: Integer;
Begin
  intPosicao := Pos('.', strDisplay);

  Result := Length(strDisplay) - intPosicao;

  If Result <= 0 Then
    Result := 2;
End;

procedure TConfiguraConsulta.cxValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  If Error Then
    ErrorText := '';
end;

Procedure TConfiguraConsulta.pChangeComboBox(Sender: TObject);
Begin
  FpAtualizaPesquisa;
End;

Procedure TConfiguraConsulta.pAjustaTamanhoDefaultGridPesquisa;
  Var
    intIndice,
    intMaxWid: Integer;
Begin
  FPesquisa.OptionsView.ScrollBars      := ssNone;

  intMaxWid := 0;
  For intIndice := 1 To FPesquisa.Rows.Count - 1 Do
  Begin
    If FPesquisa.Canvas.TextWidth(TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.Caption) > intMaxWid Then
      intMaxWid := FPesquisa.Canvas.TextWidth(TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.Caption);
  End;

  FPesquisa.OptionsView.RowHeaderWidth := intMaxWid + 30;
  FPesquisa.OptionsView.ValueWidth     := 250;
  FPesquisa.Width                      := FPesquisa.OptionsView.RowHeaderWidth + FPesquisa.OptionsView.ValueWidth;
  FPesquisa.Parent.ClientHeight        := (FColSelec.RecordCount) * 19 + 7 {pnlPainelSep} + 18{pnlPesquisaTop} + 2;

  FPesquisa.OptionsView.ScrollBars      := ssBoth;
End;

Procedure TConfiguraConsulta.pMontaPesquisa(blnLimpar: Boolean = False);
  Var
    intIndice: Integer;
    filCammpo: TField;
    intIdxTmp,
    intQtdCol: Integer;

  Function MatchTextArray(strValor: String; arrArray: TStringArrayArray): Boolean;
    Var
      intCont: Integer;
  Begin
    intIdxTmp := 0;
    Result := False;

    For intCont := Low(arrArray) To High(arrArray) Do
    Begin
      If SameText(strValor, arrArray[intCont, 0]) Then
      Begin
        intIdxTmp := intCont;
        Result := True;
        Break;
      End;
    End;
  End;
Begin
  FPesquisa.Rows[0].Visible := False;

  For intIndice := 1 To FPesquisa.Rows.Count - 1 Do
  Begin
    FPesquisa.Rows[intIndice].Visible := False;
    TcxEditorRow(FPesquisa.Rows[intIndice]).Name := 'ROW' + IntToStr(intIndice);

    If blnLimpar then
      TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.Value := Null;
  End;

  With FColSelec Do
  Begin
    intIndice := 1;

    DisableControls;
    First;

    While Not Eof do
    Begin
      FPesquisa.Rows[intIndice].Visible := True;

      TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.Caption := FieldByName('DESCAM').AsString;
      TcxEditorRow(FPesquisa.Rows[intIndice]).Name               := FieldByName('NOMCAM').AsString;

      filCammpo := FConsulta.FindField(FieldByName('NOMCAM').AsString);

      If Assigned(filCammpo) Then
      Begin
        if MatchTextArray(filCammpo.FieldName, FarrSimNao) Then
        Begin
          TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.EditPropertiesClass := TcxComboBoxProperties;
          TcxComboBoxProperties(TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.EditProperties).Items.Clear;

          With TcxComboBoxProperties(TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.EditProperties).Items Do
          Begin
            If (High(FarrSimNao[intIdxTmp]) > 1) And (Not fEmptyStr(FarrSimNao[intIdxTmp][1])) Then
            Begin
              For intQtdCol := Low(FarrSimNao[intIdxTmp]) To High(FarrSimNao[intIdxTmp]) Do
              Begin
                If intQtdCol > 0 Then
                  Add(FarrSimNao[intIdxTmp][intQtdCol]);
              End;
            End
            Else
            Begin
              Add('SIM');
              Add('NÃO');
              Add('TODOS');
            End;
          End;
          With TcxComboBoxProperties(TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.EditProperties) Do
          Begin
            DropDownListStyle   := lsFixedList;
            ImmediatePost       := True;
            ImmediateUpdateText := True;
            OnChange            := pChangeComboBox;
          End;


        End
        Else
        Case filCammpo.DataType Of
          ftFloat    : Begin
                         TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.EditPropertiesClass := TcxCurrencyEditProperties;

                         TcxCurrencyEditProperties(TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.EditProperties).DecimalPlaces :=
                           fRetDecimais(TFloatField(filCammpo).DisplayFormat);

                         TcxCurrencyEditProperties(TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.EditProperties).DisplayFormat := '0.00;-0.00';

                         TcxCurrencyEditProperties(TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.EditProperties).OnValidate := cxValidate;
                       End;

          ftSmallint,
          ftInteger,
          ftWord     : Begin
                         TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.EditPropertiesClass := TcxCurrencyEditProperties;

                         TcxCurrencyEditProperties(TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.EditProperties).DecimalPlaces := 0;
                         TcxCurrencyEditProperties(TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.EditProperties).DisplayFormat := '';
                         TcxCurrencyEditProperties(TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.EditProperties).OnValidate := cxValidate;
                       End;

          ftTime     : TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.EditPropertiesClass := TcxTimeEditProperties;
          ftDateTime,
          ftDate     : TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.EditPropertiesClass := TcxCustomDateEditProperties;

          Else         Begin
                         TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.EditPropertiesClass := TcxTextEditProperties;
                         TcxTextEditProperties(TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.EditProperties).CharCase := ecUpperCase;
                       End;
        End;

      End;

      Inc(intIndice);

      Next;
    End;

    EnableControls;
  End;

  If FCalcAlt Then
  Begin
    pAjustaTamanhoDefaultGridPesquisa;
  End Else
  Begin
    FPesquisa.OptionsView.ScrollBars      := ssNone;
    FPesquisa.Width                       := FConfigur.intWidRow;
    FPesquisa.OptionsView.ValueWidth      := FConfigur.intWidVal;
    FPesquisa.OptionsView.RowHeaderWidth  := FConfigur.intRowHea;
    FPesquisa.Parent.ClientHeight         := FConfigur.intAltPan;
    FPesquisa.OptionsView.ScrollBars      := ssBoth;
  End;

  FPesquisa.Parent.Align  := FConfigur.aliAliPes;

  Case FConfigur.aliAliPes Of
    alTop    : Begin
                 FSepPes.Align := alTop;
                 FSepPes.Top   := FPesquisa.Parent.Top + FPesquisa.Parent.Height + FSepPes.Height;
               End;
    alBottom : Begin
                 FSepPes.Align := alBottom;
                 FSepPes.Top := FPesquisa.Parent.Top - FSepPes.Height;
               End;
  End;

  FCurrRow  := 1;
End;

Procedure TConfiguraConsulta.pMudaOrdenacao(strNomCol: String);
Begin
  If FConsultaView.GetColumnByFieldName(strNomCol) <> Nil Then
  Begin
    FConsultaView.DataController.ClearSorting(True);
    FConsultaView.GetColumnByFieldName(strNomCol).SortOrder := soAscending;
  End;
End;

Function TConfiguraConsulta.fLeConfiguracao(blnLoadV, blnMontaFullText, blnMontaPesquisa: Boolean): Boolean;
  Var
    stlDimPes: TStringList;
Begin
  Try

    With FCfgCon, SQL, FConfigur do
    Begin
      Close;
      Clear;

      Add('SELECT C.* FROM CFGCON C');
      Add('INNER JOIN CFGEMP E ON E.CFG_CODEMP = :CODEMP AND E.CFG_SEQGER = C.AUTOINCREM');
      Add('WHERE C.CFG_CHAVE_ = :CHAVE_  ');

      ParamByName('CHAVE_').AsString := FChave;
      ParamByName('CODEMP').AsString := VS_strCodEmp;

      Open;

      Result := Not IsEmpty;

      If Result Then
        pCarregaCFGEMP(FieldbyName('AUTOINCREM').AsString)
      Else
        pCarregaCFGEMP('');

      intAltPan := 0;
      intRowHea := 0;
      intWidRow := 0;
      intWidVal := 200;

      aliAliPes := alBottom;

      blnFetch_ := True;
      blnComKey := True;
      blnZebrad := True;
      intCorZeb := 15589325;
      blnConsCo := False;
      blnConsCoOriginal := False;
      intTanFon := 8;
      strValor  := '';
      intRecNo  := 1;
      FLoadView := False;

      If Result Then
      Begin
        blnComKey := FieldByName('CFG_COMKEY').AsString = 'S';

        if Assigned(FindField('CFG_FETCH_')) then
          blnFetch_ := FieldByName('CFG_FETCH_').AsString = 'S';

        blnZebrad := FieldByName('CFG_ZEBRAD').AsString = 'S';

        If FieldByName('CFG_CORZEB').IsNull then
          intCorZeb := 0
        Else
          intCorZeb := FieldByName('CFG_CORZEB').AsInteger;

        blnConsCo := (FieldByName('CFG_CONSCO').AsString = 'S') And blnConsCoCfg;
        blnConsCoOriginal := blnConsCo;

        intTanFon := FieldByName('CFG_TAMFON').AsInteger;

        stlDimPes      := TStringList.Create;
        stlDimPes.Text := FieldByName('CFG_DIMPES').AsString;

        If stlDimPes.Count > 0 then
          intAltPan := StrToInt64Def(stlDimPes[0], 0);

        If stlDimPes.Count > 1 then
          intWidRow := StrToInt64Def(stlDimPes[1], 0);

        If stlDimPes.Count > 2 then
          intRowHea := StrToInt64Def(stlDimPes[2], 0);

        If stlDimPes.Count > 3 then
          intWidVal := StrToInt64Def(stlDimPes[3], 0);

        Case FieldByName('CFG_ALIPES').AsInteger Of
          0: aliAliPes := alTop;
          1: aliAliPes := alBottom;
        End;

        strValor := FieldByName('CFG_VALOR_').AsString;

        If FieldByName('CFG_RECNO_').IsNull Then
          intRecNo := 1
        Else
          intRecNo := FieldByName('CFG_RECNO_').AsInteger;

        pCarregaFullText(FieldByName('CFG_FULLTE').AsString);

        FreeAndNil(stlDimPes);
      End;

      If Result And blnLoadV then
        FLoadView := fCarregarView;

      FCalcAlt := Not ((intAltPan > 0) And (intRowHea > 0) And (intWidRow > 0));

      If intTanFon < 8 Then
       intTanFon := 8;
    End;

    pCriaEmpresas;
    pCarregaColunas;
    pCarregaExibir;
    pCarregaPesquisar;

    If blnMontaPesquisa Then
      pMontaPesquisa;

    If FCfgCon.FieldByName('CFG_FULLTE').IsNull Or blnMontaFullText Then
      pMontaFulltext(FCfgCon.FieldByName('CFG_FULLTE').IsNull);

    FColunas.BeforePost := pBeforePostColunas;

  Except
    On E: Exception Do
    Begin
      Result := False;
      ShowMessage(E.Message);
    End;
  End;
End;

Function TConfiguraConsulta.fRetCamposContida: String;
Begin
  If blnConsCoCfg Then
    Result := FContida.CommaText
  Else
    Result := '';
End;

function TConfiguraConsulta.fColunaAutoSelecao(strNomCam: String): Boolean;
  Var
    intPosicao: Integer;
Begin
  Result := FAutoSelecao.Find(strNomCam, intPosicao);
end;

Function TConfiguraConsulta.fConsultaContida(strCampo: String): Boolean;
  Var
    intIndex: Integer;
Begin
  If recConfigur.blnConsCoOriginal Then
    Result := recConfigur.blnConsCo
  Else
    Result := FContida.Find(strCampo, intIndex);
End;

Function TConfiguraConsulta.fRetCamposPesquisa: String;
   Var
     stlCampos: TStringList;
Begin
  stlCampos := TStringList.Create;

  With FColSelec Do
  Begin
    DisableControls;
    First;

    While Not Eof Do
    Begin
      stlCampos.Add(FieldByName('NOMCAM').AsString);
      Next;
    End;

  End;

  Result := stlCampos.CommaText;

  FreeAndNil(stlCampos);
End;

Function TConfiguraConsulta.fRetCamposCompletaComZeros: String;
   Var
     stlCampos: TStringList;
Begin
  stlCampos := TStringList.Create;

  With FColSelec Do
  Begin
    DisableControls;
    First;

    While Not Eof Do
    Begin
      If FieldByName('COMZER').AsString = 'S' Then
        stlCampos.Add(FieldByName('NOMCAM').AsString);
      Next;
    End;

  End;

  Result := stlCampos.CommaText;

  FreeAndNil(stlCampos);
End;

Function TConfiguraConsulta.fRetCamposExibir: String;
   Var
     stlCampos: TStringList;
Begin
  stlCampos := TStringList.Create;

  With FColunas Do
  Begin
    DisableControls;

    First;

    While Not Eof Do
    Begin
      If FieldByName('EXIBIR').AsString = 'S' then
        stlCampos.Add(FieldByName('NOMCAM').AsString);
      Next;
    End;

  End;

  Result := stlCampos.CommaText;

  FreeAndNil(stlCampos);
End;

Procedure TConfiguraConsulta.pCarregaExibir;
  Var
    stlCampos: TStringList;
    intIndice: Integer;
Begin
  If (Not FCfgCon.IsEmpty) And (Not fEmptyStr(FCfgCon.FieldByName('CFG_EXIBIR').AsString)) Then
  Begin
    stlCampos := TStringList.Create;
    stlCampos.CommaText := FCfgCon.FieldByName('CFG_EXIBIR').AsString;
    stlCampos.Sorted := True;

    FColunas.DisableControls;
    FColunas.First;

    While Not FColunas.Eof do
    Begin

      If Not stlCampos.Find(FColunas.FieldByName('NOMCAM').AsString, intIndice) Then
      Begin
        FColunas.Edit;
        FColunas.FieldByName('EXIBIR').AsString  := 'N';
        FColunas.FieldByName('PESQUI').AsInteger := 0;
        FColunas.FieldByName('CONTID').AsString  := 'N';
        FColunas.Post;
      End;

      FColunas.Next;
    End;

    FColunas.EnableControls;

    FreeAndNil(stlCampos);
  End;
End;

Procedure TConfiguraConsulta.pCarregaPesquisar;
  Var
    stlCopia: TStringList;
    stlCampos: TStringList;
    intPosicao,
    intIndice: Integer;
    strCampos: String;
    strComZer: String;
Begin
  FContida.Clear;

  If (Not FCfgCon.IsEmpty) And (Not fEmptyStr(FCfgCon.FieldByName('CFG_PESQUI').AsString)) Then
  Begin
    strCampos  := FCfgCon.FieldByName('CFG_PESQUI').AsString;
    strComZer  := FCfgCon.FieldByName('CFG_COMZER').AsString;

    FContida.CommaText := FCfgCon.FieldByName('CFG_CONTID').AsString;
  End Else
  Begin
    strCampos := FIndDef.CommaText;
    strComZer := '';
  End;

  stlCampos := TStringList.Create;
  stlCampos.CommaText := strCampos;

  stlCopia := TStringList.Create;
  stlCopia.CommaText  := strCampos;

  FColunas.DisableControls;

  For intIndice := 0 To stlCampos.Count - 1 Do
  Begin

    If Not FColunas.Locate('NOMCAM', stlCampos[intIndice], []) Then
    Begin
      stlCopia.Sorted := True;

      If stlCopia.Find(stlCampos[intIndice], intPosicao) Then
      Begin
        stlCopia.Delete(intPosicao);
      End;

    End Else
    Begin

      FColunas.Edit;
      FColunas.FieldByName('PESQUI').AsInteger := 1;

      If FContida.Find(stlCampos[intIndice], intPosicao) Then
        FColunas.FieldByName('CONTID').AsString := 'S'
      Else
        FColunas.FieldByName('CONTID').AsString := 'N';

      FColunas.Post;
    End;

  End;

  If stlCopia.Count = 0 Then
  Begin
    intPosicao := 1;

    FColunas.First;
    While Not FColunas.Eof Do
    Begin
      stlCopia.Add(FColunas.FieldByName('NOMCAM').AsString);

      FColunas.Edit;
      FColunas.FieldByName('PESQUI').AsInteger := 1;
      FColunas.Post;

      FColunas.Next;

      Inc(intPosicao);
      If intPosicao = 4 Then
        Break;
    End;

  End;

  FColSelec.EmptyDataSet;
  For intIndice := 0 To stlCopia.Count - 1 Do
  Begin

    If FColunas.Locate('NOMCAM', stlCopia[intIndice], []) Then
    Begin
      FColSelec.Append;
      FColSelec.FieldByName('NOMCAM').AsString  := FColunas.FieldByName('NOMCAM').AsString;
      FColSelec.FieldByName('DESCAM').AsString  := FColunas.FieldByName('DESCAM').AsString;
      FColSelec.FieldByName('ORDCAM').AsInteger := Succ(intIndice);

      If Pos(FColunas.FieldByName('NOMCAM').AsString, strComZer) > 0 Then
        FColSelec.FieldByName('COMZER').AsString  := 'S'
      Else
        FColSelec.FieldByName('COMZER').AsString  := 'N';

      FColSelec.Post;
    End;

  End;

  FColunas.EnableControls;

  FreeAndNil(stlCampos);
  FreeAndNil(stlCopia);
End;

Function TConfiguraConsulta.fReplicaConfiguracao: String;
  Var
    qryCfgCon: TUniQuery;
    IntIndice: Integer;
Begin
  qryCfgCon := fCriaQuery(Self);

  With qryCfgCon Do
  Begin
    Result := fRetAutoIncrem('CFGCON', VS_strCodEmp);

    SQL.Add('SELECT * FROM CFGCON WHERE FALSE');

    Open;

    Insert;

    For IntIndice := 0 To FCfgCon.Fields.Count - 1 do
      Fields[IntIndice].Value := FCfgCon.Fields[IntIndice].Value;

    FieldByName('AUTOINCREM').AsString := Result;

    Post;

  End;

  FreeAndNil(qryCfgCon);
End;

Procedure TConfiguraConsulta.pIncluiConfEmpresa(strCodEmp, strSeqGer: String);
  Var
    qryCfgEmp: TUniQuery;
Begin
  qryCfgEmp := fCriaQuery(Self);

  With qryCfgEmp, SQL Do
  Begin
    Clear;

    Add('REPLACE INTO CFGEMP (CFG_SEQGER, CFG_CODEMP, CFG_CHAVE_) VALUES (:SEQGER, :CODEMP, :CHAVE_)');

    ParamByName('CODEMP').AsString := strCodEmp;
    ParamByName('SEQGER').AsString := strSeqGer;
    ParamByName('CHAVE_').AsString := FChave;
    ExecSQL;
  End;

  FreeAndNil(qryCfgEmp);
End;

Procedure TConfiguraConsulta.pRecriaConfEmpresas;
   Var
     strAutInc: String;
Begin

  With FCfgEmp Do
  Begin
    strAutInc := '';

    First;
    While Not Eof Do
    Begin

      If Not FEmpresas.Locate('CODEMP;SELECI', VarArrayOf([FieldByName('CFG_CODEMP').AsString, 'S']), []) then
      Begin

        If fEmptyStr(strAutInc) Then
        Begin

          strAutInc := fReplicaConfiguracao;
        End;

        pIncluiConfEmpresa(FieldByName('CFG_CODEMP').AsString, strAutInc);
      End;

      Next;
    End;

  End;

End;

Procedure TConfiguraConsulta.pSalvaCFGEMP(strAutInc: String);
  Var
    qryCfgEmp: TUniQuery;
Begin
  qryCfgEmp := fCriaQuery(Self);
  With qryCfgEmp, SQL Do
  Begin


    Clear;
    Add('DELETE FROM CFGEMP WHERE CFG_SEQGER = :SEQGER');
    ParamByName('SEQGER').AsString := strAutInc;
    ExecSQL;

    Close;
    Clear;
    Add('REPLACE INTO CFGEMP (CFG_SEQGER, CFG_CODEMP, CFG_CHAVE_) VALUES (:SEQGER, :CODEMP, :CHAVE_)');

    FEmpresas.First;
    While Not FEmpresas.Eof Do
    Begin

      If FEmpresas.FieldByName('SELECI').AsString = 'S' Then
      Begin
        Close;
        ParamByName('CODEMP').AsString := FEmpresas.FieldByName('CODEMP').AsString;
        ParamByName('SEQGER').AsString := strAutInc;
        ParamByName('CHAVE_').AsString := FChave;
        ExecSQL;
      End;

      FEmpresas.Next;
    End;

  End;
  FreeAndNil(qryCfgEmp);
End;

Function TConfiguraConsulta.fRetCamposFullText: String;
  Var
    stlCampos: TStringList;
Begin
  Result := '';
  If Not Assigned(FFullText) Then
    Exit;

  stlCampos := TStringList.Create;

  With FFullText Do
  Begin
    First;
    While Not Eof Do
    Begin

      If FieldByName('SELECI').AsString = 'S' Then
      Begin
        stlCampos.Add(FieldByName('NOMCAM').AsString);
      End;

      Next;
    End;
  End;

  Result := stlCampos.Text;

  FreeAndNil(stlCampos);
End;

Function TConfiguraConsulta.fSalvaConfiguracao: Boolean;
Begin
  Try

    With FCfgCon, FConfigur Do
    Begin
      frmModulo.Database.StartTransaction;

      If IsEmpty Then
      Begin
        Insert;
        FieldByName('CFG_CHAVE_').AsString := FChave;
        FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CFGCON', VS_strCodEmp);
      End Else
      Begin
        pRecriaConfEmpresas;

        Edit;
      End;

      If blnComKey Then
        FieldByName('CFG_COMKEY').AsString := 'S'
      Else
        FieldByName('CFG_COMKEY').AsString := 'N';

      if Assigned(FindField('CFG_FETCH_')) then
      begin
        If blnFetch_ Then
          FieldByName('CFG_FETCH_').AsString := 'S'
        Else
          FieldByName('CFG_FETCH_').AsString := 'N';
      end;

      If blnZebrad Then
        FieldByName('CFG_ZEBRAD').AsString := 'S'
      Else
        FieldByName('CFG_ZEBRAD').AsString := 'N';

      FieldByName('CFG_CORZEB').AsInteger := intCorZeb;
      FieldByName('CFG_TAMFON').AsInteger := intTanFon;

      If blnConsCo Then
        FieldByName('CFG_CONSCO').AsString := 'S'
      Else
        FieldByName('CFG_CONSCO').AsString := 'N';

      FieldByName('CFG_CONTID').AsString := fRetCamposContida;
      FieldByName('CFG_PESQUI').AsString := fRetCamposPesquisa;
      FieldByName('CFG_EXIBIR').AsString := fRetCamposExibir;
      FieldByName('CFG_COMZER').AsString := fRetCamposCompletaComZeros;

      FieldByName('CFG_FULLTE').AsString := fRetCamposFullText;

      Case aliAliPes Of
        alTop: FieldByName('CFG_ALIPES').AsInteger := 0;
        Else   FieldByName('CFG_ALIPES').AsInteger := 1;
      End;

      Post;

      pSalvaCFGEMP(FieldByName('AUTOINCREM').AsString);

      frmModulo.Database.Commit;
    End;

    Result := True;

  Except
    On E: Exception Do
    Begin
      frmModulo.Database.Rollback;

      Result := False;
      ShowMessage(E.Message);
    End;
  End;

End;

Function TConfiguraConsulta.fSalvaPesquisa(pnlPesquisaHeight: Integer; view: TcxGridDBTableView; qryConsulta: TDataSet): Boolean;
  Var
    sltLista: TStringList;
    strArqTemp: String;
    blnIncluindo: Boolean;
Begin
  Try
    sltLista := TStringList.Create;
    sltLista.Add(IntToStr(pnlPesquisaHeight));
    sltLista.Add(IntToStr(FPesquisa.Width));
    sltLista.Add(IntToStr(FPesquisa.OptionsView.RowHeaderWidth));
    sltLista.Add(IntToStr(FPesquisa.OptionsView.ValueWidth));

    strArqTemp := fGetFuncoesCxGrid.fCriarArquivoTemporario('',fGetPathTempOpcoesLocais);
    view.StoreToIniFile(strArqTemp, True, [gsoUseFilter, gsoUseSummary]);

    With FCfgCon, FConfigur Do
    Begin

      If IsEmpty Then
      Begin
        Insert;
        FieldByName('CFG_CHAVE_').AsString := FChave;
        FieldByName('CFG_COMKEY').AsString := 'N';
        FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CFGCON', VS_strCodEmp);
        FieldByName('CFG_FULLTE').AsString := fRetCamposFullText;

        If blnComKey Then
          FieldByName('CFG_COMKEY').AsString := 'S'
        Else
          FieldByName('CFG_COMKEY').AsString := 'N';

        if Assigned(FindField('CFG_FETCH_')) then
        begin
          If blnFetch_ Then
            FieldByName('CFG_FETCH_').AsString := 'S'
          Else
            FieldByName('CFG_FETCH_').AsString := 'N';
        end;

        If blnZebrad Then
          FieldByName('CFG_ZEBRAD').AsString := 'S'
        Else
          FieldByName('CFG_ZEBRAD').AsString := 'N';

        FieldByName('CFG_CORZEB').AsInteger := intCorZeb;

        If blnConsCo Then
          FieldByName('CFG_CONSCO').AsString := 'S'
        Else
          FieldByName('CFG_CONSCO').AsString := 'N';

        FieldByName('CFG_TAMFON').AsInteger := intTanFon;
      End Else
      Begin
        Edit;
      End;

      FieldByName('CFG_DIMPES').AsString := sltLista.Text;

      FieldByName('CFG_VALOR_').AsString := fGetFuncoesCxGrid.fArquivoParaString(strArqTemp);

     If Not qryConsulta.IsEmpty Then
       FieldByName('CFG_RECNO_').Value := qryConsulta.RecNo
     Else
       FieldByName('CFG_RECNO_').Value := null;

      blnIncluindo := State = dsInsert;

      Post;

      If blnIncluindo Then
        pSalvaCFGEMP(FieldByName('AUTOINCREM').AsString);
    End;

    FreeAndNil(sltLista);
    DeleteFile(PChar(strArqTemp));

    Result := True;

  Except
    On E: Exception Do
    Begin
      Result := False;
      ShowMessage(E.Message);
    End;
  End;

End;

Function TConfiguraConsulta.fEditaConfiguracoes: Boolean;
Begin
  fLeConfiguracao(False, True, True);

  pCriarFormularios(TfrmConfiguraConsultaEdicao, frmConfiguraConsultaEdicao);

  With FConfigur, frmConfiguraConsultaEdicao Do
  Begin
    If blnComKey Then
      rdgTipPes.ItemIndex := 1
    Else
      rdgTipPes.ItemIndex := 0;

    chkFetch.Checked   := blnFetch_;

    chkZebra.Checked   := blnZebrad;

    If chkZebra.Checked Then
      dccZebra.ColorValue := intCorZeb;

    chkConsCo.Visible := blnConsCoCfg;

    chkConsCo.Checked := chkConsCo.Visible And blnConsCo;

    cxgColunasCONTID.Visible := chkConsCo.Visible;

    spnTanFon.Value := intTanFon;

    Case aliAliPes Of
      alTop: rdgAliPes.ItemIndex := 0;
      Else   rdgAliPes.ItemIndex := 1;
    End;

    dtsColunas.DataSet  := FColunas;
    dtsColSel.DataSet   := FColSelec;
    dtsCadEmp.DataSet   := FEmpresas;
    dtsFulltext.DataSet := FFullText;

    objConfig := Self;

    Result := ShowModal = mrOk;

    If Result then
    Begin
      blnComKey := (rdgTipPes.ItemIndex = 1);
      blnZebrad := chkZebra.Checked;
      intCorZeb := dccZebra.ColorValue;
      intTanFon := spnTanFon.Value;
      blnConsCo := chkConsCo.Checked;
      blnConsCoOriginal := blnConsCo;

      blnFetch_ := chkFetch.Checked;

      Case rdgAliPes.ItemIndex of
        0:   aliAliPes := alTop;
        Else aliAliPes := alBottom;
      End;

      Result    := fSalvaConfiguracao;

      If Result Then
      Begin
        pMontaPesquisa(True);
      End;
    End;
  End;

  pFreeAndNil(frmConfiguraConsultaEdicao);
End;

Procedure TConfiguraConsulta.pCriaFulltext;
Begin
  If Assigned(FFullText) then
    FreeAndNil(FFullText);

  FFullText := TUniClientDataSet.Create(Self);

  With FFullText, FieldDefs Do
  Begin

    With AddFieldDef Do
    Begin
      Name     := 'SELECI';
      DataType := ftString;
      Size     := 1;
    End;

    With AddFieldDef Do
    Begin
      Name     := 'NOMTAB';
      DataType := ftString;
      Size     := 50;
    End;

    With AddFieldDef Do
    Begin
      Name     := 'NOMIND';
      DataType := ftString;
      Size     := 50;
    End;

    With AddFieldDef Do
    Begin
      Name     := 'NOMCAM';
      DataType := ftMemo;
    End;

    With AddFieldDef Do
    Begin
      Name     := 'DESCAM';
      DataType := ftMemo;
    End;

    AggregatesActive := True;

  End;

  FFullText.CreateDataSet;
  FFullText.Open;
End;

procedure TConfiguraConsulta.pDefineConsultaContida(blnUtiliza: Boolean; strNomCam: String);
begin
  If FConfigur.blnConsCoOriginal Then
    FConfigur.blnConsCo := blnUtiliza
  Else
    pIncluiContida(blnUtiliza, strNomCam);
end;

Procedure TConfiguraConsulta.pCriaColunas;
Begin
  If Assigned(FColunas) then
    FreeAndNil(FColunas);

  FColunas := TUniClientDataSet.Create(Self);

  With FColunas, FieldDefs Do
  Begin

    With AddFieldDef Do
    Begin
      Name     := 'EXIBIR';
      DataType := ftString;
      Size     := 1;
    End;

    With AddFieldDef Do
    Begin
      Name     := 'CONTID';
      DataType := ftString;
      Size     := 1;
    End;

    With AddFieldDef Do
    Begin
      Name     := 'PESQUI';
      DataType := ftInteger;
    End;

    With AddFieldDef Do
    Begin
      Name     := 'NOMCAM';
      DataType := ftString;
      Size     := 50;
    End;

    With AddFieldDef Do
    Begin
      Name     := 'DESCAM';
      DataType := ftString;
      Size     := 100;
    End;

    AggregatesActive := True;

    With TAggregateField.Create(Self) Do
    Begin
      FieldName := 'TOTSEL';
      DataSet := FColunas;
      Expression := 'SUM(PESQUI)';
      Active := True;
    End;

  End;

  FColunas.CreateDataSet;
  FColunas.Open;
End;

Function TConfiguraConsulta.fTotalSelecao: Double;
Begin
  With FColunas Do
  If TAggregateField(FieldByName('TOTSEL')).Value = Null Then
    Result := 0
  Else
    Result := TAggregateField(FieldByName('TOTSEL')).Value;
End;

Procedure TConfiguraConsulta.pCriaColunasSel;
Begin
  If Assigned(FColSelec) then
    FreeAndNil(FColSelec);

  FColSelec := TUniClientDataSet.Create(Self);

  With FColSelec, FieldDefs Do
  Begin

    With AddFieldDef Do
    Begin
      Name     := 'ORDCAM';
      DataType := ftInteger;
    End;

    With AddFieldDef Do
    Begin
      Name     := 'NOMCAM';
      DataType := ftString;
      Size     := 50;
    End;

    With AddFieldDef Do
    Begin
      Name     := 'DESCAM';
      DataType := ftString;
      Size     := 100;
    End;

    With AddFieldDef Do
    Begin
      Name     := 'COMZER';
      DataType := ftString;
      Size     := 1;
    End;

    CreateDataSet;
    Open;
    IndexFieldNames := 'ORDCAM';
  End;

End;

Procedure TConfiguraConsulta.pCarregaColunas;
  Var
    intContador: Integer;
Begin
  pCriaColunas;
  pCriaColunasSel;

  FColunas.EmptyDataSet;

  FConsulta.DisableControls;
  FConsulta.First;

  For intContador := 0 To FConsulta.Fields.Count - 1 Do
  If FConsulta.Fields[intContador].Visible then
  Begin

    FColunas.Append;
    FColunas.FieldByName('EXIBIR').AsString := 'S';
    FColunas.FieldByName('CONTID').AsString := 'N';
    FColunas.FieldByName('PESQUI').AsInteger := 0;
    FColunas.FieldByName('NOMCAM').AsString := FConsulta.Fields[intContador].FieldName;
    FColunas.FieldByName('DESCAM').AsString := FConsulta.Fields[intContador].DisplayLabel;
    FColunas.Post;

  End;

  FConsulta.EnableControls;
End;

Procedure TConfiguraConsulta.pAlteraOrdemColuna(blnSobe: Boolean);
  Var
    strCodAtu: String;
Begin
  If FColSelec.RecordCount < 2 then
    Exit;

  If (FColSelec.FieldByName('ORDCAM').AsInteger = 1) And blnSobe then
    Exit;

  If (FColSelec.FieldByName('ORDCAM').AsInteger = FColSelec.RecordCount) And (Not blnSobe) then
    Exit;

  FColSelec.DisableControls;

  strCodAtu := FColSelec.FieldByName('NOMCAM').AsString;

  If blnSobe Then
  Begin
    FColSelec.Prior;
    FColSelec.Edit;
    FColSelec.FieldByName('ORDCAM').AsInteger := Succ(FColSelec.FieldByName('ORDCAM').AsInteger);
    FColSelec.Post;

    If FColSelec.Locate('NOMCAM', strCodAtu, []) Then
    Begin
      FColSelec.Edit;
      FColSelec.FieldByName('ORDCAM').AsInteger := Pred(FColSelec.FieldByName('ORDCAM').AsInteger);
      FColSelec.Post;
    End;
  End Else
  Begin
    FColSelec.Next;
    FColSelec.Edit;
    FColSelec.FieldByName('ORDCAM').AsInteger := Pred(FColSelec.FieldByName('ORDCAM').AsInteger);
    FColSelec.Post;

    If FColSelec.Locate('NOMCAM', strCodAtu, []) Then
    Begin
      FColSelec.Edit;
      FColSelec.FieldByName('ORDCAM').AsInteger := Succ(FColSelec.FieldByName('ORDCAM').AsInteger);
      FColSelec.Post;
    End;
  End;

  FColSelec.EnableControls;
End;

procedure TConfiguraConsulta.pIncluiContida(blnInclui: Boolean; strNomCam: String);
  Var
    intPosicao: Integer;
Begin
  If blnInclui then
  Begin
    If Not FContida.Find(strNomCam, intPosicao) Then
      FContida.Add(strNomCam);
  End Else
  Begin
    If FContida.Find(strNomCam, intPosicao) Then
      FContida.Delete(intPosicao);
  End;

End;

procedure TConfiguraConsulta.pBeforePostColunas(DataSet: TDataSet);
  Var
    intPosicao: Integer;
Begin
  With DataSet Do
  Begin
    pIncluiContida(FieldByName('CONTID').AsString = 'S', FieldByName('NOMCAM').AsString);

    If FieldByName('PESQUI').AsInteger = 0 then
    Begin

      If FColSelec.Locate('NOMCAM', FieldByName('NOMCAM').AsString, []) Then
      Begin
        FColSelec.Delete;
        pReordenaColunasSel;
      End;

    End Else
    Begin

      If Not FColSelec.Locate('NOMCAM', FieldByName('NOMCAM').AsString, []) Then
      Begin
        intPosicao := FColSelec.RecordCount;

        FColSelec.Append;
        FColSelec.FieldByName('NOMCAM').AsString  := FieldByName('NOMCAM').AsString;
        FColSelec.FieldByName('DESCAM').AsString  := FieldByName('DESCAM').AsString;
        FColSelec.FieldByName('ORDCAM').AsInteger := Succ(intPosicao);
        FColSelec.FieldByName('COMZER').AsString  := 'N';
        FColSelec.Post;
      End;

    End;

  End;
End;

procedure TConfiguraConsulta.pReordenaColunasSel;
  Var
    intContador: Integer;
Begin
  FColSelec.DisableControls;

  FColSelec.First;

  intContador := 1;

  While Not FColSelec.Eof Do
  Begin
    FColSelec.Edit;
    FColSelec.FieldByName('ORDCAM').AsInteger := intContador;
    FColSelec.Post;

    FColSelec.Next;

    Inc(intContador);
  End;

  FColSelec.EnableControls;

End;

Function TConfiguraConsulta.fConverteFullText(strFiltro: String): String;
Begin
  Result := Trim(strFiltro);

  Result := AnsiReplaceStr(Result, '%', '*');

  If (Pos(' ', strFiltro) > 0) And (Pos('"', strFiltro) <= 0) Then
  Begin
    Result := '+' + Result;

    Result := AnsiReplaceStr(Result, ' ', ' +');

    Result := AnsiReplaceStr(Result, '.', '. +');

    Result := AnsiReplaceStr(Result, '\', '\ +');

    Result := AnsiReplaceStr(Result, '/', '/ +');

    Result := AnsiReplaceStr(Result, ' +-', ' -');

    Result := AnsiReplaceStr(Result, '+ +', '+');
    Result := AnsiReplaceStr(Result, '++', '+');
    Result := AnsiReplaceStr(Result, '- -', '-');
    Result := AnsiReplaceStr(Result, '--', '-');

    While (Length(Result) > 0) And CharInSet(Result[Length(Result)], ['+', '-']) Do
    Begin
      Result := LeftStr(Result, Length(Result) -1);
    End;

  End;

End;

Function TConfiguraConsulta.fNomeCampoFiltro(strNomCam: String): String;
  Var
    intContador: Integer;
Begin
  Result := strNomCam;

  If Assigned(FarrSubCon) Then
  For intContador := Low(FarrSubCon) To High(FarrSubCon) Do
  If SameText(strNomCam, FarrSubCon[intContador].strAlias_) And
     (Not fEmptyStr(FarrSubCon[intContador].strCamFil)) Then
  Begin
    Result := FarrSubCon[intContador].strCamFil;
    Exit;
  End;
End;


Function TConfiguraConsulta.fSQLFiltro: String;
  Var
    intIndice: Integer;
    strCampoFiltro,
    strSQL: String;
    strConvFull: String;
Begin
  Result := '';

  For intIndice := 1 To FPesquisa.Rows.Count - 1 Do
  Begin
    strCampoFiltro := fNomeCampoFiltro(TcxEditorRow(FPesquisa.Rows[intIndice]).Name);

    If (TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.Value <> Null) And
       (Not fEmptyStr(TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.Value)) Then
    Begin

      If FConfigur.blnComKey Then
        pCompletaComZerosPesquisa(TcxEditorRow(FPesquisa.Rows[intIndice]));

      If Not fEmptyStr(Result) Then
        Result := Result + ' AND ';

      If (TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.EditProperties Is TcxComboBoxProperties) Then
      Begin
        If TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.Value = 'SIM' Then
        Begin
          Result := Result + strCampoFiltro;
          Result := Result + ' = "SIM"';
        End
        Else If TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.Value = 'NÃO' Then
        Begin
          Result := Result + strCampoFiltro;
          Result := Result + ' = "NÃO"';
        End
        Else If TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.Value = 'TODOS' Then
        Begin
          Result := Result + ' TRUE ';
        End
        Else
        Begin
          Result := Result + strCampoFiltro;
          Result := Result + ' = "' + TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.Value + '"';
        End;
      End
      Else

      If (TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.EditProperties Is TcxCurrencyEditProperties) Then
      Begin
        Result := Result + strCampoFiltro;
        // TESTAR VALORES > 1000
        Result := Result + ' = ' + AnsiReplaceStr(TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.Value, ',', '.');
      End

      Else If TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.EditProperties Is TcxTimeEditProperties Then
      Begin
        Result := Result + strCampoFiltro;
        // TESTAR
        Result := Result + ' = ' + QuotedStr(FormatDateTime('HH:NN', StrToDateDef(TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.Value, 0)))
      End

      Else If TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.EditProperties Is TcxCustomDateEditProperties Then
      Begin
        Result := Result + TcxEditorRow(FPesquisa.Rows[intIndice]).Name;
        Result := Result + ' = ' + QuotedStr(FormatDateTime('YYYY-MM-DD', StrToDateDef(TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.Value, 0)))
      End Else

      Begin
        strSQL := '';

        If FConfigur.blnComKey And fConsultaContida(TcxEditorRow(FPesquisa.Rows[intIndice]).Name) And
           (Pos('.', TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.Value) = 0) And
           (Pos('/', TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.Value) = 0) And
           (Pos(',', TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.Value) = 0) And
           (Length(TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.Value) >= 3) Then
        Begin
          strConvFull := fConverteFullText(TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.Value);
          strSQL      := fSQLFullText(strCampoFiltro, strConvFull);
        End;

        If fEmptyStr(strSQL) then
        Begin
          If fConsultaContida(TcxEditorRow(FPesquisa.Rows[intIndice]).Name) Then
          Begin
            pAjustaConsultaContida(TcxEditorRow(FPesquisa.Rows[intIndice]));
            Result := Result + fGetSQLTextoContido(strCampoFiltro, TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.Value)
          End  Else
          Begin
            Result := Result + strCampoFiltro;
            Result := Result + ' LIKE ' + QuotedStr(TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.Value + '%');
          End;
        End
        Else
        Begin
          Result := Result + strSQL;
        End;

      End;

    End;

  End;

End;

function TConfiguraConsulta.fGetSQLTextoContido(strCampo, strTexto: String): String;
  Var
    stlTexto: TStringList;
begin
  Result := '';

  Repeat
    strTexto := AnsiReplaceStr(strTexto, '  ', ' ');
  Until (Pos('  ', strTexto) <= 0);

  If fEmptyStr(strTexto) Then
    Exit;

  stlTexto := TStringList.Create;
  ExtractStrings([' '], [], PChar(strTexto), stlTexto);

  For strTexto In stlTexto Do
  Begin
    If Not fEmptyStr(Result) Then
      Result := Result + ' AND ';
    Result := Result + strCampo  + ' LIKE ' + QuotedStr('%' + strTexto + '%');
  End;

  FreeAndNil(stlTexto);
end;

Function TConfiguraConsulta.fPesquisaNaDigitacao: Boolean;
Begin
  Result := (Not (TcxEditorRow(FPesquisa.FocusedRow).Properties.EditProperties Is TcxCustomDateEditProperties)) And
            (Not (TcxEditorRow(FPesquisa.FocusedRow).Properties.EditProperties Is TcxTimeEditProperties)) And
            (Not (TcxEditorRow(FPesquisa.FocusedRow).Properties.EditProperties Is TcxCurrencyEditProperties));
End;

procedure TConfiguraConsulta.pCompletaComZerosPesquisa(cxEditorRow: TcxEditorRow);
begin
  If (cxEditorRow.Properties.EditProperties Is TcxTextEditProperties) Then
  Begin
    If (Pos(cxEditorRow.Name, fRetCamposCompletaComZeros) > 0) And
       (FConsulta.Active And (FConsulta.FindField(cxEditorRow.Name) <> Nil)) Then
    Begin
      If (Not fEmptyStr(VarToStr(cxEditorRow.Properties.Value))) And
         (Pos('%', VarToStr(cxEditorRow.Properties.Value)) = 0) Then
        cxEditorRow.Properties.Value := fStrZero(VarToStr(cxEditorRow.Properties.Value),
          FConsulta.FindField(cxEditorRow.Name).Size);
    End;
  End;
end;

procedure TConfiguraConsulta.pAjustaConsultaContida(cxEditorRow: TcxEditorRow);
begin
  If (cxEditorRow.Properties.EditProperties Is TcxTextEditProperties) And
     FConfigur.blnComKey And (Pos('%', cxEditorRow.Properties.Value) > 0) Then
    cxEditorRow.Properties.Value := ReplaceStr(VarToStr(cxEditorRow.Properties.Value), '%', '');
end;

Procedure TConfiguraConsulta.pMudaCorZebra(blnBestFit: Boolean);
  Var
    blnTrocouFonte: Boolean;
Begin

  If FConfigur.blnZebrad then
    FStyleEve.Color := FConfigur.intCorZeb;

  blnTrocouFonte := FcxConsulta.Font.Size <> FConfigur.intTanFon;

  FcxConsulta.Font.Size := FConfigur.intTanFon;

  If blnBestFit And blnTrocouFonte And (Not FConsultaView.DataController.DataSource.DataSet.IsEmpty) Then
    FConsultaView.ApplyBestFit;

  FPesquisa.Font.Size   := FConfigur.intTanFon;

  pSetaColunasGrid;
End;

Procedure TConfiguraConsulta.pMarcaExibirTodos(blnMarcar: Boolean);
Begin
  With FColunas Do
  Begin
    DisableControls;
    First;

    While Not Eof do
    Begin
      Edit;

      If blnMarcar Then
        FieldByName('EXIBIR').AsString :=  'S'
      Else
        FieldByName('EXIBIR').AsString :=  'N';

      Post;

      Next;
    End;

    First;
    EnableControls;
  End;

End;

Function TConfiguraConsulta.fValidaConsulta: Boolean;
Begin
  With FColunas Do
  Begin
    DisableControls;
    Result := Locate('EXIBIR', 'S', []);

    If Not Result Then
      fMensagem('', 'Informe pelo menos uma coluna para exibição!', ['&Ok']);

    EnableControls;
  End;

  If Not Result Then
   Exit;

  Result := Not FColSelec.IsEmpty;

  If Not Result Then
    fMensagem('', 'Informe pelo menos uma coluna para pesquisa!', ['&Ok']);

End;

Procedure TConfiguraConsulta.pFocoNaPesquisa;
Begin
  If Assigned(FPesquisa) And (FPesquisa.Rows.Count > 1) Then
  Begin
    pSetFocus(FPesquisa);
    FPesquisa.FocusedRow := FPesquisa.Rows[1];
    FPesquisa.ShowEdit;
  End;
End;

Procedure TConfiguraConsulta.pVerificaLimitePesquisa;
Begin
  With FColunas Do
  Begin
    DisableControls;

    If fTotalSelecao > 15 Then
    Begin
      Edit;
      FieldByName('PESQUI').AsInteger := 0;
      Post;

      fMensagem('', 'É permitido selecionar até 15 colunas para a pesquisa!', ['&Ok']);
    End;

    EnableControls;
  End;

End;

Function TConfiguraConsulta.fDescricaoToNomeCampo(strDescricao: String): String;
Begin
 If FColunas.Locate('DESCAM', strDescricao, []) Then
   Result := FColunas.FieldByName('NOMCAM').AsString
 Else
   Result := '';
End;

Procedure TConfiguraConsulta.pPosicionaOrdenacao;
  Var
    intIndice: Integer;
Begin
  With FConsultaView Do
  If (SortedItemCount > 0) Then
  Begin

    For intIndice := 1 To FPesquisa.Rows.Count - 1 Do
    Begin
      If SameText(SortedItems[0].Caption, TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.Caption) then
      Begin
        FCurrRow := intIndice;
        Break;
      End;
    End;

  End;

End;

Procedure TConfiguraConsulta.pProximaOrdenacao;
Begin
  If FPesquisa.Rows.Count < 2 Then
    Exit;

  Try

    Repeat

      If FCurrRow = FPesquisa.Rows.Count - 1 Then
        FCurrRow := 1
      Else
        Inc(FCurrRow);

    Until FPesquisa.Rows[FCurrRow].Visible And
          FConsultaView.Columns[FCurrRow].Visible;

    pMudaOrdenacao(FPesquisa.Rows[FCurrRow].Name);

    FPesquisa.FocusRow(FPesquisa.Rows[FCurrRow]);


  Except

  End;
End;

Procedure TConfiguraConsulta.pSetaColunasGrid;
  Var
    dbcColuna: TcxGridDBColumn;
Begin
  With FColunas Do
  Begin
    DisableControls;
    First;

    While Not Eof Do
    Begin
      dbcColuna := FConsultaView.GetColumnByFieldName(FieldByName('NOMCAM').AsString);

      If Assigned(dbcColuna) Then
        dbcColuna.Visible := FieldByName('EXIBIR').AsString = 'S';

      Next;
    End;

    EnableControls;
  End;
End;

function TConfiguraConsulta.fCarregarView: Boolean;
  Var
    strArqTemp: String;
begin
  try

    Result := False;
    if InterlockedIncrement(intGravandoArquivo) = 1 then
    begin
      strArqTemp := fGetFuncoesCxGrid.fCriarArquivoTemporario('',fGetPathTempOpcoesLocais);

      fGetFuncoesCxGrid.fEscreverNoArquivo(strArqTemp, FConfigur.strValor);
      FConsultaView.RestoreFromIniFile(strArqTemp);
      DeleteFile(PChar(strArqTemp));
      InterlockedDecrement(intGravandoArquivo);
      Result := Not fEmptyStr(FConfigur.strValor);
    end;

  Except
    On E: Exception Do
    begin
      Result := False;
      InterlockedDecrement(intGravandoArquivo);
    end;
  End;

end;

Procedure TConfiguraConsulta.pCarregaCFGEMP(strAutInc: String);
Begin
  With FCfgEmp, SQL Do
  Begin
    Close;
    Clear;
    Add('SELECT * FROM CFGEMP');
    Add('WHERE CFG_SEQGER = :SEQGER');

    ParamByName('SEQGER').AsString := strAutInc;
    Open;
  End;
End;

Procedure TConfiguraConsulta.pCriaEmpresas;
  Var
    qryCadEmp: TUniQuery;
Begin
  If Assigned(FEmpresas) then
    FreeAndNil(FEmpresas);

  FEmpresas := TUniClientDataSet.Create(Self);

  With FEmpresas, FieldDefs Do
  Begin

    With AddFieldDef Do
    Begin
      Name     := 'CODEMP';
      DataType := ftString;
      Size     := 3;
    End;

    With AddFieldDef Do
    Begin
      Name     := 'NOMEMP';
      DataType := ftString;
      Size     := 60;
    End;

    With AddFieldDef Do
    Begin
      Name     := 'SELECI';
      DataType := ftString;
      Size     := 1;
    End;

  End;

  FEmpresas.CreateDataSet;
  FEmpresas.Open;

  qryCadEmp := fCriaQuery(Nil);
  With qryCadEmp, SQL Do
  Begin
    Clear;
    Add('SELECT');
    Add('  EMP_CODEMP,');
    Add('  EMP_NOMEMP ');
    Add('FROM');
    Add('  CADEMP');
    Add('ORDER BY');
    Add('  EMP_CODEMP');

    Open;

    While Not Eof Do
    Begin

      FEmpresas.Append;

      If FCfgEmp.IsEmpty Or FCfgEmp.Locate('CFG_CODEMP', FieldByName('EMP_CODEMP').AsString, []) Or
         (FieldByName('EMP_CODEMP').AsString = VS_strCodEmp) Then
        FEmpresas.FieldByName('SELECI').AsString := 'S'
      Else
        FEmpresas.FieldByName('SELECI').AsString := 'N';

      FEmpresas.FieldByName('CODEMP').AsString := FieldByName('EMP_CODEMP').AsString;
      FEmpresas.FieldByName('NOMEMP').AsString := FieldByName('EMP_NOMEMP').AsString;
      FEmpresas.Post;

      Next;
    End;

  End;

  FreeAndNil(qryCadEmp);

  FEmpresas.BeforePost := pBeforePostEmpresas;
End;

Procedure TConfiguraConsulta.pBeforePostEmpresas(dataSet: TDataSet);
Begin
  With dataSet Do
  Begin

    If (FieldByName('CODEMP').AsString = VS_strCodEmp) And
       (FieldByName('SELECI').AsString = 'N') Then
    Begin
      fMensagem('', 'A empresa logada não pode ser desmarcada!', ['&Ok']);
      FieldByName('SELECI').AsString := 'S';
      Abort;
    End;

  End;
End;

Procedure TConfiguraConsulta.pCarregaFullText(strFullText : String);
Begin
  FstlFullT.Clear;
  FstlFullT.Text := strFullText;
  FstlFullT.Sorted := True;
End;

Procedure TConfiguraConsulta.pMarcaFullText;
  Var
    intIndice: Integer;
Begin
  If Not Assigned(FFullText) Then
    Exit;

  With FFullText Do
  Begin
    First;
    While Not Eof do
    Begin
      If FstlFullT.Find(FieldByName('NOMCAM').AsString, intIndice) Then
      Begin
        Edit;
        FieldByName('SELECI').AsString := 'S';
        Post;
      End;

      Next;
    End;
  End;

End;

Function TConfiguraConsulta.fSQLFullText(strNomCam, strFiltro: String): String;
  Var
    intIndice: Integer;
Begin
  Result := '';

  For intIndice := 0 To FstlFullT.Count - 1 Do
    If Pos(strNomCam, FstlFullT[intIndice]) > 0 Then
    Begin
      Result := ' MATCH (' + FstlFullT[intIndice] + ') AGAINST ( ' + QuotedStr(strFiltro) + ' IN BOOLEAN MODE) ';
    End;

End;

Procedure TConfiguraConsulta.pMontaFulltext(blnMarcar: Boolean);
  Var
    qryFullText: TUniQuery;
    sqlParser  : TSQLParser;
    strTabela  : String;
    sltTabelas : TStringList;
    sltCampos  : TStringList;
    sltDesCam  : TStringList;
    intContador: Integer;
    dbcColuna  : TcxGridDBColumn;

    Procedure pCarregaTabelas;
    Begin
      sqlParser := TSQLParser.Create(FstrSQL);
      sqlParser.ToBegin;

      sltCampos         := TStringList.Create;
      sltDesCam         := TStringList.Create;

      sltTabelas        := TStringList.Create;
      sltTabelas.Sorted := True;

      While sqlParser.CurrPos <  Length(FstrSQL) Do
      Begin
        strTabela := sqlParser.Lexem;

        If SameText('FROM', strTabela) Or
           SameText('JOIN', strTabela) Then
        Begin
          sqlParser.GetNextToken;
          strTabela := sqlParser.Lexem;

          If (Not sltTabelas.Find(strTabela, intContador)) Then
            sltTabelas.Add(strTabela);
        End

        Else sqlParser.GetNextToken;

      End;

      FreeAndNil(sqlParser);
    End;

Begin
  pCriaFulltext;

  qryFullText := fCriaQuery(Self);

  pCarregaTabelas;

  For intContador := 0 To sltTabelas.Count - 1 Do
  With qryFullText, SQL Do
  Begin
    Clear;
    Close;

    Try
      Add('SHOW INDEXES FROM ' + sltTabelas[intContador]);
      Open;

      sltCampos.Clear;
      sltDesCam.Clear;

      While Not Eof do
      Begin

        If SameText(FieldByName('Index_Type').AsString, 'FULLTEXT') Then
        Begin

          If Not FFullText.Locate('NOMTAB;NOMIND', VarArrayOf([sltTabelas[intContador], FieldByName('key_name').AsString]), []) Then
          Begin
            FFullText.Insert;
            FFullText.FieldByName('NOMTAB').AsString := sltTabelas[intContador];
            FFullText.FieldByName('NOMIND').AsString := FieldByName('key_name').AsString;
            FFullText.FieldByName('NOMCAM').AsString := '';
            FFullText.FieldByName('DESCAM').AsString := '';

            If blnMarcar Then
              FFullText.FieldByName('SELECI').AsString := 'S'
            Else
              FFullText.FieldByName('SELECI').AsString := 'N';

          End Else
          Begin
            FFullText.Edit;
          End;

          sltCampos.CommaText := FFullText.FieldByName('NOMCAM').AsString;
          sltDesCam.CommaText := FFullText.FieldByName('DESCAM').AsString;

          sltCampos.Add(FieldByName('column_name').AsString);

          dbcColuna := FConsultaView.GetColumnByFieldName(FieldByName('column_name').AsString);

          If Assigned(dbcColuna) Then
          Begin
            sltDesCam.Add(dbcColuna.Caption);
          End Else
          Begin
            sltDesCam.Add(FieldByName('column_name').AsString);
          End;

          FFullText.FieldByName('NOMCAM').AsString := sltCampos.CommaText;
          FFullText.FieldByName('DESCAM').AsString := sltDesCam.CommaText;

          FFullText.Post;
        End;

        Next;
      End;

    Except

    End;

  End;

  pCarregaFullText(fRetCamposFullText);
  pMarcaFullText;

  FreeAndNil(qryFullText);
  FreeAndNil(sqlParser);
  FreeAndNil(sltCampos);
  FreeAndNil(sltDesCam);
  FreeAndNil(sltTabelas);
End;

Procedure TConfiguraConsulta.pMarcaEmpresas(blnMarcar: Boolean);
Begin
  With FEmpresas Do
  Begin
    DisableControls;
    First;
    While Not Eof Do
    Begin
      If (FieldByName('CODEMP').AsString <> VS_strCodEmp) Then
      Begin
        Edit;
        If blnMarcar Then
          FieldByName('SELECI').AsString := 'S'
        Else
          FieldByName('SELECI').AsString := 'N';
        Post;
      End;

      Next;
    End;
    First;
    EnableControls;
  End;
End;

end.