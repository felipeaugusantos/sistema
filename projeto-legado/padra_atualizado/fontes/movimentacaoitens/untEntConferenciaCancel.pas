unit untEntConferenciaCancel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiEdit, AppEvnts, Menus, StdCtrls, Buttons, BitBtnLockedIncrem,
  ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage,
  cxEdit, DB, cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  Uni, untZClient, cxLookAndFeels,
  cxLookAndFeelPainters, cxNavigator, frxClass,
  frxExportCSVTestabilidade,
  cxDataControllerConditionalFormattingRulesManagerDialog, untTLock;

type
  TfrmEntConferenciaCancel = class(TfrmPaiEdit)
    btnConfirma: TBitBtnLocked;
    cxgPedidosView: TcxGridDBTableView;
    cxgPedidosLevel1: TcxGridLevel;
    cxgPedidos: TcxGrid;
    btnMarDes: TBitBtnLocked;
    cxgPedidosNUMPED: TcxGridDBColumn;
    cxgPedidosCODEMP: TcxGridDBColumn;
    cxgPedidosDTAPED: TcxGridDBColumn;
    cxgPedidosCODFOR: TcxGridDBColumn;
    cxgPedidosNOMFOR: TcxGridDBColumn;
    cxgPedidosTOTITE: TcxGridDBColumn;
    cxgPedidosMARDES: TcxGridDBColumn;
    procedure cxgPedidosViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnMarDesClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    cdsPedidos: TZClient;
    objLock: TLock;

    Function fSQLPedidos: String;
    Function fCancelaConferencias: Boolean;
    Function fMarcouPedido: Boolean;

    procedure pSelecinaPedido;
    procedure pCancelaConfPedido;
    procedure pAbreConsulta;

  public
    { Public declarations }
  end;

implementation

uses untFuncoesSimples;

{$R *.dfm}

procedure TfrmEntConferenciaCancel.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  If Not fMarcouPedido Then
  Begin
    Exit;
    pMensagemOk('Selecione os pedidos para cancelamento!');
  End;

  If fPergunta('Confirma o cancelamento das conferências selecionadas?') And
     fCancelaConferencias Then
  Begin
    pMensagemOk('Operação realizada com sucesso!');
  End;
end;

procedure TfrmEntConferenciaCancel.btnMarDesClick(Sender: TObject);
begin
  inherited;
  pSelecinaPedido;
end;

procedure TfrmEntConferenciaCancel.cxgPedidosViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgPedidosMARDES.Index]) = 'S' Then
  Begin

    ACanvas.Brush.Color := clRed;

//    If AViewInfo.Selected Then
//      ACanvas.Font.Color := clBlack;

  End

end;

Function TfrmEntConferenciaCancel.fSQLPedidos: String;
  Var
    strSQL: String;
Begin
  strSQL := '/* untEntConferenciaCancel.fSQLPedidos */';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '   PCG_NUMPED AS NUMPED, ';
  strSQL := strSQL + '   PCG_CODEMP AS CODEMP, ';
  strSQL := strSQL + '   PCG_CODFOR AS CODFOR, ';
  strSQL := strSQL + '   FOR_NOMFOR AS NOMFOR, ';
  strSQL := strSQL + '   PCG_DTAPED AS DTAPED, ';
  strSQL := strSQL + '   PCG_TOTITE AS TOTITE, ';
  strSQL := strSQL + '   "N"        AS MARDES  ';
  strSQL := strSQL + ' FROM     ';
  strSQL := strSQL + '   PCMGER ';
  strSQL := strSQL + '   INNER JOIN CADFOR ON FOR_CODFOR = PCG_CODFOR ';
  strSQL := strSQL + ' WHERE    ';
  strSQL := strSQL + '   PCG_DTALIB IS NOT NULL     AND ';
  strSQL := strSQL + '   PCG_BAIXAD = 0             AND ';
  strSQL := strSQL + '   PCG_NUMCTN = 0             AND ';
  strSQL := strSQL + '   IF(IFNULL(PCG_EMPDES, "") = "", PCG_CODEMP = ' + QuotedStr(VS_strCodEmp) + ', PCG_EMPDES = ' + QuotedStr(VS_strCodEmp) + ') AND ';
  strSQL := strSQL + '   PCG_ESPDOC = "PD"  ';
  Result := strSQL;
End;

procedure TfrmEntConferenciaCancel.pAbreConsulta;
Begin
  cdsPedidos.fAbreClient(True, 'TfrmEntConferenciaCancel.pAbreConsulta');
  cdsPedidos.pFormataDecimal('TOTITE', 2);
  objLock.pDestravarTodos;
End;

procedure TfrmEntConferenciaCancel.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  FreeAndNil(objLock);
end;

procedure TfrmEntConferenciaCancel.FormCreate(Sender: TObject);
begin
  inherited;

  cdsPedidos := TZClient.Create(Self, fSQLPedidos);
  objLock := TLock.Create;
  pAbreConsulta;

  cxgPedidosView.DataController.DataSource := cdsPedidos.dtsSource;
