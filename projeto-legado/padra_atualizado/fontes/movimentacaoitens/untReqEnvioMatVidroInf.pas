unit untReqEnvioMatVidroInf;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiConfirma, StdCtrls, EditFocus, frxClass,
  frxExportCSVTestabilidade, AppEvnts, Menus, Buttons, BitBtnLockedIncrem,
  ExtCtrls, MemoFocus, QColorLabel;

type
  TfrmReqEnvioMatVidroInf = class(TfrmPaiConfirma)
    Panel1: TPanel;
    lbl2: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label19: TLabel;
    ColorLabel1: TColorLabel;
    memInfVid: TMemoFocus;
    memInfFer: TMemoFocus;
    memInfAlu: TMemoFocus;
    memObserv: TMemoFocus;
    edtObrFin: TEditFocus;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

implementation

uses untFuncoesSimples;

{$R *.dfm}

{ TfrmReqEnvioMatVidroInf }

procedure TfrmReqEnvioMatVidroInf.FormShow(Sender: TObject);
begin
  inherited;
  SelectFirst;
end;

function TfrmReqEnvioMatVidroInf.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtObrFin) Then
    Begin
      If fEmptyStr(edtObrFin.Text) Then
      Begin
        fMensagem('Atenção', 'O campo obra finalizada deve ser informado!', ['&Ok']);
        Result := False;
      End
      Else If (edtObrFin.Text <> 'S') And (edtObrFin.Text <> 'N')Then
      Begin
        fMensagem('Atenção', 'O campo obra finalizada deve ser (S)im ou (N)ão!', ['&Ok']);
        Result := False;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

end.
