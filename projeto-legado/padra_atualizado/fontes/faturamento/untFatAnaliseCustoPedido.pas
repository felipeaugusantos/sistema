unit untFatAnaliseCustoPedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, Vcl.Buttons,
  Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, EditFocus, Data.DB, MemDS,
  DBAccess, Uni, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, Datasnap.DBClient,
  UniClientDataSet, cxCurrencyEdit, untFuncFat, Shared.Functions.DataSet,
  Vcl.Grids, Vcl.DBGrids, DBGridCitel;

type
  TfrmFatAnaliseCustoPedido = class(TfrmPaiSimples)
    pnlGeral: TPanel;
    btnConfirmar: TBitBtnLocked;
    pnlCabecalho: TPanel;
    lblPedido: TLabel;
    lblNumPedido: TLabel;
    lblEmpresa: TLabel;
    lblDescEmpresa: TLabel;
    pnlDadosPedido: TPanel;
    lblCliente: TLabel;
    lblVendedor: TLabel;
    lblConPag: TLabel;
    lblFormPag: TLabel;
    lblCartao: TLabel;
    lblTransp: TLabel;
    edtCliente: TEditFocus;
    edtVendedor: TEditFocus;
    edtCodCnd: TEditFocus;
    edtConPag: TEditFocus;
    edtForPag: TEditFocus;
    edtDesCar: TEditFocus;
    edtTransp: TEditFocus;
    edtCodCar: TEditFocus;
    lblFrete: TLabel;
    lblValorFrete: TLabel;
    cxgProdutosDBTableView: TcxGridDBTableView;
    cxgProdutosLevel: TcxGridLevel;
    cxgProdutos: TcxGrid;
    cxgProdutosCODIGO: TcxGridDBColumn;
    cxgProdutosDESCRI: TcxGridDBColumn;
    cxgProdutosUNIDAD: TcxGridDBColumn;
    cxgProdutosMARCA: TcxGridDBColumn;
    cxgProdutosAMBCOM: TcxGridDBColumn;
    cxgProdutosQTDITE: TcxGridDBColumn;
    cxgProdutosVLRUNI: TcxGridDBColumn;
    cxgProdutosDESESP: TcxGridDBColumn;
    cxgProdutosVLRTOT: TcxGridDBColumn;
    cxgProdutosFREENT: TcxGridDBColumn;
    cxgProdutosCMV: TcxGridDBColumn;
    cxgProdutosCOMPRO: TcxGridDBColumn;
    cxgProdutosTAXCAR: TcxGridDBColumn;
    cxgProdutosCUSTOT: TcxGridDBColumn;
    cxgProdutosRESULT: TcxGridDBColumn;
    cxgProdutosMARGEM: TcxGridDBColumn;
    cdsProdutos: TUniClientDataSet;
    dtsProdutos: TDataSource;
    cdsProdutosCODITE: TStringField;
    cdsProdutosDESITE: TStringField;
    cdsProdutosUNIDAD: TStringField;
    cdsProdutosMARCA: TStringField;
    cdsProdutosCOMPLE: TStringField;
    cdsProdutosQTDITE: TFloatField;
    cdsProdutosUNITAR: TFloatField;
    cdsProdutosDESESP: TFloatField;
    cdsProdutosVLRTOT: TFloatField;
    cdsProdutosFREENT: TFloatField;
    cdsProdutosCMV: TFloatField;
    cdsProdutosCOMPRO: TFloatField;
    cdsProdutosTAXCAR: TFloatField;
    cdsProdutosCUSTOT: TFloatField;
    cdsProdutosRESULT: TFloatField;
    cdsProdutosMARGEM: TFloatField;
    pnlLegenda: TPanel;
    shpLegCamEdit: TShape;
    lblLegCamEdit: TLabel;
    cdsProdutosAUTINC: TStringField;
    edtTotMargem: TEditFocus;
    lblTotMargem: TLabel;
    cdsProdutosEMPITE: TStringField;
    cdsProdutosCODFIS: TStringField;
    cdsProdutosVALCOM: TFloatField;
    cdsProdutosIMPDIR: TStringField;
    cdsProdutosICMSAI: TFloatField;
    cdsProdutosIMPFED: TFloatField;
    cdsProdutosDESOPE: TFloatField;
    cdsProdutosALDIFA: TFloatField;
    cdsProdutosVALRET: TFloatField;
    cdsProdutosBASICM: TFloatField;
    cdsProdutosPERFCP: TFloatField;
    cdsProdutosOUTVAL: TFloatField;
    pnlProfissional: TPanel;
    lblProfi: TLabel;
    edtProfi: TEditFocus;
    lblComissao: TLabel;
    edtValorComissao: TEditFocus;
    lblPercComissao: TLabel;
    pnlProfissionalVarios: TPanel;
    pnlGridProfisionalVarios: TPanel;
    cdsProfissionais: TUniClientDataSet;
    dtaProfissionais: TDataSource;
    cdsProfissionaisCODPRO: TStringField;
    cdsProfissionaisNOMPRO: TStringField;
    cdsProfissionaisCOMPRO: TFloatField;
    cxgProfissionaisDBTableView: TcxGridDBTableView;
    cxgProfissionaisLevel: TcxGridLevel;
    cxgProfissionais: TcxGrid;
    cxgProfissionaisCODPRO: TcxGridDBColumn;
    cxgProfissionaisNOMPRO: TcxGridDBColumn;
    cxgProfissionaisCOMPRO: TcxGridDBColumn;
    cdsProfissionaisTOTCOMPRO: TAggregateField;
    procedure FormShow(Sender: TObject);
    procedure edtCodCarKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCarExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cxgProdutosDBTableViewCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure edtValorComissaoExit(Sender: TObject);
    procedure cxgProdutosFREENTPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxgProfissionaisDBTableViewCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxgProfissionaisCOMPROPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
  private
    { Private declarations }
    FAutInc: String;
    FFatVenda: TFatVenda;
    FqryPedido: TUniQuery;
    FNumProfi: Integer;
    procedure pCriaDataSetProdutos;
    function fRetTaxaCartao(const ACodCar: String; const ATotIte: Double): Double;
    procedure pCalculaValores;
    procedure pCalculaValoresAtualizandoFrete(const AValorFrete: Double);
    function fSalvaAlteracaoNoPedido: Boolean;
    function fCalculaMargemGeral: Double;
    procedure pCarregarPedido;
    procedure pCarregarProdutosPedido;
    procedure pCarregaProfissionaisVarios(const AAutIncPD: String);
    procedure pCalculaValoresComissaoProfissionaisVarios(DataSet: TDataSet);
    procedure pAfterScrollProfissionais(DataSet: TDataSet);

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    FNumPed: String;
    FCodEmp: String;
  end;

