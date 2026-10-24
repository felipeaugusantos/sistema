unit untFrameAlteraPrecoIndividual;

interface

uses
  cxGridDBDataDefinitions,
  cxVariants,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridBandedTableView, cxGridDBBandedTableView, cxGrid, Uni, cxDataUtils,
  System.Types, System.StrUtils, untConsultas, untController.CheckListGarantia, untTGerenciaColunaGrid, cxGridDBTableView,
  Vcl.StdCtrls, cxContainer, dxCore;

type
  TCampo = Record
    Title,
    FieldName: String;
    ReadOnly,
    Visible: Boolean;
    Properties: TcxCustomEditProperties;
    blnTemDescricao : Boolean;
    blnCampoDescricao: Boolean;
  End;

  TArrCampos = Array Of TCampo;

  TPosicaoRegistro = record
    intRecordIndex,
    intPosition: Integer;
  end;

  TPosicaoRegistroPrt = ^TPosicaoRegistro;

  TcxGridDBDataController = class (cxGridDBDataDefinitions.TcxGridDBDataController)
  Private

     Procedure SetOrdenar(Value: Boolean);
     Function GetOrdenar: Boolean;

  protected

  property
    blnOrdenar: Boolean Read GetOrdenar Write SetOrdenar;
  end;

  TMycxCustomDataControllerInfo = class (TcxCustomDataControllerInfo)
  protected
    procedure DoSort; override;
  public
    blnOrdenar: Boolean;
  end;

  TFrameAlteraPrecoIndividual = class(TFrame)
    cxgTiposAlt: TcxGrid;
    cxvTiposAlt: TcxGridDBBandedTableView;
    cxgTiposAltLevel1: TcxGridLevel;
    cxvTiposAltColumn1: TcxGridDBBandedColumn;
    chkSuspendeOrdenacao: TCheckBox;
    procedure cxvTiposAltCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxvTiposAltEditKeyPress(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Char);
    procedure cxvTiposAltEditKeyDown(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Word;
      Shift: TShiftState);
    procedure cxvTiposAltKeyPress(Sender: TObject; var Key: Char);
    procedure cxvTiposAltColumnSizeChanged(Sender: TcxGridTableView;
      AColumn: TcxGridColumn);
    procedure cxvTiposAltBandSizeChanged(Sender: TcxGridBandedTableView;
      ABand: TcxGridBand);
    procedure chkSuspendeOrdenacaoClick(Sender: TObject);
    procedure cxvTiposAltDataControllerCompare(
      ADataController: TcxCustomDataController; ARecordIndex1, ARecordIndex2,
      AItemIndex: Integer; const V1, V2: Variant; var Compare: Integer);
  private
    FqryDados: TUniQuery;
    function fTemConsultaTabela(strNomCam: String): Boolean;
    function fRetDesAbfPisCofIpi(strTabela, strCod: String): String;

    { Private declarations }

  protected
    blnVidroInteiro: Boolean;
    frmPai: TForm;
    arrCampos: TArrCampos;
    function fGetPositionByRecordIndex(ARecordIndex: Integer): Integer;

  public
    GerenciaColunaGrid: TGerenciaColunaGrid;
    blnProcessoConfirmacao: Boolean;
    lstOrdemResgistros: TList;
    procedure pSalvaOrdenacao;
    procedure pLiberaOrdenacao;
    procedure pCarregaPosicionamento;
    Function fRetDescricaoCadastro(strNomCam, strCodCad: String; blnValidar: Boolean; Var blnErro: Boolean): String;
    function fRetCampoDesc(strField: string): TCampo;
    { Public declarations }
    Class Function fCriaFrameAlteraPrecoIndividual(frmDestino: TForm;
                                                   AarrCampos: TArrCampos;
                                                   ControlAlloc: TWinControl;
                                                   AQryDados: TUniQuery): TFrameAlteraPrecoIndividual;

  end;

