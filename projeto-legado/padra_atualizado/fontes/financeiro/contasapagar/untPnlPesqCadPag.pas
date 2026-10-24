unit untPnlPesqCadPag;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, UniClientDataSet, ExtCtrls, Uni,
  DB, BitBtnLockedIncrem;

type
  TfrmPnlPesqCadPag = class(TForm)
    btnDupAgrup: TBitBtnLocked;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure btnDupAgrupClick(Sender: TObject);
  private
    { Private declarations }
    procedure pAfterScroll(DataSet: TDataSet);

  public
    { Public declarations }
    cdsConsulta: TUniClientDataSet;
  end;

TfrmPnlPesqCadPagClass = Class Of TfrmPnlPesqCadPag;


implementation

uses untFuncoesSimples, untFuncoesAuxiliares, untFuncoesRel, untFuncoesRel2;

{$R *.dfm}

procedure TfrmPnlPesqCadPag.btnDupAgrupClick(Sender: TObject);
begin

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(87, 5390, [],
                        ['NUMAGR','CODFOR','CODEMP'],
                        [cdsConsulta.FieldByName('CTP_NUMDUP').AsString,
                        cdsConsulta.FieldByName('CTP_CODFOR').AsString,
                        cdsConsulta.FieldByName('CTP_CODEMP').AsString],
                        Sender,
                        nil,
                        True);
  End;

end;

procedure TfrmPnlPesqCadPag.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_F9 : Begin
              btnDupAgrup.Click;
              Key := 0;
            End;
  end;
end;

procedure TfrmPnlPesqCadPag.FormShow(Sender: TObject);
begin
  cdsConsulta.AfterScroll := pAfterScroll;
end;

procedure TfrmPnlPesqCadPag.pAfterScroll;
begin
  If (cdsConsulta.FieldByName('CTP_SERIE_').AsString = 'AG') Then
    btnDupAgrup.Visible := True
  Else
    btnDupAgrup.Visible := False;
end;

end.
