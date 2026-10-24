unit untFatAlteraLocFisEntFut;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, EditFocus;

type
  TfrmAlteraLocFisEntFut = class(TfrmPaiConfirma)
    lbl1: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    bvl1: TBevel;
    edtProduto: TEditFocus;
    edtRefere: TEditFocus;
    edtUnidad: TEditFocus;
    edtLocFis: TEditFocus;
    Label152: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure edtLocFisKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    blnCadLoc: Boolean;
  public
    { Public declarations }
    FstrAutInc: String;

    function fAtualiza: Boolean;
    procedure pSetAutInc(const strAutInc: String);

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

{$R *.dfm}

uses
  Uni, untTypesSistema, untConsultas, untFuncoesSimples;

procedure TfrmAlteraLocFisEntFut.edtLocFisKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;

  If blnCadLoc And fPesqLocFisica(Self, edtLocFis, Nil, Nil, Key, arrSel) And
     fValidaCampos(edtLocFis, True) Then
    SelectNext(ActiveControl, True, True);

end;

procedure TfrmAlteraLocFisEntFut.FormCreate(Sender: TObject);
begin
  inherited;

  FstrAutInc := '';
  blnCadLoc := fCfgSis('CADLOC', varBoolean);

end;

procedure TfrmAlteraLocFisEntFut.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(edtLocFis);
end;

function TfrmAlteraLocFisEntFut.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtLocFis) Then
    Begin
      If (fEmptyStr(edtLocFis.Text)) Then
      Begin
        pMensagemOk('Obrigatório informar a Localização Física!');
        Result := False;
      End
      Else
      If blnCadLoc Then
      Begin
        If fEmptyStr(fRetNomLocFisica(edtLocFis.Text)) Then
        Begin
          pMensagemOk('Localização Física não encontrada!');
          Result := False;
        End;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);

end;

function TfrmAlteraLocFisEntFut.fAtualiza: Boolean;
var
  qryUpdate: TUniQuery;
begin
  qryUpdate := fCriaQuery;
  try
    qryUpdate.SQL.Add('UPDATE MOVTRI SET ');
    qryUpdate.SQL.Add('  DET_LOCFIS = :LOCFIS');
    qryUpdate.SQL.Add('WHERE DET_SEQGER = :AUTINC');

    qryUpdate.ParamByName('LOCFIS').AsString := edtLocFis.Text;
    qryUpdate.ParamByName('AUTINC').AsString := FstrAutInc;
    qryUpdate.ExecSql;
    Result := True;
  finally
    FreeAndNil(qryUpdate);
  end;
end;

procedure TfrmAlteraLocFisEntFut.pSetAutInc(const strAutInc: String);
begin
  FstrAutInc := strAutInc;
end;

end.
