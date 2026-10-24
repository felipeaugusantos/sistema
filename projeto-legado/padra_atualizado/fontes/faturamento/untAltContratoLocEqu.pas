unit untAltContratoLocEqu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.StdCtrls, Vcl.Mask,
  Vcl.DBCtrls, DBEditFocus, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts,
  Vcl.Menus, Vcl.Buttons, BitBtnLockedIncrem, Vcl.ExtCtrls, cadastro.Model.ContratoLocacaoEquipamentos,
  MaskEditFocus;

type
  TfrmAltContratoLocEqu = class(TfrmPaiConfirma)
    grbDuracao: TGroupBox;
    lblInicio: TLabel;
    lblTermino: TLabel;
    edtDtaIni: TDBEditFocus;
    edtHorIni: TDBEditFocus;
    edtHorFin: TMaskEditFocus;
    edtDtaFin: TMaskEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtHorFinKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    procedure pCarregarDadosContrato;
    function fValidaDataHora(const strDta, strHra: String): Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    objContrato: TContratoLocacaoEquipamentos;
  end;

implementation

uses
  untFuncoesSimples;

{$R *.dfm}

{ TfrmAltContratoLocEqu }

procedure TfrmAltContratoLocEqu.edtHorFinKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If Key = VK_RETURN Then
  Begin
    If fValidaCampos(edtHorFin, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAltContratoLocEqu.FormCreate(Sender: TObject);
begin
  inherited;

  edtDtaFin.Enabled := False;
  edtHorFin.Enabled := False;
end;

procedure TfrmAltContratoLocEqu.FormShow(Sender: TObject);
begin
  inherited;

  pCarregarDadosContrato;
  pSetFocus(edtDtaFin);
end;

function TfrmAltContratoLocEqu.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := Inherited fValidaCampos(Sender, blnBuscaPorChave);

  If Result Then
  Begin
    If (Sender = edtDtaFin) Then
    Begin
      If Not fValidaDataHora(edtDtaFin.Text, edtHorFin.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Data Inválida!', ['&O k']);
        Result := False;
      End;
    End
    Else
    If (Sender = edtHorFin) Then
    Begin
      If Not fValidaDataHora(edtDtaFin.Text, edtHorFin.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Hora Inválida!', ['&O k']);
        Result := False;
      End;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

function TfrmAltContratoLocEqu.fValidaDataHora(const strDta, strHra: String): Boolean;
var
  dtaHraTmp: TDateTime;
begin

  If fEmptyStr(fTiraCaracEspeciais(strDta)) Or
     fEmptyStr(fTiraCaracEspeciais(strHra)) Then
    Exit(True);

  If fEmptyStr(fTiraCaracEspeciais(strDta, True, True, False, True)) Or
     fEmptyStr(fTiraCaracEspeciais(strHra, True, True, False, True)) Then
    Exit(True);

  Try
    dtaHraTmp := StrToDateTime(strDta + ' ' + strHra);
    Result := dtaHraTmp > 0;
  Except
    Result := False;
  End;
end;

procedure TfrmAltContratoLocEqu.pCarregarDadosContrato;
begin
  If Not Assigned(objContrato) Then
    Exit;

  edtDtaFin.Enabled := True;
  edtHorFin.Enabled := True;
  edtDtaFin.Clear;
  edtHorFin.Clear;
  edtDtaIni.Clear;
  edtHorIni.Clear;

  edtDtaIni.Text := DateTimeToStr(objContrato.DataInicial);
  edtHorIni.Text := TimeToStr(objContrato.HoraInicial);
end;

end.
