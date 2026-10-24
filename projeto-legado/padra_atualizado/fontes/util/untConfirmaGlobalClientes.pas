unit untConfirmaGlobalClientes;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, Grids, DBGridCitel, DBGrids, ComCtrls,
  Buttons, ExtCtrls, untfuncoesSimples, DB, StrUtils, Menus, Uni, AppEvnts,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade, cxProgressBar,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData, untFuncoesGenerica,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView, untMsgLiberacao, untILiberacao, untLiberacaoFactory,
  untGravando, cxGridTableView, cxGridDBTableView, cxGrid, cxCheckBox, Messages, untTCalculaVariacaoPreco,
  untZClient, Datasnap.DBClient, UniClientDataSet, untLiberacao, cxGridCitel;

const
  WM_MESSAGESELECIONAITEM = WM_USER + 8839;

type
  TfrmConfirmaGlobalClientes = class(TfrmPaiSimples)
    pnlBotoesEnt: TPanel;
    pgbProgresso: TProgressBar;
    dtsClientes: TDataSource;
    btnConfirma: TBitBtnLocked;
    btnMarTod: TBitBtnLocked;
    btnDesTod: TBitBtnLocked;
    btnVoltar: TBitBtnLocked;
    cxgItens: TcxGridCitel;
    cxvItens: TcxGridDBTableViewCitel;
    cxgItensLevel1: TcxGridLevel;
    cxStyleRepository1: TcxStyleRepository;
    cxsMoney: TcxStyle;
    Panel1: TPanel;
    lblLegendaAzul: TLabel;
    cxsBlue: TcxStyle;
    cxStyle1: TcxStyle;
    cxvItensMarcado: TcxGridDBColumn;
    cxBlackBold: TcxStyle;
    procedure FormShow(Sender: TObject);
    procedure btnVoltarClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxvItensCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxvItensKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxvItensCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure btnMarTodClick(Sender: TObject);
    procedure btnDesTodClick(Sender: TObject);
    procedure cxvItensCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure cxvItensDataControllerSortingChanged(Sender: TObject);
    procedure cxvItensDataControllerFilterChanged(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    frmGravando: TfrmGravando;
    blnMarcar: Boolean;
    qryIteCom: TUniQuery;
    objLiberacao : TLiberacao;
    blnLiberacaoPortador1 : Boolean;
    blnLiberacaoPortador2 : Boolean;
    blnLiberacaoLimiteCredito : Boolean;
    blnLiberacaoRepresentante : Boolean;
    blnLiberacaoVendedor : Boolean;
    blnLiberacaoTipoCliente : Boolean;
    blnLiberacaoTabelaPreco : Boolean;

    function fTemItemParaAlterar: Boolean;
    function fTemItemParaAlterarPrg(cxProgressBar: TcxProgressBar): Boolean;

    function fAtualizaTabela(cxProgressBar: TcxProgressBar): Boolean;
    procedure pAtualizaTabela;
    procedure pMarcaItem(blnMarcar: Boolean);
    procedure pSelecionaItem;
    procedure pAdicionaColuna(strTitulo, strCampo: String; blnVisible: Boolean = True; blnGroupBy: Boolean = False);

    function fConfirmaAlteracoes: Boolean;
    function fConfirmaAlteracoesAux(pgbProgresso2: TcxProgressBar): Boolean;
    procedure pWMMessageSelecionaItem(var Message: TMessage); Message WM_MESSAGESELECIONAITEM;

    function fMarcaTodos(cxProgresso: TcxProgressBar): Boolean;
    function fValidaLiberacoes: Boolean;
    function fCampoNoArray(strCampo: String): Boolean;
    function fValidaPortador1: Boolean;
    function fValidaPortador2: Boolean;
    function fValidaLimiteCredito: Boolean;
    function fValidaRepresentante: Boolean;
    function fValidaVendedor: Boolean;
    function fValidaTipoCliente: Boolean;
    function fValidaTabelaPreco: Boolean;
    function fRetSqlENTCLI(strCampo: String; strValor: String): String;
    function fRetSqlCliCndPag(strTipo, strValor: String): String;
  public
    { Public declarations }
    arrCamposGrid: TArrCampoGlobal;

    blnConfirma: Boolean;
    blnIncluirCnd: Boolean;
  end;

implementation

uses
  dxCore,
  untLogAltCadCli,
  untFuncoesAuxiliares;

{$R *.dfm}

{ TfrmConfirmaGlobalClientes }

procedure TfrmConfirmaGlobalClientes.pAdicionaColuna(strTitulo, strCampo: String; blnVisible: Boolean = True; blnGroupBy: Boolean = False);
  Var
    cxItem: TcxCustomGridTableItem;
Begin
  cxItem := cxvItens.FindItemByName(strCampo);

  If Not Assigned(cxItem) Then
  Begin
    cxItem := cxvItens.DataController.CreateItemByField(TUniClientDataSet(dtsClientes.DataSet).FieldByName(strCampo));
    cxItem.Name    := strCampo;
    cxItem.Caption := strTitulo;


    If SameText('CLI_NOMCLI', strCampo) Then
      TcxGridDBColumn(cxItem).SortOrder := soAscending;
  End;

  cxItem.Visible := blnVisible;
  If blnGroupBy Then
  Begin
    TcxGridDBColumn(cxItem).GroupIndex := 0;
    cxItem.Visible := False;
  End;
End;

procedure TfrmConfirmaGlobalClientes.pAtualizaTabela;
Begin
  TfrmGravando.fExecuta(fAtualizaTabela, frmGravando, 'Carregando dados, aguarde...', True, True);
End;

function TfrmConfirmaGlobalClientes.fAtualizaTabela(cxProgressBar: TcxProgressBar): Boolean;
  Var
    intContador: Integer;
    intTamMat: Integer;
    fldCampo: TField;
    fldCampoNovo: TField;
begin
  dtsClientes.DataSet.DisableControls;
  pAdicionaColuna('Código', 'CLI_CODCLI', True);
  pAdicionaColuna('Nome',   'CLI_NOMCLI');

  intTamMat := Length(arrCamposGrid);

  cxProgressBar.Properties.Max := intTamMat * 2;

  For intContador := 0 To intTamMat -1 Do
  Begin
    If (Not fEmptyStr(arrCamposGrid[intContador].strNomCam)) Then
    Begin
      pAdicionaColuna(arrCamposGrid[intContador].strDesCam, arrCamposGrid[intContador].strNomCam + '_ORI');
      pAdicionaColuna(arrCamposGrid[intContador].strDesCam + '(NOVO)', arrCamposGrid[intContador].strNomCam);
    End;

    cxProgressBar.Position := cxProgressBar.Position + 1;
    Application.ProcessMessages;
  End;

  dtsClientes.DataSet.First;
  For intContador := 0 To intTamMat-1 Do
  Begin
    If not fEmptyStr(arrCamposGrid[intContador].strDesAbr) Then
    Begin
      fldCampo     := dtsClientes.DataSet.FieldByName(arrCamposGrid[intContador].strNomCam + '_ORI');
      fldCampoNovo := dtsClientes.DataSet.FieldByName(arrCamposGrid[intContador].strNomCam);

      If (Not (fldCampo.DataType In [ftString, ftMemo])) And
         (fldCampo.DataType <> ftDate)   Then
      Begin
        If (Not fEmptyStr(arrCamposGrid[intContador].strMasCam)) Then
        Begin
          If (fldCampo.DataType = ftFloat) Then
          Begin
            (fldCampo As TFloatField).DisplayFormat     := arrCamposGrid[intContador].strMasCam;
            (fldCampoNovo As TFloatField).DisplayFormat := arrCamposGrid[intContador].strMasCam;
          End;
        End;
      End;
    End;

    cxProgressBar.Position := cxProgressBar.Position + 1;
    Application.ProcessMessages;
  End;

  frmGravando.lblGravando.Caption := 'Ajustando grid, aguarde...';
  Application.ProcessMessages;
  dtsClientes.DataSet.EnableControls;
  cxvItens.ApplyBestFit;
  Result := True;
end;

procedure TfrmConfirmaGlobalClientes.FormShow(Sender: TObject);
begin
  inherited;
  pAtualizaTabela;
  cxvItens.NavigatorButtons.First.Click;
end;

function TfrmConfirmaGlobalClientes.fMarcaTodos(cxProgresso: TcxProgressBar): Boolean;
begin
  Result := True;

  If dtsClientes.DataSet.IsEmpty Then
    Exit;

  dtsClientes.DataSet.DisableControls;
  Try
    cxProgresso.Properties.Max := dtsClientes.DataSet.RecordCount;

    dtsClientes.DataSet.First;
    While Not dtsClientes.DataSet.Eof Do
    Begin
      pMarcaItem(blnMarcar);
      dtsClientes.Dataset.Next;

      cxProgresso.Position := cxProgresso.Position + 1;
      Application.ProcessMessages;
    End;

  Finally
    dtsClientes.DataSet.EnableControls;
  End;

  cxvItens.NavigatorButtons.First.Click;
end;

procedure TfrmConfirmaGlobalClientes.btnDesTodClick(Sender: TObject);
begin
  inherited;

  blnMarcar := False;
  TfrmGravando.fExecuta(fMarcaTodos, frmGravando, 'Desmarcando clientes...', True, True);
end;

procedure TfrmConfirmaGlobalClientes.btnMarTodClick(Sender: TObject);
begin
  inherited;

  blnMarcar := True;
  TfrmGravando.fExecuta(fMarcaTodos, frmGravando, 'Marcando clientes...', True, True);
end;

procedure TfrmConfirmaGlobalClientes.btnVoltarClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmConfirmaGlobalClientes.cxvItensCellClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  If cxvItensMarcado.Focused Then
     PostMessage(Handle, WM_MESSAGESELECIONAITEM, 0, 0);
end;

procedure TfrmConfirmaGlobalClientes.cxvItensCellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
  Var
    Key: Word;
    State: TShiftState;
begin
  inherited;
  Key := VK_Return;
  cxvItensKeyDown(Sender, Key, State);
end;

procedure TfrmConfirmaGlobalClientes.cxvItensCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If dtsClientes.DataSet.IsEmpty Then
    Exit;

  If (VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxvItensMarcado.Index]) = 'M') Then
      ACanvas.Font.Color := clBlue;

  If Not AViewInfo.Selected Then
  Begin
    If Pos('_ORI', AViewInfo.Item.Name) > 0 Then
      ACanvas.Brush.Color := clWhite
    Else
      ACanvas.Brush.Color := clSilver;
  End;
