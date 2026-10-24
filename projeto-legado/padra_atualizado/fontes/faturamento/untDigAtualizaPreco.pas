unit untDigAtualizaPreco;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.Mask, MaskEditFocus, EditFocus, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, MemDS, DBAccess, Uni,
  Datasnap.DBClient, Datasnap.Provider, UniClientDataSet, untTypesSistema,
  cxImageComboBox, System.ImageList, Vcl.ImgList, cxImageList;

type
  TfrmDigAtualizaPreco = class(TfrmPaiConfirma)
    pnlFiltros: TPanel;
    pnlDocumentos: TPanel;
    rdgTipoDocumento: TRadioGroup;
    lblCliente: TLabel;
    edtCodCli: TEditFocus;
    edtDesCli: TEditFocus;
    lblEmpresa: TLabel;
    edtCodEmp: TEditFocus;
    edtDesEmp: TEditFocus;
    btnFiltrar: TBitBtnLocked;
    Label4: TLabel;
    mskDtaIni: TMaskEditFocus;
    Label6: TLabel;
    mskDtaFin: TMaskEditFocus;
    grdConsultaDBTableView1: TcxGridDBTableView;
    grdConsultaLevel1: TcxGridLevel;
    grdConsulta: TcxGrid;
    btnMarcarDesmarcarTodos: TBitBtnLocked;
    grdConsultaDBTableViewCODEMP: TcxGridDBColumn;
    grdConsultaDBTableViewNUMDOC: TcxGridDBColumn;
    grdConsultaDBTableViewESPDOC: TcxGridDBColumn;
    grdConsultaDBTableViewCODCLI: TcxGridDBColumn;
    grdConsultaDBTableViewNOMCLI: TcxGridDBColumn;
    grdConsultaDBTableViewDTAENT: TcxGridDBColumn;
    grdConsultaDBTableViewHORENT: TcxGridDBColumn;
    grdConsultaDBTableViewMARDES: TcxGridDBColumn;
    cdsConsulta: TUniClientDataSet;
    dtsConsulta: TDataSource;
    cdsConsultaFGO_CODEMP: TStringField;
    cdsConsultaFGO_NUMDOC: TStringField;
    cdsConsultaFGO_ESPDOC: TStringField;
    cdsConsultaFGO_CODCLI: TStringField;
    cdsConsultaCLI_NOMCLI: TStringField;
    cdsConsultaFGO_DTAENT: TDateField;
    cdsConsultaFGO_HORENT: TTimeField;
    cdsConsultaFGO_MARDES: TStringField;
    btnValidaPreco: TBitBtnLocked;
    grdConsultaDBTableViewVALIDA: TcxGridDBColumn;
    cdsConsultaFGO_VALIDA: TIntegerField;
    cxImageList1: TcxImageList;
    grdConsultaTableView1: TcxGridTableView;
    grdConsultaLevel2: TcxGridLevel;
    grdConsultaDBTableView2: TcxGridDBTableView;
    grdConsultaDBTableViewTRAVAS: TcxGridDBColumn;
    cdsTrava: TUniClientDataSet;
    dtsTrava: TDataSource;
    cdsTravaAUTOINCREM: TStringField;
    cdsTravaTRAVAS: TStringField;
    cdsConsultaAUTOINCREM: TStringField;
    procedure btnFiltrarClick(Sender: TObject);
    procedure grdConsultaDBTableView1CustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure grdConsultaDBTableView1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure btnMarcarDesmarcarTodosClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure mskDtaIniExit(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnValidaPrecoClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    arrEmpres,
    arrClientes: TConsultasArray;

    procedure pBuscaDocumentos;
    procedure pMarcaDesmarca;
    procedure pMarcaDesmarcaTodos;
    procedure pDesmarcaTodos;
    procedure pAtualizaDocumento(strAcao: string);
    procedure pAlteraPrecoDocumento(strCodEmp, strNumDoc, strEspDoc, strAcao: string; tpPrecoImpItem: TTipoPrecoImpItem);
    procedure pTabelaAtualSemDesconto(strCodEmp: string);
    procedure pTabelaAtualComDesconto(strCodEmp: string);
    procedure pOriginalSemDesconto(strCodEmp: string);
    procedure pOriginalComDesconto(strCodEmp: string);
    function  fBuscaValorTabPre(strCodEmp, strCodIte, strTabPre: string): Double;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;


implementation

uses
  untFuncoesSimples, untGravando, untConsultas, untFatDigPreco,
  Faturamento.Classes.TAlterarPedido, untFuncFat;

{$R *.dfm}

procedure TfrmDigAtualizaPreco.btnConfirmaClick(Sender: TObject);
begin
  pAtualizaDocumento('A');
end;

procedure TfrmDigAtualizaPreco.btnFiltrarClick(Sender: TObject);
begin
  inherited;
  if (fVerificaCampos) then
  begin
    TfrmGravando.fExecutarModal(pBuscaDocumentos, 'Aguarde... Carregando documentos.', '');
  end;
end;

procedure TfrmDigAtualizaPreco.btnMarcarDesmarcarTodosClick(Sender: TObject);
begin
  inherited;
  pMarcaDesmarcaTodos;
end;

procedure TfrmDigAtualizaPreco.btnValidaPrecoClick(Sender: TObject);
begin
  inherited;
  pAtualizaDocumento('V');
end;

procedure TfrmDigAtualizaPreco.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if fPesqCliente(conCliSimples, Self, edtCodCli, edtDesCli, Nil, Key, arrClientes, False) then
  begin
    fValidaCampos(edtCodCli, True);
    SelectNext(ActiveControl, True, True);
  end;
end;

procedure TfrmDigAtualizaPreco.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtDesEmp, Nil, Key, arrEmpres, False) then
  begin
    fValidaCampos(edtCodEmp, True);
    SelectNext(ActiveControl, True, True);
  end;
