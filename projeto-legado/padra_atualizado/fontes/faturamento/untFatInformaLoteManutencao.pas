unit untFatInformaLoteManutencao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, EditFocus, Data.DB, MemDS,
  DBAccess, Uni, Datasnap.DBClient, UniClientDataSet, untTypesSistema;

type
  TfrmFatInformaLoteManutencao = class(TfrmPaiSimples)
    Panel1: TPanel;
    edtNumLot: TEditFocus;
    lblNumLot: TLabel;
    btnConfirmar: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    procedure edtNumLotKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmarClick(Sender: TObject);
  private
    { Private declarations }
    function fLoteSeparacaoRomaneioExiste(const ANumLot : String):Boolean;
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean; override;
  end;


implementation

uses
  untFuncoesSimples, untConsultas;

{$R *.dfm}

procedure TfrmFatInformaLoteManutencao.btnConfirmarClick(Sender: TObject);
begin
  inherited;
  if (fValidaCampos(edtNumLot, True)) then
  begin
    ModalResult := mrOk;
  end;
end;

procedure TfrmFatInformaLoteManutencao.edtNumLotKeyPress(Sender: TObject;
  var Key: Char);
var
  LqryConsulta: TUniQuery;
  LarrSel   : TConsultasArray;
begin
  inherited;
  If Key = #13 Then
  Begin
    edtNumLot.Text := fStrZero(edtNumLot.Text, 8);
    If (fValidaCampos(btnConfirmar, True)) Then
      pSetFocus(btnConfirmar);
  End
  Else
  Begin
    LqryConsulta := fCriaQuery(Self);

    try
      If fPesqRomaneioLoteSeparacao(Self, edtNumLot, LqryConsulta, Key, LarrSel, True) Then
        If (fValidaCampos(btnConfirmar, True)) Then
          pSetFocus(btnConfirmar);
    finally
      FreeAndNil(LqryConsulta);
    end;
  End;
end;

function TfrmFatInformaLoteManutencao.fLoteSeparacaoRomaneioExiste(
  const ANumLot: String): Boolean;
var
  LqryLote: TUniQuery;
begin
  LqryLote := fCriaQuery;

  try
    try
      LqryLote.Close;
      LqryLote.SQL.Clear;
      LqryLote.SQL.Add('SELECT *');
      LqryLote.SQL.Add('FROM ROMLGE');
      LqryLote.SQL.Add('WHERE RLG_NUMLOT = :NUMLOT');
      LqryLote.SQL.Add('AND RLG_CODEMP = :CODEMP');

      LqryLote.ParamByName('NUMLOT').AsString := ANumLot;
      LqryLote.ParamByName('CODEMP').AsString := VS_strCodEmp;

      LqryLote.Open;

      Result := not LqryLote.IsEmpty;
    except
      Result := False;
    end;
  finally
    FreeAndNil(LqryLote);
  end;
end;

procedure TfrmFatInformaLoteManutencao.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(edtNumLot);
end;

function TfrmFatInformaLoteManutencao.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (Sender = edtNumLot) Then
  Begin
    If (Not fEmptyStr(edtNumLot.Text)) Then
    Begin
      If (Not fLoteSeparacaoRomaneioExiste(edtNumLot.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse lote de separação para romaneio não está cadastrado!', ['&Ok']);
        Result := False;
        edtNumLot.Clear;
      End;
    End
    Else
    Begin
      fMensagem('ATENÇÃO!', 'Informe o número do lote!', ['&Ok']);
      Result := False;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

end.