end;

procedure TfrmConfirmaGlobalClientes.cxvItensDataControllerFilterChanged(
  Sender: TObject);
begin
  inherited;
  dtsClientes.DataSet.DisableControls;
  Try
    dtsClientes.DataSet.Filtered := False;
    If Not fEmptyStr(cxvItens.DataController.Filter.FilterText) Then
    Begin
      dtsClientes.DataSet.Filter := UPPERCASE(cxvItens.DataController.Filter.FilterText);
      dtsClientes.DataSet.Filtered := True;
    End;
  Finally
    dtsClientes.DataSet.EnableControls;
  End;
end;

procedure TfrmConfirmaGlobalClientes.cxvItensDataControllerSortingChanged(
  Sender: TObject);
var
  intCont: Integer;
  strFieldName: String;
  objField: TField;
  DataSet : TUniClientDataSet;
begin
  inherited;
  DataSet :=  TUniClientDataSet(dtsClientes.DataSet);

  If cxvItens.SortedItemCount > 0 Then
  begin
    For intCont := 0 To cxvItens.SortedItemCount - 1 Do
    Begin
      strFieldName := cxvItens.SortedItems[intCont].DataBinding.FilterFieldName.Trim.Replace(' ','');
      objField := dtsClientes.DataSet.FindField(strFieldName);
      If objField <> nil Then
        If objField.FieldKind = fkData then
          pOrdenaDataSet(DataSet,
            strFieldName,
            IfThen(cxvItens.SortedItems[intCont].SortOrder = soDescending, 'DESC'));
    End;
  End;
end;

procedure TfrmConfirmaGlobalClientes.cxvItensKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  If (Key = VK_Return) Then
  Begin
    pSelecionaItem;
    cxvItens.Controller.FocusNextRecord(cxvItens.Controller.FocusedRecordIndex, not (ssShift in Shift), true, false, false);
  End;
end;

procedure TfrmConfirmaGlobalClientes.pSelecionaItem;
begin
  pMarcaItem(dtsClientes.DataSet.FieldByName('CLI_MARDES').AsString <> 'M');
end;

procedure TfrmConfirmaGlobalClientes.pWMMessageSelecionaItem(
  var Message: TMessage);
begin
  If cxvItensMarcado.Focused Then
    pMarcaItem(dtsClientes.DataSet.FieldByName('CLI_MARDES').AsString <> 'M');
end;

procedure TfrmConfirmaGlobalClientes.pMarcaItem(blnMarcar: Boolean);
begin
  cxvItens.DataController.BeginUpdate;
  Try
    dtsClientes.DataSet.Edit;
    dtsClientes.DataSet.FieldByName('CLI_MARDES').AsString := IIF(blnMarcar, 'M', 'D');
    dtsClientes.DataSet.Post;
  Finally
    cxvItens.DataController.EndUpdate;
  End;
end;

function TfrmConfirmaGlobalClientes.fConfirmaAlteracoes: Boolean;
Begin
  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.blnTempoRestante := True;
    frmGravando.fExecutarAcao := fConfirmaAlteracoesAux;
    frmGravando.lblGravando.Caption := 'Aguarde, atualizando clientes...';
    frmGravando.ShowModal;
    Result := frmGravando.blnConfirma;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmConfirmaGlobalClientes.fConfirmaAlteracoes]');
      Result := False;
    End;
  End;

  pFreeAndNil(frmGravando);
End;

function TfrmConfirmaGlobalClientes.fRetSqlENTCLI(strCampo: String; strValor: String): String;
begin
  Result := '';
  Result := Result + 'UPDATE ';
  Result := Result + '  ENTCLI ';
  Result := Result + 'SET ';
  Result := Result + '  ETC_'+strCampo+' = ' + QuotedStr(strValor) + ' ';
  Result := Result + 'WHERE ';
  Result := Result + '  ETC_CODCLI = :CODCLI ';
end;

function TfrmConfirmaGlobalClientes.fRetSqlCliCndPag(strTipo: String; strValor: String): String;
begin
  If (strTipo = 'INSERT') Then
  Begin
    Result := '';
    Result := Result + 'INSERT INTO CLICND ( ';
    Result := Result + '  AUTOINCREM, ';
    Result := Result + '  CND_CODCLI, ';
    Result := Result + '  CND_CODCND, ';
    Result := Result + '  CND_SUGEST, ';
    Result := Result + '  CND_ULTALT) ';
    Result := Result + 'VALUES ( ';
    Result := Result + '  :AUTOINCREM, ';
    Result := Result + '  :CND_CODCLI, ';
    Result := Result + '  ' + QuotedStr(strValor) + ', ';
    Result := Result + '  :CND_SUGEST, ';
    Result := Result + '  :CND_ULTALT); ';
  End
  Else
  If (strTipo = 'DELETE') Then
  Begin
    Result := '';
    Result := Result + 'DELETE FROM CLICND ';
    Result := Result + 'WHERE CND_CODCLI = :CND_CODCLI ';
    Result := Result + '  AND CND_CODCND = ' + QuotedStr(strValor);
  End;
end;

