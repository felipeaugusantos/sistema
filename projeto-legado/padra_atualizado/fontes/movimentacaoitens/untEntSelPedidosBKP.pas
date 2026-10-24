unit untEntSelPedidos;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, ComCtrls, Buttons, ExtCtrls,
  Grids, DBGridCitel, DBGrids, {Qt,} Menus, EditFocus, Uni, AppEvnts;

type
  TfrmEntSelPedidos = class(TfrmPaiSimples)
    pnlTitulo: TPanel;
    pnlDadosInformativos: TPanel;
    Label6: TLabel;
    Label21: TLabel;
    pnlBotoesSelecao: TPanel;
    btnConfirma: TBitBtn;
    btnSairSelecao: TBitBtn;
    dbgPedidos: TDBGridCitel;
    Label2: TLabel;
    Label4: TLabel;
    edtPedSel: TEditFocus;
    edtTotIte: TEditFocus;
    edtTotIpi: TEditFocus;
    edtTotGer: TEditFocus;
    Label1: TLabel;
    edtTotSub: TEditFocus;
    procedure FormShow(Sender: TObject);
    procedure dbgPedidosDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbgPedidosDblClick(Sender: TObject);
    procedure dbgPedidosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure btnSairSelecaoClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    procedure pCriaTemporaria;
    procedure pAtualizaTemporaria;
    procedure pDeletaTemporaria;

    procedure pCalculaDadosInformativos;
    procedure pCalculaTotal;

    procedure pMarcaDuplicata(blnMarcar: Boolean);
    procedure pSelecionaDuplicata;

    function fTestaDataBalanco(strNumPed, strNumEmp: String): Boolean;

  public
    { Public declarations }
    arrPedidos: Array Of String;
    arrEmpresas: Array Of String;
    blnConfirma: Boolean;
    strCodFor: String;
    intQtdSel: Integer;
  end;

var
  frmEntSelPedidos: TfrmEntSelPedidos;

implementation

uses untFuncoes, untfuncoesSimples, untModuloSPR, untModulo;

{$R *.dfm}

{ TfrmEntSelPedidos }

procedure TfrmEntSelPedidos.pAtualizaTemporaria;
  Var
    strSQL: String;      
begin

  If Not fTabelaExiste('TMP_PCMGER') Then
    pCriaTemporaria;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  TMP_PCMGER ';
  strSQL := strSQL + 'ORDER BY ';
  strSQL := strSQL + '  FOR_NOMFOR, PCG_DTAPED ';

  With frmModuloSPR.qryTemporaria Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    Open;
  End;

  dbgPedidos.Columns[4].Width := 64;
  dbgPedidos.Columns[5].Width := 64;
  dbgPedidos.Columns[6].Width := 64;
  dbgPedidos.Columns[7].Width := 64;

  pCalculaTotal;

end;

procedure TfrmEntSelPedidos.pCriaTemporaria;
  Var
    strSQL: String;
begin

  pDeletaTemporaria;

  strSQL := '';
  strSQL := strSQL + 'CREATE TEMPORARY TABLE TMP_PCMGER ';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  PCG_NUMPED, ';
  strSQL := strSQL + '  PCG_CODEMP, ';
  strSQL := strSQL + '  PCG_CODFOR, ';
  strSQL := strSQL + '  FOR_NOMFOR, ';
  strSQL := strSQL + '  PCG_DTAPED, ';
  strSQL := strSQL + '  FORMAT(PCG_TOTITE, 2) AS PCG_TOTITE, ';
  strSQL := strSQL + '  FORMAT(PCG_TOTSUB, 2) AS PCG_TOTSUB, ';
  strSQL := strSQL + '  FORMAT(PCG_TOTIPI, 2) AS PCG_TOTIPI, ';
  strSQL := strSQL + '  FORMAT(PCG_TOTGER, 2) AS PCG_TOTGER ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  PCMGER, ';
  strSQL := strSQL + '  CADFOR ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  PCG_NUMCTN = 0 AND ';
  strSQL := strSQL + '  PCG_CODFOR = FOR_CODFOR AND ';
  strSQL := strSQL + '  PCG_ESPDOC = "PD" AND ';
  strSQL := strSQL + '  (PCG_BAIXAD = FALSE OR PCG_BAIXAD IS NULL ) AND ';
  //strSQL := strSQL + '  (PCG_CODEMP = ' + QuotedStr(VS_strCodEmp) + ') ';
  strSQL := strSQL + '  (PCG_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' OR PCG_CODFOR = ' + QuotedStr(fRetCodForFilial) + ') ';

  With frmModuloSPR.qryTemporaria Do
  Begin

    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ExecSQL;
    Close;

  End;

  {*****************************************}
  {* CRIA CAMPO PARA MARCADO / DESMARCADO  *}
  {**************************************MV*}
  strSQL := '';
  strSQL := strSQL + 'ALTER TABLE TMP_PCMGER ';
  strSQL := strSQL + '  ADD PCG_MARDES VARCHAR(01) ';

  With frmModuloSPR.qryTemporaria Do
  Begin

    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ExecSQL;
    Close;

  End;

