unit untFatExpServicosConferencia;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, BitBtnLockedIncrem, ExtCtrls, Grids, DBGridCitel, DBGrids, EditFocus,
  UniClientDataSet, DB, Uni, StrUtils, Datasnap.DBClient, frxClass, frxExportCSVTestabilidade;

type
  TfrmFatExpServicosConferencia = class(TfrmPai)
    lblFundo: TPanel;
    btnConfirma: TBitBtnLocked;
    gpbConf: TGroupBox;
    dbgPedidos: TDBGridCitel;
    Label3: TLabel;
    edtCodIte: TEditFocus;
    edtQtdIte: TEditFocus;
    Label1: TLabel;
    cdsItens: TUniClientDataSet;
    cdsItensCODITE: TStringField;
    cdsItensCODBAR: TStringField;    
    cdsItensBAREMB: TStringField;
    cdsItensDESITE: TStringField;
    cdsItensSIGUNI: TStringField;
    cdsItensQTDITE: TFloatField;
    cdsItensQTDCON: TFloatField;
    cdsItensENTSAI: TStringField;
    dtsItens: TDataSource;
    lblLegBlue: TPanel;
    Panel1: TPanel;
    Panel2: TPanel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    cdsItensNUMDOC: TStringField;
    cdsItensCODEMP: TStringField;
    cdsItensSEQINC: TIntegerField;
    cdsItensCODCLI: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure dbgPedidosDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
  private
    function fConferiuTudo: Boolean;
    function fExpedirProduto(Var strMsg: String): Boolean;
  public
    procedure pSetaPedidos(strCodEmp: String; stlPedidos: TStringList);
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmFatExpServicosConferencia: TfrmFatExpServicosConferencia;

implementation

uses untFuncoesSimples;

{$R *.dfm}

procedure TfrmFatExpServicosConferencia.btnConfirmaClick(Sender: TObject);
begin
  cdsItens.First;
  While Not cdsItens.Eof Do
  Begin
    If cdsItensQTDCON.AsFloat < cdsItensQTDITE.AsFloat Then
    Begin
      fMensagem('', 'Existem itens não conferidos, favor efetuar conferência completa!', ['&O k']);
      pSetFocus(edtCodIte);
      Exit;
    End;
    cdsItens.Next;
  End;
  ModalResult := mrOK;
end;

procedure TfrmFatExpServicosConferencia.dbgPedidosDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
  procedure pBColor(cl: TColor; clF: TColor = clNone);
  begin
    dbgPedidos.Canvas.Brush.Color := cl;

    If clF <> clNone Then
      dbgPedidos.Canvas.Font.Color := clF;
  end;
begin
  If cdsItensENTSAI.AsString = 'E' Then
    pBColor(clGreen, clWhite)
  Else
    pBColor(clYellow, clBlack);

  If cdsItensQTDITE.AsFloat = cdsItensQTDCON.AsFloat Then
    pBColor(clBlue, clWhite);

  dbgPedidos.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

function TfrmFatExpServicosConferencia.fConferiuTudo: Boolean;
  Var
    intRecNo: Integer;
begin
  Result := False;

  intRecNo := cdsItens.RecNo;
  Try
    cdsItens.First;
    While Not cdsItens.Eof Do
    Begin
      If cdsItensQTDCON.AsFloat < cdsItensQTDITE.AsFloat Then
        Exit;
        
      cdsItens.Next;
    End;

    Result := True;
  Finally
    cdsItens.RecNo := intRecNo;
  End;
end;

procedure TfrmFatExpServicosConferencia.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodIte);
end;

procedure TfrmFatExpServicosConferencia.FormCreate(Sender: TObject);
begin
  inherited;
  pSetaCodIte( cdsItensCODITE );
  cdsItens.CreateDataSet;
end;

procedure TfrmFatExpServicosConferencia.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_F10 Then
  Begin
    btnConfirma.Click;
  End;
end;

function TfrmFatExpServicosConferencia.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
  Var
    strMsg: String;
    blnBarExp: Boolean;
    intTamCodIte: Integer;