end;

function TfrmDigAtualizaPreco.fBuscaValorTabPre(strCodEmp, strCodIte,
  strTabPre: string): Double;
var
  qryTabPre: TUniQuery;
begin
  Result := 0;

  if (fEmptyStr(strCodEmp)) or (fEmptyStr(strCodIte)) or (fEmptyStr(strTabPre)) then
  begin
    Exit;
  end;

  strTabPre := 'ITE_PREVE' + strTabPre;
  qryTabPre := fCriaQuery;
  try


    qryTabPre.Close;
    qryTabPre.SQL.Clear;
    qryTabPre.SQL.Add('SELECT '+strTabPre+' AS TABPRE FROM ITEGER');
    qryTabPre.SQL.Add('WHERE ITE_CODITE = :CODITE AND ITE_CODEMP = :CODEMP');
    qryTabPre.ParamByName('CODITE').AsString := strCodIte;
    qryTabPre.ParamByName('CODEMP').AsString := strCodEmp;
    qryTabPre.Open;

    Result := qryTabPre.FieldByName('TABPRE').AsFloat;
  finally
    FreeAndNil(qryTabPre);
  end;
end;

procedure TfrmDigAtualizaPreco.FormCreate(Sender: TObject);
begin
  inherited;
  cdsConsulta.CreateDataSet;
  cdsTrava.CreateDataSet;
end;

procedure TfrmDigAtualizaPreco.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  case key of
    VK_F2: pMarcaDesmarcaTodos;
    VK_F3: pAtualizaDocumento('V');
  end;
end;

procedure TfrmDigAtualizaPreco.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(TRadioGroup(rdgTipoDocumento.Controls[0]));
end;

