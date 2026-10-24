unit untHerancaCombo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, EditFocus, Mask,
  MaskEditFocus, StrUtils, Uni, AppEvnts, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmHerancaCombo = class(TfrmPai)
    Panel1: TPanel;
    Label9: TLabel;
    edtDesCom: TEditFocus;
    edtCodCom: TEditFocus;
    btnConfirma: TBitBtnLocked;
    procedure edtCodComKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
  private
    { Private declarations }
    strCodIte: String;
  public
    { Public declarations }
    blnConfirma: Boolean;

    qryGenCom :TUniQuery;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;

  end;

var
  frmHerancaCombo: TfrmHerancaCombo;

implementation

uses  untfuncoesSimples, DB, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmHerancaCombo.edtCodComKeyPress(Sender: TObject;
  var Key: Char);
  Var
    qryConGen: TUniQuery;
    arrSel   : TConsultasArray;
begin
  inherited;

  If fEntraCons(Key) Then
  Begin

    Try
      qryConGen := fCriaQuery;

      Try
        If (fPesqComboVenda(Self, edtCodCom, Nil, qryConGen, Key, arrSel)) Then
          fValidaCampos(edtCodCom, True);
      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '[TfrmHerancaCombo.edtCodComKeyPress]');
        End;
      End;
    Finally
      FreeAndNil(qryConGen);
    End;
  End;
end;

procedure TfrmHerancaCombo.FormShow(Sender: TObject);
begin
  inherited;
  edtCodCom.Clear;
  edtDesCom.Clear;
  pSetFocus(edtCodCom);

end;

function TfrmHerancaCombo.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    if Sender = edtCodCom then
    begin
      If fEmptyStr(edtCodCom.Text) Then
      Begin
        fMensagem('ATENÇÃO','O Campo Código do Combo deve ser preenchido!',['&O K']);
        Result := False;
      End
      Else
      Begin
        edtDesCom.Text := fRetDesComboVenda(edtCodCom.Text);
        If fEmptyStr(edtDesCom.Text) Then
        Begin
          fMensagem('ATENÇÃO','Código do Combo não encontrado!',['&O K']);
          edtCodCom.Clear;
          Result := False;
        end;
      End;
    end;

    if not Result then
      pSetFocus(Sender);
  End;
end;

procedure TfrmHerancaCombo.btnConfirmaClick(Sender: TObject);
  Var
    strSQL: String;
begin
  inherited;

  if not fVerificaCampos then
    Exit;

  strCodIte := edtCodCom.Text;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  *    ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  COMVEN  ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  COM_CODCOM = :CODCOM ';

  With qryGenCom Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODCOM').AsString := edtCodCom.Text;
    Open;
  End;
  
  blnConfirma := True;
  Close;

end;

end.