begin
  Result := True;

  If (Sender = edtCodIte) Then
  Begin
    If fEmptyStr(edtCodIte.Text) Then
      strMsg := 'Produto precisa ser preenchido!'
    Else
    Begin
      intTamCodIte := fTamCodIte;
      If (Length(edtCodIte.Text) <= intTamCodIte) Then
        edtCodIte.Text := fStrZero(edtCodIte.Text, intTamCodIte);

      If (cdsItens.Locate('CODITE', edtCodIte.Text, [])) Or
         (cdsItens.Locate('CODBAR', edtCodIte.Text, [])) Or
         (cdsItens.Locate('BAREMB', edtCodIte.Text, [])) Then
      Begin
        If (Length(edtCodIte.Text) <= intTamCodIte) Then
        Begin
          blnBarExp := (fCampoTabela('ITE_BAREXP', 'CADITE', ['ITE_CODITE'], [edtCodIte.Text]) = 'S') and fCfgSis('BAREXP', varBoolean);

          If (blnBarExp) Then
          Begin
            strMsg := 'Para expedir este produto é necessário informar o código de barras!';
            edtCodIte.Clear;
          End;
        End;
      End
      Else
        strMsg := 'Produto digitado não encontra-se na lista de produtos para conferência!';
    End;
  End

  Else If (Sender = edtQtdIte) Then
  Begin
    If fEmptyStr(edtQtdIte.Text) Then
      strMsg := 'Quantidade precisa ser preenchida!'
    Else
    Begin
      If fValidaCampos(edtCodIte) And fExpedirProduto(strMsg) Then
      Begin
        edtCodIte.Clear;
        edtQtdIte.Clear;
        blnMudarFoco := False;
        pSetFocus(edtCodIte);

        If fConferiuTudo Then
          btnConfirma.Click;
      End;
    End;
  End;

  If Not fEmptyStr(strMsg) Then
  Begin
    Result := False;
    fMensagem('', strMsg, ['&Ok']);
  End;
end;

function TfrmFatExpServicosConferencia.fExpedirProduto(Var strMsg: String): Boolean;
  Var
    fltQtdIte: Double;
    fltQtdRes: Double;

  function fFiltrarProduto(strCampo, strCodigo: String): Boolean;
  begin
    cdsItens.Filtered := False;
    cdsItens.Filter   := strCampo + ' = ' + QuotedStr(strCodigo);
    cdsItens.Filtered := True;
    Result := Not cdsItens.IsEmpty;
  end;

begin
  Try
    cdsItens.DisableControls;

    If Not fFiltrarProduto('CODITE', edtCodIte.Text) Then
    If Not fFiltrarProduto('CODBAR', edtCodIte.Text) Then
           fFiltrarProduto('BAREMB', edtCodIte.Text);

    fltQtdRes := 0.00;
    fltQtdIte := fStrToFloat(edtQtdIte.Text);

    cdsItens.First;
    While Not cdsItens.Eof Do
    Begin
      fltQtdRes := fltQtdRes + (cdsItensQTDITE.AsFloat - cdsItensQTDCON.AsFloat);
      cdsItens.Next;
    End;

    If fltQtdIte > fltQtdRes Then
    Begin
      strMsg := 'Quantidade digitada é maior que a quantidade a expedir!';
      Result := False;
    End
    Else
    Begin
      cdsItens.First;
      While Not cdsItens.Eof Do
      Begin
        cdsItens.Edit;
        fltQtdRes := (cdsItensQTDITE.AsFloat - cdsItensQTDCON.AsFloat);

        If fltQtdRes >= fltQtdIte Then
        Begin
          cdsItensQTDCON.AsFloat := cdsItensQTDCON.AsFloat + fltQtdIte;
          fltQtdIte := 0.00;
        End
        Else
        Begin
          cdsItensQTDCON.AsFloat := cdsItensQTDCON.AsFloat + fltQtdRes;
          fltQtdIte := fltQtdIte - fltQtdRes;
        End;

        cdsItens.Post;

        If fFormataFloat(fltQtdIte, 2) = 0.00 Then
          Break;

        cdsItens.Next;
      End;
      Result := True;
    End;
  Finally
    cdsItens.Filter   := '';
    cdsItens.Filtered := False;
    cdsItens.EnableControls;
  End;
end;