function TfrmConfirmaGlobalClientes.fConfirmaAlteracoesAux(pgbProgresso2: TcxProgressBar): Boolean;
  Var
    strUpdCadCli: String;
    strUpdTipFre: String;
    strUpdCodTra: String;
    strSelCndPag: String;
    strInsOrDelCndPag: String;

    blnAltCadCli: Boolean;
    intContador : Integer;
    intTamMat   : Integer;
    intAtualiza : Integer;

    fldCampo: TField;
    fldCampoNovo: TField;
    qryGenTmp: TUniQuery;

    LogAltCadCli : TLogAltCadCli;
    blnGravaLogTransacaoAnt : Boolean;
begin
  blnGravaLogTransacaoAnt := VS_blnGravaLogTransacao;
  LogAltCadCli := TLogAltCadCli.Create(Self);
  qryGenTmp := fCriaQuery;

  Try
    VS_blnGravaLogTransacao := False;
    Result := True;

    dtsClientes.DataSet.DisableControls;
    dtsClientes.DataSet.Filter := '(CLI_MARDES = ''M'')';
    dtsClientes.DataSet.Filtered := True;
    dtsClientes.DataSet.First;

    If dtsClientes.DataSet.RecordCount > 1000 Then
      intAtualiza := dtsClientes.DataSet.RecordCount Div 100
    Else
      intAtualiza := 0;

    Try
      pgbProgresso2.Position       := 0;
      pgbProgresso2.Properties.Max := dtsClientes.DataSet.RecordCount;
      Application.ProcessMessages;

      While Not dtsClientes.DataSet.Eof Do
      Begin
        strUpdTipFre := '';
        strUpdCodTra := '';
        strSelCndPag := '';
        strInsOrDelCndPag := '';

        blnAltCadCli := False;
        LogAltCadCli.pLogAdd('CADCLI', ['AUTOINCREM'], 'CLI_CODCLI = ' + QuotedStr(dtsClientes.DataSet.FieldByName('CLI_CODCLI').AsString), pSetaDisplayLabelCadCli);
        LogAltCadCli.LogVar.Clear;

        intTamMat := Length(arrCamposGrid);
        fStartTransaction;

        strUpdCadCli := '';
        strUpdCadCli := strUpdCadCli + 'UPDATE   ';
        strUpdCadCli := strUpdCadCli + '  CADCLI ';
        strUpdCadCli := strUpdCadCli + 'SET ';

        For intContador := 0 To intTamMat -1 Do
        Begin
          If Not fEmptyStr(arrCamposGrid[intContador].strNomCam) Then
          Begin
            fldCampo     := dtsClientes.DataSet.FieldByName(arrCamposGrid[intContador].strNomCam + '_ORI');
            fldCampoNovo := dtsClientes.DataSet.FieldByName(arrCamposGrid[intContador].strNomCam);

            If arrCamposGrid[intContador].strNomCam = 'TIPFRE' Then
              strUpdTipFre := fRetSqlENTCLI('TIPFRE', fldCampoNovo.AsString)
            Else If arrCamposGrid[intContador].strNomCam = 'CODTRA' Then
              strUpdCodTra := fRetSqlENTCLI('CODTRA', fldCampoNovo.AsString)
            Else If arrCamposGrid[intContador].strNomCam = 'CNDPAG' Then
            Begin
              strSelCndPag := strSelCndPag + 'SELECT * FROM CLICND ';
              strSelCndPag := strSelCndPag + 'WHERE CND_CODCLI = ' + QuotedStr(dtsClientes.DataSet.FieldByName('CLI_CODCLI').AsString);
              strSelCndPag := strSelCndPag + '  AND CND_CODCND = ' + QuotedStr(fldCampoNovo.AsString) + ' ';

              If blnIncluirCnd Then
                strInsOrDelCndPag := fRetSqlCliCndPag('INSERT', fldCampoNovo.AsString)
              Else
                strInsOrDelCndPag := fRetSqlCliCndPag('DELETE', fldCampoNovo.AsString);
            End
            Else
            Begin
              LogAltCadCli.LogVar.AddOrSetValue(fldCampoNovo.FieldName, strLoginUsuarioLogado);

              blnAltCadCli := True;
              strUpdCadCli := strUpdCadCli + ' ' + fldCampoNovo.FieldName + ' = ';

              If fldCampo.DataType In [ftString, ftMemo] Then
                strUpdCadCli := strUpdCadCli + QuotedStr(fldCampoNovo.AsString)
              Else
                strUpdCadCli := strUpdCadCli + AnsiReplaceStr(fldCampoNovo.AsString, ',', '.');

              If intContador < intTamMat -1 Then
                strUpdCadCli := strUpdCadCli + ',';
            End;
          End;
        End;

        If RightStr(strUpdCadCli, 1) = ',' Then
          strUpdCadCli := Copy(strUpdCadCli, 1, Length(strUpdCadCli)-1);

        strUpdCadCli := strUpdCadCli + ' WHERE ';
        strUpdCadCli := strUpdCadCli + '  CLI_CODCLI = :CODCLI ';

        If blnAltCadCli Then
        Begin
          qryGenTmp.Close;
          qryGenTmp.SQL.Clear;
          qryGenTmp.SQL.Add(strUpdCadCli);
          qryGenTmp.ParamByName('CODCLI').AsString := dtsClientes.DataSet.FieldByName('CLI_CODCLI').AsString;
          qryGenTmp.ExecSQL;
          qryGenTmp.Close;

          LogAltCadCli.pProcessarLogs;
        End;

        If Not fEmptyStr(strUpdTipFre) Then
        Begin
          qryGenTmp.Close;
          qryGenTmp.SQL.Clear;
          qryGenTmp.SQL.Add(strUpdTipFre);
          qryGenTmp.ParamByName('CODCLI').AsString := dtsClientes.DataSet.FieldByName('CLI_CODCLI').AsString;
          qryGenTmp.ExecSQL;
          qryGenTmp.Close;
        End;

        If Not fEmptyStr(strUpdCodTra) Then
        Begin
          qryGenTmp.Close;
          qryGenTmp.SQL.Clear;
          qryGenTmp.SQL.Add(strUpdCodTra);
          qryGenTmp.ParamByName('CODCLI').AsString := dtsClientes.DataSet.FieldByName('CLI_CODCLI').AsString;
          qryGenTmp.ExecSQL;
          qryGenTmp.Close;
        End;

        If Not fEmptyStr(strSelCndPag) Then
        Begin
          qryGenTmp.Close;
          qryGenTmp.SQL.Clear;
          qryGenTmp.SQL.Add(strSelCndPag);
          qryGenTmp.Open;

          If (qryGenTmp.IsEmpty) Then
          Begin
            If (blnIncluirCnd) Then
            Begin
              qryGenTmp.Close;
              qryGenTmp.SQL.Clear;
              qryGenTmp.SQL.Add(strInsOrDelCndPag);
              qryGenTmp.ParamByName('AUTOINCREM').AsString   := fRetAutoIncrem('CLICND', VS_strCodEmp);
              qryGenTmp.ParamByName('CND_CODCLI').AsString   := dtsClientes.DataSet.FieldByName('CLI_CODCLI').AsString;
              qryGenTmp.ParamByName('CND_SUGEST').AsString   := 'N';
              qryGenTmp.ParamByName('CND_ULTALT').AsDateTime := fNow();
              qryGenTmp.ExecSQL;
            End;
          End
          Else
          Begin
            If (Not blnIncluirCnd) Then
            Begin
              qryGenTmp.Close;
              qryGenTmp.SQL.Clear;
              qryGenTmp.SQL.Add(strInsOrDelCndPag);
              qryGenTmp.ParamByName('CND_CODCLI').AsString := dtsClientes.DataSet.FieldByName('CLI_CODCLI').AsString;
              qryGenTmp.ExecSQL;
            End;
          End;

          qryGenTmp.Close;
        End;

        fCommit;
        dtsClientes.DataSet.Next;

        pgbProgresso2.Position := pgbProgresso2.Position + 1;

        If (intAtualiza = 0) Or (Trunc(pgbProgresso2.Position) Mod intAtualiza = 0) Then
          Application.ProcessMessages;
      End;

      dtsClientes.DataSet.Filtered := False;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        dtsClientes.DataSet.Filtered := False;
        dtsClientes.DataSet.EnableControls;
        Result := False;
        pMensagensErro(E.Message, '[fConfirmaAlteracoes]');
      End;
    End;
  Finally
    dtsClientes.DataSet.EnableControls;
    VS_blnGravaLogTransacao := blnGravaLogTransacaoAnt;

    FreeAndNil(qryGenTmp);
    FreeAndNil(LogAltCadCli);
  End;