function TfrmDigAtualizaPreco.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  if Sender = (mskDtaFin) then
  begin
    if (fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) and (not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) then
    begin
      fMensagem('ATENÇÃO!', 'Preencha a data inicial!', ['&Ok']);
      pSetFocus(mskDtaIni);
      Result := False;
    end;

    if (not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) and (fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) then
    begin
      fMensagem('ATENÇÃO!', 'Preencha a data final!', ['&Ok']);
      pSetFocus(mskDtaFin);
      Result := False;
    end;

    if (not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) and (not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) and (StrToDate(mskDtaFin.Text) < (StrToDate(mskDtaIni.Text))) then
    begin
      fMensagem('ATENÇÃO!', 'Data final não pode ser menor que a data inicial!', ['&Ok']);
      pSetFocus(mskDtaFin);
      Result := False;
    end;
  end;

  if Sender = (edtCodCli) then
  begin
    if Length(edtCodCli.Text) = 8 then
    begin
      edtDesCli.Text := fRetNomCliente(edtCodCli.Text);
    end;

    if (not fEmptyStr(edtCodCli.Text)) and (fEmptyStr(edtDesCli.Text)) then
    begin
      fMensagem('ATENÇÃO!', 'Cliente não encontrado!', ['&Ok']);
      edtCodCli.Clear;
      pSetFocus(edtCodCli);
      Result := False;
    end;
  end;

  if Sender = (edtCodEmp) then
  begin
    if Length(edtCodEmp.Text) = 3 then
    begin
      edtDesEmp.Text := fRetNomeEmpresa(edtCodEmp.Text);
    end;

    if (not fEmptyStr(edtCodEmp.Text)) and (fEmptyStr(edtDesEmp.Text)) then
    begin
      fMensagem('ATENÇÃO!', 'Empresa não encontrada!', ['&Ok']);
      edtCodEmp.Clear;
      pSetFocus(edtCodEmp);
      Result := False;
    end;
  end;
end;

procedure TfrmDigAtualizaPreco.grdConsultaDBTableView1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If (AViewInfo.GridRecord.Values[grdConsultaDBTableViewMARDES.Index] = 'M') Then
  Begin
    ACanvas.Brush.Color := clBlue;
    ACanvas.Font.Color := clWhite;
  End
  Else
  Begin
    ACanvas.Brush.Color := clWhite;
    ACanvas.Font.Color := clBlack;
  End;
end;

procedure TfrmDigAtualizaPreco.grdConsultaDBTableView1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  case key of
    VK_RETURN: pMarcaDesmarca;
    VK_SPACE: pMarcaDesmarca;
  end;
end;

procedure TfrmDigAtualizaPreco.mskDtaIniExit(Sender: TObject);
begin
  inherited;
  if (not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) and (fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) then
  begin
    mskDtaFin.Text := DateToStr(fNow);
  end;
end;

procedure TfrmDigAtualizaPreco.pAlteraPrecoDocumento(strCodEmp, strNumDoc,
  strEspDoc, strAcao: string; tpPrecoImpItem: TTipoPrecoImpItem);
var
  objAltPed: TAlterarPedido;