const
  PROFISSIONAIS_VARIOS = 3;

implementation

{$R *.dfm}

uses untFuncoesSimples, untConsultas, untTypesSistema, untGravando, untFatGor,
  untFuncFatTypes;

procedure TfrmFatAnaliseCustoPedido.btnConfirmarClick(Sender: TObject);
begin
  inherited;

  if not fVerificaCampos then
    Exit;

  if fSalvaAlteracaoNoPedido then
  begin
    fMensagem('', 'Pedido '+FNumPed+' alterado com sucesso!', ['&Ok']);
    Close;
  end;
end;

procedure TfrmFatAnaliseCustoPedido.cxgProdutosDBTableViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin                        
  inherited;

  if AViewInfo.Item.Options.Editing then
  begin
    ACanvas.Brush.Color := clYellow;          
    ACanvas.Font.Color  := clBlack;
  end;
end;

procedure TfrmFatAnaliseCustoPedido.cxgProdutosFREENTPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  inherited;
  
  if (fEmptyStr(VarToString(DisplayValue))) then
    DisplayValue := 0
  else if (DisplayValue < 0) then
    DisplayValue := 0;

  pCalculaValoresAtualizandoFrete(DisplayValue);
end;

procedure TfrmFatAnaliseCustoPedido.cxgProfissionaisCOMPROPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  inherited;
  
  if (fEmptyStr(VarToString(DisplayValue))) then
    DisplayValue := 0
  else if (DisplayValue < 0) or (DisplayValue > 100) then
    DisplayValue := 0;

  cdsProfissionais.AfterPost := pAfterScrollProfissionais;
end;

procedure TfrmFatAnaliseCustoPedido.cxgProfissionaisDBTableViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  
  if AViewInfo.Item.Options.Editing then
  begin
    ACanvas.Brush.Color := clYellow;
    ACanvas.Font.Color  := clBlack;
  end;
end;

procedure TfrmFatAnaliseCustoPedido.edtCodCarExit(Sender: TObject);
begin
  inherited;

  if fValidaCampos(edtCodCar) then
    pCalculaValores;
end;

procedure TfrmFatAnaliseCustoPedido.edtCodCarKeyPress(Sender: TObject;
  var Key: Char);
var
  arrCartao : TConsultasArray;
begin
  inherited;

  If fPesqCartao(Self, edtCodCar, edtDesCar, Nil, Key, arrCartao, True, False, False, False, False, False, FCodEmp) Then
  Begin
    If (fValidaCampos(Self, True)) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatAnaliseCustoPedido.edtValorComissaoExit(Sender: TObject);
begin
  inherited;

  if fValidaCampos(edtValorComissao) then
    pCalculaValores
end;

function TfrmFatAnaliseCustoPedido.fCalculaMargemGeral: Double;
var
  cdsData: OleVariant;
  recTotMarLuc : TRecTotaisMargemLucro;
begin
  Result := 0;

  if not Assigned(cdsProdutos) then
    Exit;

  if not cdsProdutos.Active then
    Exit;

  if cdsProdutos.RecordCount <= 0 then
    Exit;

  if not Assigned(FFatVenda) then
    Exit;

  if not cdsVenda.Active then
    Exit;

  if cdsVenda.RecordCount <= 0  then
    Exit;

  cdsProdutos.DisableControls;

  try
    cdsProdutos.First;

    while not cdsProdutos.Eof do
    begin
      if cdsVenda.Locate('ITE_SEQDET', cdsProdutosAUTINC.AsString, []) then
      begin
        cdsVenda.Edit;
        cdsVenda.FieldByName('ITE_TOTCUS').AsFloat := fStrToFloat(FloatToStrF(cdsProdutosCUSTOT.AsFloat, ffNumber, 12, 2),0);
        cdsVenda.FieldByName('ITE_CUSITE').AsFloat := fStrToFloat(FloatToStrF(cdsVenda.FieldByName('ITE_TOTCUS').AsFloat / cdsProdutosQTDITE.AsFloat, ffNumber, 12, 2),0);
        cdsVenda.FieldByName('ITE_PRECUS').AsFloat := cdsVenda.FieldByName('ITE_CUSITE').AsFloat;
        cdsVenda.Post;
      end;

      cdsProdutos.Next;
    end;

    cdsData := FFatVenda.fCalculaMargemLucro(False);

    FFatVenda.pCalculaTotaisMargemLucro(cdsData,
                                        recTotMarLuc);
  finally
     cdsProdutos.First;
    cdsProdutos.EnableControls;
  end;

  Result := recTotMarLuc.fltTotMarPrat;
end;

procedure TfrmFatAnaliseCustoPedido.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  if Assigned(FFatVenda) then
    FreeAndNil(FFatVenda);

  if Assigned(FqryPedido) then
    FreeAndNil(FqryPedido);
