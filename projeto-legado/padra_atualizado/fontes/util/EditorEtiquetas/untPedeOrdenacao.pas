unit untPedeOrdenacao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiEdit, AppEvnts, Menus, StdCtrls, Buttons, BitBtnLockedIncrem,
  ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage,
  cxEdit, DB, cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, cxDropDownEdit,
  EditFocus, ComboBoxFocus, untTypesSistema, cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, frxClass,
  frxExportCSVTestabilidade, untOrdenacao, untFuncoesEditorFast,
  untConsultas, cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmPedeOrdenacao = class(TfrmPaiEdit)
    btnConfirma: TBitBtnLocked;
    pnlDados: TPanel;
    cxgItensView: TcxGridDBTableView;
    cxgItensLevel1: TcxGridLevel;
    cxgItens: TcxGrid;
    cxgItensCODCAM: TcxGridDBColumn;
    cxgItensDESCAM: TcxGridDBColumn;
    cxgItensDIRECA: TcxGridDBColumn;
    pnlUpDown: TPanel;
    spbUp: TSpeedButton;
    spbDown: TSpeedButton;
    btnExcluir: TBitBtnLocked;
    btnIncluir: TBitBtnLocked;
    edtCodCam: TEditFocus;
    edtDesCam: TEditFocus;
    Label1: TLabel;
    Label2: TLabel;
    cxgItensNUMORD: TcxGridDBColumn;
    cbxDirecao: TComboBoxFocus;
    procedure edtCodCamKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure spbUpClick(Sender: TObject);
    procedure spbDownClick(Sender: TObject);
  private
    { Private declarations }
    arrSel: TConsultasArray;
  public
    { Public declarations }
    cdsCamOrd: TOrdenacao;
  protected

    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  end;

var
  frmPedeOrdenacao: TfrmPedeOrdenacao;

implementation

{$R *.dfm}

uses untReguaEditor, untFuncoesSimples, untConstantes, Uni;
  
procedure TfrmPedeOrdenacao.btnExcluirClick(Sender: TObject);
begin
  inherited;

  cdsCamOrd.pExclui;
end;

procedure TfrmPedeOrdenacao.btnIncluirClick(Sender: TObject);
begin
  inherited;

  If Not fVerificaCampos Then
    Exit;

  If cdsCamOrd.fInclui(edtCodCam.Text, edtDesCam.Text, cbxDirecao.Text) Then
  Begin
    edtCodCam.Clear;
    edtDesCam.Clear;
    cbxDirecao.ItemIndex := 0;
    pSetFocus(edtCodCam);
  End;
end;

procedure TfrmPedeOrdenacao.edtCodCamKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  If fPesqCamsposLayout(Self,
                        edtCodCam,
                        edtDesCam,
                        Nil,
                        Key,
                        arrSel,
                        fSQLFiltroCamposDocumento(cdsCamOrd.intCodEti),
                        VAL_DADOS) And
     fValidaCampos(edtCodCam, True) Then
    Self.SelectNext(ActiveControl, True, True);

end;

procedure TfrmPedeOrdenacao.FormShow(Sender: TObject);
begin
  inherited;

  cxgItensView.DataController.DataSource := cdsCamOrd.dtsSource;

  pSetFocus(edtCodCam);
end;

function TfrmPedeOrdenacao.fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin

    If (Sender = edtCodCam) Then
    Begin

      If fEmptyStr(edtCodCam.Text) Then
      Begin
        fMensagem('', 'Informe o código do Campo para ordenação!', ['&O k']);
        Result := False;
      End Else
      Begin

        edtDesCam.Text := fRetNomCampoLayout(edtCodCam.Text, cdsCamOrd.intCodEti, VAL_DADOS);

        If fEmptyStr(edtDesCam.Text) Then
        Begin
          fMensagem('', 'Código do Campo não encontrado!', ['&O k']);
          Result := False;
        End;

      End;

    End

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmPedeOrdenacao.spbDownClick(Sender: TObject);
begin
  inherited;

  cdsCamOrd.pDown;
end;

procedure TfrmPedeOrdenacao.spbUpClick(Sender: TObject);
begin
  inherited;

  cdsCamOrd.pUp;
end;

end.