begin
  objAltPed := TAlterarPedido.Create(nil);
  try
    objAltPed.strEmpPed := strCodEmp;
    objAltPed.strNumPed := strNumDoc;
    objAltPed.strEspPed := strEspDoc;

    if objAltPed.fCarregarPedido then
    begin
      objAltPed.blnSolicitouAlteracaoPreco := True;
      cdsVenda.First;
      while not cdsVenda.Eof do
      begin
        case tpPrecoImpItem of
          tpNenhumaDefinicao:                  pTabelaAtualSemDesconto(strCodEmp);
          tpPrecoTabelaAtualSemDesconto:       pTabelaAtualSemDesconto(strCodEmp);
          tpPrecoTabelaAtualComDesconto:       pTabelaAtualComDesconto(strCodEmp);
          tpPrecoDocumentoOriginalSemDesconto: pOriginalSemDesconto(strCodEmp);
          tpPrecoDocumentoOriginalComDesconto: pOriginalComDesconto(strCodEmp);
        end;
        cdsVenda.Next;
      end;

      if strAcao = 'V' then
      begin
        if (tpPrecoImpItem = tpPrecoTabelaAtualSemDesconto) or
           (tpPrecoImpItem = tpPrecoDocumentoOriginalSemDesconto) or
           (tpPrecoImpItem = tpNenhumaDefinicao) then
        begin
          objAltPed.objVenda.fltPorDes := 0;
          objAltPed.objVenda.fltPorDesTmp := 0;
          objAltPed.objVenda.fltDesEsp := 0;
        end;
        if objAltPed.fCalculaTotalPedido then
        begin
          if cdsConsulta.Locate('FGO_CODEMP;FGO_NUMDOC;FGO_ESPDOC', VarArrayOf([strCodEmp, strNumDoc, strEspDoc]), []) then
          begin
            cdsConsulta.Edit;
            if objAltPed.fDocumentoSemTravaDePreco then
            begin
              cdsConsulta.FieldByName('FGO_VALIDA').AsInteger := 1;
              if cdsTrava.Locate('AUTOINCREM',cdsConsulta.FieldByName('AUTOINCREM').AsString,[]) then
              begin
                cdsTrava.Edit;
                cdsTrava.FieldByName('TRAVAS').AsString := 'Nenhuma trava encontrada.';
                cdsTrava.Post;
              end;
            end
            else
            begin
              cdsConsulta.FieldByName('FGO_VALIDA').AsInteger := 2;
              if cdsTrava.Locate('AUTOINCREM',cdsConsulta.FieldByName('AUTOINCREM').AsString,[]) then
              begin
                cdsTrava.Edit;
                cdsTrava.FieldByName('TRAVAS').AsString := strMensagemTravaPreco;
                cdsTrava.Post;
              end;
            end;
            cdsConsulta.Post;
          end;
        end;
      end
      else if strAcao = 'A' then
      begin
        if (tpPrecoImpItem = tpPrecoTabelaAtualSemDesconto) or
           (tpPrecoImpItem = tpPrecoDocumentoOriginalSemDesconto) or
           (tpPrecoImpItem = tpNenhumaDefinicao)then
        begin
          objAltPed.objVenda.fltPorDes := 0;
          objAltPed.objVenda.fltPorDesTmp := 0;
          objAltPed.objVenda.fltDesEsp := 0;
        end;
        if objAltPed.fCalculaTotalPedido and objAltPed.fGravarPedido then
        begin
          pDesmarcaTodos;
          fMensagem('', 'Preços atulizados com sucesso!', ['&Ok']);
        end;
      end;
    end;
  finally
    FreeAndNil(objAltPed);
  end;
end;

procedure TfrmDigAtualizaPreco.pAtualizaDocumento(strAcao: string);
var
  cdsTmp: TUniClientDataSet;
  tpPrecoImpItem: TTipoPrecoImpItem;
  frmFatDigPreco: TfrmFatDigPreco;
begin
  if (cdsConsulta.Active) and (not cdsConsulta.IsEmpty) then
  begin
    cdsTmp := TUniClientDataSet.Create(nil);
    try
      pCloneDataSet(cdsTmp, cdsConsulta);
      cdsTmp.Filtered := False;
      cdsTmp.Filter := ' FGO_MARDES = ''M'' ';
      cdsTmp.Filtered := True;

      if not cdsTmp.IsEmpty then
      begin
        try
          pCriarFormularios (TfrmFatDigPreco, frmFatDigPreco);
          if frmFatDigPreco.ShowModal = mrOk then
          begin
            tpPrecoImpItem  := TTipoPrecoImpItem(frmFatDigPreco.rdgPreco.ItemIndex);
            cdsTmp.DisableControls;
            cdsTmp.First;

            while not cdsTmp.Eof do
            begin
              pAlteraPrecoDocumento(cdsTmp.FieldByName('FGO_CODEMP').AsString, cdsTmp.FieldByName('FGO_NUMDOC').AsString, cdsTmp.FieldByName('FGO_ESPDOC').AsString, strAcao, tpPrecoImpItem);
              cdsTmp.Next;
            end;
          end;
        finally
          pFreeAndNil(frmFatDigPreco);
        end;
      end
      else
      begin
        fMensagem('ATENÇÃO!', 'selecione ao menos um documento!', ['&Ok']);
      end;
    finally
      FreeAndNil(cdsTmp);
    end;
  end
  else
  begin
    fMensagem('ATENÇÃO!', 'Nenhum documento carregado!', ['&Ok']);
  end;
end;

procedure TfrmDigAtualizaPreco.pBuscaDocumentos;
var
  qryConsulta: TUniQuery;