end;

function TfrmConfirmaGlobalClientes.fTemItemParaAlterar: Boolean;
Begin
  Result := TfrmGravando.fExecuta(fTemItemParaAlterarPrg, frmGravando, 'Verificando clientes marcados, aguarde...', False);
End;

function TfrmConfirmaGlobalClientes.fTemItemParaAlterarPrg(cxProgressBar: TcxProgressBar): Boolean;
Begin
  Result := False;
  dtsClientes.DataSet.DisableControls;
  dtsClientes.DataSet.First;
  While Not dtsClientes.DataSet.Eof Do
  Begin
    If dtsClientes.DataSet.FieldByName('CLI_MARDES').AsString = 'M' Then
    Begin
      Result := True;
      Break;
    End;
    dtsClientes.Dataset.Next;
  End;
  dtsClientes.DataSet.EnableControls;
End;

function TfrmConfirmaGlobalClientes.fValidaLiberacoes: Boolean;
begin
  If (Not blnLiberacaoPortador1) Then
  Begin
    blnLiberacaoPortador1 := fValidaPortador1;
    If (Not blnLiberacaoPortador1) Then
    Begin
      pMensagemOk('A liberação do Portador (1) não foi realizada!');
      Exit(False);
    End;
  End;

  If (Not blnLiberacaoPortador2) Then
  Begin
    blnLiberacaoPortador2 := fValidaPortador2;
    If (Not blnLiberacaoPortador2) Then
    Begin
      pMensagemOk('A liberação do Portador (2) não foi realizada!');
      Exit(False);
    End;
  End;

  If (Not blnLiberacaoLimiteCredito) Then
  Begin
    blnLiberacaoLimiteCredito := fValidaLimiteCredito;
    If (Not blnLiberacaoLimiteCredito) Then
    Begin
      pMensagemOk('A liberação do limite de crédito não foi realizada!');
      Exit(False);
    End;
  End;

  If (Not blnLiberacaoRepresentante) Then
  Begin
    blnLiberacaoRepresentante := fValidaRepresentante;
    If (Not blnLiberacaoRepresentante) Then
    Begin
      pMensagemOk('A liberação do representante não foi realizada!');
      Exit(False);
    End;
  End;

  If (Not blnLiberacaoVendedor) Then
  Begin
    blnLiberacaoVendedor := fValidaVendedor;
    If (Not blnLiberacaoVendedor) Then
    Begin
      pMensagemOk('A liberação do vendedor não foi realizada!');
      Exit(False);
    End;
  End;

  If (Not blnLiberacaoTipoCliente) Then
  Begin
    blnLiberacaoTipoCliente := fValidaTipoCliente;
    If (Not blnLiberacaoTipoCliente) Then
    Begin
      pMensagemOk('A liberação do Tipo de Cliente não foi realizada!');
      Exit(False);
    End;
  End;

  If (Not blnLiberacaoTabelaPreco) Then
  Begin
    blnLiberacaoTabelaPreco := fValidaTabelaPreco;
    If (Not blnLiberacaoTabelaPreco) Then
    Begin
      pMensagemOk('A liberação da tabela de preço não foi realizada!');
      Exit(False);
    End;
  End;

  Result := True;
end;

function TfrmConfirmaGlobalClientes.fValidaLimiteCredito: Boolean;
var
  objTabela    : TRegistroMsgLiberaTabela;
  objTabela2   : TRegistroMsgLiberaTabela;
  objLinha     : TLinhaMsgLibera;
  objLinha2    : TLinhaMsgLibera;
  fltValorAnte : Double;
  fltValorNovo : Double;
  blnTemValidacao: Boolean;
begin
  Result := True;

  If Not fCampoNoArray('CLI_LIMCRE') Then
    Exit;

  blnTemValidacao := False;

  dtsClientes.DataSet.DisableControls;
  Try
    dtsClientes.DataSet.Filter := '(CLI_MARDES = ''M'')';
    dtsClientes.DataSet.Filtered := True;

    If Not dtsClientes.DataSet.IsEmpty Then
    Begin
      objTabela := TRegistroMsgLiberaTabela.Create();

      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlCabecalho;
      objLinha.pAddColuna(''  , 'Cliente'           , 70 , alEsquerda , teAutcom);
      objLinha.pAddColuna(''  , 'CPF/CNPJ'          , 18 , alEsquerda , teAutcom);
      objLinha.pAddColuna(''  , 'Lim. Crédito Atual', 20 , alDireita , teAutcom);
      objLinha.pAddColuna(''  , 'Novo Lim. Crédito' , 20 , alDireita  , teAutcom);
      objTabela.lstLinhas.Add(objLinha);

      dtsClientes.DataSet.First;
      While Not dtsClientes.DataSet.Eof Do
      Begin
        fltValorNovo := dtsClientes.DataSet.FieldByName('CLI_LIMCRE').AsFloat;
        fltValorAnte := dtsClientes.DataSet.FieldByName('CLI_LIMCRE_ORI').AsFloat;

        If fltValorAnte <> fltValorNovo then
        Begin
          If (fCfgSis('LMCROP', VarBoolean)) And
             (fltValorNovo > fLimCredOperador('', dtsClientes.DataSet.FieldByName('CLI_CODCLI').Value)) Then
          Begin
            If fCfgSis('LMCRTR', VarString) <> '1' Then
            Begin
              blnTemValidacao := True;

              objLinha  := TLinhaMsgLibera.Create;
              objLinha.enuTipoLinha := tlValor;
              objLinha.pAddColuna('Cliente'            , dtsClientes.DataSet.FieldByName('CLI_CODCLI').AsString + '-' + dtsClientes.DataSet.FieldByName('CLI_NOMCLI').AsString, 70 , alEsquerda , teAutcom);
              objLinha.pAddColuna('CPF/CNPJ'           , fFormataCpfCgc(dtsClientes.DataSet.FieldByName('CLI_C_G_C_').AsString, fSetaPais), 18, alEsquerda, teAutcom);
              objLinha.pAddColuna('Lim. Crédito Atual' , FloatToStrF(fltValorAnte, ffFixed, 15, 2)          , 20, alDireita,  teAutcom);
              objLinha.pAddColuna('Novo Lim. Crédito'  , FloatToStrF(fltValorNovo, ffFixed, 15, 2)          , 20, alDireita,  teAutcom);
              objTabela.lstLinhas.Add(objLinha);
            End;
          End;
        End;

        dtsClientes.DataSet.Next;
      End;

      If blnTemValidacao Then
      Begin
        objLiberacao.Clear;
        objLiberacao.strDirAce    := 'LCRCLIOPE';
        objLiberacao.strSenLib    := fCfgSis('SENCRE');
        objLiberacao.strMsgSen    := 'Limite de Crédito';
        objLiberacao.strCodOpe    := strLoginUsuarioLogado;
        objLiberacao.strCodDig    := strLoginUsuarioLogado;
        objLiberacao.objMsgLibera.pAddTexto('Alteração de limite de crédito maior que alçada do operador ');
        objLiberacao.objMsgLibera.pAddQuebra();

        objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

        Result := objLiberacao.fLibera;

        If (Not Result) Then
          Exit(False);
      End;

      objTabela2 := TRegistroMsgLiberaTabela.Create();

      objLinha2  := TLinhaMsgLibera.Create;
      objLinha2.enuTipoLinha := tlCabecalho;
      objLinha2.pAddColuna(''  , 'Cliente'           , 70 , alEsquerda , teAutcom);
      objLinha2.pAddColuna(''  , 'CPF/CNPJ'          , 18 , alEsquerda , teAutcom);
      objLinha2.pAddColuna(''  , 'Lim. Crédito Atual', 20 , alDireita , teAutcom);
      objLinha2.pAddColuna(''  , 'Novo Lim. Crédito' , 20 , alDireita  , teAutcom);
      objTabela2.lstLinhas.Add(objLinha2);

      dtsClientes.DataSet.First;
      While Not dtsClientes.DataSet.Eof Do
      Begin
        fltValorNovo := dtsClientes.DataSet.FieldByName('CLI_LIMCRE').AsFloat;
        fltValorAnte := dtsClientes.DataSet.FieldByName('CLI_LIMCRE_ORI').AsFloat;

        If fltValorAnte <> fltValorNovo then
        Begin
          If Not ((fCfgSis('LMCROP', VarBoolean)) And (fltValorNovo > fLimCredOperador('', dtsClientes.DataSet.FieldByName('CLI_CODCLI').Value)))  Then
          Begin
            blnTemValidacao := True;

            objLinha2  := TLinhaMsgLibera.Create;
            objLinha2.enuTipoLinha := tlValor;
            objLinha2.pAddColuna('Cliente'            , dtsClientes.DataSet.FieldByName('CLI_CODCLI').AsString + '-' + dtsClientes.DataSet.FieldByName('CLI_NOMCLI').AsString, 70 , alEsquerda , teAutcom);
            objLinha2.pAddColuna('CPF/CNPJ'           , fFormataCpfCgc(dtsClientes.DataSet.FieldByName('CLI_C_G_C_').AsString, fSetaPais), 18, alEsquerda, teAutcom);
            objLinha2.pAddColuna('Lim. Crédito Atual' , FloatToStrF(fltValorAnte, ffFixed, 15, 2)          , 20, alDireita,  teAutcom);
            objLinha2.pAddColuna('Novo Lim. Crédito'  , FloatToStrF(fltValorNovo, ffFixed, 15, 2)          , 20, alDireita,  teAutcom);
            objTabela2.lstLinhas.Add(objLinha2);
          End;
        End;

        dtsClientes.DataSet.Next;
      End;

      If blnTemValidacao Then
      Begin
        objLiberacao.Clear;
        objLiberacao.strDirAce    := 'LCRCLI';
        objLiberacao.strSenLib    := fCfgSis('SENCRE');
        objLiberacao.strMsgSen    := 'Limite de Crédito';
        objLiberacao.strCodOpe    := strLoginUsuarioLogado;
        objLiberacao.strCodDig    := strLoginUsuarioLogado;
        objLiberacao.objMsgLibera.pAddTexto('Troca de limite de crédito.');
        objLiberacao.objMsgLibera.pAddQuebra();

        objLiberacao.objMsgLibera.lstRegistros.Add(objTabela2);
        Result := objLiberacao.fLibera;
      End;
    end;
  Finally
    dtsClientes.DataSet.Filtered := False;
    dtsClientes.DataSet.Filter := '';
    dtsClientes.DataSet.EnableControls;
  End;
