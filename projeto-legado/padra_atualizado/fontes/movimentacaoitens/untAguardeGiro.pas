unit untAguardeGiro;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls;

type
  TfrmAguardeGiro = class(TForm)
    prbProgresso: TProgressBar;
    pnlInforma: TPanel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAguardeGiro: TfrmAguardeGiro;

implementation

{$R *.dfm}

initialization

  frmAguardeGiro := Nil;
  
end.
