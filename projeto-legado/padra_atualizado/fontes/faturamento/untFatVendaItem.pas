unit untFatVendaItem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiEdit, frxClass, untTypesSistema,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls;

type
  TValidaCampos = Function(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean Of Object;

  TfrmFatVendaItem = class(TfrmPaiEdit)
    pnlImpostos: TPanel;
    Label15: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    llbCST: TLabel;
    llbCFOP: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    llbICMSbase: TLabel;
    llbICMSaliq: TLabel;
    Label8: TLabel;
    llbICMSvalor: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    llbIPIbase: TLabel;
    llbIPIaliq: TLabel;
    Label16: TLabel;
    llbIPIvalor: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    llbSTbase: TLabel;
    llbSTiva: TLabel;
    Label23: TLabel;
    llbSTvalor: TLabel;
    Label25: TLabel;
    llbTotalimpostos: TLabel;
    pnlUltimaCompra: TPanel;
    Label26: TLabel;
    Label6: TLabel;
    llbULtCompra: TLabel;
    Label9: TLabel;
    pnlFundo: TPanel;
    tmrFechar: TTimer;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure tmrFecharTimer(Sender: TObject);
  private
    { Private declarations }
    blnUsaMultiLote, blnUsaMultiSerie, blnUsaMultiSerieNF: Boolean;
    FOnIniciar: TGenericProcedure;
    FCloseExecute: TReferenceProcedure;
    FOnExecute : TReferenceBooleanFunction;
    FExecute : Boolean;
  public
    { Public declarations }
    fValidaCamposVenda: TValidaCampos;
  public
    property OnIniciar: TGenericProcedure read FOnIniciar write FOnIniciar;
    property OnExecute: TReferenceBooleanFunction read FOnExecute write FOnExecute;
    property Execute : Boolean read FExecute write FExecute;
    property CloseExecute : TReferenceProcedure read FCloseExecute write FCloseExecute;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmFatVendaItem: TfrmFatVendaItem;

implementation

{$R *.dfm}

uses untFatVendas, untFuncoesSimples;

procedure TfrmFatVendaItem.FormActivate(Sender: TObject);
begin
  inherited;
  if Assigned(FOnIniciar) then
    fExecutarModal(FOnIniciar, 'Aguarde, Carregando dados ...', '');
  If (Assigned(FOnExecute)) Then
  Begin
    Application.ProcessMessages;
    FExecute := FOnExecute;
    If (Not FExecute) Then
    Begin
      If Assigned(FCloseExecute) Then
        tmrFechar.Enabled := True;
    End;
  End;
end;

procedure TfrmFatVendaItem.FormCreate(Sender: TObject);
begin
  inherited;
  FExecute := True;
  pnlImpostos.Visible := False;

  if (Assigned(frmFatVendas)) then
  begin
    blnUsaMultiLote := (FrmFatVendas.pnlItemLote.Visible) and (fCfgSis('MULTLT', varString) = 'S') and (Pos(FrmFatVendas.strOpcDoc, 'PD_OR_VN_') > 0);
    if FrmFatVendas.blnTrocandoProduto and (FrmFatVendas.strIdeProTrocando <> 'NOR') then
      blnUsaMultiLote := False;
    blnUsaMultiSerie := (fCfgSis('NSERQT', varString) = 'S') And (Pos(FrmFatVendas.strOpcDoc, 'PD_OR_') > 0) And
                        fProdutoUsaNumeroDeSerie(FrmFatVendas.edtCodIte.Text, FrmFatVendas.edtCodEmp.Text);
    blnUsaMultiSerieNF := (fCfgSis('NUMSER', varString) = 'S') And (fCfgSis('INNUSE',varString) = 'S') And (Pos(FrmFatVendas.strOpcDoc, 'VN_') > 0) And
                          fProdutoUsaNumeroDeSerie(FrmFatVendas.edtCodIte.Text, FrmFatVendas.edtCodEmp.Text);
    pnlInfo.Caption := '  F7 - Últimas Vendas' +
                     IIF(blnUsaMultiLote,  '     F8 - Selecionar Lotes', '') +
                     IIF(blnUsaMultiSerie, '     F9 - Selecionar Séries', '');
    pnlInfo.Caption := pnlInfo.Caption  +
                       IIF(blnUsaMultiSerieNF, '     F9 - Selecionar Séries', '');
  end
  else
  begin
    blnUsaMultiLote    := False;
    blnUsaMultiSerie   := False;
    blnUsaMultiSerieNF := False;
  end;

  blnPassarRadioButtonComEnter := False;

  Self.llbCST.Caption           := '' ;
  Self.llbCFOP.Caption          := '';

  Self.llbICMSbase.Caption      := FloatToStrF(0, ffFixed, 12, 2);
  Self.llbICMSaliq.Caption      := FloatToStrF(0, ffFixed, 12, 2);
  Self.llbICMSvalor.Caption     := FloatToStrF(0, ffFixed, 12, 2);

  Self.llbIPIbase.Caption       := FloatToStrF(0, ffFixed, 12, 2);
  Self.llbIPIaliq.Caption       := FloatToStrF(0, ffFixed, 12, 2);
  Self.llbIPIvalor.Caption      := FloatToStrF(0, ffFixed, 12, 2);

  Self.llbSTbase.Caption        := FloatToStrF(0, ffFixed, 12, 2);
  Self.llbSTiva.Caption         := FloatToStrF(0, ffFixed, 12, 2);
  Self.llbSTvalor.Caption       := FloatToStrF(0, ffFixed, 12, 2);
  Self.llbTotalimpostos.Caption := FloatToStrF(0, ffFixed, 12, 2);
end;

procedure TfrmFatVendaItem.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_Return: SelectNext(ActiveControl, True, True);
    VK_Escape: Key := 0;
    VK_F7: if Assigned(frmFatVendas) then FrmFatVendas.pUltimasVendas;
    VK_F8: if (blnUsaMultiLote) and Assigned(frmFatVendas) then
             FrmFatVendas.pMostraMultiLotes(FrmFatVendas.edtCodIte.Text)
           else if Assigned(frmFatVendas) And FrmFatVendas.blnTrocandoProduto and (FrmFatVendas.strIdeProTrocando <> 'NOR') then
             FrmFatVendas.btnTintaMaquina.Click;
    VK_F9: if ((blnUsaMultiSerie) Or (blnUsaMultiSerieNF)) and Assigned(frmFatVendas) Then
           begin
             frmFatVendas.pMostraMultiSeries;
           end;
  End;
end;

function TfrmFatVendaItem.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
Begin
  Result := fValidaCamposVenda(Sender, blnBuscaPorChave);
End;

procedure TfrmFatVendaItem.tmrFecharTimer(Sender: TObject);
begin
  inherited;
  If Not Assigned(FCloseExecute) Then
    Exit;
  FCloseExecute;
  Self.Close;
end;

end.

