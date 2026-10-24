unit untPnlDadosPreNota;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, untClassPanelCx, Data.DB, Datasnap.DBClient, UniClientDataSet, MemDS,
  DBAccess, Uni;

type
  TfrmPnlDadosPreNota = class(TForm)
    BitBtnLocked1: TBitBtnLocked;
    procedure BitBtnLocked1Click(Sender: TObject);
  private
    { Private declarations }
  public
    cdsConsulta     : TUniClientDataSet;
    { Public declarations }

  end;

  TfrmPnlDadosPreNotaClass = Class Of TfrmPnlDadosPreNota;
var
  frmPnlDadosPreNota: TfrmPnlDadosPreNota;

implementation

uses
  untFuncoesSimples;

{$R *.dfm}

procedure TfrmPnlDadosPreNota.BitBtnLocked1Click(Sender: TObject);
var
  qryConsulta: TUniQuery;
begin
  If Not Assigned(cdsConsulta) Then
    Exit;

  If cdsConsulta.IsEmpty Then
    Exit;

  qryConsulta := fCriaQuery;
  Try
    qryConsulta.SQL.Add('UPDATE DETELE');
    qryConsulta.SQL.Add('INNER JOIN GERELE ON GERELE.AUTOINCREM = DETELE.DET_SEQGER');
    qryConsulta.SQL.Add(' SET XPED = NULL');
    qryConsulta.SQL.Add('WHERE GERELE.AUTOINCREM = "' + cdsConsulta.FieldByName('AUTOINCREM').AsString + '"');
    qryConsulta.ExecSQL;

    pMensagemOk('Vínculo removido');
  Finally
    FreeAndNil(qryConsulta);
  End;
end;

end.
