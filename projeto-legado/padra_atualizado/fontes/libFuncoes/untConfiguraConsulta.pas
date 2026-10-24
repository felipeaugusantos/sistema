unit untConfiguraConsulta;

interface

Uses
  Uni,
  ExtCtrls,
  EditFocus,
  Dialogs,
  SysUtils,
  DB,
  UniClientDataSet,
  UniDataSetProvider,
  untConfiguraConsultaOperadores,
  Controls,
  Classes,
  StrUtils,
  cxVGrid,
  cxEdit,
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
  untClassPanelCx,
  untTypesSistema,
  StdCtrls;

Const
  SEP_QTDCAR = '#!#';

Type
  TRecConfiguracao = Record
    blnFetch_: Boolean;
    blnFilObr: Boolean;
    blnFilBra: Boolean;
    blnComKey: Boolean;
    blnZebrad: Boolean;
    blnExpand: Boolean;
    intCorZeb: Integer;
    intTanFon: Integer;
    blnConsCo: Boolean;
    blnConsCoOriginal: Boolean;

    intAltPan,
    intRowHea,
    intWidRow,
    intWidVal,
    intRecNo: Integer;

    strColunas,
    strValor: String;

    sltGruObr: TStringList;

    aliAliPes: TAlign;
  End;

  TConfiguraConsulta = Class(TComponent)
    Private
      FLeuConf: Boolean;
      FChave: String;
      FCfgCon: TUniQuery;
      FCfgEmp: TUniQuery;

      FTraCon,
      FTraTam,
      FComZer,
      FPeriod,
      FObriga,
      FGruObr,
      FQtdCar: TStringList;

      FAchouPorEmpresa: Boolean;

      FNomeCFGCON,
      FNomeCFGEMP: String;

      FCampoBuscaPalavraExataPorToken: string;
      FCampoBuscaComplementarPorToken: string;

      FNomeCampos: TStringList;

      FobjConsulta: TDefConsulta;

      FarrSubCon: TArrRecSubConsulta;

      FContida: TStringList;
      FAutoSelecao: TStringList;

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

      FValidacaoPeriodo: TPanel;

      FstrSQL: String;

      FCurrRow: Integer;

      FCalcAlt: Boolean;

      FEmpresas: TUniClientDataSet;
      FarrSimNao: TStringArrayArray;
      FpAtualizaPesquisa : TAtualizar;

      Function fLarColToText(view: TcxGridDBTableView): String;

      Function fCampoPeriodo(strNomCam: String): Boolean;

      Function fConverteFullText(strNomCam, strFiltro: String; var AHavingFilters: string): String;
      Function fSQLFullText(strNomCam, strFiltro: String): String;
      Function fReplicaConfiguracao: String;
      Function fGetMySqlVariableValue(strName: String): String;
      Function fLeConfiguracao(blnLoadV, blnMontaFullText, blnMontaPesquisa: Boolean): Boolean;
      Function fSalvaConfiguracao: Boolean;
      Function fRetCamposPesquisa: String;
      Function fRetCamposContida: String;
      Function fRetCamposAutoSelecao: String;
      Function fRetCamposExibir: String;
      Function fRetCamposCompletaComZeros: String;
      Function fRetCamposPeriodo: String;
      Function fRetCamposObrigatorio: String;
      Function fRetCamposGrupoObrigatorios: String;
      Function fRetCamposQuantidadeCaracteres: String;
      Function fRetDecimais(strDisplay: String): Integer;
      Function fTotalSelecao: Integer;
      Function fTotalSelecaoPeriodo: Integer;
      Function fCarregarView: Boolean;
      Function fRetCamposFullText: String;
      Function fCampoTemIndiceFullText(strNomCam: String; var strCamposIndiceFullText: string): Boolean;

      procedure pPesquisaRowValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
                                       var Error: Boolean);

      Procedure pMarcaFullText;
      Procedure pIncluiConfEmpresa(strCodEmp, strSeqGer: String);
      Procedure pSalvaCFGEMP(strAutInc: String);
      Procedure pCarregaCFGEMP(strAutInc, strNomeCFGEMP: String);
      Procedure pCriaColunas;
      Procedure pCriaColunasSel;
      Procedure pCriaEmpresas;
      Procedure pCarregaColunas;
      Procedure pCarregaExibir;
      Procedure pCarregaPesquisar;
      procedure pBeforePostColunas(DataSet: TDataSet);
      procedure pIncluiContida(blnInclui: Boolean; strNomCam: String);
      procedure pIncluiAutoSelecao(blnInclui: Boolean; strNomCam: String);
      procedure pReordenaColunasSel;
      Procedure pSetaColunasGrid;
      Procedure pRecriaConfEmpresas;
      Procedure pMontaFulltext(blnMarcar: Boolean);
      Procedure pBeforePostEmpresas(dataSet: TDataSet);
      Procedure pCarregaFullText(strFullText: String);

      procedure cxValidate(Sender: TObject; var DisplayValue: Variant;
                              var ErrorText: TCaption; var Error: Boolean);

      procedure pChangeComboBox(Sender: TObject);

      function fGetSQLTextoContido(strCampo, strTexto: String; blnUsarMatch: Boolean; var AHavingFilters: string): String;

      Function fCompletaComZerosPesquisa(cxEditorRow: TcxEditorRow): Boolean;
      procedure pAjustaConsultaContida(cxEditorRow: TcxEditorRow);

      Procedure pSalvaConsultaConfigurada;

      Function fRetTituloCampo(strNomCam: String; intIndex: Integer): String;

      Function fTemTamanhoPesquisa(strCampo, strInfos: String; Var IntQtdCar: Integer): Boolean;
      function fEhCampoGrupoObrigatorio(strNomCam: String): Boolean;
      function fDescricaoCamposGrupoObrigatorio: String;

      Procedure pCarregaTravaConsulta(Var strComZer: String);
      Procedure pCarregaTamanhoMimimo(Var strQtdCar: String);
    Public

      strErroValidacao,
      strCamposExibir: String;

      blnTemAoMenosUmFiltroPreenchido: Boolean;

      blnTemCampoObrigatorio,
      blnValidateComErro,
      blnRestaurouColunas,
      blnConsCoCfg: Boolean;

      objConfigOperadores: TConfiguraConsultaOperadores;

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
                         pAtualizaPesquisaP : TAtualizar;
                         arrSubCon: TArrRecSubConsulta;
                         objConsulta: TDefConsulta;
                         stlCampos: TStringList;
                         pnlValidacaoPeriodo: TPanel); Reintroduce;

      Destructor Destroy; override;

      Function fEhFiltroTravado: Boolean; Overload;
      Function fEhFiltroTravado(strNomCam: String): Boolean Overload;

      Function fTemTamanhoMinimo(strNomCam: String): Boolean;

      Procedure pAfterScrollColSelec(dataSet: TDataSet);

      function fValidaFiltros: Boolean;

      function fNomeRowToFieldName(strNomRow: String): String;
      function fNomeCampoFiltro(strNomCam: String): String;
      function fAliasCampoFiltro(strNomCam: String): String; overload;
      function fAliasCampoFiltro(arrCampos: TArray<string>): TArray<string>; overload;

      Function fGetMinCarDig(strCampo: String): Integer;

      Function fCampoObrigatorio(strNomCam: String): Boolean;

      Function fConsultaContida(strCampo: String): Boolean;
      Function fLocateForcaContida(AField: String): Boolean;

      Function fPesquisaNaDigitacao: Boolean;
      Procedure pMontaPesquisa(blnLimpar: Boolean = False);

      Procedure pAjustaTamanhoDefaultGridPesquisa;

      Procedure pRestauraColunas(view: TcxGridDBTableView);

      Function fDescricaoToNomeCampo(strDescricao: String): String;
      Function fEditaConfiguracoes(blnPermiteAtualiza: Boolean = False): Boolean;
      Function fValidaConsulta: Boolean;
      Function fSalvaPesquisa(pnlPesquisaHeight: Integer; view: TcxGridDBTableView; qryConsulta: TDataSet;
                              blnSalvaColunas: Boolean = False; blnSalvaColunasAutomaticamente: Boolean = True): Boolean;

      Procedure pMarcaEmpresas(blnMarcar: Boolean);
      Procedure pMudaOrdenacao(strNomCol: String);
      Procedure pAlteraOrdemColuna(blnSobe: Boolean);
      Procedure pMudaCorZebra(blnBestFit: Boolean);
      Procedure pMarcaExibirTodos(blnMarcar: Boolean);
      procedure pDefineConsultaContida(blnUtiliza: Boolean; strNomCam: String);
      Procedure pFocoNaPesquisa;
      Procedure pVerificaLimitePesquisa;
      Procedure pVerificaLimitePesquisaSel;
      Procedure pProximaOrdenacao;
      Procedure pPosicionaOrdenacao;
      Procedure pCriaFulltext;

      Function fSQLFiltroPeriodo(intIndice: Integer; strCampoFiltro: String; blnDataSet: Boolean): String;

      function fTratarPesquisaCpfCpnjComLike(const ASQL: String): String;

      Function fSQLFiltro(var AHavingFilters: string): String;
      function ObterClausulaWhere(const str:String): String;
      Function fGetValorFiltro(intIndice: Integer; strNomCam: String; blnDataSet: Boolean): String;

      Function fFiltroDataSet: String;
      Function fColunaAutoSelecao(strNomCam: String): Boolean;

      Function fIgnoraChar(strCodCam, strValor: String): String;

      Function fCampoToSubConsulta(strSQL: String;  blnComAlias: Boolean): String;

      Function fPossuiFiltro: Boolean;

      Function fNomeRowToNomeCampo(strNomCam: String): String;

    published

      property cdsEmpresas: TUniClientDataSet Read FEmpresas Write FEmpresas;
      property cdsColunas:  TUniClientDataSet Read FColunas  Write FColunas;
      property cdsColSelec: TUniClientDataSet Read FColSelec Write FColSelec;
      property cdsFullText: TUniClientDataSet Read FFullText Write FFullText;
      property blnLeuConf : Boolean           Read FLeuConf;

      property recConfigur: TRecConfiguracao Read FConfigur;
      property blnCalcAlt: Boolean Read FCalcAlt Write FCalcAlt;
      property blnLoadView: Boolean Read FLoadView;

      property stlComZer: TStringList Read FComZer;
      property stlPeriod: TStringList Read FPeriod;
      property stlObriga: TStringList Read FObriga;
      property stlGruObr: TStringList Read FGruObr;
      property stlQtdCar: TStringList Read FQtdCar;

      property strChaveConsulta: String Read FChave;
  End;

const
  MAX_COLS_PESQUISA = 15;

implementation

Uses
  cxGridDBDataDefinitions,
  System.TypInfo,
  untFuncoesCXGrid,
  untFuncoesGen,
  untConfiguraConsultaEdicao, 
  untFuncoesGenCompartilhada;

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
   pAtualizaPesquisaP : TAtualizar;
   arrSubCon: TArrRecSubConsulta;
   objConsulta: TDefConsulta;
   stlCampos: TStringList;
   pnlValidacaoPeriodo: TPanel);
Begin
  Inherited Create(Owner);

  FConfigur.sltGruObr := TStringList.Create;
  FConfigur.sltGruObr.Sorted := True;

  FValidacaoPeriodo := pnlValidacaoPeriodo;

  blnValidateComErro := False;

  FComZer := TStringList.Create;
  FComZer.Sorted := True;

  FTraCon := TStringList.Create;
  FTraCon.Sorted := True;

  FTraTam := TStringList.Create;
  FTraTam.Sorted := True;

  FPeriod := TStringList.Create;
  FPeriod.Sorted := True;

  FObriga := TStringList.Create;
  FObriga.Sorted := True;

  FGruObr := TStringList.Create;
  FGruObr.Sorted := True;

  FQtdCar := TStringList.Create;

  FAchouPorEmpresa := False;

  strCamposExibir := '';

  FNomeCampos  := stlCampos;

  FobjConsulta := objConsulta;

  if assigned(objConsulta) then
  begin
    FCampoBuscaPalavraExataPorToken := objConsulta.strCampoBuscaPalavraExataPorToken;
    FCampoBuscaComplementarPorToken := objConsulta.strCampoBuscaComplementarPorToken;
  end;

  objConfigOperadores := TConfiguraConsultaOperadores.Create;

  blnRestaurouColunas := False;

  FarrSubCon := arrSubCon;

  blnConsCoCfg := fCfgSis('CONSCO', VarBoolean);

  innodb_ft_min_token_size := fGetMySqlVariableValue('innodb_ft_min_token_size').ToInteger;

  FContida := TStringList.Create;
  FContida.Sorted := True;

  FAutoSelecao := TStringList.Create;
  FAutoSelecao.Sorted := True;

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
  FreeAndNil(objConfigOperadores);
  FreeAndNil(FIndDef);
  FreeAndNil(FstlFullT);
  FreeAndNil(FContida);
  FreeAndNil(FAutoSelecao);
  FreeAndNil(FComZer);
  FreeAndNil(FTraCon);
  FreeAndNil(FTraTam);
  FreeAndNil(FPeriod);
  FreeAndNil(FObriga);
  FreeAndNil(FGruObr);
  FreeAndNil(FQtdCar);

  FreeAndNil(FConfigur.sltGruObr);
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

