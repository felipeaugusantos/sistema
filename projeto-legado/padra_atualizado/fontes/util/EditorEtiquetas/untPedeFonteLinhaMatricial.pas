unit untPedeFonteLinhaMatricial;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiConfirma, AppEvnts, Menus, StdCtrls, Buttons,
  BitBtnLockedIncrem, ExtCtrls, cxStyles, cxGraphics, cxEdit, cxCheckBox,
  cxDropDownEdit, cxVGrid, cxControls, cxInplaceContainer, cxLookAndFeels,
  cxLookAndFeelPainters, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmPedeFonteLinhaMatricial = class(TfrmPaiConfirma)
    cxvFonte: TcxVerticalGrid;
    cxvFonteTamanho: TcxEditorRow;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPedeFonteLinhaMatricial: TfrmPedeFonteLinhaMatricial;

implementation

{$R *.dfm}

end.