end;

procedure TfrmFatAnaliseCustoPedido.FormCreate(Sender: TObject);
begin
  inherited;
  TfrmGravando.fExecutarModal(pCriaDataSetProdutos, 'Aguarde, Carregando pedido ...', '');
end;

procedure TfrmFatAnaliseCustoPedido.FormShow(Sender: TObject);
begin
  inherited;
  TfrmGravando.fExecutarModal(pCarregarPedido, 'Aguarde, Carregando pedido ...', '');
end;

function TfrmFatAnaliseCustoPedido.fRetTaxaCartao(const ACodCar: String;
  const ATotIte: Double): Double;
var
  LqryTaxa: TUniQuery;
  LfltTotPro: Double;
  LfltPerCar: Double;
begin
  Result := 0;

  if fEmptyStr(ACodCar) then
    Exit;

  if ATotIte <= 0 then
    Exit;

  LqryTaxa := fCriaQuery;

  try
    LfltTotPro := fCampoTabela('FGO_TOTPRO','FATGOR',['AUTOINCREM'],[FAutInc]);

    LqryTaxa.Close;
    LqryTaxa.SQL.Clear;
    LqryTaxa.SQL.Add('SELECT CAR_PERDES, CAR_TIPTAX');
    LqryTaxa.SQL.Add('FROM CADCAR');
    LqryTaxa.SQL.Add('WHERE CAR_CODCAR = :CODCAR');
    LqryTaxa.ParamByName('CODCAR').AsString := ACodCar;
    LqryTaxa.Open;

    if LqryTaxa.IsEmpty then
      Exit;

    if LqryTaxa.FieldByName('CAR_TIPTAX').AsString = 'P' then
    begin
      LfltPerCar := LqryTaxa.FieldByName('CAR_PERDES').AsFloat;
    end
    else
    begin
      LfltPerCar := ((LqryTaxa.FieldByName('CAR_PERDES').AsFloat * 100) / LfltTotPro);
    end;

    Result := (ATotIte * (LfltPerCar / 100));
  finally
    FreeAndNil(LqryTaxa);
  end;
end;

function TfrmFatAnaliseCustoPedido.fSalvaAlteracaoNoPedido: Boolean;
var
  LqrySalvar: TUniQuery;
begin
  Result := False;

  if not Assigned(cdsProdutos) then
    Exit;

  if not cdsProdutos.Active then
    Exit;

  if cdsProdutos.RecordCount <=0 then
    Exit;

  if fEmptyStr(FAutInc) then
    Exit;

  LqrySalvar := fCriaQuery;
  cdsProdutos.DisableControls;

  try
    fStartTransaction;                                              

    try
      LqrySalvar.Close;
      LqrySalvar.SQL.Clear;
      LqrySalvar.SQL.Add('UPDATE EXTGOR');
      LqrySalvar.SQL.Add('SET FGO_ACPCAR = :ACPCAR');
      LqrySalvar.SQL.Add(', FGO_ACPCOM = :ACPCOM');
      LqrySalvar.SQL.Add('WHERE FGO_SEQFGO = :SEQFGO');
      LqrySalvar.ParamByName('ACPCAR').AsString := edtCodCar.Text;
      LqrySalvar.ParamByName('ACPCOM').AsFloat := fStrToFloat(edtValorComissao.Text,0);
      LqrySalvar.ParamByName('SEQFGO').AsString := FAutInc;
      LqrySalvar.ExecSQL;

      LqrySalvar.Close;
      LqrySalvar.SQL.Clear;
      LqrySalvar.SQL.Add('UPDATE EXTDOR');
      LqrySalvar.SQL.Add('SET FDO_FREENT = :FREENT');
      LqrySalvar.SQL.Add(', FDO_ACPPRO = :ACPPRO');
      LqrySalvar.SQL.Add(', FDO_ACPTXC = :ACPTXC');
      LqrySalvar.SQL.Add(', FDO_ACPVCT = :ACPVCT');
      LqrySalvar.SQL.Add(', FDO_ACPRES = :ACPRES');
      LqrySalvar.SQL.Add(', FDO_ACPMAR = :ACPMAR');
      LqrySalvar.SQL.Add(', FDO_OUTVAL = :OUTVAL');
      LqrySalvar.SQL.Add('WHERE FDO_SEQFDO = :SEQFDO');

      cdsProdutos.First;

      while not cdsProdutos.Eof do
      begin
        LqrySalvar.Close;
        LqrySalvar.ParamByName('FREENT').AsFloat := cdsProdutosFREENT.AsFloat;
        LqrySalvar.ParamByName('ACPPRO').AsFloat := cdsProdutosCOMPRO.AsFloat;
        LqrySalvar.ParamByName('ACPTXC').AsFloat := cdsProdutosTAXCAR.AsFloat;
        LqrySalvar.ParamByName('ACPVCT').AsFloat := cdsProdutosCUSTOT.AsFloat;
        LqrySalvar.ParamByName('ACPRES').AsFloat := cdsProdutosRESULT.AsFloat;
        LqrySalvar.ParamByName('ACPMAR').AsFloat := cdsProdutosMARGEM.AsFloat;
        LqrySalvar.ParamByName('OUTVAL').AsFloat := cdsProdutosOUTVAL.AsFloat;
        LqrySalvar.ParamByName('SEQFDO').AsString := cdsProdutosAUTINC.AsString;
        LqrySalvar.ExecSQL;

        cdsProdutos.Next;
      end;

      if FNumProfi = PROFISSIONAIS_VARIOS then
      begin
        cdsProfissionais.DisableControls;
        try
          LqrySalvar.Close;
          LqrySalvar.SQL.Clear;
          LqrySalvar.SQL.Add('UPDATE DIVFAT');
          LqrySalvar.SQL.Add('SET DIV_COMPRO = :COMPRO');
          LqrySalvar.SQL.Add('WHERE DIV_SEQGER = :SEQGER');
          LqrySalvar.SQL.Add('AND DIV_CODDIV = :CODDIV');

          cdsProfissionais.First; 

          while not cdsProfissionais.Eof do
          begin     
            LqrySalvar.Close;
            LqrySalvar.ParamByName('COMPRO').AsFloat := cdsProfissionaisCOMPRO.AsFloat;
            LqrySalvar.ParamByName('SEQGER').AsString := FAutInc;
            LqrySalvar.ParamByName('CODDIV').AsString := cdsProfissionaisCODPRO.AsString;
            LqrySalvar.ExecSQL;
            
            cdsProfissionais.Next;
          end;
        finally
          cdsProfissionais.First;
          cdsProfissionais.EnableControls;
        end;
      end;

      fCommit;

      Result := True;
    except
      On E: Exception Do
      begin
        fRollBack;
        pMensagensErro(E.Message, '[TfrmFatAnaliseCustoPedido.fSalvaAlteracaoNoPedido]');
      end;
    end;
  finally
    FreeAndNil(LqrySalvar);
    cdsProdutos.First;
    cdsProdutos.EnableControls;
  end;
