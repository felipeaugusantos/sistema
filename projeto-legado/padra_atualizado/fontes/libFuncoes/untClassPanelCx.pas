unit untClassPanelCx;

interface

Uses

  ExtCtrls, Forms, Controls, SysUtils, UniClientDataSet, Classes,
  Variants, DB, cxGridCustomTableView, cxGridDBTableView, Uni,
  MaskUtils, cxStyles, BitBtnLockedIncrem, Vcl.ImgList, System.Types,
  cxGraphics, cxImageComboBox, untTypesSistema, EditFocus, cxEdit, cxExtEditRepositoryItems, dxColorEdit,
  untConstantes, Vcl.Graphics;

Type
  TFuncConfiguraSQLConsulta = Function (objConsulta: Pointer {TDefConsulta}): Boolean Of Object;

  TAtualizar = procedure Of Object;
  TIniciouNavegacaoGridConsulta = procedure of object;
  TParouNavegacaoGridConsulta = procedure of object;
  TPrcAtualizaInformacaoSubConsulta = procedure of object;

  TFunctionTab = Function(cdsConsulta: TUniClientDataSet; DropControl: TControl; RectLinhaGrid: TRect): Boolean Of Object;

  TAfterScroll = Procedure(DataSet: TDataSet);

  TAtualizaAplicacao = Procedure Of Object;

  TOnBeforeListaSelecaoAdd =  Procedure(strValue: String; Var blnAdd: boolean) Of Object;
  TOnAfterListaSelecaoRemove =  Procedure(strValue: String) Of Object;

  TProcedureLista = procedure(stlLista: TStringList) of object;

  TGetStyle = function(AView: TcxGridDBTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; ADataSet: TDataSet): TcxStyle Of Object;

  TOpcoesExportacao = procedure(blnValue: Boolean) of object;

  TAplicaFiltro = procedure(strValue: String) of object;
  TValidaTemFiltro = Procedure Of Object;

  TCamposTotalVenda = record
    edtTotGer: TEditFocus;
    edtSohIPI: TEditFocus;
    edtTotIpi: TEditFocus;
    edtSohST : TEditFocus;
    edtSohFCP: TEditFocus;
    edtTotSer: TEditFocus;
    edtTotImp: TEditFocus;
    edtSohCBS: TEditFocus;
    edtSohIBS: TEditFocus;
    edtSohIS: TEditFocus;
  end;

  TParametrosConsulta = record
    strCodCli,
    strCodCnd,
    strTabPre: String;
  end;

  TprcDisplayText = procedure(Sender: TcxCustomGridTableItem;
                              ARecord: TcxCustomGridRecord;
                              var AText: string) Of Object;