Function TConfiguraConsulta.fCampoPeriodo(strNomCam: String): Boolean;
  Var
    intIndex: Integer;
Begin
  Result := FPeriod.Find(strNomCam, intIndex);
End;

Function TConfiguraConsulta.fCampoObrigatorio(strNomCam: String): Boolean;
  Var
    intIndex: Integer;
Begin
  Result := FObriga.Find(strNomCam, intIndex);
End;

procedure TConfiguraConsulta.pPesquisaRowValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  If VarToStr(DisplayValue).IsEmpty Then
  Begin
    Error := True;
    ErrorText := '';

    FValidacaoPeriodo.Visible := True;
    FValidacaoPeriodo.Caption := ' O filtro "' + Trim(AnsiReplaceStr(TcxEditorRow(FPesquisa.FocusedRow).Properties.Caption, '*', '')) +
                                  '" não pode ficar em branco!';

    blnValidateComErro := True;
  End Else
  Begin
    FValidacaoPeriodo.Visible := False;
    FValidacaoPeriodo.Caption := '';
    blnValidateComErro := False;
  End;
end;

Procedure TConfiguraConsulta.pMontaPesquisa(blnLimpar: Boolean = False);
  Var
    intIndice: Integer;
    filCammpo: TField;
    intIdxTmp,
    intQtdCol,
    intPeriodo: Integer;

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
  blnTemCampoObrigatorio := False;

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

    intPeriodo := 0;

    While Not Eof do
    Begin
      If intIndice > FPesquisa.Rows.Count-1 Then
        Break;

      FPesquisa.Rows[intIndice].Visible := True;

      If fCampoPeriodo(FieldByName('NOMCAM').AsString) Then
      Begin
        Inc(intPeriodo);

        If intPeriodo = 1 Then
        Begin
          TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.Caption := FieldByName('DESCAM').AsString + ' (Inicial)';
          TcxEditorRow(FPesquisa.Rows[intIndice]).Name               := FieldByName('NOMCAM').AsString + '_1';
        End Else
        Begin
          TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.Caption := FieldByName('DESCAM').AsString + ' (Final)';
          TcxEditorRow(FPesquisa.Rows[intIndice]).Name               := FieldByName('NOMCAM').AsString + '_2';
        End;

      End Else
      Begin
        TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.Caption := FieldByName('DESCAM').AsString;
        TcxEditorRow(FPesquisa.Rows[intIndice]).Name               := FieldByName('NOMCAM').AsString;

        intPeriodo := 0;
      End;

      If fCampoObrigatorio(FieldByName('NOMCAM').AsString) Then
      Begin
        TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.Caption := TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.Caption + ' *';
        blnTemCampoObrigatorio := True;
      End;

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

          TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.Hint := 'Pressione a tecla [Delete] para limpar';

          With TcxComboBoxProperties(TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.EditProperties) Do
          Begin
            DropDownListStyle   := lsFixedList;
            ImmediatePost       := True;
            ImmediateUpdateText := True;
            OnChange            := pChangeComboBox;
            ClearKey            := VK_DELETE;
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

          ftTime     : Begin
                         TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.EditPropertiesClass := TcxTimeEditProperties;
                         TcxTimeEditProperties(TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.EditProperties).ClearKey := VK_DELETE;
                       End;
          ftDateTime,
          ftDate     : TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.EditPropertiesClass := TcxCustomDateEditProperties;

          Else         Begin
                         TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.EditPropertiesClass := TcxTextEditProperties;
                         TcxTextEditProperties(TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.EditProperties).CharCase := ecUpperCase;
                       End;
        End;

      End;

      If fCampoObrigatorio(FieldByName('NOMCAM').AsString) Then
        TcxTextEditProperties(TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.EditProperties).OnValidate := pPesquisaRowValidate
      Else
        TcxTextEditProperties(TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.EditProperties).OnValidate := cxValidate;

      Inc(intIndice);

      If intPeriodo = 2 Then
        intPeriodo := 0;

      If intPeriodo <> 1 Then
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
  If (FConsultaView.GetColumnByFieldName(strNomCol) <> Nil) And
     FConsultaView.GetColumnByFieldName(strNomCol).Visible  Then
  Begin
    FConsultaView.DataController.ClearSorting(True);
    FConsultaView.GetColumnByFieldName(strNomCol).SortOrder := soAscending;
  End;
End;

