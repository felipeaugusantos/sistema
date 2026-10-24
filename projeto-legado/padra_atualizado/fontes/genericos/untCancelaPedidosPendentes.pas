unit untCancelaPedidosPendentes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,frxExportCSVTestabilidade, Vcl.AppEvnts,
  Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls,
  cxLookAndFeels,cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,cxDataStorage,
  cxEdit, cxNavigator,cxDataControllerConditionalFormattingRulesManagerDialog,Data.DB,cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,cxGridTableView, cxGridDBTableView,
  cxGrid, cxCalendar, cxTextEdit,cxCurrencyEdit,UniClientDataSet,Uni,untGravando,CxProgressBar;

type
  TfrmCancelaPedidosPendentes = class(TfrmPai)
    pnlFundo: TPanel;
    cxGridPedidosDBTableViewPedidos: TcxGridDBTableView;
    cxGridPedidosLevel1: TcxGridLevel;
    cxGridPedidos: TcxGrid;
    cxGridPedidosDBTableViewPedidosColumnDATA_EMISSAO: TcxGridDBColumn;
    cxGridPedidosDBTableViewPedidosColumnPEDIDO: TcxGridDBColumn;
    cxGridPedidosDBTableViewPedidosColumnVENDEDOR: TcxGridDBColumn;
    cxGridPedidosDBTableViewPedidosColumnCOND_PAGAMENTO: TcxGridDBColumn;
    cxGridPedidosDBTableViewPedidosColumnCLIENTE: TcxGridDBColumn;
    cxGridPedidosDBTableViewPedidosColumnVALOR_PEDIDO: TcxGridDBColumn;
    cxGridPedidosDBTableViewPedidosMARDES: TcxGridDBColumn;
    pnlLegendas: TPanel;
    Shape4: TShape;
    Label1: TLabel;
    Shape5: TShape;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    btnMarcarTodos: TBitBtnLocked;
    btnDesmarcarTodos: TBitBtnLocked;
    btnCancelarPedidos: TBitBtnLocked;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cxGridPedidosDBTableViewPedidosCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridPedidosDBTableViewPedidosCellDblClick(
      Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridPedidosDBTableViewPedidosKeyDown(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure cxGridPedidosDBTableViewPedidosColumnVENDEDORGetCellHint(
      Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      ACellViewInfo: TcxGridTableDataCellViewInfo; const AMousePos: TPoint;
      var AHintText: TCaption; var AIsHintMultiLine: Boolean;
      var AHintTextRect: TRect);
    procedure cxGridPedidosDBTableViewPedidosColumnCLIENTEGetCellHint(
      Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      ACellViewInfo: TcxGridTableDataCellViewInfo; const AMousePos: TPoint;
      var AHintText: TCaption; var AIsHintMultiLine: Boolean;
      var AHintTextRect: TRect);
    procedure cxGridPedidosDBTableViewPedidosColumnCOND_PAGAMENTOGetCellHint(
      Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      ACellViewInfo: TcxGridTableDataCellViewInfo; const AMousePos: TPoint;
      var AHintText: TCaption; var AIsHintMultiLine: Boolean;
      var AHintTextRect: TRect);
    procedure btnMarcarTodosClick(Sender: TObject);
    procedure btnDesmarcarTodosClick(Sender: TObject);
    procedure btnCancelarPedidosClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    FCdsPedidos: TUniClientDataSet;
    FDtsPedidos: TDataSource;
    FExitePedidosPendentes: Boolean;
    FContinuarCancelamento: Boolean;
    FPermissaoParaCancelamento: Boolean;
    FCorZebra : Integer;
    FOperador : String;

    function RetornaSQLPedidosPendentes:String;
    procedure CarregaPedidos;
    procedure MarcaDesmarca;
    procedure MarcarTodos;
    procedure DesmarcarTodos;
    procedure CancelarPedido;
    function CancelandoPedidosPendente(pgbStatus: TcxProgressBar = Nil): Boolean;
    function PedidoCanceladoComSucesso:Boolean;
  public
    { Public declarations }
    property ExitePedidosPendentes: Boolean Read FExitePedidosPendentes;
    property Operador: String Write FOperador;
  end;

implementation

Uses untFuncoesSimples,untCancelamentoDocumentos;

{$R *.dfm}

{ TfrmCancelaPedidosPendentes }

procedure TfrmCancelaPedidosPendentes.btnDesmarcarTodosClick(Sender: TObject);
begin
  inherited;

  If Not btnDesmarcarTodos.Enabled Then
    Exit;

  TfrmGravando.fExecutarModal(DesmarcarTodos,'Aguarde... Desmarcando todos os pedidos.','');
end;

procedure TfrmCancelaPedidosPendentes.btnCancelarPedidosClick(Sender: TObject);
  var
    LfrmGravando : TfrmGravando;
    LRecNo : Integer;
begin
  inherited;

  If Not btnCancelarPedidos.Enabled Then
    Exit;

  Try
    LRecNo := FCdsPedidos.RecNo;
    FCdsPedidos.DisableControls;

    FCdsPedidos.Filtered := False;
    FCdsPedidos.Filter := 'MARDES = ' +  QuotedStr('M');
    FCdsPedidos.Filtered  := True;

    If FCdsPedidos.IsEmpty Then
    Begin
      fMensagem('ATENÇÃO', 'Selecione ao menos um pedido!',['&OK']);
      FCdsPedidos.Filtered := False;
      FCdsPedidos.Filter   := '';
      FCdsPedidos.Filtered := True;
      FCdsPedidos.RecNo := LRecNo;

      Exit;
    End;

    If fMensagem('ATENÇÃO!','Todos os pedidos selecionados serão cancelados.' + #10#13 +
                            'Deseja realmente continuar com este procedimento?', ['&Sim', '&Não'],2) = 2 Then
    Begin
      FCdsPedidos.Filtered := False;
      FCdsPedidos.Filter   := '';
      FCdsPedidos.Filtered := True;
      FCdsPedidos.RecNo := LRecNo;

      Exit;
    End;

    Try
      Try
        pCriarFormularios(TfrmGravando, LfrmGravando);
        LfrmGravando.lblGravando.Caption := 'Aguarde... Cancelando os pedidos selecionados...';
        LfrmGravando.fExecutarAcao := CancelandoPedidosPendente;
        LfrmGravando.ShowModal;

        FExitePedidosPendentes := False;
        CarregaPedidos;
      Finally
        FreeAndNil(LfrmGravando);
      End;
    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    FCdsPedidos.EnableControls;
  End;
end;

procedure TfrmCancelaPedidosPendentes.btnMarcarTodosClick(Sender: TObject);
begin
  inherited;

  If Not btnMarcarTodos.Enabled Then
    Exit;

  TfrmGravando.fExecutarModal(MarcarTodos,'Aguarde... Marcando todos os pedidos.','');
end;

function TfrmCancelaPedidosPendentes.CancelandoPedidosPendente(
  pgbStatus: TcxProgressBar): Boolean;

begin
  Result := True;
  FCdsPedidos.DisableControls;

  pgbStatus.Visible := True;
  pgbStatus.Properties.Max := FCdsPedidos.RecordCount;
  pgbStatus.Position := 0;

  FCdsPedidos.First;
  While Not FCdsPedidos.Eof Do
  Begin
    pnlInfo.Caption := ' Cancelando o Pedido ' + FCdsPedidos.FieldByName('PEDIDO').AsString + '.';
    CancelarPedido;

    If Not FContinuarCancelamento Then
      Break;

    pgbStatus.Position := pgbStatus.Position + 1;
    FCdsPedidos.Next;
  End;

  pnlInfo.Caption := '';
  FCdsPedidos.EnableControls;
end;

procedure TfrmCancelaPedidosPendentes.CancelarPedido;
  Var
    LCancelamentoDocumentos: TfrmCancelamentoDocumentos;
begin
  Try
    Try
      pCriarFormularios(TfrmCancelamentoDocumentos, LCancelamentoDocumentos);

      LCancelamentoDocumentos.pSetEspecie('PD');
      LCancelamentoDocumentos.lsbEspecies.ItemIndex := LCancelamentoDocumentos.IndiceEspecie;
      LCancelamentoDocumentos.lsbEspeciesDblClick(LCancelamentoDocumentos.lsbEspecies);

      LCancelamentoDocumentos.edtNumDoc.Text  := FCdsPedidos.FieldByName('FGO_NUMDOC').AsString;
      LCancelamentoDocumentos.edtCliFor.Text  := FCdsPedidos.FieldByName('FGO_CODCLI').AsString;
      LCancelamentoDocumentos.CancelamentoDePedidoPendenteDeFaturamento := True;
      LCancelamentoDocumentos.btnAdicionar.Click;

      If (FCdsPedidos.RecNo <> FCdsPedidos.RecordCount) Then
      Begin
        If Not PedidoCanceladoComSucesso Then
        Begin
          If fMensagem('ATENÇÃO!','Não foi possível cancelar o pedido ' +FCdsPedidos.FieldByName('PEDIDO').AsString + #10#13 +
                                  'Deseja continuar com o cancelamento dos demais pedidos selecionados?', ['&Sim', '&Não'],1) = 2 Then
          Begin
            FContinuarCancelamento := False;
          End;
        End;
      End;

    Finally
      FreeAndNil(LCancelamentoDocumentos);
    End;

  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;

end;

procedure TfrmCancelaPedidosPendentes.CarregaPedidos;
  Var
    LFatGor : TUniQuery;
begin

  Try
    LFatGor := fCriaQuery(Nil);
    Try
      LFatGor.Close;
      LFatGor.SQL.Clear;
      LFatGor.SQL.Text := RetornaSQLPedidosPendentes;
      LFatGor.Open;

      If Not LFatGor.IsEmpty Then
      Begin
        pSetaClient(LFatGor);

        FCdsPedidos := fCriaClientDatset(LFatGor);
        FDtsPedidos := fCriaDataSource(FCdsPedidos);

        FCdsPedidos.First;
        cxGridPedidosDBTableViewPedidos.DataController.DataSource := FdtsPedidos;
        FExitePedidosPendentes := True;
      End
      Else
        btnSair.Click;

    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    FreeAndNil(LFatGor);
  End;

end;

procedure TfrmCancelaPedidosPendentes.cxGridPedidosDBTableViewPedidosCellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  MarcaDesmarca;
end;

procedure TfrmCancelaPedidosPendentes.cxGridPedidosDBTableViewPedidosColumnCLIENTEGetCellHint(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  ACellViewInfo: TcxGridTableDataCellViewInfo; const AMousePos: TPoint;
  var AHintText: TCaption; var AIsHintMultiLine: Boolean;
  var AHintTextRect: TRect);
begin
  inherited;
  AHintText := VarToStr(ARecord.Values[Sender.Index]);
  AIsHintMultiLine := True;
end;

procedure TfrmCancelaPedidosPendentes.cxGridPedidosDBTableViewPedidosColumnCOND_PAGAMENTOGetCellHint(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  ACellViewInfo: TcxGridTableDataCellViewInfo; const AMousePos: TPoint;
  var AHintText: TCaption; var AIsHintMultiLine: Boolean;
  var AHintTextRect: TRect);
begin
  inherited;
  AHintText := VarToStr(ARecord.Values[Sender.Index]);
  AIsHintMultiLine := True;
end;

procedure TfrmCancelaPedidosPendentes.cxGridPedidosDBTableViewPedidosColumnVENDEDORGetCellHint(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  ACellViewInfo: TcxGridTableDataCellViewInfo; const AMousePos: TPoint;
  var AHintText: TCaption; var AIsHintMultiLine: Boolean;
  var AHintTextRect: TRect);
begin
  inherited;
  AHintText := VarToStr(ARecord.Values[Sender.Index]);
  AIsHintMultiLine := True;
end;

procedure TfrmCancelaPedidosPendentes.cxGridPedidosDBTableViewPedidosCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var
    LMarDes: String;
begin
  inherited;

  If (Not AViewInfo.GridRecord.Focused) And
     (AViewInfo.GridRecord.Index Mod 2 = 0) Then
  Begin
    ACanvas.Brush.Color := FCorZebra;
  End;

  LMarDes := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxGridPedidosDBTableViewPedidosMARDES.Index]);

  If (LMarDes = 'M') Then
  Begin
    If (Not AViewInfo.Selected) Then
      ACanvas.Font.Color := clBlue
    Else
      ACanvas.Font.Color := clLime;
  End;