end;

function TfrmConfirmaGlobalClientes.fValidaRepresentante: Boolean;
var
  strValorNovo: String;
  strValorAnte: String;
  blnTemValidacao: Boolean;
  objTabela : TRegistroMsgLiberaTabela;
  objLinha  : TLinhaMsgLibera;
begin
  Result := True;

  If Not fCampoNoArray('CLI_CODREP') Then
    Exit;

  blnTemValidacao := False;

  dtsClientes.DataSet.DisableControls;
  Try
    dtsClientes.DataSet.Filter := '(CLI_MARDES = ''M'')';
    dtsClientes.DataSet.Filtered := True;

    objTabela := TRegistroMsgLiberaTabela.Create();

    objLinha  := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlCabecalho;
    objLinha.pAddColuna(''  , 'Cliente'            , 60 , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'CPF/CNPJ'           , 18 , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'Representante Atual', 26 , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'Novo Representante' , 26 , alEsquerda , teAutcom);
    objTabela.lstLinhas.Add(objLinha);

    dtsClientes.DataSet.First;
    While Not dtsClientes.DataSet.Eof do
    Begin
      strValorNovo := dtsClientes.DataSet.FieldByName('CLI_CODREP').AsString;
      strValorAnte := dtsClientes.DataSet.FieldByName('CLI_CODREP_ORI').AsString;

      If strValorAnte <> strValorNovo then
      Begin
        blnTemValidacao := True;

        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlValor;
        objLinha.pAddColuna('Cliente'            , dtsClientes.DataSet.FieldByName('CLI_CODCLI').AsString + '-' + dtsClientes.DataSet.FieldByName('CLI_NOMCLI').AsString, 60 , alEsquerda , teAutcom);
        objLinha.pAddColuna('CPF/CNPJ'           , fFormataCpfCgc(dtsClientes.DataSet.FieldByName('CLI_C_G_C_').AsString, fSetaPais), 18, alEsquerda, teAutcom);
        objLinha.pAddColuna('Representante Atual', strValorAnte + '-' + dtsClientes.DataSet.FieldByName('OPE_NOMREP_ORI').AsString  , 26, alEsquerda, teAutcom);
        objLinha.pAddColuna('Novo Representante' , strValorNovo + '-' + fRetNomeOperador(strValorNovo)                              , 26, alEsquerda, teAutcom);
        objTabela.lstLinhas.Add(objLinha);
      End;

      dtsClientes.DataSet.Next;
    End;

    if blnTemValidacao then
    begin
      If (Not fPermitirAlterarVendedorERepresentante) Then
      Begin
        objLiberacao.Clear;
        objLiberacao.strDirAce    := 'ALTVCL';
        objLiberacao.strSenLib    := fCfgSis('SENVEN');
        objLiberacao.strMsgSen    := 'Representante';
        objLiberacao.strCodOpe    := strLoginUsuarioLogado;
        objLiberacao.strCodDig    := strLoginUsuarioLogado;
        objLiberacao.objMsgLibera.pAddTexto('Troca de Representante no Cadastro de Cliente.');
        objLiberacao.objMsgLibera.pAddQuebra();

        objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

        Result := objLiberacao.fLibera;
      End;
    end;
  Finally
    dtsClientes.DataSet.Filtered := False;
    dtsClientes.DataSet.Filter := '';
    dtsClientes.DataSet.EnableControls;
  End;
end;

function TfrmConfirmaGlobalClientes.fValidaVendedor: Boolean;
var
  strValorNovo: String;
  strValorAnte: String;
  blnTemValidacao: Boolean;
  objTabela : TRegistroMsgLiberaTabela;
  objLinha  : TLinhaMsgLibera;