end;

procedure TfrmEntSelPedidos.pDeletaTemporaria;
  Var
    strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'DROP TABLE TMP_PCMGER ';

  If fTabelaExiste('TMP_PCMGER') Then
  Begin

    With frmModuloSPR.qryTemporaria Do
    Begin

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ExecSQL;
      Close;

    End;

  End;

end;

procedure TfrmEntSelPedidos.FormShow(Sender: TObject);
begin
  inherited;
  pDeletaTemporaria;
  pAtualizaTemporaria;

  pCalculaTotal;

  Screen.Cursor := crDefault;
  intQtdSel     := 0;
  strCodFor     := '';
end;

procedure TfrmEntSelPedidos.dbgPedidosDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;
  With frmModuloSPR.qryTemporaria Do
  Begin
    {*****************************************}
    {* CASO A TABELA ESTEJA FECHADA, SAI     *}
    {**************************************MV*}
    If Not Active Then
      Exit;

    If FieldByName('PCG_MARDES').AsString = 'M' Then
    Begin
      dbgPedidos.Canvas.Font.Color := clBlue;
    End;
    {Else
    Begin
      dbgPedidos.Canvas.Font.Color := clBlack;
    End;}

  End;

  dbgPedidos.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmEntSelPedidos.pMarcaDuplicata(blnMarcar: Boolean);
  Var
    strSQL: String;
begin

  If blnMarcar Then
  Begin
    {************************************************************************}
    {*  NAO É PERMITIDO MARCAR PEDIDOS COM DATA DE BALANÇO >= DATA CORRENTE *}
    {*********************************************************************LA*}
    If Not fTestaDataBalanco(frmModuloSPR.qryTemporaria.FieldByName('PCG_NUMPED').AsString,
                             frmModuloSPR.qryTemporaria.FieldByName('PCG_CODEMP').AsString) Then
    Begin
      fMensagem('', 'Esse pedido contem itens com data de balanço ' + DateToStr(VS_Date) + '. Verifique!', ['&O k']);
      Exit;
    End;

    If (intQtdSel > 0) Then
    Begin
      If (strCodFor <> frmModuloSPR.qryTemporaria.FieldByName('PCG_CODFOR').AsString) Then
      Begin
        fMensagem('', 'Só é possivel selecionar pedidos do mesmo fornecedor!', ['&O k']);
        Exit;
      End;
    End
    Else
    Begin
      strCodFor := frmModuloSPR.qryTemporaria.FieldByName('PCG_CODFOR').AsString;
    End;
    Inc(intQtdSel);
  End
  Else
  Begin
    If (intQtdSel > 0) Then
      Dec(intQtdSel);

    If (intQtdSel <= 0) Then
      strCodFor := ''; 
  End;

  strSQL := '';
  strSQL := strSQL + 'UPDATE ';
  strSQL := strSQL + '  TMP_PCMGER ';
  strSQL := strSQL + 'SET ';
  strSQL := strSQL + '  PCG_MARDES = :MARDES ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  PCG_NUMPED = :NUMPED ';

  With frmModuloSPR.qryGen001 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    If blnMarcar Then
    Begin
      ParamByName('MARDES').AsString := 'M';
    End
    Else
    Begin
      ParamByName('MARDES').AsString := 'D';
    End;

    ParamByName('NUMPED').AsString := frmModuloSPR.qryTemporaria.FieldByName('PCG_NUMPED').AsString;
    ExecSQL;
    Close;
  End;

end;

procedure TfrmEntSelPedidos.pSelecionaDuplicata;
  Var
    intRecNo: Integer;
begin

  intRecNo := frmModuloSPR.qryTemporaria.RecNo;

  If frmModuloSPR.qryTemporaria.FieldByName('PCG_MARDES').AsString <> 'M' Then
  Begin
    pMarcaDuplicata(True);
  End
  Else
  Begin
    pMarcaDuplicata(False);
  End;

  pAtualizaTemporaria;
  pCalculaDadosInformativos;

  frmModuloSPR.qryTemporaria.RecNo := intRecNo;

end;

procedure TfrmEntSelPedidos.pCalculaDadosInformativos;
  Var
    strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  COUNT(*) AS QTD ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  TMP_PCMGER ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  PCG_MARDES = "M" ';

  With frmModuloSPR.qryGen001 Do
  Begin

    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    Open;
    edtPedSel.Text := FieldByName('QTD').AsString;
    Close;

  End;

end;

procedure TfrmEntSelPedidos.dbgPedidosDblClick(Sender: TObject);
begin
  inherited;
  pSelecionaDuplicata;