procedure TfrmFatExpServicosConferencia.pSetaPedidos(strCodEmp: String; stlPedidos: TStringList);
  Var
    intIndex: Integer;
    strParams: String;
    field: TField;
    qryItens: TUniQuery;
    strEntSai: String;
begin
  qryItens := fCriaQuery;
  Try
    qryItens.SQL.Add('SELECT CODEMP,');
    qryItens.SQL.Add('       CODCLI,');
    qryItens.SQL.Add('       NUMDOC,');
    qryItens.SQL.Add('       SEQINC,');
    qryItens.SQL.Add('       CODITE,');
    qryItens.SQL.Add('       ITE_CODBAR AS CODBAR,');    
    qryItens.SQL.Add('       ITE_BAREMB AS BAREMB,');
    qryItens.SQL.Add('       CONCAT(CODITE, "-", ITE_DESITE) AS DESITE,');
    qryItens.SQL.Add('       UNI_SIGUNI AS SIGUNI,');
    qryItens.SQL.Add('       ABS(QTDITE) AS QTDITE,');
    qryItens.SQL.Add('       0 AS QTDCON,');
    qryItens.SQL.Add('       IF(QTDITE < 0, "E", "S") AS ENTSAI');
    qryItens.SQL.Add('  FROM (SELECT FDO_CODEMP AS CODEMP,');
    qryItens.SQL.Add('               FDO_NUMDOC AS NUMDOC,');
    qryItens.SQL.Add('               FDO_CODCLI AS CODCLI,');
    qryItens.SQL.Add('               FDO_SEQINC AS SEQINC,');
    qryItens.SQL.Add('               FDO_CODITE AS CODITE,');
    qryItens.SQL.Add('               SUM(FDO_QTDITE * IF(FDO_ENTSAI = "S", 1, -1)) AS QTDITE');
    qryItens.SQL.Add('          FROM FDOSEP');
    qryItens.SQL.Add('         WHERE FDO_PENDEN = 1');
    qryItens.SQL.Add('           AND FDO_CODEMP = :CODEMP');
    qryItens.SQL.Add('           AND FDO_NUMDOC IN ($NUMDOC$)');
    qryItens.SQL.Add('         GROUP BY FDO_NUMDOC,');
    qryItens.SQL.Add('               FDO_CODITE,');
    qryItens.SQL.Add('               FDO_SEQINC) TAB');
    qryItens.SQL.Add('  JOIN CADITE ON ITE_CODITE = CODITE');
    qryItens.SQL.Add('  JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI');
    qryItens.SQL.Add(' WHERE QTDITE <> 0');

    strParams := '';
    For intIndex := 0 To stlPedidos.Count - 1 Do
      strParams := strParams + IIF(intIndex = 0, '', ', ') + ':NUMDOC_' + IntToStr(intIndex);

    qryItens.SQL.Text := AnsiReplaceStr(qryItens.SQL.Text , '$NUMDOC$', strParams);

    For intIndex := 0 To stlPedidos.Count - 1 Do
      qryItens.ParamByName('NUMDOC_' + IntToStr(intIndex)).AsString := stlPedidos[intIndex];

    qryItens.ParamByName('CODEMP').AsString := VS_strCodEmp;

    qryItens.Open;

    strEntSai := qryItens.FieldByName('ENTSAI').AsString;

    If qryItens.Locate('ENTSAI', 'S', []) And qryItens.Locate('ENTSAI', 'E', []) Then
    Begin
      Case fGetMenu('Selecione o tipo de conferência:',
                   ['ENTRADAS NO ALMOXARIFADO',
                    'SAÍDAS DO ALMOXARIFADO'], 1) Of
        1: strEntSai := 'E';
        2: strEntSai := 'S';
      End;
    End;

    qryItens.First;
    While Not qryItens.Eof Do
    Begin
      If qryItens.FieldByName('ENTSAI').AsString = strEntSai Then
      Begin
        cdsItens.Append;
        For field In qryItens.Fields Do
          cdsItens.FieldByName(field.FieldName).AsVariant := field.AsVariant;
        cdsItens.Post;
      End;
      qryItens.Next;
    End;
  Finally
    qryItens.Free;
  End;
end;

end.
