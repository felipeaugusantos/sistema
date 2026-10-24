unit untFatDigCFOP;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, frxClass, untFuncFat, Uni,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, Vcl.Buttons,
  Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, EditFocus, System.StrUtils,
  untTypesSistema;

type
  TfrmFatDigCFOP = class(TfrmPaiSimples)
    pnlConfirma: TPanel;
    btnConfirmaDados: TBitBtnLocked;
    btnCancelaDados: TBitBtnLocked;
    pnlFundo: TPanel;
    lbl1: TLabel;
    edtClaFis: TEditFocus;
    edtDesCla: TEditFocus;
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCancelaDadosClick(Sender: TObject);
    procedure edtClaFisKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

implementation

uses untFuncoes, untfuncoesSimples, untConsultas;

{$R *.dfm}

function TfrmFatDigCFOP.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtClaFis) Then
    Begin
      If (fEmptyStr(TEditFocus(Sender).Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Classificação Fiscal deve ser preenchida!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        edtDesCla.Text := fRetDesCla(TEditFocus(Sender).Text);

        If fEmptyStr(edtDesCla.Text) Then
        Begin
          Result := False;
          fMensagem('ATENÇÃO!', 'Classificação Fiscal não cadastrada!', ['&Ok']);
        End
        Else
          SelectNext(ActiveControl, True, True);
      End;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmFatDigCFOP.btnCancelaDadosClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrCancel;
end;

procedure TfrmFatDigCFOP.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;
  If fVerificaCampos Then
    ModalResult := mrOk;
End;

procedure TfrmFatDigCFOP.edtClaFisKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrCFOP : TConsultasArray;
    qryConCfo : TUniQuery;
begin
  inherited;
  qryConCfo := fCriaQuery(Self);

  If fPesqCFOP(Self, edtClaFis, edtDesCla, qryConCfo, Key, arrCFOP) Then
  Begin
    If fValidaCampos(edtClaFis, True) Then
    begin
      SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmFatDigCFOP.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F10   : If btnConfirmaDados.Enabled Then
                 btnConfirmaDados.Click;

    VK_ESCAPE: Close;
  End;
end;

procedure TfrmFatDigCFOP.FormShow(Sender: TObject);
begin
  inherited;
  edtClaFis.Text := EmptyStr;
  edtDesCla.Text := EmptyStr;
  pSetFocus(edtClaFis);
end;

End.
