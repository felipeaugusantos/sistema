unit Login.View.FMXSplash;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.Ani, FMX.Layouts,
  FMX.Effects, FMX.Filter.Effects, Login.View.Interfaces,
  System.Math, StrUtils;

type
  TfmxSplash = class(TForm, ISplashView)
    lblMensagem: TLabel;
    layFundo: TLayout;
    imgLogoFundoEscuro: TImage;
    LineTransitionEffect1: TLineTransitionEffect;
    tmrStart: TTimer;
    lblPercentagem: TLabel;
    lblAcoes: TLabel;
    imgFundo: TImage;
    recFundo: TRectangle;
    procedure FormShow(Sender: TObject);
    procedure tmrStartTimer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    procedure NotificarProgresso(ANotificacao: ISplashNotificacaoProgresso);
  public
    { Public declarations }
    objSplash: ISplash;
  end;

function ExecutarSplash(AObjSplash: ISplash; RunningInTSPlus: Boolean = False): Boolean;

implementation

{$R *.fmx}

var
  fmxSplash: TfmxSplash;

function ExecutarSplash(AObjSplash: ISplash; RunningInTSPlus: Boolean = False): Boolean;
begin
  fmxSplash := TfmxSplash.Create(nil);
  Try
    fmxSplash.objSplash := AObjSplash;

    If RunningInTSPlus Then
    Begin
      fmxSplash.Transparency              := False;
      fmxSplash.recFundo.Corners          := [];
      fmxSplash.recFundo.Stroke.Thickness := 0;
    End
    Else
    Begin
      fmxSplash.Transparency              := True;
      fmxSplash.recFundo.Corners          := [TCorner.TopLeft,
                                             TCorner.TopRight,
                                             TCorner.BottomLeft,
                                             TCorner.BottomRight];
      fmxSplash.recFundo.Stroke.Thickness := 1;
    End;

    fmxSplash.ShowModal;
    Result := AObjSplash.SplashRealizado;
  Finally
    FreeAndNil(fmxSplash);
  End;
end;

procedure TfmxSplash.FormDestroy(Sender: TObject);
begin
  objSplash.RemoveView(Self);
end;

procedure TfmxSplash.FormShow(Sender: TObject);
begin
  objSplash.AddView(Self);
  LineTransitionEffect1.Normal := PointF(150, 0);
  tmrStart.Enabled := True;
end;

procedure TfmxSplash.NotificarProgresso(ANotificacao: ISplashNotificacaoProgresso);
Var
  LProgresso: Double;
begin
  LProgresso                     := ANotificacao.Progresso / ANotificacao.Max * 100;
  LineTransitionEffect1.Progress := Floor(LProgresso * 85 / 100 );
  lblPercentagem.Text            := FormatFloat('0', Floor(LProgresso)) + '%';

  If Not ANotificacao.Detalhes.IsEmpty Then
    lblAcoes.Text := ANotificacao.Detalhes
  Else
  Begin
    If ContainsText(ANotificacao.Mensagem, 'Aguarde... ') Then
      lblAcoes.Text := Copy(ANotificacao.Mensagem, 12, Length(ANotificacao.Mensagem))
    else
      lblAcoes.Text := ANotificacao.Mensagem;
  End;
end;

procedure TfmxSplash.tmrStartTimer(Sender: TObject);
begin
  tmrStart.Enabled := False;
  Try
    objSplash.ExecutarSplash();
  Finally
    Self.Close;
  End;
end;

initialization
  registerclass(TfmxSplash);

end.
