unit untArqDivRetBco;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, AppEvnts, Menus, Buttons, BitBtnLockedIncrem,
  ExtCtrls, frxClass, frxDBSet, frxExportCSVTestabilidade;

type
  TfrmArqDivRetBco = class(TfrmPai)
    memArqDiv: TMemo;
    frxReportJ: TfrxReport;
    frxDBNaoGra: TfrxDBDataset;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    strNomArq: String;
  end;

var
  frmArqDivRetBco: TfrmArqDivRetBco;

implementation

{$R *.dfm}

procedure TfrmArqDivRetBco.FormShow(Sender: TObject);
begin
  inherited;

  memArqDiv.Lines.LoadFromFile(strNomArq);

end;

end.