end;

procedure TfrmCancelaPedidosPendentes.cxGridPedidosDBTableViewPedidosKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_SPACE) Then
    MarcaDesmarca
  Else If  (Key = VK_RETURN) Then
    MarcaDesmarca;
end;

procedure TfrmCancelaPedidosPendentes.DesmarcarTodos;
  Var
    LRecNo: Integer;
begin
  Try
    FCdsPedidos.DisableControls;
    LRecNo := FCdsPedidos.RecNo;

    FCdsPedidos.First;
    While Not FCdsPedidos.Eof Do
    Begin
      FCdsPedidos.Edit;
      FCdsPedidos.FieldByName('MARDES').AsString := 'D';
      FCdsPedidos.Post;
      FCdsPedidos.Next;
    End;

    FCdsPedidos.RecNo := LRecNo;
    FCdsPedidos.EnableControls;

  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;
end;

procedure TfrmCancelaPedidosPendentes.FormCreate(Sender: TObject);
begin
  inherited;
  FExitePedidosPendentes := False;
  FContinuarCancelamento := True;
  FCorZebra := fCfgSis('CORZEB', varInteger);
  CarregaPedidos;
end;

procedure TfrmCancelaPedidosPendentes.FormDestroy(Sender: TObject);
begin
  inherited;
  If Assigned(FDtsPedidos) Then
    FreeAndNil(FDtsPedidos);

  If Assigned(FCdsPedidos) Then
    FreeAndNil(FCdsPedidos);