begin
  Result := True;

  If Not fCampoNoArray('CLI_CODVEN') Then
    Exit;

  blnTemValidacao := False;

  dtsClientes.DataSet.DisableControls;
  Try
    dtsClientes.DataSet.Filter := '(CLI_MARDES = ''M'')';
    dtsClientes.DataSet.Filtered := True;

    objTabela := TRegistroMsgLiberaTabela.Create();

    objLinha  := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlCabecalho;
    objLinha.pAddColuna(''  , 'Cliente'            , 60 , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'CPF/CNPJ'           , 18 , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'Vendedor Atual', 26 , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'Novo Vendedor' , 26 , alEsquerda , teAutcom);
    objTabela.lstLinhas.Add(objLinha);

    dtsClientes.DataSet.First;
    While Not dtsClientes.DataSet.Eof do
    Begin
      strValorNovo := dtsClientes.DataSet.FieldByName('CLI_CODVEN').AsString;
      strValorAnte := dtsClientes.DataSet.FieldByName('CLI_CODVEN_ORI').AsString;

      If strValorAnte <> strValorNovo then
      Begin
        blnTemValidacao := True;

        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlValor;
        objLinha.pAddColuna('Cliente'            , dtsClientes.DataSet.FieldByName('CLI_CODCLI').AsString + '-' + dtsClientes.DataSet.FieldByName('CLI_NOMCLI').AsString, 60 , alEsquerda , teAutcom);
        objLinha.pAddColuna('CPF/CNPJ'           , fFormataCpfCgc(dtsClientes.DataSet.FieldByName('CLI_C_G_C_').AsString, fSetaPais), 18, alEsquerda, teAutcom);
        objLinha.pAddColuna('Vendedor Atual', strValorAnte + '-' + dtsClientes.DataSet.FieldByName('OPE_NOMVEN_ORI').AsString       , 26, alEsquerda, teAutcom);
        objLinha.pAddColuna('Novo Vendedor' , strValorNovo + '-' + fRetNomeOperador(strValorNovo)                                   , 26, alEsquerda, teAutcom);
        objTabela.lstLinhas.Add(objLinha);
      End;

      dtsClientes.DataSet.Next;
    End;

    if blnTemValidacao then
    begin
      If (Not fPermitirAlterarVendedorERepresentante) Then
      Begin
        objLiberacao.Clear;
        objLiberacao.strDirAce    := 'ALTVCL';
        objLiberacao.strSenLib    := fCfgSis('SENVEN');
        objLiberacao.strMsgSen    := 'Vendedor';
        objLiberacao.strCodOpe    := strLoginUsuarioLogado;
        objLiberacao.strCodDig    := strLoginUsuarioLogado;
        objLiberacao.objMsgLibera.pAddTexto('Troca de Vendedor no Cadastro de Cliente.');
        objLiberacao.objMsgLibera.pAddQuebra();

        objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

        Result := objLiberacao.fLibera;
      End;
    end;
  Finally
    dtsClientes.DataSet.Filtered := False;
    dtsClientes.DataSet.Filter := '';
    dtsClientes.DataSet.EnableControls;
  End;
end;

function TfrmConfirmaGlobalClientes.fValidaTipoCliente: Boolean;
var
  strValorNovo: String;
  strValorAnte: String;
  blnTemValidacao: Boolean;
  objTabela : TRegistroMsgLiberaTabela;
  objLinha  : TLinhaMsgLibera;
begin
  Result := True;

  If Not fCampoNoArray('CLI_TIPCLI') Then
    Exit;

  If fEmptyStr( fCfgSis('SENTCL')) Then
    Exit;

  blnTemValidacao := False;

  dtsClientes.DataSet.DisableControls;
  Try
    dtsClientes.DataSet.Filter := '(CLI_MARDES = ''M'')';
    dtsClientes.DataSet.Filtered := True;

    objTabela := TRegistroMsgLiberaTabela.Create();

    objLinha  := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlCabecalho;
    objLinha.pAddColuna(''  , 'Cliente'              , 60 , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'CPF/CNPJ'             , 18 , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'Tipo de Cliente Atual', 26 , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'Novo Tipo de Cliente' , 26 , alEsquerda , teAutcom);
    objTabela.lstLinhas.Add(objLinha);

    dtsClientes.DataSet.First;
    While Not dtsClientes.DataSet.Eof do
    Begin
      strValorNovo := dtsClientes.DataSet.FieldByName('CLI_TIPCLI').AsString;
      strValorAnte := dtsClientes.DataSet.FieldByName('CLI_TIPCLI_ORI').AsString;

      If strValorAnte <> strValorNovo then
      Begin
        blnTemValidacao := True;

        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlValor;
        objLinha.pAddColuna('Cliente'              , dtsClientes.DataSet.FieldByName('CLI_CODCLI').AsString + '-' + dtsClientes.DataSet.FieldByName('CLI_NOMCLI').AsString, 60 , alEsquerda , teAutcom);
        objLinha.pAddColuna('CPF/CNPJ'             , fFormataCpfCgc(dtsClientes.DataSet.FieldByName('CLI_C_G_C_').AsString, fSetaPais), 18, alEsquerda, teAutcom);
        objLinha.pAddColuna('Tipo de Cliente Atual', strValorAnte + '-' + dtsClientes.DataSet.FieldByName('TIP_DESTIP_ORI').AsString  , 26, alEsquerda, teAutcom);
        objLinha.pAddColuna('Novo Tipo de Cliente' , strValorNovo + '-' + fRetDescTipoCli(strValorNovo)                               , 26, alEsquerda, teAutcom);
        objTabela.lstLinhas.Add(objLinha);
      End;

      dtsClientes.DataSet.Next;
    End;

    If blnTemValidacao Then
    Begin
      objLiberacao.Clear;
      objLiberacao.strDirAce    := 'ALTTPC';
      objLiberacao.strSenLib    := fCfgSis('SENTCL');
      objLiberacao.strMsgSen    := 'Tipo de Cliente';
      objLiberacao.strCodOpe    := strLoginUsuarioLogado;
      objLiberacao.strCodDig    := strLoginUsuarioLogado;
      objLiberacao.objMsgLibera.pAddTexto('Troca de tipo de cliente no Cadastro de Cliente.');
      objLiberacao.objMsgLibera.pAddQuebra();

      objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

      Result := objLiberacao.fLibera;
    End;
  Finally
    dtsClientes.DataSet.Filtered := False;
    dtsClientes.DataSet.Filter := '';
    dtsClientes.DataSet.EnableControls;
  End;
end;

function TfrmConfirmaGlobalClientes.fValidaTabelaPreco: Boolean;
var
  strValorNovo: String;
  strValorAnte: String;
  blnTemValidacao: Boolean;
  objTabela : TRegistroMsgLiberaTabela;
  objLinha  : TLinhaMsgLibera;
begin
  Result := True;

  If Not fCampoNoArray('CLI_TABPRE') Then
    Exit;

  If Not (fCfgSis('SENTTP', varString) = 'S') Then
    Exit;

  blnTemValidacao := False;

  dtsClientes.DataSet.DisableControls;
  Try
    dtsClientes.DataSet.Filter := '(CLI_MARDES = ''M'')';
    dtsClientes.DataSet.Filtered := True;

    objTabela := TRegistroMsgLiberaTabela.Create();

    objLinha  := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlCabecalho;
    objLinha.pAddColuna(''  , 'Cliente'              , 60 , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'CPF/CNPJ'             , 18 , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'Tabela de Preço Atual', 25 , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'Nova Tabela de Preço' , 25 , alEsquerda , teAutcom);
    objTabela.lstLinhas.Add(objLinha);

    dtsClientes.DataSet.First;
    While Not dtsClientes.DataSet.Eof do
    Begin
      strValorNovo := dtsClientes.DataSet.FieldByName('CLI_TABPRE').AsString;
      strValorAnte := dtsClientes.DataSet.FieldByName('CLI_TABPRE_ORI').AsString;

      If strValorAnte <> strValorNovo then
      Begin
        blnTemValidacao := True;

        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlValor;
        objLinha.pAddColuna('Cliente'              , dtsClientes.DataSet.FieldByName('CLI_CODCLI').AsString + '-' + dtsClientes.DataSet.FieldByName('CLI_NOMCLI').AsString, 60 , alEsquerda , teAutcom);
        objLinha.pAddColuna('CPF/CNPJ'             , fFormataCpfCgc(dtsClientes.DataSet.FieldByName('CLI_C_G_C_').AsString, fSetaPais), 18, alEsquerda, teAutcom);
        objLinha.pAddColuna('Tabela de Preço Atual', strValorAnte                                                                     , 25, alEsquerda, teAutcom);
        objLinha.pAddColuna('Nova Tabela de Preço' , strValorNovo                                                                     , 25, alEsquerda, teAutcom);
        objTabela.lstLinhas.Add(objLinha);
      End;

      dtsClientes.DataSet.Next;
    End;

    If blnTemValidacao Then
    Begin
      objLiberacao.Clear;
      objLiberacao.strDirAce    := 'CLIPRE';
      objLiberacao.strSenLib    := fCfgSis('SENTPC');
      objLiberacao.strMsgSen    := 'Tabela de Preço do Cliente';
      objLiberacao.strCodOpe    := strLoginUsuarioLogado;
      objLiberacao.strCodDig    := strLoginUsuarioLogado;
      objLiberacao.objMsgLibera.pAddTexto('Troca de tabela de preço no Cadastro de Cliente.');
      objLiberacao.objMsgLibera.pAddQuebra();

      objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

      Result := objLiberacao.fLibera;
    End;
  Finally
    dtsClientes.DataSet.Filtered := False;
    dtsClientes.DataSet.Filter := '';
    dtsClientes.DataSet.EnableControls;
  End;