implementation

{$R *.dfm}

uses untPai, untTypesSistema, untFuncoesSimples;

{ TFrameAlteraPrecoIndividual }

class function TFrameAlteraPrecoIndividual.fCriaFrameAlteraPrecoIndividual(
  frmDestino: TForm;
  AarrCampos: TArrCampos;
  ControlAlloc: TWinControl;
  AQryDados: TUniQuery): TFrameAlteraPrecoIndividual;
begin
  Result := TFrameAlteraPrecoIndividual.Create(frmDestino);
  Result.blnProcessoConfirmacao := False;
  Result.frmPai    := frmDestino;
  Result.arrCampos := AarrCampos;
  Result.Parent    := ControlAlloc;

  Result.blnVidroInteiro := (fCfgSis('VENVID', varBoolean)) And (Not fCfgSis('DECVID', varBoolean));

  Result.FQryDados := AQryDados;
  Result.Top       := 0;
  Result.TabOrder  := 0;
  Result.lstOrdemResgistros := TList.Create;
  Result.GerenciaColunaGrid := TGerenciaColunaGrid.Create(strLoginUsuarioLogado, 'TFrameAlteraPrecoIndividual', TcxGridDBTableView(Result.cxvTiposAlt), False);
//  Result.cxvTiposAlt.DataController.DataSource := ADtsDados;
end;


procedure TFrameAlteraPrecoIndividual.chkSuspendeOrdenacaoClick(
  Sender: TObject);
begin
  If chkSuspendeOrdenacao.Checked Then
    pSalvaOrdenacao;

  TcxGridDBDataController(cxvTiposAlt.DataController).blnOrdenar := False;

  cxvTiposAlt.DataController.Refresh;

  If Not chkSuspendeOrdenacao.Checked Then
    pSalvaOrdenacao;

end;

procedure TFrameAlteraPrecoIndividual.cxvTiposAltBandSizeChanged(
  Sender: TcxGridBandedTableView; ABand: TcxGridBand);
  var i: integer;
begin
  For i := 0 To ABand.ColumnCount -1 do
  Begin
    GerenciaColunaGrid.pSalvaColuna(ABand.Columns[i], ABand.ColumnCount =1,  ABand.Width);
  End
end;

procedure TFrameAlteraPrecoIndividual.cxvTiposAltColumnSizeChanged(
  Sender: TcxGridTableView; AColumn: TcxGridColumn);
  var  ABand: TcxGridBand;
       i: integer;
begin
  ABand := TcxGridDBBandedColumn(AColumn).Position.Band;
  For i := 0 To ABand.ColumnCount -1 do
   GerenciaColunaGrid.pSalvaColuna(ABand.Columns[i], ABand.ColumnCount =1,  ABand.Width);
end;

procedure TFrameAlteraPrecoIndividual.cxvTiposAltCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If blnProcessoConfirmacao Then
  Begin

    If Pos('nov', LowerCase(TcxGridDBBandedColumn(AViewInfo.Item).DataBinding.FieldName)) > 0 Then
    Begin
      ACanvas.Brush.Color := clSilver;
    End;

  End

end;

procedure TFrameAlteraPrecoIndividual.cxvTiposAltDataControllerCompare(
  ADataController: TcxCustomDataController; ARecordIndex1, ARecordIndex2,
  AItemIndex: Integer; const V1, V2: Variant; var Compare: Integer);
var
   intPosition1, intPosition2: Integer;
begin

  If chkSuspendeOrdenacao.Checked  then
  Begin

    intPosition1 := fGetPositionByRecordIndex(ARecordIndex1);
    intPosition2 := fGetPositionByRecordIndex(ARecordIndex2);

    If cxvTiposAlt.SortedItems[0].SortOrder = soAscending Then
      Compare := VarCompare(intPosition1, intPosition2)
    Else
      Compare := VarCompare(intPosition2, intPosition1);

  End Else
  Begin

    Compare := VarCompare(V1, V2);

  End;