end;

function TfrmFatAnaliseCustoPedido.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtCodCar) And (edtCodCar.Enabled) Then
    Begin
      If fEmptyStr(edtCodCar.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O cartão deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        edtDesCar.Text := fRetNomeCartao(edtCodCar.Text);
        If fEmptyStr(edtDesCar.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Cartão não encontrado!', ['&Ok']);
          Result := False;
        End;
      End;
    End
    Else
    If (Sender = edtValorComissao) And (edtValorComissao.Enabled) Then
    Begin
      edtValorComissao.Text := FloatToStrF(fStrToFloat(edtValorComissao.Text,0), ffNumber, 5, 2);
      If (fStrToFloat(edtValorComissao.Text,0) < 0) Or (fStrToFloat(edtValorComissao.Text, 0) > 100) Then
      Begin
        fMensagem('ATENÇÃO!', 'Valor de comissãodeve ser entre 0,00 e 100,00!', ['&Ok']);
        Result := False;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmFatAnaliseCustoPedido.pCarregaProfissionaisVarios(
  const AAutIncPD: String);
var
  LQryProfisional: TUniQuery;
begin                                                
  LQryProfisional := fCriaQuery;
  cdsProfissionais.DisableControls;
  cdsProfissionais.AfterScroll := Nil;

  try
    cdsProfissionais.EmptyDataSet;
    
    LQryProfisional.Close;
    LQryProfisional.SQL.Clear;
    LQryProfisional.SQL.Add('SELECT DIV_CODDIV, DIV_COMPRO');
    LQryProfisional.SQL.Add('FROM DIVFAT');
    LQryProfisional.SQL.Add('WHERE DIV_SEQGER = :SEQGER');
    LQryProfisional.ParamByName('SEQGER').AsString := AAutIncPD;
    LQryProfisional.Open;

    if LQryProfisional.IsEmpty then
      Exit;

    while not LQryProfisional.Eof do
    begin
      cdsProfissionais.Append;
      cdsProfissionaisCODPRO.AsString := LQryProfisional.FieldByName('DIV_CODDIV').AsString;
      cdsProfissionaisNOMPRO.AsString := fRetNomProfissional(LQryProfisional.FieldByName('DIV_CODDIV').AsString);
      cdsProfissionaisCOMPRO.AsFloat := LQryProfisional.FieldByName('DIV_COMPRO').AsFloat;
      cdsProfissionais.Post;
      
      LQryProfisional.Next;
    end;
  finally
    FreeAndNil(LQryProfisional);
    cdsProfissionais.First;
    cdsProfissionais.EnableControls;
  end;
end;

procedure TfrmFatAnaliseCustoPedido.pCarregarPedido;
var
  LblnDeletouItens: Boolean;
  LstrCodProfi: String;
begin
  FqryPedido.Close;
  FqryPedido.SQL.Clear;
  FqryPedido.SQL.Add(fSelectFromFatgorLeftAuxiliares(False));
  FqryPedido.SQL.Add('WHERE F.FGO_ESPDOC = "PD"');
  FqryPedido.SQL.Add('AND F.FGO_NUMDOC = :NUMDOC');
  FqryPedido.SQL.Add('AND F.FGO_CODEMP = :CODEMP');

  FqryPedido.ParamByName('NUMDOC').AsString := FNumPed;
  FqryPedido.ParamByName('CODEMP').AsString := FCodEmp;

  FqryPedido.Open;

  if FqryPedido.IsEmpty then
    Exit;

  FAutInc := FqryPedido.FieldByName('AUTOINCREM').AsString;

  edtCodCar.Enabled := ((fCfgSis('SOLCAR', varBoolean)) And (FqryPedido.FieldByName('FGO_CODFPG').AsString = '007'));

  lblNumPedido.Caption := FNumPed;
  lblDescEmpresa.Caption := concat(FCodEmp,'-',fRetNomeEmpresa(FCodEmp));

  edtCliente.Text := Concat(FqryPedido.FieldByName('FGO_CODCLI').AsString,'-',fRetNomCliente(FqryPedido.FieldByName('FGO_CODCLI').AsString));
  edtVendedor.Text := Concat(FqryPedido.FieldByName('FGO_CODVEN').AsString,'-',fRetNomVendRep(FqryPedido.FieldByName('FGO_CODVEN').AsString));
  edtCodCnd.Text := Concat(FqryPedido.FieldByName('FGO_CODCND').AsString,'-',fRetDesConPag(FqryPedido.FieldByName('FGO_CODCND').AsString));
  edtConPag.Text := fFormataCondPag(FqryPedido.FieldByName('FGO_CONPAG').AsString);
  edtForPag.Text := Concat(FqryPedido.FieldByName('FGO_CODFPG').AsString,'-',fRetDescFpg(FqryPedido.FieldByName('FGO_CODFPG').AsString));
  edtTransp.Text := Concat(FqryPedido.FieldByName('FGO_CODTRA').AsString,'-',fRetNomTransportadora(FqryPedido.FieldByName('FGO_CODTRA').AsString));
  lblValorFrete.Caption := FloatToStrF(FqryPedido.FieldByName('FGO_TOTFRE').AsFloat, ffNumber, 12, 2);
  edtCodCar.Text := FqryPedido.FieldByName('FGO_ACPCAR').AsString;
  edtDesCar.Text := fRetNomeCartao(edtCodCar.Text);

  if FNumProfi = PROFISSIONAIS_VARIOS then
  begin
    pnlProfissional.Visible := False;
    pnlProfissionalVarios.Visible := True;
    pCarregaProfissionaisVarios(FAutInc);
  end
  else
  begin
    pnlProfissional.Visible := True;
    pnlProfissionalVarios.Visible := False;
    LstrCodProfi := fCampoTabela('FDO_CODDIV','FATDOR',['FDO_SEQGER'],[FAutInc]);
    edtProfi.Text := Concat(LstrCodProfi,'-',fRetNomProfissional(LstrCodProfi));
    edtValorComissao.Text := FloatToStrF(FqryPedido.FieldByName('FGO_ACPCOM').AsFloat, ffNumber, 5, 2);
    edtValorComissao.Enabled := not fEmptyStr(LstrCodProfi);
  end;

  FFatVenda.strNumOrc := FNumPed;
  FFatVenda.strEspOrc := 'PD';
  FFatVenda.strEmpOri := FCodEmp;
  untFuncFat.pCarregarClientePedidoOrcamento(FFatVenda, FFatVenda.strEmpOri, True);
  FFatVenda.pCarregaPedidoOrcamento(FqryPedido, LblnDeletouItens);
  FFatVenda.pPreencheMatrizFechamento;

  If FFatVenda.fRetemImpostosNoDescontoEspecial Then
  Begin
    FFatVenda.pDestacaRetencoes;
    FFatVenda.pRetemImpostosNoDescontoEspecial;
  End;

  FFatVenda.pCalculaTotGer;
  FFatVenda.pRateiaValores;

  pCarregarProdutosPedido;
end;

procedure TfrmFatAnaliseCustoPedido.pCarregarProdutosPedido;
var
  LRecCustoPedido: IMyCampoTabela;
  LblnChamaCalculaValores: Boolean;
  LintContador: Integer;
  LfltValCom: Double;
begin
  if fEmptyStr(FAutInc) then
    Exit;

  if not Assigned(FFatVenda) then
    Exit;

  if Length(FFatVenda.arrMatItens) <= 0 then
    Exit;

  cdsProdutos.DisableControls;

  try
    LblnChamaCalculaValores := True;

    for LintContador := 0 to Length(FFatVenda.arrMatItens) - 1 do
    begin
      if (cdsVenda.Locate('ITE_SEQDET', FFatVenda.arrMatItens[LintContador].strSeqDet, [])) then
      begin
        cdsProdutos.Append;
        cdsProdutosCODITE.AsString := cdsVenda.FieldByName('ITE_CODITE').AsString;
        cdsProdutosDESITE.AsString := fRetNomProduto(cdsVenda.FieldByName('ITE_CODITE').AsString);
        cdsProdutosUNIDAD.AsString := fRetSiglaUnidade(cdsVenda.FieldByName('ITE_UNIDAD').AsString);
        cdsProdutosMARCA.AsString := fRetNomMarca(cdsVenda.FieldByName('ITE_CODMAR').AsString);
        cdsProdutosCOMPLE.AsString := cdsVenda.FieldByName('ITE_COMPLE').AsString;
        cdsProdutosQTDITE.AsFloat := cdsVenda.FieldByName('ITE_QTDITE').AsFloat;
        cdsProdutosUNITAR.AsFloat := cdsVenda.FieldByName('ITE_UNITAR').AsFloat;
        cdsProdutosVLRTOT.AsFloat := cdsVenda.FieldByName('ITE_TOTITE').AsFloat;
        cdsProdutosCMV.AsFloat := cdsVenda.FieldByName('ITE_TOTCUS').AsFloat;
        cdsProdutosAUTINC.AsString := cdsVenda.FieldByName('ITE_SEQDET').AsString;

        LRecCustoPedido := fCampoTabela(['FDO_FREENT','FDO_ACPPRO','FDO_ACPTXC','FDO_ACPVCT','FDO_ACPRES','FDO_ACPMAR','FDO_OUTVAL'], 'EXTDOR', ['FDO_SEQFDO'], [cdsVenda.FieldByName('ITE_SEQDET').AsString]);

        if LRecCustoPedido.FieldByName('FDO_ACPRES').AsFloat > 0 then
        begin
          LblnChamaCalculaValores := False;
          cdsProdutosFREENT.AsFloat := LRecCustoPedido.FieldByName('FDO_FREENT').AsFloat;
          cdsProdutosCOMPRO.AsFloat := LRecCustoPedido.FieldByName('FDO_ACPPRO').AsFloat;
          cdsProdutosTAXCAR.AsFloat := LRecCustoPedido.FieldByName('FDO_ACPTXC').AsFloat;
          cdsProdutosCUSTOT.AsFloat := LRecCustoPedido.FieldByName('FDO_ACPVCT').AsFloat;
          cdsProdutosRESULT.AsFloat := LRecCustoPedido.FieldByName('FDO_ACPRES').AsFloat;
          cdsProdutosMARGEM.AsFloat := LRecCustoPedido.FieldByName('FDO_ACPMAR').AsFloat;
          cdsProdutosOUTVAL.AsFloat := LRecCustoPedido.FieldByName('FDO_OUTVAL').AsFloat;
        end
        else
        begin
          cdsProdutosFREENT.AsFloat := cdsVenda.FieldByName('ITE_QTDITE').AsString * fCampoTabela('ITE_VALFRE','ITEGER',['ITE_CODITE','ITE_CODEMP'],[cdsVenda.FieldByName('ITE_CODITE').AsString,cdsVenda.FieldByName('ITE_EMPITE').AsString]);
        end;

        LfltValCom := fCampoTabela('ITE_COMTB'+cdsVenda.FieldByName('ITE_TABPRE').AsString,'ITEGER',['ITE_CODITE','ITE_CODEMP'],[cdsVenda.FieldByName('ITE_CODITE').AsString,cdsVenda.FieldByName('ITE_EMPITE').AsString]);

        cdsProdutosEMPITE.AsString := cdsVenda.FieldByName('ITE_EMPITE').AsString;
        cdsProdutosCODFIS.AsString := cdsVenda.FieldByName('ABF_CODFIS').AsString;
        cdsProdutosVALCOM.AsFloat := LfltValCom;
        cdsProdutosIMPDIR.AsString := cdsVenda.FieldByName('ITE_IMPDIR').AsString;
        cdsProdutosICMSAI.AsFloat := cdsVenda.FieldByName('ITE_ICMSAI').AsFloat;
        cdsProdutosIMPFED.AsFloat := cdsVenda.FieldByName('ITE_IMPFED').AsFloat;
        cdsProdutosDESOPE.AsFloat := cdsVenda.FieldByName('ITE_DESOPE').AsFloat;
        cdsProdutosALDIFA.AsFloat := FFatVenda.arrMatItens[LintContador].recDifalFCP.fltAlDifa;
        cdsProdutosVALRET.AsFloat := FFatVenda.arrMatItens[LintContador].fltValRet;
        cdsProdutosBASICM.AsFloat := FFatVenda.arrMatItens[LintContador].fltBasIcm;
        cdsProdutosPERFCP.AsFloat := FFatVenda.arrMatItens[LintContador].recDifalFCP.fltPerFcp;
        cdsProdutosDESESP.AsFloat := FFatVenda.arrMatItens[LintContador].fltDesEsp;

        cdsProdutos.Post;
      end;
    end;

    if LblnChamaCalculaValores then
      pCalculaValores
    else
      edtTotMargem.Text := FloatToStrF(fCalculaMargemGeral, ffNumber, 18, fCfgSis('DECUNI', varInteger));
  finally
    cdsProdutos.First;
    cdsProdutos.EnableControls;
  end;
end;

procedure TfrmFatAnaliseCustoPedido.pCriaDataSetProdutos;
begin
  cdsProdutos.CreateDataSet;
  cdsProfissionais.CreateDataSet;
  cdsProfissionais.AggregatesActive := True;

  TFloatField(cdsProdutos.FieldByName('QTDITE')).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
  TFloatField(cdsProdutos.FieldByName('UNITAR')).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
  TFloatField(cdsProdutos.FieldByName('DESESP')).DisplayFormat := '#,##0.00';
  TFloatField(cdsProdutos.FieldByName('VLRTOT')).DisplayFormat := '#,##0.00';
  TFloatField(cdsProdutos.FieldByName('FREENT')).DisplayFormat := '#,##0.00';
  TFloatField(cdsProdutos.FieldByName('CMV')).DisplayFormat := '#,##0.00';
  TFloatField(cdsProdutos.FieldByName('COMPRO')).DisplayFormat := '#,##0.00';
  TFloatField(cdsProdutos.FieldByName('TAXCAR')).DisplayFormat := '#,##0.00';
  TFloatField(cdsProdutos.FieldByName('CUSTOT')).DisplayFormat := '#,##0.00';
  TFloatField(cdsProdutos.FieldByName('RESULT')).DisplayFormat := '#,##0.00';
  TFloatField(cdsProdutos.FieldByName('MARGEM')).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));

  TFloatField(cdsProfissionais.FieldByName('COMPRO')).DisplayFormat := '##0.00';

  cxgProdutosQTDITE.Summary.FooterFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
  cxgProdutosVLRUNI.Summary.FooterFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
  cxgProdutosDESESP.Summary.FooterFormat := '#,##0.00';
  cxgProdutosVLRTOT.Summary.FooterFormat := '#,##0.00';
  cxgProdutosFREENT.Summary.FooterFormat := '#,##0.00';
  cxgProdutosCMV.Summary.FooterFormat := '#,##0.00';
  cxgProdutosCOMPRO.Summary.FooterFormat := '#,##0.00';
  cxgProdutosTAXCAR.Summary.FooterFormat := '#,##0.00';
  cxgProdutosCUSTOT.Summary.FooterFormat := '#,##0.00';
  cxgProdutosRESULT.Summary.FooterFormat := '#,##0.00';

  pCriarCdsVenda(Nil);
  FFatVenda := TFatVenda.CreateInstance('PD');
  FqryPedido := fCriaQuery;
  FNumProfi := fCfgSis('NROPRO');
