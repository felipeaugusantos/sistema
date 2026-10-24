unit untImpBoletosCTe;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, EditFocus, untFuncoesSimples, untTypesSistema;

type
  TfrmImpBoletosCTe = class(TfrmPaiConfirma)
    Label1: TLabel;
    Label2: TLabel;
    edtNumCte: TEditFocus;
    Label4: TLabel;
    edtCodEmp: TEditFocus;
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
  private
    { Private declarations }
    function fExisteCadRec(var objArrDupCtr: TArrDupCtr): Boolean;
  public
    { Public declarations }
    strNumCte: String;
    strCodEmp: String;
    strCodCli: String;
  end;

implementation

{$R *.dfm}

uses
  Uni, untBoleto;

procedure TfrmImpBoletosCTe.btnConfirmaClick(Sender: TObject);
var
  objArrDupCtr: TArrDupCtr;
begin
//  inherited;
  if fExisteCadRec(objArrDupCtr) then
  begin
    TBoleto.fImprimirBoletos(objArrDupCtr);
    ModalResult := MrOk;
  end
  else
    pMensagemOk('Aguarde a geração do Contas a Receber pela empresa emitente da CT-e!');
end;

function TfrmImpBoletosCTe.fExisteCadRec(var objArrDupCtr: TArrDupCtr): Boolean;
var
  qryCadRec: TUniQuery;
  intCnt: Integer;
begin
  SetLength(objArrDupCtr, 0);

  qryCadRec := fCriaQuery;
  try
    qryCadRec.SQL.Add('SELECT AUTOINCREM');
    qryCadRec.SQL.Add('  FROM CADREC');
    qryCadRec.SQL.Add(' WHERE CTR_NUMDUP = :NUMDUP');
    qryCadRec.SQL.Add('   AND CTR_ESPDOC = :ESPDOC');
    qryCadRec.SQL.Add('   AND CTR_CODCLI = :CODCLI');
    qryCadRec.SQL.Add('   AND CTR_CODEMP = :CODEMP');

    qryCadRec.ParamByName('NUMDUP').AsString := fStrZero(strNumCte, 12);
    qryCadRec.ParamByName('ESPDOC').AsString := 'CT';
    qryCadRec.ParamByName('CODCLI').AsString := strCodCli;
    qryCadRec.ParamByName('CODEMP').AsString := strCodEmp;
    qryCadRec.Open;

    Result := not qryCadRec.IsEmpty;

    if Result then
    begin
      SetLength(objArrDupCtr, qryCadRec.RecordCount);
      intCnt := 0;
      while not qryCadRec.Eof do
      begin
        objArrDupCtr[intCnt].strAutoIn := qryCadRec.FieldByName('AUTOINCREM').AsString;

        Inc(intCnt);
        qryCadRec.Next;
      end;
    end;
  finally
    FreeAndNil(qryCadRec);
  end;
end;

procedure TfrmImpBoletosCTe.FormShow(Sender: TObject);
begin
  inherited;
  edtNumCte.Text := strNumCte;
  edtCodEmp.Text := strCodEmp;
end;

end.