end;

procedure TFrameAlteraPrecoIndividual.cxvTiposAltEditKeyPress(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Char);
begin
  inherited;
  cxvTiposAltKeyPress(Sender, Key);
end;


procedure TFrameAlteraPrecoIndividual.cxvTiposAltEditKeyDown(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_Return: If FqryDados.State = dsEdit Then
                 FqryDados.Post;
  End;

end;


procedure TFrameAlteraPrecoIndividual.cxvTiposAltKeyPress(Sender: TObject;
  var Key: Char);
 Var
    qryDados: TUniQuery;
    arrSelecao: TConsultasArray;
    strNomCam: String;
    strDescricao: string;
    campo: TCampo;
    Error: Boolean;

  Procedure pSalva(strDado: String);
  Begin
    Key := #0;
    Error := False;
    strDescricao := fRetDescricaoCadastro(strNomCam, strDado, True, Error);

    If (strDescricao <> '') And (TcxGridDBBandedColumn(cxvTiposAlt.Controller.FocusedColumn).DataBinding.FieldName <> '') Then
    Begin
      campo := fRetCampoDesc(TcxGridDBBandedColumn(cxvTiposAlt.Controller.FocusedColumn).DataBinding.FieldName);
      If (campo.FieldName <> '') And (  Not (campo.FieldName = TcxGridDBBandedColumn(cxvTiposAlt.Controller.FocusedColumn).DataBinding.FieldName)) Then
      Begin
        If Not (FqryDados.State in dsEditModes) Then
          FqryDados.Edit;

        FqryDados.FieldByName(campo.FieldName).AsString := strDescricao;
        cxvTiposAlt.DataController.SetEditValue(cxvTiposAlt.Controller.FocusedColumn.Index, strDado, evsValue);
      End;
    end;
  End;

begin
  inherited;
  If Assigned(cxvTiposAlt.Controller.FocusedColumn) Then
  Begin
    If Assigned(TcxGridDBBandedColumn(cxvTiposAlt.Controller.FocusedColumn).DataBinding) Then
      strNomCam := TcxGridDBBandedColumn(cxvTiposAlt.Controller.FocusedColumn).DataBinding.FieldName;
  End;

  If AnsiEndsStr('_NOV', strNomCam) Then
    strNomCam := AnsiReplaceStr(strNomCam, '_NOV', '');

  If blnVidroInteiro And
     (Pos(strNomCam, 'ITE_LARVID_ITE_ALTVID_ITE_LAMAVI_ITE_ALMAVI') > 0) And
     CharInSet(Key, [',','.','-']) Then
  Begin
    Key := #0;
    Exit;
  End;

  If fEntraCons(Key) Then
  Begin

    With cxvTiposAlt.DataController.DataSource.DataSet Do
    If fTemConsultaTabela(strNomCam) Then
    Begin


      qryDados := fCriaQuery;


      If SameText(strNomCam, 'ITE_CODFOR') And
         fPesqFornecedor(conForSimples, frmPai, Nil, Nil, qryDados, Key, arrSelecao, True) And
         (Not fEmptyStr(qryDados.FieldByName('FOR_CODFOR').AsString)) Then
      Begin


        pSalva(qryDados.FieldByName('FOR_CODFOR').AsString);

      End

      Else If SameText(strNomCam, 'ITE_CODGPR') And
              fPesqGrupoPrecos(frmPai, Nil, Nil, qryDados, Key, arrSelecao) And
              (Not fEmptyStr(qryDados.FieldByName('GPR_CODIGO').AsString)) Then
      Begin

        pSalva
        (qryDados.FieldByName('GPR_CODIGO').AsString);

      End

      Else If SameText(strNomCam, 'ITE_PRDGRU') And
              fPesqGrupoProduto(frmPai, Nil, Nil, qryDados, Key, arrSelecao) And
              (Not fEmptyStr(qryDados.FieldByName('PRD_CODGRU').AsString)) Then
      Begin

        pSalva(qryDados.FieldByName('PRD_CODGRU').AsString);

      End

      Else If SameText(strNomCam, 'ITE_CODABF') And
              fPesqAbrevFiscal(frmPai, Nil, Nil, qryDados, Key, arrSelecao) And
              (Not fEmptyStr(qryDados.FieldByName('ABF_CODABF').AsString)) Then
      Begin

        pSalva(qryDados.FieldByName('ABF_CODABF').AsString);

      End

      Else If SameText(strNomCam, 'ITE_ABFPIS') And
              fPesqPISSAI(frmPai, Nil, Nil, qryDados, Key, arrSelecao) And
              (Not fEmptyStr(qryDados.FieldByName('APC_CODAPC').AsString)) Then
      Begin

        pSalva(qryDados.FieldByName('APC_CODAPC').AsString);

      End

      Else If SameText(strNomCam, 'ITE_ABFCOF') And
              fPesqCOFSAI(frmPai, Nil, Nil, qryDados, Key, arrSelecao) And
              (Not fEmptyStr(qryDados.FieldByName('APC_CODAPC').AsString)) Then
      Begin

        pSalva(qryDados.FieldByName('APC_CODAPC').AsString);

      End

      Else If SameText(strNomCam, 'ITE_ABFIPI') And
              fPesqIPISAI(frmPai, Nil, qryDados, Key, arrSelecao) And
              (Not fEmptyStr(qryDados.FieldByName('APC_CODAPC').AsString)) Then
      Begin

        pSalva(qryDados.FieldByName('APC_CODAPC').AsString);

      End

      Else If SameText(strNomCam, 'ITE_CODMAR') And
              fPesqMarcas(frmPai, Nil, nil, qryDados, Key, arrSelecao) And
              (Not fEmptyStr(qryDados.FieldByName('MAR_CODMAR').AsString)) Then
      Begin

        pSalva(qryDados.FieldByName('MAR_CODMAR').AsString);

      End

      Else If SameText(strNomCam, 'ITE_SITPRO') And
              fPesqSituacaoProduto(frmPai, Nil, nil, qryDados, Key, arrSelecao) And
              (Not fEmptyStr(qryDados.FieldByName('SIT_CODIGO').AsString)) Then
      Begin

        pSalva(qryDados.FieldByName('SIT_CODIGO').AsString);

      End

      Else If SameText(strNomCam, 'ITE_CODMON') And
              fPesqMontadora(frmPai, Nil, nil, qryDados, Key, arrSelecao) And
              (Not fEmptyStr(qryDados.FieldByName('MON_CODMON').AsString)) Then
      Begin

        pSalva(qryDados.FieldByName('MON_CODMON').AsString);

      End

      Else If SameText(strNomCam, 'ITE_CODUNI') And
              fPesqUnidade(frmPai, Nil, nil, nil, qryDados, Key, arrSelecao) And
              (Not fEmptyStr(qryDados.FieldByName('UNI_CODUNI').AsString)) Then
      Begin

        pSalva(qryDados.FieldByName('UNI_CODUNI').AsString);

      End

      Else If SameText(strNomCam, 'ITE_UNICOM') And
              fPesqUnidade(frmPai, Nil, nil, nil, qryDados, Key, arrSelecao) And
              (Not fEmptyStr(qryDados.FieldByName('UNI_CODUNI').AsString)) Then
      Begin

        pSalva(qryDados.FieldByName('UNI_CODUNI').AsString);

      End

      Else If SameText(strNomCam, 'ITE_UNITRI') And
              fPesqUnidade(frmPai, Nil, nil, nil, qryDados, Key, arrSelecao) And
              (Not fEmptyStr(qryDados.FieldByName('UNI_CODUNI').AsString)) Then
      Begin

        pSalva(qryDados.FieldByName('UNI_CODUNI').AsString);

      End

      Else If SameText(strNomCam, 'ITE_CODGRU') And
              fPesqGrupo(frmPai, Nil, nil, qryDados, Key, arrSelecao) And
              (Not fEmptyStr(qryDados.FieldByName('GRU_CODGRU').AsString)) Then
      Begin

        pSalva(qryDados.FieldByName('GRU_CODGRU').AsString);

      End

      Else If SameText(strNomCam, 'ITE_CODDEP') And
              fPesqDepartamento(frmPai, Nil, Nil, qryDados, Key, arrSelecao) And
              (Not fEmptyStr(qryDados.FieldByName('DEP_CODIGO').AsString)) Then
      Begin

        pSalva(qryDados.FieldByName('DEP_CODIGO').AsString);

      End

      Else If SameText(strNomCam, 'ITE_GRUCMP') And
              fPesqGrupoCompra(frmPai, Nil, Nil, qryDados, Key, arrSelecao) And
              (Not fEmptyStr(qryDados.FieldByName('GRU_CODIGO').AsString)) Then
      Begin

        pSalva(qryDados.FieldByName('GRU_CODIGO').AsString);

      End

      Else If SameText(strNomCam, 'ITE_CODONU') And
              fPesqClassificacaoOnu(frmPai, Nil, Nil, qryDados, Key, arrSelecao) And
              (Not fEmptyStr(qryDados.FieldByName('ONU_CODONU').AsString)) Then
      Begin

        pSalva(qryDados.FieldByName('ONU_CODONU').AsString);

      End

      Else If SameText(strNomCam, 'ITE_CODDIC') And
              fPesqDic(frmPai, Nil, Nil, qryDados, Key, arrSelecao) And
              (Not fEmptyStr(qryDados.FieldByName('DIC_CODDIC').AsString)) Then
      Begin

        pSalva(qryDados.FieldByName('DIC_CODDIC').AsString);

      End

      Else If SameText(strNomCam, 'ITE_CODLSE') And
              fPesqLocSep(frmPai, Nil, Nil, qryDados, Key, arrSelecao) And
              (Not fEmptyStr(qryDados.FieldByName('LSE_CODIGO').AsString)) Then
      Begin

        pSalva(qryDados.FieldByName('LSE_CODIGO').AsString);

      End

      Else If SameText(strNomCam, 'ITE_CDCEST') And
              fPesqCest(frmPai, Nil, Nil, qryDados, Key, arrSelecao) And
              (Not fEmptyStr(qryDados.FieldByName('CES_CDCEST').AsString)) Then
      Begin

        pSalva(qryDados.FieldByName('CES_CDCEST').AsString);

      End

      Else If SameText(strNomCam, 'ITE_SITPRO') And
              fPesqSituacaoProduto(frmPai, Nil, Nil, qryDados, Key, arrSelecao) And
              (Not fEmptyStr(qryDados.FieldByName('SIT_CODIGO').AsString)) Then
      Begin

        pSalva(qryDados.FieldByName('CES_CDCEST').AsString);

      End

      Else If SameText(strNomCam, 'ITE_CODGPC') And
              fPesqGPC(frmPai, Nil, Nil, qryDados, Key, arrSelecao) And
              (Not fEmptyStr(qryDados.FieldByName('GPC_CODGPC').AsString)) Then
      Begin

        pSalva(qryDados.FieldByName('GPC_CODGPC').AsString);

      End

      Else If SameText(strNomCam, 'ITE_EMPCAR') And
              fPesqEmpresa(conEmpSimples, frmPai, Nil, Nil, qryDados, Key, arrSelecao) And
              (Not fEmptyStr(qryDados.FieldByName('EMP_CODEMP').AsString)) Then
      Begin

        pSalva(qryDados.FieldByName('EMP_CODEMP').AsString);

      End

      Else If SameText(strNomCam, 'ITE_EMPSUG') And
              fPesqEmpresa(conEmpSimples, frmPai, Nil, Nil, qryDados, Key, arrSelecao) And
              (Not fEmptyStr(qryDados.FieldByName('EMP_CODEMP').AsString)) Then
      Begin

        pSalva(qryDados.FieldByName('EMP_CODEMP').AsString);

      End

      Else If (Pos(strNomCam, 'ITE_LOCFIS_ITE_LOCSUP') > 0) And
              (fCfgSis('CADLOC', varBoolean)) And
              (fPesqLocFisica(frmPai, Nil, Nil, qryDados, Key, arrSelecao)) And
              ((qryDados.FindField('LOC_CODLOC') <> Nil) And (Not fEmptyStr(qryDados.FieldByName('LOC_CODLOC').AsString))) Then
      Begin

        pSalva(qryDados.FieldByName('LOC_CODLOC').AsString);

      End;

      FreeAndNil(qryDados);
    End;

  End;
end;

Function TFrameAlteraPrecoIndividual.fRetDescricaoCadastro(strNomCam, strCodCad: String; blnValidar: Boolean; Var blnErro: Boolean): String;
Begin
  Result  := '';
  blnErro := False;

  If fEmptyStr(strCodCad) Then
    Exit;

  If AnsiEndsStr('_NOV', strNomCam) Then
    strNomCam := AnsiReplaceStr(strNomCam, '_NOV', '');

  If SameText(strNomCam, 'ITE_CODFOR') Then
  Begin
    Result := fRetNomFornecedor(strCodCad);
  End

  Else If SameText(strNomCam, 'ITE_CODGPR') Then
  Begin
    Result := fRetNomeGrupoPrecos(strCodCad);
  End

  Else If SameText(strNomCam, 'ITE_PRDGRU') Then
  Begin
    Result := fRetNomeGrupoProduto(strCodCad);
  End

  Else If SameText(strNomCam, 'ITE_CODABF') Then
  Begin
    Result := fRetDesAbfIcm(strCodCad);
  End

  Else If SameText(strNomCam, 'ITE_ABFPIS') Then
  Begin
    Result := fRetDesAbfPisCofIpi('PISSAI', strCodCad);
  End

  Else If SameText(strNomCam, 'ITE_ABFCOF') Then
  Begin
    Result := fRetDesAbfPisCofIpi('COFSAI', strCodCad);
  End

  Else If SameText(strNomCam, 'ITE_ABFIPI') Then
  Begin
    Result := fRetDesAbfPisCofIpi('IPISAI', strCodCad);
  End

  Else If SameText(strNomCam, 'ITE_CODMAR') Then
  Begin
    Result := fRetNomMarca(strCodCad);
  End

  Else If SameText(strNomCam, 'ITE_CODMON') Then
  Begin
    Result := fRetNomMontadora(strCodCad);
  End

  Else If SameText(strNomCam, 'ITE_CODUNI') Then
  Begin
    Result := fRetNomUnidade(strCodCad);
  End

  Else If SameText(strNomCam, 'ITE_UNICOM') Then
  Begin
    Result := fRetNomUnidade(strCodCad);
  End

  Else If SameText(strNomCam, 'ITE_UNITRI') Then
  Begin
    Result := fRetNomUnidade(strCodCad);
  End

  Else If SameText(strNomCam, 'ITE_CODGRU') Then
  Begin

    If blnValidar And (RightStr(strCodCad, 3) = '000') Then
    Begin
      pMensagemOk('Linha não permitida!');
      Exit;
    End;

    If blnValidar Then
      Result := fRetNomeLinhaGrupo(strCodCad)
    Else
      Result := fRetNomeSoGrupo(strCodCad);

  End

  Else If SameText(strNomCam, 'ITE_CODDEP') Then
  Begin
    Result := fCampoTabela('DEP_DESCRI','CADDEP',['DEP_CODIGO'], [strCodCad]);
  End

  Else If SameText(strNomCam, 'ITE_GRUCMP') Then
  Begin
    Result := fRetDescGrupoCompra(strCodCad);
  End

  Else If SameText(strNomCam, 'ITE_CODONU') Then
  Begin
    Result := fRetDescClassificacaoOnu(strCodCad);
  End

  Else If SameText(strNomCam, 'ITE_CODDIC') Then
  Begin
    Result := fRetDesDic(strCodCad);
  End

  Else If SameText(strNomCam, 'ITE_CODLSE') Then
  Begin
    Result := fRetLocSep(strCodCad);
  End

  Else If SameText(strNomCam, 'ITE_CDCEST') Then
  Begin
    Result := fCampoTabela('CES_DESCRI','CDCEST',['CES_CDCEST'], [strCodCad]);
  End

  Else If SameText(strNomCam, 'ITE_SITPRO') Then
  Begin
    Result := fRetNomSituacaoProduto(strCodCad);
  End

  Else If SameText(strNomCam, 'ITE_CODGPC') Then
  Begin
    Result := fCampoTabela('GPC_DESGPC','CADGPC',['GPC_CODGPC'], [strCodCad]);
  End

  Else If SameText(strNomCam, 'ITE_EMPCAR') Then
  Begin
    Result := fRetNomeEmpresaSelec(strCodCad);
  End

  Else If SameText(strNomCam, 'ITE_EMPSUG') Then
  Begin
    Result := fRetNomeEmpresaSelec(strCodCad);
  End

  Else If SameText(strNomCam, 'ITE_LOCFIS') Then
  Begin
    Result := fCampoTabela('LOC_DESCRI', 'CADLOC', ['LOC_CODLOC'], [strCodCad]);
  End

  Else If SameText(strNomCam, 'ITE_LOCSUP') Then
  Begin
    Result := fCampoTabela('LOC_DESCRI', 'CADLOC', ['LOC_CODLOC'], [strCodCad]);
  End

  Else if SameText(strNomCam, 'ITE_CODATC') then
  begin
    Result := TCheckListGarantiaController.fRetornaNomeAssistenciaTecnica(strCodCad);
    If (Not fEmptyStr(Result)) Then
    Begin
      if Not TCheckListGarantiaController.fCadAssistenciaAtivo(strCodCad) then
      begin
        fMensagem('ATENÇÃO!', 'Assistência técnica inativa, selecione cadastro ativado!', ['&Ok']);
        Result := EmptyStr;
        blnValidar := False;
        blnErro := True;
      end;
    end;
  end;

  If (blnValidar And fEmptyStr(Result)) And (fTemConsultaTabela(strNomCam)) Then
  Begin
    pMensagemOk('Código não encontrado!');
    blnErro := True;
  End;
End;


function TFrameAlteraPrecoIndividual.fTemConsultaTabela(
  strNomCam: String): Boolean;
Begin
  If AnsiEndsStr('_NOV', strNomCam) Then
    strNomCam := AnsiReplaceStr(strNomCam, '_NOV', '');

  Result := Pos(strNomCam, 'ITE_CODFOR_ITE_CODGPR_ITE_PRDGRU_ITE_CODABF_ITE_ABFPIS_ITE_ABFCOF_ITE_ABFIPI_' +
                           'ITE_CODMAR_ITE_NOMCAM_ITE_CODMON_ITE_CODUNI_ITE_UNICOM_ITE_UNITRI_ITE_CODGRU_' +
                           'ITE_CODDEP_ITE_GRUCMP_ITE_CODONU_ITE_CODDIC_ITE_CODLSE_ITE_CDCEST_ITE_SITPRO_' +
                           'ITE_CODGPC_ITE_EMPCAR_ITE_EMPSUG_ITE_LOCFIS_ITE_LOCSUP_ITE_CODATC') > 0;
End;

procedure TFrameAlteraPrecoIndividual.pCarregaPosicionamento;
begin
  GerenciaColunaGrid.pCarregaColunas;
end;



procedure TFrameAlteraPrecoIndividual.pSalvaOrdenacao;
  Var
    intRecNo,
    intContador: Integer;
    ptrRegistro: TPosicaoRegistroPrt;
begin
  pLiberaOrdenacao;

  If cxvTiposAlt.DataController.DataSet.IsEmpty Then
    Exit;

  intRecNo := cxvTiposAlt.DataController.DataSet.RecNo;

  With cxvTiposAlt.DataController do
  For intContador := 0 To RecordCount - 1 Do
  begin
    New(ptrRegistro);
    ptrRegistro^.intRecordIndex := intContador;
    ptrRegistro^.intPosition := GetRowIndexByRecordIndex(intContador, False);
    lstOrdemResgistros.Add(ptrRegistro);
  end;

  cxvTiposAlt.DataController.DataSet.RecNo := intRecNo;

end;

function TFrameAlteraPrecoIndividual.fRetCampoDesc(strField: string): TCampo;
var i : integer;
begin
  For i := 0 To High(arrCampos) do
  Begin
    If arrCampos[i].FieldName = strField Then
    Begin
      If arrCampos[i].blnTemDescricao Then
        exit(arrCampos[i + 1])
      Else
      Begin
        Result.Title := '';
        Result.FieldName := '';
        Result.ReadOnly := True;
        Result.Visible := False;
        Result.Properties:= Nil;
        Result.blnTemDescricao := False;
      end;
    End;
  End
end;


function TFrameAlteraPrecoIndividual.fRetDesAbfPisCofIpi(strTabela, strCod: String): String;
  Var
    qryAbf: TUniQuery;
begin
  qryAbf := fCriaQuery(Self);
  qryAbf.SQL.Add('SELECT APC_DESCRI FROM ' + strTabela +  ' WHERE APC_CODAPC = :CODAPC');
  qryAbf.ParamByName('CODAPC').AsString := strCod;
  qryAbf.Open;

  Result := qryAbf.FieldByName('APC_DESCRI').AsString;

  FreeAndNil(qryAbf);
end;

procedure TMycxCustomDataControllerInfo.DoSort;
begin
  inherited;
end;

Procedure TcxGridDBDataController.SetOrdenar(Value: Boolean);
Begin
  If Value <> TMycxCustomDataControllerInfo(DataControllerInfo).blnOrdenar Then
  Begin
    TMycxCustomDataControllerInfo(DataControllerInfo).blnOrdenar := Value;

    If Value Then
      TMycxCustomDataControllerInfo(DataControllerInfo).DoSort;

  End;

End;

Function TcxGridDBDataController.GetOrdenar: Boolean;
Begin
  Result := TMycxCustomDataControllerInfo(DataControllerInfo).blnOrdenar;
End;

procedure TFrameAlteraPrecoIndividual.pLiberaOrdenacao;
  Var
    intContador: Integer;
Begin
  For intContador := 0 To lstOrdemResgistros.Count -1 Do
    Dispose(TPosicaoRegistroPrt(lstOrdemResgistros[intContador]));

  lstOrdemResgistros.Clear;
End;

function TFrameAlteraPrecoIndividual.fGetPositionByRecordIndex(ARecordIndex: Integer): Integer;
  Var
    intContador: Integer;
begin
  Result := -1;

  For intContador := 0 To lstOrdemResgistros.Count -1 Do
    If TPosicaoRegistroPrt(lstOrdemResgistros[intContador])^.intRecordIndex = ARecordIndex Then
    Begin
      Result := TPosicaoRegistroPrt(lstOrdemResgistros[intContador])^.intPosition;
      Break;
    End;

end;
end.