end;

procedure TfrmCancelaPedidosPendentes.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If  (Key = VK_F2) Then
    btnMarcarTodos.Click
  Else If (Key = VK_F3) Then
    btnDesmarcarTodos.Click
  Else If (Key = VK_F9) Then
    btnCancelarPedidos.Click;
end;

procedure TfrmCancelaPedidosPendentes.FormShow(Sender: TObject);
begin
  inherited;
  Try
    FPermissaoParaCancelamento := fVerificaAcessoSistema('PERCANCELARPEDIDORCX', FOperador);

    If Not FPermissaoParaCancelamento Then
    Begin
      btnMarcarTodos.Enabled     := False;
      btnDesmarcarTodos.Enabled  := False;
      btnCancelarPedidos.Enabled := False;
    End;

    pSetFocus(cxGridPedidos);
    cxGridPedidosDBTableViewPedidos.Columns[0].FocusWithSelection;

  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;
end;

procedure TfrmCancelaPedidosPendentes.MarcaDesmarca;
  Var
    LMarcado: Boolean;
begin
  Try
    If Not FPermissaoParaCancelamento Then
      Exit;

    LMarcado := FCdsPedidos.FieldByName('MARDES').AsString.Equals('M');

    FCdsPedidos.Edit;
    FCdsPedidos.FieldByName('MARDES').AsString := IIF(LMarcado,'D','M');
    FCdsPedidos.Post;

  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;