end;

procedure TfrmFatAnaliseCustoPedido.pAfterScrollProfissionais(
  DataSet: TDataSet);
begin
  pCalculaValoresComissaoProfissionaisVarios(DataSet)
end;

procedure TfrmFatAnaliseCustoPedido.pCalculaValores;
var
  LfltComPro: Double;
  LfltTaxCar: Double;
  LfltTotIte: Double;
  LfltImcSTPV: Double;
  LblnCalcST: Boolean;
begin
  if not Assigned(cdsProdutos) then
    Exit;

  if not cdsProdutos.Active then
    Exit;

  if cdsProdutos.RecordCount <= 0 then
    Exit;

  LfltComPro := 0;

  if FNumProfi = PROFISSIONAIS_VARIOS then
  begin
    pCalculaValoresComissaoProfissionaisVarios(cdsProfissionais);
  end
  else
  begin
    if (edtValorComissao.Enabled) and (not fEmptyStr(edtValorComissao.Text)) then
      LfltComPro := fStrToFloat(edtValorComissao.Text,0) / 100;
  end;

  cdsProdutos.DisableControls;

  try
    cdsProdutos.First;

    while not cdsProdutos.Eof do
    begin
      LfltTotIte := cdsProdutosVLRTOT.AsFloat - cdsProdutosDESESP.AsFloat;

      LfltTaxCar := 0;
      if (edtCodCar.Enabled) and (not fEmptyStr(edtCodCar.Text)) then
        LfltTaxCar := fRetTaxaCartao(edtCodCar.Text, LfltTotIte);

      cdsProdutos.Edit;

      if FNumProfi <> PROFISSIONAIS_VARIOS then
        cdsProdutosCOMPRO.AsFloat := (LfltTotIte * LfltComPro);

      cdsProdutosTAXCAR.AsFloat := LfltTaxCar;
      cdsProdutosCUSTOT.AsFloat := (cdsProdutosFREENT.AsFloat + cdsProdutosCMV.AsFloat + cdsProdutosCOMPRO.AsFloat + cdsProdutosTAXCAR.AsFloat);
      cdsProdutosRESULT.AsFloat := (cdsProdutosVLRTOT.AsFloat - cdsProdutosCUSTOT.AsFloat);
      cdsProdutosOUTVAL.AsFloat := (cdsProdutosFREENT.AsFloat + cdsProdutosCOMPRO.AsFloat + cdsProdutosTAXCAR.AsFloat);

      FFatVenda.objIcStPv.pAdd(cdsProdutosCODITE.AsString,
                               FFatVenda.fGetEmpCalculoItem(cdsProdutosEMPITE.AsString),
                               FFatVenda.GetTipAbf(cdsProdutosEMPITE.AsString),
                               FFatVenda.fUFDestTrib(cdsProdutosEMPITE.AsString),
                               cdsProdutosCODFIS.AsString,
                               LfltImcSTPV,
                               LblnCalcST);

      cdsProdutosMARGEM.AsFloat := fCalculaPrecoVenda(2, cdsProdutosCUSTOT.AsFloat,
                                                      cdsProdutosVLRTOT.AsFloat,
                                                      0,
                                                      IIF(fCfgSis('IMPCF4') = 'S',FfatVenda.fCalculaAliquota(cdsProdutosCODITE.AsString, cdsProdutosEMPITE.AsString, cdsProdutosIMPDIR.AsString), cdsProdutosICMSAI.AsFloat),
                                                      cdsProdutosIMPFED.AsFloat,
                                                      cdsProdutosDESOPE.AsFloat,
                                                      cdsProdutosVALCOM.asFloat,
                                                      fMarMpkParaVenda(fCfgSis('MARMKP')),
                                                      fCfgSis('PCMPRO'),
                                                      fCfgSis('DECUNI'),
                                                      LfltImcSTPV,
                                                      LblnCalcST,
                                                      IIF( not fCfgSis('CLPVDI', varBoolean), cdsProdutosALDIFA.AsFloat, 0),
                                                      IIF( not fCfgSis('CLPVDI', varBoolean) And (cdsProdutosVALRET.AsFloat = 0) And (cdsProdutosBASICM.AsFloat <> 0), cdsProdutosPERFCP.AsFloat, 0));
      cdsProdutos.Post;

      cdsProdutos.Next;
    end;

    edtTotMargem.Text := FloatToStrF(fCalculaMargemGeral, ffNumber, 18, fCfgSis('DECUNI', varInteger));
  finally
    cdsProdutos.First;
    cdsProdutos.EnableControls;
  end;