end;

function TfrmConfirmaGlobalClientes.fValidaPortador1: Boolean;
  Var
    objTabela : TRegistroMsgLiberaTabela;
    objLinha  : TLinhaMsgLibera;
begin
  Result := True;

  If Not fCampoNoArray('CLI_CODPOR') Then
    Exit;

  dtsClientes.DataSet.DisableControls;
  Try
    If (Not fEmptyStr(fCfgSis('SENPOR'))) Then
    begin
      dtsClientes.DataSet.Filter := '(CLI_MARDES = ''M'') AND (CLI_CODPOR = '''')';
      dtsClientes.DataSet.Filtered := True;

      If (Not dtsClientes.DataSet.IsEmpty) then
      begin
        objLiberacao.Clear;
        objLiberacao.strDirAce    := 'CLIPOR';
        objLiberacao.strSenLib    := fCfgSis('SENPOR');
        objLiberacao.strMsgSen    := 'Portador (1) em branco';
        objLiberacao.strCodOpe    := strLoginUsuarioLogado;
        objLiberacao.strCodDig    := strLoginUsuarioLogado;
        objLiberacao.objMsgLibera.pAddTexto('Portador (1) em branco.');
        objLiberacao.objMsgLibera.pAddQuebra();

        objTabela := TRegistroMsgLiberaTabela.Create();

        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlCabecalho;
        objLinha.pAddColuna(''  , 'Cliente'         , 60 , alEsquerda , teAutcom);
        objLinha.pAddColuna(''  , 'CPF/CNPJ'        , 18 , alEsquerda , teAutcom);
        objLinha.pAddColuna(''  , 'Portador 1 Atual', 26 , alEsquerda , teAutcom);
        objTabela.lstLinhas.Add(objLinha);

        dtsClientes.DataSet.First;
        While not dtsClientes.DataSet.Eof Do
        Begin
          objLinha  := TLinhaMsgLibera.Create;
          objLinha.enuTipoLinha := tlValor;
          objLinha.pAddColuna('Cliente'          , dtsClientes.DataSet.FieldByName('CLI_CODCLI').AsString + '-' + dtsClientes.DataSet.FieldByName('CLI_NOMCLI').AsString, 60 , alEsquerda , teAutcom);
          objLinha.pAddColuna('CPF/CNPJ'         , fFormataCpfCgc(dtsClientes.DataSet.FieldByName('CLI_C_G_C_').AsString, fSetaPais), 18 , alEsquerda , teAutcom);
          objLinha.pAddColuna('Portador 1 Atual' , dtsClientes.DataSet.FieldByName('CLI_CODPOR_ORI').AsString + '-' + dtsClientes.DataSet.FieldByName('POR_NOMPOR_ORI').AsString, 26 , alEsquerda , teAutcom);
          objTabela.lstLinhas.Add(objLinha);

          dtsClientes.DataSet.Next;
        End;

        objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

        Result := objLiberacao.fLibera;

        If (Not Result) Then
        Begin
          pMensagemOk('A liberação do Portador (1) não foi realizada!');
          Exit(False);
        End;
      end;
    end;

    if (Not fEmptyStr(fCfgSis('SENTPO'))) then
    begin
      dtsClientes.DataSet.Filter := '(CLI_MARDES = ''M'') AND (CLI_CODPOR <> '''')';
      dtsClientes.DataSet.Filtered := True;

      if not dtsClientes.DataSet.IsEmpty then
      begin
        objLiberacao.Clear;
        objLiberacao.strDirAce    := 'ALTPOR';
        objLiberacao.strSenLib    := fCfgSis('SENTPO');
        objLiberacao.strMsgSen    := 'Portador';
        objLiberacao.strCodOpe    := strLoginUsuarioLogado;
        objLiberacao.strCodDig    := strLoginUsuarioLogado;
        objLiberacao.objMsgLibera.pAddTexto('Troca de portador 1 no Cadastro de Cliente.');
        objLiberacao.objMsgLibera.pAddQuebra();

        objTabela := TRegistroMsgLiberaTabela.Create();

        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlCabecalho;
        objLinha.pAddColuna(''  , 'Cliente'         , 60 , alEsquerda , teAutcom);
        objLinha.pAddColuna(''  , 'CPF/CNPJ'        , 18 , alEsquerda , teAutcom);
        objLinha.pAddColuna(''  , 'Portador 1 Atual', 26 , alEsquerda , teAutcom);
        objLinha.pAddColuna(''  , 'Novo Portador 1' , 26 , alEsquerda , teAutcom);
        objTabela.lstLinhas.Add(objLinha);

        dtsClientes.DataSet.First;
        while not dtsClientes.DataSet.eof do
        begin
          objLinha  := TLinhaMsgLibera.Create;
          objLinha.enuTipoLinha := tlValor;
          objLinha.pAddColuna('Cliente'          , dtsClientes.DataSet.FieldByName('CLI_CODCLI').AsString + '-' + dtsClientes.DataSet.FieldByName('CLI_NOMCLI').AsString, 60 , alEsquerda , teAutcom);
          objLinha.pAddColuna('CPF/CNPJ'         , fFormataCpfCgc(dtsClientes.DataSet.FieldByName('CLI_C_G_C_').AsString, fSetaPais), 18 , alEsquerda , teAutcom);
          objLinha.pAddColuna('Portador 1 Atual' , dtsClientes.DataSet.FieldByName('CLI_CODPOR_ORI').AsString + ' ' + dtsClientes.DataSet.FieldByName('POR_NOMPOR_ORI').AsString, 26 , alEsquerda , teAutcom);
          objLinha.pAddColuna('Novo Portador 1'  , dtsClientes.DataSet.FieldByName('CLI_CODPOR').AsString + ' ' + fRetNomPortador(dtsClientes.DataSet.FieldByName('CLI_CODPOR').AsString), 26 , alEsquerda , teAutcom);
          objTabela.lstLinhas.Add(objLinha);

          dtsClientes.DataSet.Next;
        end;

        objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

        Result := objLiberacao.fLibera;
      end;
    end;
  Finally
    dtsClientes.DataSet.Filtered := False;
    dtsClientes.DataSet.Filter := '';
    dtsClientes.DataSet.EnableControls;
  End;
end;

function TfrmConfirmaGlobalClientes.fValidaPortador2: Boolean;
  Var
    objTabela : TRegistroMsgLiberaTabela;
    objLinha  : TLinhaMsgLibera;
