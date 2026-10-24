unit untConsultaNotAgrCadCtaReceber;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untConsultaComp, DB, Uni, ExtCtrls, StdCtrls,
  ComCtrls, Buttons, Grids, DBGridCitel, DBGrids, BitBtnLockedIncrem, MemDS, DBAccess;

type
  TfrmConsultaNotAgrCadCtaReceber = class(TfrmConsultaComp)
    pnlAuxiliar: TPanel;
    btnDuplicatas: TBitBtnLocked;
    procedure btnDuplicatasClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmConsultaNotAgrCadCtaReceber: TfrmConsultaNotAgrCadCtaReceber;

implementation

uses untFuncoesSimples, untCtrMostraDuplicatas;

{$R *.dfm}

procedure TfrmConsultaNotAgrCadCtaReceber.btnDuplicatasClick(
  Sender: TObject);
begin
  inherited;

  Try
    pCriarFormularios(TfrmCtrMostraDuplicatas, frmCtrMostraDuplicatas);
    frmCtrMostraDuplicatas.Caption := frmCtrMostraDuplicatas.Caption + ' - ' +
                                      qryConsulta.FieldByName('Duplicata').AsString + '-AG-' +
                                      qryConsulta.FieldByName('Empresa').AsString;

    If frmCtrMostraDuplicatas.fMostraDuplicatas(qryConsulta.FieldByName('Duplicata').AsString,
                                                qryConsulta.FieldByName('Empresa').AsString) Then
      frmCtrMostraDuplicatas.ShowModal;

  Finally
    pFreeAndNil(frmCtrMostraDuplicatas);
  End;

end;

procedure TfrmConsultaNotAgrCadCtaReceber.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  If (Key = VK_F9) Then
    btnDuplicatas.Click;

end;

end.
