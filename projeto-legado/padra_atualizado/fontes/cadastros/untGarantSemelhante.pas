unit untGarantSemelhante;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiEdit, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls,
  BitBtnLockedIncrem;

type
  TfrmGarantSemelhante = class(TfrmPaiEdit)
    lsbCodFab: TListBox;
    btnGravar: TBitBtnLocked;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmGarantSemelhante: TfrmGarantSemelhante;

implementation

{$R *.dfm}

end.
