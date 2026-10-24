unit untFormTestabilidade;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untTestabilidade;

type
  TfrmTestabilidade = class(TForm)
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  published
    objTestabilidade: TTestabilidade;

  end;

var
  frmTestabilidade: TfrmTestabilidade;

implementation

{$R *.dfm}

procedure TfrmTestabilidade.FormCreate(Sender: TObject);
begin
  objTestabilidade := TTestabilidade.fGetTestabilidade;
end;

procedure TfrmTestabilidade.FormDestroy(Sender: TObject);
begin
  objTestabilidade := Nil; // -> Referência emprestada de fGetTestabilidade: o dono do singleton é a seção finalization de untTestabilidade, não este form.
end;

end.
