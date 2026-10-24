unit untSelecionaLayout;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiEdit, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, DB,
  cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  Uni, BitBtnLockedIncrem, cxLookAndFeels,
  cxLookAndFeelPainters, cxNavigator, frxClass, frxExportCSVTestabilidade,
  cxCheckBox, cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmSelecionaLayout = class(TfrmPaiEdit)
    dtsLayEti: TDataSource;
    cxStyleRepositorio: TcxStyleRepository;
    cxStyleSelecao: TcxStyle;
    cxStyle1: TcxStyle;
    btnConfima: TBitBtnLocked;
    btnExcluir: TBitBtnLocked;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1: TcxGridDBTableView;
    colCodLay: TcxGridDBColumn;
    colNomLay: TcxGridDBColumn;
    colDtaAlt: TcxGridDBColumn;
    colHorAlt: TcxGridDBColumn;
    colPadrao: TcxGridDBColumn;
    cxGrid1Level1: TcxGridLevel;
    colDescri: TcxGridDBColumn;
    colEmpresa: TcxGridDBColumn;
    colOpcional: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure cxgLayEtiDBTableView1Column5CustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure btnExcluirClick(Sender: TObject);
    procedure colOpcionalPropertiesChange(Sender: TObject);
  private
    { Private declarations }

    procedure pExcluiLayout;
    procedure pAtualizaCampoOpcional();
  public
    qryLayEti: TUniQuery;
    strCodLay: String;
    { Public declarations }
    class procedure pSelecionaLayout(qryDados : TUniQuery);
  end;

var
  frmSelecionaLayout: TfrmSelecionaLayout;

implementation



{$R *.dfm}

uses untFuncoesSimples;

procedure TfrmSelecionaLayout.btnExcluirClick(Sender: TObject);
begin
  inherited;

  pExcluiLayout;
end;

procedure TfrmSelecionaLayout.pExcluiLayout;
Begin
  With qryLayEti Do
  Begin
    If FieldByName('LAY_CODLAY').AsString = strCodLay Then
    Begin
      pMensagemOk('Esse layout está aberto no editor!');
      Exit;
    End;

    If SameText(FieldByName('LAY_PADRAO').AsString, 'S') Then
    Begin
      pMensagemOk('Layout padrão não pode ser excluido!');
      Exit;
    End;

    If fPergunta('Confirma a exclusão do layout?') Then
    Begin
      qryLayEti.Delete;
      qryLayEti.Refresh;
    End;
  End;
End;

class procedure TfrmSelecionaLayout.pSelecionaLayout(qryDados: TUniQuery);
begin
  pCriarFormularios(TfrmSelecionaLayout, frmSelecionaLayout);

  frmSelecionaLayout.dtsLayEti.DataSet := qryDados;
  frmSelecionaLayout.colPadrao.Options.Editing := False;
  frmSelecionaLayout.btnExcluir.Visible := False;
  frmSelecionaLayout.btnSair.Visible := False;
  frmSelecionaLayout.ShowModal;

  FreeAndNil(frmSelecionaLayout);
end;

procedure TfrmSelecionaLayout.colOpcionalPropertiesChange(Sender: TObject);
begin
  inherited;
  pAtualizaCampoOpcional();
end;

procedure TfrmSelecionaLayout.cxgLayEtiDBTableView1Column5CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If AViewInfo.Value = 'S' Then
  Begin
    ACanvas.Brush.Color := clRed;
  End;

end;

procedure TfrmSelecionaLayout.FormCreate(Sender: TObject);
begin
  inherited;

  strCodLay := '';
  qryLayEti := fCriaQuery(Self);
  dtsLayEti.DataSet := qryLayEti;

end;

procedure TfrmSelecionaLayout.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F10,
    VK_RETURN: Begin
                 btnConfima.Click;
                 Key := 0;
               End;
  End;

end;

procedure TfrmSelecionaLayout.FormShow(Sender: TObject);
begin
  inherited;

  if not fEmptyStr(qryLayEti.SQL.Text) Then
  Begin
    With qryLayEti Do
    Begin
      FieldByName('LAY_DTAALT').Alignment := taCenter;
      FieldByName('LAY_HORALT').Alignment := taCenter;
      FieldByName('LAY_PADRAO').Alignment := taCenter;
    End;
  End;

end;

procedure TfrmSelecionaLayout.pAtualizaCampoOpcional();
  Var
    qry: TUniQuery;
Begin
  If (qryLayEti.IsEmpty) then
    Exit;

  qry := fCriaQuery;
  Try
    qry.SQL.Clear;
    qry.SQL.Add('UPDATE LAYETI SET ');
    qry.SQL.Add('  LAY_OPCION = :OPCION ');
    qry.SQL.Add('WHERE');
    qry.SQL.Add('  LAY_TIPLAY = :TIPLAY AND ');
    qry.SQL.Add('  LAY_CODLAY = :CODLAY AND ');
    qry.SQL.Add('  LAY_CODEMP = :CODEMP ');

    qry.ParamByName('OPCION').AsString  := qryLayEti.FieldByName('LAY_OPCION').AsString;
    qry.ParamByName('TIPLAY').AsString  := qryLayEti.FieldByName('LAY_TIPLAY').AsString;
    qry.ParamByName('CODLAY').AsString  := qryLayEti.FieldByName('LAY_CODLAY').AsString;
    qry.ParamByName('CODEMP').AsString  := qryLayEti.FieldByName('LAY_CODEMP').AsString;
    qry.ExecSQL;
  Finally
    FreeAndNil(qry);
  End;
End;

end.
