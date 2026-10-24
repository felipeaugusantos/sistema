unit untRelacionaHist;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxClasses,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxGridCustomView, cxGrid, Uni, cxButtons, System.ImageList, Vcl.ImgList,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxImageList;

type
  TfrmRelacionaHist = class(TfrmPai)
    grdHistoricoDBTableView1: TcxGridDBTableView;
    grdHistoricoLevel1: TcxGridLevel;
    grdHistorico: TcxGrid;
    grdHistoricoDBTableView1Column1: TcxGridDBColumn;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    dsHistExt: TDataSource;
    cxStyle2: TcxStyle;
    grdHistoricoDBTableView1Column2: TcxGridDBColumn;
    chkRelacionados: TCheckBox;
    cxButton5: TcxButton;
    imglDiversas16: TcxImageList;
    btnExcluirRel: TcxButton;
    Label1: TLabel;
    edtProcura: TEdit;
    procedure grdHistoricoDBTableView1CellDblClick(
      Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure FormShow(Sender: TObject);
    procedure grdHistoricoDBTableView1CustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure chkRelacionadosClick(Sender: TObject);
    procedure cxButton5Click(Sender: TObject);
    procedure btnExcluirRelClick(Sender: TObject);
    procedure ApplicationEventsMessage(var Msg: tagMSG; var Handled: Boolean);
    procedure edtProcuraKeyPress(Sender: TObject; var Key: Char);
    procedure grdHistoricoDBTableView1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    qryMovExt: TUniQuery;
    procedure pVinculaHistorico(strHistMovBan: String);
  public
    { Public declarations }
    strCodPor: String;
    procedure pAbrirQuery;
  end;

var
  frmRelacionaHist: TfrmRelacionaHist;

implementation

{$R *.dfm}

uses untHistMovBan, untFuncoesSimples;

procedure TfrmRelacionaHist.pAbrirQuery;
var
  strSql: String;
begin
  with qryMovExt do
  begin
    Sql.Clear;
    strSql := 'SELECT DISTINCT EX.EXT_HISTOR, IF(E.EXT_CODPOR IS NOT NULL, E.EXT_CODPOR, "") AS EXT_CODPOR FROM EXTBAN EX LEFT JOIN EXTHIS E ON E.EXT_HISTOR = EX.EXT_HISTOR WHERE EX.EXT_HISTOR <> "" AND EX.EXT_CODPOR = :CODPOR ';
    if chkRelacionados.Checked then
      strSql := strSql + ' AND E.EXT_CODPOR IS NOT NULL ';

    strSql := strSql  + ' ORDER BY EX.EXT_HISTOR ASC ';

    Sql.Text :=  strSql;
    ParamByName('CODPOR').AsString := strCodPor;
    Open;
  end;
end;

procedure TfrmRelacionaHist.pVinculaHistorico(strHistMovBan: String);
var
  qrySql: TUniQuery;
begin
  qrySql := fCriaQuery;

  with qrySql do
  begin
    Sql.Clear;
    Sql.Text := 'SELECT * FROM EXTHIS WHERE EXT_CODPOR = :CODPOR AND EXT_BANHIS = :BANHIS';
    ParamByName('CODPOR').AsString :=  strCodPor;
    ParamByName('BANHIS').AsString :=  strHistMovBan;

    Open;

    if not IsEmpty then
    begin
      pMensagemOk('O Histórico da movimentação bancária selecionado, já foi relacionado com o seguinte histórico do extrato: ' + #13#13 + FieldByName('EXT_HISTOR').AsString);
      Exit;
    end
    else
    begin
      Close;
      Sql.Clear;
      Sql.Text := 'INSERT INTO EXTHIS SET EXT_CODPOR = :CODPOR, EXT_HISTOR = :HISTOR, EXT_BANHIS = :BANHIS';
      ParamByName('CODPOR').AsString :=  strCodPor;
      ParamByName('HISTOR').AsString :=  qryMovExt.FieldByName('EXT_HISTOR').AsString;
      ParamByName('BANHIS').AsString :=  strHistMovBan;

      ExecSql;
      Close;
    end;
  end;
  FreeAndNil(qrySql);

  qryMovExt.Refresh;
  pMensagemOk('Histórico relacionado com sucesso!');
end;

procedure TfrmRelacionaHist.ApplicationEventsMessage(var Msg: tagMSG;
  var Handled: Boolean);
begin
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

procedure TfrmRelacionaHist.btnExcluirRelClick(Sender: TObject);
var
  qryExcluirRel: TUniQuery;
begin
  inherited;
  if not qryMovExt.isEmpty then
  begin
    if qryMovExt.FieldByName('EXT_CODPOR').AsString <> '' then
    begin
      if fMensagem('Aviso', 'Confirma exclusão do relacionamento do histórico selecionado?', ['&S i m', '&N ã o']) = 1 then
      begin
        qryExcluirRel := fCriaQuery;
        with qryExcluirRel do
        begin
          Sql.Clear;
          Sql.Text := ' DELETE FROM EXTHIS WHERE EXT_CODPOR = :CODPOR AND EXT_HISTOR = :HISTOR ';
          ParamByName('CODPOR').AsString := qryMovExt.FieldByName('EXT_CODPOR').AsString;
          ParamByName('HISTOR').AsString := qryMovExt.FieldByName('EXT_HISTOR').AsString;

          ExecSql;

          qryMovExt.Refresh;
          pMensagemOk('Relacionamento de histórico excluído com sucesso!');
        end;
        FreeAndNil(qryExcluirRel);
      end;
    end
    else
      pMensagemOk('Histórico não foi relacionado!');
  end;
end;

procedure TfrmRelacionaHist.chkRelacionadosClick(Sender: TObject);
begin
  inherited;
  pAbrirQuery;
end;

procedure TfrmRelacionaHist.cxButton5Click(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmRelacionaHist.edtProcuraKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if edtProcura.Text <> '' then
  begin
    qryMovExt.Filtered := False;
    qryMovExt.Filter   := 'EXT_HISTOR LIKE ' + QuotedStr('*' + edtProcura.Text + '*');
    qryMovExt.Filtered := True;
  end
  else
  begin
    qryMovExt.Filter   := '';
    qryMovExt.Filtered := False;
  end;
end;

procedure TfrmRelacionaHist.FormShow(Sender: TObject);
begin
  inherited;
  qryMovExt := fCriaQuery;

  dsHistExt.DataSet := qryMovExt;

  pAbrirQuery;
end;

procedure TfrmRelacionaHist.grdHistoricoDBTableView1CellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
  Var
    LHistMovBan : TfrmHistMovBan;
begin
  inherited;
  if qryMovExt.isEmpty then
    Exit;

  pCriarFormularios(TfrmHistMovBan, LHistMovBan);

  LHistMovBan.StrCodPor := qryMovExt.FieldByName('EXT_CODPOR').AsString;
  LHistMovBan.strHisExt := qryMovExt.FieldByName('EXT_HISTOR').AsString;

  try
    LHistMovBan.ShowModal;
  finally
    if LHistMovBan.strDescri <> '' then
      pVinculaHistorico(LHistMovBan.strDescri);

    FreeAndNil(LHistMovBan);
  end;
end;

procedure TfrmRelacionaHist.grdHistoricoDBTableView1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var
  strValor: String;
begin
  if AViewInfo.GridRecord.Selected then
     ACanvas.Brush.Color := clNavy;

  if AViewInfo.GridRecord.Index = -1 then
    Exit;

  strValor := VarAsType(grdHistoricoDBTableView1.ViewData.Records[AViewInfo.GridRecord.Index].Values[ grdHistoricoDBTableView1Column2.Index], varString);

  if (strValor <> '') and (not AViewInfo.GridRecord.Selected) then
    ACanvas.Brush.Color  := $00FFE4D5;
end;

procedure TfrmRelacionaHist.grdHistoricoDBTableView1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if key = vk_Return then
  begin
    if qryMovExt.isEmpty then
      Exit;

    frmHistMovBan := TfrmHistMovBan.Create(nil);

    frmHistMovBan.StrCodPor := qryMovExt.FieldByName('EXT_CODPOR').AsString;
    frmHistMovBan.strHisExt := qryMovExt.FieldByName('EXT_HISTOR').AsString;

    try
      frmHistMovBan.ShowModal;
    finally
      if frmHistMovBan.strDescri <> '' then
        pVinculaHistorico(frmHistMovBan.strDescri);

      FreeAndNil(frmHistMovBan);
    end;
  end;
end;

end.