Type
  TPanelCx = Class(TObject)
  private

  public
    blnIgnorarTeclas,
    blnExibirSaldos,
    blnAlternarModoTab: Boolean;
    blnItemDiferenteSimilar,
    blnEstaNoGridSimilar,
    blnConfirmaSimilar: Boolean;
    strSimilar: String;
    strFiltroEspecifico: String;

    sltLista: TStringList;
    stlListaSelecao: TStringList;

    pgcDropControl: TControl;

    prcAtualizar: TAtualizar;
    prcAtualizaAplicacao: TAtualizaAplicacao;
    prcIniciouNavegacaoGridConsulta: TIniciouNavegacaoGridConsulta;
    prcParouNavegacaoGridConsulta: TParouNavegacaoGridConsulta;
    prcAtualizaInformacaoSubConsulta: TPrcAtualizaInformacaoSubConsulta;

    prcLista: TProcedureLista;

    prcValidaTemFiltro: TValidaTemFiltro;

    recParametros:  TParametrosConsulta;

    fncTeclaTab: TFunctionTab;

    blnTemPan: Boolean;  // SE POSSUI UM PAINEL
    blnExpand: Boolean;

    arrNomCam: Array Of String;
    arrRetCam: Array Of Variant;

    frmPanel: TForm;

    intAltTel: Integer;

    strLimpaFiltro: String;

    blnExibeCamposTotalVenda: Boolean;
    CamposTotalVenda: TCamposTotalVenda;
    blnEstaEmAbastecimentoPorDepositoUsandoPrecoLocal: Boolean;

    FOnBeforeListaSelecaoAdd: TOnBeforeListaSelecaoAdd;
    FOnAfterListaSelecaoRemove: TOnAfterListaSelecaoRemove;

    FOnDislplayTextGeneric: TprcDisplayText;

    FSetFornecedorUnicoExportacao: TOpcoesExportacao;

    FAplicaFiltro: TAplicaFiltro;

    FobjConfConsulta: Pointer; //TConfiguraConsulta;

    Constructor Create(blnComPan: Boolean = True); Reintroduce;

    Procedure pCriaForm(NewDockSite: TWinControl; DropControl: TControl;
                        cdsConsulta: TUniClientDataSet;
                        btnConfirma: TBitBtnLocked;
                        cdsSubConsulta: TUniClientDataSet); Virtual; Abstract;

    Procedure pKeyDown(var Key: Word; Shift: TShiftState); Virtual; Abstract;

    Procedure pRetornaValores(cdsConsulta: TUniClientDataSet);

    function fGetSQLPreFiltro(): String; Virtual;

  End;

  TRecMascara = Record
    strCodCam: String;
    prcDisTex: TprcDisplayText;
  End;

  TRecIndexCampo = Record
    strCodCam: String;
    intIndice: Integer;
  End;

  TArrRecMascara = Array Of TRecMascara;

  TArrRecIndexCampo = Array Of TRecIndexCampo;

  TRecCharIgnorado = Record
    strCodCam,
    strCharIg: String;
  End;

  TArrRecCharIgnorado = Array Of TRecCharIgnorado;

  TRecSubConsulta = Record
    strAlias_,
    strSubSql,
    strCamFil,
    strTitulo: String;
  End;

  TArrRecSubConsulta = Array Of TRecSubConsulta;

  TRecTrocaWhere = Record
    intPosWhere: Integer;
    strCampoOriginal,
    strCampoFinal: String;
  End;

  TArrRecTrocaWhere = Array Of TRecTrocaWhere;

  TRecFiltroSimNaoNumerico = Record
    strAlias_,
    strCamFil: String;
  End;

  TArrRecFiltroSimNaoNumerico = Array Of TRecFiltroSimNaoNumerico;


  TRecConflitos = Record
    strNomCam,
    strCamNov: String;
  End;

  TArrRecConflitos = Array Of TRecConflitos;

  TRecFormatDecimais = Record
    strNomCam: String;
    intQtdDec: Integer;
  End;

  TArrRecFormatDecimais = Array Of TRecFormatDecimais;

  TarrCampos = Array Of String;

  TarrCamposDuplo = Array Of Record
                               strCamMsk,
                               strCamCalc: String;
                               prcDisTex: TprcDisplayText;
                             End;

  TRecFiltros = Record
    strNomCam,
    strInfCam: String;
  End;

  TarrFiltros = Array Of TRecFiltros;


  TRecReplaceChar = record
    CharOrigem: string;
    CharDestino: String;
    Campo: String;
  End;

  TarrReplaceChar = Array Of TRecReplaceChar;




  TRecLocalizar = Record
    strNomCam,
    strValCam: String;
  End;

  TTeclaAtalhoParaLimparPesquisa = Record
    blnUsaTeclaAtalho: Boolean;
    strTexto: String;
    Key: Word;
  End;

  TRecIco = Record
    strNomCam: String;
    varValCam: Variant;
    intImaInd: Integer;
    blnDescri: Boolean;
    cxImgList: TImageList;
  End;

  TRecCircle = Record
    strNomCam: String;
    cxImgList: TImageList;
    intCor: Integer;
  End;

  TarrRecIcos = Array Of TRecIco;

  TArrFieldLink = Array of string;

  TArrDrawCircle = Array of TRecCircle;

  TArrTabelas = Array Of Record
    strTabela,
    strAlias: String;
  End;

  TDefConsulta = Class(TObject)
  private
    FBeforeAtualiza: TGenericProcedureWithClientParamAndVar;
    FstrNomCamCor: String;

    procedure pIncluiIdxCampo(strNomCam: String);

    procedure pIncluiCampos(arrCampos: Array Of String;
                            Var arrMskCam: TarrCampos);
    procedure pIncluiCamposIcon(arrCampos: TarrRecIcos;
                                Var arrRecIcon: TarrRecIcos);

    procedure pLimpaArrays;

  public
    strSQLPadrao: String;
    stlNomeColunas: TStringList;

    strMascPlanContabil: String;

    arrTabelas: TArrTabelas;
    ArrFieldLink : TArrFieldLink;

    arrDrawCircle: TArrDrawCircle;

    strAutIncSelCon: String;
    blnSQLConsultaConfigurado: Boolean;
    blnEditandoSQLConsultaConfigurado: Boolean;
    dtsColunasUsuario: TDataSet;

    arrRecMas: TArrRecMascara;
    arrIdxCam: TArrRecIndexCampo;
    arrCharIg: TArrRecCharIgnorado;
    arrSubCon: TArrRecSubConsulta;
    arrTroWhe: TArrRecTrocaWhere;
    arrFilSN_: TArrRecFiltroSimNaoNumerico;
    arrForDec: TArrRecFormatDecimais;
    arrConfli: TarrRecConflitos;
    arrFiltro: TarrFiltros;
    arrReplaceChar: TarrReplaceChar;
    arrRecIco: TarrRecIcos;

    stlCamposComplementares: TStringList;

    arrMskDup: TarrCamposDuplo;

    funcConfiguraConsulta: TFuncConfiguraSQLConsulta;

    recLocalizar: TRecLocalizar;

    recTeclaAtalhoParaLimparPesquisa: TTeclaAtalhoParaLimparPesquisa;

    strChaveConsulta: String;

    strCampoBuscaPalavraExataPorToken: string;
    strCampoBuscaComplementarPorToken: string;

    strSQLRetorno: String;

    arrMskCep: TarrCampos;
    arrForcaContida: TArrCampos;
    arrMskFon: TarrCampos;
    arrMskCnp: TarrCampos;
    arrSimNao: TStringArrayArray;
    arrCamProc: TStringArray;
    arrDisplayGeneric: TarrCampos;

    arrCamBetween: TarrCampos;

    funcGetCellStyle: TGetStyle;
    blnSimilares: Boolean;

    Constructor Create; Reintroduce;
    Destructor Destroy; Override;

    // IMPLEMENTADO NA FERRAMENTA
    procedure pIncluiSubConsulta(strAlias,
                                 strSql: String;
                                 strCampoFiltro: String = '';
                                 strTituloCampo: String = '');

    procedure pIncluiTrocaWhere(intPosWhere: Integer;
                                strCamOri,
                                strCamFin: String);

    Procedure pAdicionaTabela(strNomTab, strAliasTab: String);

    procedure pFormataDecimal(strCampo: String; intDecimais: Integer);

    procedure pIncluiCamposCep(arrCampos: Array Of String);
    procedure pIncluiCamposDisplayGeneric(strCampos:String);
    procedure pIncluiCamposFone(arrCampos: Array Of String);
    procedure pIncluiCamposCNPJ(arrCampos: Array Of String);
    procedure pDisplayCep(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure pDisplayFone(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure pDisplayCNPJ(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure pDisplayData(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure pDisplayCNAE(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure pDisplayLinhaGrupo(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure pDisplayPlanoContas(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure pDisplayPlanoContabil(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure pDisplayPlacaVeiculo(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure pDisplayNumLot(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure pIncluiDefMascara(strNomCam: String; prcDspTxt: TprcDisplayText);
    procedure pIncluiListaForcaContida(strNomCam: String);

    procedure pIncluiDefMascaraDup(strNomCam, strNomCalc: String; prcDspTxt: TprcDisplayText);
    procedure pDisplayCNPJ_CPF(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure pIncluiCampoSimNao(strNomCam: String; arrDescricao: TarrCampos = Nil);
    procedure pIncluiCampoBetween(arrCampos: Array Of String);
    procedure pIncluiCampoBetweenIcon(arrCampos: TarrRecIcos);
    procedure pSetaCarecteresIgnorados(strNomCam, strChar: String);
    procedure pIncluiConflito(strNomCam, strCamNov: String);
    procedure pIncluiIndCampos(arrCampos: Array Of String);
    Function fIdxCampo(strCodCam: String): Integer;
    function fCellBold(AView: TcxGridDBTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; ADataSet: TDataSet): Boolean; virtual;
    function fGetCellStyle(AView: TcxGridDBTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; ADataSet: TDataSet): TcxStyle; virtual;

    function fGetIndexColumnByFieldName(AView: TcxGridDBTableView; AFieldName: String): Integer;

    // ------------------------------------------------------------------------

    // ----------------------------------------

    // DESNECESSÁRIO
    procedure pIncluirFiltroSimNaoNumerico(strAlias, strNomeCampo : String);

    //-----------------------------------------------------------

    // SÓ POR CÓDIGO
    procedure pIncluiCampoProcessado(strNomCam: String);
    procedure pIncluiIcone(strCampo: String; varValor: Variant; intImageIndex: Integer; blnDescription: Boolean = False; cxImageList: TImageList = nil);
    procedure pParametriza(qryConsulta: TUniQuery); Virtual;
    procedure pIncluiFiltro(strCampo, strInfFiltro: String);  // SÓ TEM NA CONSULTA DE PRODUTO
    procedure pIncluiIgnoreChar(ACharOrigem, CharDestino, ACampo: String);

    procedure pConfiguraIcones(cxConsultaView: TcxGridDBTableView; cxImageListDef: TImageList);
    function LocateFieldLink(AFieldName: String): Boolean;
    function LocateDrawCircle(AFieldName: String): Boolean;
    procedure pConfiguraIconeSobEncomenda(cxConsultaView: TcxGridDBTableView);
    procedure pIncluiIconeSobEncomenda(AstrCampo: String; AimlImagens: TImageList; AintCorConfigurada: Integer);
    function fGetRecDrawCircle(AStrCampo: String): TRecCircle;

    procedure pConfiguraColorEdit(cxConsultaView: TcxGridDBTableView);
    property BeforeAtualiza: TGenericProcedureWithClientParamAndVar read FBeforeAtualiza write FBeforeAtualiza ;
    property strNomCampoCor: String read FstrNomCamCor write FstrNomCamCor;
    function fGetReplaceChar(ACampo: string): TRecReplaceChar;

  End;

  TCarregaIcones = Procedure(qryCampos: TUniQuery; objDefConsulta: TDefConsulta);

Var
  prcCarregaIcones: TCarregaIcones;

implementation

uses
  untFuncoesGenerica;

Constructor TDefConsulta.Create;
Begin
  Inherited Create;
  FBeforeAtualiza := Nil ;
  blnSimilares := False;
  strCampoBuscaPalavraExataPorToken := '';
  strCampoBuscaComplementarPorToken := '';
  dtsColunasUsuario := Nil;
  strAutIncSelCon   := '';
  blnSQLConsultaConfigurado := False;
  blnEditandoSQLConsultaConfigurado := False;

  stlCamposComplementares := TStringList.Create;
  stlCamposComplementares.Duplicates := dupIgnore;
  stlCamposComplementares.Sorted := True;

  SetLength(arrTabelas, 0);

  funcGetCellStyle := Nil;

  funcConfiguraConsulta := Nil;

  strSQLRetorno := '';
  FstrNomCamCor := 'CAT_CORCAT';

  stlNomeColunas := TStringList.Create;

  pLimpaArrays;
End;

Destructor TDefConsulta.Destroy;
begin
  pLimpaArrays;

  FreeAndNil(stlNomeColunas);
  FreeAndNil(stlCamposComplementares);

  inherited;
End;

procedure TDefConsulta.pLimpaArrays;
Begin
  SetLength(arrMskDup, 0);
  SetLength(arrRecMas, 0);
  SetLength(arrIdxCam, 0);
  SetLength(arrSubCon, 0);
  SetLength(arrTroWhe, 0);
  SetLength(arrFilSN_, 0);
  SetLength(arrConfli, 0);
  SetLength(arrFiltro, 0);
  SetLength(arrReplaceChar, 0);
  SetLength(arrForDec, 0);
  SetLength(arrMskCep, 0);
  SetLength(arrMskFon, 0);
  SetLength(arrRecIco, 0);
  SetLength(arrCharIg, 0);
  SetLength(arrCamBetween, 0);
  SetLength(arrDisplayGeneric, 0);
End;

procedure TDefConsulta.pParametriza(qryConsulta: TUniQuery);
Begin

End;

Procedure TDefConsulta.pAdicionaTabela(strNomTab, strAliasTab: String);
Begin
  SetLength(arrTabelas, Succ(Length(arrTabelas)));
  With arrTabelas[High(arrTabelas)] Do
  Begin
    strTabela := strNomTab;
    strAlias  := strAliasTab;
  End;
End;

procedure TDefConsulta.pIncluiIcone(strCampo: String; varValor: Variant; intImageIndex: Integer;
  blnDescription: Boolean = False; cxImageList: TImageList = nil);
Begin
  SetLength(arrRecIco, Succ(Length(arrRecIco)));
  With arrRecIco[High(arrRecIco)] Do
  Begin
    strNomCam := strCampo;
    varValCam := varValor;
    intImaInd := intImageIndex;
    blnDescri := blnDescription;
    cxImgList := cxImageList;
  End;
End;

procedure TDefConsulta.pIncluiIconeSobEncomenda(AstrCampo: String; AimlImagens: TImageList; AintCorConfigurada: Integer);
begin
  SetLength(arrDrawCircle, Succ(Length(arrDrawCircle)));
  With arrDrawCircle[High(arrDrawCircle)] Do
  Begin
    strNomCam := AstrCampo;
    cxImgList := AimlImagens;
    intCor := AintCorConfigurada;
  End;
end;

procedure TDefConsulta.pConfiguraColorEdit(cxConsultaView: TcxGridDBTableView);
Var
  coluna: TcxGridDBColumn;
Begin
  coluna := cxConsultaView.GetColumnByFieldName(FstrNomCamCor);

  If Assigned(coluna) Then
    With coluna Do
    begin
      Visible         := True;
      Width           := 70;
      Options.Editing := False;
      PropertiesClass := TdxColorEditProperties;
    End;

End;

procedure TDefConsulta.pConfiguraIcones(cxConsultaView: TcxGridDBTableView; cxImageListDef: TImageList);
  Var
    intIndice: Integer;
    intIndice2: Integer;
    item: TcxImageComboBoxItem;
    coluna: TcxGridDBColumn;
Begin
  For intIndice := Low(arrRecIco) To High(arrRecIco) Do
  begin
    coluna := cxConsultaView.GetColumnByFieldName(arrRecIco[intIndice].strNomCam);

    If Assigned(coluna) Then
    begin
      coluna.Width           := 25;
      coluna.Index           := 0;
      coluna.SortIndex       := -1;
      coluna.Options.Editing := False;

      If Not SameText(coluna.PropertiesClassName, 'TcxImageComboBoxProperties') Then
      Begin
        coluna.PropertiesClass := TcxImageComboBoxProperties;

        For intIndice2 := intIndice To High(arrRecIco) Do
        begin
          If arrRecIco[intIndice2].strNomCam <> arrRecIco[intIndice].strNomCam Then
            Break;

          If arrRecIco[intIndice2].cxImgList = nil Then
            TcxImageComboBoxProperties(coluna.Properties).Images := cxImageListDef
          Else
            TcxImageComboBoxProperties(coluna.Properties).Images := arrRecIco[intIndice2].cxImgList;

          item := TcxImageComboBoxProperties(coluna.Properties).Items.Add;
          item.ImageIndex := arrRecIco[intIndice2].intImaInd;
          item.Value      := arrRecIco[intIndice2].varValCam;

          If arrRecIco[intIndice].blnDescri Then
            item.Description := item.Value;
        end;
      End;
    end;
  end;
End;

procedure TDefConsulta.pConfiguraIconeSobEncomenda(cxConsultaView: TcxGridDBTableView);
var
  item: TcxImageComboBoxItem;
  intIndice: Integer;
  cxColuna: TcxGridDBColumn;
  recCir: TRecCircle;
begin
  For intIndice := Low(arrDrawCircle) To High(arrDrawCircle) Do
  begin
    cxColuna := cxConsultaView.GetColumnByFieldName(arrDrawCircle[intIndice].strNomCam);

    If Assigned(cxColuna) Then
    Begin
      cxColuna.PropertiesClass := TcxImageComboBoxProperties;
      cxColuna.Width           := 100;
      cxColuna.Index           := 0;
      cxColuna.SortIndex       := -1;
      cxColuna.Options.Editing := False;

      recCir := fGetRecDrawCircle(cxColuna.DataBinding.FieldName);

      TcxImageComboBoxProperties(cxColuna.Properties).Images := recCir.cxImgList;

      item := TcxImageComboBoxProperties(cxColuna.Properties).Items.Add;
      Case recCir.intCor Of
        clBlack: item.ImageIndex := 0;
        clFuchsia: item.ImageIndex := 3;
        clBlue: item.ImageIndex := 1;
        clPurple: item.ImageIndex := 4;
        clRed: item.ImageIndex := 5;
        clGreen: item.ImageIndex := 2;
      End;
      item.Value := 'SIM';
    End;
  End;
end;

procedure TDefConsulta.pIncluiFiltro(strCampo, strInfFiltro: String);
Begin
  SetLength(arrFiltro, Succ(Length(arrFiltro)));
  With arrFiltro[High(arrFiltro)] Do
  Begin
    strNomCam := strCampo;
    strInfCam := strInfFiltro;
  End;
End;

procedure TDefConsulta.pIncluiIgnoreChar(ACharOrigem, CharDestino, ACampo: String);
Begin
  SetLength(arrReplaceChar, Succ(Length(arrReplaceChar)));
  With arrReplaceChar[High(arrReplaceChar)] Do
  Begin
    CharOrigem  := ACharOrigem;
    CharDestino := CharDestino;
    Campo := ACampo;
  End;
End;


procedure TDefConsulta.pFormataDecimal(strCampo: String; intDecimais: Integer);
Begin
  SetLength(arrForDec, Succ(Length(arrForDec)));
  With arrForDec[High(arrForDec)] Do
  Begin
    strNomCam := strCampo;
    intQtdDec := intDecimais;
  End;
End;

procedure TDefConsulta.pIncluiConflito(strNomCam, strCamNov: String);
Begin
  SetLength(arrConfli, Succ(Length(arrConfli)));
  arrConfli[High(arrConfli)].strNomCam := strNomCam;
  arrConfli[High(arrConfli)].strCamNov := strCamNov;
End;

Function TDefConsulta.fIdxCampo(strCodCam: String): Integer;
  Var
    intIndice: Integer;
Begin
  Result := -1;

  For intIndice := Low(arrIdxCam) To High(arrIdxCam) Do
    If SameText(arrIdxCam[intIndice].strCodCam, strCodCam) Then
    Begin
      Result := arrIdxCam[intIndice].intIndice;
      Break;
    End;
End;

function TDefConsulta.LocateDrawCircle(AFieldName: String): Boolean;
var
  recCir: TRecCircle;
begin
  Result := false;
  For recCir in arrDrawCircle do
    If recCir.strNomCam =  AFieldName Then
      Exit(True);
end;

function TDefConsulta.LocateFieldLink(AFieldName: String): Boolean;
var strFieldLink: string;
begin
  Result := false;
  For strFieldLink in ArrFieldLink do
    If strFieldLink =  AFieldName Then
      Exit(True);
end;

procedure TDefConsulta.pIncluiIndCampos(arrCampos: Array Of String);
  Var
    intIndice: Integer;
Begin
  For intIndice := Low(arrCampos) To High(arrCampos) Do
  Begin
    pIncluiIdxCampo(arrCampos[intIndice]);
    {**************************************************************************************************************}
    {* NÃO ESTAVA FORMATANDO CORRETAMENTE O CPF/CNPJ.                                                             *}
    {* ADICIONADO PARA QUE OS CAMPOS DE CONTROLE SEJAM CONSIDERADOS NO RETORNO DA FUNÇÃO: fIdxCampo('CLI_CGCCPF');*}
    {* REQ: 193733                                                                                                *}
    {***********************************************************************************************************RN*}
    if (Assigned(stlCamposComplementares)) And (stlCamposComplementares.IndexOf(arrCampos[intIndice]) < 0) then
      stlCamposComplementares.Add(arrCampos[intIndice]);
  End;
End;

procedure TDefConsulta.pIncluirFiltroSimNaoNumerico(strAlias, strNomeCampo: String);
begin
  SetLength(arrFilSN_, Succ(Length(arrFilSN_)));

  With arrFilSN_[High(arrFilSN_)] Do
  Begin
    strAlias_ := strAlias;
    strCamFil := strNomeCampo;
  End;

end;

procedure TDefConsulta.pIncluiIdxCampo(strNomCam: String);
Begin
  SetLength(arrIdxCam, Succ(Length(arrIdxCam)));
  With arrIdxCam[High(arrIdxCam)] Do
  Begin
    strCodCam := strNomCam;
    intIndice := 0;
  End;
End;

procedure TDefConsulta.pSetaCarecteresIgnorados(strNomCam, strChar: String);
  Var
    intContador: Integer;
Begin
  For intContador := Low(arrCharIg) To High(arrCharIg) Do
    If SameText(arrCharIg[intContador].strCodCam, strNomCam) Then
    Begin
      arrCharIg[intContador].strCharIg := strChar;
      Exit;
    End;

  SetLength(arrCharIg, Succ(Length(arrCharIg)));
  With arrCharIg[High(arrCharIg)] Do
  Begin
    strCodCam := strNomCam;
    strCharIg := strChar;
  End;
End;

procedure TDefConsulta.pIncluiCampos(arrCampos: Array Of String;
                                     Var arrMskCam: TarrCampos);
  Var
    intIndice: Integer;
Begin
  SetLength(arrMskCam, Length(arrCampos));
  For intIndice := Low(arrCampos) To High(arrCampos) Do
    arrMskCam[intIndice] := arrCampos[intIndice];
End;

procedure TDefConsulta.pIncluiCamposIcon(arrCampos: TarrRecIcos;
                                     Var arrRecIcon: TarrRecIcos);
  Var
    intIndice: Integer;
Begin
  SetLength(arrRecIcon, Length(arrCampos));
  For intIndice := Low(arrCampos) To High(arrCampos) Do
    arrRecIcon[intIndice] := arrCampos[intIndice];
End;

procedure TDefConsulta.pIncluiCamposCep(arrCampos: Array Of String);
Begin
  pIncluiCampos(arrCampos, arrMskCep);
End;

procedure TDefConsulta.pIncluiCamposDisplayGeneric(strCampos:String);
var intIndex : Integer;
Begin
  intIndex := Length(arrDisplayGeneric) + 1;
  If intIndex = 0 Then
    intIndex := 1;
  SetLength(arrDisplayGeneric, intIndex);
  arrDisplayGeneric[intIndex -1] := strCampos;
End;


procedure TDefConsulta.pIncluiCamposFone(arrCampos: Array Of String);
Begin
  pIncluiCampos(arrCampos, arrMskFon);
End;

procedure TDefConsulta.pIncluiCampoSimNao(strNomCam: String; arrDescricao: TarrCampos = Nil);
  Var
    intIndex: Integer;
begin
  If arrDescricao <> Nil Then
    intIndex := Length(arrDescricao) + 1
  Else
    intIndex := 1;

  SetLength(arrSimNao, Succ(Length(arrSimNao)));   //adiciona uma linha na matriz
  SetLength(arrSimNao[High(arrSimNao)], intIndex); //adiciona uma coluna na última linha da matriz

  arrSimNao[High(arrSimNao)][0] := strNomCam;

  For intIndex := Low(arrDescricao) To High(arrDescricao) Do
    arrSimNao[High(arrSimNao)][intIndex+1] := arrDescricao[intIndex];
end;

procedure TDefConsulta.pIncluiCampoBetween(arrCampos: Array Of String);
begin
  pIncluiCampos(arrCampos, arrCamBetween);
end;

procedure TDefConsulta.pIncluiCampoBetweenIcon(arrCampos: TarrRecIcos);
begin
  pIncluiCamposIcon(arrCampos, arrRecIco);
end;

procedure TDefConsulta.pIncluiCampoProcessado(strNomCam: String);
begin
  SetLength(arrCamProc, Succ(Length(arrCamProc)));
  arrCamProc[High(arrCamProc)] := strNomCam;
end;

procedure TDefConsulta.pIncluiCamposCNPJ(arrCampos: Array Of String);
Begin
  pIncluiCampos(arrCampos, arrMskCnp);
End;

procedure TDefConsulta.pIncluiSubConsulta(strAlias,
                                          strSql: String;
                                          strCampoFiltro: String = '';
                                          strTituloCampo: String = '');
  Var
    intIndice: Integer;
    intContador: Integer;
Begin
  intIndice := -1;

  strSql := Trim(strSql);

  If Not strSQL.StartsWith('(') Then
    strSql := '(' + strSql + ')';

  For intContador := Low(arrSubCon) To High(arrSubCon) Do
    If SameText(arrSubCon[intContador].strAlias_, strAlias) Then
    Begin
      intIndice := intContador;
      Break;
    End;

  If intIndice = -1 Then
  Begin
    SetLength(arrSubCon, Succ(Length(arrSubCon)));
    intIndice := High(arrSubCon);
  End;

  With arrSubCon[intIndice] Do
  Begin
    strAlias_ := strAlias;
    strSubSql := strSql;
    strCamFil := strCampoFiltro;
    strTitulo := strTituloCampo;
  End;
End;

procedure TDefConsulta.pIncluiTrocaWhere(intPosWhere: Integer;
                                         strCamOri,
                                         strCamFin: String);
  Var
    intIndice: Integer;
    intContador: Integer;
Begin
  For intContador := Low(arrTroWhe) To High(arrTroWhe) Do
    If (arrTroWhe[intContador].intPosWhere = intPosWhere) And
       SameText(arrTroWhe[intContador].strCampoOriginal, strCamOri) Then
      Exit;

  SetLength(arrTroWhe, Succ(Length(arrTroWhe)));
  intIndice := High(arrTroWhe);

  arrTroWhe[intIndice].intPosWhere      := intPosWhere;
  arrTroWhe[intIndice].strCampoOriginal := strCamOri;
  arrTroWhe[intIndice].strCampoFinal    := strCamFin;
End;

procedure TDefConsulta.pIncluiDefMascara(strNomCam: String; prcDspTxt: TprcDisplayText);
Begin
  SetLength(arrRecMas, Succ(Length(arrRecMas)));
  With arrRecMas[High(arrRecMas)] Do
  Begin
    strCodCam := strNomCam;
    prcDisTex := prcDspTxt;
  End;
End;

procedure TDefConsulta.pIncluiListaForcaContida(strNomCam: String);
Begin
  SetLength(arrForcaContida, Succ(Length(arrForcaContida)));
  arrForcaContida[High(arrForcaContida)] := strNomCam
End;

procedure TDefConsulta.pIncluiDefMascaraDup(strNomCam, strNomCalc: String; prcDspTxt: TprcDisplayText);
  Var
    intContador: Integer;
Begin
  For intContador := Low(arrMskDup) To High(arrMskDup) Do
    If SameText(arrMskDup[intContador].strCamMsk, strNomCam) Then
    Begin
      arrMskDup[intContador].strCamCalc := strNomCalc;
      arrMskDup[intContador].prcDisTex  := prcDspTxt;
      Exit;
    End;

  SetLength(arrMskDup, Succ(Length(arrMskDup)));
  With arrMskDup[High(arrMskDup)] Do
  Begin
    strCamMsk  := strNomCam;
    strCamCalc := strNomCalc;
    prcDisTex  := prcDspTxt;
  End;
End;

procedure TDefConsulta.pDisplayCep(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  AText := FormatMaskText('99999-999;0;', AText)
end;

procedure TDefConsulta.pDisplayFone(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  AText := fFormataFone(AText);
end;

procedure TDefConsulta.pDisplayCNPJ_CPF(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);

begin
  If Sender.Tag > ARecord.ValueCount - 1 Then
    Exit;

  If VarToStr(ARecord.Values[Sender.Tag]) = '1' Then
    AText := FormatMaskText(fRetMascaraC_G_C_(fSetaPais, C_G_C_), AText)
  Else
    AText := FormatMaskText(fRetMascaraC_G_C_(fSetaPais, C_P_F_), AText);
end;

function TDefConsulta.fCellBold(AView: TcxGridDBTableView;
  ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem;
  ADataSet: TDataSet): Boolean;
begin
  Result := False;
end;

function TDefConsulta.fGetIndexColumnByFieldName(AView: TcxGridDBTableView; AFieldName: String): Integer;
  Var
    cxColuna: TcxGridDBColumn;
Begin
  Result := -1;

  cxColuna := AView.GetColumnByFieldName(AFieldName);

  If Assigned(cxColuna) Then
    Result := AView.GetColumnByFieldName(AFieldName).Index;
End;

function TDefConsulta.fGetRecDrawCircle(AStrCampo: String): TRecCircle;
var
  recCir: TRecCircle;
begin
  For recCir in arrDrawCircle do
    If recCir.strNomCam = AStrCampo Then
      Exit(recCir);
end;

function TDefConsulta.fGetReplaceChar(ACampo: string): TRecReplaceChar;
var
  i:TRecReplaceChar;
begin
  Result.Campo := '';
  for i in arrReplaceChar do
  begin
    If i.Campo = ACampo Then
    begin
       Result := i;
       Exit;
    End;
  End;
end;

//sobrescrever este metodo para definir o estilo das celulas (fonte, cor, etc...)
function TDefConsulta.fGetCellStyle(AView: TcxGridDBTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; ADataSet: TDataSet): TcxStyle;
begin
  If Assigned(funcGetCellStyle) Then
    Result := funcGetCellStyle(AView, ARecord, AItem, ADataSet)
  Else
    Result := Nil;
end;

procedure TDefConsulta.pDisplayCNPJ(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
begin
  AText := FormatMaskText(fRetMascaraC_G_C_(fSetaPais, C_G_C_), AText)
end;

procedure TDefConsulta.pDisplayData(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  AText := FormatMaskText('99/99/9999;0;', AText)
end;

procedure TDefConsulta.pDisplayCNAE(Sender: TcxCustomGridTableItem;
                                      ARecord: TcxCustomGridRecord;
                                    var AText: string);
begin
  AText := FormatMaskText('9999-9/99;0;_', AText);
end;

procedure TDefConsulta.pDisplayLinhaGrupo(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  AText := FormatMaskText('999.999;0;', AText)
end;

procedure TDefConsulta.pDisplayPlanoContas(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  AText := FormatMaskText('99.99.999;0;', AText)
end;

procedure TDefConsulta.pDisplayPlanoContabil(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  AText := FormatMaskText(strMascPlanContabil, AText);
end;

procedure TDefConsulta.pDisplayPlacaVeiculo(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  AText := FormatMaskText('999-9999;0;', AText)
end;

procedure TDefConsulta.pDisplayNumLot(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
begin
  AText := FormatMaskText('999999-999;0;', AText);
end;

Constructor TPanelCx.Create(blnComPan: Boolean = True);
Begin
  Inherited Create;

  blnExibeCamposTotalVenda   := False;
  CamposTotalVenda.edtTotGer := Nil;
  CamposTotalVenda.edtSohIPI := Nil;
  CamposTotalVenda.edtTotIpi := Nil;
  CamposTotalVenda.edtSohST  := Nil;
  CamposTotalVenda.edtSohFCP := Nil;
  CamposTotalVenda.edtSohCBS := Nil;
  CamposTotalVenda.edtSohIBS := Nil;
  CamposTotalVenda.edtSohIS := Nil;
  CamposTotalVenda.edtTotSer := Nil;
  CamposTotalVenda.edtTotImp := Nil;

  blnEstaNoGridSimilar := False;
  blnIgnorarTeclas := False;
  prcIniciouNavegacaoGridConsulta := nil;
  prcParouNavegacaoGridConsulta := nil;
  prcAtualizaInformacaoSubConsulta := Nil;
  prcAtualizar := Nil;
  prcLista := Nil;
  fncTeclaTab := Nil;
  FOnBeforeListaSelecaoAdd := Nil;
  FOnDislplayTextGeneric := nil;

  SetLength(arrNomCam, 0);
  blnTemPan := blnComPan;
  strSimilar     := '';
  strFiltroEspecifico:= '';
  strLimpaFiltro := '';
  sltLista   := Nil;
  blnEstaEmAbastecimentoPorDepositoUsandoPrecoLocal := False;
End;

function TPanelCx.fGetSQLPreFiltro: String;
begin
  Result := '';
end;

Procedure TPanelCx.pRetornaValores(cdsConsulta: TUniClientDataSet);
  Var
    intIndice: Integer;
Begin
  If (Length(arrNomCam) > 0) And
     (Not cdsConsulta.IsEmpty) Then
  With cdsConsulta Do
  Begin
    SetLength(arrRetCam, Length(arrNomCam));

    For intIndice := Low(arrNomCam) To High(arrNomCam) Do
      arrRetCam[intIndice] := FieldByName(arrNomCam[intIndice]).Value;

  End
  Else
    arrRetCam := Nil;
End;

initialization

  prcCarregaIcones := Nil;


end.