end;

procedure TfrmFatAnaliseCustoPedido.pCalculaValoresAtualizandoFrete(
  const AValorFrete: Double);
var
  LfltImcSTPV: Double;
  LblnCalcST: Boolean;
begin
  if not Assigned(cdsProdutos) then
    Exit;

  if not cdsProdutos.Active then
    Exit;

  if cdsProdutos.RecordCount <= 0 then
    Exit;

  if cdsProdutos.RecNo < 1 then
    Exit;

  try
    cdsProdutos.Edit;
    cdsProdutosFREENT.AsFloat := AValorFrete;
    cdsProdutosCUSTOT.AsFloat := (cdsProdutosFREENT.AsFloat + cdsProdutosCMV.AsFloat + cdsProdutosCOMPRO.AsFloat + cdsProdutosTAXCAR.AsFloat);
    cdsProdutosRESULT.AsFloat := (cdsProdutosVLRTOT.AsFloat - cdsProdutosCUSTOT.AsFloat);
    cdsProdutosOUTVAL.AsFloat := (cdsProdutosFREENT.AsFloat + cdsProdutosCOMPRO.AsFloat + cdsProdutosTAXCAR.AsFloat);

    FFatVenda.objIcStPv.pAdd(cdsProdutosCODITE.AsString,
                             FFatVenda.fGetEmpCalculoItem(cdsProdutosEMPITE.AsString),
                             FFatVenda.GetTipAbf(cdsProdutosEMPITE.AsString),
                             FFatVenda.fUFDestTrib(cdsProdutosEMPITE.AsString),
                             cdsProdutosCODFIS.AsString,
                             LfltImcSTPV,
                             LblnCalcST);

    cdsProdutosMARGEM.AsFloat := fCalculaPrecoVenda(2, cdsProdutosCUSTOT.AsFloat,
                                                    cdsProdutosVLRTOT.AsFloat,
                                                    0,
                                                    IIF(fCfgSis('IMPCF4') = 'S',FfatVenda.fCalculaAliquota(cdsProdutosCODITE.AsString, cdsProdutosEMPITE.AsString, cdsProdutosIMPDIR.AsString), cdsProdutosICMSAI.AsFloat),
                                                    cdsProdutosIMPFED.AsFloat,
                                                    cdsProdutosDESOPE.AsFloat,
                                                    cdsProdutosVALCOM.asFloat,
                                                    fMarMpkParaVenda(fCfgSis('MARMKP')),
                                                    fCfgSis('PCMPRO'),
                                                    fCfgSis('DECUNI'),
                                                    LfltImcSTPV,
                                                    LblnCalcST,
                                                    IIF( not fCfgSis('CLPVDI', varBoolean), cdsProdutosALDIFA.AsFloat, 0),
                                                    IIF( not fCfgSis('CLPVDI', varBoolean) And (cdsProdutosVALRET.AsFloat = 0) And (cdsProdutosBASICM.AsFloat <> 0), cdsProdutosPERFCP.AsFloat, 0));

    cdsProdutos.Post;

    edtTotMargem.Text := FloatToStrF(fCalculaMargemGeral, ffNumber, 18, fCfgSis('DECUNI', varInteger));
  finally

  end;
