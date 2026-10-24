unit untItensAvisoAlteracaoPreco;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, cxCurrencyEdit,
  cxGridBandedTableView, cxGridDBBandedTableView, untFuncoesSimples,
  untGravando, cxProgressBar, untMensagem, Vcl.Mask, Vcl.DBCtrls, DBEditFocus,
  QColorLabel, EditFocus, untPai;

type
  TfrmItensAvisoAlteracaoPreco = class(TfrmPai)
    cxgItens: TcxGrid;
    cxgItensView: TcxGridDBBandedTableView;
    cxgItensCODITE: TcxGridDBBandedColumn;
    cxgItensDESITE: TcxGridDBBandedColumn;
    cxgItensPRECUS_ANT: TcxGridDBBandedColumn;
    cxgItensPRECUS_NOV: TcxGridDBBandedColumn;
    cxgItensPREVE1_ANT: TcxGridDBBandedColumn;
    cxgItensPREVE1_NOV: TcxGridDBBandedColumn;
    cxgItensPREVE1_VAR: TcxGridDBBandedColumn;
    cxgItensPREVE2_ANT: TcxGridDBBandedColumn;
    cxgItensPREVE2_NOV: TcxGridDBBandedColumn;
    cxgItensPREVE2_VAR: TcxGridDBBandedColumn;
    cxgItensPREVE3_ANT: TcxGridDBBandedColumn;
    cxgItensPREVE3_NOV: TcxGridDBBandedColumn;
    cxgItensPREVE3_VAR: TcxGridDBBandedColumn;
    cxgItensPREVE4_ANT: TcxGridDBBandedColumn;
    cxgItensPREVE4_NOV: TcxGridDBBandedColumn;
    cxgItensPREVE4_VAR: TcxGridDBBandedColumn;
    cxgItensPREVE5_ANT: TcxGridDBBandedColumn;
    cxgItensPREVE5_NOV: TcxGridDBBandedColumn;
    cxgItensPREVE5_VAR: TcxGridDBBandedColumn;
    cxgItensPREVE6_ANT: TcxGridDBBandedColumn;
    cxgItensPREVE6_NOV: TcxGridDBBandedColumn;
    cxgItensPREVE6_VAR: TcxGridDBBandedColumn;
    cxgItensPREVE7_ANT: TcxGridDBBandedColumn;
    cxgItensPREVE7_NOV: TcxGridDBBandedColumn;
    cxgItensPREVE7_VAR: TcxGridDBBandedColumn;
    cxgItensLevel1: TcxGridLevel;
    dtsItens: TDataSource;
    cxgItensPRECUS_VAR: TcxGridDBBandedColumn;
    cxgItensCODUNI: TcxGridDBBandedColumn;
    Panel1: TPanel;
    lblIteCcr: TLabel;
    clbIteCcr: TColorLabel;
    edtConfirma: TEditFocus;
    cxStyleRepository: TcxStyleRepository;
    styDentro: TcxStyle;
    styFora: TcxStyle;
    Shape2: TShape;
    Label2: TLabel;
    Label1: TLabel;
    Shape1: TShape;
    btnConfirmar: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure cxgItensPRECUS_VARStylesGetContentStyle(
      Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    var
      fltPctPrc : Double;
    procedure pAjustaColunas;
    function fAjustarColunasAux(pgbProgresso: TcxProgressBar): Boolean;
  protected
  public
    var
     blnConfirma: Boolean;
  end;

var
  frmItensAvisoAlteracaoPreco: TfrmItensAvisoAlteracaoPreco;

implementation

{$R *.dfm}

procedure TfrmItensAvisoAlteracaoPreco.btnConfirmarClick(Sender: TObject);
begin
  inherited;
   If Not (Pos(edtConfirma.Text,'SN') > 0) Then
   Begin
     fMensagem('', 'O campo de confirmação deve ser S ou N', ['&OK']);
     Exit;
   End
   Else
   Begin
     ModalResult := mrOk;
   End;
end;

procedure TfrmItensAvisoAlteracaoPreco.cxgItensPRECUS_VARStylesGetContentStyle(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
var
  fltVar: Double;
begin
  inherited;
  Try
    fltVar := cxgItensView.DataController.Values[ARecord.RecordIndex, TcxGridDBBandedColumn(AItem).Index];
  Except
    fltVar := 0;
  End;

  If fltVar = 0 Then
    Exit;

  If fltVar > fltPctPrc Then
    AStyle := styFora
  Else
    AStyle := styDentro;
end;

function TfrmitensAvisoAlteracaoPreco.fAjustarColunasAux(pgbProgresso: TcxProgressBar):Boolean;
var
  intTab: Integer;
  blnTabVisible: Boolean;
begin
  Try
    cxgItensView.Bands[0].Caption := '   Produtos com oscilação de preço superior ou inferior a ' + FloatToStr(fltPctPrc) + '%   ';

    pgbProgresso.Position := 0;
    pgbProgresso.Properties.Max := Length(VS_strTabPrc)-1;

    For intTab := 1 To Length(VS_strTabPrc) Do
    Begin
      blnTabVisible := VS_strTabPrc[intTab] = 'S';

      TcxGridDBBandedColumn(FindComponent('cxgItensPREVE'+intTab.toString+'_ANT')).Visible := blnTabVisible;
      TcxGridDBBandedColumn(FindComponent('cxgItensPREVE'+intTab.toString+'_NOV')).Visible := blnTabVisible;
      TcxGridDBBandedColumn(FindComponent('cxgItensPREVE'+intTab.toString+'_VAR')).Visible := blnTabVisible;

      pgbProgresso.Position := pgbProgresso.Position + 1;
      Application.ProcessMessages;
    End;

    cxgItensView.ApplyBestFit;
    pSetFocus(cxgItens);

    Result := True;
  Except On
    E:Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TfrmitensAvisoAlteracaoPreco.fAjustarColunasAux]');
    End;
  End;
end;

procedure TfrmItensAvisoAlteracaoPreco.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  blnConfirma := edtConfirma.Text = 'S';
end;

procedure TfrmItensAvisoAlteracaoPreco.FormCreate(Sender: TObject);
begin
  inherited;
  fltPctPrc := fCfgSis('PCTPRC', varDouble);
end;

procedure TfrmItensAvisoAlteracaoPreco.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F10: btnConfirmar.Click;
  End;
end;

procedure TfrmItensAvisoAlteracaoPreco.FormShow(Sender: TObject);
begin
  inherited;
  pAjustaColunas;
end;

procedure TfrmItensAvisoAlteracaoPreco.pAjustaColunas;
begin
  TfrmGravando.fExecuta(fAjustarColunasAux, frmGravando, 'Ajustando grid de variações de preço...');
end;

end.