end;

procedure TfrmEntSelPedidos.dbgPedidosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  If (Key = VK_Return) Then
  Begin
    pSelecionaDuplicata;
  End
  Else If (Key = VK_Escape) Then
  Begin
    btnSairSelecao.Click;
  End
  Else If (Key = VK_F10) Then
  Begin
    btnConfirma.Click;
    Key := 0;
  End;

end;

procedure TfrmEntSelPedidos.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
  frmModuloSPR.qryTemporaria.Close;
end;

procedure TfrmEntSelPedidos.btnSairSelecaoClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmEntSelPedidos.btnConfirmaClick(Sender: TObject);
  Var
    strSQL: String;
    intContador: Integer;
begin

  intContador := 0;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  PCG_NUMPED, ';
  strSQL := strSQL + '  PCG_CODEMP ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  TMP_PCMGER ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  PCG_MARDES = "M" ';

  With frmModuloSPR.qryGen001 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    Open;

    If Not IsEmpty Then
    Begin

      SetLength(arrPedidos, RecordCount);
      SetLength(arrEmpresas, RecordCount);

      While Not Eof Do
      Begin

        arrPedidos[intContador]  := FieldByName('PCG_NUMPED').AsString;
        arrEmpresas[intContador] := FieldByName('PCG_CODEMP').AsString;
        Inc(intContador);
        Next;

      End;

      Close;
      Self.Close;
      blnConfirma := True;

    End
    Else
    Begin
      fMensagem('', 'É necessário escolher pelo menos um pedido!', ['&O k']);
      dbgPedidos.SetFocus;
    End;
    
  End;

end;

procedure TfrmEntSelPedidos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  pDeletaTemporaria;
end;

procedure TfrmEntSelPedidos.FormActivate(Sender: TObject);
begin
  inherited;
  If frmModuloSPR.qryTemporaria.IsEmpty Then
  Begin

    Hide;
    fMensagem('', 'Não há pedidos em aberto!', ['&O k']);
    Close;

  End;
end;

procedure TfrmEntSelPedidos.pCalculaTotal;
  Var
    strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  SUM(PCG_TOTITE) AS TOTITE, ';
  strSQL := strSQL + '  SUM(PCG_TOTIPI) AS TOTIPI, ';
  strSQL := strSQL + '  SUM(PCG_TOTSUB) AS TOTSUB, ';
  strSQL := strSQL + '  SUM(PCG_TOTGER) AS TOTGER ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  TMP_PCMGER ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  PCG_MARDES = "M" ';

  With frmModuloSPR.qryGen001 Do
  Begin

    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    Open;

    edtTotIte.Text := FormatFloat('#,##0.00', FieldByName('TOTITE').AsFloat);
    edtTotIpi.Text := FormatFloat('#,##0.00', FieldByName('TOTIPI').AsFloat);
    edtTotSub.Text := FormatFloat('#,##0.00', FieldByName('TOTSUB').AsFloat);
    edtTotGer.Text := FormatFloat('#,##0.00', FieldByName('TOTGER').AsFloat);

    Close;

  End;

end;

{*****************************************************************}
{* ESSA FUNCAO RETORNA TRUE SE HOUVER ALGUM ITEM NO PEDIDO COM   *}
{* DATA MAIOR OU IGUAL A DATA CORRENTE; FALSE CASO CONTRARIO     *)
***************************************************************LA*}
function TfrmEntSelPedidos.fTestaDataBalanco(strNumPed, strNumEmp: String): Boolean;
 Var
   qryQuery : TUniQuery;
   strSQL : String;
Begin
  strSQL := '';
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  COUNT(*) ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  PCMDET, CADITE, ITEGER ';
  strSQL := strSQL + 'WHERE ';

  strSQL := strSQL + '  PCD_CODITE        = CADITE.ITE_CODITE AND ';

  strSQL := strSQL + '  CADITE.ITE_CODITE = ITEGER.ITE_CODITE AND ';
  strSQL := strSQL + '  CADITE.ITE_CODEMP = ITEGER.ITE_CODEMP AND ';

  strSQL := strSQL + '  ITEGER.ITE_DTABAL >= :DTHOJE  AND';

  strSQL := strSQL + '  PCD_NUMPED = :NUMPED AND    ';
  strSQL := strSQL + '  PCD_CODEMP = :CODEMP AND    ';
  strSQL := strSQL + '  PCD_ESPDOC = ''PD''         ';

  qryQuery := fCriaQuery;
  With qryQuery  Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('NUMPED').AsString   := strNumPed;
    ParamByName('CODEMP').AsString   := strNumEmp;
    ParamByName('DTHOJE').AsDate     := VS_Date;

    Open;
    Result := qryQuery.fields[0].asinteger = 0;
    Close;
  End;
  FreeAndNil(qryQuery);
End;

end.

