unit untPnlDadosAdquirentesCartao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem;

type
  TfrmPnlDadosAdquirentesCartao = class(TForm)
    btnIncluirAdquirente: TBitBtnLocked;
  procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnIncluirAdquirenteClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); reintroduce; virtual;
  end;

  TfrmPnlDadosAdquirentesCartaoClass = Class Of TfrmPnlDadosAdquirentesCartao;

implementation

uses untCadAdquirenteCartao, untFuncoesSimples ;

{$R *.dfm}

{ TfrmPnlDadosAdquirentesCartao }

procedure TfrmPnlDadosAdquirentesCartao.btnIncluirAdquirenteClick(
  Sender: TObject);
var
  LfrmCadAdqCartao : TfrmCadAdquirenteCartao ;
begin
  pCriarFormularios(TfrmCadAdquirenteCartao, LfrmCadAdqCartao);
  Try
    LfrmCadAdqCartao.showModal;
  Finally
    pFreeAndNil(LfrmCadAdqCartao);
  End;
end;

constructor TfrmPnlDadosAdquirentesCartao.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

procedure TfrmPnlDadosAdquirentesCartao.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Case Key Of
    VK_F10: btnIncluirAdquirente.Click;
  End;

  Case Key Of
    VK_F10: Key := 0;
  End;
end;

end.
