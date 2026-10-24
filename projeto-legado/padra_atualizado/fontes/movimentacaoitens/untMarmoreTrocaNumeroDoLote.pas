unit untMarmoreTrocaNumeroDoLote;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, EditFocus, Data.DB, untZClient;

type
  TfrmMarmoreTrocaNumeroDoLote = class(TfrmPai)
    edtLoteOriginal: TEditFocus;
    Label1: TLabel;
    Label2: TLabel;
    edtLoteNovo: TEditFocus;
    btnTrocar: TSpeedButton;
    DataSource1: TDataSource;
    procedure btnTrocarClick(Sender: TObject);
  private
    { Private declarations }
  protected
    sizeField: integer;
    cdsDados: TZClient;
    cdsChapas: TZClient;
    blnTrocou: Boolean;
    function fValidaTrocaValida : boolean;
    procedure pTrocaValores;

  public
   class function fTroca(AcdsDados: TZClient; AcdsChapas: TZClient; AsizeFieldLote: integer): Boolean;
    { Public declarations }
  end;

var
  frmMarmoreTrocaNumeroDoLote: TfrmMarmoreTrocaNumeroDoLote;

implementation

uses
  untFuncoesSimples;

{$R *.dfm}

{ TfrmMarmoreTrocaNumeroDoLote }

class function TfrmMarmoreTrocaNumeroDoLote.fTroca(AcdsDados: TZClient; AcdsChapas: TZClient; AsizeFieldLote: integer): Boolean;
begin
  pCriarFormularios(TfrmMarmoreTrocaNumeroDoLote, frmMarmoreTrocaNumeroDoLote);
  Try
    frmMarmoreTrocaNumeroDoLote.edtLoteOriginal.Text := AcdsChapas.FieldByName('LOTE_BASE').AsString;
    frmMarmoreTrocaNumeroDoLote.sizeField:= AsizeFieldLote;
    frmMarmoreTrocaNumeroDoLote.cdsDados := AcdsDados;
    frmMarmoreTrocaNumeroDoLote.cdsChapas := AcdsChapas;
    frmMarmoreTrocaNumeroDoLote.blnTrocou := False;
    frmMarmoreTrocaNumeroDoLote.Showmodal;
    result :=  frmMarmoreTrocaNumeroDoLote.blnTrocou;
  finally
    FreeAndNil(frmMarmoreTrocaNumeroDoLote);
  End;

end;

function TfrmMarmoreTrocaNumeroDoLote.fValidaTrocaValida: boolean;
var strLotesInvalidos: String;
    strLoteFinal: string;
begin
  strLotesInvalidos := '';
  cdsChapas.First;
  While not cdsChapas.Eof Do
  Begin
    strLoteFinal := StringReplace(cdsDados.FieldByName('LOT_NUMLOT').AsString, edtLoteOriginal.Text, edtLoteNovo.Text, []);

    If Length(strLoteFinal) > sizeField Then
      strLotesInvalidos := strLotesInvalidos +  #$A#$D + strLoteFinal;
    cdsChapas.Next;
  End;

  strLotesInvalidos :=  Copy(strLotesInvalidos, 1, Length(strLotesInvalidos) -1);
  strLotesInvalidos := StringReplace(strLotesInvalidos, ',', #$A#$D, []);


  Result := strLotesInvalidos = '';
  If Not Result Then
  begin
    pMensagemOk('Os lotes a seguir [' + strLotesInvalidos + ']' + #$A#$D + ' tem mais que '+IntToStr(sizeField)+' caracteres , por favor informar outro Número de Lote!');
    edtLoteNovo.Clear;
    pSetFocus(edtLoteNovo);

  End;
end;

procedure TfrmMarmoreTrocaNumeroDoLote.pTrocaValores;
begin
  cdsDados.Edit;
  cdsDados.FieldByName('LOT_NUMLOT').AsString := edtLoteNovo.Text;
  cdsDados.Post;

  cdsChapas.First;
  while not cdsChapas.Eof Do
  Begin
    cdsChapas.Edit;
    cdsChapas.FieldByName('LOTE').AsString :=  StringReplace(cdsChapas.FieldByName('LOTE').AsString, edtLoteOriginal.Text, edtLoteNovo.Text, []);
    cdsChapas.FieldByName('LOTE_BASE').AsString :=  StringReplace(cdsChapas.FieldByName('LOTE_BASE').AsString, edtLoteOriginal.Text, edtLoteNovo.Text, []);
    cdsChapas.Post;
    cdsChapas.Next;
  End;

  blnTrocou := True;
end;

procedure TfrmMarmoreTrocaNumeroDoLote.btnTrocarClick(Sender: TObject);
begin
  inherited;
  If fValidaTrocaValida Then
  begin
    pTrocaValores;
    Close;
  End;
end;

end.
