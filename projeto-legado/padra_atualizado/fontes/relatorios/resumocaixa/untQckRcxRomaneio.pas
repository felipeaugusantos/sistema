unit untQckRcxRomaneio;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiQck, RLParser, RLReport, ExtCtrls, RLPreviewForm;

type
  TfrmQckRcxRomaneio = class(TfrmPaiQck)
    RLBand1: TRLBand;
    RLDBResult1: TRLDBResult;
    RLDBResult2: TRLDBResult;
    RLDBResult3: TRLDBResult;
    RLDBResult4: TRLDBResult;
    RLDBResult5: TRLDBResult;
    RLLabel10: TRLLabel;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLDBText5: TRLDBText;
    RLDBText7: TRLDBText;
    RLDBText8: TRLDBText;
    RLDBText6: TRLDBText;
    RLDBText9: TRLDBText;
    RLDBText11: TRLDBText;
    RLDBResult6: TRLDBResult;
    rllRomaneio: TRLLabel;
    RLLabel1: TRLLabel;
    RLLabel3: TRLLabel;
    RLLabel5: TRLLabel;
    RLLabel6: TRLLabel;
    RLLabel7: TRLLabel;
    RLLabel8: TRLLabel;
    RLLabel9: TRLLabel;
    RLLabel2: TRLLabel;
    RLLabel4: TRLLabel;
    RLLabel12: TRLLabel;
    RLDBText10: TRLDBText;
    RLLabel11: TRLLabel;
    RLLabel13: TRLLabel;
    RLDBText12: TRLDBText;
    RLDBResult7: TRLDBResult;
    procedure rllOrdemBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    dtaDtaIni: TDateTime;
  end;

var
  frmQckRcxRomaneio: TfrmQckRcxRomaneio;

implementation

{$R *.dfm}

procedure TfrmQckRcxRomaneio.rllOrdemBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text := strOrdem;
end;

end.