end;

procedure TfrmCancelaPedidosPendentes.MarcarTodos;
  Var
    LRecNo: Integer;
begin
  FCdsPedidos.DisableControls;
  LRecNo := FCdsPedidos.RecNo;

  FCdsPedidos.First;
  While Not FCdsPedidos.Eof Do
  Begin
    FCdsPedidos.Edit;
    FCdsPedidos.FieldByName('MARDES').AsString := 'M';
    FCdsPedidos.Post;
    FCdsPedidos.Next;
  End;
  FCdsPedidos.RecNo := LRecNo;
  FCdsPedidos.EnableControls;
end;

function TfrmCancelaPedidosPendentes.PedidoCanceladoComSucesso: Boolean;
  Var
    LFatGor: TUniQuery;
begin
  Result := False;
  Try
    LFatGor := fCriaQuery(Nil);
    Try
      LFatGor.Close;
      LFatGor.SQL.Clear;
      LFatGor.SQL.Text := 'SELECT                      '+
                          '  FGO_NUMDOC                '+
                          'FROM                        '+
                          '  FATGOR                    '+
                          'WHERE FGO_ESPDOC = "PD"     '+
                          '  AND FGO_JAFATU = 0        '+
                          '  AND FGO_NUMDOC = :NUMDOC  '+
                          '  AND FGO_CODCLI = :CODCLI  '+
                          '  AND FGO_CODEMP = :CODEMP  ';

      LFatGor.ParamByName('NUMDOC').AsString := FCdsPedidos.FieldByName('FGO_NUMDOC').AsString;
      LFatGor.ParamByName('CODCLI').AsString := FCdsPedidos.FieldByName('FGO_CODCLI').AsString;
      LFatGor.ParamByName('CODEMP').AsString := VS_strCodEmp;
      LFatGor.Open;

      Result := LFatGor.IsEmpty;

    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    FreeAndNil(LFatGor);
  End;