begin
  qryConsulta := fCriaQuery;
  try
    qryConsulta.Close;
    qryConsulta.SQL.Clear;
    qryConsulta.SQL.Add('SELECT F.AUTOINCREM, F.FGO_CODEMP, F.FGO_NUMDOC, F.FGO_ESPDOC, F.FGO_CODCLI, C.CLI_NOMCLI,');
    qryConsulta.SQL.Add('       F.FGO_DTAENT, F.FGO_HORENT, "D" AS FGO_MARDES, 0 AS FGO_VALIDAR');
    qryConsulta.SQL.Add('FROM FATGOR F');
    qryConsulta.SQL.Add('INNER JOIN CADCLI C');
    qryConsulta.SQL.Add('ON(F.FGO_CODCLI = C.CLI_CODCLI)');
    qryConsulta.SQL.Add('WHERE F.FGO_JAFATU = 0');

    if rdgTipoDocumento.ItemIndex = 0 then
    begin
      qryConsulta.SQL.Add('AND F.FGO_ESPDOC = "OR" ');
    end
    else
    begin
      qryConsulta.SQL.Add('AND F.FGO_ESPDOC = "PD" ');
    end;

    if (not fEmptyStr(edtDesCli.Text)) then
    begin
      qryConsulta.SQL.Add('AND F.FGO_CODCLI = :CODCLI');
      qryConsulta.ParamByName('CODCLI').AsString := edtCodCli.Text;
    end;

    if (not fEmptyStr(edtDesEmp.Text)) then
    begin
      qryConsulta.SQL.Add('AND F.FGO_CODEMP = :CODEMP');
      qryConsulta.ParamByName('CODEMP').AsString := edtCodEmp.Text;
    end;

    if (not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) and (not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) then
    begin
      qryConsulta.SQL.Add('AND F.FGO_DTAENT BETWEEN :DTAINI AND :DTAFIN');
      qryConsulta.ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
      qryConsulta.ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);
    end;

    qryConsulta.Open;
    cdsConsulta.EmptyDataSet;
    cdsConsulta.DisableControls;
    cdsTrava.EmptyDataSet;

    while not qryConsulta.Eof do
    begin
      cdsConsulta.Append;
      cdsConsultaAUTOINCREM.AsString   := qryConsulta.FieldByName('AUTOINCREM').AsString;
      cdsConsultaFGO_CODEMP.AsString   := qryConsulta.FieldByName('FGO_CODEMP').AsString;
      cdsConsultaFGO_NUMDOC.AsString   := qryConsulta.FieldByName('FGO_NUMDOC').AsString;
      cdsConsultaFGO_ESPDOC.AsString   := qryConsulta.FieldByName('FGO_ESPDOC').AsString;
      cdsConsultaFGO_CODCLI.AsString   := qryConsulta.FieldByName('FGO_CODCLI').AsString;
      cdsConsultaCLI_NOMCLI.AsString   := qryConsulta.FieldByName('CLI_NOMCLI').AsString;
      cdsConsultaFGO_DTAENT.AsDateTime := qryConsulta.FieldByName('FGO_DTAENT').AsDateTime;
      cdsConsultaFGO_HORENT.AsDateTime := qryConsulta.FieldByName('FGO_HORENT').AsDateTime;
      cdsConsultaFGO_MARDES.AsString   := qryConsulta.FieldByName('FGO_MARDES').AsString;
      cdsConsulta.Post;

      cdsTrava.Append;
      cdsTravaAUTOINCREM.AsString := qryConsulta.FieldByName('AUTOINCREM').AsString;
      cdsTravaTRAVAS.AsString := EmptyStr;
      cdsTrava.Post;

      qryConsulta.Next;
    end;

    cdsConsulta.First;
    cdsConsulta.EnableControls;
    grdConsulta.Refresh;
  finally
    FreeAndNil(qryConsulta);
  end;
end;

procedure TfrmDigAtualizaPreco.pDesmarcaTodos;
begin
  if (cdsConsulta.Active) and (not cdsConsulta.IsEmpty) then
  begin
    try
      cdsConsulta.DisableControls;
      cdsConsulta.First;
      while not cdsConsulta.Eof do
      begin
        cdsConsulta.Edit;
        cdsConsulta.FieldByName('FGO_MARDES').AsString := 'D';
        cdsConsulta.Post;
        cdsConsulta.Next;
      end;
      cdsConsulta.First;
    finally
      cdsConsulta.EnableControls;
    end;
  end;
