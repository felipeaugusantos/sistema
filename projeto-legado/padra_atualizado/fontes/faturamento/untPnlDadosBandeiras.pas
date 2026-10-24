unit untPnlDadosBandeiras;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem;

type
  TfrmPnlDadosBandeiras = class(TForm)
    btnIncluirBandeira: TBitBtnLocked;
  procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnIncluirBandeiraClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); reintroduce; virtual;
  end;

  TfrmPnlDadosBandeirasClass = Class Of TfrmPnlDadosBandeiras;

implementation

uses untCadBandeiras, untFuncoesSimples ;

{$R *.dfm}

{ TfrmPnlDadosBandeiras }

procedure TfrmPnlDadosBandeiras.btnIncluirBandeiraClick(Sender: TObject);
var
  LfrmCadBandeiras : TfrmCadBandeiras ;
begin
  pCriarFormularios(TfrmCadBandeiras, LfrmCadBandeiras);
  Try
    LfrmCadBandeiras.showModal;
  Finally
    pFreeAndNil(LfrmCadBandeiras);
  End;
end;

constructor TfrmPnlDadosBandeiras.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

procedure TfrmPnlDadosBandeiras.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Case Key Of
    VK_F10: btnIncluirBandeira.Click;
  End;

  Case Key Of
    VK_F10: Key := 0;
  End;
end;

end.
