unit untHorarioDisparaRobo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit,
  cxSpinEdit, cxTimeEdit;

type
  TfrmHorarioDisparaRobo = class(TfrmPaiConfirma)
    Panel1: TPanel;
    HroInicial: TcxTimeEdit;
    HroFim: TcxTimeEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
  private
    { Private declarations }
    FConfiguracao: String;
    FHorario : String;
    function getTimeToStr(AValor: TTime): String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;

  public
    { Public declarations }

  property Horario: String read FHorario write FHorario;
  property Configuracao: String read FConfiguracao write FConfiguracao;
  end;

implementation

Uses System.StrUtils, untFuncoesSimples;

{$R *.dfm}

{ TfrmHorarioDisparaRobo }

procedure TfrmHorarioDisparaRobo.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If Self.ModalResult = mrOk Then
  Begin
    FHorario :=  Concat('Inicial: ',getTimeToStr(HroInicial.Time),'   ','Final: ',getTimeToStr(HroFim.Time));
  End;
end;

procedure TfrmHorarioDisparaRobo.FormShow(Sender: TObject);
begin
  inherited;
  FHorario := '';
end;

function TfrmHorarioDisparaRobo.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result:= True;

  If (Sender = HroFim) Then
  Begin
    If  HroFim.Time < HroInicial.Time  Then
    Begin
      fMensagem('ATENÇÃO!', 'O Horário Final deve ser maior que a Horário Inicial!',['&Ok']);
      Result := False;
    End;
  End;

 If Not Result Then
   pSetFocus(Sender);

end;

function TfrmHorarioDisparaRobo.getTimeToStr(AValor: TTime): String;
begin
  Try
    Result := Copy(TimeToStr(AValor),1,5);
  Except
    Result := '00:00';
  End;
end;

end.