end;

function TfrmCancelaPedidosPendentes.RetornaSQLPedidosPendentes: String;
  Var
    intQtdeDias: Integer;
begin
  intQtdeDias := fCfgSis('QDFECA', varInteger);
  Result := 'SELECT                                                             '+
            '  FGO_DTAENT AS DATA_EMISSAO,                                      '+
            '  CONCAT(FGO_NUMDOC, "-", FGO_ESPDOC, "-", FGO_CODEMP) AS PEDIDO,  '+
            '  CONCAT(FGO_CODVEN, "-", OPE_NOMOPE) AS VENDEDOR,                 '+
            '  CONCAT(FGO_CODCLI, "-", CLI_NOMCLI) AS CLIENTE,                  '+
            '  CONCAT(FGO_CODCND, "-", CND_DESCRI) AS COND_PAGAMENTO,           '+
            '  FGO_VLRCON AS VALOR_PEDIDO,                                      '+
            '  "D" AS MARDES,                                                   '+
            '  FGO_NUMDOC,                                                      '+
            '  FGO_CODCLI                                                       '+
            'FROM                                                               '+
            '  FATGOR                                                           '+
            'INNER JOIN CADCLI                                                  '+
            '  ON CLI_CODCLI = FGO_CODCLI                                       '+
            'INNER JOIN EXTGOR                                                  '+
            '  ON FGO_SEQFGO = FATGOR.AUTOINCREM                                '+
            'INNER JOIN CADOPE                                                  '+
            '  ON OPE_CODOPE = FGO_CODVEN                                       '+
            'LEFT JOIN CADCND                                                   '+
            '  ON CADCND.CND_CODIGO = FATGOR.FGO_CODCND                         '+
            'LEFT JOIN CADEMP                                                   '+
            '  ON EMP_CLIFIL = FATGOR.FGO_CODCLI                                '+
            'WHERE FGO_ESPDOC = "PD"                                            '+
            ' AND  FGO_JAFATU = 0                                               '+
            ' AND  FGO_CODEMP = ' + VS_strCodEmp.QuotedString + '               '+
            ' AND  FGO_VLRCON > 0                                               '+
            ' AND  FGO_DOCEND IS NULL                                           '+
            ' AND  EMP_CLIFIL IS NULL                                           ';
  If (fCfgSis('RCXPDP', varBoolean)) And (intQtdeDias > 0) Then
    Result := Result + #13 + 'AND FGO_DTAENT < DATE_SUB(CURDATE(), INTERVAL '+ intQtdeDias.ToString+' DAY) ';
  Result := Result + #13 + 'ORDER BY FGO_DTAENT, FGO_HORENT                     ';
end;

end.