end;

procedure TfrmFatAnaliseCustoPedido.pCalculaValoresComissaoProfissionaisVarios(DataSet: TDataSet);
var
  LfltTotIte: Double;
  LfltImcSTPV: Double;
  LblnCalcST: Boolean; 
begin
  if not Assigned(cdsProdutos) then
    Exit;

  if not cdsProdutos.Active then
    Exit;

  if cdsProdutos.RecordCount <= 0 then
    Exit;

  if not Assigned(DataSet) then
    Exit;

  if not DataSet.Active then
    Exit;

  if DataSet.RecordCount <= 0 then
    Exit;

  if DataSet.RecNo <= 0 then
    Exit;

  cdsProdutos.DisableControls;
  DataSet.DisableControls;

  try
    cdsProdutos.First;
    
    while not cdsProdutos.Eof do
    begin
      LfltTotIte := cdsProdutosVLRTOT.AsFloat - cdsProdutosDESESP.AsFloat;

      cdsProdutos.Edit;
      cdsProdutosCOMPRO.AsFloat := (LfltTotIte * (DataSet.FieldByName('TOTCOMPRO').Value / 100));
      cdsProdutosCUSTOT.AsFloat := (cdsProdutosFREENT.AsFloat + cdsProdutosCMV.AsFloat + cdsProdutosCOMPRO.AsFloat + cdsProdutosTAXCAR.AsFloat);
      cdsProdutosRESULT.AsFloat := (cdsProdutosVLRTOT.AsFloat - cdsProdutosCUSTOT.AsFloat);
      cdsProdutosOUTVAL.AsFloat := (cdsProdutosFREENT.AsFloat + cdsProdutosCOMPRO.AsFloat + cdsProdutosTAXCAR.AsFloat);

      FFatVenda.objIcStPv.pAdd(cdsProdutosCODITE.AsString,
                               FFatVenda.fGetEmpCalculoItem(cdsProdutosEMPITE.AsString),
                               FFatVenda.GetTipAbf(cdsProdutosEMPITE.AsString),
                               FFatVenda.fUFDestTrib(cdsProdutosEMPITE.AsString),
                               cdsProdutosCODFIS.AsString,
                               LfltImcSTPV,
                               LblnCalcST);

      cdsProdutosMARGEM.AsFloat := fCalculaPrecoVenda(2, cdsProdutosCUSTOT.AsFloat,
                                                      cdsProdutosVLRTOT.AsFloat,
                                                      0,
                                                      IIF(fCfgSis('IMPCF4') = 'S',FfatVenda.fCalculaAliquota(cdsProdutosCODITE.AsString, cdsProdutosEMPITE.AsString, cdsProdutosIMPDIR.AsString), cdsProdutosICMSAI.AsFloat),
                                                      cdsProdutosIMPFED.AsFloat,
                                                      cdsProdutosDESOPE.AsFloat,
                                                      cdsProdutosVALCOM.asFloat,
                                                      fMarMpkParaVenda(fCfgSis('MARMKP')),
                                                      fCfgSis('PCMPRO'),
                                                      fCfgSis('DECUNI'),
                                                      LfltImcSTPV,
                                                      LblnCalcST,
                                                      IIF( not fCfgSis('CLPVDI', varBoolean), cdsProdutosALDIFA.AsFloat, 0),
                                                      IIF( not fCfgSis('CLPVDI', varBoolean) And (cdsProdutosVALRET.AsFloat = 0) And (cdsProdutosBASICM.AsFloat <> 0), cdsProdutosPERFCP.AsFloat, 0));
      cdsProdutos.Post;
          
      cdsProdutos.Next;
    end;

    edtTotMargem.Text := FloatToStrF(fCalculaMargemGeral, ffNumber, 18, fCfgSis('DECUNI', varInteger));
  finally
    cdsProdutos.First;
    cdsProdutos.EnableControls;
    cdsProfissionais.AfterPost := Nil;
    DataSet.EnableControls;
  end;
end;

end.