end;

procedure TfrmDigAtualizaPreco.pMarcaDesmarca;
var
  strStatus: string;
begin
  if (cdsConsulta.Active) and (not cdsConsulta.IsEmpty) and (cdsConsulta.RecNo > 0) then
  begin
    strStatus := cdsConsulta.FieldByName('FGO_MARDES').AsString;
    cdsConsulta.Edit;
    cdsConsulta.FieldByName('FGO_MARDES').AsString := IIF(strStatus = 'D', 'M', 'D');
    cdsConsulta.Post;
  end;
end;

procedure TfrmDigAtualizaPreco.pMarcaDesmarcaTodos;
var
  strStatus: string;
begin
  if (cdsConsulta.Active) and (not cdsConsulta.IsEmpty) then
  begin
    try
      cdsConsulta.DisableControls;
      cdsConsulta.First;
      strStatus := cdsConsulta.FieldByName('FGO_MARDES').AsString;
      while not cdsConsulta.Eof do
      begin
        cdsConsulta.Edit;
        cdsConsulta.FieldByName('FGO_MARDES').AsString := IIF(strStatus = 'D', 'M', 'D');
        cdsConsulta.Post;
        cdsConsulta.Next;
      end;
      cdsConsulta.First;
    finally
      cdsConsulta.EnableControls;
    end;
  end;
end;

procedure TfrmDigAtualizaPreco.pOriginalComDesconto(strCodEmp: string);
begin
  cdsVenda.Edit;
  cdsVenda.FieldByName('ITE_UNITAR').AsFloat := cdsVenda.FieldByName('ITE_UNIDIG').AsFloat - ((cdsVenda.FieldByName('ITE_UNIDIG').AsFloat * cdsVenda.FieldByName('ITE_DESCON').AsFloat) / 100);
  cdsVenda.FieldByName('ITE_DESESP').AsFloat := 0;
  cdsVenda.Post;
end;

procedure TfrmDigAtualizaPreco.pOriginalSemDesconto(strCodEmp: string);
begin
  cdsVenda.Edit;
  cdsVenda.FieldByName('ITE_UNITAR').AsFloat := cdsVenda.FieldByName('ITE_UNIDIG').AsFloat;
  cdsVenda.FieldByName('ITE_DESCON').AsFloat := 0;
  cdsVenda.FieldByName('ITE_DESESP').AsFloat := 0;
  cdsVenda.Post;
end;

procedure TfrmDigAtualizaPreco.pTabelaAtualComDesconto(strCodEmp: string);
var
  fltValorTabela: Double;
begin
  fltValorTabela := fBuscaValorTabPre(strCodEmp, cdsVenda.FieldByName('ITE_CODITE').AsString, cdsVenda.FieldByName('ITE_TABPRE').AsString);
  cdsVenda.Edit;
  cdsVenda.FieldByName('ITE_UNIDIG').AsFloat := fltValorTabela;
  cdsVenda.FieldByName('ITE_UNITAR').AsFloat := fltValorTabela - ((fltValorTabela * cdsVenda.FieldByName('ITE_DESCON').AsFloat) / 100);
  cdsVenda.FieldByName('ITE_DESESP').AsFloat := 0;
  cdsVenda.Post;
end;

procedure TfrmDigAtualizaPreco.pTabelaAtualSemDesconto(strCodEmp: string);
var
  fltValorTabela: Double;
begin
  fltValorTabela := fBuscaValorTabPre(strCodEmp, cdsVenda.FieldByName('ITE_CODITE').AsString, cdsVenda.FieldByName('ITE_TABPRE').AsString);
  cdsVenda.Edit;
  cdsVenda.FieldByName('ITE_UNIDIG').AsFloat := fltValorTabela;
  cdsVenda.FieldByName('ITE_UNITAR').AsFloat := fltValorTabela;
  cdsVenda.FieldByName('ITE_DESCON').AsFloat := 0;
  cdsVenda.FieldByName('ITE_DESESP').AsFloat := 0;
  cdsVenda.Post;
end;

end.
