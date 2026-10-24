unit untSelFasObra;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass, untTypesSistema,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, EditFocus, untSelFaseObraFrame, untFuncFat;

type
  TfrmSelFasObra = class(TfrmPai)
    btnConfirma: TBitBtnLocked;
    fraFaseObra: TfraSelFaseObraFrame;
    procedure FormActivate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean = False): Boolean; Override;
  public
    { Public declarations }
    objVenda: TFatVenda;
    blnConfirma: Boolean;
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples, untConsultas, untConstantes, untFuncoesConsulta;

procedure TfrmSelFasObra.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If Not fVerificaCampos Then
    Exit;

  If Not fraFaseObra.fConfirmaDados Then
    Exit;

  blnConfirma := True;
  Close;
end;

procedure TfrmSelFasObra.FormActivate(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
end;

procedure TfrmSelFasObra.FormCreate(Sender: TObject);
begin
  inherited;
  fraFaseObra.OnFormCreate;
end;

procedure TfrmSelFasObra.FormDestroy(Sender: TObject);
begin
  inherited;
  fraFaseObra.OnFormDestroy;
end;

procedure TfrmSelFasObra.FormShow(Sender: TObject);
begin
  inherited;
  fraFaseObra.objVenda := objVenda;
  fraFaseObra.OnFormShow;
end;

function TfrmSelFasObra.fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean;
begin
  Result := fraFaseObra.fValidaCampos(Sender, blnValidaIndividual);
  If Not Result Then
    pSetFocus(Sender);
end;

end.
