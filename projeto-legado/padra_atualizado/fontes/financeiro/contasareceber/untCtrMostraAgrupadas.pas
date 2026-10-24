unit untCtrMostraAgrupadas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, Grids, DBGridCitel, DBGrids, StrUtils,
  AppEvnts, DB, Uni, BitBtnLockedIncrem, MemDS, DBAccess, frxClass,
  frxExportCSVTestabilidade, EditFocus;

type
  TfrmCtrMostraAgrupadas = class(TfrmPai)
    dbgDuplicatas: TDBGridCitel;
    qryDados: TUniQuery;
    dtsDados: TDataSource;
    btnProdutos: TBitBtnLocked;
    pnlStatPromoc: TPanel;
    Shape1: TShape;
    Label17: TLabel;
    Panel1: TPanel;
    Label3: TLabel;
    Panel2: TPanel;
    lblValorTotal: TLabel;
    edtValorTotal: TEditFocus;
    procedure dbgDuplicatasKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure btnProdutosClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dbgDuplicatasDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
  public
    { Public declarations }
    blnSelDocumentosDupAgr: Boolean;  {se veio pelo resumo de caixa = TRUE}
    blnMosPro: Boolean;
  end;


implementation

uses TypesRel, untFuncoesRel2, untFuncoesRel, untRelFatVendasClienteF9,
  untModuloSPR, untFuncoesSimples;

{$R *.dfm}

procedure TfrmCtrMostraAgrupadas.dbgDuplicatasDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  if blnMosPro then
  Begin
    If qryDados.FieldByName('PROMOC').Value <> null Then
    Begin
      if (qryDados.FieldByName('PROMOC').AsString = 'S')  then
        dbgDuplicatas.Canvas.Font.Color := clTeal;
    End;
  End;

  dbgDuplicatas.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmCtrMostraAgrupadas.dbgDuplicatasKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_ESCAPE) Then
  Begin
    Close;
  End
  Else If (Key = VK_F7) Then
  Begin
    btnProdutos.Click;
  End
end;

procedure TfrmCtrMostraAgrupadas.FormShow(Sender: TObject);
begin
  inherited;
  dbgDuplicatas.Columns[7].Width := 70;
  pnlStatPromoc.Visible := self.blnMosPro;
end;

procedure TfrmCtrMostraAgrupadas.btnProdutosClick(Sender: TObject);
var
  frmRelFatVendasClienteF9: TfrmRelFatVendasClienteF9;
begin
  inherited;

  Try
    pCriarFormularios(TfrmRelFatVendasClienteF9, frmRelFatVendasClienteF9);

    With frmRelFatVendasClienteF9 Do
    Begin
      dtsRelVenCli.DataSet := frmModuloSPR.qryRelatorio;
      blnMosVenMtl := fCfgSis('VENMTL', varBoolean);
      blnMosPromoc := self.blnMosPro;

      pMostrarProdutos(LeftStr(dbgDuplicatas.DataSource.DataSet.FieldByName('CTR_DUPPAR').AsString, fTamDocCadRec),
                       dbgDuplicatas.DataSource.DataSet.FieldByName('CTR_ESPDOC').AsString,
                       LeftStr(dbgDuplicatas.DataSource.DataSet.FieldByName('CTR_CODEMP').AsString, 3),
                       False, dbgDuplicatas.DataSource.DataSet.FieldByName('CTR_CODCLI').AsString);
      ShowModal;
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[btnProdutosClick]');
    End;
  End;

  pFreeAndNil(frmRelFatVendasClienteF9);

end;

procedure TfrmCtrMostraAgrupadas.FormCreate(Sender: TObject);
begin
  inherited;
  blnMosPro              := False;
  blnSelDocumentosDupAgr := FALSE;
end;

end.