Function TConfiguraConsulta.fLeConfiguracao(blnLoadV, blnMontaFullText, blnMontaPesquisa: Boolean): Boolean;
  Var
    stlDimPes: TStringList;

    Function fLeConfigAux(strNomeCFGCON, strNomeCFGEMP: String; blnComEmpresa: Boolean): Boolean;
    Begin
      With FCfgCon, SQL, FConfigur do
      Begin
        Close;
        Clear;

        strColunas := '';

        Add('SELECT C.* FROM ' + strNomeCFGCON + ' C');

        If blnComEmpresa Then
          Add('INNER JOIN ' + strNomeCFGEMP + ' E ON E.CFG_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' AND E.CFG_SEQGER = C.AUTOINCREM');

        Add('WHERE C.CFG_CHAVE_ = :CHAVE_  ');

        If fCfgSis('CONOPE', VarBoolean) Then
          Add('AND C.CFG_CODOPE = :CODOPE  ')
        Else
          Add('AND C.CFG_CODOPE IS NULL    ');

        ParamByName('CHAVE_').AsString := FChave;

        If fCfgSis('CONOPE', VarBoolean) Then
          ParamByName('CODOPE').AsString := strUsuarioLogado;

        Open;

        Result := Not IsEmpty;

        If Result Then
          FAchouPorEmpresa := blnComEmpresa;
      End;
    End;

    Function fLeConfig(strNomeCFGCON, strNomeCFGEMP: String): Boolean;
    Begin
      Result := fLeConfigAux(strNomeCFGCON, strNomeCFGEMP, True) Or
                fLeConfigAux(strNomeCFGCON, strNomeCFGEMP, False);
    End;

    Function fCopiaConfigAntiga: Boolean;
      Var
        strAutInc: String;
        qryCfgEmp: TUniQuery;
        intContador: Integer;
    Begin
      Result := fLeConfig('CFGCON', 'CFGEMP');

      If Result Then
      Begin
        Try
          fStartTransactionGen;

          pCarregaCFGEMP(FCfgCon.FieldbyName('AUTOINCREM').AsString, 'CFGEMP');

          strAutInc := fReplicaConfiguracao;

          qryCfgEmp := fCriaQuery(Nil);
          qryCfgEmp.SQL.Text := 'SELECT * FROM SELEMP WHERE FALSE';
          qryCfgEmp.Open;

          FCfgEmp.First;
          While Not FCfgEmp.Eof Do
          Begin

            qryCfgEmp.Insert;

            For intContador := 0 To FCfgEmp.FieldCount - 1 Do
              qryCfgEmp.Fields[intContador].Value := FCfgEmp.Fields[intContador].Value;

            qryCfgEmp.FieldByName('CFG_SEQGER').AsString := strAutInc;
            qryCfgEmp.Post;

            FCfgEmp.Next;
          End;

          fCommitGen;

        Except
          On E: Exception Do
          Begin
            fRollBackGen;
            ShowMessage(E.Message);
            Result := False;
            Exit;
          End;
        End;

      End;

      Result := fLeConfig('SELCON', 'SELEMP');
    End;

Begin
  Try

    With FCfgCon, SQL, FConfigur do
    Begin
      If Assigned(FobjConsulta) And FobjConsulta.blnSQLConsultaConfigurado Then
      Begin
        FNomeCFGCON := 'SELCON';
        FNomeCFGEMP := 'SELEMP';
      End Else
      Begin
        FNomeCFGCON := 'CFGCON';
        FNomeCFGEMP := 'CFGEMP';
      End;

      Result := fLeConfig(FNomeCFGCON, FNomeCFGEMP);

      If (Not Result) And Assigned(FobjConsulta) And FobjConsulta.blnSQLConsultaConfigurado Then
        Result := fCopiaConfigAntiga;

      If Result Then
      Begin

        If Not FAchouPorEmpresa Then
          pIncluiConfEmpresa(VS_strCodEmp, FieldbyName('AUTOINCREM').AsString);

        pCarregaCFGEMP(FieldbyName('AUTOINCREM').AsString, FNomeCFGEMP);

      End Else
      Begin

        pCarregaCFGEMP('', FNomeCFGEMP);

      End;

      intAltPan := 0;
      intRowHea := 0;
      intWidRow := 0;
      intWidVal := 200;

      aliAliPes := alBottom;

      blnFetch_ := True;
      blnFilObr := True;
      blnFilBra := False;
      blnComKey := True;
      blnZebrad := True;
      blnExpand := True;
      intCorZeb := 15589325;
      blnConsCo := False;
      blnConsCoOriginal := False;
      intTanFon := 8;
      strValor  := '';
      intRecNo  := 1;
      FLoadView := False;

      strCamposExibir := '';

      If Result Then
      Begin
        blnComKey := FieldByName('CFG_COMKEY').AsString = 'S';
        blnFetch_ := FieldByName('CFG_FETCH_').AsString = 'S';
        blnFilObr := FieldByName('CFG_FILOBR').AsString = 'S';
        blnFilBra := FieldByName('CFG_FILBRA').AsString = 'S';
        blnZebrad := FieldByName('CFG_ZEBRAD').AsString = 'S';
        blnExpand := FieldByName('CFG_EXPAND').AsString = 'S';

        FConfigur.sltGruObr.CommaText := fLinhaToTexto(FieldByName('CFG_GRUOBR').AsString);

        strColunas := FieldByName('CFG_LARCOL').AsString;

        If FieldByName('CFG_CORZEB').IsNull then
          intCorZeb := 0
        Else
          intCorZeb := FieldByName('CFG_CORZEB').AsInteger;

        blnConsCo := (FieldByName('CFG_CONSCO').AsString = 'S') And blnConsCoCfg;
        blnConsCoOriginal := blnConsCo;

        intTanFon := FieldByName('CFG_TAMFON').AsInteger;

        stlDimPes      := TStringList.Create;
        stlDimPes.Text := fLinhaToTexto(FieldByName('CFG_DIMPES').AsString);

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

        strCamposExibir := FieldByName('CFG_EXIBIR').AsString;

        strValor := fLinhaToTexto(FieldByName('CFG_VALOR_').AsString);

        If FieldByName('CFG_RECNO_').IsNull Then
          intRecNo := 1
        Else
          intRecNo := FieldByName('CFG_RECNO_').AsInteger;

        pCarregaFullText(fLinhaToTexto(FieldByName('CFG_FULLTE').AsString));

        FreeAndNil(stlDimPes);
      End;

      If Result And blnLoadV then
      Begin
        FLoadView := fCarregarView;
        If Not FLoadView Then
          FLoadView := (Pos('ConsultaDinâmica-', FChave) > 0) Or (Pos('ConsultaDinamica-', FChave) > 0);
      End;  

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
      pMontaFulltext(True);

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

Function TConfiguraConsulta.fRetCamposAutoSelecao: String;
Begin
  Result := FAutoSelecao.CommaText;
End;

Function TConfiguraConsulta.fConsultaContida(strCampo: String): Boolean;
  Var
    intIndex: Integer;
Begin
  If Not FCampoBuscaPalavraExataPorToken.IsEmpty Then
    If strCampo = FCampoBuscaPalavraExataPorToken Then
      Exit(False);

  If Not FCampoBuscaPalavraExataPorToken.IsEmpty Then
    If strCampo = fAliasCampoFiltro(FCampoBuscaPalavraExataPorToken) Then
      Exit(False);

  If Not FCampoBuscaComplementarPorToken.IsEmpty Then
    If strCampo = FCampoBuscaComplementarPorToken Then
      Exit(False);

  If Not FCampoBuscaComplementarPorToken.IsEmpty Then
    If strCampo = fAliasCampoFiltro(FCampoBuscaComplementarPorToken) Then
      Exit(False);

  If recConfigur.blnConsCoOriginal Then
    Result := recConfigur.blnConsCo
  Else
    Result := FContida.Find(strCampo, intIndex);

  If Not Result Then
    result := fLocateForcaContida(strCampo);
End;

Function TConfiguraConsulta.fLocateForcaContida(AField: String): Boolean;
var i: integer;
Begin
  Result := False;
  If Assigned(FobjConsulta) Then
    For i := 0 To High(FobjConsulta.arrForcaContida) do
      If FobjConsulta.arrForcaContida[i] = AField then
        Exit(True);
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

    EnableControls;
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

    EnableControls;
  End;

  Result := stlCampos.CommaText;

  FreeAndNil(stlCampos);
End;

Function TConfiguraConsulta.fRetCamposPeriodo: String;
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
      If FieldByName('PERIOD').AsString = 'S' Then
        stlCampos.Add(FieldByName('NOMCAM').AsString);
      Next;
    End;

    EnableControls;
  End;

  Result := stlCampos.CommaText;

  FreeAndNil(stlCampos);
End;

Function TConfiguraConsulta.fRetCamposQuantidadeCaracteres: String;
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
      If FieldByName('QTDCAR').AsInteger > 0 Then
        stlCampos.Add(FieldByName('NOMCAM').AsString + SEP_QTDCAR + FieldByName('QTDCAR').AsString);
      Next;
    End;

    EnableControls;
  End;

  Result := stlCampos.CommaText;

  FreeAndNil(stlCampos);
End;

Function TConfiguraConsulta.fRetCamposObrigatorio: String;
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
      If FieldByName('OBRIGA').AsString = 'S' Then
        stlCampos.Add(FieldByName('NOMCAM').AsString);
      Next;
    End;

    EnableControls;
  End;

  Result := stlCampos.CommaText;

  FreeAndNil(stlCampos);
End;

Function TConfiguraConsulta.fRetCamposGrupoObrigatorios: String;
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
      If FieldByName('GRUOBR').AsString = 'S' Then
        stlCampos.Add(FieldByName('NOMCAM').AsString);
      Next;
    End;

    EnableControls;
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

  strCamposExibir := stlCampos.Text;

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
    stlCampos.CommaText := fLinhaToTexto(FCfgCon.FieldByName('CFG_EXIBIR').AsString);
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
        FColunas.FieldByName('AUTSEL').AsString  := 'N';
        FColunas.Post;
      End;

      FColunas.Next;
    End;

    FColunas.EnableControls;

    FreeAndNil(stlCampos);
  End;
End;

Function TConfiguraConsulta.fTemTamanhoPesquisa(strCampo, strInfos: String; Var IntQtdCar: Integer): Boolean;
  Var
    stlInfos: TStringList;
    intContador: Integer;
    strNomCam,
    strQtdCam: String;
Begin
  Result := False;
  stlInfos := TStringList.Create;
  stlInfos.CommaText := strInfos;

  For intContador := 0 To stlInfos.Count - 1 Do
  Begin
    strNomCam := Copy(stlInfos[intContador], 1, Pred(Pos(SEP_QTDCAR, stlInfos[intContador])));

    strQtdCam := stlInfos[intContador];

    Delete(strQtdCam, 1, Pos(SEP_QTDCAR, stlInfos[intContador]) + Length(SEP_QTDCAR) - 1);

    If SameText(strCampo, strNomCam) Then
    Begin
      IntQtdCar := StrToIntDef(strQtdCam, 0);
      Result := True;
      Break;
    End;

  End;

  FreeAndNil(stlInfos)
End;

Procedure TConfiguraConsulta.pCarregaTravaConsulta(Var strComZer: String);
  Var
    qryTraCon: TUniQuery;
    intIndex,
    intContador: Integer;
    stlComZer: TStringList;
Begin
  stlComZer := TStringList.Create;
  stlComZer.Sorted := True;
  stlComZer.Text := AnsiReplaceStr(strComZer, ',', #13#10);

  qryTraCon := fCriaQuery(Self);;
  qryTraCon.SQL.Text := 'SELECT GROUP_CONCAT(TRA_NOMCAM) AS CAMPOS FROM TRACON WHERE TRA_CHAVE_ = ' + QuotedStr(FChave) + ' AND TRA_COMZER = "S"';
  qryTraCon.Open;

  FTraCon.Text := AnsiReplaceStr(qryTraCon.FieldByName('CAMPOS').AsString, ',', #13#10);

  For intContador := 0 To FTraCon.Count - 1 Do
    If Not stlComZer.Find(FTraCon[intContador], intIndex) Then
      strComZer := strComZer + ',' + FTraCon[intContador];

  FreeAndNil(qryTraCon);
  FreeAndNil(stlComZer);
End;

Procedure TConfiguraConsulta.pCarregaTamanhoMimimo(Var strQtdCar: String);
  Var
    qryTraTam: TUniQuery;
    blnAchou: Boolean;
    intContador,
    intContador2: Integer;
    stlNomes,
    stlTamanhos,
    stlQtdCarLocal: TStringList;
Begin
  stlTamanhos := TStringList.Create;
  stlNomes    := TStringList.Create;

  stlQtdCarLocal := TStringList.Create;
  stlQtdCarLocal.Text := AnsiReplaceStr(strQtdCar, ',', #13#10);

  qryTraTam := fCriaQuery(Self);;
  qryTraTam.SQL.Text := 'SELECT GROUP_CONCAT(TRA_NOMCAM ORDER BY TRA_NOMCAM) AS CAMPOS, ' +
                        '       GROUP_CONCAT(TRA_TAMMIN ORDER BY TRA_NOMCAM) AS TAMMIN  ' +
                        ' FROM TRATAM WHERE TRA_CHAVE_ = ' + QuotedStr(FChave) + ' AND TRA_TAMMIN > 0 ';
  qryTraTam.Open;

  FTraTam.Text := AnsiReplaceStr(qryTraTam.FieldByName('CAMPOS').AsString, ',', #13#10);

  stlNomes.Text    := AnsiReplaceStr(qryTraTam.FieldByName('CAMPOS').AsString, ',', #13#10);
  stlTamanhos.Text := AnsiReplaceStr(qryTraTam.FieldByName('TAMMIN').AsString, ',', #13#10);

  For intContador := 0 To stlNomes.Count - 1 Do
  Begin
    blnAchou := False;

    For intContador2 := 0 To stlQtdCarLocal.Count - 1 Do
      If AnsiStartsStr(stlNomes[intContador] + SEP_QTDCAR, stlQtdCarLocal[intContador2]) Then
      Begin
        stlQtdCarLocal[intContador2] := stlNomes[intContador] + SEP_QTDCAR + stlTamanhos[intContador];
        blnAchou := True;
        Break;
      End;

     If Not blnAchou Then
       stlQtdCarLocal.Add(stlNomes[intContador] + SEP_QTDCAR + stlTamanhos[intContador]);
  End;

  strQtdCar := AnsiReplaceStr(Trim(stlQtdCarLocal.Text), #13#10, ',');

  FreeAndNil(qryTraTam);
  FreeAndNil(stlQtdCarLocal);
  FreeAndNil(stlTamanhos);
End;

Procedure TConfiguraConsulta.pCarregaPesquisar;
  Var
    stlCopia: TStringList;
    stlCampos: TStringList;
    intPosicao,
    intIndice: Integer;
    strCampos: String;
    strComZer,
    strPeriod,
    strObriga,
    strGruObr,
    strQtdCar: String;
    intQtdCar: Integer;
Begin
  FContida.Clear;
  FAutoSelecao.Clear;

  If (Not FCfgCon.IsEmpty) And (Not fEmptyStr(FCfgCon.FieldByName('CFG_PESQUI').AsString)) Then
  Begin
    strCampos  := fLinhaToTexto(FCfgCon.FieldByName('CFG_PESQUI').AsString);
    strComZer  := fLinhaToTexto(FCfgCon.FieldByName('CFG_COMZER').AsString);
    strPeriod  := fLinhaToTexto(FCfgCon.FieldByName('CFG_PERIOD').AsString);
    strObriga  := fLinhaToTexto(FCfgCon.FieldByName('CFG_OBRIGA').AsString);
    strGruObr  := fLinhaToTexto(FCfgCon.FieldByName('CFG_GRUOBR').AsString);
    strQtdCar  := fLinhaToTexto(FCfgCon.FieldByName('CFG_QTDCAR').AsString);

    FContida.CommaText     := fLinhaToTexto(FCfgCon.FieldByName('CFG_CONTID').AsString);
    FAutoSelecao.CommaText := fLinhaToTexto(FCfgCon.FieldByName('CFG_AUTSEL').AsString);
  End Else
  Begin
    strCampos := FIndDef.CommaText;
    strComZer := '';
    strPeriod := '';
    strObriga := '';
    strGruObr := '';
    strQtdCar := '';
  End;

  pCarregaTravaConsulta(strComZer);
  pCarregaTamanhoMimimo(strQtdCar);

  stlCampos := TStringList.Create;
  stlCampos.CommaText := strCampos;

  stlCopia := TStringList.Create;
  stlCopia.CommaText  := strCampos;

  FColunas.DisableControls;

  For intIndice := 0 To stlCampos.Count - 1 Do
  Begin

    If Not FColunas.Locate('NOMCAM', stlCampos[intIndice], []) Then
    Begin
      intPosicao := stlCopia.IndexOf(stlCampos[intIndice]);

      If intPosicao > -1 Then
      Begin
        stlCopia.Delete(intPosicao);
      End;

    End Else
    Begin

      FColunas.Edit;
      FColunas.FieldByName('PESQUI').AsInteger := 1;

      If FContida.Find(stlCampos[intIndice], intPosicao) Then
        FColunas.FieldByName('EXPAND').AsString := 'S'
      Else
        FColunas.FieldByName('EXPAND').AsString := 'N';

      If FContida.Find(stlCampos[intIndice], intPosicao) Then
        FColunas.FieldByName('CONTID').AsString := 'S'
      Else
        FColunas.FieldByName('CONTID').AsString := 'N';

      If FAutoSelecao.Find(stlCampos[intIndice], intPosicao) Then
        FColunas.FieldByName('AUTSEL').AsString := 'S'
      Else
        FColunas.FieldByName('AUTSEL').AsString := 'N';

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
  FColSelec.AfterScroll := Nil;
  FColSelec.FieldByName('QTDCAR').ReadOnly := False;

  FColSelec.EmptyDataSet;
  For intIndice := 0 To stlCopia.Count - 1 Do
  Begin

    If FColunas.Locate('NOMCAM', stlCopia[intIndice], []) Then
    Begin
      FColSelec.Append;
      FColSelec.FieldByName('NOMCAM').AsString  := FColunas.FieldByName('NOMCAM').AsString;
      FColSelec.FieldByName('TIPDAD').AsString  := FColunas.FieldByName('TIPDAD').AsString;
      FColSelec.FieldByName('DESCAM').AsString  := FColunas.FieldByName('DESCAM').AsString;
      FColSelec.FieldByName('ORDCAM').AsInteger := Succ(intIndice);

      If Pos(FColunas.FieldByName('NOMCAM').AsString, strComZer) > 0 Then
        FColSelec.FieldByName('COMZER').AsString  := 'S'
      Else
        FColSelec.FieldByName('COMZER').AsString  := 'N';

      If Pos(FColunas.FieldByName('NOMCAM').AsString, strPeriod) > 0 Then
        FColSelec.FieldByName('PERIOD').AsString  := 'S'
      Else
        FColSelec.FieldByName('PERIOD').AsString  := 'N';

      If Pos(FColunas.FieldByName('NOMCAM').AsString, strObriga) > 0 Then
        FColSelec.FieldByName('OBRIGA').AsString  := 'S'
      Else
        FColSelec.FieldByName('OBRIGA').AsString  := 'N';

      If Pos(FColunas.FieldByName('NOMCAM').AsString, strGruObr) > 0 Then
        FColSelec.FieldByName('GRUOBR').AsString  := 'S'
      Else
        FColSelec.FieldByName('GRUOBR').AsString  := 'N';

      If fTemTamanhoPesquisa(FColunas.FieldByName('NOMCAM').AsString, strQtdCar, intQtdCar) Then
        FColSelec.FieldByName('QTDCAR').AsInteger := intQtdCar;

      FColSelec.Post;
    End;

  End;

  FColunas.EnableControls;

  FreeAndNil(stlCampos);
  FreeAndNil(stlCopia);

  FComZer.Text := AnsiReplaceStr(fRetCamposCompletaComZeros, ',', #13#10);
  FPeriod.Text := AnsiReplaceStr(fRetCamposPeriodo, ',', #13#10);
  FObriga.Text := AnsiReplaceStr(fRetCamposObrigatorio, ',', #13#10);
  FGruObr.Text := AnsiReplaceStr(fRetCamposGrupoObrigatorios, ',', #13#10);
  FQtdCar.Text := AnsiReplaceStr(fRetCamposQuantidadeCaracteres, ',', #13#10);
End;

Function TConfiguraConsulta.fReplicaConfiguracao: String;
  Var
    qryCfgCon: TUniQuery;
    IntIndice: Integer;
Begin
  qryCfgCon := fCriaQuery(Self);

  With qryCfgCon Do
  Begin

    Result := fRetAutoIncrem(FNomeCFGCON, VS_strCodEmp);

    SQL.Add('SELECT * FROM ' + FNomeCFGCON + ' WHERE FALSE');

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

    Add('REPLACE INTO ' + FNomeCFGEMP + ' (CFG_SEQGER, CFG_CODEMP, CFG_CHAVE_) VALUES (:SEQGER, :CODEMP, :CHAVE_)');

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
          strAutInc := fReplicaConfiguracao;

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
    Add('DELETE FROM ' + FNomeCFGEMP + ' WHERE CFG_SEQGER = :SEQGER');
    ParamByName('SEQGER').AsString := strAutInc;
    ExecSQL;

    Close;
    Clear;
    Add('REPLACE INTO ' + FNomeCFGEMP + ' (CFG_SEQGER, CFG_CODEMP, CFG_CHAVE_) VALUES (:SEQGER, :CODEMP, :CHAVE_)');

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
      Database.StartTransaction;

      If IsEmpty Then
      Begin
        Insert;
        FieldByName('CFG_CHAVE_').AsString := FChave;

        If fCfgSis('CONOPE', VarBoolean) Then
          FieldByName('CFG_CODOPE').AsString := strUsuarioLogado;

        FieldByName('AUTOINCREM').AsString := fRetAutoIncrem(FNomeCFGCON, VS_strCodEmp);
      End Else
      Begin
        pRecriaConfEmpresas;

        Edit;
      End;

      If blnComKey Then
        FieldByName('CFG_COMKEY').AsString := 'S'
      Else
        FieldByName('CFG_COMKEY').AsString := 'N';

      If blnFetch_ Then
        FieldByName('CFG_FETCH_').AsString := 'S'
      Else
        FieldByName('CFG_FETCH_').AsString := 'N';

      If blnFilObr Then
        FieldByName('CFG_FILOBR').AsString := 'S'
      Else
        FieldByName('CFG_FILOBR').AsString := 'N';

      If blnFilBra Then
        FieldByName('CFG_FILBRA').AsString := 'S'
      Else
        FieldByName('CFG_FILBRA').AsString := 'N';

      If blnZebrad Then
        FieldByName('CFG_ZEBRAD').AsString := 'S'
      Else
        FieldByName('CFG_ZEBRAD').AsString := 'N';

      If blnExpand Then
        FieldByName('CFG_EXPAND').AsString := 'S'
      Else
        FieldByName('CFG_EXPAND').AsString := 'N';

      FieldByName('CFG_CORZEB').AsInteger := intCorZeb;
      FieldByName('CFG_TAMFON').AsInteger := intTanFon;

      If blnConsCo Then
        FieldByName('CFG_CONSCO').AsString := 'S'
      Else
        FieldByName('CFG_CONSCO').AsString := 'N';

      FieldByName('CFG_CONTID').AsString := fTextoToLinha(fRetCamposContida);
      FieldByName('CFG_AUTSEL').AsString := fTextoToLinha(fRetCamposAutoSelecao);
      FieldByName('CFG_PESQUI').AsString := fTextoToLinha(fRetCamposPesquisa);
      FieldByName('CFG_EXIBIR').AsString := fTextoToLinha(fRetCamposExibir);
      FieldByName('CFG_COMZER').AsString := fTextoToLinha(fRetCamposCompletaComZeros);
      FieldByName('CFG_PERIOD').AsString := fTextoToLinha(fRetCamposPeriodo);
      FieldByName('CFG_OBRIGA').AsString := fTextoToLinha(fRetCamposObrigatorio);
      FieldByName('CFG_GRUOBR').AsString := fTextoToLinha(fRetCamposGrupoObrigatorios);
      FieldByName('CFG_QTDCAR').AsString := fTextoToLinha(fRetCamposQuantidadeCaracteres);
      FieldByName('CFG_FULLTE').AsString := fTextoToLinha(fRetCamposFullText);

      Case aliAliPes Of
        alTop: FieldByName('CFG_ALIPES').AsInteger := 0;
        Else   FieldByName('CFG_ALIPES').AsInteger := 1;
      End;

      Post;

      pSalvaCFGEMP(FieldByName('AUTOINCREM').AsString);

      pSalvaConsultaConfigurada;

      Result := True;

      If fCfgSis('CONOPE', VarBoolean) Then
        If objConfigOperadores.fTemRegistroSelecionado Then
          Result := objConfigOperadores.fReplicarConfigConsultaParaOperadores(
            FNomeCFGCON, FCfgCon.FieldByName('AUTOINCREM').AsString);

      If Result Then
        Database.Commit
      Else
        Database.Rollback;
    End;

  Except
    On E: Exception Do
    Begin
      Database.Rollback;

      Result := False;
      ShowMessage(E.Message);
    End;
  End;

End;

Procedure TConfiguraConsulta.pSalvaConsultaConfigurada;
Begin
  FColunas.First;
  While Not FColunas.Eof Do
  Begin
    If Assigned(FobjConsulta) And Assigned(FobjConsulta.dtsColunasUsuario) And
       FobjConsulta.dtsColunasUsuario.Locate('CAM_ALIAS_', FColunas.FieldByName('NOMCAM').AsString, []) Then
    Begin
      FobjConsulta.dtsColunasUsuario.Edit;
      FobjConsulta.dtsColunasUsuario.FieldByName('CAM_EXIBIR').AsString := FColunas.FieldByName('EXIBIR').AsString;
      FobjConsulta.dtsColunasUsuario.Post;
    End;
    FColunas.Next;
  End;
End;

Function TConfiguraConsulta.fLarColToText(view: TcxGridDBTableView): String;
  Var
    intContador: Integer;
    stlColunas: TStringList;
Begin
  stlColunas := TStringList.Create;

  For intContador := 0 To view.ColumnCount - 1 Do
    If view.Columns[intContador].Visible Then
      stlColunas.Add(view.Columns[intContador].DataBinding.FieldName + '^' + IntToStr(view.Columns[intContador].Width));

  Result := stlColunas.Text;

  FreeAndNil(stlColunas);
End;

Procedure TConfiguraConsulta.pRestauraColunas(view: TcxGridDBTableView);
  Var
    strNomCol: String;
    intLargura,
    intContador: Integer;
    stlColunas: TStringList;
    colColuna: TcxGridDBColumn;
Begin
  If Not FLoadView Then
    Exit;

  stlColunas := TStringList.Create;

  stlColunas.Text := FConfigur.strColunas;

  For intContador := 0 To stlColunas.Count - 1 Do
  Begin
    strNomCol := Trim(Copy(stlColunas[intContador], 1, Pred(Pos('^', stlColunas[intContador]))));

    intLargura := StrToIntDef(Trim(RightStr(stlColunas[intContador], Length(stlColunas[intContador]) - Pos('^', stlColunas[intContador]))), 0);

    colColuna := view.GetColumnByFieldName(strNomCol);

    If Assigned(colColuna) And (intLargura > 0) Then
      colColuna.Width := intLargura;
  End;

  FreeAndNil(stlColunas);

  blnRestaurouColunas := True;
End;

Function TConfiguraConsulta.fSalvaPesquisa(pnlPesquisaHeight: Integer;
                                           view: TcxGridDBTableView;
                                           qryConsulta: TDataSet;
                                           blnSalvaColunas: Boolean = False;
                                           blnSalvaColunasAutomaticamente: Boolean = True): Boolean;
  Var
    sltLista: TStringList;
    strArqTemp: String;
    blnIncluindo: Boolean;
    strAux: String;

  function fGravaCampoValorOuDimensao: Boolean;
  begin
    Result := blnSalvaColunasAutomaticamente;
    
    If (Not Result) Then
    Begin
      Result := Trim(FCfgCon.FieldByName('CFG_DIMPES').AsString).IsEmpty Or
                Trim(FCfgCon.FieldByName('CFG_VALOR_').AsString).IsEmpty;
    End;
  end;
    
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

        If fCfgSis('CONOPE', VarBoolean) Then
          FieldByName('CFG_CODOPE').AsString := strUsuarioLogado;

        FieldByName('CFG_COMKEY').AsString := 'N';
        FieldByName('AUTOINCREM').AsString := fRetAutoIncrem(FNomeCFGCON, VS_strCodEmp);
        FieldByName('CFG_FULLTE').AsString := fTextoToLinha(fRetCamposFullText);

        If blnComKey Then
          FieldByName('CFG_COMKEY').AsString := 'S'
        Else
          FieldByName('CFG_COMKEY').AsString := 'N';

        If blnFetch_ Then
          FieldByName('CFG_FETCH_').AsString := 'S'
        Else
          FieldByName('CFG_FETCH_').AsString := 'N';

        If blnFilObr Then
          FieldByName('CFG_FILOBR').AsString := 'S'
        Else
          FieldByName('CFG_FILOBR').AsString := 'N';

        If blnFilBra Then
          FieldByName('CFG_FILBRA').AsString := 'S'
        Else
          FieldByName('CFG_FILBRA').AsString := 'N';

        If blnZebrad Then
          FieldByName('CFG_ZEBRAD').AsString := 'S'
        Else
          FieldByName('CFG_ZEBRAD').AsString := 'N';

        If blnExpand Then
          FieldByName('CFG_EXPAND').AsString := 'S'
        Else
          FieldByName('CFG_EXPAND').AsString := 'N';

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

      If (fGravaCampoValorOuDimensao) Then
      Begin
        strAux := fTextoToLinha(sltLista.Text);
        If (FieldByName('CFG_DIMPES').AsString <> strAux) Then 
          FieldByName('CFG_DIMPES').AsString := fTextoToLinha(sltLista.Text);

        strAux := fTextoToLinha(fGetFuncoesCxGrid.fArquivoParaString(strArqTemp));
        If (FieldByName('CFG_VALOR_').AsString <> strAux) Then    
          FieldByName('CFG_VALOR_').AsString := fTextoToLinha(fGetFuncoesCxGrid.fArquivoParaString(strArqTemp));
      End;

      If Not qryConsulta.IsEmpty Then
        FieldByName('CFG_RECNO_').Value := qryConsulta.RecNo
      Else
        FieldByName('CFG_RECNO_').Value := null;

      If blnSalvaColunas Or
        (fEmptyStr(FieldByName('CFG_LARCOL').AsString) And (Not qryConsulta.IsEmpty)) Then
      Begin
        FieldByName('CFG_LARCOL').AsString := fLarColToText(view);

        strColunas := FieldByName('CFG_LARCOL').AsString;
      End;

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

Function TConfiguraConsulta.fEditaConfiguracoes(blnPermiteAtualiza: Boolean = False): Boolean;
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
    chkFilObr.Checked  := blnFilObr;
    chkFilBra.Checked  := blnFilBra;

    chkZebra.Checked     := blnZebrad;
    chkExpandida.Checked := blnExpand;

    If chkZebra.Checked Then
      dccZebra.ColorValue := intCorZeb;

    chkConsCo.Visible := blnConsCoCfg;
    chkExpandida.Visible := blnPermiteAtualiza;

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
      blnExpand := chkExpandida.Checked;
      intCorZeb := dccZebra.ColorValue;
      intTanFon := spnTanFon.Value;
      blnConsCo := chkConsCo.Checked;
      blnConsCoOriginal := blnConsCo;

      blnFetch_ := chkFetch.Checked;
      blnFilObr := chkFilObr.Checked;
      blnFilBra := chkFilBra.Checked;

      Case rdgAliPes.ItemIndex of
        0:   aliAliPes := alTop;
        Else aliAliPes := alBottom;
      End;

      Result := fSalvaConfiguracao;

      If Result Then
      Begin
        FComZer.Text := AnsiReplaceStr(fRetCamposCompletaComZeros, ',', #13#10);
        FPeriod.Text := AnsiReplaceStr(fRetCamposPeriodo, ',', #13#10);
        FObriga.Text := AnsiReplaceStr(fRetCamposObrigatorio, ',', #13#10);
        FGruObr.Text := AnsiReplaceStr(fRetCamposGrupoObrigatorios, ',', #13#10);
        FQtdCar.Text := AnsiReplaceStr(fRetCamposQuantidadeCaracteres, ',', #13#10);

        pMontaPesquisa(True);
      End;
    End;
  End;

  pFreeAndNil(frmConfiguraConsultaEdicao);
End;

Function TConfiguraConsulta.fGetMinCarDig(strCampo: String): Integer;
  Var
    intQtdCar: Integer;
Begin
  If fTemTamanhoPesquisa(strCampo, fCommaText(FQtdCar), intQtdCar) Then
    Result := intQtdCar
  Else
    Result := 0;
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
      Name     := 'EXPAND';
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
      Name     := 'AUTSEL';
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

    With AddFieldDef Do
    Begin
      Name     := 'TIPDAD';
      DataType := ftString;
      Size     := 20;
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

Function TConfiguraConsulta.fColunaAutoSelecao(strNomCam: String): Boolean;
  Var
    intPosicao: Integer;
Begin
  Result := FAutoSelecao.Find(strNomCam, intPosicao);
End;

Function TConfiguraConsulta.fTotalSelecao: Integer;
Begin
  With FColunas Do
  If TAggregateField(FieldByName('TOTSEL')).Value = Null Then
    Result := 0
  Else
    Result := TAggregateField(FieldByName('TOTSEL')).Value;
End;

function TConfiguraConsulta.fTotalSelecaoPeriodo: Integer;
  Var
    cdsClone: TUniClientDataSet;
begin
  cdsClone := TUniClientDataSet.Create(Nil);
  Try
    cdsClone.Data := FColSelec.Data;

    cdsClone.Filtered := False;
    cdsClone.Filter   := 'PERIOD = ''S''';
    cdsClone.Filtered := True;

    Result := cdsClone.RecordCount;
  Finally
    FreeAndNil(cdsClone);
  End;
end;

function TConfiguraConsulta.fTratarPesquisaCpfCpnjComLike(
  const ASQL: String): String;
begin
  Result := ASQL;
  //Req 254699
  //AND CLI_C_G_C_ LIKE '%48465962812%' nao usa indice
  //AND CLI_C_G_C_ LIKE '48465962812%'      usa indice
  Result := Result.Replace('C_G_C_ LIKE ''%', 'C_G_C_ LIKE ''');
end;

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

    With AddFieldDef Do
    Begin
      Name     := 'PERIOD';
      DataType := ftString;
      Size     := 1;
    End;

    With AddFieldDef Do
    Begin
      Name     := 'OBRIGA';
      DataType := ftString;
      Size     := 1;
    End;

    With AddFieldDef Do
    Begin
      Name     := 'GRUOBR';
      DataType := ftString;
      Size     := 1;
    End;

    With AddFieldDef Do
    Begin
      Name     := 'QTDCAR';
      DataType := ftInteger;
    End;

    With AddFieldDef Do
    Begin
      Name     := 'TIPDAD';
      DataType := ftString;
      Size     := 20;
    End;

    CreateDataSet;
    Open;
    IndexFieldNames := 'ORDCAM';
  End;

End;

Procedure TConfiguraConsulta.pAfterScrollColSelec(dataSet: TDataSet);
  Var
    intIndex: Integer;
Begin
  dataSet.FieldByName('QTDCAR').ReadOnly := (Not SameText(dataSet.FieldByName('TIPDAD').AsString, 'ftString')) Or
                                            FTraTam.Find(dataSet.FieldByName('NOMCAM').AsString, intIndex);

  dataSet.FieldByName('COMZER').ReadOnly := FTraCon.Find(dataSet.FieldByName('NOMCAM').AsString, intIndex);
End;

Function TConfiguraConsulta.fEhFiltroTravado: Boolean;
  Var
    strFieldName: String;
    intIndex: Integer;
Begin
  strFieldName := fNomeRowToFieldName(TcxEditorRow(FPesquisa.FocusedRow).Name);
  Result := FTraCon.Find(strFieldName, intIndex);
End;

Function TConfiguraConsulta.fEhFiltroTravado(strNomCam: String): Boolean;
  Var
    intIndex: Integer;
Begin
  Result := FTraCon.Find(strNomCam, intIndex);
End;

Function TConfiguraConsulta.fTemTamanhoMinimo(strNomCam: String): Boolean;
  Var
    intIndex: Integer;
Begin
  Result := FTraTam.Find(strNomCam, intIndex);
End;

Function TConfiguraConsulta.fRetTituloCampo(strNomCam: String; intIndex: Integer): String;
Begin
  If intIndex < FNomeCampos.Count Then
    Result := FNomeCampos[intIndex]
  Else
    Result := '';
End;

Procedure TConfiguraConsulta.pCarregaColunas;
  Var
    intContador: Integer;
    strTitulo: String;
Begin
  pCriaColunas;
  pCriaColunasSel;

  FColunas.EmptyDataSet;

  FConsulta.DisableControls;
  FConsulta.First;

  For intContador := 0 To FConsulta.Fields.Count - 1 Do
  Begin
    strTitulo := fRetTituloCampo(FConsulta.Fields[intContador].FieldName, intContador);

    If Not strTitulo.IsEmpty then
    Begin

      FColunas.Append;
      FColunas.FieldByName('EXIBIR').AsString := 'S';
      FColunas.FieldByName('CONTID').AsString := 'N';
      FColunas.FieldByName('EXPAND').AsString := 'N';
      FColunas.FieldByName('AUTSEL').AsString := 'N';
      FColunas.FieldByName('PESQUI').AsInteger := 0;
      FColunas.FieldByName('NOMCAM').AsString := FConsulta.Fields[intContador].FieldName;
      FColunas.FieldByName('DESCAM').AsString := strTitulo;
      FColunas.FieldByName('TIPDAD').AsString := GetEnumName(Typeinfo(TFieldType), integer(FConsulta.Fields[intContador].DataType));

      FColunas.Post;

    End;

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

procedure TConfiguraConsulta.pIncluiAutoSelecao(blnInclui: Boolean; strNomCam: String);
  Var
    intPosicao: Integer;
Begin
  If blnInclui then
  Begin
    If Not FAutoSelecao.Find(strNomCam, intPosicao) Then
      FAutoSelecao.Add(strNomCam);
  End Else
  Begin
    If FAutoSelecao.Find(strNomCam, intPosicao) Then
      FAutoSelecao.Delete(intPosicao);
  End;

End;

procedure TConfiguraConsulta.pBeforePostColunas(DataSet: TDataSet);
  Var
    intPosicao: Integer;
Begin
  FColSelec.AfterScroll := Nil;
  FColSelec.FieldByName('QTDCAR').ReadOnly := False;

  With DataSet Do
  Begin
    pIncluiContida(FieldByName('CONTID').AsString = 'S', FieldByName('NOMCAM').AsString);

    pIncluiAutoSelecao(FieldByName('AUTSEL').AsString = 'S', FieldByName('NOMCAM').AsString);

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
        FColSelec.FieldByName('TIPDAD').AsString  := FieldByName('TIPDAD').AsString;
        FColSelec.FieldByName('ORDCAM').AsInteger := Succ(intPosicao);
        FColSelec.FieldByName('COMZER').AsString  := 'N';
        FColSelec.FieldByName('PERIOD').AsString  := 'N';
        FColSelec.FieldByName('OBRIGA').AsString  := 'N';
        FColSelec.FieldByName('GRUOBR').AsString  := 'N';
        FColSelec.Post;
      End;

    End;

  End;

  FColSelec.AfterScroll := pAfterScrollColSelec;
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


function TConfiguraConsulta.fConverteFullText(strNomCam, strFiltro: String; var AHavingFilters: string): String;

  procedure pRemoveEspacoDuplo(var strFiltro : String);
  begin
    Repeat
      strFiltro := AnsiReplaceStr(strFiltro, '  ', ' ');
    Until (Pos('  ', strFiltro) <= 0);
  end;

  function fRetornaExpressao(strFiltro : String) : String;
  var
    stlTexto : TStringList;
  begin
    Result := '';
    If Not fEmptyStr(strFiltro) Then
    Begin
      stlTexto := TStringList.Create;
      try
        ExtractStrings([' '], [], PChar(strFiltro), stlTexto);
        For strFiltro In stlTexto Do
          If (Length(strFiltro) >= innodb_ft_min_token_size) Then
          Begin
            Result := Result + '+' + strFiltro + '*';
          End;
      finally
        FreeAndNil(stlTexto);
      end;
    End;
  end;

begin
  Result := '';

  If Not FCampoBuscaPalavraExataPorToken.IsEmpty And (strNomCam = FCampoBuscaPalavraExataPorToken) Then
  Begin
    If AHavingFilters <> '' Then
      AHavingFilters := AHavingFilters + ' AND ';

    AHavingFilters := AHavingFilters + fAliasCampoFiltro(strNomCam) + ' LIKE "%' + strFiltro + '%" ';

    strFiltro := AnsiReplaceStr(strFiltro, '%', '_');
    strFiltro := AnsiReplaceStr(strFiltro, '*', '_');
    strFiltro := AnsiReplaceStr(strFiltro, '-', '_');
    strFiltro := AnsiReplaceStr(strFiltro, '+', '_');
    strFiltro := AnsiReplaceStr(strFiltro, '/', '_');
    strFiltro := AnsiReplaceStr(strFiltro, '\', '_');
    strFiltro := AnsiReplaceStr(strFiltro, '.', '_');
    strFiltro := AnsiReplaceStr(strFiltro, '(', '_');
    strFiltro := AnsiReplaceStr(strFiltro, ')', '_');
    strFiltro := AnsiReplaceStr(strFiltro, '>', '_');
    strFiltro := AnsiReplaceStr(strFiltro, '<', '_');
    strFiltro := AnsiReplaceStr(strFiltro, '"', '_');
    strFiltro := AnsiReplaceStr(strFiltro, '~', '_');

    strFiltro := '| _' + Trim(strFiltro) + '_ |';

    AHavingFilters := AHavingFilters + ' AND ' + fAliasCampoFiltro(strNomCam) + ' LIKE "%' + strFiltro + '%" ';

    Result := '+' + strFiltro + '*';
  End
  Else
  Begin
    strFiltro := AnsiReplaceStr(strFiltro, '%', ' ');
    strFiltro := AnsiReplaceStr(strFiltro, '*', ' ');
    strFiltro := AnsiReplaceStr(strFiltro, '-', ' ');
    strFiltro := AnsiReplaceStr(strFiltro, '+', ' ');
    strFiltro := AnsiReplaceStr(strFiltro, '/', ' ');
    strFiltro := AnsiReplaceStr(strFiltro, '\', ' ');
    strFiltro := AnsiReplaceStr(strFiltro, '.', ' ');
    strFiltro := AnsiReplaceStr(strFiltro, '(', ' ');
    strFiltro := AnsiReplaceStr(strFiltro, ')', ' ');
    strFiltro := AnsiReplaceStr(strFiltro, '>', ' ');
    strFiltro := AnsiReplaceStr(strFiltro, '<', ' ');
    strFiltro := AnsiReplaceStr(strFiltro, '"', ' ');
    strFiltro := AnsiReplaceStr(strFiltro, '~', ' ');

    strFiltro := Trim(strFiltro);

    pRemoveEspacoDuplo(strFiltro);

    Result := fRetornaExpressao(strFiltro);
  End;
end;

Function TConfiguraConsulta.fNomeRowToNomeCampo(strNomCam: String): String;
Begin
  If EndsText('_1', strNomCam) Or EndsText('_2', strNomCam) Then
    Result := LeftStr(strNomCam, Length(strNomCam) - 2)
  Else
    Result := strNomCam;
End;

Function TConfiguraConsulta.fNomeCampoFiltro(strNomCam: String): String;
  Var
    intContador: Integer;
Begin
  strNomCam := fNomeRowToNomeCampo(strNomCam);

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

function TConfiguraConsulta.fAliasCampoFiltro(arrCampos: TArray<string>): TArray<string>;
var
  LIndex: Integer;
begin
  SetLength(Result, Length(arrCampos));
  for LIndex := 0 to Length(arrCampos)-1 do
    Result[LIndex] := fAliasCampoFiltro(arrCampos[LIndex]);
end;

Function TConfiguraConsulta.fAliasCampoFiltro(strNomCam: String): String;
  Var
    intContador: Integer;
Begin
  Result := strNomCam;
  If Assigned(FarrSubCon) Then
  For intContador := Low(FarrSubCon) To High(FarrSubCon) Do
  If SameText(strNomCam, FarrSubCon[intContador].strCamFil) And
     (Not fEmptyStr(FarrSubCon[intContador].strAlias_)) Then
  Begin
    Result := FarrSubCon[intContador].strAlias_;
    Exit;
  End;
End;

Function TConfiguraConsulta.fIgnoraChar(strCodCam, strValor: String): String;
  Var
    intContador,
    intContador2: Integer;
Begin
  Result := strValor;

  If Assigned(FobjConsulta) Then
  With FobjConsulta Do
  Begin

    For intContador := Low(arrCharIg) To High(arrCharIg) Do
      If SameText(strCodCam, arrCharIg[intContador].strCodCam) Then
      Begin

        For intContador2 := 1 To Length(arrCharIg[intContador].strCharIg) Do
          Result := AnsiReplaceStr(Result, arrCharIg[intContador].strCharIg[intContador2], '');

        Break;
      End;

  End;
End;

Function TConfiguraConsulta.fSQLFiltroPeriodo(intIndice: Integer; strCampoFiltro: String; blnDataSet: Boolean): String;
  Var
    strInicio,
    strFim: String;
Begin
  strInicio := fGetValorFiltro(intIndice, strCampoFiltro, blnDataSet);
  strFim := fGetValorFiltro(Succ(intIndice), strCampoFiltro, blnDataSet);

  If (Not fEmptyStr(strInicio)) And (Not fEmptyStr(strFim)) Then
  Begin

    If blnDataSet Then
      Result :=  strCampoFiltro + ' >= ' + strInicio + ' AND ' + strCampoFiltro + ' <= ' + strFim
    Else
      Result :=  strCampoFiltro + ' BETWEEN ' + strInicio + ' AND ' + strFim

  End Else If (Not fEmptyStr(strInicio)) Then
    Result :=  strCampoFiltro + ' >= ' +  strInicio

  Else If (Not fEmptyStr(strFim)) Then
    Result :=  strCampoFiltro + ' <= ' +  strFim

  Else
    Result := ' TRUE ';
End;

Function TConfiguraConsulta.fFiltroDataSet: String;
  Var
    intIndice: Integer;
    strValor, strCampoFiltro, strHavingFiltro: String;
    blnCompletouComZeros,
    blnPeriodo: Boolean;
Begin
  intIndice := 1;
  While intIndice <= FPesquisa.Rows.Count - 1 Do
  Begin
    blnCompletouComZeros := False;

    strCampoFiltro := fNomeCampoFiltro(TcxEditorRow(FPesquisa.Rows[intIndice]).Name);

    blnPeriodo := fCampoPeriodo(strCampoFiltro);

    //Campos processados apos abertura da consulta devem ser filtrados usando Filter do ClientDataSet
    If Not (Assigned(FobjConsulta) And MatchStr(strCampoFiltro, FobjConsulta.arrCamProc)) Then
    Begin
      Inc(intIndice);

      If blnPeriodo Then
        Inc(intIndice);

      Continue;
    End;

    If (TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.Value <> Null) And
       (Not fEmptyStr(TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.Value)) Then
    Begin

      If FConfigur.blnComKey Then
        blnCompletouComZeros := fCompletaComZerosPesquisa(TcxEditorRow(FPesquisa.Rows[intIndice]));

      If Not fEmptyStr(Result) Then
        Result := Result + ' AND ';

      If (TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.EditProperties Is TcxComboBoxProperties) Then
      Begin
        If TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.Value = 'SIM' Then
        Begin
          If blnPeriodo Then
          Begin
            Result := Result + fSQLFiltroPeriodo(intIndice, strCampoFiltro, True)
          End Else
          Begin
            Result := Result + strCampoFiltro;
            Result := Result + ' = ' + QuotedStr('SIM');
          End;
        End
        Else If TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.Value = 'NÃO' Then
        Begin
          If blnPeriodo Then
          Begin
            Result := Result + fSQLFiltroPeriodo(intIndice, strCampoFiltro, True)
          End Else
          Begin
            Result := Result + strCampoFiltro;
            Result := Result + ' = ' + QuotedStr('NÃO');
          End;
        End
        Else If TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.Value = 'TODOS' Then
        Begin
         Result := Result + ' 1 = 1 ';
        End
        Else
        Begin

          If blnPeriodo Then
          Begin
            Result := Result + fSQLFiltroPeriodo(intIndice, strCampoFiltro, True)
          End Else
          Begin
            Result := Result + strCampoFiltro;
            Result := Result + ' = ' + QuotedStr(TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.Value);
          End;

        End;
      End
      Else

      If (TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.EditProperties Is TcxCurrencyEditProperties) Then
      Begin
        If blnPeriodo Then
        Begin
          Result := Result + fSQLFiltroPeriodo(intIndice, strCampoFiltro, True)
        End Else
        Begin
          Result := Result + strCampoFiltro;
          Result := Result + ' = ' + AnsiReplaceStr(TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.Value, ',', '.');
        End;
      End

      Else If TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.EditProperties Is TcxTimeEditProperties Then
      Begin
        If blnPeriodo Then
        Begin
          Result := Result + fSQLFiltroPeriodo(intIndice, strCampoFiltro, True)
        End Else
        Begin
          Result := Result + strCampoFiltro;
          Result := Result + ' = ' + QuotedStr(FormatDateTime('HH:NN', StrToTimeDef(TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.Value, 0)))
        End;
      End

      Else If TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.EditProperties Is TcxCustomDateEditProperties Then
      Begin
        If blnPeriodo Then
        Begin
          Result := Result + fSQLFiltroPeriodo(intIndice, strCampoFiltro, True)
        End Else
        Begin
          Result := Result + 'DATE('+ strCampoFiltro +')';
          Result := Result + ' = ' + QuotedStr(FormatDateTime('YYYY-MM-DD', StrToDateDef(TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.Value, 0)));
        End;
      End Else
      Begin
        strValor := fIgnoraChar(strCampoFiltro, TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.Value).Replace('*', '%');

        If (Not blnCompletouComZeros) And fConsultaContida(strCampoFiltro) Then
        Begin
          pAjustaConsultaContida(TcxEditorRow(FPesquisa.Rows[intIndice]));
          If fEmptyStr(fGetSQLTextoContido(strCampoFiltro, strValor, False{blnUsarMatch}, strHavingFiltro)) Then
           Result := Result + ' TRUE '
          Else
            Result := Result + fGetSQLTextoContido(strCampoFiltro, strValor, False{blnUsarMatch}, strHavingFiltro);
        End
        Else
        Begin
          If blnPeriodo Then
          Begin
            Result := Result + fSQLFiltroPeriodo(intIndice, strCampoFiltro, True)
          End Else
          Begin
            Result := Result + strCampoFiltro;

            If blnCompletouComZeros Then
              Result := Result + ' = ' + QuotedStr(fSafeSQLValue(strValor))
            Else
              Result := Result + ' LIKE ' + QuotedStr(fSafeSQLValue(strValor) + '%');
          End;
        End;
      End;

    End;

    Inc(intIndice);

    If blnPeriodo Then
      Inc(intIndice);
  End; {While intIndice <= FPesquisa.Rows.Count - 1 Do}

End;

Function TConfiguraConsulta.fGetValorFiltro(intIndice: Integer; strNomCam: String; blnDataSet: Boolean): String;
Begin
  If (TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.Value = Null) Or
     fEmptyStr(TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.Value) Then
  Begin
    Result := '';
    Exit;
  End;

  If (TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.EditProperties Is TcxComboBoxProperties) Then
  Begin
    If TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.Value = 'SIM' Then
    Begin
      Result := '"SIM"';
    End
    Else If TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.Value = 'NÃO' Then
    Begin
      Result := '"NÃO"';
    End
    Else If TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.Value = 'TODOS' Then
    Begin
      Result := ' TRUE ';
    End
    Else
    Begin
      Result := '"' + TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.Value + '"';
    End;
  End

  Else If (TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.EditProperties Is TcxCurrencyEditProperties) Then
  Begin
    Result := AnsiReplaceStr(TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.Value, ',', '.');
  End

  Else If TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.EditProperties Is TcxTimeEditProperties Then
  Begin
    Result := QuotedStr(FormatDateTime('HH:NN', StrToTimeDef(TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.Value, 0)))
  End

  Else If TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.EditProperties Is TcxCustomDateEditProperties Then
  Begin
    Result := QuotedStr(FormatDateTime(IFThen(blnDataSet, 'DD/MM/YYYY', 'YYYY-MM-DD'), StrToDateDef(TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.Value, 0)))
  End

  Else Result := QuotedStr(fIgnoraChar(strNomCam, TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.Value).Replace('*', '%'));
End;

Function TConfiguraConsulta.fSQLFiltro(var AHavingFilters: string): String;
  Var
    intIndice: Integer;
    strValor,
    strCampoFiltro,
    strNomeCampoFiltro,
    strCamposIndiceFullText: string;
    strSQL: String;
    strConvFull: String;
    blnCompletouComZeros,
    blnPeriodo: Boolean;
    clausulaWhere: String;
    RecReplaceChar: TRecReplaceChar;
Begin
  Result := '';
  AHavingFilters := '';

  intIndice := 1;

  While intIndice <= FPesquisa.Rows.Count - 1 Do
  Begin
    blnCompletouComZeros := False;
    strNomeCampoFiltro := fNomeCampoFiltro(TcxEditorRow(FPesquisa.Rows[intIndice]).Name);
    strCampoFiltro := fCampoToSubConsulta(strNomeCampoFiltro, False);

    blnPeriodo := fCampoPeriodo(strCampoFiltro);

    //Campos processados apos abertura da consulta devem ser filtrados usando Filter do ClientDataSet
    If Assigned(FobjConsulta) And MatchStr(strCampoFiltro, FobjConsulta.arrCamProc) Then
    Begin
      Inc(intIndice);
      Continue;
    End;

    If ((TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.Value <> Null) And
       (Not fEmptyStr(TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.Value))) Or
       (blnPeriodo And
         ((TcxEditorRow(FPesquisa.Rows[Succ(intIndice)]).Properties.Value <> Null) And
         (Not fEmptyStr(TcxEditorRow(FPesquisa.Rows[Succ(intIndice)]).Properties.Value)))) Then
    Begin

      If FConfigur.blnComKey Then
        blnCompletouComZeros := fCompletaComZerosPesquisa(TcxEditorRow(FPesquisa.Rows[intIndice]));

      If Not fEmptyStr(Result) Then
        Result := Result + ' AND ';

      If (TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.EditProperties Is TcxComboBoxProperties) Then
      Begin
        If TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.Value = 'SIM' Then
        Begin
          If blnPeriodo Then
          Begin
            Result := Result + fSQLFiltroPeriodo(intIndice, strCampoFiltro, False)
          End Else
          Begin
            Result := Result + strCampoFiltro;
            Result := Result + ' = "SIM"';
          End;
        End
        Else If TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.Value = 'NÃO' Then
        Begin
          If blnPeriodo Then
          Begin
            Result := Result + fSQLFiltroPeriodo(intIndice, strCampoFiltro, False)
          End Else
          Begin
            Result := Result + strCampoFiltro;
            Result := Result + ' = "NÃO"';
          End;
        End
        Else If TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.Value = 'TODOS' Then
        Begin
          Result := Result + ' TRUE ';
        End
        Else
        Begin
          If blnPeriodo Then
          Begin
            Result := Result + fSQLFiltroPeriodo(intIndice, strCampoFiltro, False)
          End Else
          Begin
            Result := Result + strCampoFiltro;
            Result := Result + ' = "' + TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.Value + '"';
          End;
        End;
      End

      Else If (TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.EditProperties Is TcxCurrencyEditProperties) Then
      Begin
        If blnPeriodo Then
        Begin
          Result := Result + fSQLFiltroPeriodo(intIndice, strCampoFiltro, False)
        End Else
        Begin
          Result := Result + strCampoFiltro;
          Result := Result + ' = ' + AnsiReplaceStr(TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.Value, ',', '.');
        End;
      End

      Else If TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.EditProperties Is TcxTimeEditProperties Then
      Begin
        If blnPeriodo Then
        Begin
          Result := Result + fSQLFiltroPeriodo(intIndice, strCampoFiltro, False)
        End Else
        Begin
          Result := Result + strCampoFiltro;
          Result := Result + ' = ' + QuotedStr(FormatDateTime('HH:NN', StrToTimeDef(TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.Value, 0)))
        End;
      End

      Else If TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.EditProperties Is TcxCustomDateEditProperties Then
      Begin
        If blnPeriodo Then
        Begin
          Result := Result + fSQLFiltroPeriodo(intIndice, strCampoFiltro, False)
        End Else
        Begin
          Result := Result + strCampoFiltro;
          Result := Result + ' =  ' + QuotedStr(FormatDateTime('YYYY-MM-DD', StrToDateDef(TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.Value, 0)))
        End;
      End Else

      Begin
        strSQL := '';
        clausulaWhere := ObterClausulaWhere(TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.Value);
        strValor := fIgnoraChar(strCampoFiltro, TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.Value);

        If Assigned(FobjConsulta) Then
        Begin
          RecReplaceChar := FobjConsulta.fGetReplaceChar(strCampoFiltro);
          If Not fEmptyStr(RecReplaceChar.Campo) Then
            strValor := fIgnoraChar(strCampoFiltro, TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.Value).Replace(RecReplaceChar.CharOrigem, RecReplaceChar.CharDestino)
        End;

        If FConfigur.blnComKey And (Not blnCompletouComZeros) And (Length(strValor) >= innodb_ft_min_token_size) And fCampoTemIndiceFullText(strCampoFiltro, strCamposIndiceFullText) Then
        Begin
          If Not FCampoBuscaPalavraExataPorToken.IsEmpty And (strCampoFiltro = FCampoBuscaPalavraExataPorToken) Then
          Begin
            If Pos('%', strValor) = 0 Then
            Begin
              strConvFull := fConverteFullText(strCampoFiltro, strValor, AHavingFilters);
              strSQL      := fSQLFullText(strCampoFiltro, strConvFull);
            End
            Else
            Begin
              strSQL := ' ' + strCampoFiltro + ' LIKE ' + QuotedStr('%' + strValor + '%');
            End;
          End
          Else If Not FCampoBuscaComplementarPorToken.IsEmpty And (strCampoFiltro = FCampoBuscaComplementarPorToken) Then
          Begin
            strSQL := TFuncoesGenCompartilhada.fSQLBuscaComplementarPorToken(strCamposIndiceFullText.Split([',']),
                                                                             fAliasCampoFiltro(strCamposIndiceFullText.Split([','])),
                                                                             strValor,
                                                                             AHavingFilters);
          End
          Else If fConsultaContida(TcxEditorRow(FPesquisa.Rows[intIndice]).Name) And
            (Pos('.', strValor) = 0) And (Pos('/', strValor) = 0) And (Pos(',', strValor) = 0) Then
          Begin
            strConvFull := fConverteFullText(strCampoFiltro, strValor, AHavingFilters);
            strSQL      := fSQLFullText(strCampoFiltro, strConvFull);
          End;
        End;

        If fEmptyStr(strSQL) then
        Begin
          If (Not blnCompletouComZeros) And fConsultaContida(TcxEditorRow(FPesquisa.Rows[intIndice]).Name) Then
          Begin
            pAjustaConsultaContida(TcxEditorRow(FPesquisa.Rows[intIndice]));
            //Caso tenha digitado apenas '%' ou '*' é removido ficando vazio o filtro
            //ocasionando erro de sintaxe (AND AND). Ver Req: 73925
            If fEmptyStr(fGetSQLTextoContido(strCampoFiltro, strValor, True{blnUsarMatch}, AHavingFilters)) Then
              Result := Result + ' TRUE '
            Else
              Result := Result + fGetSQLTextoContido(strCampoFiltro, strValor, True{blnUsarMatch}, AHavingFilters);
          End
          Else
          Begin
            If blnPeriodo Then
            Begin
              Result := Result + fSQLFiltroPeriodo(intIndice, strCampoFiltro, False)
            End Else
            if clausulaWhere<> '' then
            begin
              Result := Result + strCampoFiltro;
              Result := Result + clausulaWhere +
                QuotedStr(
                  strValor.Replace('=','')
                  .Replace('>','')
                  .Replace(' ','')
                );
            end Else
            Begin
              Result := Result + strCampoFiltro;

              If blnCompletouComZeros Then
                Result := Result + ' = ' + QuotedStr(fSafeSQLValue(strValor))
              Else
                Result := Result + ' LIKE ' + QuotedStr(fSafeSQLValue(strValor) + '%');
            End;
          End;
        End
        Else
        Begin  // FULLTEXT
          Result := Result + strSQL;
        End;

      End;

    End;

    Inc(intIndice);

    If blnPeriodo Then
      Inc(intIndice);
  End; {While intIndice <= FPesquisa.Rows.Count - 1 Do}

  Result := fTratarPesquisaCpfCpnjComLike(Result);

End;

function TConfiguraConsulta.fNomeRowToFieldName(strNomRow: String): String;
Begin
  If strNomRow.EndsWith('_1') Or strNomRow.EndsWith('_2') Then
   Result := Copy(strNomRow, 1, Length(strNomRow) - 2)
  Else
    Result := strNomRow;
End;

function TConfiguraConsulta.fValidaFiltros: Boolean;
  Var
    intMinCar,
    intIndice: Integer;
    strValorFiltroLimpo,
    strGrupoObrigatorio,
    strFieldName,
    strValorFiltro,
    strCampoFiltro: String;
    strNomeCampoFiltro:String;
    blnTemValorInfiltro,
    blnPeriodo: Boolean;
Begin
  strErroValidacao := '';

  blnTemValorInfiltro := False;
  blnTemAoMenosUmFiltroPreenchido := False;

  Result := True;

  intIndice := 1;

  While intIndice <= FPesquisa.Rows.Count - 1 Do
  Begin
    strCampoFiltro := fCampoToSubConsulta(fNomeCampoFiltro(TcxEditorRow(FPesquisa.Rows[intIndice]).Name), False);
    strNomeCampoFiltro := fNomeCampoFiltro(TcxEditorRow(FPesquisa.Rows[intIndice]).Name);

    blnPeriodo := fCampoPeriodo(strCampoFiltro);

    strFieldName := fNomeRowToFieldName(TcxEditorRow(FPesquisa.Rows[intIndice]).Name);

    strValorFiltro := fGetValorFiltro(intIndice, strCampoFiltro, False);

    if not fEmptyStr(strValorFiltro) then
      blnTemAoMenosUmFiltroPreenchido := True;

    If fEhCampoGrupoObrigatorio(strFieldName) Then
    Begin
      If (Not fEmptyStr(strValorFiltro)) Then
        blnTemValorInfiltro := True;

      If blnPeriodo And (Not fEmptyStr(fGetValorFiltro(Succ(intIndice), strCampoFiltro, False))) Then
        blnTemValorInfiltro := True;
    End;

    If blnPeriodo And
      (Not fEmptyStr(fGetValorFiltro(Succ(intIndice), strCampoFiltro, False))) And
      (strValorFiltro > fGetValorFiltro(Succ(intIndice), strCampoFiltro, False)) Then
    Begin
      If (Not Assigned(FPesquisa.FocusedRow)) Or (intIndice <= FPesquisa.FocusedRow.Index) Then
        strErroValidacao := '"' + TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.Caption + '" maior que "' +
                            TcxEditorRow(FPesquisa.Rows[Succ(intIndice)]).Properties.Caption + '" !';

      TcxEditorRow(FPesquisa.Rows[intIndice]).Focused := True;
      Result := False;
      Exit;
    End;

    If (Not fEmptyStr(strValorFiltro)) Then
    Begin
      strValorFiltroLimpo := Trim(AnsiReplaceStr(AnsiReplaceStr(strValorFiltro, '%', ''), '*', ''));
      If AnsiStartsStr('''', strValorFiltroLimpo) Then
        strValorFiltroLimpo := Trim(AnsiReplaceStr(strValorFiltro, '''', ''));

      intMinCar := fGetMinCarDig(TcxEditorRow(FPesquisa.Rows[intIndice]).Name);

      If (intMinCar > 0) And (Length(strValorFiltroLimpo) < intMinCar) Then
      Begin
        strErroValidacao := ' O filtro "' + Trim(AnsiReplaceStr(TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.Caption, '*', '')) +
                            '" deve ter um tamanho mínimo de ' + intMinCar.ToString + ' caracteres!';
        Result := False;
        Exit;
      End;
    End;

    If fCampoObrigatorio(strNomeCampoFiltro) And
       fEmptyStr(fGetValorFiltro(intIndice, strNomeCampoFiltro, False)) Then
    Begin
      If (Not Assigned(FPesquisa.FocusedRow)) Or (intIndice <= FPesquisa.FocusedRow.Index) Then
        strErroValidacao := ' O filtro "' + Trim(AnsiReplaceStr(TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.Caption, '*', '')) +
                            '" não pode ficar em branco!';

      TcxEditorRow(FPesquisa.Rows[intIndice]).Focused := True;

      Result := False;
      Exit;
    End;

    If blnPeriodo And
       fCampoObrigatorio(strNomeCampoFiltro) And
       fEmptyStr(fGetValorFiltro(Succ(intIndice), strNomeCampoFiltro, False)) Then
    Begin
      If (Not Assigned(FPesquisa.FocusedRow)) Or (Succ(intIndice) <= FPesquisa.FocusedRow.Index) Then
        strErroValidacao := ' O filtro "' + Trim(AnsiReplaceStr(TcxEditorRow(FPesquisa.Rows[Succ(intIndice)]).Properties.Caption, '*', '')) +
                          '" não pode ficar em branco!';

      TcxEditorRow(FPesquisa.Rows[Succ(intIndice)]).Focused := True;

      Result := False;
      Exit;
    End;

    Inc(intIndice);

    If blnPeriodo Then
      Inc(intIndice);
  End; {While intIndice <= FPesquisa.Rows.Count - 1 Do}

  If Result And (Not blnTemValorInfiltro) And FConfigur.blnFilObr Then
  Begin
    strGrupoObrigatorio := fDescricaoCamposGrupoObrigatorio;

    If strGrupoObrigatorio.IsEmpty Then
      strErroValidacao := ' Ao menos um filtro deve ser informado para a consulta!'
    Else
      strErroValidacao := ' Ao menos um filtro (entre os filtros ' + strGrupoObrigatorio + ') deve ser informado para a consulta!';

    Result := False;
    Exit;
  End;

End;

function TConfiguraConsulta.ObterClausulaWhere(const str: String): String;
begin
  Result := '';

  if str.Contains('>=') then
    Result := ' >= '
  else if str.Contains('>') then
    Result := ' > '
  else if str.Contains('=') then
    Result := ' = ';
end;

function TConfiguraConsulta.fEhCampoGrupoObrigatorio(strNomCam: String): Boolean;
  Var
    intIndex: Integer;
Begin
  Result := True;

  If FConfigur.sltGruObr.Count = 0 Then
    Exit;

  Result := FConfigur.sltGruObr.Find(strNomCam, intIndex);
End;

function TConfiguraConsulta.fDescricaoCamposGrupoObrigatorio: String;
  Var
    intCotador: Integer;
    sltNomes: TStringList;
Begin
  sltNomes := TStringList.Create;
  sltNomes.Duplicates := dupIgnore;
  sltNomes.Sorted := True;

  For intCotador := 0 To FConfigur.sltGruObr.Count - 1 Do
    If FColSelec.Locate('NOMCAM', FConfigur.sltGruObr[intCotador], []) Then
      sltNomes.Add(FColSelec.FieldByName('DESCAM').AsString);

  Result := fCommaText(sltNomes);
  FreeAndNil(sltNomes);
End;

function TConfiguraConsulta.fGetMySqlVariableValue(strName: String): String;
  Var
    qryVar: TUniQuery;
Begin
  qryVar := fCriaQuery(Self);
  qryVar.SQL.Add('SHOW VARIABLES LIKE "%' + strName + '%"');
  qryVar.Open;

  Result := qryVar.FieldByName('Value').AsString;

  FreeAndNil(qryVar);
End;

function TConfiguraConsulta.fGetSQLTextoContido(strCampo, strTexto: String; blnUsarMatch: Boolean; var AHavingFilters: string): String;
  Var
    stlTexto: TStringList;
    strSQL,
    clausulaWhere,
    strConvFull,
    strCamposIndiceFullText: string;
begin
  Result := '';

  Repeat
    strTexto := AnsiReplaceStr(strTexto, '  ', ' ');
  Until (Pos('  ', strTexto) <= 0);

  If fEmptyStr(strTexto) Then
    Exit;

  clausulaWhere := ObterClausulaWhere(strTexto);

  stlTexto := TStringList.Create;
  ExtractStrings([' '], [], PChar(strTexto), stlTexto);

  For strTexto In stlTexto Do
  Begin
    If Not fEmptyStr(Result) Then
      Result := Result + ' AND ';

    strSQL := '';

    If blnUsarMatch And FConfigur.blnComKey And (Length(strTexto) >= innodb_ft_min_token_size) And fCampoTemIndiceFullText(strCampo, strCamposIndiceFullText) Then
    Begin
      If Not FCampoBuscaPalavraExataPorToken.IsEmpty And (strCampo = FCampoBuscaPalavraExataPorToken) Then
      Begin
        If Pos('%', strTexto) = 0 Then
        Begin
          strConvFull := fConverteFullText(strCampo, strTexto, AHavingFilters);
          strSQL := fSQLFullText(strCampo, strConvFull);
        End
        Else
          strSQL := ' ' + strCampo + ' LIKE ' + QuotedStr('%' + strTexto + '%');
      End
      Else If Not FCampoBuscaComplementarPorToken.IsEmpty And (strCampo = FCampoBuscaComplementarPorToken) Then
      Begin
        strSQL := TFuncoesGenCompartilhada.fSQLBuscaComplementarPorToken(strCamposIndiceFullText.Split([',']),
                                                                         fAliasCampoFiltro(strCamposIndiceFullText.Split([','])),
                                                                         strTexto,
                                                                         AHavingFilters);
      End
      Else If (Pos('.', strTexto) = 0) And (Pos('/', strTexto) = 0) And (Pos(',', strTexto) = 0) Then
      Begin
        strConvFull := fConverteFullText(strCampo, strTexto, AHavingFilters);
        strSQL := fSQLFullText(strCampo, strConvFull);
      End;
    End;

    if fEmptyStr(strSQL) then
    begin
      if clausulaWhere <> '' then
      begin
        Result := Result + strCampo;
        Result := Result + clausulaWhere +
          QuotedStr(
            strTexto.Replace('=','')
            .Replace('>','')
            .Replace(' ','')
          )
      end
      else
        Result := Result + strCampo + ' LIKE ' + QuotedStr('%' + strTexto + '%')
    end
    Else
      Result := Result + strSQL;
  End;

  FreeAndNil(stlTexto);
end;

Function TConfiguraConsulta.fPesquisaNaDigitacao: Boolean;
Begin
  Result := (Not (TcxEditorRow(FPesquisa.FocusedRow).Properties.EditProperties Is TcxCustomDateEditProperties)) And
            (Not (TcxEditorRow(FPesquisa.FocusedRow).Properties.EditProperties Is TcxTimeEditProperties)) And
            (Not (TcxEditorRow(FPesquisa.FocusedRow).Properties.EditProperties Is TcxCurrencyEditProperties));
End;

function TConfiguraConsulta.fPossuiFiltro: Boolean;
var
  intIndice: Integer;
begin
  Result := False;
  For intIndice := 1 To Pred(FPesquisa.Rows.Count) Do
  Begin
    If (TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.Value <> Null) And
       (Not fEmptyStr(TcxEditorRow(FPesquisa.Rows[intIndice]).Properties.Value)) Then
    Begin
      Result := True;
      Break;
    End;
  End;
end;

Function TConfiguraConsulta.fCompletaComZerosPesquisa(cxEditorRow: TcxEditorRow): Boolean;
  Var
    intIndex: Integer;
begin
  Result := False;

  If (cxEditorRow.Properties.EditProperties Is TcxTextEditProperties) Then
  Begin
    If FComZer.Find(cxEditorRow.Name, intIndex) And
       (FConsulta.Active And (FConsulta.FindField(cxEditorRow.Name) <> Nil)) Then
    Begin
      If (Not fEmptyStr(VarToStr(cxEditorRow.Properties.Value))) And
         (Pos('%', VarToStr(cxEditorRow.Properties.Value)) = 0)  And
         (Pos('*', VarToStr(cxEditorRow.Properties.Value)) = 0)  Then
      Begin
        Result := True;
        cxEditorRow.Properties.Value := fStrZero(VarToStr(cxEditorRow.Properties.Value),
          FConsulta.FindField(cxEditorRow.Name).Size);
      End;
    End;
  End;
end;

procedure TConfiguraConsulta.pAjustaConsultaContida(cxEditorRow: TcxEditorRow);
Var blnCampoPermiteAsterisco: Boolean;
begin
  blnCampoPermiteAsterisco := False;
  If (cxEditorRow.Properties.EditProperties Is TcxTextEditProperties) Then
    If SameText(cxEditorRow.Name, 'ITE_DESITE') Then
      blnCampoPermiteAsterisco := True;

  If (cxEditorRow.Properties.EditProperties Is TcxTextEditProperties) And
     FConfigur.blnComKey And (Pos('%', cxEditorRow.Properties.Value) > 0) Then
  Begin
    cxEditorRow.Properties.Value := Trim(ReplaceStr(VarToStr(cxEditorRow.Properties.Value), '%', ' '));
    Repeat
      cxEditorRow.Properties.Value := AnsiReplaceStr(cxEditorRow.Properties.Value, '  ', ' ');
    Until (Pos('  ', cxEditorRow.Properties.Value) <= 0);
  End;

  If (cxEditorRow.Properties.EditProperties Is TcxTextEditProperties) And
     FConfigur.blnComKey And (Pos('*', cxEditorRow.Properties.Value) > 0) And (Not blnCampoPermiteAsterisco) Then
  Begin
    cxEditorRow.Properties.Value := Trim(ReplaceStr(VarToStr(cxEditorRow.Properties.Value), '*', ' '));
    Repeat
      cxEditorRow.Properties.Value := AnsiReplaceStr(cxEditorRow.Properties.Value, '  ', ' ');
    Until (Pos('  ', cxEditorRow.Properties.Value) <= 0);
  End;
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

    If (fTotalSelecao + fTotalSelecaoPeriodo) > MAX_COLS_PESQUISA Then
    Begin
      Edit;
      FieldByName('PESQUI').AsInteger := 0;
      Post;

      fMensagem('', 'É permitido selecionar até '+ MAX_COLS_PESQUISA.ToString +' colunas para a pesquisa!', ['&Ok']);
    End;

    EnableControls;
  End;
End;

procedure TConfiguraConsulta.pVerificaLimitePesquisaSel;
begin
  With FColSelec Do
  Begin
    DisableControls;

    If (fTotalSelecao + fTotalSelecaoPeriodo) > MAX_COLS_PESQUISA Then
    Begin
      Edit;
      FieldByName('PERIOD').AsString := 'N';
      Post;

      fMensagem('', 'É permitido selecionar até '+ MAX_COLS_PESQUISA.ToString +' colunas para a pesquisa!', ['&Ok']);
    End;

    EnableControls;
  End;
end;

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

    Until FPesquisa.Rows[FCurrRow].Visible;

    pMudaOrdenacao(FPesquisa.Rows[FCurrRow].Name);

    FPesquisa.FocusRow(FPesquisa.Rows[FCurrRow]);

  Except

  End;
End;

Procedure TConfiguraConsulta.pSetaColunasGrid;
  Var
    dbcColuna: TcxGridDBColumn;
Begin
  If Assigned(FColunas) Then
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
    if InterlockedIncrement(intGravandoCarregandoArquivoCfg) = 1 then
    begin
      strArqTemp := fGetFuncoesCxGrid.fCriarArquivoTemporario('',fGetPathTempOpcoesLocais);

      fGetFuncoesCxGrid.fEscreverNoArquivo(strArqTemp, FConfigur.strValor);
      FConsultaView.RestoreFromIniFile(strArqTemp);
      DeleteFile(PChar(strArqTemp));
      InterlockedDecrement(intGravandoCarregandoArquivoCfg);
      Result := Not fEmptyStr(FConfigur.strValor);
    end;

  Except
    On E: Exception Do
    begin
      Result := False;
      InterlockedDecrement(intGravandoCarregandoArquivoCfg);
    end;
  End;

end;

Procedure TConfiguraConsulta.pCarregaCFGEMP(strAutInc, strNomeCFGEMP: String);
Begin
  With FCfgEmp, SQL Do
  Begin
    Close;
    Clear;
    Add('SELECT * FROM ' + strNomeCFGEMP);
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

Procedure TConfiguraConsulta.pCarregaFullText(strFullText: String);
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

Function TConfiguraConsulta.fCampoTemIndiceFullText(strNomCam: String; var strCamposIndiceFullText: string): Boolean;
  Var
    intIndice: Integer;
begin
  Result := False;
  For intIndice := 0 To FstlFullT.Count - 1 Do
    If Pos(strNomCam, FstlFullT[intIndice]) > 0 Then
    begin
      strCamposIndiceFullText := FstlFullT[intIndice];
      Exit(True);
    end;
end;

Function TConfiguraConsulta.fSQLFullText(strNomCam, strFiltro: String): String;
  Var
    intIndice: Integer;
Begin
  Result := '';
  For intIndice := 0 To FstlFullT.Count - 1 Do
    If Pos(strNomCam, FstlFullT[intIndice]) > 0 Then
      Result := ' MATCH (' + FstlFullT[intIndice] + ') AGAINST ( ' + QuotedStr(strFiltro) + ' IN BOOLEAN MODE) ';
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

Function TConfiguraConsulta.fCampoToSubConsulta(strSQL: String;
  blnComAlias: Boolean): String;
  Var
    intIndice: Integer;
Begin
  Result := strSQL;

  If Assigned(FobjConsulta) Then
  With FobjConsulta Do
  Begin
    For intIndice := Low(arrSubCon) To High(arrSubCon) Do
      With arrSubCon[intIndice] Do
      If blnComAlias Then
        Result := StringReplace(Result, strAlias_, strSubSql + ' AS ' + strAlias_, [rfReplaceAll])
      Else
        Result := StringReplace(Result, strAlias_, strSubSql, [rfReplaceAll]);
  End

End;

end.


