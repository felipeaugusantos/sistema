unit untBoxEntrega;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, untTBoxEntrega, System.ImageList, Vcl.ImgList, EditFocus,
  untBoxEntregaTroca;

type
  TfrmBoxEntrega = class(TfrmPai)
    pnlPrincipal: TPanel;
    imlSetas: TImageList;
    shpCorLivre: TShape;
    shpVista: TShape;
    shpPrazoSemEnt: TShape;
    shpPrazoComEnt: TShape;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    btnAtualizar: TBitBtnLocked;
    btnInformarBox: TBitBtnLocked;
    edtTimer: TEditFocus;
    tmrRefresh: TTimer;
    Label5: TLabel;
    Label6: TLabel;
    btnOrdenacao: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnAtualizarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure edtTimerExit(Sender: TObject);
    procedure tmrRefreshTimer(Sender: TObject);
    procedure btnInformarBoxClick(Sender: TObject);
    procedure btnOrdenacaoClick(Sender: TObject);
  private
    { Private declarations }
    objDocBoxEntrega : TDocumentoBoxEntrega;
    toTpOrd          : TTipoOrdenacao;
    TipoOperacao     : TTipoOperacao;

    procedure pHabilitarTimer;

  public
    procedure pConfiguraTelaParaOperacaoDeRetira;
    procedure pConfiguraTelaParaOperacaoDeEntregaImediata;
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples;

procedure TfrmBoxEntrega.btnAtualizarClick(Sender: TObject);
begin
  inherited;

  objDocBoxEntrega.pDesenharPanelBotoes(-1, toTpOrd);
end;

procedure TfrmBoxEntrega.btnInformarBoxClick(Sender: TObject);
  Var
    frmBoxEntregaTroca : TfrmBoxEntregaTroca;
begin
  inherited;

  Try
    pCriarFormularios(TfrmBoxEntregaTroca, frmBoxEntregaTroca);
    frmBoxEntregaTroca.objDocBoxEntrega := Self.objDocBoxEntrega;
    frmBoxEntregaTroca.ShowModal();
    objDocBoxEntrega.pDesenharPanelBotoes(-1, toTpOrd);
  Finally
    FreeAndNil(frmBoxEntregaTroca);
  End;
end;

procedure TfrmBoxEntrega.btnOrdenacaoClick(Sender: TObject);
begin
  inherited;

  If (fMensagem('', 'Ordenar por: ', ['&Box', '&Cliente']) = 1) Then
    toTpOrd := toBox
  Else
    toTpOrd := toCliente;

  btnAtualizar.Click();
end;

procedure TfrmBoxEntrega.edtTimerExit(Sender: TObject);
begin
  inherited;

  pHabilitarTimer();
end;

procedure TfrmBoxEntrega.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;

  FreeAndNil(objDocBoxEntrega);
end;

procedure TfrmBoxEntrega.FormCreate(Sender: TObject);
begin
  inherited;

  toTpOrd := toBox;
  objDocBoxEntrega := nil;
end;

procedure TfrmBoxEntrega.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If (Key = VK_F5) Then
    btnAtualizar.Click();

  If (Key = VK_F9) Then
    btnInformarBox.Click();

  If (Key = VK_F7) Then
    btnOrdenacao.Click();
end;

procedure TfrmBoxEntrega.FormShow(Sender: TObject);
begin
  inherited;

  If (Not Assigned(objDocBoxEntrega)) Then
    objDocBoxEntrega := TDocumentoBoxEntrega.Create(Self, pnlPrincipal, imlSetas, TipoOperacao);

  objDocBoxEntrega.pDesenharPanelBotoes(0, toTpOrd);

  shpCorLivre.Brush.Color    := fCfgSis(IIF(objDocBoxEntrega.fEhOperacaoDeRetira, 'BOXLIV', 'BEILIV'), varInteger);
  shpVista.Brush.Color       := fCfgSis(IIF(objDocBoxEntrega.fEhOperacaoDeRetira, 'BOXVIS', 'BEIVIS'), varInteger);
  shpPrazoSemEnt.Brush.Color := fCfgSis(IIF(objDocBoxEntrega.fEhOperacaoDeRetira, 'BOXPRA', 'BEIPRA'), varInteger);
  shpPrazoComEnt.Brush.Color := fCfgSis(IIF(objDocBoxEntrega.fEhOperacaoDeRetira, 'BOXPRE', 'BEIPRE'), varInteger);

  pHabilitarTimer();
end;

procedure TfrmBoxEntrega.pConfiguraTelaParaOperacaoDeEntregaImediata;
begin
  TipoOperacao := topEntregaImediata;
  Self.Caption := 'Box de Entrega - ENTREGA IMEDIATA';
end;

procedure TfrmBoxEntrega.pConfiguraTelaParaOperacaoDeRetira;
begin
  TipoOperacao := topRetira;
  Self.Caption := 'Box de Entrega - RETIRA';
end;

procedure TfrmBoxEntrega.pHabilitarTimer;
begin
  If (StrToInt(edtTimer.Text) > 0) Then
  Begin
    tmrRefresh.Interval := StrToInt(edtTimer.Text) * 1000;
    tmrRefresh.Enabled  := True;
  End
  Else
  Begin
    tmrRefresh.Enabled  := False;
  End;
end;

procedure TfrmBoxEntrega.tmrRefreshTimer(Sender: TObject);
begin
  inherited;

  btnAtualizar.Click();
end;

end.