begin
  Result := True;

  If Not fCampoNoArray('CLI_CODPO2') Then
    Exit;

  dtsClientes.DataSet.DisableControls;
  Try
    If (Not fEmptyStr(fCfgSis('SENPO2'))) Then
    begin
      dtsClientes.DataSet.Filter := '(CLI_MARDES = ''M'') AND (CLI_CODPO2 = '''')';
      dtsClientes.DataSet.Filtered := True;

      If (Not dtsClientes.DataSet.IsEmpty) then
      begin
        objLiberacao.Clear;
        objLiberacao.strDirAce    := 'CLIPOR';
        objLiberacao.strSenLib    := fCfgSis('SENPO2');
        objLiberacao.strMsgSen    := 'Portador (2) em branco';
        objLiberacao.strCodOpe    := strLoginUsuarioLogado;
        objLiberacao.strCodDig    := strLoginUsuarioLogado;
        objLiberacao.objMsgLibera.pAddTexto('Portador (2) em branco.');
        objLiberacao.objMsgLibera.pAddQuebra();

        objTabela := TRegistroMsgLiberaTabela.Create();

        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlCabecalho;
        objLinha.pAddColuna(''  , 'Cliente'         , 60 , alEsquerda , teAutcom);
        objLinha.pAddColuna(''  , 'CPF/CNPJ'        , 18 , alEsquerda , teAutcom);
        objLinha.pAddColuna(''  , 'Portador 2 Atual', 26 , alEsquerda , teAutcom);
        objTabela.lstLinhas.Add(objLinha);

        dtsClientes.DataSet.First;
        While not dtsClientes.DataSet.Eof Do
        Begin
          objLinha  := TLinhaMsgLibera.Create;
          objLinha.enuTipoLinha := tlValor;
          objLinha.pAddColuna('Cliente'          , dtsClientes.DataSet.FieldByName('CLI_CODCLI').AsString + '-' + dtsClientes.DataSet.FieldByName('CLI_NOMCLI').AsString, 60 , alEsquerda , teAutcom);
          objLinha.pAddColuna('CPF/CNPJ'         , fFormataCpfCgc(dtsClientes.DataSet.FieldByName('CLI_C_G_C_').AsString, fSetaPais), 18 , alEsquerda , teAutcom);
          objLinha.pAddColuna('Portador 2 Atual' , dtsClientes.DataSet.FieldByName('CLI_CODPO2_ORI').AsString + '-' + fRetNomPortador(dtsClientes.DataSet.FieldByName('CLI_CODPO2_ORI').AsString), 26 , alEsquerda , teAutcom);
          objTabela.lstLinhas.Add(objLinha);

          dtsClientes.DataSet.Next;
        End;

        objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

        Result := objLiberacao.fLibera;

        If (Not Result) Then
        Begin
          pMensagemOk('A liberação do Portador (2) não foi realizada!');
          Exit(False);
        End;
      end;
    end;

    if (Not fEmptyStr(fCfgSis('SENTPO'))) then
    begin
      dtsClientes.DataSet.Filter := '(CLI_MARDES = ''M'') AND (CLI_CODPO2 <> '''')';
      dtsClientes.DataSet.Filtered := True;

      if not dtsClientes.DataSet.IsEmpty then
      begin
        objLiberacao.Clear;
        objLiberacao.strDirAce    := 'ALTPOR';
        objLiberacao.strSenLib    := fCfgSis('SENTPO');
        objLiberacao.strMsgSen    := 'Portador';
        objLiberacao.strCodOpe    := strLoginUsuarioLogado;
        objLiberacao.strCodDig    := strLoginUsuarioLogado;
        objLiberacao.objMsgLibera.pAddTexto('Troca de portador 2 no Cadastro de Cliente.');
        objLiberacao.objMsgLibera.pAddQuebra();

        objTabela := TRegistroMsgLiberaTabela.Create();

        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlCabecalho;
        objLinha.pAddColuna(''  , 'Cliente'         , 60 , alEsquerda , teAutcom);
        objLinha.pAddColuna(''  , 'CPF/CNPJ'        , 18 , alEsquerda , teAutcom);
        objLinha.pAddColuna(''  , 'Portador 2 Atual', 26 , alEsquerda , teAutcom);
        objLinha.pAddColuna(''  , 'Novo Portador 2' , 26 , alEsquerda , teAutcom);
        objTabela.lstLinhas.Add(objLinha);

        dtsClientes.DataSet.First;
        while not dtsClientes.DataSet.eof do
        begin
          objLinha  := TLinhaMsgLibera.Create;
          objLinha.enuTipoLinha := tlValor;
          objLinha.pAddColuna('Cliente'          , dtsClientes.DataSet.FieldByName('CLI_CODCLI').AsString + '-' + dtsClientes.DataSet.FieldByName('CLI_NOMCLI').AsString, 60 , alEsquerda , teAutcom);
          objLinha.pAddColuna('CPF/CNPJ'         , fFormataCpfCgc(dtsClientes.DataSet.FieldByName('CLI_C_G_C_').AsString, fSetaPais), 18 , alEsquerda , teAutcom);
          objLinha.pAddColuna('Portador 2 Atual' , dtsClientes.DataSet.FieldByName('CLI_CODPO2_ORI').AsString + ' ' + dtsClientes.DataSet.FieldByName('POR_NOMPO2_ORI').AsString, 26 , alEsquerda , teAutcom);
          objLinha.pAddColuna('Novo Portador 2'  , dtsClientes.DataSet.FieldByName('CLI_CODPO2').AsString + ' ' + fRetNomPortador(dtsClientes.DataSet.FieldByName('CLI_CODPO2').AsString), 26 , alEsquerda , teAutcom);
          objTabela.lstLinhas.Add(objLinha);

          dtsClientes.DataSet.Next;
        end;

        objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

        Result := objLiberacao.fLibera;
      end;
    end;
  Finally
    dtsClientes.DataSet.Filtered := False;
    dtsClientes.DataSet.Filter := '';
    dtsClientes.DataSet.EnableControls;
  End;
end;

function TfrmConfirmaGlobalClientes.fCampoNoArray(strCampo: String): Boolean;
  Var
    intTamMat : Integer;
    intContador : Integer;
begin
  Result := False;

  intTamMat := Length(arrCamposGrid);
  intContador := 0;
  While intContador < intTamMat Do
  Begin
    If (arrCamposGrid[intContador].strNomCam = strCampo) Then
      Exit(True);

    Inc(intContador);
  End;
end;

procedure TfrmConfirmaGlobalClientes.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  If Not fTemItemParaAlterar Then
  Begin
    fMensagem('', 'Não há clientes marcados para serem alterados!', ['&O k']);
    Exit;
  End;

  If (Not btnConfirma.Enabled) Then
    Exit;

  If (fMensagem('', 'Confirma a operação?', ['&Sim', '&Não']) > 1) Then
  Begin
    pSetFocus(Self);
    Exit;
  End;

  If (Not fValidaLiberacoes) Then
    Exit;

  btnConfirma.Enabled := False;
  btnVoltar.Enabled   := False;
  Try
    Screen.Cursor := crHourGlass;

    If fConfirmaAlteracoes Then
    Begin
      blnConfirma := True;
      Screen.Cursor := crDefault;
      fMensagem('', 'Alteração dos clientes concluída com sucesso!', ['&O k']);
      Close;
    End;
  Finally
    btnConfirma.Enabled := True;
    btnVoltar.Enabled   := True;
    Screen.Cursor := crDefault;
  End;
end;

procedure TfrmConfirmaGlobalClientes.FormCreate(Sender: TObject);
begin
  inherited;
  objLiberacao := TLiberacao.Create;
  blnConfirma := False;
  blnLiberacaoPortador1 := False;
end;

procedure TfrmConfirmaGlobalClientes.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(objLiberacao);
end;

procedure TfrmConfirmaGlobalClientes.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If (Key = VK_F10) Then
    btnConfirma.Click
  Else If (Key = VK_F3) Then
    btnMarTod.Click
  Else If (Key = VK_F4) Then
    btnDesTod.Click
  Else If (Key = VK_Escape) Then
    btnVoltar.Click;
end;

procedure TfrmConfirmaGlobalClientes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(qryIteCom);
end;

end.


