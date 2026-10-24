unit untCadIteMon;

interface

uses
  Windows, Classes, Controls, Forms, untPai, AppEvnts, Menus, StdCtrls, Buttons,
  ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage,
  cxEdit, cxDBData, cxCheckBox, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxControls, cxGridCustomView,
  cxGrid, EditFocus, untCadIteMontadoras, BitBtnLockedIncrem, cxLookAndFeels,
  cxLookAndFeelPainters, cxNavigator, DB, frxClass, frxExportCSVTestabilidade,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmCadIteMon = class(TfrmPai)
    pnlEmbala: TPanel;
    Label168: TLabel;
    edtCodMon: TEditFocus;
    pnlTitulo: TPanel;
    cxgMontadora: TcxGrid;
    cxgMontadoraView: TcxGridDBTableView;
    cxgMontadoraLevel1: TcxGridLevel;
    edtDesMon: TEditFocus;
    cxgMontadoraCodMon: TcxGridDBColumn;
    cxgMontadoraNomMom: TcxGridDBColumn;
    btnExcluir: TBitBtnLocked;
    btnAdiBar: TBitBtnLocked;
    btnCanBar: TBitBtnLocked;
    procedure edtCodMonKeyPress(Sender: TObject; var Key: Char);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCanBarClick(Sender: TObject);
    procedure btnAdiBarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    objIteMon: TCadIteMontadoras;

    Procedure pLimpaTela;
  protected
    procedure pProximoControle(Sender: TObject);  override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmCadIteMon: TfrmCadIteMon;

implementation

uses untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmCadIteMon.pProximoControle(Sender: TObject);
begin
  If (Sender As TWinControl).Tag = 99 Then
  Begin
    If (fValidaCampos(TWinControl(Sender))) And (blnMudarFoco) Then
      SelectNext(TWinControl(Sender), True, True);
  End
  Else
    SelectNext(TWinControl(Sender), True, True);
  blnMudarFoco := True;
end;

procedure TfrmCadIteMon.btnAdiBarClick(Sender: TObject);
begin
  inherited;

  If fVerificaCampos Then
    objIteMon.pIncluiMontadora(edtCodMon.Text);

  pSetFocus(edtCodMon);

end;

Procedure TfrmCadIteMon.pLimpaTela;
Begin
  edtCodMon.Clear;
  edtDesMon.Clear;
End;

procedure TfrmCadIteMon.btnCanBarClick(Sender: TObject);
begin
  inherited;
  pLimpaTela;
end;

procedure TfrmCadIteMon.btnExcluirClick(Sender: TObject);
begin
  inherited;

  objIteMon.pExcluiRegistro;
end;

procedure TfrmCadIteMon.edtCodMonKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;

  If fPesqMontadora(Self,
                    edtCodMon,
                    edtDesMon,
                    Nil,
                    Key,
                    arrSel) And
     fValidaCampos(edtCodMon, True) Then
    pSetFocus(btnAdiBar);
end;

procedure TfrmCadIteMon.FormCreate(Sender: TObject);
begin
  inherited;

  blnFecharComEscape := False;
end;

procedure TfrmCadIteMon.FormShow(Sender: TObject);
begin
  inherited;

  cxgMontadoraView.DataController.DataSource := objIteMon.dtsSource;
  pSetFocus(edtCodMon);
end;

function TfrmCadIteMon.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  blnMudarFoco := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtCodMon) Then
    Begin

      If fEmptyStr(edtCodMon.Text) Then
      Begin
        edtDesMon.Clear;
      End Else
      Begin
        edtDesMon.Text := fRetNomMontadora(edtCodMon.Text);
        If fEmptyStr(edtDesMon.Text) Then
        Begin
          pMensagemOk('Código da Montadora não econtrado!');
          Result := False;
        End;
      End;

    End;


  End;

  If Not Result Then
    pSetFocus(Sender);
end;

end.