end;

procedure TfrmEntConferenciaCancel.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_SPACE : btnMarDes.Click;
    VK_F10   : btnConfirma.Click;
  End;

end;

procedure TfrmEntConferenciaCancel.FormShow(Sender: TObject);
begin
  inherited;

  pSetFocus(cxgPedidos);
end;

procedure TfrmEntConferenciaCancel.pSelecinaPedido;
Begin
  With cdsPedidos Do
  Begin
    If IsEmpty Then
      Exit;

    If (FieldbyName('MARDES').AsString = 'N') Then
    Begin

      If Not objLock.fLock_Unlock('PEDCOMPD' + FieldbyName('NUMPED').AsString +  VS_strCodEmp, True, False, TRUE) Then
      Begin
        pMensagemOk('Esse Documento está sendo utilizado em outra Estação por ' +
                       fGetHostLock('PEDCOMPD' + FieldbyName('NUMPED').AsString +  VS_strCodEmp)  + '!');

        Exit;
      End;

    End Else
    Begin
      objLock.fLock_Unlock('PEDCOMPD' + FieldbyName('NUMPED').AsString +  VS_strCodEmp, False, False);
    End;

    Edit;

    If FieldbyName('MARDES').AsString = 'S' Then
      FieldbyName('MARDES').AsString := 'N'
    Else
      FieldbyName('MARDES').AsString := 'S';

    Post;
  End;
End;

procedure TfrmEntConferenciaCancel.pCancelaConfPedido;
  Var
    qryUpdate: TUniQuery;
Begin
  qryUpdate := fCriaQuery(Self);

  With qryUpdate, SQL Do
  Begin
    Close;
    Clear;
    Add('UPDATE PCMGER');
    Add('SET PCG_DTALIB = NULL,');
    Add('    PCG_INDCON = NULL,');
    Add('    PCG_INHCON = NULL ');
    Add('WHERE');
    Add('  PCG_NUMPED = :NUMPED AND       ');
    Add('  IF(IFNULL(PCG_EMPDES, "") = "", PCG_CODEMP = ' + QuotedStr(VS_strCodEmp) + ', PCG_EMPDES = ' + QuotedStr(VS_strCodEmp) + ') AND ');
    Add('  PCG_ESPDOC = "PD"    AND       ');
    Add('  PCG_NUMCTN = 0       AND       ');
    Add('  PCG_BAIXAD = 0       AND ');
    Add('  PCG_CODFOR = :CODFOR           ');

    ParamByName('CODFOR').AsString := cdsPedidos.FieldByName('CODFOR').AsString;
    ParamByName('NUMPED').AsString := cdsPedidos.FieldByName('NUMPED').AsString;
    ExecSQL;

    Close;
    Clear;
    Add('UPDATE PCMDET');
    Add('INNER JOIN PCMGER ON ');
    Add('  PCD_NUMPED = PCG_NUMPED AND ');
    Add('  PCD_CODEMP = PCG_CODEMP AND ');
    Add('  PCD_CODFOR = PCG_CODFOR AND ');
    Add('  PCD_ESPDOC = PCG_ESPDOC    ');
    Add('SET PCD_QTDCON = 0');
    Add('WHERE');
    Add('  PCG_NUMPED = :NUMPED AND       ');
    Add('  IF(IFNULL(PCG_EMPDES, "") = "", PCG_CODEMP = ' + QuotedStr(VS_strCodEmp) + ', PCG_EMPDES = ' + QuotedStr(VS_strCodEmp) + ') AND ');
    Add('  PCG_ESPDOC = "PD"    AND       ');
    Add('  PCG_NUMCTN = 0       AND       ');
    Add('  PCG_BAIXAD = 0       AND       ');
    Add('  PCG_CODFOR = :CODFOR           ');

    ParamByName('CODFOR').AsString := cdsPedidos.FieldByName('CODFOR').AsString;
    ParamByName('NUMPED').AsString := cdsPedidos.FieldByName('NUMPED').AsString;
    ExecSQL;

  End;

  FreeAndNil(qryUpdate);
End;

Function TfrmEntConferenciaCancel.fMarcouPedido: Boolean;
Begin
  With cdsPedidos Do
  Begin
    DisableControls;
    Result := Locate('MARDES', 'S', []);
    EnableControls;
  End;
End;

Function TfrmEntConferenciaCancel.fCancelaConferencias: Boolean;
Begin
  With cdsPedidos Do
  Begin
    Try
      DisableControls;
      Filter   := 'MARDES = ' + QuotedStr('S');
      Filtered := True;

      fStartTransaction;

      First;
      While Not Eof Do
      Begin
        pCancelaConfPedido;
        Next;
      End;

      fCommit;

      Result := True;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        Result := False;
        pMensagensErro(E.Message, '[TfrmEntConferenciaCancel.fCancelaConferencias]');
      End;
    End;

    Filtered := False;
    Filter   := '';
    pAbreConsulta;
    EnableControls;
  End;
End;

end.
