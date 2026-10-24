unit untConsExtBanPen;

interface

uses
  Winapi.Windows, Winapi.Messages, SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, cxTextEdit, Uni, UniClientDataSet, untExtratoBaseClass,
  cxCheckBox, cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmConsExtBanPen = class(TfrmPai)
    grdLanPendDBTableView1: TcxGridDBTableView;
    grdLanPendLevel1: TcxGridLevel;
    grdLanPend: TcxGrid;
    grdLanPendDBTableView1Column1: TcxGridDBColumn;
    grdLanPendDBTableView1Column2: TcxGridDBColumn;
    grdLanPendDBTableView1Column4: TcxGridDBColumn;
    grdLanPendDBTableView1Column5: TcxGridDBColumn;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    dsLancamentos: TDataSource;
    cxStyle2: TcxStyle;
    cxStyleRepository2: TcxStyleRepository;
    cxStyle3: TcxStyle;
    grdLanPendDBTableView1Column3: TcxGridDBColumn;
    btnConfirma: TBitBtnLocked;
    btnMarcaDesmarca: TBitBtnLocked;
    btnMarcaTodos: TBitBtnLocked;
    btnDesmarcaTodos: TBitBtnLocked;
    grdLanPendDBTableView1Column6: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ApplicationEventsMessage(var Msg: tagMSG; var Handled: Boolean);
    procedure grdLanPendDBTableView1CustomDrawCell
      (Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnMarcaDesmarcaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnMarcaTodosClick(Sender: TObject);
    procedure btnDesmarcaTodosClick(Sender: TObject);
    procedure grdLanPendDBTableView1Column3PropertiesChange(Sender: TObject);
    procedure grdLanPendDBTableView1Editing(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; var AAllow: Boolean);
  private
    { Private declarations }

    blnCarregaBanco: Boolean;
    blnCarregaPortador: Boolean;
    strCodBcoLoc: String;
    strCodPorLoc: String;
    strArquivo: String;
    strCodPorMarcado: String;
    blnRetornaArqLoc, blnIgnoradosLoc: Boolean;
    FExtratoBancario: TExtratoBancario;

    qryLancamentos: TUniQuery;
    function fGetSql: String;
  public
    { Public declarations }
    class function fMostraCarregandoBanco(strCodBco: String = '';
      strCodPor: String = ''; blnRetornaArq: Boolean = False;
      blnIgnorados: Boolean = False): TExtratoBancario;
  end;

var
  frmConsExtBanPen: TfrmConsExtBanPen;

implementation

{$R *.dfm}

uses untFuncoesSimples;

procedure TfrmConsExtBanPen.ApplicationEventsMessage(var Msg: tagMSG;
  var Handled: Boolean);
begin
  inherited;
  case Msg.Message of
    WM_KEYDOWN:
      begin
        if (Msg.wParam = VK_ESCAPE) then
        begin
          Msg.wParam := 0;
          Close;
        end;
      end;
  end;
end;

procedure TfrmConsExtBanPen.btnConfirmaClick(Sender: TObject);
var
  intRecNo: Integer;
  strDatas: String;
begin
  inherited;
  if blnRetornaArqLoc Then
  begin
    qryLancamentos.DisableControls;
    intRecNo := qryLancamentos.RecNo;

    qryLancamentos.Filter := 'EXT_MARCADO = ' + QuotedStr('S');
    qryLancamentos.Filtered := True;

    If Not qryLancamentos.IsEmpty Then
    Begin

      qryLancamentos.First;
      While Not qryLancamentos.Eof Do
      Begin
        If qryLancamentos.FieldByName('EXT_MARCADO').AsString = 'S' Then
        Begin
          If Pos(qryLancamentos.FieldByName('EXT_DTALAN').AsString,
            strDatas) <= 0 Then
          Begin
            If Not fEmptyStr(strDatas) Then
              strDatas := strDatas + '_' + FormatDateTime('yyyymmdd',
                qryLancamentos.FieldByName('EXT_DTALAN').AsDateTime)
            Else
              strDatas := FormatDateTime('yyyymmdd',
                qryLancamentos.FieldByName('EXT_DTALAN').AsDateTime);
          End;
        End;

        qryLancamentos.Next;
      End;

      FExtratoBancario := TExtratoBancario.Create;
      FExtratoBancario.Arquivo := '';
      FExtratoBancario.Periodo := fRetStrToSQLIn(strDatas);
      FExtratoBancario.CodBco := qryLancamentos.FieldByName
        ('EXT_CODBCO').AsString;
      FExtratoBancario.CodPor := qryLancamentos.FieldByName
        ('EXT_CODPOR').AsString;
    End;

    qryLancamentos.Filtered := False;
    qryLancamentos.Filter := '';
    qryLancamentos.RecNo := intRecNo;
    qryLancamentos.EnableControls;

    Close;
  end;

end;

procedure TfrmConsExtBanPen.btnDesmarcaTodosClick(Sender: TObject);
var
  intRecNo_: Integer;
begin
  inherited;
  If Not fEmptyStr(strCodPorMarcado) Then
  Begin
    qryLancamentos.DisableControls;
    intRecNo_ := qryLancamentos.RecNo;
    qryLancamentos.Filter   := ' EXT_CODPOR = ' + QuotedStr(strCodPorMarcado) ;
    qryLancamentos.Filtered := True;

    If Not QryLancamentos.IsEmpty Then
    Begin
      QryLancamentos.First;
      While Not QryLancamentos.Eof Do
      Begin
        QryLancamentos.Edit;
        QryLancamentos.FieldByName('EXT_MARCADO').AsString := 'N';
        QryLancamentos.Post;

        QryLancamentos.Next;
      End;
    End;

    strCodPorMarcado := '';
    btnMarcaTodos.Enabled := False;
    btnDesmarcaTodos.Enabled := False;

    QryLancamentos.Filtered := False;
    QryLancamentos.Filter   := '';
    QryLancamentos.RecNo    := IntRecNo_;
    QryLancamentos.EnableControls;
  End;

end;

procedure TfrmConsExtBanPen.btnMarcaDesmarcaClick(Sender: TObject);
var
  strMarCad: String;
  intRecNo_: Integer;
  intFocusI: Integer;
  blnMarDes: Boolean;
  blnEncont: Boolean;
begin
  inherited;
  blnMarDes := True;
  If Not qryLancamentos.IsEmpty Then
  Begin
    If Not fEmpresaTemAcessoPortador(qryLancamentos.FieldByName('EXT_CODPOR').AsString, '') Then
    Begin
      fMensagem('ATENÇÃO!','Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".' , ['&Ok']);
      Exit;
    End;


    Application.ProcessMessages;
    intFocusI :=  grdLanPendDBTableView1.DataController.FocusedRowIndex;

    If qryLancamentos.FieldByName('EXT_MARCADO').AsString = 'S' Then
      strMarCad := 'N'
    Else
      strMarCad := 'S';

    intRecNo_ := qryLancamentos.RecNo;

    qryLancamentos.DisableControls;
    qryLancamentos.Filter := ' EXT_MARCADO = ' + QuotedStr('S');
    qryLancamentos.Filtered := True;

    blnEncont := qryLancamentos.RecordCount > 0;
    qryLancamentos.Filtered := False;
    qryLancamentos.Filter   := '';
    qryLancamentos.RecNo    := intRecNo_;

    If (strMarCad = 'S') Then
    Begin
      If  (not blnEncont) Then
      Begin
        If fEmptyStr(strCodPorMarcado) Then
        Begin
          strCodPorMarcado := qryLancamentos.FieldByName('EXT_CODPOR').AsString;
          btnMarcaTodos.Enabled    := True;
          btnDesmarcaTodos.Enabled := True;
        End
      End
      Else
      Begin
        If qryLancamentos.FieldByName('EXT_CODPOR').AsString <> strCodPorMarcado Then
        Begin
          fMensagem('Aviso', 'Não é possível marcar registros de portadores diferentes!', ['&O k']);
          blnMarDes := False;
        End;
      End;
    End;
    If blnMarDes Then
    Begin
      qryLancamentos.Edit;
      qryLancamentos.FieldByName('EXT_MARCADO').AsString := strMarCad ;
      qryLancamentos.Post;

      If strMarCad = 'N' then
      Begin
        intRecNo_               := qryLancamentos.RecNo;
        qryLancamentos.Filter   := ' EXT_MARCADO = ' + QuotedStr('S');
        qryLancamentos.Filtered := True;

        If ((qryLancamentos.RecordCount = 0) And (not fEmptyStr(strCodPorMarcado))) Then
        Begin
          strCodPorMarcado         := '';
          btnMarcaTodos.Enabled    := False;
          btnDesmarcaTodos.Enabled := False;
        End;
        qryLancamentos.Filtered := False;
        qryLancamentos.Filter   := '';
        qryLancamentos.RecNo    := intRecNo_;
      End;
    End;
    grdLanPendDBTableView1.DataController.FocusedRowIndex :=  intFocusI;
    qryLancamentos.EnableControls;
  End;
end;

procedure TfrmConsExtBanPen.btnMarcaTodosClick(Sender: TObject);
var
  intRecNo_: Integer;
begin
  If Not fEmptyStr(strCodPorMarcado) Then
  Begin
    qryLancamentos.DisableControls;
    intRecNo_ := qryLancamentos.RecNo;
    qryLancamentos.Filter   := ' EXT_CODPOR = ' + QuotedStr(strCodPorMarcado) ;
    qryLancamentos.Filtered := True;

    If Not QryLancamentos.IsEmpty Then
    Begin
      QryLancamentos.First;
      While Not QryLancamentos.Eof Do
      Begin
        If fEmpresaTemAcessoPortador(qryLancamentos.FieldByName('EXT_CODPOR').AsString, '') Then
        begin
          QryLancamentos.Edit;
          QryLancamentos.FieldByName('EXT_MARCADO').AsString := 'S';
          QryLancamentos.Post;
        end;

        QryLancamentos.Next;
      End;
    End;

    QryLancamentos.Filtered := False;
    QryLancamentos.Filter   := '';
    QryLancamentos.RecNo    := IntRecNo_;
    QryLancamentos.EnableControls;
  End;
end;

procedure TfrmConsExtBanPen.btnSairClick(Sender: TObject);
begin
  inherited;
  Close;
end;

function TfrmConsExtBanPen.fGetSql: String;
Var
  FExtBelEmpLogada: Boolean;
  FSql: String;
begin
  FExtBelEmpLogada := (fCfgSis('EXTBEL') = 'EL'); //Empresa logada

  FSql := '';
  FSql := FSql + ' SELECT DISTINCT EXT_ARQIMP,   ';
  FSql := FSql + '   CONCAT(EXT_CODPOR, " - ", CADPOR.POR_NOMPOR) AS PORTADOR, ';
  FSql := FSql + '   EXT_DTALAN, ';
  FSql := FSql + '   CONCAT(COUNT(EXT_CODBCO), " Lançamento(s)") AS QTDREG, ';
  FSql := FSql + '   "N" AS EXT_MARCADO, ';
  FSql := FSql + '   EXTBAN.* ';
  FSql := FSql + ' FROM ';
  FSql := FSql + '   EXTBAN ';
  FSql := FSql + ' LEFT JOIN CADPOR ON POR_CODPOR = EXT_CODPOR ';

  If FExtBelEmpLogada Then
    FSql := FSql + ' JOIN CADCCA C ON C.AUTOINCREM = CADPOR.POR_CCAAUT     ';

  FSql := FSql + ' WHERE ';
  FSql := FSql + '   EXT_DTACON IS NULL ';

  If Not blnIgnoradosLoc Then
    FSql := FSql + ' AND EXT_SITUAC <> "I"  '
  Else
    FSql := FSql + ' AND EXT_SITUAC = "I"   ';

  If blnCarregaBanco Then
    FSql := FSql + ' AND EXT_CODBCO = ' + strCodBcoLoc;

  If blnCArregaPortador Then
    FSql := FSql + ' AND EXT_CODPOR = ' + strCodPorLoc;

  If FExtBelEmpLogada Then
    FSql := FSql + '  AND C.CCA_CODEMP = ' + QuotedStr(VS_strCodEmp);


  FSql := FSql + ' GROUP BY ';
  FSql := FSql + '   EXT_CODPOR, EXT_CODBCO, EXT_DTALAN   ';

  Result := FSql;
end;

class function TfrmConsExtBanPen.fMostraCarregandoBanco(strCodBco: String;
  strCodPor: String; blnRetornaArq: Boolean; blnIgnorados: Boolean): TExtratoBancario;
begin
  frmConsExtBanPen := TfrmConsExtBanPen.Create(nil);

  with frmConsExtBanPen do
  begin
    blnRetornaArqLoc := blnRetornaArq;
    strCodBcoLoc := strCodBco;
    strCodPorLoc := strCodPor;

    if strCodBcoLoc <> '' then
      blnCarregaBanco := True;

    if strCodPorLoc <> '' then
      blnCarregaPortador := True;

    if blnIgnorados then
    begin
      blnIgnoradosLoc := True;
      Caption := 'Consulta Lançamentos Extrato Eletrônico Ignorados';
    end;

    ShowModal;

    if blnRetornaArqLoc Then
      Result := FExtratoBancario
    else
      Result := nil;
  end;

  FreeAndNil(frmConsExtBanPen);
end;

procedure TfrmConsExtBanPen.FormCreate(Sender: TObject);
begin
  inherited;
  qryLancamentos := fCriaQuery;
  qryLancamentos.CachedUpdates := True;
  qryLancamentos.Options.SetFieldsReadOnly := False;
  dsLancamentos.DataSet := qryLancamentos;
  strCodBcoLoc := '';
  strCodPorLoc := '';
  strArquivo := '';
  blnCarregaBanco := False;
  blnCarregaPortador := False;
  blnIgnoradosLoc := False;
end;

procedure TfrmConsExtBanPen.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If Key = VK_SPACE Then
    btnMarcaDesmarca.Click
  Else If Key = vk_F7 Then
    btnMarcaTodos.Click
  Else If Key = vk_F8 Then
    btnDesmarcaTodos.Click
  Else If Key = vk_F10 Then
    btnConfirma.Click;
end;

procedure TfrmConsExtBanPen.FormShow(Sender: TObject);
begin
  inherited;
  with qryLancamentos do
  begin
    Close;
    Sql.Clear;
    Sql.Text := fGetSql;
    Open;

    if IsEmpty then
      pSetFocus(btnSair)
    else
      pSetFocus(grdLanPend);

    strCodPorMarcado := '';

    grdLanPendDBTableView1.DataController.Groups.FullExpand;
  end;
end;

procedure TfrmConsExtBanPen.grdLanPendDBTableView1Column3PropertiesChange(
  Sender: TObject);
var
  intRecNo_ : Integer;
begin
  inherited;
  intRecNo_ := grdLanPendDBTableView1.DataController.FocusedRowIndex;
  btnMarcaDesmarca.Click;
  grdLanPendDBTableView1.DataController.FocusedRowIndex :=   intRecNo_;
  SysUtils.Abort;
end;

procedure TfrmConsExtBanPen.grdLanPendDBTableView1CustomDrawCell
  (Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
Var
 temAcesso:Boolean;
 extCodPor:String;
begin
  inherited;

  if not AViewInfo.Selected then
  Begin
    extCodPor:=VarAsType(grdLanPendDBTableView1.ViewData.Records[AViewInfo.GridRecord.Index].Values[ grdLanPendDBTableView1Column6.Index], varString);
    temAcesso:= fEmpresaTemAcessoPortador(extCodPor, '');

    if not temAcesso then
    Begin
      ACanvas.Font.Color  := clGray;
    End else
    Begin

    End;
  End;

  if AViewInfo.GridRecord.Selected then
  Begin
    ACanvas.Brush.Color := clNavy;
    ACanvas.Font.Color  := clWhite;
  End;

end;

procedure TfrmConsExtBanPen.grdLanPendDBTableView1Editing(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  var AAllow: Boolean);
begin
  inherited;

  If Not fEmpresaTemAcessoPortador(qryLancamentos.FieldByName('EXT_CODPOR').AsString, '') Then
    AAllow := False
  Else
    AAllow := True;

  if not AAllow Then
    fMensagem('ATENÇÃO!','Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".' , ['&Ok']);
end;

end.

